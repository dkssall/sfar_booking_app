import { initializeApp } from "https://www.gstatic.com/firebasejs/12.1.7/firebase-app.js";

import {
  getAuth,
  signInWithEmailAndPassword
} from "https://www.gstatic.com/firebasejs/12.1.7/firebase-auth.js";

// ==============================
// إعداد Firebase
// ==============================

const firebaseConfig = {
  apiKey: "AIzaSyD4Zn7o0BBEAc4K7E6aW3YLh9hXFDzglVA",
  authDomain: "ajel-booking.firebaseapp.com",
  projectId: "ajel-booking",
  storageBucket: "ajel-booking.firebasestorage.app",
  messagingSenderId: "385816942991",
  appId: "1:385816942991:web:cc9ea0bff26643547613fa",
  measurementId: "G-0PDL44N8TG"
};

// ==============================
// تشغيل Firebase
// ==============================

const app = initializeApp(firebaseConfig);
alert("app.js يعمل");

const auth = getAuth(app);

// ==============================
// عناصر صفحة تسجيل الدخول
// ==============================

const emailInput = document.getElementById("email");
const passwordInput = document.getElementById("password");
const loginBtn = document.getElementById("loginBtn");
const loginMessage = document.getElementById("loginMessage");

// ==============================
// تسجيل دخول المدير
// ==============================

loginBtn.addEventListener("click", async () => {

  const email = emailInput.value.trim();
  const password = passwordInput.value;

  // التحقق من البيانات
  if (!email || !password) {
    loginMessage.textContent =
      "يرجى إدخال البريد الإلكتروني وكلمة المرور";
    return;
  }

  loginMessage.textContent = "جاري تسجيل الدخول...";
  loginBtn.disabled = true;

  try {

    await signInWithEmailAndPassword(
      auth,
      email,
      password
    );

    loginMessage.textContent = "تم تسجيل الدخول بنجاح";

    // الانتقال إلى لوحة التحكم
    setTimeout(() => {
      window.location.href = "dashboard.html";
    }, 800);

  } catch (error) {

    console.error(error);

    let message = "حدث خطأ أثناء تسجيل الدخول";

    if (error.code === "auth/invalid-credential") {
      message = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
    }

    if (error.code === "auth/user-not-found") {
      message = "لا يوجد حساب بهذا البريد الإلكتروني";
    }

    if (error.code === "auth/wrong-password") {
      message = "كلمة المرور غير صحيحة";
    }

    if (error.code === "auth/invalid-email") {
      message = "البريد الإلكتروني غير صحيح";
    }

    loginMessage.textContent = message;

  } finally {

    loginBtn.disabled = false;

  }

});
