import { useState, useEffect } from 'react';
import { 
  ChevronLeft, 
  ChevronRight, 
  Check, 
  Droplets, 
  Activity, 
  History as HistoryIcon, 
  Settings, 
  Globe, 
  Star, 
  Mail,
  Info, 
  User, 
  LogOut, 
  Bell, 
  RefreshCw, 
  AlertCircle,
  Thermometer,
  Waves,
  Zap,
  Upload,
  Home,
  BarChart2
} from 'lucide-react';
import { motion } from 'motion/react';

type Screen = 'splash' | 'signin' | 'signup' | 'forgot_password' | 'otp' | 'new_password' | 'success' | 'preparing' | 'connect' | 'scan' | 'analyzing' | 'home' | 'history' | 'sensors' | 'settings' | 'refreshing' | 'sensor_detail' | 'personal_info' | 'reset_account' | 'region_language';

const BottomNav = ({ current, onNavigate }: { current: string, onNavigate: (s: Screen) => void }) => (
  <div className="absolute bottom-0 left-0 w-full bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] pb-6 pt-4 px-6 z-20 shadow-[0_-10px_30px_rgba(10,92,113,0.2)] rounded-t-[32px]">
    <div className="flex justify-between items-center text-white">
      <button onClick={() => onNavigate('home')} className={`flex flex-col items-center gap-1 transition-opacity ${current === 'home' ? 'opacity-100' : 'opacity-50'}`}>
        <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" /></svg>
        <span className="text-[10px] font-medium">Home</span>
      </button>
      <button onClick={() => onNavigate('history')} className={`flex flex-col items-center gap-1 transition-opacity ${current === 'history' ? 'opacity-100' : 'opacity-50'}`}>
        <HistoryIcon size={24} />
        <span className="text-[10px] font-medium">History</span>
      </button>
      <button onClick={() => onNavigate('sensors')} className={`flex flex-col items-center gap-1 transition-opacity ${current === 'sensors' ? 'opacity-100' : 'opacity-50'}`}>
        <Info size={24} />
        <span className="text-[10px] font-medium">Sensors</span>
      </button>
      <button onClick={() => onNavigate('settings')} className={`flex flex-col items-center gap-1 transition-opacity ${current === 'settings' ? 'opacity-100' : 'opacity-50'}`}>
        <Settings size={24} />
        <span className="text-[10px] font-medium">Settings</span>
      </button>
    </div>
  </div>
);

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('splash');
  const [resetEmail, setResetEmail] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [otp, setOtp] = useState(['', '', '', '', '']);
  const [selectedDevice, setSelectedDevice] = useState('Device A');
  const [isDeviceDropdownOpen, setIsDeviceDropdownOpen] = useState(false);
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [selectedSensor, setSelectedSensor] = useState<'ph' | 'temp' | 'tds' | 'turbidity'>('ph');
  const [historyTab, setHistoryTab] = useState<'ph' | 'temp' | 'tds' | 'turbidity'>('ph');

  useEffect(() => {
    if (currentScreen !== 'otp') {
      setOtp(['', '', '', '', '']);
    }
    if (currentScreen !== 'forgot_password') {
      setResetEmail('');
    }

    if (currentScreen === 'splash') {
      const timer = setTimeout(() => {
        setCurrentScreen('signin');
      }, 3500);
      return () => clearTimeout(timer);
    }
    if (currentScreen === 'preparing') {
      const timer = setTimeout(() => {
        setCurrentScreen('connect');
      }, 3000);
      return () => clearTimeout(timer);
    }
    if (currentScreen === 'analyzing') {
      const timer = setTimeout(() => {
        setCurrentScreen('home');
      }, 4000);
      return () => clearTimeout(timer);
    }
    if (currentScreen === 'refreshing') {
      const timer = setTimeout(() => {
        setCurrentScreen('home');
      }, 2500);
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
              <div className="absolute inset-0 flex items-center justify-center pt-7 z-0">
                 <span className="text-[#1CA3C6] font-bold text-xl leading-tight text-center">Pure<br/>Drop</span>
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
                  <div className="absolute inset-0 flex items-center justify-center pt-7">
                     <span className="text-white font-bold text-xl leading-tight text-center">Pure<br/>Drop</span>
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
          <div key={currentScreen} className="flex flex-col h-full font-serif relative overflow-hidden">
            {/* Background Decorations */}
            <div className="absolute top-[-20px] right-[-40px] opacity-20 pointer-events-none z-0">
              <svg viewBox="0 0 24 24" className="w-48 h-48 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>
            <div className="absolute bottom-[-40px] left-[-40px] opacity-20 pointer-events-none z-0">
              <svg viewBox="0 0 24 24" className="w-64 h-64 text-[#4ECDC4]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            {/* Fixed Header */}
            <div className="p-6 pb-2 relative z-20">
              <div className="flex justify-between items-start">
                <h1 className="text-[44px] font-black text-[#0A5C71] mt-4 leading-none tracking-tighter">
                  {isSignIn ? 'Sign In' : 'Sign Up'}
                </h1>
                
                {/* Logo */}
                <div className="relative w-32 h-40 flex items-center justify-center">
                  <div className="absolute inset-0 bg-[#1CA3C6]/20 rounded-full blur-3xl animate-pulse" />
                  
                  {/* Shadow Drop (Outline) */}
                  <svg viewBox="0 0 24 24" className="absolute w-44 h-44 text-[#1CA3C6]/20" fill="none" stroke="currentColor" strokeWidth="0.5">
                    <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                  </svg>

                  <svg viewBox="0 0 24 24" className="w-40 h-40 text-[#1CA3C6] drop-shadow-2xl" fill="currentColor">
                    <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center pt-6 text-white text-center font-black text-[12px] leading-tight tracking-widest uppercase">
                    Pure<br/>Drop
                  </div>
                </div>
              </div>
            </div>

            {/* Scrollable Content */}
            <div className="flex-1 overflow-y-auto no-scrollbar px-6 pb-8 relative z-10">
              {/* Sign Up Welcome Text */}
              {!isSignIn && (
                <div className="text-center mb-8">
                  <h2 className="text-4xl font-black italic text-[#0A5C71] drop-shadow-sm">Welcome</h2>
                  <div className="w-12 h-1 bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] mx-auto mt-2 rounded-full" />
                </div>
              )}

              {/* Form Fields */}
              <div className="space-y-6">
                {!isSignIn && (
                  <div className="space-y-2">
                    <label className="text-lg font-black italic text-[#0A5C71] ml-1">Full Name :</label>
                    <input type="text" placeholder="Enter your name" className="w-full h-14 bg-white/50 backdrop-blur-md border-2 border-[#0A5C71]/10 rounded-2xl px-6 text-[#0A5C71] font-bold focus:outline-none focus:border-[#1CA3C6] focus:bg-white transition-all shadow-sm" />
                  </div>
                )}

                <div className="space-y-2">
                  <label className="text-lg font-black italic text-[#0A5C71] ml-1">
                    {isSignIn ? 'Name / Email :' : 'Email :'}
                  </label>
                  <input type="text" placeholder={isSignIn ? "Username or email" : "example@mail.com"} className="w-full h-14 bg-white/50 backdrop-blur-md border-2 border-[#0A5C71]/10 rounded-2xl px-6 text-[#0A5C71] font-bold focus:outline-none focus:border-[#1CA3C6] focus:bg-white transition-all shadow-sm" />
                </div>

                <div className="space-y-2">
                  <label className="text-lg font-black italic text-[#0A5C71] ml-1">Password :</label>
                  <input type="password" placeholder={isSignIn ? "••••••••" : "Create a password"} className="w-full h-14 bg-white/50 backdrop-blur-md border-2 border-[#0A5C71]/10 rounded-2xl px-6 text-[#0A5C71] font-bold focus:outline-none focus:border-[#1CA3C6] focus:bg-white transition-all shadow-sm placeholder:text-[#0A5C71]/30" />
                </div>

                {!isSignIn && (
                  <div className="space-y-2">
                    <label className="text-lg font-black italic text-[#0A5C71] ml-1">Confirm Password :</label>
                    <input type="password" placeholder="Repeat password" className="w-full h-14 bg-white/50 backdrop-blur-md border-2 border-[#0A5C71]/10 rounded-2xl px-6 text-[#0A5C71] font-bold focus:outline-none focus:border-[#1CA3C6] focus:bg-white transition-all shadow-sm placeholder:text-[#0A5C71]/30" />
                  </div>
                )}

                {isSignIn && (
                  <div className="flex flex-col gap-4 px-1">
                    <div 
                      className="flex items-center gap-3 cursor-pointer group w-fit"
                      onClick={() => setRememberMe(!rememberMe)}
                    >
                      <div className={`w-6 h-6 border-2 border-[#0A5C71] rounded-lg flex items-center justify-center transition-all ${rememberMe ? 'bg-[#0A5C71] scale-110 shadow-lg' : 'bg-white/50'}`}>
                        {rememberMe && <Check size={16} className="text-white" strokeWidth={4} />}
                      </div>
                      <span className="text-base font-black italic text-[#0A5C71] select-none group-hover:text-[#1CA3C6] transition-colors">Remember Me</span>
                    </div>
                    <button onClick={() => setCurrentScreen('forgot_password')} className="text-base font-black italic text-[#0A5C71] underline decoration-2 underline-offset-4 hover:text-[#1CA3C6] transition-colors w-fit">
                      Forgot Password ?
                    </button>
                  </div>
                )}
              </div>

              {/* Action Button */}
              <div className="mt-12">
                <button 
                  onClick={() => setCurrentScreen(isSignIn ? 'preparing' : 'signin')} 
                  className="w-full h-16 bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] text-white text-2xl font-black italic rounded-[20px] shadow-[0_10px_25px_rgba(10,92,113,0.3)] hover:scale-[1.02] active:scale-[0.98] transition-all"
                >
                  {isSignIn ? 'Sign In' : 'Sign Up'}
                </button>
              </div>

              {/* Footer Link */}
              <div className="mt-12 text-center pb-8">
                <p className="text-[#0A5C71] italic text-base font-medium">
                  {isSignIn ? 'Not a member ? ' : 'Already have an account ? '}
                  <button 
                    onClick={() => setCurrentScreen(isSignIn ? 'signup' : 'signin')}
                    className="font-black underline decoration-2 underline-offset-4 hover:text-[#1CA3C6] transition-colors"
                  >
                    {isSignIn ? 'Sign Up' : 'Sign In'}
                  </button>
                </p>
              </div>
            </div>
          </div>
        );

      case 'forgot_password':
        return (
          <div key={currentScreen} className="flex flex-col h-full font-sans relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-40px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-48 h-48 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="flex justify-between items-center mb-8 relative z-10">
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
          <div key={currentScreen} className="flex flex-col h-full font-sans relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute bottom-20 left-[-40px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-64 h-64 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="mb-8 relative z-10">
              <button onClick={() => setCurrentScreen('forgot_password')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
            </div>
            <h2 className="text-3xl font-bold text-[#0A5C71] mb-3">OTP Code Verification</h2>
            <p className="text-sm text-[#0A5C71] mb-10 leading-relaxed">
              we have sent an OTP code to your email <span className="underline">{resetEmail || 'your email'}</span> Enter the OTP code below to verify
            </p>
            
            <div className="flex justify-between gap-2 mb-10">
              {[0, 1, 2, 3, 4].map((index) => (
                <input 
                  key={index} 
                  type="text"
                  maxLength={1}
                  value={otp[index]}
                  className="w-14 h-14 bg-[#0A5C71] text-white text-center text-2xl font-bold rounded-xl shadow-inner focus:outline-none focus:ring-2 focus:ring-[#1CA3C6]"
                  onChange={(e) => {
                    const val = e.target.value;
                    const newOtp = [...otp];
                    newOtp[index] = val;
                    setOtp(newOtp);
                    if (val.length === 1) {
                      const next = e.target.nextElementSibling as HTMLInputElement;
                      if (next) next.focus();
                    }
                  }}
                  onKeyDown={(e) => {
                    if (e.key === 'Backspace' && !e.currentTarget.value) {
                      const prev = e.currentTarget.previousElementSibling as HTMLInputElement;
                      if (prev) prev.focus();
                    }
                  }}
                />
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
          <div key={currentScreen} className="flex flex-col h-full font-sans relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-10 right-[-20px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-48 h-48 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="mb-8 relative z-10">
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
          <div className="flex flex-col min-h-full font-sans items-center pt-32 px-6 pb-10">
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

      case 'preparing':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-40px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-64 h-64 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="flex items-center mb-8 relative z-10">
              <button onClick={() => setCurrentScreen('signin')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-center text-3xl font-bold text-[#0A5C71] pr-7">Preparing<br/>Sensors</h2>
            </div>
            
            <div className="flex-1 flex flex-col items-center justify-center">
              <div className="w-40 h-40 rounded-full shadow-[0_10px_30px_rgba(28,163,198,0.3)] flex items-center justify-center mb-16">
                <svg viewBox="0 0 24 24" className="w-40 h-40 text-[#1CA3C6]" fill="currentColor">
                  <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                </svg>
              </div>
              
              <p className="text-lg text-[#0A5C71] font-serif mb-10">Place sensors in water to begin</p>
              <p className="text-base text-[#0A5C71]">Status : Waiting...</p>
            </div>
          </div>
        );

      case 'connect':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute bottom-20 left-[-40px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-64 h-64 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="flex items-center mb-8 relative z-10">
              <button onClick={() => setCurrentScreen('preparing')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-center text-3xl font-bold text-[#0A5C71] pr-7">Connect your<br/>Device</h2>
            </div>
            
            <div className="flex-1 flex flex-col items-center justify-center">
              <div className="flex items-center justify-center gap-2 mb-16">
                <div className="w-2 h-10 bg-[#0A5C71] rounded-full"></div>
                <div className="w-2 h-16 bg-[#0A5C71] rounded-full"></div>
                <div className="w-20 h-32 bg-[#0A5C71] rounded-2xl flex justify-center pt-4">
                  <div className="w-2 h-2 bg-white rounded-full"></div>
                </div>
                <div className="w-2 h-16 bg-[#0A5C71] rounded-full"></div>
                <div className="w-2 h-10 bg-[#0A5C71] rounded-full"></div>
              </div>
              
              <p className="text-lg text-[#0A5C71] font-serif text-center mb-10 leading-relaxed">Make sure your device is<br/>powered on</p>
              
              <div className="flex items-center gap-2 mb-16">
                <span className="text-base text-[#0A5C71]">Status :</span>
                <div className="w-3 h-3 bg-red-500 rounded-full"></div>
                <span className="text-base text-[#0A5C71]">Not Connected</span>
              </div>
              
              <button onClick={() => setCurrentScreen('scan')} className="w-full h-14 bg-[#0A5C71] text-white text-xl font-bold rounded-xl hover:bg-[#084a5a] transition-colors">
                Scan for devices
              </button>
            </div>
          </div>
        );

      case 'scan':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-40 right-[-30px] opacity-10 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-48 h-48 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            <div className="flex items-center mb-4 relative z-10">
              <button onClick={() => setCurrentScreen('connect')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-center text-3xl font-bold text-[#0A5C71] pr-7">Scan For<br/>Devices</h2>
            </div>
            
            <div className="w-full py-3 border-y border-[#0A5C71]/20 mb-6">
              <p className="text-center text-base text-[#0A5C71] font-serif">Scanning for nearby devices...</p>
            </div>
            
            <h3 className="text-base font-bold text-[#0A5C71] mb-4 px-2">Available Devices</h3>
            
            <div className="space-y-3 px-2 flex-1">
              <div 
                onClick={() => { setSelectedDevice('Device A'); setCurrentScreen('home'); }} 
                className={`w-full p-4 border border-[#0A5C71] rounded-lg flex items-center cursor-pointer transition-all ${selectedDevice === 'Device A' ? 'bg-[#9CE3F5]' : 'bg-white/50'}`}
              >
                <svg className="w-5 h-5 text-[#0A5C71] mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                <span className="text-lg font-bold text-[#0A5C71] flex-1">Device A</span>
                {selectedDevice === 'Device A' && <Check className="text-[#0A5C71]" size={24} />}
              </div>
              
              <div 
                onClick={() => { setSelectedDevice('Device B'); setCurrentScreen('home'); }} 
                className={`w-full p-4 border border-[#0A5C71] rounded-lg flex items-center cursor-pointer transition-all ${selectedDevice === 'Device B' ? 'bg-[#9CE3F5]' : 'bg-white/50'}`}
              >
                <svg className="w-5 h-5 text-[#0A5C71] mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                <span className="text-lg font-bold text-[#0A5C71] flex-1">Device B</span>
                {selectedDevice === 'Device B' && <Check className="text-[#0A5C71]" size={24} />}
              </div>
              
              <div 
                onClick={() => { setSelectedDevice('Device C'); setCurrentScreen('home'); }} 
                className={`w-full p-4 border border-[#0A5C71] rounded-lg flex items-center cursor-pointer transition-all ${selectedDevice === 'Device C' ? 'bg-[#9CE3F5]' : 'bg-white/50'}`}
              >
                <svg className="w-5 h-5 text-[#0A5C71] mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                <span className="text-lg font-bold text-[#0A5C71] flex-1">Device C</span>
                {selectedDevice === 'Device C' && <Check className="text-[#0A5C71]" size={24} />}
              </div>
              
              <div onClick={() => setCurrentScreen('home')} className="w-full p-4 border border-[#0A5C71] rounded-lg flex items-center cursor-pointer bg-white/50">
                <svg className="w-6 h-6 text-[#0A5C71] mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg>
                <span className="text-lg font-bold text-[#0A5C71]">Add new</span>
              </div>
            </div>
            
            <div className="mt-auto px-2">
              <button 
                onClick={() => setCurrentScreen('refreshing')}
                className="w-full h-14 border-2 border-[#0A5C71] text-[#0A5C71] text-xl font-bold rounded-xl hover:bg-[#0A5C71]/10 transition-colors"
              >
                Retry
              </button>
            </div>
          </div>
        );

      case 'analyzing':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 px-6">
            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <div className="bg-white/50 backdrop-blur-sm px-4 py-1.5 rounded-lg border border-[#0A5C71]/10 text-[#0A5C71] font-bold shadow-sm flex items-center gap-2 text-sm">
                <span>Home</span>
                <ChevronLeft size={16} className="-rotate-90" />
              </div>
              <div className="flex items-center gap-3">
                <RefreshCw size={18} className="text-[#0A5C71] animate-spin" />
                <Settings size={18} className="text-[#0A5C71]" />
              </div>
            </div>
            
            <div className="flex-1 flex flex-col items-center justify-center">
              <div className="relative w-48 h-48 flex items-center justify-center mb-12">
                <motion.div
                  initial={{ scale: 0.9, opacity: 0.5 }}
                  animate={{ scale: 1.1, opacity: 0.8 }}
                  transition={{ duration: 1.5, repeat: Infinity, repeatType: "reverse" }}
                  className="absolute inset-0 bg-[#1CA3C6]/10 rounded-full blur-2xl"
                />
                <svg viewBox="0 0 24 24" className="w-40 h-40 text-[#1CA3C6] drop-shadow-xl" fill="currentColor">
                  <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                </svg>
              </div>
              
              <div className="w-full px-4 space-y-4">
                <div className="w-full bg-[#0A5C71]/10 h-3 rounded-full overflow-hidden">
                  <motion.div 
                    className="bg-[#1CA3C6] h-full"
                    initial={{ width: "0%" }}
                    animate={{ width: "100%" }}
                    transition={{ duration: 4, ease: "linear" }}
                  />
                </div>
                <h2 className="text-center text-2xl font-bold text-[#0A5C71] tracking-[0.2em]">DOWNLOADING</h2>
              </div>
            </div>
          </div>
        );

      case 'refreshing':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 px-6">
            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <div className="bg-white/50 backdrop-blur-sm px-4 py-1.5 rounded-lg border border-[#0A5C71]/10 text-[#0A5C71] font-bold shadow-sm flex items-center gap-2 text-sm">
                <span>Home</span>
                <ChevronLeft size={16} className="-rotate-90" />
              </div>
              <div className="flex items-center gap-3">
                <RefreshCw size={18} className="text-[#0A5C71] animate-spin" />
                <Settings size={18} className="text-[#0A5C71]" />
              </div>
            </div>
            
            <div className="flex-1 flex flex-col items-center justify-center">
              <div className="relative w-48 h-48 flex items-center justify-center mb-12">
                <motion.div
                  initial={{ scale: 0.9, opacity: 0.5 }}
                  animate={{ scale: 1.1, opacity: 0.8 }}
                  transition={{ duration: 1.5, repeat: Infinity, repeatType: "reverse" }}
                  className="absolute inset-0 bg-[#1CA3C6]/10 rounded-full blur-2xl"
                />
                <svg viewBox="0 0 24 24" className="w-40 h-40 text-[#1CA3C6] drop-shadow-xl" fill="currentColor">
                  <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
                </svg>
              </div>
              
              <div className="w-full px-4 space-y-4">
                <div className="w-full bg-[#0A5C71]/10 h-3 rounded-full overflow-hidden">
                  <motion.div 
                    className="bg-[#1CA3C6] h-full"
                    initial={{ width: "0%" }}
                    animate={{ width: "100%" }}
                    transition={{ duration: 2.5, ease: "linear" }}
                  />
                </div>
                <h2 className="text-center text-2xl font-bold text-[#0A5C71] tracking-[0.2em]">REFRESHING</h2>
              </div>
            </div>
          </div>
        );

      case 'home':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-40 right-[-50px] opacity-20 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-80 h-80 text-[#1CA3C6]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>
            <div className="absolute bottom-20 left-[-40px] opacity-20 pointer-events-none">
              <svg viewBox="0 0 24 24" className="w-64 h-64 text-[#4ECDC4]" fill="currentColor">
                <path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/>
              </svg>
            </div>

            {/* Sticky Header & Greeting */}
            <div className={`sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 mb-6 shadow-md ${isDeviceDropdownOpen ? 'z-[120]' : 'z-[110]'}`}>
              <div className="flex justify-between items-center mb-4">
                <div className="relative">
                  <button 
                    onClick={() => setIsDeviceDropdownOpen(!isDeviceDropdownOpen)}
                    className="flex items-center gap-2 bg-white/90 backdrop-blur-md px-4 py-2 rounded-full border border-[#0A5C71]/10 text-[#0A5C71] font-bold shadow-md relative z-[121]"
                  >
                    <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                    <span>{selectedDevice}</span>
                    <ChevronLeft size={18} className={`transition-transform duration-300 ${isDeviceDropdownOpen ? 'rotate-90' : '-rotate-90'}`} />
                  </button>

                  {/* Click Backdrop */}
                  {isDeviceDropdownOpen && (
                    <div 
                      className="fixed inset-0 z-[115]" 
                      onClick={() => setIsDeviceDropdownOpen(false)}
                    />
                  )}

                  {/* Dropdown List Overlay */}
                  {isDeviceDropdownOpen && (
                    <motion.div 
                      initial={{ opacity: 0, y: -10 }}
                      animate={{ opacity: 1, y: 0 }}
                      className="absolute top-full left-0 mt-3 w-56 bg-white rounded-[24px] shadow-[0_20px_50px_rgba(10,92,113,0.2)] border border-[#0A5C71]/5 z-[120] overflow-hidden"
                    >
                      <div className="py-2">
                        {['Device A', 'Device B', 'Device C'].map(device => (
                          <button 
                            key={device}
                            onClick={() => {
                              setSelectedDevice(device);
                              setIsDeviceDropdownOpen(false);
                            }}
                            className={`w-full px-5 py-3 text-left text-sm font-black transition-colors flex items-center justify-between ${
                              selectedDevice === device ? 'text-[#1CA3C6] bg-[#1CA3C6]/5' : 'text-[#0A5C71] hover:bg-[#0A5C71]/5'
                            }`}
                          >
                            <span>{device}</span>
                            {selectedDevice === device && <Check size={14} strokeWidth={4} />}
                          </button>
                        ))}
                      </div>
                    </motion.div>
                  )}
                </div>
                
                <div className="flex items-center gap-3">
                  <button 
                    onClick={() => setCurrentScreen('refreshing')}
                    className="w-10 h-10 bg-white rounded-full flex items-center justify-center text-[#0A5C71] shadow-lg transition-all active:scale-95"
                  >
                    <RefreshCw size={20} />
                  </button>
                </div>
              </div>

              <div className={`transition-opacity duration-300 ${isDeviceDropdownOpen ? 'opacity-0 pointer-events-none' : 'opacity-100'}`}>
                <h2 className="text-3xl font-black text-[#0A5C71] tracking-tight leading-none">Hello, Mayar!</h2>
                <p className="text-base text-[#0A5C71]/60 font-medium mt-1">Real-time water status</p>
              </div>
            </div>

            {/* Main Quality Card - Compact Hero Version */}
            <div className="bg-gradient-to-br from-[#0A5C71] via-[#1CA3C6] to-[#0A5C71] rounded-[32px] p-6 text-white mb-8 shadow-[0_20px_40px_rgba(10,92,113,0.3)] relative overflow-hidden group">
              <div className="relative z-10 flex flex-col">
                <div className="flex justify-between items-start mb-6">
                  <div className="space-y-1">
                    <div className="flex items-center gap-2 px-2 py-0.5 bg-white/10 rounded-full backdrop-blur-md border border-white/10 w-fit">
                      <div className="w-1.5 h-1.5 bg-[#4ECDC4] rounded-full animate-pulse shadow-[0_0_8px_#4ECDC4]" />
                      <span className="text-[9px] font-black uppercase tracking-[0.2em]">Live Monitoring</span>
                    </div>
                    <h3 className="text-2xl font-black tracking-tight leading-tight">Excellent Condition</h3>
                  </div>
                  <div className="w-12 h-12 bg-white/10 rounded-2xl flex items-center justify-center backdrop-blur-2xl border border-white/20 shadow-inner">
                    <Activity size={24} className="text-white" />
                  </div>
                </div>

                <div className="flex items-center gap-4 mb-8">
                  <div className="flex items-baseline gap-1">
                    <span className="text-6xl font-black tracking-tighter leading-none">62</span>
                    <span className="text-xl font-bold opacity-40">/100</span>
                  </div>
                  <div className="h-12 w-[1px] bg-white/10 rounded-full" />
                  <div className="space-y-0">
                    <p className="text-lg font-bold leading-tight">Your water is <span className="text-[#4ECDC4] font-black">Safe</span> to drink</p>
                    <p className="text-[9px] font-black opacity-40 uppercase tracking-widest">Verified 5m ago</p>
                  </div>
                </div>

                <div className="space-y-3">
                  <div className="w-full bg-white/10 h-3 rounded-full overflow-hidden backdrop-blur-sm p-[2px] border border-white/5">
                    <motion.div 
                      className="bg-gradient-to-r from-[#4ECDC4] via-white to-[#4ECDC4] h-full rounded-full shadow-[0_0_15px_rgba(78,205,196,0.6)]"
                      initial={{ width: 0 }}
                      animate={{ width: '62%' }}
                      transition={{ duration: 2, ease: "circOut" }}
                    />
                  </div>
                  <div className="flex justify-between items-center px-1">
                    <span className="text-[9px] font-black uppercase tracking-[0.2em] opacity-50">Quality Index</span>
                    <div className="flex items-center gap-1">
                      <span className="text-xs font-black">92%</span>
                      <ChevronRight size={12} className="text-[#4ECDC4]" />
                    </div>
                  </div>
                </div>
              </div>

              {/* Enhanced Decorative Elements */}
              <div className="absolute -right-10 -top-10 w-40 h-40 bg-white/5 rounded-full blur-[60px] group-hover:bg-white/10 transition-all duration-1000"></div>
              <div className="absolute -left-10 -bottom-10 w-40 h-40 bg-[#4ECDC4]/10 rounded-full blur-[60px]"></div>
              
              {/* Animated Wave Pattern */}
              <motion.svg 
                className="absolute bottom-0 left-0 w-[200%] h-24 opacity-10 pointer-events-none" 
                viewBox="0 0 1440 320"
                animate={{ x: ["-50%", "0%"] }}
                transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
              >
                <path fill="#ffffff" d="M0,160L48,176C96,192,192,224,288,224C384,224,480,192,576,165.3C672,139,768,117,864,128C960,139,1056,181,1152,186.7C1248,192,1344,160,1392,144L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
              </motion.svg>
            </div>

            {/* Metrics Grid */}
            <div className="grid grid-cols-2 gap-4 mb-6 relative z-10">
              <div className="bg-white/80 backdrop-blur-md p-4 rounded-[24px] shadow-xl border border-white/50 group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex items-center gap-2 mb-3">
                  <div className="w-8 h-8 bg-orange-100 rounded-xl flex items-center justify-center text-orange-500">
                    <Thermometer size={18} />
                  </div>
                  <span className="text-[11px] font-black text-[#0A5C71]/50 uppercase tracking-wider">Temp</span>
                </div>
                <p className="text-2xl font-black text-[#0A5C71]">24.5°C</p>
                <div className="flex items-center gap-1 mt-1">
                  <div className="w-1.5 h-1.5 bg-green-500 rounded-full" />
                  <p className="text-[10px] text-green-600 font-bold uppercase">Optimal</p>
                </div>
              </div>
              <div className="bg-white/80 backdrop-blur-md p-4 rounded-[24px] shadow-xl border border-white/50 group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex items-center gap-2 mb-3">
                  <div className="w-8 h-8 bg-purple-100 rounded-xl flex items-center justify-center text-purple-500">
                    <Droplets size={18} />
                  </div>
                  <span className="text-[11px] font-black text-[#0A5C71]/50 uppercase tracking-wider">pH Level</span>
                </div>
                <p className="text-2xl font-black text-[#0A5C71]">7.2</p>
                <div className="flex items-center gap-1 mt-1">
                  <div className="w-1.5 h-1.5 bg-green-500 rounded-full" />
                  <p className="text-[10px] text-green-600 font-bold uppercase">Neutral</p>
                </div>
              </div>
              <div className="bg-white/80 backdrop-blur-md p-4 rounded-[24px] shadow-xl border border-white/50 group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex items-center gap-2 mb-3">
                  <div className="w-8 h-8 bg-blue-100 rounded-xl flex items-center justify-center text-blue-500">
                    <Zap size={18} />
                  </div>
                  <span className="text-[11px] font-black text-[#0A5C71]/50 uppercase tracking-wider">TDS</span>
                </div>
                <p className="text-2xl font-black text-[#0A5C71]">120<span className="text-xs ml-1 opacity-50">ppm</span></p>
                <div className="flex items-center gap-1 mt-1">
                  <div className="w-1.5 h-1.5 bg-green-500 rounded-full" />
                  <p className="text-[10px] text-green-600 font-bold uppercase">Pure</p>
                </div>
              </div>
              <div className="bg-white/80 backdrop-blur-md p-4 rounded-[24px] shadow-xl border border-white/50 group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex items-center gap-2 mb-3">
                  <div className="w-8 h-8 bg-cyan-100 rounded-xl flex items-center justify-center text-cyan-500">
                    <Waves size={18} />
                  </div>
                  <span className="text-[11px] font-black text-[#0A5C71]/50 uppercase tracking-wider">Turbidity</span>
                </div>
                <p className="text-2xl font-black text-[#0A5C71]">0.5<span className="text-xs ml-1 opacity-50">NTU</span></p>
                <div className="flex items-center gap-1 mt-1">
                  <div className="w-1.5 h-1.5 bg-green-500 rounded-full" />
                  <p className="text-[10px] text-green-600 font-bold uppercase">Clear</p>
                </div>
              </div>
            </div>

            {/* Status Section */}
            <div className="bg-white/40 backdrop-blur-lg rounded-[24px] p-4 border border-white/60 flex items-center gap-4 relative z-10 shadow-lg">
              <div className="w-14 h-14 bg-gradient-to-br from-[#0A5C71] to-[#1CA3C6] rounded-2xl flex items-center justify-center text-white shadow-lg">
                <RefreshCw size={28} />
              </div>
              <div className="flex-1">
                <p className="text-base font-black text-[#0A5C71]">Device Connected</p>
                <p className="text-xs text-[#0A5C71]/60 font-bold">Last updated: Just now</p>
              </div>
              <button onClick={() => setCurrentScreen('connect')} className="px-4 py-2 bg-[#0A5C71]/10 rounded-full text-xs font-black text-[#0A5C71] uppercase tracking-wider hover:bg-[#0A5C71]/20 transition-colors">
                Change
              </button>
            </div>
          </div>
        );

      case 'history':
        const historyData = {
          ph: { color: '#1CA3C6', label: 'pH' },
          temp: { color: '#EAB308', label: 'Temperature' },
          tds: { color: '#1CA3C6', label: 'TDS' },
          turbidity: { color: '#EF4444', label: 'Turbidity' }
        }[historyTab];

        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <button onClick={() => setCurrentScreen('home')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="text-3xl font-black text-[#0A5C71] tracking-tighter">History</h2>
              <div className="flex items-center gap-3">
                <button 
                  onClick={() => setCurrentScreen('refreshing')}
                  className="w-10 h-10 bg-white rounded-full flex items-center justify-center text-[#0A5C71] shadow-lg transition-all active:scale-95"
                >
                  <RefreshCw size={20} />
                </button>
              </div>
            </div>

            {/* Tab Bar */}
            <div className="flex justify-between items-center bg-white/60 backdrop-blur-md p-1.5 rounded-2xl border border-white/50 mb-8 relative z-10 overflow-x-auto no-scrollbar shadow-lg">
              {['ph', 'temp', 'tds', 'turbidity'].map((tab) => (
                <button
                  key={tab}
                  onClick={() => setHistoryTab(tab as any)}
                  className={`px-4 py-2.5 rounded-xl text-xs font-black transition-all whitespace-nowrap uppercase tracking-wider ${
                    historyTab === tab 
                      ? 'bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] text-white shadow-lg' 
                      : 'text-[#0A5C71]/40 hover:text-[#0A5C71]/60'
                  }`}
                >
                  {tab === 'ph' ? 'pH' : tab === 'temp' ? 'Temperature' : tab === 'tds' ? 'TDS' : 'Turbidity'}
                </button>
              ))}
            </div>
            
            <div className="flex-1 space-y-8 overflow-y-auto pr-1 no-scrollbar relative z-10">
              {/* 24H Graph */}
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl group">
                <div className="flex items-center justify-between mb-6">
                  <div className="flex items-center gap-2">
                    <div className="w-3 h-3 rounded-full bg-yellow-400 shadow-[0_0_8px_rgba(250,204,21,0.5)]" />
                    <span className="text-sm font-black text-[#0A5C71] uppercase tracking-widest">24H Analytics</span>
                  </div>
                  <div className="px-3 py-1 bg-yellow-100 text-yellow-600 text-[10px] font-black rounded-full uppercase tracking-widest border border-yellow-200">
                    Caution !
                  </div>
                </div>
                <div className="h-40 w-full relative">
                  <svg className="w-full h-full" viewBox="0 0 400 100" preserveAspectRatio="none">
                    <defs>
                      <linearGradient id="grad24" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" style={{ stopColor: historyData.color, stopOpacity: 0.3 }} />
                        <stop offset="100%" style={{ stopColor: historyData.color, stopOpacity: 0 }} />
                      </linearGradient>
                    </defs>
                    <motion.path 
                      d="M0,80 Q50,60 100,65 T200,50 T300,70 T400,40 L400,100 L0,100 Z" 
                      fill="url(#grad24)"
                      initial={{ pathLength: 0, opacity: 0 }}
                      animate={{ pathLength: 1, opacity: 1 }}
                      transition={{ duration: 2, ease: "easeInOut" }}
                    />
                    <motion.path 
                      d="M0,80 Q50,60 100,65 T200,50 T300,70 T400,40" 
                      fill="none" 
                      stroke={historyData.color} 
                      strokeWidth="3" 
                      strokeLinecap="round"
                      initial={{ pathLength: 0 }}
                      animate={{ pathLength: 1 }}
                      transition={{ duration: 2, ease: "easeInOut" }}
                    />
                  </svg>
                  <div className="flex justify-between mt-4 text-[10px] text-[#0A5C71]/40 font-black uppercase tracking-tighter">
                    <span>8 AM</span><span>12 PM</span><span>4 PM</span><span>8 PM</span><span>12 AM</span><span>4 AM</span>
                  </div>
                </div>
              </div>

              {/* 7 Days Graph */}
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl group">
                <div className="flex items-center justify-between mb-6">
                  <div className="flex items-center gap-2">
                    <div className="w-3 h-3 rounded-full bg-[#4ECDC4] shadow-[0_0_8px_rgba(78,205,196,0.5)]" />
                    <span className="text-sm font-black text-[#0A5C71] uppercase tracking-widest">7 Days Trend</span>
                  </div>
                  <div className="px-3 py-1 bg-green-100 text-green-600 text-[10px] font-black rounded-full uppercase tracking-widest border border-green-200">
                    Stable
                  </div>
                </div>
                <div className="h-40 w-full relative">
                  <svg className="w-full h-full" viewBox="0 0 400 100" preserveAspectRatio="none">
                    <defs>
                      <linearGradient id="grad7" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" style={{ stopColor: '#4ECDC4', stopOpacity: 0.3 }} />
                        <stop offset="100%" style={{ stopColor: '#4ECDC4', stopOpacity: 0 }} />
                      </linearGradient>
                    </defs>
                    <motion.path 
                      d="M0,70 Q50,50 100,55 T200,40 T300,60 T400,30 L400,100 L0,100 Z" 
                      fill="url(#grad7)"
                      initial={{ pathLength: 0, opacity: 0 }}
                      animate={{ pathLength: 1, opacity: 1 }}
                      transition={{ duration: 2, ease: "easeInOut", delay: 0.5 }}
                    />
                    <motion.path 
                      d="M0,70 Q50,50 100,55 T200,40 T300,60 T400,30" 
                      fill="none" 
                      stroke="#4ECDC4" 
                      strokeWidth="3" 
                      strokeLinecap="round"
                      initial={{ pathLength: 0 }}
                      animate={{ pathLength: 1 }}
                      transition={{ duration: 2, ease: "easeInOut", delay: 0.5 }}
                    />
                  </svg>
                  <div className="flex justify-between mt-4 text-[10px] text-[#0A5C71]/40 font-black uppercase tracking-tighter">
                    <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        );

      case 'sensors':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <button onClick={() => setCurrentScreen('home')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="text-3xl font-black text-[#0A5C71] tracking-tighter">Sensors</h2>
              <div className="flex items-center gap-3">
                <button 
                  onClick={() => setCurrentScreen('refreshing')}
                  className="w-10 h-10 bg-white rounded-full flex items-center justify-center text-[#0A5C71] shadow-lg transition-all active:scale-95"
                >
                  <RefreshCw size={20} />
                </button>
              </div>
            </div>
            
            <div className="space-y-6 overflow-y-auto pr-1 no-scrollbar relative z-10">
              {/* Turbidity Card */}
              <div className="bg-white/80 backdrop-blur-md p-5 rounded-[28px] border border-white/50 shadow-xl group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex justify-between items-start mb-4">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-cyan-100 rounded-2xl flex items-center justify-center text-cyan-500 shadow-inner">
                      <Waves size={24} />
                    </div>
                    <div>
                      <h3 className="text-lg font-black text-[#0A5C71]">Turbidity</h3>
                      <div className="flex items-center gap-1.5">
                        <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                        <span className="text-[10px] font-black text-green-600 uppercase tracking-widest">Normal</span>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-2xl font-black text-[#0A5C71]">0.5<span className="text-sm ml-1 opacity-50">NTU</span></span>
                    <div className="w-20 h-2 bg-[#0A5C71]/10 rounded-full mt-2 overflow-hidden p-[1px]">
                      <motion.div 
                        className="bg-gradient-to-r from-cyan-400 to-cyan-500 h-full rounded-full" 
                        initial={{ width: 0 }}
                        animate={{ width: '30%' }}
                        transition={{ duration: 1.5 }}
                      />
                    </div>
                  </div>
                </div>
                <p className="text-xs text-[#0A5C71]/60 font-bold mb-4 leading-relaxed">Measures how cloudy or hazy the water is, indicating the presence of suspended particles.</p>
                <button 
                  onClick={() => { setSelectedSensor('turbidity'); setCurrentScreen('sensor_detail'); }}
                  className="w-full py-3 bg-[#0A5C71]/5 rounded-xl flex justify-center items-center gap-2 text-xs font-black text-[#0A5C71] uppercase tracking-widest hover:bg-[#0A5C71]/10 transition-colors"
                >
                  View Analytics <ChevronLeft size={14} className="rotate-180" />
                </button>
              </div>

              {/* Temperature Card */}
              <div className="bg-white/80 backdrop-blur-md p-5 rounded-[28px] border border-white/50 shadow-xl group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex justify-between items-start mb-4">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-orange-100 rounded-2xl flex items-center justify-center text-orange-500 shadow-inner">
                      <Thermometer size={24} />
                    </div>
                    <div>
                      <h3 className="text-lg font-black text-[#0A5C71]">Temperature</h3>
                      <div className="flex items-center gap-1.5">
                        <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                        <span className="text-[10px] font-black text-green-600 uppercase tracking-widest">Normal</span>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-2xl font-black text-[#0A5C71]">23°C</span>
                    <div className="w-20 h-2 bg-[#0A5C71]/10 rounded-full mt-2 overflow-hidden p-[1px]">
                      <motion.div 
                        className="bg-gradient-to-r from-orange-400 to-orange-500 h-full rounded-full" 
                        initial={{ width: 0 }}
                        animate={{ width: '45%' }}
                        transition={{ duration: 1.5 }}
                      />
                    </div>
                  </div>
                </div>
                <p className="text-xs text-[#0A5C71]/60 font-bold mb-4 leading-relaxed">Measures the thermal energy of the water, affecting chemical reactions and biological life.</p>
                <button 
                  onClick={() => { setSelectedSensor('temp'); setCurrentScreen('sensor_detail'); }}
                  className="w-full py-3 bg-[#0A5C71]/5 rounded-xl flex justify-center items-center gap-2 text-xs font-black text-[#0A5C71] uppercase tracking-widest hover:bg-[#0A5C71]/10 transition-colors"
                >
                  View Analytics <ChevronLeft size={14} className="rotate-180" />
                </button>
              </div>

              {/* pH Card */}
              <div className="bg-white/80 backdrop-blur-md p-5 rounded-[28px] border border-white/50 shadow-xl group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex justify-between items-start mb-4">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-purple-100 rounded-2xl flex items-center justify-center text-purple-500 shadow-inner">
                      <Droplets size={24} />
                    </div>
                    <div>
                      <h3 className="text-lg font-black text-[#0A5C71]">pH Level</h3>
                      <div className="flex items-center gap-1.5">
                        <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                        <span className="text-[10px] font-black text-green-600 uppercase tracking-widest">Normal</span>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-2xl font-black text-[#0A5C71]">7.2</span>
                    <div className="w-20 h-2 bg-[#0A5C71]/10 rounded-full mt-2 overflow-hidden p-[1px]">
                      <motion.div 
                        className="bg-gradient-to-r from-purple-400 to-purple-500 h-full rounded-full" 
                        initial={{ width: 0 }}
                        animate={{ width: '60%' }}
                        transition={{ duration: 1.5 }}
                      />
                    </div>
                  </div>
                </div>
                <p className="text-xs text-[#0A5C71]/60 font-bold mb-4 leading-relaxed">Measures the acidity or alkalinity of water. Essential for safe consumption and pipe longevity.</p>
                <button 
                  onClick={() => { setSelectedSensor('ph'); setCurrentScreen('sensor_detail'); }}
                  className="w-full py-3 bg-[#0A5C71]/5 rounded-xl flex justify-center items-center gap-2 text-xs font-black text-[#0A5C71] uppercase tracking-widest hover:bg-[#0A5C71]/10 transition-colors"
                >
                  View Analytics <ChevronLeft size={14} className="rotate-180" />
                </button>
              </div>

              {/* TDS Card */}
              <div className="bg-white/80 backdrop-blur-md p-5 rounded-[28px] border border-white/50 shadow-xl group hover:translate-y-[-4px] transition-all duration-300">
                <div className="flex justify-between items-start mb-4">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-blue-100 rounded-2xl flex items-center justify-center text-blue-500 shadow-inner">
                      <Zap size={24} />
                    </div>
                    <div>
                      <h3 className="text-lg font-black text-[#0A5C71]">TDS</h3>
                      <div className="flex items-center gap-1.5">
                        <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                        <span className="text-[10px] font-black text-green-600 uppercase tracking-widest">Normal</span>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="text-2xl font-black text-[#0A5C71]">120<span className="text-sm ml-1 opacity-50">mg/L</span></span>
                    <div className="w-20 h-2 bg-[#0A5C71]/10 rounded-full mt-2 overflow-hidden p-[1px]">
                      <motion.div 
                        className="bg-gradient-to-r from-blue-400 to-blue-500 h-full rounded-full" 
                        initial={{ width: 0 }}
                        animate={{ width: '25%' }}
                        transition={{ duration: 1.5 }}
                      />
                    </div>
                  </div>
                </div>
                <p className="text-xs text-[#0A5C71]/60 font-bold mb-4 leading-relaxed">Total Dissolved Solids indicates the concentration of dissolved substances in the water.</p>
                <button 
                  onClick={() => { setSelectedSensor('tds'); setCurrentScreen('sensor_detail'); }}
                  className="w-full py-3 bg-[#0A5C71]/5 rounded-xl flex justify-center items-center gap-2 text-xs font-black text-[#0A5C71] uppercase tracking-widest hover:bg-[#0A5C71]/10 transition-colors"
                >
                  View Analytics <ChevronLeft size={14} className="rotate-180" />
                </button>
              </div>
            </div>
          </div>
        );

      case 'sensor_detail':
        const sensorData = {
          ph: {
            title: 'pH Sensor',
            value: 'pH 7.2',
            status: 'Normal',
            statusColor: 'bg-green-500',
            icon: <Droplets size={24} />,
            desc: [
              'Measures the acidity or alkalinity of water.',
              'Safe range : 6.5 - 8.5',
              'A pH of 7 is neutral , low pH cause corrosion ; high pH can Lead to scaling .'
            ],
            graphLabel: 'Safe',
            graphColor: '#1CA3C6'
          },
          temp: {
            title: 'Temperature Sensor',
            value: 'Temp 25°C',
            status: 'Acceptable',
            statusColor: 'bg-yellow-500',
            icon: <Thermometer size={24} />,
            desc: [
              'Measures the Temperature of water.',
              'Safe range : 10 - 25°C',
              'Above 25-30 °C — water tastes bad, promotes microbial growth .'
            ],
            graphLabel: 'Caution !',
            graphColor: '#EAB308'
          },
          tds: {
            title: 'Dissolved solids sensor',
            value: 'TDS 120 mg/L',
            status: 'Normal',
            statusColor: 'bg-green-500',
            icon: <Zap size={24} />,
            desc: [
              'Measures the total amount of dissolved substances in water, such as salts, minerals, and metals.',
              'Safe range : 0 - 300 mg/L',
              '300 - 600 mg/L Water is still drinkable, but mineral content is noticeable.',
              'Above 1000 mg/L Water quality is poor and may be unsuitable for drinking.'
            ],
            graphLabel: 'Safe',
            graphColor: '#1CA3C6'
          },
          turbidity: {
            title: 'Turbidity sensor',
            value: 'Turbidity 6.5 NTU',
            status: 'Critical',
            statusColor: 'bg-red-500',
            icon: <Waves size={24} />,
            desc: [
              'Measures how cloudy or clear the water is by detecting suspended particles such as mud, bacteria, or organic matter.',
              'Safe range : 0 - 1 NTU',
              '1 - 5 NTU Water is slightly cloudy but still usable.',
              'Above 5 NTU Water may contain harmful microorganisms and is unsafe.'
            ],
            graphLabel: 'Unsafe !!',
            graphColor: '#EF4444'
          }
        }[selectedSensor];

        return (
          <div className="flex flex-col h-full font-sans pb-24 relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <button onClick={() => setCurrentScreen('sensors')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="text-3xl font-black text-[#0A5C71] tracking-tighter">{sensorData.title}</h2>
              <div className="w-10" /> {/* Spacer */}
            </div>

            <div className="flex-1 space-y-8 overflow-y-auto pr-1 no-scrollbar relative z-10">
              {/* Main Info Card */}
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl group">
                <div className="flex justify-between items-center mb-6">
                  <div className="flex items-center gap-4">
                    <div className="w-14 h-14 bg-cyan-100 rounded-2xl flex items-center justify-center text-cyan-500 shadow-inner">
                      {sensorData.icon}
                    </div>
                    <div>
                      <h3 className="text-2xl font-black text-[#0A5C71]">{sensorData.value}</h3>
                      <div className="flex items-center gap-1.5 mt-1">
                        <div className={`w-2 h-2 rounded-full animate-pulse ${sensorData.statusColor}`} />
                        <span className="text-[10px] font-black text-[#0A5C71]/60 uppercase tracking-widest">{sensorData.status}</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="space-y-4">
                  {sensorData.desc.map((line, i) => (
                    <p key={i} className="text-xs text-[#0A5C71]/70 font-bold leading-relaxed flex gap-3">
                      <span className="mt-1.5 w-1.5 h-1.5 rounded-full bg-[#0A5C71]/30 shrink-0" />
                      {line}
                    </p>
                  ))}
                </div>
              </div>

              {/* Graph Card */}
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl group">
                <div className="flex justify-center mb-6">
                   <span className={`text-[10px] font-black px-6 py-1.5 rounded-full bg-white border border-white shadow-lg uppercase tracking-widest`} style={{ color: sensorData.graphColor }}>
                    {sensorData.graphLabel}
                  </span>
                </div>
                <div className="h-44 w-full relative">
                  {/* Mock Graph SVG */}
                  <svg className="w-full h-full" viewBox="0 0 400 100" preserveAspectRatio="none">
                    <defs>
                      <linearGradient id="grad" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" style={{ stopColor: sensorData.graphColor, stopOpacity: 0.3 }} />
                        <stop offset="100%" style={{ stopColor: sensorData.graphColor, stopOpacity: 0 }} />
                      </linearGradient>
                    </defs>
                    <motion.path 
                      d="M0,80 Q50,70 100,75 T200,60 T300,80 T400,50 L400,100 L0,100 Z" 
                      fill="url(#grad)"
                      initial={{ pathLength: 0, opacity: 0 }}
                      animate={{ pathLength: 1, opacity: 1 }}
                      transition={{ duration: 2, ease: "easeInOut" }}
                    />
                    <motion.path 
                      d="M0,80 Q50,70 100,75 T200,60 T300,80 T400,50" 
                      fill="none" 
                      stroke={sensorData.graphColor} 
                      strokeWidth="4" 
                      strokeLinecap="round"
                      initial={{ pathLength: 0 }}
                      animate={{ pathLength: 1 }}
                      transition={{ duration: 2, ease: "easeInOut" }}
                    />
                    {/* Points */}
                    {[0, 100, 200, 300, 400].map((x, i) => {
                      const y = [80, 75, 60, 80, 50][i];
                      return (
                        <motion.circle 
                          key={i}
                          cx={x} 
                          cy={y} 
                          r="4" 
                          fill="white" 
                          stroke={sensorData.graphColor}
                          strokeWidth="2"
                          initial={{ scale: 0 }}
                          animate={{ scale: 1 }}
                          transition={{ delay: 1 + i * 0.2 }}
                        />
                      );
                    })}
                  </svg>
                  {/* X-Axis Labels */}
                  <div className="flex justify-between mt-6 text-[10px] text-[#0A5C71]/40 font-black uppercase tracking-tighter">
                    <span>8 AM</span><span>12 PM</span><span>4 PM</span><span>8 PM</span><span>12 AM</span><span>4 AM</span>
                  </div>
                </div>
              </div>

              <p className="text-center text-xs font-bold text-[#0A5C71]/60">Last updated : 15 minutes ago</p>

              {/* Action Buttons */}
              <div className="grid grid-cols-2 gap-4">
                <button 
                  onClick={() => setCurrentScreen('refreshing')}
                  className="flex flex-col items-center justify-center gap-2 p-4 bg-white/60 rounded-2xl border border-[#0A5C71]/10 shadow-sm active:scale-95 transition-transform"
                >
                  <RefreshCw size={24} className="text-[#0A5C71]" />
                  <span className="text-xs font-bold text-[#0A5C71]">Refresh</span>
                </button>
                <button className="flex flex-col items-center justify-center gap-2 p-4 bg-white/60 rounded-2xl border border-[#0A5C71]/10 shadow-sm active:scale-95 transition-transform">
                  <Upload size={24} className="text-[#0A5C71]" />
                  <span className="text-xs font-bold text-[#0A5C71]">Export</span>
                </button>
              </div>
            </div>
          </div>
        );

      case 'settings':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="sticky top-0 z-[110] bg-[#F0F9FA] -mx-6 px-6 pt-12 pb-4 flex justify-between items-center mb-6 shadow-md">
              <button onClick={() => setCurrentScreen('home')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="text-3xl font-black text-[#0A5C71] tracking-tighter">Settings</h2>
              <button 
                onClick={() => setCurrentScreen('refreshing')}
                className="w-10 h-10 bg-white rounded-full flex items-center justify-center text-[#0A5C71] shadow-lg transition-all active:scale-95"
              >
                <RefreshCw size={20} />
              </button>
            </div>
            
            <div className="space-y-4 flex-1 relative z-10">
              <button 
                onClick={() => setCurrentScreen('personal_info')}
                className="w-full bg-white/80 backdrop-blur-md p-5 rounded-[24px] border border-white/50 flex items-center justify-between shadow-xl group hover:translate-y-[-2px] transition-all duration-300"
              >
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-cyan-100 rounded-2xl flex items-center justify-center text-cyan-500 shadow-inner">
                    <User size={24} />
                  </div>
                  <span className="font-black text-[#0A5C71] uppercase tracking-widest text-xs">Personal Information</span>
                </div>
                <ChevronLeft size={20} className="rotate-180 text-[#0A5C71]/30" />
              </button>

              <button 
                onClick={() => setCurrentScreen('region_language')}
                className="w-full bg-white/80 backdrop-blur-md p-5 rounded-[24px] border border-white/50 flex items-center justify-between shadow-xl group hover:translate-y-[-2px] transition-all duration-300"
              >
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-orange-100 rounded-2xl flex items-center justify-center text-orange-500 shadow-inner">
                    <Globe size={24} />
                  </div>
                  <span className="font-black text-[#0A5C71] uppercase tracking-widest text-xs">Region & Languages</span>
                </div>
                <ChevronLeft size={20} className="rotate-180 text-[#0A5C71]/30" />
              </button>

              <button className="w-full bg-white/80 backdrop-blur-md p-5 rounded-[24px] border border-white/50 flex items-center justify-between shadow-xl group hover:translate-y-[-2px] transition-all duration-300">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-yellow-100 rounded-2xl flex items-center justify-center text-yellow-500 shadow-inner">
                    <Star size={24} />
                  </div>
                  <span className="font-black text-[#0A5C71] uppercase tracking-widest text-xs">Rate The App</span>
                </div>
                <ChevronLeft size={20} className="rotate-180 text-[#0A5C71]/30" />
              </button>

              <button className="w-full bg-white/80 backdrop-blur-md p-5 rounded-[24px] border border-white/50 flex items-center justify-between shadow-xl group hover:translate-y-[-2px] transition-all duration-300">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-purple-100 rounded-2xl flex items-center justify-center text-purple-500 shadow-inner">
                    <Mail size={24} />
                  </div>
                  <span className="font-black text-[#0A5C71] uppercase tracking-widest text-xs">Contact US</span>
                </div>
                <ChevronLeft size={20} className="rotate-180 text-[#0A5C71]/30" />
              </button>
            </div>

            <div className="mt-auto relative z-10">
              <button 
                onClick={() => setCurrentScreen('signin')}
                className="w-full py-5 bg-white/80 backdrop-blur-md border border-white/50 text-[#EF4444] text-xl font-black rounded-[24px] shadow-xl hover:bg-red-50 transition-all uppercase tracking-widest"
              >
                Log Out
              </button>
            </div>
          </div>
        );

      case 'personal_info':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="flex items-center mb-10 pt-2 relative z-10">
              <button onClick={() => setCurrentScreen('settings')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-3xl font-black text-[#0A5C71] text-center pr-7 tracking-tighter">Personal Info</h2>
            </div>
            
            <div className="space-y-8 flex-1 relative z-10">
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl space-y-8">
                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-black text-[#0A5C71]/40 uppercase tracking-widest">Full Name</span>
                    <span className="text-lg font-black text-[#0A5C71]">Mayar Ahmed</span>
                  </div>
                  <div className="w-full h-[1px] bg-[#0A5C71]/10" />
                </div>

                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex flex-col">
                      <span className="text-sm font-black text-[#0A5C71]/40 uppercase tracking-widest">Email Address</span>
                      <span className="text-lg font-black text-[#0A5C71]">mayar61134@gmail.com</span>
                    </div>
                    <button className="w-10 h-10 bg-[#0A5C71]/5 rounded-full flex items-center justify-center text-[#0A5C71] hover:bg-[#0A5C71]/10 transition-colors">
                      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" /></svg>
                    </button>
                  </div>
                  <div className="w-full h-[1px] bg-[#0A5C71]/10" />
                </div>

                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex flex-col">
                      <span className="text-sm font-black text-[#0A5C71]/40 uppercase tracking-widest">Password</span>
                      <span className="text-lg font-black text-[#0A5C71]">••••••••</span>
                    </div>
                    <button className="w-10 h-10 bg-[#0A5C71]/5 rounded-full flex items-center justify-center text-[#0A5C71] hover:bg-[#0A5C71]/10 transition-colors">
                      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" /></svg>
                    </button>
                  </div>
                  <div className="w-full h-[1px] bg-[#0A5C71]/10" />
                </div>
              </div>
            </div>

            <div className="mt-auto relative z-10">
              <button 
                onClick={() => setCurrentScreen('reset_account')}
                className="w-full py-5 bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] text-white text-xl font-black rounded-[24px] shadow-xl hover:scale-[1.02] active:scale-95 transition-all uppercase tracking-widest"
              >
                Reset Account
              </button>
            </div>
          </div>
        );

      case 'reset_account':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="flex items-center mb-10 pt-2 relative z-10">
              <button onClick={() => setCurrentScreen('personal_info')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-3xl font-black text-[#0A5C71] text-center pr-7 tracking-tighter">Reset Account</h2>
            </div>
            
            <div className="space-y-8 flex-1 relative z-10">
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl space-y-6">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <label className="text-[10px] font-black text-[#0A5C71]/40 uppercase tracking-widest ml-1">First Name</label>
                    <input type="text" placeholder="Mayar" className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 text-[#0A5C71] font-bold focus:bg-white focus:border-[#0A5C71]/20 focus:outline-none transition-all" />
                  </div>
                  <div className="space-y-2">
                    <label className="text-[10px] font-black text-[#0A5C71]/40 uppercase tracking-widest ml-1">Last Name</label>
                    <input type="text" placeholder="Ahmed" className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 text-[#0A5C71] font-bold focus:bg-white focus:border-[#0A5C71]/20 focus:outline-none transition-all" />
                  </div>
                </div>

                <div className="space-y-2">
                  <label className="text-[10px] font-black text-[#0A5C71]/40 uppercase tracking-widest ml-1">Change Email</label>
                  <input type="email" placeholder="mayar61134@gmail.com" className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 text-[#0A5C71] font-bold focus:bg-white focus:border-[#0A5C71]/20 focus:outline-none transition-all" />
                </div>

                <div className="space-y-2">
                  <label className="text-[10px] font-black text-[#0A5C71]/40 uppercase tracking-widest ml-1">Change Password</label>
                  <input type="password" placeholder="••••••••" className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 text-[#0A5C71] font-bold focus:bg-white focus:border-[#0A5C71]/20 focus:outline-none transition-all" />
                </div>
              </div>
            </div>

            <div className="mt-auto relative z-10">
              <button 
                onClick={() => setCurrentScreen('personal_info')}
                className="w-full py-5 bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] text-white text-xl font-black rounded-[24px] shadow-xl hover:scale-[1.02] active:scale-95 transition-all uppercase tracking-widest"
              >
                Reset
              </button>
            </div>
          </div>
        );

      case 'region_language':
        return (
          <div className="flex flex-col min-h-full font-sans pb-32 relative overflow-hidden px-6">
            {/* Background Decorations */}
            <div className="absolute top-20 right-[-30px] opacity-20 pointer-events-none">
              <div className="w-64 h-64 bg-[#4ECDC4] rounded-full blur-[80px]" />
            </div>
            <div className="absolute bottom-40 left-[-30px] opacity-20 pointer-events-none">
              <div className="w-48 h-48 bg-[#FFE66D] rounded-full blur-[60px]" />
            </div>

            {/* Header */}
            <div className="flex items-center mb-10 pt-2 relative z-10">
              <button onClick={() => setCurrentScreen('settings')} className="text-[#0A5C71]">
                <ChevronLeft size={28} />
              </button>
              <h2 className="flex-1 text-3xl font-black text-[#0A5C71] text-center pr-7 tracking-tighter">Region & Language</h2>
            </div>
            
            <div className="space-y-6 flex-1 relative z-10">
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-[32px] border border-white/50 shadow-xl space-y-8">
                <div className="space-y-4">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-cyan-100 rounded-xl flex items-center justify-center text-cyan-500 shadow-inner">
                      <Globe size={20} />
                    </div>
                    <span className="text-sm font-black text-[#0A5C71]/40 uppercase tracking-widest">Offer Region</span>
                  </div>
                  
                  <button className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 flex items-center justify-between text-[#0A5C71] font-bold hover:bg-white hover:border-[#0A5C71]/10 transition-all">
                    <span>United Kingdom (UK)</span>
                    <ChevronLeft size={18} className="-rotate-90 opacity-30" />
                  </button>
                </div>

                <div className="space-y-4">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-orange-100 rounded-xl flex items-center justify-center text-orange-500 shadow-inner">
                      <Globe size={20} />
                    </div>
                    <span className="text-sm font-black text-[#0A5C71]/40 uppercase tracking-widest">Choose Language</span>
                  </div>
                  
                  <button className="w-full h-14 bg-[#0A5C71]/5 border border-transparent rounded-2xl px-5 flex items-center justify-between text-[#0A5C71] font-bold hover:bg-white hover:border-[#0A5C71]/10 transition-all">
                    <span>English (US)</span>
                    <ChevronLeft size={18} className="-rotate-90 opacity-30" />
                  </button>
                </div>
              </div>
            </div>
            
            <div className="mt-auto relative z-10">
              <button 
                onClick={() => setCurrentScreen('settings')}
                className="w-full py-5 bg-gradient-to-r from-[#0A5C71] to-[#1CA3C6] text-white text-xl font-black rounded-[24px] shadow-xl hover:scale-[1.02] active:scale-95 transition-all uppercase tracking-widest"
              >
                Save Changes
              </button>
            </div>
          </div>
        );
    }
  };

  return (
    <div className="min-h-screen bg-[#0A5C71] flex items-center justify-center p-4 relative overflow-hidden">
      {/* Animated Background Blobs */}
      <motion.div 
        animate={{ 
          scale: [1, 1.2, 1],
          x: [0, 50, 0],
          y: [0, -30, 0]
        }}
        transition={{ duration: 10, repeat: Infinity, ease: "easeInOut" }}
        className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-[#1CA3C6] rounded-full blur-[120px] opacity-30"
      />
      <motion.div 
        animate={{ 
          scale: [1, 1.3, 1],
          x: [0, -40, 0],
          y: [0, 60, 0]
        }}
        transition={{ duration: 12, repeat: Infinity, ease: "easeInOut" }}
        className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-[#9CE3F5] rounded-full blur-[150px] opacity-20"
      />

      {/* Mobile Device Mockup Container */}
      <div className="relative w-full max-w-[400px] h-[850px] bg-gradient-to-br from-[#e6f7fc] via-[#f0fbff] to-[#9ce3f5] rounded-[40px] shadow-[0_50px_100px_rgba(0,0,0,0.3)] overflow-hidden border-[8px] border-gray-900">
        
        {/* Internal Colorful Blobs */}
        <div className="absolute top-[10%] left-[-20%] w-64 h-64 bg-[#1CA3C6]/10 rounded-full blur-3xl pointer-events-none" />
        <div className="absolute bottom-[20%] right-[-20%] w-80 h-80 bg-[#9CE3F5]/20 rounded-full blur-3xl pointer-events-none" />
        <div className="absolute top-[40%] right-[-10%] w-40 h-40 bg-[#0A5C71]/5 rounded-full blur-2xl pointer-events-none" />

        {/* Status Bar Mock */}
        <div className="absolute top-0 w-full h-12 flex justify-between items-center px-6 text-[#0A5C71] text-sm font-sans font-medium z-[150] bg-[#F0F9FA]/90 backdrop-blur-md rounded-t-[40px]">
          <span>9:41</span>
          <div className="flex gap-2 items-center">
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 21.5c-3.31 0-6-2.69-6-6 0-3.07 3.47-8.88 5.65-12.31.16-.25.54-.25.7 0 2.18 3.43 5.65 9.24 5.65 12.31 0 3.31-2.69 6-6 6z"/></svg>
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4C7.31 4 3.07 5.9 0 8.98L12 21 24 8.98C20.93 5.9 16.69 4 12 4z"/></svg>
            <div className="w-6 h-3 border border-current rounded-sm p-[1px]"><div className="w-full h-full bg-current rounded-sm"></div></div>
          </div>
        </div>

        {/* Scrollable Content */}
        <div className="w-full h-full relative no-scrollbar">
          <div className="w-full h-full overflow-y-auto pt-16 no-scrollbar">
            {renderScreen()}
          </div>
          {/* Fixed Bottom Navigation */}
          {['home', 'history', 'sensors', 'settings', 'personal_info', 'reset_account', 'region_language', 'analyzing', 'refreshing'].includes(currentScreen) && (
            <BottomNav 
              current={
                ['personal_info', 'reset_account', 'region_language'].includes(currentScreen) 
                  ? 'settings' 
                  : currentScreen === 'analyzing' || currentScreen === 'refreshing' 
                    ? 'home' 
                    : currentScreen
              } 
              onNavigate={setCurrentScreen} 
            />
          )}
        </div>

        {/* Home Indicator Mock */}
        <div className="absolute bottom-2 left-1/2 -translate-x-1/2 w-32 h-1.5 bg-gray-800 rounded-full z-10"></div>
      </div>

      {/* Info Panel */}
      <div className="absolute top-4 right-4 max-w-sm bg-gray-800 text-white p-6 rounded-xl shadow-xl border border-gray-700 font-sans">
        <h3 className="text-lg font-bold mb-2 text-[#9ce3f5]">Connection Flow Added!</h3>
        <p className="text-sm text-gray-300 mb-4">
          I have added the 4-screen connection flow. After signing in, you will be taken to "Preparing Sensors", then "Connect Device", "Scan Devices", and finally "Analyzing Water".
        </p>
        <ul className="text-sm text-gray-400 list-disc pl-4 space-y-1">
          <li>lib/preparing_sensors.dart</li>
          <li>lib/connect_device.dart</li>
          <li>lib/scan_devices.dart</li>
          <li>lib/analyzing_water.dart</li>
          <li>lib/widgets/custom_bottom_nav.dart</li>
        </ul>
        <button 
          onClick={() => setCurrentScreen('splash')}
          className="mt-4 w-full py-2 bg-[#0A5C71] text-white rounded-lg hover:bg-[#084a5a] transition-colors text-sm font-bold"
        >
          Restart App Flow
        </button>
      </div>
    </div>
  );
}
