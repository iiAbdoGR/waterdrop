/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import { useState } from 'react';

export default function App() {
  const [isSignIn, setIsSignIn] = useState(true);

  return (
    <div className="min-h-screen bg-gray-900 flex items-center justify-center p-4 font-serif">
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
        <div className="w-full h-full overflow-y-auto pt-16 pb-8 px-6 no-scrollbar">
          
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
                  <a href="#" className="text-xl italic text-[#0A5C71] underline decoration-1 underline-offset-4">
                    Forgot Password ?
                  </a>
                </div>
                <div className="flex items-center gap-3 pt-4">
                  <div className="w-6 h-6 border-[1.5px] border-[#0A5C71] rounded-sm"></div>
                  <span className="text-xl italic text-[#0A5C71]">Remember Me</span>
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
          <div className="mt-6 text-center">
            <p className="text-[#0A5C71] italic text-sm">
              {isSignIn ? 'Not a member ? ' : 'Already have an account ? '}
              <button 
                onClick={() => setIsSignIn(!isSignIn)}
                className="font-bold underline decoration-2 underline-offset-2 hover:text-[#084a5a]"
              >
                {isSignIn ? 'Sign Up' : 'Sign In'}
              </button>
            </p>
          </div>

          {/* Home Indicator Mock */}
          <div className="absolute bottom-2 left-1/2 -translate-x-1/2 w-32 h-1.5 bg-gray-800 rounded-full"></div>
        </div>
      </div>

      {/* Info Panel */}
      <div className="absolute top-4 right-4 max-w-sm bg-gray-800 text-white p-6 rounded-xl shadow-xl border border-gray-700 font-sans">
        <h3 className="text-lg font-bold mb-2 text-[#9ce3f5]">Flutter Code Generated!</h3>
        <p className="text-sm text-gray-300 mb-4">
          I have created the requested Flutter `.dart` files in the <code className="bg-gray-900 px-1 py-0.5 rounded text-[#9ce3f5]">lib/</code> directory of this project.
        </p>
        <ul className="text-sm text-gray-400 list-disc pl-4 space-y-1">
          <li>lib/main.dart</li>
          <li>lib/sign_in.dart</li>
          <li>lib/sign_up.dart</li>
        </ul>
        <p className="text-sm text-gray-300 mt-4">
          You can download the project files from the editor to use them in your local Flutter environment. The interactive preview here is a React replica so you can see the design!
        </p>
      </div>
    </div>
  );
}
