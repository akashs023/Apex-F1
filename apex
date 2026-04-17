<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>F1 2026 | New Era Live Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Racing+Sans+One&display=swap');
        
        :root {
            --f1-red: #ff1801;
            --neon-blue: #00f0ff;
            --glass-bg: rgba(20, 20, 25, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: radial-gradient(circle at top right, #1a0b2e, #050505, #001220);
            background-attachment: fixed;
            color: #ffffff;
            min-height: 100vh;
        }
        
        h1, h2, h3, .f1-font {
            font-family: 'Racing Sans One', cursive;
            letter-spacing: 1.5px;
        }

        /* Glassmorphism & Vibrant Elements */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
        }
        
        .glass-card:hover {
            border-color: rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(255, 24, 1, 0.15);
        }

        .text-gradient {
            background: linear-gradient(to right, #ff1801, #ff8a00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .neon-border {
            border-left: 4px solid var(--f1-red);
            box-shadow: -4px 0px 15px -3px rgba(255, 24, 1, 0.5);
        }

        /* Chart Container Strict Requirements */
        .chart-container {
            position: relative;
            width: 100%;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
            height: 380px;
            max-height: 450px;
        }
        @media (max-width: 768px) {
            .chart-container { height: 300px; max-height: 350px; }
        }

        /* View Switching Logic */
        .view-section { display: none; opacity: 0; transform: translateY(10px); transition: all 0.4s ease-out; }
        .view-section.active { display: block; opacity: 1; transform: translateY(0); }

        /* Custom Vibrant Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: rgba(0,0,0,0.2); }
        ::-webkit-scrollbar-thumb { background: linear-gradient(to bottom, #ff1801, #ff8a00); border-radius: 10px; }

        .pulse-dot {
            height: 8px; width: 8px; background-color: var(--f1-red); border-radius: 50%; display: inline-block;
            box-shadow: 0 0 10px var(--f1-red); animation: pulse 1.5s infinite;
        }
        @keyframes pulse { 0% { opacity: 1; box-shadow: 0 0 10px var(--f1-red); } 50% { opacity: 0.4; box-shadow: 0 0 2px var(--f1-red); } 100% { opacity: 1; box-shadow: 0 0 10px var(--f1-red); } }
    </style>
</head>
<body class="antialiased selection:bg-red-500 selection:text-white">

    <!-- Application Structure Plan: High-energy SPA dashboard. Uses glassmorphism against a dark gradient to make the data pop. The architecture remains tab-based for instant navigation, ideal for real-time race data consumption. Content is updated to simulate the highly anticipated 2026 engine regulation era. -->
    <!-- Visualization & Content Choices: 
        1. Standings -> Vibrant Bar Chart (Chart.js) -> Team-colored bars with tooltips for visual dominance.
        2. Dashboard -> Glowing Countdown + Top 3 list -> High impact entry point.
        3. News Feed -> Interactive Cards -> Simulates social media with emojis instead of SVGs.
        4. A-Z -> Real-time Search List -> For the new 2026 technical terminology.
    -->
    <!-- CONFIRMATION: NO SVG graphics used. NO Mermaid JS used. -->

    <!-- Navigation -->
    <nav class="glass-card sticky top-0 z-50 border-b border-white/10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20">
                <div class="flex-shrink-0 flex items-center cursor-pointer" onclick="switchTab('home')">
                    <span class="text-4xl mr-3 drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]">🏎️</span>
                    <div class="flex flex-col">
                        <span class="f1-font text-3xl text-white tracking-widest leading-none">APEX <span class="text-[#ff1801]">F1</span></span>
                        <span class="text-[10px] text-cyan-400 font-bold tracking-[0.2em] uppercase">2026 New Era</span>
                    </div>
                </div>
                <div class="hidden md:flex space-x-2">
                    <button onclick="switchTab('home')" id="nav-home" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg bg-white/10 text-white transition-all shadow-[0_0_15px_rgba(255,24,1,0.3)] border border-[#ff1801]">Dashboard</button>
                    <button onclick="switchTab('schedule')" id="nav-schedule" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-all">Schedule</button>
                    <button onclick="switchTab('results')" id="nav-results" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-all">Results</button>
                    <button onclick="switchTab('standings')" id="nav-standings" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-all">Standings</button>
                    <button onclick="switchTab('news')" id="nav-news" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-all">Paddock Feed</button>
                    <button onclick="switchTab('az')" id="nav-az" class="nav-btn px-4 py-2 text-sm font-bold uppercase rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-all">Glossary</button>
                </div>
            </div>
        </div>
        <!-- Mobile Nav -->
        <div class="md:hidden flex overflow-x-auto p-3 space-x-3 bg-black/40 backdrop-blur-md">
            <button onclick="switchTab('home')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-gradient-to-r from-[#ff1801] to-[#ff8a00] rounded-full text-white shadow-lg whitespace-nowrap">Dashboard</button>
            <button onclick="switchTab('schedule')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-white/5 rounded-full text-gray-300 whitespace-nowrap">Schedule</button>
            <button onclick="switchTab('results')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-white/5 rounded-full text-gray-300 whitespace-nowrap">Results</button>
            <button onclick="switchTab('standings')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-white/5 rounded-full text-gray-300 whitespace-nowrap">Standings</button>
            <button onclick="switchTab('news')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-white/5 rounded-full text-gray-300 whitespace-nowrap">Feed</button>
            <button onclick="switchTab('az')" class="nav-btn px-4 py-2 text-xs font-bold uppercase bg-white/5 rounded-full text-gray-300 whitespace-nowrap">A-Z</button>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 py-10">

        <!-- 1. DASHBOARD VIEW -->
        <section id="view-home" class="view-section active">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Hero Countdown -->
                <div class="lg:col-span-2 glass-card rounded-2xl p-8 md:p-12 relative overflow-hidden group">
                    <div class="absolute -right-20 -top-20 w-64 h-64 bg-[#ff1801] rounded-full mix-blend-screen filter blur-[100px] opacity-40 group-hover:opacity-60 transition-opacity"></div>
                    <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-[#00f0ff] rounded-full mix-blend-screen filter blur-[100px] opacity-20"></div>
                    
                    <div class="flex items-center space-x-2 mb-4 relative z-10">
                        <span class="pulse-dot"></span>
                        <h2 class="text-cyan-400 uppercase text-sm font-bold tracking-[0.2em]">Up Next • Round 6</h2>
                    </div>
                    
                    <h1 class="text-5xl md:text-7xl f1-font text-transparent bg-clip-text bg-gradient-to-r from-white to-gray-400 mb-8 relative z-10 drop-shadow-lg">
                        MIAMI <br/><span class="text-gradient">GRAND PRIX</span>
                    </h1>
                    
                    <div class="flex flex-wrap gap-4 text-center relative z-10" id="countdown">
                        <!-- JS fills this -->
                    </div>
                    
                    <div class="mt-8 pt-6 border-t border-white/10 flex justify-between items-center relative z-10">
                        <p class="text-gray-400 font-medium"><span class="text-xl mr-2">🌴</span>Miami International Autodrome</p>
                        <button onclick="switchTab('schedule')" class="text-[#ff1801] font-bold uppercase hover:text-white transition-colors flex items-center">Full Calendar <span class="ml-2">→</span></button>
                    </div>
                </div>

                <!-- Live Standings Top 3 -->
                <div class="glass-card rounded-2xl p-8 flex flex-col justify-between relative overflow-hidden">
                    <div class="absolute inset-0 bg-gradient-to-b from-[#ff1801]/10 to-transparent opacity-50"></div>
                    <div class="relative z-10">
                        <h2 class="f1-font text-2xl mb-6 neon-border pl-3">2026 TITLE FIGHT</h2>
                        <ul class="space-y-6">
                            <!-- P1 -->
                            <li class="flex justify-between items-center bg-white/5 p-4 rounded-xl border border-white/10 hover:bg-white/10 transition-colors">
                                <div class="flex items-center">
                                    <span class="font-bold text-2xl w-8 text-[#ff1801] f1-font">1</span>
                                    <div>
                                        <span class="uppercase font-bold text-lg block">L. Hamilton</span>
                                        <span class="text-xs text-gray-400 uppercase tracking-wider">Ferrari</span>
                                    </div>
                                </div>
                                <span class="text-xl font-black text-white bg-[#ff1801]/20 px-3 py-1 rounded-lg">112</span>
                            </li>
                            <!-- P2 -->
                            <li class="flex justify-between items-center bg-white/5 p-4 rounded-xl border border-white/10 hover:bg-white/10 transition-colors">
                                <div class="flex items-center">
                                    <span class="font-bold text-2xl w-8 text-gray-400 f1-font">2</span>
                                    <div>
                                        <span class="uppercase font-bold text-lg block">M. Verstappen</span>
                                        <span class="text-xs text-gray-400 uppercase tracking-wider">Red Bull Ford</span>
                                    </div>
                                </div>
                                <span class="text-xl font-black text-white bg-blue-900/40 px-3 py-1 rounded-lg">105</span>
                            </li>
                            <!-- P3 -->
                            <li class="flex justify-between items-center bg-white/5 p-4 rounded-xl border border-white/10 hover:bg-white/10 transition-colors">
                                <div class="flex items-center">
                                    <span class="font-bold text-2xl w-8 text-gray-400 f1-font">3</span>
                                    <div>
                                        <span class="uppercase font-bold text-lg block">L. Norris</span>
                                        <span class="text-xs text-gray-400 uppercase tracking-wider">McLaren</span>
                                    </div>
                                </div>
                                <span class="text-xl font-black text-white bg-orange-500/20 px-3 py-1 rounded-lg">89</span>
                            </li>
                        </ul>
                    </div>
                    <button onclick="switchTab('standings')" class="w-full mt-6 py-3 bg-gradient-to-r from-[#ff1801] to-[#cc0000] hover:shadow-[0_0_20px_rgba(255,24,1,0.5)] transition-all rounded-xl text-sm font-bold uppercase tracking-widest text-white relative z-10">View Full Standings</button>
                </div>
            </div>
        </section>

        <!-- 2. SCHEDULE VIEW -->
        <section id="view-schedule" class="view-section">
            <div class="mb-8 flex items-center justify-between">
                <div>
                    <h1 class="text-4xl f1-font neon-border pl-4">2026 CALENDAR</h1>
                    <p class="text-gray-400 mt-2 ml-5">The dawn of the active aero & sustainable fuel era.</p>
                </div>
                <div class="text-5xl opacity-50">🌍</div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="schedule-container">
                <!-- Populated by JS -->
            </div>
        </section>

        <!-- 3. RESULTS VIEW -->
        <section id="view-results" class="view-section">
            <h1 class="text-4xl f1-font mb-8 neon-border pl-4">LATEST CLASSIFICATION</h1>
            <div class="glass-card rounded-2xl overflow-hidden">
                <div class="p-8 bg-gradient-to-r from-black/60 to-black/20 border-b border-white/10 flex flex-wrap justify-between items-center gap-4">
                    <div>
                        <div class="flex items-center space-x-3 mb-2">
                            <span class="text-3xl drop-shadow-md">🇯🇵</span>
                            <h2 class="text-3xl f1-font text-white">JAPANESE GRAND PRIX</h2>
                        </div>
                        <p class="text-cyan-400 text-sm font-bold tracking-widest uppercase">Round 5 • Suzuka International Racing Course</p>
                    </div>
                    <div class="bg-[#ff1801]/20 border border-[#ff1801]/50 px-4 py-2 rounded-lg text-center">
                        <p class="text-[10px] uppercase tracking-widest text-gray-300">Fastest Lap</p>
                        <p class="font-bold text-[#ff1801]">L. Hamilton (1:29.304)</p>
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 text-xs uppercase tracking-wider">
                                <th class="p-5 font-semibold">Pos</th>
                                <th class="p-5 font-semibold">Driver</th>
                                <th class="p-5 font-semibold">Constructor</th>
                                <th class="p-5 font-semibold">Time/Gap</th>
                                <th class="p-5 font-semibold text-center">Pts</th>
                            </tr>
                        </thead>
                        <tbody class="text-sm font-medium">
                            <tr class="hover:bg-white/10 transition-colors border-b border-white/5 bg-[#ff1801]/5">
                                <td class="p-5 f1-font text-2xl text-[#ff1801]">1</td>
                                <td class="p-5 text-lg font-bold">L. HAMILTON</td>
                                <td class="p-5 text-gray-400">Ferrari</td>
                                <td class="p-5 font-mono">1:30:15.221</td>
                                <td class="p-5 text-center font-bold text-xl text-white">26</td>
                            </tr>
                            <tr class="hover:bg-white/10 transition-colors border-b border-white/5">
                                <td class="p-5 f1-font text-xl text-gray-300">2</td>
                                <td class="p-5 font-bold">M. VERSTAPPEN</td>
                                <td class="p-5 text-gray-400">Red Bull Ford</td>
                                <td class="p-5 font-mono text-gray-300">+4.122s</td>
                                <td class="p-5 text-center font-bold text-lg">18</td>
                            </tr>
                            <tr class="hover:bg-white/10 transition-colors border-b border-white/5">
                                <td class="p-5 f1-font text-xl text-gray-300">3</td>
                                <td class="p-5 font-bold">L. NORRIS</td>
                                <td class="p-5 text-gray-400">McLaren</td>
                                <td class="p-5 font-mono text-gray-300">+9.870s</td>
                                <td class="p-5 text-center font-bold text-lg">15</td>
                            </tr>
                            <tr class="hover:bg-white/10 transition-colors border-b border-white/5">
                                <td class="p-5 f1-font text-xl text-gray-400">4</td>
                                <td class="p-5 font-bold">C. LECLERC</td>
                                <td class="p-5 text-gray-400">Ferrari</td>
                                <td class="p-5 font-mono text-gray-400">+12.550s</td>
                                <td class="p-5 text-center font-bold text-lg">12</td>
                            </tr>
                            <tr class="hover:bg-white/10 transition-colors border-b border-white/5">
                                <td class="p-5 f1-font text-xl text-gray-400">5</td>
                                <td class="p-5 font-bold">N. HÜLKENBERG</td>
                                <td class="p-5 text-gray-400">Audi</td>
                                <td class="p-5 font-mono text-gray-400">+21.004s</td>
                                <td class="p-5 text-center font-bold text-lg">10</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- 4. STANDINGS VIEW -->
        <section id="view-standings" class="view-section">
            <h1 class="text-4xl f1-font mb-2 neon-border pl-4">WORLD CHAMPIONSHIP</h1>
            <p class="text-gray-400 mb-8 ml-5">Current Top 10 Driver Standings - 2026 Season</p>
            
            <div class="glass-card rounded-2xl p-6 md:p-8 mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold uppercase tracking-widest text-white/80">Points Distribution</h2>
                    <div class="px-3 py-1 bg-white/10 rounded-full text-xs font-bold text-cyan-400 border border-cyan-400/30">Live Data</div>
                </div>
                <div class="chart-container">
                    <canvas id="standingsChart"></canvas>
                </div>
            </div>
        </section>

        <!-- 5. NEWS AGGREGATOR VIEW -->
        <section id="view-news" class="view-section">
            <div class="flex flex-col md:flex-row justify-between md:items-end mb-8 gap-4">
                <div>
                    <h1 class="text-4xl f1-font neon-border pl-4">THE PADDOCK FEED</h1>
                    <p class="text-gray-400 mt-2 ml-5">Aggregated news, social media, and official announcements.</p>
                </div>
                <div class="flex gap-2">
                    <span class="bg-blue-500/20 text-blue-400 px-3 py-1 rounded-full text-xs font-bold border border-blue-500/30">#F12026</span>
                    <span class="bg-red-500/20 text-red-400 px-3 py-1 rounded-full text-xs font-bold border border-red-500/30">#NewEra</span>
                </div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="news-container">
                <!-- Populated by JS -->
            </div>
        </section>

        <!-- 6. A-Z GLOSSARY VIEW -->
        <section id="view-az" class="view-section">
            <div class="glass-card p-8 rounded-2xl mb-8 flex flex-col md:flex-row justify-between items-center gap-6 relative overflow-hidden">
                <div class="absolute right-0 top-0 w-1/2 h-full bg-gradient-to-l from-[#ff1801]/10 to-transparent"></div>
                <div class="relative z-10">
                    <h1 class="text-4xl f1-font mb-2 text-white">2026 TECH GLOSSARY</h1>
                    <p class="text-gray-400">Search terminology to understand the new active aero and power unit regulations.</p>
                </div>
                <div class="w-full md:w-1/3 relative z-10">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-xl">🔍</div>
                    <input type="text" id="azSearch" placeholder="Search (e.g., Active Aero)..." class="w-full bg-black/50 border border-white/20 rounded-xl py-3 pl-10 pr-4 text-white placeholder-gray-500 outline-none focus:border-[#ff1801] focus:ring-1 focus:ring-[#ff1801] transition-all">
                </div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4" id="az-container">
                <!-- Populated by JS -->
            </div>
        </section>

    </main>

    <footer class="border-t border-white/10 mt-16 py-10 bg-black/40 backdrop-blur-lg">
        <div class="max-w-7xl mx-auto px-4 flex flex-col items-center justify-center text-center">
            <span class="text-3xl mb-4 drop-shadow-[0_0_5px_rgba(255,255,255,0.8)]">🏁</span>
            <p class="text-gray-400 font-medium uppercase tracking-widest text-sm mb-2">Developed for Academic Purposes</p>
            <p class="text-gray-600 text-xs">Unofficial F1 Dashboard • Data simulated for 2026 season context</p>
        </div>
    </footer>

    <script>
        // --- 2026 DATA STATE ---
        const scheduleData = [
            { round: 6, name: 'Miami Grand Prix', date: '01-03 May', track: 'Miami Intl Autodrome', flag: '🇺🇸', status: 'next' },
            { round: 7, name: 'Emilia Romagna GP', date: '15-17 May', track: 'Imola Circuit', flag: '🇮🇹', status: 'upcoming' },
            { round: 8, name: 'Monaco Grand Prix', date: '22-24 May', track: 'Circuit de Monaco', flag: '🇲🇨', status: 'upcoming' },
            { round: 9, name: 'Canadian Grand Prix', date: '05-07 Jun', track: 'Circuit Gilles-Villeneuve', flag: '🇨🇦', status: 'upcoming' },
            { round: 10, name: 'Spanish Grand Prix', date: '19-21 Jun', track: 'Circuit de Barcelona-Catalunya', flag: '🇪🇸', status: 'upcoming' },
            { round: 11, name: 'Austrian Grand Prix', date: '26-28 Jun', track: 'Red Bull Ring', flag: '🇦🇹', status: 'upcoming' }
        ];

        const newsData = [
            { source: 'Instagram', icon: '📸', handle: '@lewishamilton', text: 'P1 in Suzuka! 🇯🇵 The Tifosi energy is unmatched. This 2026 car feels incredible. We keep pushing. 🐎❤️', time: '2h ago', type: 'social' },
            { source: 'F1 Official', icon: '📰', handle: 'F1.com', text: 'TECH TUESDAY: How Audi\'s innovative MGU-K approach is already paying dividends in their debut season.', time: '5h ago', type: 'official' },
            { source: 'Twitter / X', icon: '🐦', handle: '@redbullracing', text: 'Max fought hard for P2 today. The Ford power unit is showing strong reliability. Eyes forward to Miami! 🇺🇸🏁', time: '6h ago', type: 'social' },
            { source: 'F1 Official', icon: '📰', handle: 'F1.com', text: 'EXPLAINED: The new Active Aero X-Mode. How teams are utilizing the 2026 regulations to reduce drag on the straights.', time: '12h ago', type: 'official' },
            { source: 'Instagram', icon: '📸', handle: '@mclaren', text: 'Another podium for Lando! Papaya power is strong this season. 🧡🏆', time: '14h ago', type: 'social' }
        ];

        const azData = [
            { term: 'Active Aero (Z-Mode & X-Mode)', desc: 'Introduced in 2026. Z-Mode engages high downforce for corners. X-Mode flattens wings to drastically reduce drag on straights.' },
            { term: 'MGU-K', desc: 'Motor Generator Unit - Kinetic. In 2026, its electrical power output was massively increased to nearly 350kW (470bhp), matching the combustion engine.' },
            { term: '100% Sustainable Fuel', desc: 'Mandated for all 2026 power units. Drop-in fuel created from non-food biological sources or municipal waste, reducing net CO2 emissions to zero.' },
            { term: 'Manual Override (Push-to-Pass)', desc: 'A 2026 feature allowing the following car to deploy extra electrical energy up to 337km/h to aid overtaking.' },
            { term: 'Halo', desc: 'A titanium protective barrier surrounding the driver\'s head to prevent impact injuries.' },
            { term: 'Undercut', desc: 'Pitting earlier than a rival to use fresh tires to set faster lap times, aiming to pass them when they eventually pit.' },
            { term: 'Parc Fermé', desc: 'An area where cars are kept under FIA supervision. Teams cannot make major setup changes once a car is in Parc Fermé conditions.' },
            { term: 'Telemetry', desc: 'Real-time data transmitted from the car to the pit wall, monitoring PU performance, tire degradation, and active aero status.' }
        ];

        // --- NAVIGATION LOGIC ---
        let chartInstance = null;

        function switchTab(tabId) {
            // 1. Hide all views
            document.querySelectorAll('.view-section').forEach(el => {
                el.classList.remove('active');
            });
            
            // 2. Reset Nav Buttons
            document.querySelectorAll('.nav-btn').forEach(btn => {
                // Desktop styling reset
                if(btn.classList.contains('bg-white/10')) {
                    btn.className = btn.className.replace('bg-white/10 text-white shadow-[0_0_15px_rgba(255,24,1,0.3)] border border-[#ff1801]', 'text-gray-400 hover:text-white hover:bg-white/5 border border-transparent');
                }
                // Mobile styling reset
                if(btn.classList.contains('bg-gradient-to-r')) {
                    btn.className = btn.className.replace('bg-gradient-to-r from-[#ff1801] to-[#ff8a00] text-white shadow-lg', 'bg-white/5 text-gray-300');
                }
            });

            // 3. Show target view
            setTimeout(() => {
                document.getElementById(`view-${tabId}`).classList.add('active');
            }, 50); // small delay for CSS transition trigger
            
            // 4. Highlight active nav
            const desktopBtn = document.getElementById(`nav-${tabId}`);
            if(desktopBtn) {
                desktopBtn.className = desktopBtn.className.replace('text-gray-400 hover:text-white hover:bg-white/5 border border-transparent', 'bg-white/10 text-white shadow-[0_0_15px_rgba(255,24,1,0.3)] border border-[#ff1801]');
            }
            
            // Mobile active state handling based on text content since IDs are on desktop
            const mobileBtns = document.querySelectorAll('.md\\:hidden .nav-btn');
            mobileBtns.forEach(btn => {
                if(btn.textContent.toLowerCase().includes(tabId) || (tabId === 'home' && btn.textContent === 'Dashboard') || (tabId === 'news' && btn.textContent === 'Feed')) {
                    btn.className = btn.className.replace('bg-white/5 text-gray-300', 'bg-gradient-to-r from-[#ff1801] to-[#ff8a00] text-white shadow-lg');
                }
            });

            // 5. Init Chart
            if(tabId === 'standings') {
                // Small timeout allows the container to render its dimensions first before Chart.js draws
                setTimeout(initChart, 100); 
            }
        }

        // --- RENDER FUNCTIONS ---
        function renderSchedule() {
            const container = document.getElementById('schedule-container');
            container.innerHTML = scheduleData.map(race => `
                <div class="glass-card rounded-2xl p-6 border-t-2 ${race.status === 'next' ? 'border-[#ff1801] shadow-[0_-5px_15px_rgba(255,24,1,0.2)]' : 'border-transparent'} hover:-translate-y-2 transition-transform cursor-pointer group">
                    <div class="flex justify-between items-start mb-4">
                        <div class="flex flex-col">
                            <span class="text-xs font-black tracking-widest uppercase ${race.status === 'next' ? 'text-cyan-400' : 'text-gray-500'}">Round ${race.round}</span>
                            ${race.status === 'next' ? '<span class="text-[10px] bg-[#ff1801] text-white px-2 py-0.5 rounded mt-1 inline-block w-max font-bold animate-pulse">UP NEXT</span>' : ''}
                        </div>
                        <span class="text-3xl group-hover:scale-125 transition-transform origin-top-right">${race.flag}</span>
                    </div>
                    <h3 class="text-2xl f1-font mb-1 text-white group-hover:text-gradient">${race.name}</h3>
                    <p class="text-gray-400 text-sm mb-6">${race.track}</p>
                    <div class="bg-white/5 border border-white/10 px-4 py-2 rounded-lg inline-block text-sm font-bold uppercase tracking-wider text-white w-full text-center group-hover:bg-white/10 transition-colors">
                        ${race.date}
                    </div>
                </div>
            `).join('');
        }

        function renderNews() {
            const container = document.getElementById('news-container');
            container.innerHTML = newsData.map(item => `
                <div class="glass-card rounded-2xl p-6 flex flex-col h-full hover:border-white/30 transition-colors group">
                    <div class="flex items-center justify-between border-b border-white/10 pb-4 mb-4">
                        <div class="flex items-center space-x-3">
                            <div class="h-10 w-10 rounded-full bg-white/5 flex items-center justify-center text-xl border border-white/10 group-hover:border-${item.type === 'official' ? 'red-500' : 'blue-500'} transition-colors">
                                ${item.icon}
                            </div>
                            <div>
                                <p class="text-sm font-bold text-white">${item.handle}</p>
                                <p class="text-[10px] text-gray-400 uppercase tracking-wider">${item.source}</p>
                            </div>
                        </div>
                        <span class="text-xs text-gray-500 font-medium bg-black/30 px-2 py-1 rounded">${item.time}</span>
                    </div>
                    <p class="text-gray-300 leading-relaxed flex-grow text-sm md:text-base">${item.text}</p>
                    <div class="mt-4 pt-4 border-t border-white/5 flex justify-end">
                        <button class="text-gray-500 hover:text-white transition-colors text-sm font-bold uppercase flex items-center">Read <span class="ml-1">→</span></button>
                    </div>
                </div>
            `).join('');
        }

        function renderAZ(searchTerm = '') {
            const container = document.getElementById('az-container');
            const filtered = azData.filter(item => item.term.toLowerCase().includes(searchTerm.toLowerCase()));
            
            if(filtered.length === 0) {
                container.innerHTML = '<p class="text-gray-500 col-span-2 text-center py-10 bg-black/20 rounded-xl border border-white/5">No tech terms found matching your query.</p>';
                return;
            }

            container.innerHTML = filtered.map(item => `
                <div class="glass-card rounded-xl p-6 hover:border-[#ff1801]/50 transition-colors group">
                    <h3 class="text-xl f1-font text-white mb-3 group-hover:text-[#ff1801] transition-colors">${item.term}</h3>
                    <p class="text-gray-400 text-sm leading-relaxed">${item.desc}</p>
                </div>
            `).join('');
        }

        // --- CHART INITIALIZATION ---
        function initChart() {
            const ctx = document.getElementById('standingsChart').getContext('2d');
            
            // Destroy existing chart to prevent canvas overlap issues when switching tabs
            if (chartInstance) {
                chartInstance.destroy();
            }

            Chart.defaults.color = '#9ca3af';
            Chart.defaults.font.family = 'Outfit';

            chartInstance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['HAM (FER)', 'VER (RBR)', 'NOR (MCL)', 'LEC (FER)', 'RUS (MER)', 'PIA (MCL)', 'ALO (AST)', 'SAI (AUD)', 'HUL (AUD)', 'PER (RBR)'],
                    datasets: [{
                        label: 'Championship Points',
                        data: [112, 105, 89, 76, 54, 48, 33, 28, 22, 15],
                        backgroundColor: [
                            '#e80020', // Ferrari Red
                            '#001a4d', // Red Bull Dark Blue
                            '#ff8000', // McLaren Papaya
                            '#e80020', // Ferrari
                            '#00a19c', // Mercedes Teal
                            '#ff8000', // McLaren
                            '#00665e', // Aston Martin Green
                            '#ff1801', // Audi Neon Red
                            '#ff1801', // Audi Neon Red
                            '#001a4d'  // Red Bull
                        ],
                        borderColor: [
                            '#ff4d66', '#3366ff', '#ffa64d', '#ff4d66', '#33e0d8', '#ffa64d', '#00b3a4', '#ff6655', '#ff6655', '#3366ff'
                        ],
                        borderWidth: 1,
                        borderRadius: 6,
                        hoverBackgroundColor: '#ffffff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(10, 10, 15, 0.9)',
                            titleFont: { size: 14, family: 'Outfit', weight: 'bold' },
                            bodyFont: { size: 16, weight: '900', family: 'Racing Sans One' },
                            padding: 15,
                            borderColor: 'rgba(255, 255, 255, 0.1)',
                            borderWidth: 1,
                            displayColors: false,
                            callbacks: {
                                label: function(context) { return context.parsed.y + ' PTS'; }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.05)' },
                            border: { dash: [4, 4] },
                            ticks: { font: { weight: '600' } }
                        },
                        x: {
                            grid: { display: false },
                            ticks: { font: { weight: '800', size: 11 } }
                        }
                    },
                    animation: {
                        duration: 1500,
                        easing: 'easeOutQuart'
                    }
                }
            });
        }

        // --- DYNAMIC COUNTDOWN ---
        function updateCountdown() {
            // Calculate a future date (e.g., next Sunday relative to now)
            const targetDate = new Date();
            targetDate.setDate(targetDate.getDate() + (7 - targetDate.getDay()) % 7);
            targetDate.setHours(15, 0, 0, 0); // 3 PM race start

            setInterval(() => {
                const now = new Date().getTime();
                const distance = targetDate.getTime() - now;

                if (distance < 0) {
                    document.getElementById('countdown').innerHTML = '<div class="text-3xl text-f1-red font-bold animate-pulse">RACE IS LIVE!</div>';
                    return;
                }

                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                const timeBlocks = [
                    { val: days, label: 'Days' }, { val: hours, label: 'Hours' }, 
                    { val: minutes, label: 'Mins' }, { val: seconds, label: 'Secs' }
                ];

                document.getElementById('countdown').innerHTML = timeBlocks.map(block => `
                    <div class="glass-card border-white/20 p-3 md:p-5 rounded-xl min-w-[70px] md:min-w-[90px] flex flex-col items-center justify-center backdrop-blur-xl bg-black/30">
                        <span class="block text-3xl md:text-5xl f1-font text-white drop-shadow-md">${block.val.toString().padStart(2, '0')}</span>
                        <span class="text-[10px] md:text-xs text-cyan-400 font-bold uppercase tracking-widest mt-1">${block.label}</span>
                    </div>
                `).join('');
            }, 1000);
        }

        // --- INITIALIZE APP ---
        window.onload = () => {
            renderSchedule();
            renderNews();
            renderAZ();
            updateCountdown();
            
            // Set up Glossary Search listener
            document.getElementById('azSearch').addEventListener('input', (e) => {
                renderAZ(e.target.value);
            });
        };
    </script>
</body>
</html>
