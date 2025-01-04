import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as nodemailer from 'nodemailer';

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'your-email@gmail.com',
    pass: 'your-app-password'
  }
});

// Lưu OTP trong Firestore
async function saveOtp(email: string, otp: string) {
  const otpDoc = {
    email,
    otp,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    isUsed: false
  };
  
  await admin.firestore().collection('otps').add(otpDoc);
}

// Tạo OTP ngẫu nhiên
function generateOtp(): string {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

export const sendOtpEmail = functions.https.onCall(async (data, context) => {
  try {
    const { email } = data;
    const otp = generateOtp();
    
    // Lưu OTP
    await saveOtp(email, otp);
    
    // Gửi email
    await transporter.sendMail({
      from: 'your-email@gmail.com',
      to: email,
      subject: 'Your verification code',
      html: `Your verification code is: <b>${otp}</b>`
    });
    
    return { success: true };
  } catch (error) {
    return { error: error.message };
  }
});

export const verifyOtp = functions.https.onCall(async (data, context) => {
  try {
    const { email, otp } = data;
    
    // Kiểm tra OTP trong Firestore
    const otpSnapshot = await admin.firestore()
      .collection('otps')
      .where('email', '==', email)
      .where('otp', '==', otp)
      .where('isUsed', '==', false)
      .orderBy('createdAt', 'desc')
      .limit(1)
      .get();
    
    if (otpSnapshot.empty) {
      return { isValid: false, error: 'Invalid OTP' };
    }
    
    // Đánh dấu OTP đã sử dụng
    await otpSnapshot.docs[0].ref.update({ isUsed: true });
    
    return { isValid: true };
  } catch (error) {
    return { error: error.message };
  }
}); 