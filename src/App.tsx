import { useState, useEffect } from 'react';
import { ChevronLeft, Check } from 'lucide-react';
import { motion } from 'motion/react';

type Screen = 'splash' | 'signin' | 'signup' | 'forgot_password' | 'otp' | 'new_password' | 'success';

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('splash');
  const [resetEmail, setResetEmail] = useState('');
  const [rememberMe, setRememberMe] = useState(false);

  useEffect(() => {
    if (currentScreen === 'splash') {
      const timer = setTimeout(() => {
        setCurrentScreen('signin');
      }, 3500);
      return () => clearTimeout(timer);
    }
  }, [currentScreen]);

  const renderScreen = () => {
    switch (currentScreen) {
      case 'splash':
        return (
          <div className="flex flex-col h-full font-serif items-center justify-center">
            <div className="relative w-48 h-48 flex items-center justify-center">
              {/* Base Drop Outline */}
              <svg viewBox="0 0 24 24" className="absolute inset-0 w-full h-full text-[#1CA3C6]" fill="none" stroke="currentColor" strokeWidth="0.5">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
              
              {/* Base Text (Light Blue) */}
              <div className="absolute inset-0 flex items-center justify-center pt-12 z-0">
                 <span className="text-[#1CA3C6] font-bold text-2xl leading-tight text-center">Pure<br/>Drop</span>
              </div>

              {/* Filled Drop (clipped by height) */}
              <motion.div 
                className="absolute bottom-0 left-0 w-full overflow-hidden z-10"
                initial={{ height: "0%" }}
                animate={{ height: "100%" }}
                transition={{ duration: 3, ease: "easeInOut" }}
              >
                <div className="absolute bottom-0 left-0 w-48 h-48">
                  <svg viewBox="0 0 24 24" className="absolute bottom-0 w-full h-full text-[#1CA3C6]" fill="currentColor">
                    <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                  </svg>
                  {/* Filled Text (White) */}
                  <div className="absolute inset-0 flex items-center justify-center pt-12">
                     <span className="text-white font-bold text-2xl leading-tight text-center">Pure<br/>Drop</span>
                  </div>
                </div>
              </motion.div>
            </div>
          </div>
        );

      case 'signin':
      case 'signup':
        const isSignIn = currentScreen === 'signin';
        return (
          <div className="flex flex-col h-full font-serif">
            {/* Header */}
            <div className="flex justify-between items-start mb-4">
              <h1 className="text-[40px] font-bold text-[#0A5C71] mt-4">
                {isSignIn ? 'Sign In' : 'Sign Up'}
              </h1>
              
              {/* Logo */}
              <div className="relative w-24 h-32 flex items-center justify-center">
                <svg viewBox="0 0 24 24" className="w-32 h-32 text-[#1CA3C6] drop-shadow-md" fill="currentColor">
                  <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                </svg>
                <div className="absolute top-[60px] text-white text-center font-bold text-sm leading-tight">
                  Pure<br/>Drop
                </div>
              </div>
            </div>

            {/* Sign Up Welcome Text */}
            {!isSignIn && (
              <div className="text-center mb-6">
                <h2 className="text-3xl italic text-[#0A5C71]">Welcome</h2>
              </div>
            )}

            {/* Form Fields */}
            <div className="space-y-5">
              {!isSignIn && (
                <div className="space-y-2">
                  <label className="text-xl italic text-[#0A5C71]">Full Name :</label>
                  <input type="text" className="w-full h-12 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2" />
                </div>
              )}

              <div className="space-y-2">
                <label className="text-xl italic text-[#0A5C71]">
                  {isSignIn ? 'Name / Email :' : 'Email :'}
                </label>
                <input type="text" className="w-full h-12 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2" />
              </div>

              <div className="space-y-2">
                <label className="text-xl italic text-[#0A5C71]">Password :</label>
                <input type="password" placeholder={isSignIn ? "..." : ""} className="w-full h-12 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2 placeholder:text-[#0A5C71] placeholder:tracking-widest" />
              </div>

              {!isSignIn && (
                <div className="space-y-2">
                  <label className="text-xl italic text-[#0A5C71]">Confirm Password :</label>
                  <input type="password" className="w-full h-12 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2" />
                </div>
              )}

              {isSignIn && (
                <>
                  <div className="pt-2">
                    <button onClick={() => setCurrentScreen('forgot_password')} className="text-xl italic text-[#0A5C71] underline decoration-1 underline-offset-4">
                      Forgot Password ?
                    </button>
                  </div>
                  <div 
                    className="flex items-center gap-3 pt-4 cursor-pointer"
                    onClick={() => setRememberMe(!rememberMe)}
                  >
                    <div className={`w-6 h-6 border-[1.5px] border-[#0A5C71] rounded-sm flex items-center justify-center transition-colors ${rememberMe ? 'bg-[#0A5C71]' : 'bg-transparent'}`}>
                      {rememberMe && <Check size={16} className="text-white" strokeWidth={4} />}
                    </div>
                    <span className="text-xl italic text-[#0A5C71] select-none">Remember Me</span>
                  </div>
                </>
              )}
            </div>

            {/* Action Button */}
            <div className="mt-12">
              <button className="w-full h-14 bg-[#0A5C71] text-white text-2xl italic rounded-xl hover:bg-[#084a5a] transition-colors">
                {isSignIn ? 'Sign In' : 'Sign Up'}
              </button>
            </div>

            {/* Footer Link */}
            <div className="mt-6 text-center pb-8">
              <p className="text-[#0A5C71] italic text-sm">
                {isSignIn ? 'Not a member ? ' : 'Already have an account ? '}
                <button 
                  onClick={() => setCurrentScreen(isSignIn ? 'signup' : 'signin')}
                  className="font-bold underline decoration-2 underline-offset-2 hover:text-[#084a5a]"
                >
                  {isSignIn ? 'Sign Up' : 'Sign In'}
                </button>
              </p>
            </div>
          </div>
        );

      case 'forgot_password':
        return (
          <div className="flex flex-col h-full font-sans">
            <div className="flex justify-between items-center mb-8">
              <button onClick={() => setCurrentScreen('signin')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <span className="text-sm text-[#0A5C71] underline cursor-pointer">Need help ?</span>
            </div>
            <h2 className="text-3xl font-bold text-[#0A5C71] mb-3">Reset Your Password</h2>
            <p className="text-sm text-[#0A5C71] mb-10 leading-relaxed">
              Please enter your email and we will send an OTP code in the next step to reset your password
            </p>
            
            <div className="space-y-2">
              <label className="text-base text-[#0A5C71]">Email</label>
              <input 
                type="email" 
                value={resetEmail}
                onChange={(e) => setResetEmail(e.target.value)}
                placeholder="Enter your Email" 
                className="w-full h-14 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2 placeholder:text-[#0A5C71]/50" 
              />
            </div>

            <div className="mt-auto pb-8">
              <button onClick={() => setCurrentScreen('otp')} className="w-full h-14 bg-[#0A5C71] text-white text-lg font-bold rounded-xl hover:bg-[#084a5a] transition-colors">
                Continue
              </button>
            </div>
          </div>
        );

      case 'otp':
        return (
          <div className="flex flex-col h-full font-sans">
            <div className="mb-8">
              <button onClick={() => setCurrentScreen('forgot_password')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
            </div>
            <h2 className="text-3xl font-bold text-[#0A5C71] mb-3">OTP Code Verification</h2>
            <p className="text-sm text-[#0A5C71] mb-10 leading-relaxed">
              we have sent an OTP code to your email <span className="underline">{resetEmail || 'your email'}</span> Enter the OTP code below to verify
            </p>
            
            <div className="flex justify-between gap-2 mb-10">
              {[1, 2, 3, 4, 5].map((i) => (
                <div key={i} className="w-14 h-14 bg-[#0A5C71] rounded-xl shadow-inner"></div>
              ))}
            </div>

            <div className="text-center space-y-2">
              <p className="text-sm text-[#0A5C71]">Didn't receive the code?</p>
              <button className="text-sm text-[#0A5C71] underline font-bold">Resend Code</button>
            </div>

            <div className="mt-auto pb-8">
              <button onClick={() => setCurrentScreen('new_password')} className="w-full h-14 bg-[#0A5C71] text-white text-lg font-bold rounded-xl hover:bg-[#084a5a] transition-colors">
                Submit
              </button>
            </div>
          </div>
        );

      case 'new_password':
        return (
          <div className="flex flex-col h-full font-sans">
            <div className="mb-8">
              <button onClick={() => setCurrentScreen('otp')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
            </div>
            <h2 className="text-3xl font-bold text-[#0A5C71] mb-3">Create a new Password</h2>
            <p className="text-sm text-[#0A5C71] mb-10 leading-relaxed">
              Create your new password. If you forget it, then you have to do forgot password again
            </p>
            
            <div className="space-y-6">
              <div className="space-y-2">
                <label className="text-base text-[#0A5C71]">New Password</label>
                <input 
                  type="password" 
                  placeholder="Enter your New Password" 
                  className="w-full h-14 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2 placeholder:text-[#0A5C71]/50" 
                />
              </div>
              <div className="space-y-2">
                <label className="text-base text-[#0A5C71]">Confirm Password</label>
                <input 
                  type="password" 
                  placeholder="Enter your New Password Again" 
                  className="w-full h-14 bg-transparent border border-[#0A5C71] rounded-lg px-4 text-[#0A5C71] focus:outline-none focus:border-2 placeholder:text-[#0A5C71]/50" 
                />
              </div>
            </div>

            <div className="mt-auto pb-8">
              <button onClick={() => setCurrentScreen('success')} className="w-full h-14 bg-[#0A5C71] text-white text-lg font-bold rounded-xl hover:bg-[#084a5a] transition-colors">
                Submit
              </button>
            </div>
          </div>
        );

      case 'success':
        return (
          <div className="flex flex-col h-full font-sans items-center pt-32">
            <div className="w-36 h-36 bg-[#0A5C71] rounded-full flex items-center justify-center mb-10 shadow-lg">
              <Check size={80} className="text-white" strokeWidth={3} />
            </div>
            <h2 className="text-2xl font-bold text-[#0A5C71]">Password Updated!</h2>
            
            <div className="mt-auto w-full pb-8">
              <button onClick={() => setCurrentScreen('signin')} className="w-full h-14 bg-[#0A5C71] text-white text-lg font-bold rounded-xl hover:bg-[#084a5a] transition-colors">
                Back To Sign In
              </button>
            </div>
          </div>
        );
    }
  };

  return (
    <div className="min-h-screen bg-gray-900 flex items-center justify-center p-4">
      {/* Mobile Device Mockup Container */}
      <div className="relative w-full max-w-[400px] h-[850px] bg-gradient-to-b from-[#e6f7fc] to-[#9ce3f5] rounded-[40px] shadow-2xl overflow-hidden border-[8px] border-gray-800">
        
        {/* Status Bar Mock */}
        <div className="absolute top-0 w-full h-12 flex justify-between items-center px-6 text-[#0A5C71] text-sm font-sans font-medium z-10">
          <span>9:41</span>
          <div className="flex gap-2 items-center">
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/></svg>
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4C7.31 4 3.07 5.9 0 8.98L12 21 24 8.98C20.93 5.9 16.69 4 12 4z"/></svg>
            <div className="w-6 h-3 border border-current rounded-sm p-[1px]"><div className="w-full h-full bg-current rounded-sm"></div></div>
          </div>
        </div>

        {/* Scrollable Content */}
        <div className="w-full h-full overflow-y-auto pt-16 px-6 no-scrollbar">
          {renderScreen()}
        </div>

        {/* Home Indicator Mock */}
        <div className="absolute bottom-2 left-1/2 -translate-x-1/2 w-32 h-1.5 bg-gray-800 rounded-full z-10"></div>
      </div>

      {/* Info Panel */}
      <div className="absolute top-4 right-4 max-w-sm bg-gray-800 text-white p-6 rounded-xl shadow-xl border border-gray-700 font-sans">
        <h3 className="text-lg font-bold mb-2 text-[#9ce3f5]">Splash Screen Added!</h3>
        <p className="text-sm text-gray-300 mb-4">
          I have created the animated splash screen in Flutter and React. It fills up over 3 seconds and automatically navigates to the Sign In screen.
        </p>
        <ul className="text-sm text-gray-400 list-disc pl-4 space-y-1">
          <li>lib/splash_screen.dart</li>
          <li>lib/main.dart (updated initial route)</li>
        </ul>
        <button 
          onClick={() => setCurrentScreen('splash')}
          className="mt-4 w-full py-2 bg-[#0A5C71] text-white rounded-lg hover:bg-[#084a5a] transition-colors text-sm font-bold"
        >
          Replay Splash Animation
        </button>
      </div>
    </div>
  );
}
