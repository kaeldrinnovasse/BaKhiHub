if not game:IsLoaded() then game.Loaded:Wait() end

local ps, rs, ru, cl = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("RunService"), game:GetService("CollectionService")
repeat task.wait() until ps.LocalPlayer

local lp = ps.LocalPlayer
local function zx(t, nw)
	local fp, g = `BaKhi/Configs/StealAnEgg/{lp.Name}_Log.txt`, getgenv().__BkLq
	if not g then
		g = {pq = {}, dt = false}
		getgenv().__BkLq = g
	end
	local m, ts = (tostring(t):gsub("%s*\n%s*", " <- ")), os.date("%Y-%m-%d %H:%M:%S")
	local la = g.pq[#g.pq]
	if la and la[2] == m then
		la[1], la[3] = ts, la[3] + 1
	else
		table.insert(g.pq, {ts, m, 1})
	end
	local function wr()
		g.dt = false
		local n = nw and #g.pq or #g.pq - 1
		if n <= 0 then return end
		local b = {}
		for i = 1, n do
			local x = g.pq[i]
			b[i] = `{x[1]} | {x[2]}{x[3] > 1 and ` x{x[3]}` or ""}`
		end
		local s2 = table.concat(b, "\n") .. "\n"
		local ok = pcall(function()
			for _, x in {"BaKhi", "BaKhi/Configs", "BaKhi/Configs/StealAnEgg"} do
				if not isfolder(x) then makefolder(x) end
			end
			if appendfile and isfile(fp) then appendfile(fp, s2) else writefile(fp, (isfile(fp) and readfile(fp) or "") .. s2) end
		end)
		if ok then
			for _ = 1, n do table.remove(g.pq, 1) end
		end
	end
	if nw then
		wr()
		return
	end
	if g.dt then return end
	g.dt = true
	task.delay(2, wr)
end
local function xl(m)
	warn("[Sae] " .. m)
	zx("[Load] " .. m, true)
	pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = "BaKhi Hub", Text = m, Duration = 15}) end)
end
local es, ad, si, cy, rg, ai, er, sv, rm
do
	local o = {}
	for i, p in {"Client.EggState", "Data.Assets", "Shared.Util.AreaEggSlotIdentity", "Shared.Util.AreaEggCycle", "Shared.Modules.Ragdoll", "Shared.Util.AssetItems", "Shared.Util.EggRecords", "Shared.Save", "Shared.Remotes"} do
		local x = rs
		for n in p:gmatch("[^%.]+") do x = x and x:WaitForChild(n, 60) end
		local ok, m = x ~= nil, nil
		if ok then ok, m = pcall(require, x) end
		if not ok or m == nil then xl((x and "Load Failed: Broken " or "Load Failed: Missing ") .. p) return end
		o[i] = m
	end
	es, ad, si, cy, rg, ai, er, sv, rm = table.unpack(o, 1, 9)
end
local dr = ad.Directory or ad
do
	local t0 = os.clock()
	while true do
		task.wait(0.2)
		local c, ok, f = lp.Character, pcall(es.HasFieldSnapshot)
		local w = lp:GetAttribute("ProfileReady") ~= true and "Profile Not Ready" or not (ok and f == true) and "No Field Snapshot" or not (c and c:FindFirstChild("HumanoidRootPart")) and "No Character" or nil
		if not w then break end
		if os.clock() - t0 > 60 then xl("Load Failed: " .. w) return end
	end
end

local ge = getgenv()
if ge.__BkSae then
	if ge.__BkSae.Stop then pcall(ge.__BkSae.Stop, true) end
	ge.__BkSae.on = false
	for _, c in ge.__BkSae.cn do pcall(function() c:Disconnect() end) end
	for _, c in ge.__BkSae.tc or {} do pcall(function() c:Disconnect() end) end
	for p, v in ge.__BkSae.ta or {} do if p.Parent then pcall(function() p.CanTouch = v end) end end
	for _, c in ge.__BkSae.uc or {} do pcall(function() c:Disconnect() end) end
	for h in ge.__BkSae.uh or {} do pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end) end
	pcall(function()
		local c = require(lp.PlayerScripts.PlayerModule):GetControls()
		if rawget(c, "GetMoveVector") then c.GetMoveVector = nil end
	end)
end
local st ={on = false, g = 0, cn = {}, bl = {}, bk = {}, sl = {}, so = nil, sc = nil, n = 0, ms = "Idle", at = nil, h0 = nil, rz = 4, mr = {}, az = {}, wf = nil, wo = false, bx = false, fp = false, gr = false, gx = false, gg = 0, lx = false, lb = false, tq = false, th = 0, tx = false, tb = false, rsh = 0, pu = nil, dw = 0.3, pc = 0, ps = false, es = false, sp = {}, se = {}, pf = nil, fm = 1.15, gh = 5, gc = 0, ct = nil, sr = false, fz = false, hq = false, ta = {}, tc = {}, pi = false, bt = nil, tr = nil, uc = {}, uh = {}, uu = 0, bf = false, bo = false, bi = 0, ap = false, mq = 0, ah = false, hf = {}, ui = {}, ef = 0, hd = false, hm = false, hl = false, hg = 0, hb = false, hbl = {}, hk = 150, hr = 300, hw = 0.4, bsi = 0.6, bsq = 0, hpx = 0, hbt = 0, hx = false, ts = nil, gbd = 20, cs = nil, rtn = 0, hs = 264}
ge.__BkSae = st

local function lg(s)
	if s == st.ms then return end
	st.ms = s
	print("[Sae] " .. s)
	zx(s)
end

local xt
local function xs(n, k, m, e)
	if e ~= nil then
		zx(`[Error] {n} | {tostring(e)}`)
		if xt then pcall(function() zx(xt()) end) end
		m = m .. ": " .. ((tostring(e):match("^[^\n]*") or ""):gsub("^.-:(%d+): ", "Line %1: "))
	end
	lg(m)
	warn("[Sae] " .. n .. " Stopped: " .. m)
	task.spawn(function()
		task.wait()
		if st.nt then pcall(st.nt, n, m) end
		local t = st.ui[k]
		if t and t.v then pcall(t.Set, t, false) end
	end)
end

local function xc(c)
	c:Disconnect()
	local i = table.find(st.cn, c)
	if i then table.remove(st.cn, i) end
end

local function rt()
	local c = lp.Character
	return c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChildOfClass("Humanoid")
end

local L
local function kv() return true end

local function sp()
	local w = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	local a = w and w:FindFirstChild("Areas")
	local l = a and a:FindFirstChild("SeparationLine")
	return l and l:IsA("BasePart") and l or nil
end

local function cz()
	local w = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	local a = w and w:FindFirstChild("Areas")
	local b = a and a:FindFirstChild("EggCarryBounds")
	local g = b and b:FindFirstChild("Gameplay1")
	if not (g and g:IsA("BasePart")) then return nil end
	return g.Position.Z - g.Size.Z / 2 + 15, g.Position.Z + g.Size.Z / 2 - 15
end

local function dl()
	if workspace:GetAttribute("Event_AdminAbuse") == true then return math.huge end
	local t = workspace:GetServerTimeNow()
	local o1, n = pcall(cy.IsNightPhase, t)
	local o2, ns = pcall(cy.NightStartTime, t)
	local o3, nr = pcall(cy.NextResetTime, t)
	if not (o1 and o2 and o3) or type(ns) ~= "number" or type(nr) ~= "number" then return nil, "Cycle Read Failed" end
	if n or t - (nr - cy.ResetPeriodSeconds) < 5 then return 0 end
	return ns - t
end

local function fs()
	local l, h = sp(), rt()
	return l ~= nil and h ~= nil and l.CFrame.LookVector:Dot(h.Position - l.Position) > 0
end

local function cr()
	local ok, s = pcall(es.ReadCarryState)
	return ok and type(s) == "table" and s.IsCarrying == true
end

xt = function()
	local h = rt()
	return string.format("[State] Pos %s | Dimension %s | Carry %s/%s | Train %s | Farm %s | Halloween %s | Butterfly %s | Swap %s | Status %s", h and string.format("%d, %d, %d", math.floor(h.Position.X), math.floor(h.Position.Y), math.floor(h.Position.Z)) or "-", tostring(lp:GetAttribute("InHalloweenDimension") == true), tostring(cr()), tostring(lp:GetAttribute("HalloweenCarrying") == true), tostring(lp:GetAttribute("TrainEventPhase")), tostring(st.on), tostring(st.hd), tostring(st.bf), tostring(st.sc ~= nil), tostring(st.ms))
end

local function av(u)
	local ok, r = pcall(es.ReadFieldEgg, u)
	return ok and type(r) == "table" and (r.State == "Slot" or r.State == "Dropped")
end

local function cd()
	if os.clock() < st.ef then return {} end
	local ok, s = pcall(es.ReadFieldEggs)
	if not ok or type(s) ~= "table" then return {} end
	local o, t, ix, oc = {}, os.clock(), {}, {}
	if st.pi then
		local o3, v = pcall(sv.Await)
		ix = o3 and type(v) == "table" and type(v.Index) == "table" and v.Index or {}
		local o4, w = pcall(es.ReadOwnerEggs, lp.UserId)
		for _, x in o4 and type(w) == "table" and w or {} do
			if type(x) == "table" and type(x.AssetCategory) == "string" then oc[x.AssetCategory] = true end
		end
	end
	for _, r in s.Records or {} do
		local a = dr[r.AssetCategory]
		local wt
		if st.wf then wt = st.wf.a and r.AreaId == st.wf.a or st.wf.r and a and a.Rarity and a.Rarity._id == st.wf.r or false elseif st.pi then wt = ix[r.AssetCategory] ~= true and not oc[r.AssetCategory] elseif next(st.az) then wt = st.az[r.AreaId] == true else wt = a and a.Rarity and st.mr[a.Rarity._id] end
		if a and (r.State == "Slot" or r.State == "Dropped") and typeof(r.BoundsCFrame) == "CFrame" and (st.bl[r.Uid] or 0) < t and wt then
			o[#o + 1] = {u = r.Uid, r = r, k = tonumber(a.Rarity and a.Rarity.Rank) or 0, e = tonumber(a.EarningRate) or 0, p = r.BoundsCFrame.Position}
		end
	end
	table.sort(o, function(x, y)
		if (x.u == st.pu) ~= (y.u == st.pu) then return x.u == st.pu end
		if x.e ~= y.e then return x.e > y.e end
		return x.k > y.k
	end)
	return o
end

local gd = {[Enum.HumanoidStateType.Running] = true, [Enum.HumanoidStateType.RunningNoPhysics] = true, [Enum.HumanoidStateType.Landed] = true}

local function ct(hu)
	pcall(function() require(lp.PlayerScripts.PlayerModule):GetControls().humanoid = hu end)
end

local function ra(ch)
	local a = ch and ch:FindFirstChild("Animate")
	if not (a and a:IsA("LocalScript")) then return end
	task.spawn(function()
		a.Enabled = false
		task.wait()
		a.Enabled = true
	end)
end

local function fz(on)
	if on ~= st.fz then
		st.fz = on
		local c = lp.Character
		local a = c and c:FindFirstChild("Animate")
		if a and a:IsA("LocalScript") then a.Enabled = not on end
	end
	if not on then return end
	local _, hu = rt()
	local am = hu and hu:FindFirstChildOfClass("Animator")
	for _, t in am and am:GetPlayingAnimationTracks() or {} do pcall(function() t:Stop(0) end) end
end

local function ul()
	for _, c in st.sl do pcall(function() c:Disconnect() end) end
	table.clear(st.sl)
end

local function aq(on)
	if on and #st.tc > 0 then return end
	for _, c in st.tc do pcall(function() c:Disconnect() end) end
	table.clear(st.tc)
	if not on then
		for p, v in st.ta do
			if p.Parent then pcall(function() p.CanTouch = v end) end
		end
		table.clear(st.ta)
		return
	end
	local function np(p)
		if not p:IsA("BasePart") or st.ta[p] ~= nil then return end
		st.ta[p] = p.CanTouch
		pcall(function() p.CanTouch = false end)
		st.tc[#st.tc + 1] = p:GetPropertyChangedSignal("CanTouch"):Connect(function() if p.CanTouch then p.CanTouch = false end end)
	end
	local function tr(t)
		if not t.Parent or t:GetAttribute("Owner") == lp.Name then return end
		np(t)
		for _, d in t:GetDescendants() do np(d) end
		st.tc[#st.tc + 1] = t.DescendantAdded:Connect(np)
	end
	for _, t in cl:GetTagged("PlacedTrap") do pcall(tr, t) end
	st.tc[#st.tc + 1] = cl:GetInstanceAddedSignal("PlacedTrap"):Connect(function(t) task.defer(pcall, tr, t) end)
end

local function su(on)
	for _, c in st.uc do pcall(function() c:Disconnect() end) end
	table.clear(st.uc)
	for h in st.uh do pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end) end
	table.clear(st.uh)
	if not on then return end
	local ph = Enum.HumanoidStateType.Physics
	local function nd(d)
		if d:IsA("Motor6D") then
			if not d.Enabled then d.Enabled = true end
			st.uc[#st.uc + 1] = d:GetPropertyChangedSignal("Enabled"):Connect(function() if not d.Enabled then d.Enabled = true end end)
		elseif (d:IsA("BallSocketConstraint") or d:IsA("HingeConstraint")) and d:GetAttribute("RagdollConstraint") then
			d.Enabled = false
		elseif d:IsA("Humanoid") and not st.uh[d] then
			st.uh[d] = true
			pcall(function() d:SetStateEnabled(ph, false) end)
			st.uc[#st.uc + 1] = d.StateChanged:Connect(function(_, n) if n == ph then pcall(function() d:ChangeState(Enum.HumanoidStateType.GettingUp) end) end end)
		end
	end
	local function bc(ch)
		for _, d in ch:GetDescendants() do nd(d) end
		st.uc[#st.uc + 1] = ch.DescendantAdded:Connect(nd)
	end
	if lp.Character then bc(lp.Character) end
	st.uc[#st.uc + 1] = lp.CharacterAdded:Connect(bc)
	st.uc[#st.uc + 1] = lp:GetAttributeChangedSignal("RagdollEndTime"):Connect(function() st.uu = os.clock() + 0.5 end)
	st.uc[#st.uc + 1] = ru.Heartbeat:Connect(function()
		if os.clock() >= st.uu then return end
		local h, hu = rt()
		if not h or not hu then return end
		local v = h.AssemblyLinearVelocity
		local hv, ws = Vector3.new(v.X, 0, v.Z), hu.WalkSpeed
		if hv.Magnitude <= ws and v.Y <= 0 then return end
		if hv.Magnitude > ws then hv = hv.Unit * ws end
		h.AssemblyLinearVelocity = Vector3.new(hv.X, math.min(v.Y, 0), hv.Z)
	end)
end

local function un()
	ul()
	fz(false)
	local ch, o, c = lp.Character, st.so, st.sc
	st.so, st.sc = nil, nil
	if not (o and c and ch and o.Parent == nil and c.Parent == ch) then return end
	o.Parent = ch
	workspace.CurrentCamera.CameraSubject = o
	ct(o)
	pcall(function() c:Destroy() end)
	ra(ch)
end

local function sw()
	local ch = lp.Character
	local hu = ch and ch:FindFirstChildOfClass("Humanoid")
	if st.sc and hu == st.sc and st.sc.Parent == ch then return true end
	if st.sc then un() end
	if not hu or hu.Health <= 0 or hu.FloorMaterial == Enum.Material.Air or not gd[hu:GetState()] then return false end
	local c = hu:Clone()
	hu.Parent = nil
	c.Parent = ch
	workspace.CurrentCamera.CameraSubject = c
	ct(c)
	ra(ch)
	st.so, st.sc, st.at = hu, c, nil
	local a, b = hu:FindFirstChildOfClass("Animator"), c:FindFirstChildOfClass("Animator")
	if a and b then
		st.sl[#st.sl + 1] = a.AnimationPlayed:Connect(function(k)
			if not k.Animation or c.Parent == nil then return end
			local ok, t = pcall(function() return b:LoadAnimation(k.Animation) end)
			if not ok or not t then return end
			pcall(function()
				t.Priority, t.Looped = k.Priority, k.Looped
				t:Play(0.05, math.max(k.WeightTarget, 0.01), k.Speed)
			end)
			local s
			s = k.Stopped:Connect(function()
				s:Disconnect()
				pcall(function() t:Stop(0.1) end)
			end)
		end)
	end
	st.sl[#st.sl + 1] = c.Died:Connect(function()
		ul()
		st.so, st.sc = nil, nil
		local cc = lp.Character
		if cc and hu.Parent == nil then
			hu.Parent = cc
			workspace.CurrentCamera.CameraSubject = hu
			ct(hu)
		end
		pcall(function() c:Destroy() end)
		hu.Health = 0
	end)
	return true
end

local function ac()
	if typeof(filtergc) ~= "function" then return "Monitor Check Failed: No Filtergc" end
	if not st.at or rawget(st.at, "InitializingUntil") == nil then
		local ok, r = pcall(filtergc, "table", {Keys = {"InitializingUntil"}}, false)
		st.at = ok and type(r) == "table" and r[1] or nil
		st.h0 = st.at and tonumber(rawget(st.at, "HistoryCount")) or nil
	end
	local t = st.at
	if not t then return "Monitor Check Failed: Monitor Not Found" end
	local h, c = tonumber(rawget(t, "HistoryCount")) or 0, rawget(t, "CorrectionReason")
	if c ~= nil then return "Monitor Active: Correction " .. tostring(c) end
	if h > (st.h0 or 0) + 2 then return "Monitor Active: Sampling" end
	return nil
end

local function gy2(p, v, up, inc)
	local pm = RaycastParams.new()
	if inc then
		pm.FilterType, pm.FilterDescendantsInstances = Enum.RaycastFilterType.Include, inc
	else
		pm.FilterType, pm.FilterDescendantsInstances, pm.RespectCanCollide = Enum.RaycastFilterType.Exclude, {lp.Character, workspace.CurrentCamera}, true
	end
	local y
	for _, o in {Vector3.zero, v.Magnitude > 0.1 and v.Unit * 6 or Vector3.zero} do
		local r = workspace:Raycast(p + o + Vector3.new(0, up, 0), Vector3.new(0, -up - 110, 0), pm)
		if r then y = math.max(y or -math.huge, r.Position.Y) end
	end
	return y and y + st.gh or p.Y
end

local function mv(tg, ck, to, cp, gf)
	local c = lp.Character
	if not rt() then return false, "Move Failed: No Character" end
	local t0, dn, wy = os.clock(), nil, nil
	local kp, kt = rt().Position, os.clock()
	local cn = ru.PreSimulation:Connect(function(d)
		if dn ~= nil then return end
		local hr, hm = rt()
		if ge.__BkSae ~= st or not (st.on or st.bo) then dn, wy = false, "Stopped" return end
		if not hr or not hm or hm.Health <= 0 or lp.Character ~= c then dn, wy = false, "Move Failed: Character Lost" return end
		fz(gf ~= nil or hm.FloorMaterial == Enum.Material.Air)
		local r = ck and ck()
		if r then dn, wy = false, r return end
		if os.clock() - t0 > to then dn, wy = false, "Move Failed: Timeout" return end
		local v, gy = tg - hr.Position, nil
		if gf == true then v, gy = Vector3.new(v.X, 0, v.Z), gy2(hr.Position, Vector3.new(v.X, 0, v.Z), 10) end
		local m = v.Magnitude
		if m <= 1 then
			hr.AssemblyLinearVelocity = Vector3.zero
			dn = true
			return
		end
		if os.clock() - kt >= 1 then
			if (hr.Position - kp).Magnitude < 2 then dn, wy = false, "Move Failed: Blocked" return end
			kp, kt = hr.Position, os.clock()
		end
		local dt, ws = math.max(d, 1 / 240), hm.WalkSpeed * (cp or 1)
		local w2 = v.Unit * math.min(ws, m / dt)
		if gy then w2 += Vector3.new(0, math.clamp((gy - hr.Position.Y) / dt * 0.2, -ws, ws), 0) end
		local fd = Vector3.new(v.X, 0, v.Z)
		if gf ~= nil and fd.Magnitude > 0.5 then hr.CFrame = CFrame.lookAt(hr.Position, hr.Position + fd) end
		hr.AssemblyLinearVelocity = w2 + Vector3.new(0, workspace.Gravity * d * 0.5, 0)
		hr.AssemblyAngularVelocity = Vector3.zero
	end)
	st.cn[#st.cn + 1] = cn
	while dn == nil do ru.Heartbeat:Wait() end
	xc(cn)
	return dn, wy
end

local function hp(en, y, rq, ck, inc)
	while true do
		if ge.__BkSae ~= st or not (st.on or st.bo) then return false, "Stopped" end
		local r = ck and ck()
		if r then return false, r end
		local hr = rt()
		if not hr then return false, "Home Failed: Character Lost" end
		if rq and not cr() then return false, "Home Failed: Egg Lost" end
		fz(true)
		local d, k = Vector3.new(en.X - hr.Position.X, 0, en.Z - hr.Position.Z), rq and st.hs or 264
		if d.Magnitude <= k then
			hr.CFrame = CFrame.new(en) * hr.CFrame.Rotation
			hr.AssemblyLinearVelocity = Vector3.zero
			return true
		end
		local nx, nz = hr.Position.X + d.Unit.X * k, hr.Position.Z + d.Unit.Z * k
		local np = Vector3.new(nx, y or gy2(Vector3.new(nx, hr.Position.Y, nz), Vector3.zero, 60, inc), nz)
		hr.CFrame = y and CFrame.new(np) * hr.CFrame.Rotation or CFrame.lookAt(np, np + d.Unit)
		hr.AssemblyLinearVelocity = Vector3.zero
		task.wait(0.1)
	end
end


local function go(e)
	local z0, z1 = cz()
	if not z0 then return false, "Fly Failed: No Corridor" end
	local h = rt()
	if not h then return false, "Fly Failed: No Character" end
	local hz = math.clamp(h.Position.Z, z0, z1)
	if hz ~= h.Position.Z then
		local ok, wy = mv(Vector3.new(h.Position.X, h.Position.Y, hz), nil, 10, nil, true)
		if not ok then return false, wy end
		h = rt()
		if not h then return false, "Fly Failed: No Character" end
	end
	local b, nt = Vector3.new(e.p.X, h.Position.Y, math.clamp(e.p.Z, z0, z1)), 0
	local u = Vector3.new(b.X - h.Position.X, 0, b.Z - h.Position.Z)
	if u.Magnitude > 7 then b -= u.Unit * 7 end
	local function ck()
		if os.clock() < nt then return nil end
		nt = os.clock() + 0.25
		if not av(e.u) then return "Fly Failed: Egg Gone" end
		local dd = dl()
		if not dd or dd < 2 then return "Fly Failed: Night Coming" end
		return nil
	end
	local _, hu = rt()
	local ok, wy = mv(b, ck, hu and (b - h.Position).Magnitude / math.max(hu.WalkSpeed * st.fm, 16) + 10 or 30, st.fm, true)
	if not ok then return false, wy end
	h = rt()
	if not h then return false, "Fly Failed: No Character" end
	local f = Vector3.new(e.p.X - h.Position.X, 0, e.p.Z - h.Position.Z)
	return mv(e.p + Vector3.new(0, 3, 0) - (f.Magnitude > 7 and f.Unit * 7 or f), ck, 10, st.fm, false)
end

local function kd()
	local ok, r = pcall(rg.IsRagdolled, lp.Character)
	if ok and r == true then return true end
	local n = tonumber(lp:GetAttribute("RagdollEndTime"))
	return n ~= nil and n > workspace:GetServerTimeNow()
end

local function tk(e)
	local k = si.LooksLikeFirstAreaUid(e.u) and si.SlotKey(e.r.AreaId, e.r.NestId) or nil
	local t0 = os.clock()
	while kd() and os.clock() - t0 < 5 do task.wait(0.1) end
	local t1 = os.clock()
	local ok, a, b = pcall(es.CarryFieldEgg, e.u, k)
	while ok and not a and ((tostring(b):find("knocked down", 1, true) and os.clock() - t0 < 6) or (tostring(b):find("Get closer", 1, true) and os.clock() - t1 < 1.5)) do
		task.wait(0.25)
		ok, a, b = pcall(es.CarryFieldEgg, e.u, k)
	end
	if ok and not a and tostring(b):find("gameplay area", 1, true) then
		local l = sp()
		local o2, r = pcall(es.ReadFieldEgg, e.u)
		local p = o2 and type(r) == "table" and typeof(r.BoundsCFrame) == "CFrame" and r.BoundsCFrame.Position
		if l and p then
			local lv = l.CFrame.LookVector
			lg(string.format("Retake Inside | Egg %d", math.floor(lv:Dot(p - l.Position))))
			if mv(p - lv * (lv:Dot(p - l.Position) - 4) + Vector3.new(0, 3, 0), nil, 5) then ok, a, b = pcall(es.CarryFieldEgg, e.u, k) end
		end
	end
	if not ok then return false, "Take Failed: " .. tostring(a) end
	if not a then return false, "Take Failed: " .. tostring(b or "Denied") end
	local t = os.clock()
	repeat task.wait() until cr() or os.clock() - t > 1
	if not cr() then return false, "Take Failed: Not Carrying" end
	st.pu = e.u
	return true
end

local function rp()
	local t0 = os.clock()
	task.wait(st.dw)
	local o1, cs = pcall(es.ReadCarryState)
	local u = o1 and type(cs) == "table" and cs.Uid
	if type(u) ~= "string" then return false, "Drop Failed: No Carry Uid" end
	local o2, a, b = pcall(es.DropFieldEgg, "PlayerRequest")
	if not o2 or not a then return false, "Drop Failed: " .. tostring(o2 and (b or "Denied") or a) end
	local t1 = os.clock()
	repeat task.wait() until not cr() or os.clock() - t1 > 1
	if cr() then return false, "Drop Failed: Still Carrying" end
	local o3, r = pcall(es.ReadFieldEgg, u)
	local ok, wy = tk({u = u, r = o3 and type(r) == "table" and r or {}})
	if not ok then return false, "Repick " .. tostring(wy) end
	lg(string.format("Relay %dms (Drop %dms, Take %dms)", (os.clock() - t0) * 1000, (t1 - t0 - st.dw) * 1000, (os.clock() - t1) * 1000))
	return true
end

local function ze()
	local w = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	local a = w and w:FindFirstChild("Areas")
	local g = a and a:FindFirstChild("GuardAreas")
	local o = {}
	if not g then return o end
	for _, z in g:GetChildren() do
		local b = z:FindFirstChild("Bounds")
		if b and b:IsA("BasePart") then o[#o + 1] = b.Position.X - b.Size.X / 2 end
	end
	table.sort(o, function(x1, x2) return x1 > x2 end)
	return o
end

local function dg()
	local l, h = sp(), rt()
	if not (l and h) then return "No Character" end
	local nd = math.huge
	for _, p in ps:GetPlayers() do
		local r = p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
		if r then nd = math.min(nd, (r.Position - h.Position).Magnitude) end
	end
	return string.format("Me %d Z %d Ragdoll %s Trapped %s Player %s", math.floor(l.CFrame.LookVector:Dot(h.Position - l.Position)), math.floor(h.Position.Z), tostring(kd()), tostring(lp.Character and lp.Character:GetAttribute("IsTrapped") == true), nd == math.huge and "None" or tostring(math.floor(nd)))
end

local function sz(z, lq, lv)
	local tf, hb = workspace:FindFirstChild("Transient"), {}
	for _, d in tf and tf:GetDescendants() or {} do
		if d.Name == "PlayerTrap" then
			local x = d:FindFirstChild("Hitbox") or d
			if x:IsA("BasePart") and d:GetAttribute("Owner") ~= lp.Name then
				local s = lv:Dot(x.Position - lq)
				if s > -40 and s < 70 then hb[#hb + 1] = {x.Position.Z, math.max(x.Size.X, x.Size.Z) / 2 + 6} end
			end
		end
	end
	if #hb == 0 then return z end
	local z0, z1 = cz()
	z0, z1 = z0 or z - 60, z1 or z + 60
	for k = 0, 60 do
		for _, c in {z + k * 3, z - k * 3} do
			if c >= z0 and c <= z1 then
				local ok = true
				for _, t in hb do
					if math.abs(c - t[1]) < t[2] then
						ok = false
						break
					end
				end
				if ok then
					if c ~= z then lg(string.format("Trap Lane %d -> %d", math.floor(z), math.floor(c))) end
					return c
				end
			end
		end
	end
	return z
end

local function hm(rq)
	local l, h = sp(), rt()
	if not l then return false, "Home Failed: No Separation Line" end
	if not h then return false, "Home Failed: No Character" end
	local lv, lq = l.CFrame.LookVector, l.Position
	local q = h.Position - lv * (lv:Dot(h.Position - lq) - 48)
	local en = Vector3.new(q.X, lq.Y + 3, sz(q.Z, lq, lv))
	if rq then
		local k = 0
		for _, x in ze() do
			if x < h.Position.X then
				k += 1
				if k % st.rz == 0 and x + 10 > en.X + 150 then
					lg("Relay At " .. math.floor(x + 10))
					local ok, wy = hp(Vector3.new(x + 10, en.Y, q.Z), nil, true)
					if not ok then return false, wy end
					ok, wy = rp()
					if not ok then return false, wy end
				end
			end
		end
	end
	local ok, wy = hp(en, nil, rq)
	if not ok then return false, wy end
	if not rq then
		task.wait(0.1)
		return mv(en - lv * 70, nil, 5)
	end
	ok, wy = rp()
	if not ok then return false, wy end
	local o1, cs = pcall(es.ReadCarryState)
	local sm = o1 and type(cs) == "table" and tonumber(cs.SpeedMultiplier) or 0.9
	local cu = o1 and type(cs) == "table" and cs.Uid
	local n0, dw2 = st.n, nil
	ok, wy = mv(en - lv * 70, function()
		if not cr() then
			dw2 = dw2 or dg()
			return "Delivered"
		end
		return nil
	end, 5, sm, false)
	if wy ~= "Delivered" and not ok then return false, wy end
	local t = os.clock()
	repeat task.wait(0.05) until (not cr() and st.n > n0) or os.clock() - t > 3
	if st.n <= n0 then
		local o2, r = pcall(es.ReadFieldEgg, cu)
		local ep = o2 and type(r) == "table" and typeof(r.BoundsCFrame) == "CFrame" and r.BoundsCFrame.Position
		return false, string.format("Home Failed: Not Claimed | %s | Egg %s %s", dw2 or dg(), o2 and type(r) == "table" and tostring(r.State) or "Gone", ep and tostring(math.floor(lv:Dot(ep - lq))) or "?")
	end
	return true
end

local function ow()
	local ok, o = pcall(es.ReadOwnerEggs, lp.UserId)
	local u, p = {}, {}
	if not ok or type(o) ~= "table" then return u, p end
	local o5, v5 = pcall(sv.Await)
	local ix = o5 and type(v5) == "table" and type(v5.Index) == "table" and v5.Index or {}
	for k, v in pairs(o) do
		if type(v) == "table" then
			local c = type(v.Placement) == "table" and v.Placement.LocalCFrame
			if typeof(c) == "CFrame" then
				p[#p + 1] = Vector2.new(c.X, c.Z)
			elseif v.Placement == nil and type(k) == "string" then
				local a, w = dr[v.AssetCategory], nil
				if st.pi and not st.ap then
					w = ix[v.AssetCategory] ~= true
				else
					w = not (st.es and a and a.Rarity and st.se[a.Rarity._id]) or (st.pi and ix[v.AssetCategory] ~= true)
				end
				if w then
					u[#u + 1] = {u = k, k = tonumber(a and a.Rarity and a.Rarity.Rank) or 0, e = tonumber(a and a.EarningRate) or 0}
				end
			end
		end
	end
	table.sort(u, function(x, y)
		if x.k ~= y.k then return x.k > y.k end
		return x.e > y.e
	end)
	return u, p
end

local function pm()
	local f = workspace:FindFirstChild("Plots")
	for _, c in f and f:GetChildren() or {} do
		local s = c:FindFirstChild("PlotSign")
		s = s and s:FindFirstChild("PlayerPlotSign")
		s = s and s:FindFirstChild("Frame")
		s = s and s:FindFirstChild("PlayerName")
		if s and s:IsA("TextLabel") and (s.Text:lower() == lp.Name:lower() or s.Text:lower() == lp.DisplayName:lower()) then return c end
	end
	return nil
end

local function pn()
	local c = pm()
	local t = c and c:FindFirstChild("ToUpdate")
	local a = t and t:FindFirstChild("StarterPen") or c and c:FindFirstChild("CenterPoint")
	if not a then return nil end
	local ok, r = pcall(function() return a:IsA("Model") and a:GetPivot() or a.CFrame end)
	return ok and r.Position or nil
end

local function tb()
	local p = pm()
	local b = p and p:FindFirstChild("TreadmillBottom")
	return b and b:IsA("BasePart") and b or nil
end

local function tm()
	local b = tb()
	if not b then return nil end
	for _, m in cl:GetTagged("ActiveTreadmill") do
		local ok, q = pcall(function() return m:IsA("Model") and m:GetPivot().Position or m.Position end)
		if ok and (q - b.Position).Magnitude < 15 then return m end
	end
	return nil
end

local function lt()
	local ok, a, b = pcall(rm.Treadmill.AskDoff.InvokeServer, rm.Treadmill.AskDoff)
	if not ok then return false, "Doff Failed: " .. tostring(a) end
	if not a then return false, "Doff Failed: " .. tostring(b or "Denied") end
	return true
end

st.bt = tm() and true or nil
do
	local ok, c = pcall(function() return rm.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a) st.bt = a end) end)
	if ok and c then st.cn[#st.cn + 1] = c end
	ok, c = pcall(function()
		return game:GetService("LogService").MessageOut:Connect(function(m)
			local r = m:match("Static treadmill entry rejected: (.-)%s*$")
			if r then st.tr = r:gsub("%f[%a]%a", string.upper) end
		end)
	end)
	if ok and c then st.cn[#st.cn + 1] = c end
end

local function mt()
	if st.bt then return true end
	st.tr = nil
	local b = tb()
	if not b then return false, "Treadmill Failed: No Treadmill" end
	local h, hu = rt()
	if not h or not hu or hu.Health <= 0 then return false, "Treadmill Failed: No Character" end
	if (b.Position - h.Position).Magnitude > 200 then return false, "Treadmill Failed: Too Far" end
	for _ = 1, 2 do
		h = rt()
		if not h then return false, "Treadmill Failed: Character Lost" end
		local ok, wy = mv(Vector3.new(b.Position.X, h.Position.Y, b.Position.Z), nil, 10)
		if not ok then return false, tostring(wy) end
		local t1 = os.clock()
		repeat task.wait(0.2) until st.bt or os.clock() - t1 > 3
		if st.bt then return true end
	end
	if st.tr == "Not Grounded" then return false, "Treadmill Failed: Not Grounded | Respawn" end
	return false, "Treadmill Failed: " .. (st.tr or "Not Mounted")
end

local function pe()
	local u, p = ow()
	if #u == 0 then return 0, "Place Skipped: Bag Empty" end
	if st.pf and #p >= st.pf then return 0, "Place Skipped: Pen Full" end
	st.pf = nil
	local a, h = pn(), rt()
	if not a then return 0, "Place Failed: No Pen" end
	if not h then return 0, "Place Failed: No Character" end
	if (h.Position - a).Magnitude > 20 then
		for _, q in {Vector3.new(h.Position.X, a.Y + 20, h.Position.Z), Vector3.new(a.X, a.Y + 20, a.Z), a + Vector3.new(0, 3, 0)} do
			local ok, wy = mv(q, nil, 15)
			if not ok then return 0, wy end
		end
	end
	local bd, n, wy = {}, 0, nil
	for _, e in u do
		if ge.__BkSae ~= st or not (st.on or st.hd) then break end
		local o1, a1, b1 = pcall(es.WearEggTool, e.u)
		if not o1 or not a1 then
			wy = "Wear Failed: " .. tostring(o1 and (b1 or "Denied") or a1)
			continue
		end
		task.wait(0.15)
		local dn = false
		for x = -24, 8, 5 do
			for z = 4, 69, 5 do
				local v, fr = Vector2.new(x, z), true
				if bd[x .. "," .. z] then fr = false end
				for _, q in p do
					if fr and (q - v).Magnitude < 5 then fr = false end
				end
				if fr then
					local o2, a2, b2 = pcall(es.PlantEgg, e.u, CFrame.new(x, -0.5, z))
					if o2 and a2 then
						p[#p + 1], n, dn = v, n + 1, true
						break
					end
					wy = "Place Failed: " .. tostring(o2 and (b2 or "Denied") or a2)
					if tostring(b2):find("too many", 1, true) then
						st.pf = #p
						pcall(es.DoffEggTool, e.u)
						return n, wy
					end
					bd[x .. "," .. z] = true
				end
			end
			if dn then break end
		end
		if not dn then
			pcall(es.DoffEggTool, e.u)
			break
		end
	end
	return n, wy
end

local function rr(c)
	local a = dr[c]
	return a and a.Rarity and a.Rarity._id or ""
end

local function sc()
	local ok, s = pcall(sv.Await)
	if not ok or type(s) ~= "table" then return {}, {} end
	local p, e = {}, {}
	if st.ps and next(st.sp) then
		local q = {}
		for _, u in ipairs(s.EquippedAssets or {}) do q[u] = true end
		for k, v in pairs(s.Inventory or {}) do
			local o, i = pcall(ai.Decode, v)
			if o and type(i) == "table" and not i.IsFavorite and not i.InFuse and not q[k] and st.sp[rr(i.Category)] then p[#p + 1] = k end
		end
	end
	if st.es and next(st.se) then
		for k, v in pairs(s.EggInventory or {}) do
			if type(v) == "table" and v.Placement == nil then
				local o, r = pcall(er.Decode, v)
				if o and type(r) == "table" and st.se[rr(r.AssetCategory)] and not (st.pi and type(s.Index) == "table" and s.Index[r.AssetCategory] ~= true) then e[#e + 1] = k end
			end
		end
	end
	return p, e
end

local function sl(p, e)
	for _, z in {{p, false}, {e, true}} do
		local l, g = z[1], z[2]
		for i = 1, #l, 512 do
			local b = table.move(l, i, math.min(i + 511, #l), 1, {})
			pcall(function() rm.PetSatchel.SellSelection:FireServer({Assets = g and {} or b, Eggs = g and b or {}}) end)
		end
	end
end

local function wp2()
	local w = workspace:FindFirstChild("World")
	local a = w and w:FindFirstChild("Areas")
	local p = a and a:FindFirstChild("WallStartCollision")
	return p and p:IsA("BasePart") and p or nil
end

local function bw2()
	local p = wp2()
	return p ~= nil and p.CanCollide
end

local function wl()
	local p, h = wp2(), rt()
	if not (p and h) then return false, "Wall Wait Failed: No Wall" end
	local lv = p.CFrame.LookVector
	local s = lv:Dot(h.Position - p.Position)
	if s < -12 or s > -3 then
		local z0, z1 = cz()
		local q = h.Position - lv * (s + 6)
		if z0 then q = Vector3.new(q.X, q.Y, math.clamp(q.Z, z0, z1)) end
		local ok, wy = mv(q, function() return not bw2() and "Wall Down" or nil end, 10, st.fm, true)
		if not ok and wy ~= "Wall Down" then return false, wy end
	end
	while bw2() do
		if ge.__BkSae ~= st or not st.on then return false, "Stopped" end
		task.wait(0.05)
	end
	return true
end

local function wq()
	local l = cd()
	if #l == 0 then return os.clock() < st.ef and "Egg Bag Full" or "No Eggs" end
	local d, h, hu = dl(), rt()
	if d and h and hu and d < math.abs(l[1].p.X - h.Position.X) / math.max(hu.WalkSpeed, 16) + 9 then return "Waiting For Day" end
	return nil
end

local function pg2(on)
	local w = workspace:FindFirstChild("World")
	local p = w and w:FindFirstChild("HalloweenDimensionPortal")
	for _, d in p and p:GetDescendants() or {} do
		if d:IsA("BasePart") and d.Name == "Hitbox" and d.CanTouch ~= on then d.CanTouch = on end
	end
end

local function lob(g)
	while not st.gr and ge.__BkSae == st do task.wait(0.1) end
	while ge.__BkSae == st and st.on and st.g == g do
		if st.sr then break end
		pg2(false)
		if (st.bx or st.lx or st.tx) and not cr() then
			if not st.fp then
				st.fp = true
				un()
				lg(st.lx and "Paused For Red Light" or st.tx and "Paused For T-Rex" or "Paused For Butterflies")
			end
			task.wait(1)
			continue
		end
		if st.fp then
			if st.bo then
				task.wait(0.5)
				continue
			end
			st.fp = false
			lg("Resuming Farm")
		end
		fz(false)
		if st.bt or tm() then
			local wy = not cr() and wq()
			if wy and not (wy == "Waiting For Day" and bw2()) then
				lg(wy .. " | On Treadmill")
				task.wait(1)
				continue
			end
			lg("Leaving Treadmill")
			local ok, wy = lt()
			if not ok then lg(tostring(wy)) end
			task.wait(1)
			continue
		end
		if not sw() then
			lg("Waiting To Swap")
			task.wait(0.2)
			continue
		end
		local r = ac()
		if r then
			st.on, st.sr = false, false
			un()
			xs("Auto Steal Egg", "ae", r)
			break
		end
		local h, hu = rt()
		if not h or not hu or hu.Health <= 0 then
			lg("Waiting For Character")
			task.wait(0.5)
			continue
		end
		if not cr() then
			local l = cd()
			if #l == 0 then
				local nm = os.clock() < st.ef and "Egg Bag Full" or "No Eggs"
				if fs() then
					lg(nm .. " | Going Home")
					hm(false)
					continue
				end
				if (st.pi or st.ap) and os.clock() >= st.pc then
					st.pc = os.clock() + 15
					lg("Placing Eggs")
					local n, wy = pe()
					lg(string.format("Placed %d%s", n, wy and (" | " .. wy) or ""))
				end
				if os.clock() >= st.mq then
					st.mq = os.clock() + 3
					lg(nm .. " | Mounting Treadmill")
					un()
					local ok, wy = mt()
					lg(ok and "Treadmill Mounted" or tostring(wy))
					continue
				end
				lg(nm)
				task.wait(1)
				continue
			end
			local e = l[1]
			local d, de = dl()
			if not d then
				lg(tostring(de))
				task.wait(1)
				continue
			end
			if d < math.abs(e.p.X - h.Position.X) / math.max(hu.WalkSpeed, 16) + 9 then
				if fs() then
					lg("Night Coming, Going Home")
					hm(false)
				elseif bw2() then
					lg("Waiting For Wall")
					local ok, wy = wl()
					lg(ok and "Wall Down" or tostring(wy))
				else
					if (st.pi or st.ap) and os.clock() >= st.pc then
						lg("Placing Eggs")
						local n, wy = pe()
						st.pc = os.clock() + 15
						lg(string.format("Placed %d%s", n, wy and (" | " .. wy) or ""))
					end
					if os.clock() >= st.mq then
						st.mq = os.clock() + 3
						lg("Waiting For Day | Mounting Treadmill")
						un()
						local ok, wy = mt()
						lg(ok and "Treadmill Mounted" or tostring(wy))
						continue
					end
					lg("Waiting For Day")
					task.wait(0.5)
				end
				continue
			end
			lg("Flying To " .. tostring(e.r.AssetCategory) .. " (" .. tostring(e.r.AreaId) .. ")")
			st.ct = os.clock()
			local ok, wy = go(e)
			if ok then
				lg("Taking " .. tostring(e.r.AssetCategory))
				ok, wy = tk(e)
			end
			if not ok then
				if tostring(wy):find("egg inventory is full", 1, true) then
					st.ef, st.pc = os.clock() + 30, 0
					lg("Egg Bag Full")
					continue
				end
				if tostring(wy):find("inventory full", 1, true) then
					lg(tostring(wy))
					task.wait(1)
					continue
				end
				if tostring(wy):find("Get closer", 1, true) then
					st.gc += 1
					lg(tostring(wy))
					if st.gc >= 2 then
						st.gc = 0
						lg("Waiting For Position Sync")
						task.wait(4)
					end
					continue
				end
				if wy == "Move Failed: Blocked" then
					st.bk[e.u] = (st.bk[e.u] or 0) + 1
					if st.bk[e.u] >= 3 then
						st.bl[e.u], st.bk[e.u] = os.clock() + 30, nil
					else
						task.wait(1)
					end
				elseif wy ~= "Stopped" and wy ~= "Move Failed: Character Lost" and wy ~= "Fly Failed: Night Coming" and not tostring(wy):find("knocked down", 1, true) then
					st.bl[e.u] = os.clock() + 30
				end
				lg(tostring(wy))
				task.wait(0.2)
				continue
			end
		end
		lg("Flying Home")
		local ok, wy = hm(true)
		if ok then
			st.pu, st.gc = nil, 0
			lg(string.format("Delivered %.1fs", st.ct and os.clock() - st.ct or 0))
			st.ct = nil
		else
			lg(tostring(wy))
			if tostring(wy):find("Get closer", 1, true) then
				st.gc += 1
				if st.gc >= 2 then
					st.gc = 0
					lg("Waiting For Position Sync")
					task.wait(4)
				end
			end
			task.wait(0.2)
		end
	end
	if not st.sr or ge.__BkSae ~= st or st.g ~= g then return end
	st.on, st.sr = false, false
	if st.fp then
		st.fp = false
		lg("Idle")
		return
	end
	if st.bt or tm() then
		lg("Leaving Treadmill")
		local ok, wy = lt()
		if not ok then lg(tostring(wy)) end
	end
	un()
	pg2(true)
	lg("Idle")
end

local function lo(g)
	local ok, e = xpcall(lob, debug.traceback, g)
	if ok or ge.__BkSae ~= st or st.g ~= g then return end
	pcall(pg2, true)
	local p = st.fp
	st.on, st.sr, st.fp = false, false, false
	if not p then
		local _, hu = rt()
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		pcall(un)
	end
	xs("Auto Steal Egg", "ae", "Farm Crashed", e)
end

local ok, c = pcall(function()
	return es.FieldClaimed:Connect(function(a)
		st.n += 1
		print("[Sae] Claimed #" .. st.n .. " " .. tostring(type(a) == "table" and a.DisplayName or a))
	end)
end)
if ok and c then st.cn[#st.cn + 1] = c end

function st.Start()
	if not kv() then lg("Key Check Failed: No Valid Key") return end
	st.sr = false
	if st.on then return end
	st.on, st.g, st.at = true, st.g + 1, nil
	task.spawn(lo, st.g)
end

function st.Stop(f)
	if st.on and not f then
		st.sr = true
		lg("Stopping After Trip")
		return
	end
	local w = st.on
	st.on, st.sr = false, false
	pg2(true)
	if not (w or f) and st.bo then return end
	local _, hu = rt()
	local t = os.clock()
	while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
	un()
	lg("Idle")
end

local bb, bw, bq = (function()
	local ok, a, b, c = pcall(function()
		local e = rs.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom
		return require(e), require(e.Swarm), require(rs.Shared.Modules.ButterflyCatalog)
	end)
	if ok then return a, b, c end
	return nil, nil, nil
end)()

pcall(function()
	st.cn[#st.cn + 1] = rm.LiveEvents.Began.OnClientEvent:Connect(function(n, d) if n == "ButterflyBloom" and type(d) == "number" then st.be = workspace:GetServerTimeNow() + d end end)
	st.cn[#st.cn + 1] = rm.LiveEvents.Ended.OnClientEvent:Connect(function(n) if n == "ButterflyBloom" then st.be = nil end end)
end)

local function ba()
	if st.be and st.be > workspace:GetServerTimeNow() then return true end
	if not bb then return false end
	local ok, a, e = pcall(function() return debug.getupvalue(bb.StartEvent, 1), debug.getupvalue(bb.StartEvent, 2) end)
	return ok and a == true and type(e) == "number" and e > workspace:GetServerTimeNow()
end

local bfl = (function()
	local ok, r = pcall(function() return require(rs.Shared.Flags.ButterflyFlags) end)
	return ok and type(r) == "table" and r or nil
end)()

local function bc()
	local t = workspace:GetServerTimeNow()
	local function tf(x)
		x = math.max(0, math.floor(x))
		return string.format("%02d:%02d", x // 60, x % 60)
	end
	if st.be and st.be > t then return "Butterfly Bloom Active: " .. tf(st.be - t) .. " Left" end
	if bb then
		local ok, a, e = pcall(function() return debug.getupvalue(bb.StartEvent, 1), debug.getupvalue(bb.StartEvent, 2) end)
		if ok and a == true and type(e) == "number" and e > t then return "Butterfly Bloom Active: " .. tf(e - t) .. " Left" end
	end
	local function fv2(k)
		local f = bfl and bfl[k]
		return type(f) == "table" and f.Value or nil
	end
	if fv2("Enabled") == false then return "Next Butterfly Bloom: Disabled" end
	local i, o = tonumber(fv2("IntervalSeconds")), tonumber(fv2("OffsetSeconds"))
	if not (i and o and i > 0) then return "Next Butterfly Bloom: Unknown" end
	return "Next Butterfly Bloom: " .. tf(o + math.ceil((t - o) / i) * i - t)
end

local function bn()
	local ok, s = pcall(sv.Await)
	local b = ok and type(s) == "table" and s.Butterflies
	if type(b) ~= "table" then return false, 0 end
	return b.NetClaimed == true, tonumber(b.TotalCaught) or 0
end

local function bv()
	for _, c in {lp.Character, lp:FindFirstChildOfClass("Backpack")} do
		for _, t in c and c:GetChildren() or {} do
			if t:IsA("Tool") and t:GetAttribute("ButterflyNet") == true then return t end
		end
	end
	return nil
end

local function bz()
	local w = workspace:FindFirstChild("World")
	local a = w and w:FindFirstChild("Areas")
	local b = a and a:FindFirstChild("ButterflyBloom")
	b = b and b:FindFirstChild("Bounds")
	return b and b:IsA("BasePart") and b or nil
end

local bs = (function()
	local ok, f = pcall(function()
		local n = require(rs.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom.Net)
		for i = 1, 40 do
			local o1, v = pcall(debug.getupvalue, n.Step, i)
			if not o1 then break end
			if type(v) == "function" and debug.info(v, "n") == "autoSwing" then
				for j = 1, 10 do
					local o2, x = pcall(debug.getupvalue, v, j)
					if not o2 then break end
					if type(x) == "number" then return function() pcall(debug.setupvalue, v, j, os.clock()) end end
				end
			end
		end
		return nil
	end)
	return ok and f or nil
end)()

local function bd2()
	local o1, r = pcall(bq.EssenceRecipe)
	local o2, s = pcall(sv.Await)
	local c = o2 and type(s) == "table" and type(s.Butterflies) == "table" and s.Butterflies.Counts
	if not o1 or type(r) ~= "table" or type(c) ~= "table" then return nil, true end
	local n, an = {}, false
	for k, v in r do
		local d = (tonumber(v) or 0) - (tonumber(c[k]) or 0)
		if d > 0 then n[k], an = d, true end
	end
	return n, an
end

local function bh(p)
	if not (p and p:IsA("ProximityPrompt")) then return end
	p:InputHoldBegin()
	task.wait(p.HoldDuration + 0.15)
	p:InputHoldEnd()
end

local function bn2()
	local wd = workspace:FindFirstChild("World")
	local mk = wd and wd:FindFirstChild("Build")
	mk = mk and mk:FindFirstChild("EnchantedTreeInterior")
	mk = mk and mk:FindFirstChild("Markers")
	local en = mk and mk:FindFirstChild("EnterTrigger")
	en = en and en:FindFirstChild("EnchantedTreeEntrance")
	local ep, ex = en and en:FindFirstChildWhichIsA("ProximityPrompt"), mk and mk:FindFirstChild("ExitTrigger")
	local ns = wd and wd:FindFirstChild("Machines")
	ns = ns and ns:FindFirstChild("ButterflyStation")
	ns = ns and ns:FindFirstChild("NetStand")
	local an, np = ns and ns:FindFirstChild("Anchor"), ns and ns:FindFirstChildWhichIsA("ProximityPrompt", true)
	if not (en and en:IsA("Attachment") and ep and ex and an and np) then return nil end
	return {en = en, ep = ep, ex = ex, an = an, np = np}
end

local function fp(a, r)
	r = tostring(r)
	return r:find(":", 1, true) and r or (a .. ": " .. r)
end

local function bd(p, ck)
	local h, hu = rt()
	if not h or not hu then return false, "No Character" end
	local a = p.en.WorldPosition
	if (h.Position - a).Magnitude > 9 then
		if dl() == 0 or bw2() then return false, "Waiting For Day" end
		if st.bt or tm() then
			lt()
			task.wait(1)
		end
		if not sw() then return false, "Swap" end
		local o2, wy = true, nil
		local z0, z1 = cz()
		if z0 and (h.Position.Z < z0 or h.Position.Z > z1) then
			o2, wy = mv(Vector3.new(h.Position.X, h.Position.Y, math.clamp(h.Position.Z, z0, z1)), ck, 10)
			h, hu = rt()
			if o2 and not (h and hu) then o2, wy = false, "No Character" end
		end
		if o2 then
			local y = math.max(h.Position.Y, a.Y) + 50
			o2, wy = hp(Vector3.new(a.X, y, a.Z - 7), y, false, ck)
			if o2 then o2, wy = hp(Vector3.new(a.X, a.Y + 1, a.Z - 7), y, false, ck) end
		end
		fz(false)
		local _, h2 = rt()
		local t = os.clock()
		while h2 and h2.Parent and h2.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		t = os.clock()
		while o2 and os.clock() - t < 8 do
			local r = ck and ck()
			if r then o2, wy = false, r end
			task.wait(0.2)
		end
		un()
		if not o2 then return false, wy end
	end
	return true
end

local function bj(p, ck)
	local ok, s = pcall(sv.Await)
	local w = ok and type(s) == "table" and s.WispCompanion
	if type(w) ~= "table" or w.Unlocked ~= true then return false, "Wisp Locked" end
	if lp:GetAttribute("InEnchantedTree") == true then return true end
	local o2, wy = bd(p, ck)
	if not o2 then return false, wy end
	bh(p.ep)
	local t = os.clock()
	repeat task.wait(0.2) until lp:GetAttribute("InEnchantedTree") == true or os.clock() - t > 6
	if lp:GetAttribute("InEnchantedTree") ~= true then return false, "Not Entered" end
	task.wait(0.5)
	return true
end

local function be(p, ck)
	local h = rt()
	if h then mv(Vector3.new(p.ex.Position.X, h.Position.Y, p.ex.Position.Z), function() if lp:GetAttribute("InEnchantedTree") ~= true then return "Left" end return ck and ck() end, 10) end
	local t = os.clock()
	repeat task.wait(0.2) until lp:GetAttribute("InEnchantedTree") ~= true or os.clock() - t > 5
	fz(false)
	return lp:GetAttribute("InEnchantedTree") ~= true
end

local function bk()
	local p = bn2()
	if not p then return false, "Net Failed: No Tree" end
	local function ck() if st.on or not st.bf then return "Stopped" end return nil end
	st.bo = true
	local ok, r = bj(p, ck)
	if not ok then st.bo = false return false, fp("Net Failed", r) end
	local h = rt()
	if not h then st.bo = false return false, "Net Failed: No Character" end
	local o2, wy = mv(Vector3.new(p.an.Position.X - 5, h.Position.Y, p.an.Position.Z), ck, 10)
	if not o2 then st.bo = false return false, fp("Net Failed", wy) end
	task.wait(0.3)
	bh(p.np)
	local t = os.clock()
	repeat task.wait(0.2) until bn() or os.clock() - t > 5
	local got = bn()
	be(p, ck)
	st.bo = false
	return got, not got and "Net Failed: Not Claimed" or nil
end

local function bu()
	if st.on then return false, "Teleport Failed: Farm Running" end
	if st.hd or st.hm or st.hx then return false, "Teleport Failed: Halloween Running" end
	if st.bo then return false, "Teleport Failed: Busy" end
	local p = bn2()
	if not p then return false, "Teleport Failed: No Tree" end
	local function ck() if st.on then return "Stopped" end return nil end
	st.bo = true
	local ok, r = bj(p, ck)
	if not ok then st.bo = false return false, fp("Teleport Failed", r) end
	local h = rt()
	if not h then st.bo = false return false, "Teleport Failed: No Character" end
	local o2, wy = mv(Vector3.new(p.an.Position.X - 5, h.Position.Y, p.an.Position.Z), ck, 10)
	fz(false)
	st.bo = false
	if not o2 then return false, fp("Teleport Failed", wy) end
	return true
end

local wqd = (function()
	local ok, r = pcall(function() return require(rs.Data.WispQuests) end)
	return ok and type(r) == "table" and r or nil
end)()

local function ws()
	local o, s = pcall(sv.Await)
	local w = o and type(s) == "table" and s.WispCompanion
	return type(w) == "table" and w or nil
end

local function wu()
	local w = ws()
	return w ~= nil and w.Unlocked == true
end

local function fi(r, ...)
	local a = table.pack(pcall(r.InvokeServer, r, ...))
	if a[1] and a[2] then return true end
	return false, tostring(a[1] and (a[3] or "Denied") or a[2])
end

local function wr(a, b)
	return fi(rm.WispCompanion.Request, a, b)
end

local function wa(id)
	local ok, r = pcall(function() return require(rs.Data.Areas) end)
	local d = ok and type(r) == "table" and (r.Directory or r)[id]
	local o = {}
	for _, x in type(d) == "table" and d.DropTable or {} do
		if type(x) == "table" and type(x[1]) == "string" then o[x[1]] = true end
	end
	return o
end

local function wp(id)
	local o, s = pcall(sv.Await)
	if not o or type(s) ~= "table" then return nil end
	local c, q, g = wa(id), {}, {}
	for _, u in ipairs(s.EquippedAssets or {}) do q[u] = true end
	for k, v in pairs(s.Inventory or {}) do
		local o2, i = pcall(ai.Decode, v)
		if o2 and type(i) == "table" and c[i.Category] and not i.IsFavorite and not i.InFuse and not i.CreatorTemporary and not q[k] then
			g[i.Category] = g[i.Category] or {}
			table.insert(g[i.Category], k)
			if #g[i.Category] >= 3 then return g[i.Category] end
		end
	end
	return nil
end

local function wz(l)
	local m = workspace:FindFirstChild("World")
	m = m and m:FindFirstChild("Machines")
	m = m and m:FindFirstChild("FuseMachine")
	m = m and m:FindFirstChild("Machine")
	if not (m and m:IsA("BasePart")) then return false, "Fuse Failed: No Machine" end
	local h = rt()
	if not h then return false, "Fuse Failed: No Character" end
	if st.bt or tm() then
		lt()
		task.wait(1)
		h = rt()
		if not h then return false, "Fuse Failed: No Character" end
	end
	local d = Vector3.new(h.Position.X - m.Position.X, 0, h.Position.Z - m.Position.Z)
	if d.Magnitude > 6 then
		st.bo = true
		local ok, wy = mv(Vector3.new(m.Position.X, h.Position.Y, m.Position.Z) + d.Unit * 5, nil, 15)
		st.bo = false
		fz(false)
		if not ok then return false, fp("Fuse Failed", wy) end
	end
	local o, s = pcall(sv.Await)
	if not o or type(s) ~= "table" then return false, "Fuse Failed: No Save" end
	if s.FusionInfoAcknowledged == false then fi(rm.Fusery.ConfirmBriefing) end
	if s.FusionEggReward then fi(rm.Fusery.FinishReveal) end
	for _, u in table.clone(type(s.FusionSlots) == "table" and s.FusionSlots or {}) do fi(rm.Fusery.EjectPet, u) end
	for _, u in l do
		local ok, wy = fi(rm.Fusery.LoadPet, u, false)
		if not ok then return false, "Fuse Failed: " .. wy end
		task.wait(0.3)
	end
	local ok, wy = fi(rm.Fusery.BeginFuse)
	if not ok then return false, "Fuse Failed: " .. wy end
	task.wait(0.6)
	ok, wy = fi(rm.Fusery.FinishReveal)
	if not ok then return false, "Fuse Reveal Failed: " .. wy end
	return true
end

local function we()
	st.wf = nil
	if not st.wo then return end
	st.wo = false
	if st.on then st.Stop() end
end

local function wt()
	local p, z = bn2(), workspace:FindFirstChild("World")
	z = z and z:FindFirstChild("Build")
	z = z and z:FindFirstChild("EnchantedForestZone")
	local a = z and z:FindFirstChild("Zone13Props")
	a = a and a:FindFirstChild("EnchantedTree")
	a = a and a:FindFirstChild("WispAnchor")
	local pr = a and a:FindFirstChild("WispTreePrompt")
	if not (p and pr) then return "Wisp Return Failed: No Tree" end
	local function ck() if st.on or not st.bf then return "Stopped" end return nil end
	st.bo = true
	local ok, wy = bd(p, ck)
	if ok then
		bh(pr)
		local t = os.clock()
		repeat task.wait(0.2) until wu() or os.clock() - t > 8
		ok, wy = wu(), "Not Unlocked"
	end
	st.bo = false
	return ok and "Wisp Unlocked" or fp("Wisp Return Failed", wy)
end

local function wd()
	local w = ws()
	if not w or not wqd then return "Wisp Failed: No State" end
	if not w.Accepted then
		local ok, m = wr("Accept")
		return ok and "Wisp Accepted" or "Wisp Accept Failed: " .. tostring(m)
	end
	local q = wqd.List[w.Stage]
	if q and not w.Claimed[q.Id] and (w.Progress[q.Id] or 0) >= q.Target then
		local ok, m = wr("Claim", q.Id)
		return ok and "Wisp Claimed | " .. q.Title or "Wisp Claim Failed: " .. tostring(m)
	end
	if q and q.Event == "EggSecured" then
		st.wf = q.Match.AreaId and {a = q.Match.AreaId} or {r = q.Match.Rarity}
		if not st.on then
			st.wo = true
			st.Start()
		end
		return string.format("Wisp Quest | %s %d/%d", q.Title, w.Progress[q.Id] or 0, q.Target)
	end
	if q and q.Event == "PetFused" then
		local l = wp(q.Match.AreaId)
		if not l then
			st.wf = {a = q.Match.AreaId}
			if not st.on then
				st.wo = true
				st.Start()
			end
			return "Wisp Quest | " .. q.Title .. " | Waiting For 3 Same Pets"
		end
		we()
		if st.on then return "Wisp | Waiting For Farm" end
		local ok, m = wz(l)
		return ok and "Wisp Fused" or tostring(m)
	end
	we()
	if st.on then return "Wisp | Waiting For Farm" end
	if q then return "Wisp Quest | " .. q.Title .. " | Not Automated" end
	if not w.Returning then
		local ok, m = wr("BeginReturn")
		return ok and "Wisp Returning" or "Wisp Return Failed: " .. tostring(m)
	end
	return wt()
end

local function gl()
	local v = workspace:GetAttribute("RLGL_Light")
	return type(v) == "string" and v or "Rise"
end

local function ge2()
	return workspace:GetAttribute("Event_RedLightGreenLight") == true and typeof(workspace:GetAttribute("RLGL_EggPosition")) == "Vector3"
end

local function gr2(ep)
	local p = workspace:GetAttribute(ep)
	if typeof(p) ~= "Vector3" then return nil end
	local ok, s = pcall(es.ReadFieldEggs)
	local b, bd = nil, 25
	for _, r in ok and type(s) == "table" and s.Records or {} do
		if typeof(r.BoundsCFrame) == "CFrame" then
			local d = (r.BoundsCFrame.Position - p).Magnitude
			if d < bd then b, bd = r, d end
		end
	end
	return b
end

local function gm(tg, sp, ck, to, gt, aj)
	local t0, dn, wy = os.clock(), nil, nil
	local cn = ru.PreSimulation:Connect(function(d)
		if dn ~= nil then return end
		local hr, hm = rt()
		if ge.__BkSae ~= st then dn, wy = false, "Stopped" return end
		if not hr or not hm or hm.Health <= 0 then dn, wy = false, "Character Lost" return end
		fz(hm.FloorMaterial == Enum.Material.Air)
		local r = ck and ck()
		if r then dn, wy = false, r return end
		if os.clock() - t0 > to then dn, wy = false, "Timeout" return end
		local g = Vector3.new(0, workspace.Gravity * d * 0.5, 0)
		hr.AssemblyAngularVelocity = Vector3.zero
		if gt and not gt() then
			hr.AssemblyLinearVelocity = g
			return
		end
		local a2 = aj and aj(hr.Position, tg)
		local v = (a2 or tg) - hr.Position
		local m = v.Magnitude
		if m <= 1 and not a2 then
			hr.AssemblyLinearVelocity = g
			dn = true
			return
		end
		hr.AssemblyLinearVelocity = v.Unit * math.min(sp(), m / math.max(d, 1 / 240)) + g
	end)
	st.cn[#st.cn + 1] = cn
	while dn == nil do ru.Heartbeat:Wait() end
	xc(cn)
	return dn, wy
end

local function gb()
	local ok, g = pcall(function() return require(rs.Data.Gears).Directory end)
	for _, c in {lp.Character, lp:FindFirstChildOfClass("Backpack")} do
		for _, t in c and c:GetChildren() or {} do
			local n = t:IsA("Tool") and t.Name:gsub("%s*%b[]$", "")
			if n and ok and type(g) == "table" and type(g[n]) == "table" and g[n].BatControllerData then return t end
		end
	end
	return nil
end

local function gh(p, gt)
	local hr, hu = rt()
	local tr = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if not (hr and tr) then return false, "No Target" end
	if (tr.Position - hr.Position).Magnitude > 14 or (gt and not gt()) then return false, "Not Ready" end
	local t = gb()
	if not t then return false, "No Bat" end
	if t.Parent ~= lp.Character and hu then
		pcall(function() hu:EquipTool(t) end)
		task.wait(0.1)
	end
	pcall(function() t:Activate() end)
	return true
end

local function gqb(g, c)
	local lm, nb = nil, 0
	local function l2(m)
		if m == lm then return end
		lm = m
		lg(m)
	end
	local function ck()
		if not c.on(g) or ge.__BkSae ~= st or not c.ev() then return "Stopped" end
		return nil
	end
	local function gm2(a, sp2, ck3, to2)
		return gm(a, sp2, ck3, to2, c.gt, c.aj)
	end
	local function own(on)
		if on then
			st.bo, st[c.fb] = true, true
			return sw()
		end
		local _, hu = rt()
		if hu then pcall(function() hu:UnequipTools() end) end
		fz(false)
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		un()
		st.bo, st[c.fb] = false, false
		return true
	end
	while ge.__BkSae == st and c.on(g) do
		st[c.fx] = c.ev()
		if st[c.fx] and c.pre then c.pre() end
		if not st[c.fx] then
			if st[c.fb] then own(false) end
			l2(c.n .. " | Waiting For Event")
			task.wait(1)
			continue
		end
		local lv0 = c.lv and lp:GetAttribute(c.lv)
		if type(lv0) == "number" and lv0 <= 0 then
			if st[c.fb] then own(false) end
			l2(c.n .. " | No Lives")
			task.wait(1)
			continue
		end
		local r = gr2(c.ep)
		local o1, cs0 = pcall(es.ReadCarryState)
		local mine = o1 and type(cs0) == "table" and cs0.IsCarrying == true and workspace:GetAttribute(c.cu) == lp.UserId
		if not st[c.fb] then
			if (cr() and not mine) or (st.on and not st.fp) or (st.bo and not st[c.fb]) then
				l2(c.n .. " | Waiting For Control")
				task.wait(0.5)
				continue
			end
			if st.bt or tm() then
				lt()
				task.wait(1)
			end
			if not own(true) then
				st.bo, st[c.fb] = false, false
				l2(c.n .. " | Waiting To Swap")
				task.wait(0.5)
				continue
			end
		end
		local _, hu = rt()
		local ws = hu and hu.WalkSpeed or 16
		if mine then
			local sm = tonumber(cs0.SpeedMultiplier) or 0.5
			local function vs() return ws * sm end
			local l, h = sp(), rt()
			if l and h then
				local lv, lq = l.CFrame.LookVector, l.Position
				local q = h.Position - lv * (lv:Dot(h.Position - lq) - 48)
				local z0, z1 = cz()
				local en = Vector3.new(q.X, lq.Y + 3, z0 and math.clamp(q.Z, z0, z1) or q.Z)
				local y = math.max(h.Position.Y, lq.Y + 45)
				local function ck2()
					local c = ck()
					if c then return c end
					if not cr() then return "Dropped" end
					return nil
				end
				l2(c.n .. " | Carrying Home")
				local ok, wy = gm2(Vector3.new(h.Position.X, y, h.Position.Z), vs, ck2, 30)
				if ok then ok, wy = gm2(Vector3.new(en.X, y, en.Z), vs, ck2, (en - h.Position).Magnitude / math.max(vs(), 8) * 3 + 30) end
				if ok then ok, wy = gm2(en, vs, ck2, 30) end
				if ok then ok, wy = gm2(en - lv * 70, vs, ck2, 40) end
				l2(ok and c.n .. " | Walked In" or c.n .. " | " .. tostring(wy))
				if not cr() then
					task.wait(2)
					if not c.ev() or not gr2(c.ep) then l2(c.n .. " Delivered") end
				end
			end
		elseif r then
			local cu = workspace:GetAttribute(c.cu)
			local cp = type(cu) == "number" and cu ~= lp.UserId and ps:GetPlayerByUserId(cu) or nil
			local function vs() return ws * st.fm end
			if cp then
				local tr = cp.Character and cp.Character:FindFirstChild("HumanoidRootPart")
				if tr then
					l2(c.n .. " | Chasing " .. cp.Name)
					gm2(tr.Position + Vector3.new(0, 2, 0), vs, function()
						local c = ck()
						if c then return c end
						local h = rt()
						if h and (tr.Position - h.Position).Magnitude <= 8 then return "Near" end
						return nil
					end, 3)
					if os.clock() >= nb and gh(cp, c.gt) then
						nb = os.clock() + 0.7
						l2(c.n .. " | Hit " .. cp.Name)
					end
				else
					task.wait(0.2)
				end
			else
				local p = r.BoundsCFrame.Position
				l2(c.n .. " | Flying To Egg")
				local h = rt()
				local ok = true
				if h and (p - h.Position).Magnitude > 60 then
					local y = math.max(h.Position.Y, p.Y) + 50
					ok = gm2(Vector3.new(h.Position.X, y, h.Position.Z), vs, ck, 20)
					if ok then ok = gm2(Vector3.new(p.X, y, p.Z), vs, ck, (p - h.Position).Magnitude / math.max(vs(), 16) * 3 + 30) end
				end
				if ok then ok = gm2(p + Vector3.new(0, 3, 0), vs, ck, 20) end
				if ok then
					while c.gt and not c.gt() and ck() == nil do task.wait(0.05) end
					l2(c.n .. " | Taking Egg")
					local o2, wy = tk({u = r.Uid, r = r})
					l2(o2 and c.n .. " | Egg Taken" or c.n .. " | " .. tostring(wy))
					local t2 = os.clock()
					while o2 and workspace:GetAttribute(c.cu) ~= lp.UserId and os.clock() - t2 < 1.5 do task.wait(0.05) end
				end
			end
		else
			l2(c.n .. " | No Egg")
			task.wait(0.5)
		end
		task.wait(0.05)
	end
	st[c.fx] = false
	if st[c.fb] then own(false) end
end

local function gq(g, c)
	local ok, e = xpcall(gqb, debug.traceback, g, c)
	if ok or ge.__BkSae ~= st or not c.on(g) then return end
	st[c.fx] = false
	if st[c.fb] then
		local _, hu = rt()
		if hu then pcall(function() hu:UnequipTools() end) end
		pcall(fz, false)
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		pcall(un)
		st.bo, st[c.fb] = false, false
	end
	xs(c.t, c.k, c.n .. " Crashed", e)
end

local lc = {t = "Auto Red Light Green Light", k = "arl", n = "Red Light", fx = "lx", fb = "lb", ep = "RLGL_EggPosition", cu = "RLGL_CarrierUserId", lv = "RLGL_Lives", ev = ge2, gt = function() return gl() == "Green" end, on = function(g) return st.gx and st.gg == g end}

local trh = (function()
	local ok, r = pcall(function() return require(rs.Shared.Modules.TrexRunHerd) end)
	return ok and type(r) == "table" and r or nil
end)()

local tw = {}

local function tw2(l)
	table.clear(tw)
	for _, w in type(l) == "table" and l or {} do
		if type(w) == "table" and type(w.Id) == "number" then tw[w.Id] = w end
	end
end

pcall(function()
	st.cn[#st.cn + 1] = rm.TrexRun.Wave.OnClientEvent:Connect(function(w)
		if type(w) == "table" and type(w.Id) == "number" then tw[w.Id] = w end
	end)
	st.cn[#st.cn + 1] = rm.TrexRun.Herd.OnClientEvent:Connect(tw2)
end)

local function te2()
	return workspace:GetAttribute("Event_TrexRun") == true and typeof(workspace:GetAttribute("TrexRun_EggPosition")) == "Vector3"
end

local function ta2(pos)
	if not trh then return nil end
	local co = trh.ReadCourse(workspace)
	if not co then return nil end
	local now = workspace:GetServerTimeNow()
	local dp, lt = trh.Locate(co, pos)
	local bad, thr, hw = {}, false, co.LaneWidth * 0.5 + 4
	for id, w in tw do
		if trh.IsExpired(w, co, now) then
			tw[id] = nil
		elseif trh.IsMoving(w, now) and type(w.Lanes) == "table" then
			local ah = (dp - trh.DepthAt(w, now)) * w.Direction
			if ah > -10 and ah < (tonumber(w.Speed) or 150) * 1.2 + 30 then
				for k in w.Lanes do
					local la = trh.TrexLateral(co, w, k)
					bad[#bad + 1] = la
					if math.abs(la - lt) < hw then thr = true end
				end
			end
		end
	end
	if not thr then return nil end
	local best, bd
	for ln = 1, co.Lanes do
		local c0 = trh.LaneOffset(co, ln)
		local ok = true
		for _, la in bad do
			if math.abs(la - c0) < hw then
				ok = false
				break
			end
		end
		if ok and (not bd or math.abs(c0 - lt) < bd) then best, bd = c0, math.abs(c0 - lt) end
	end
	if not best then return nil end
	local q = trh.Point(co, dp, best)
	return Vector3.new(q.X, pos.Y, q.Z)
end

local nf = 0

local function tp2()
	if next(tw) ~= nil or os.clock() < nf then return end
	nf = os.clock() + 3
	local ok, l = pcall(function() return rm.TrexRun.FetchHerd:InvokeServer() end)
	if ok then tw2(l) end
end

local tc2 = {t = "Auto T-Rex Run", k = "atx", n = "T-Rex", fx = "tx", fb = "tb", ep = "TrexRun_EggPosition", cu = "TrexRun_CarrierUserId", lv = nil, ev = te2, gt = nil, aj = ta2, pre = tp2, on = function(g) return st.tq and st.th == g end}

local function bgb(g)
	if not (bb and bw and bq) then xs("Auto Butterfly", "abf", "Butterfly Failed: No Module") return end
	if not kv() then lg("Key Check Failed: No Valid Key") return end
	if not bs then lg("Butterfly | Auto Swing Not Found") end
	local by, c0, nx, lw = false, 0, 0, nil
	local function ed()
		if not by then return end
		by = false
		if st.on and not st.fp then
			st.bo = false
			return
		end
		local _, hu = rt()
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		if hu then pcall(function() hu:UnequipTools() end) end
		un()
		st.bo = false
	end
	local function ck()
		if (st.on and not st.fp) or not st.bf or st.bi ~= g or not ba() then return "Stopped" end
		return nil
	end
	while ge.__BkSae == st and st.bf and st.bi == g do
		local nc, tc = bn()
		if st.lx or st.tx then
			st.bx = false
			ed()
			task.wait(1)
			continue
		end
		st.bx = nc and ba() and true or false
		if not nc and not wu() then
			ed()
			local m = wd()
			if m ~= lw then
				lw = m
				lg(m)
			end
			task.wait(1)
			continue
		end
		if st.wf or st.wo then we() end
		if st.on and not st.fp then
			by, st.bo = false, false
			task.wait(1)
			continue
		end
		if not nc then
			ed()
			lg("Claiming Net")
			local ok, wy = bk()
			lg(ok and "Net Claimed" or tostring(wy))
			task.wait(ok and 1 or 30)
			continue
		end
		if not ba() then
			ed()
			lg("Butterfly Waiting For Event")
			task.wait(1)
			continue
		end
		local nd, na = bd2()
		if not na then nd = nil end
		local b = bz()
		if not b then
			lg("Butterfly Failed: No Area")
			task.wait(5)
			continue
		end
		if not by then
			st.bo = true
			if not sw() then
				st.bo = false
				lg("Butterfly Waiting To Swap")
				task.wait(0.5)
				continue
			end
			by, c0 = true, tc
		end
		local h, hu = rt()
		if not h or not hu or hu.Health <= 0 then
			task.wait(0.5)
			continue
		end
		local o = b.CFrame:PointToObjectSpace(h.Position)
		local fr = math.max(math.abs(o.X) - b.Size.X / 2, math.abs(o.Z) - b.Size.Z / 2)
		if fr > 20 then
			if lp:GetAttribute("InEnchantedTree") == true then
				local p2 = bn2()
				lg("Leaving Tree")
				if p2 then be(p2, ck) end
				task.wait(0.5)
				continue
			end
			local dn = dl()
			if dn == 0 or bw2() or (dn and dn < (b.Position - h.Position).Magnitude / math.max(hu.WalkSpeed, 16) + 5) then
				lg("Butterfly Waiting For Day")
				task.wait(0.5)
				continue
			end
			if fr < 150 then
				hu:MoveTo(Vector3.new(b.Position.X, h.Position.Y, b.Position.Z))
				task.wait(0.2)
				continue
			end
			if st.bt or tm() then
				lg("Leaving Treadmill")
				local o3, w3 = lt()
				if not o3 then lg(tostring(w3)) end
				task.wait(1)
				continue
			end
			lg("Flying To Butterflies")
			local z0, z1 = cz()
			if z0 and (h.Position.Z < z0 or h.Position.Z > z1) then
				local ok, wy = mv(Vector3.new(h.Position.X, h.Position.Y, math.clamp(h.Position.Z, z0, z1)), ck, 10)
				h, hu = rt()
				if not ok or not h or not hu then
					lg(tostring(wy or "Move Failed: Character Lost"))
					task.wait(0.5)
					continue
				end
			end
			local y = math.max(h.Position.Y, b.Position.Y) + 50
			local ok, wy = hp(Vector3.new(b.Position.X, y, b.Position.Z), y, false, ck)
			if ok then ok, wy = hp(b.Position + Vector3.new(0, 3, 0), y, false, ck) end
			fz(false)
			if not ok then
				lg(tostring(wy))
				task.wait(0.5)
			end
			continue
		end
		fz(false)
		local t = bv()
		if t and t.Parent ~= lp.Character then pcall(function() hu:EquipTool(t) end) end
		if bs then bs() end
		local p, pk, pd, s, sk, sd = nil, -1, math.huge, nil, -1, math.huge
		local x1, xk, xd, y1, yk, yd = nil, -1, math.huge, nil, -1, math.huge
		for _, e in bw.Each() do
			local eo = typeof(e.Position) == "Vector3" and b.CFrame:PointToObjectSpace(e.Position)
			if (e.Alpha or 0) >= 0.5 and eo and math.abs(eo.X) <= b.Size.X / 2 + 10 and math.abs(eo.Z) <= b.Size.Z / 2 + 10 and type(e.Flight) == "table" then
				local m, k = (e.Position - h.Position).Magnitude, tonumber(type(e.Tier) == "table" and e.Tier.Order) or 0
				if not nd or (type(e.Tier) == "table" and nd[e.Tier.Id] ~= nil) then
					if k > pk or (k == pk and m < pd) then p, pk, pd = e, k, m end
					if m <= 13 and (k > sk or (k == sk and m < sd)) then s, sk, sd = e, k, m end
				end
				if k > xk or (k == xk and m < xd) then x1, xk, xd = e, k, m end
				if m <= 13 and (k > yk or (k == yk and m < yd)) then y1, yk, yd = e, k, m end
			end
		end
		p, s = p or x1, s or y1
		if s and os.clock() >= nx then
			nx = os.clock() + 0.5
			local id = s.Flight.Id
			task.spawn(function()
				local ok, r = pcall(function() return rm.Butterflies.AskSwing:InvokeServer(id) end)
				if ok and (r == "Caught" or r == "Gone") then pcall(bw.Remove, id) end
			end)
		end
		if p then
			local q = p.Position
			pcall(function() q = bq.PositionAt(p.Flight, workspace:GetServerTimeNow() + 0.3) end)
			local v = Vector3.new(h.Position.X - q.X, 0, h.Position.Z - q.Z)
			q = v.Magnitude > 0.1 and q + v.Unit * 11 or q
			hu:MoveTo(Vector3.new(q.X, h.Position.Y, q.Z))
		else
			hu:MoveTo(Vector3.new(b.Position.X, h.Position.Y, b.Position.Z))
		end
		lg(string.format("%s | Caught %d", nd and "Catching For Essence" or "Catching Rarest", tc - c0))
		task.wait(0.1)
	end
	st.bx = false
	ed()
	we()
end

local function bg(g)
	local ok, e = xpcall(bgb, debug.traceback, g)
	if ok or ge.__BkSae ~= st or st.bi ~= g then return end
	st.bx = false
	if st.on and not st.fp then
		st.bo = false
	elseif st.bo and not (st.lb or st.tb or st.hb) then
		local _, hu = rt()
		if hu then pcall(function() hu:UnequipTools() end) end
		pcall(un)
		st.bo = false
	end
	pcall(we)
	xs("Auto Butterfly", "abf", "Butterfly Crashed", e)
end

local function hdb(g)
	local lm
	local function l2(m)
		if m == lm then return end
		lm = m
		lg("Halloween | " .. m)
	end
	local function hz2(n)
		local m = workspace:FindFirstChild("HalloweenDimension")
		local z = m and m:FindFirstChild("Zones")
		local p = z and z:FindFirstChild(n)
		return p and p:IsA("BasePart") and p or nil
	end
	local function hin() return lp:GetAttribute("InHalloweenDimension") == true end
	local function gg()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local g2 = m and m:FindFirstChild("Ground")
		return g2 and {g2, workspace.Terrain} or {workspace.Terrain}
	end
	local function zq(q)
		for i = 1, 3 do
			local b = hz2("Zone" .. i)
			if b and math.abs(q.X - b.Position.X) <= b.Size.X / 2 and math.abs(q.Z - b.Position.Z) <= b.Size.Z / 2 then return i end
		end
		return nil
	end
	local function hca() return lp:GetAttribute("HalloweenCarrying") == true end
	local function on() return ge.__BkSae == st and (st.hd or st.hm or st.hx) and st.hg == g end
	local function own(o)
		if o then
			st.bo, st.hb = true, true
			if sw() then return true end
			st.bo, st.hb = false, false
			return false
		end
		local _, hu = rt()
		fz(false)
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		un()
		st.bo, st.hb = false, false
		return true
	end
	local function el()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local w = m and m:FindFirstChild("WorldEggs")
		local o, t, h = {}, os.clock(), rt()
		for _, e in w and w:GetChildren() or {} do
			local u, pn = e:GetAttribute("HalloweenEggUid"), e:GetAttribute("PreparedSourceName")
			local p = e:FindFirstChild("StealPrompt", true)
			local ok, q = pcall(e.GetPivot, e)
			local z = ok and zq(q.Position)
			if type(u) == "string" and type(pn) == "string" and p and p:IsA("ProximityPrompt") and p.Enabled and (st.hbl[u] or 0) < t and z then
				local a = dr[pn]
				o[#o + 1] = {u = u, p = q.Position, pr = p, z = z, n = pn, e = tonumber(a and a.EarningRate) or 0, k = tonumber(a and a.Rarity and a.Rarity.Rank) or 0}
			end
		end
		table.sort(o, function(x, y)
			if x.k ~= y.k then return x.k > y.k end
			if x.e ~= y.e then return x.e > y.e end
			return h ~= nil and (x.p - h.Position).Magnitude < (y.p - h.Position).Magnitude
		end)
		return o
	end
	local function en()
		local w = workspace:FindFirstChild("World")
		local p = w and w:FindFirstChild("HalloweenDimensionPortal")
		local b = p and p:FindFirstChild("Hitbox", true)
		pg2(true)
		if not (b and b:IsA("BasePart")) then return false, "Enter Failed: No Portal" end
		if st.bt or tm() then
			lt()
			task.wait(1)
		end
		local t0 = os.clock()
		while not hin() and os.clock() - t0 < 40 do
			if not on() then return false, "Stopped" end
			local _, hu = rt()
			if hu then hu:MoveTo(b.Position) end
			task.wait(0.25)
		end
		if not hin() then return false, "Enter Failed: Timeout" end
		local t = os.clock()
		repeat task.wait(0.2) until not tostring(lp:GetAttribute("HalloweenTransition") or ""):find(":cover:") or os.clock() - t > 10
		return true
	end
	local function nk()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local f = m and m:FindFirstChild("Spawns")
		local s = hz2("SafeZone")
		local lo, hi, l = math.huge, -math.huge, {}
		for _, p in f and f:GetDescendants() or {} do
			if p:IsA("BasePart") and p.Name == "Spawn" then
				lo, hi = math.min(lo, p.Position.X), math.max(hi, p.Position.X)
				l[#l + 1] = p.Position
			end
		end
		if not s or #l == 0 then return nil end
		return lo - 100, hi + 100, s.Position.Z + s.Size.Z / 2 + 40, l
	end
	local function gt(e)
		local h, hu = rt()
		if not h or not hu then return false, "Fly Failed: No Character" end
		local u = Vector3.new(e.p.X - h.Position.X, 0, e.p.Z - h.Position.Z)
		local b = u.Magnitude > 7 and e.p - u.Unit * 7 or e.p
		local function ck()
			if not on() then return "Stopped" end
			if not e.pr.Parent or not e.pr.Enabled then return "Fly Failed: Egg Gone" end
			return nil
		end
		local lo, hi, zn = nk()
		if lo and h.Position.Z < zn then
			local x = math.clamp(h.Position.X, lo, hi)
			local ok, wy = hp(Vector3.new(x, gy2(Vector3.new(x, h.Position.Y, zn), Vector3.zero, 60, gg()) - st.gh + 3, zn), nil, false, ck, gg())
			if not ok then return false, wy end
		end
		local ok, wy = hp(Vector3.new(b.X, gy2(Vector3.new(b.X, e.p.Y, b.Z), Vector3.zero, 60, gg()) - st.gh + 3, b.Z), nil, false, ck, gg())
		if not ok then return false, wy end
		task.wait(0.15)
		pcall(fireproximityprompt, e.pr)
		local t = os.clock()
		repeat task.wait() until hca() or os.clock() - t > 1.5
		if not hca() then return false, "Steal Failed: Not Carrying" end
		return true
	end
	local function rl2()
		local h = rt()
		if not h then return false, "Relay Failed: No Character" end
		local ok, a, b = pcall(rm.HalloweenDimension.AskDropEgg.InvokeServer, rm.HalloweenDimension.AskDropEgg)
		if not ok or not a then return false, "Relay Failed: Drop " .. tostring(ok and (b or "Denied") or a) end
		local t = os.clock()
		repeat task.wait() until not hca() or os.clock() - t > 1
		if hca() then return false, "Relay Failed: Still Carrying" end
		local m = workspace:FindFirstChild("HalloweenDimension")
		local w = m and m:FindFirstChild("WorldEggs")
		local pr, bd = nil, 25
		t = os.clock()
		while not pr and os.clock() - t < 1 do
			for _, x in w and w:GetChildren() or {} do
				local p = x:FindFirstChild("StealPrompt", true)
				local o2, q = pcall(x.GetPivot, x)
				if p and p:IsA("ProximityPrompt") and p.Enabled and o2 and (q.Position - h.Position).Magnitude < bd then pr, bd = p, (q.Position - h.Position).Magnitude end
			end
			if not pr then task.wait() end
		end
		if not pr then return false, "Relay Failed: No Dropped Egg" end
		t = os.clock()
		local nf = 0
		repeat
			if os.clock() >= nf then
				nf = os.clock() + 0.25
				pcall(fireproximityprompt, pr)
			end
			task.wait()
		until hca() or os.clock() - t > 2
		if not hca() then return false, "Relay Failed: Retake" end
		return true
	end
	local function sh3(en)
		local h0 = rt()
		local lq = h0 and h0.Position
		while true do
			if not on() then return false, "Stopped" end
			if not hca() then return false, "Carry Ended" end
			local hr, hu = rt()
			if not hr or not hu then return false, "Home Failed: Character Lost" end
			fz(true)
			local d, k = Vector3.new(en.X - hr.Position.X, 0, en.Z - hr.Position.Z), st.hk
			if d.Magnitude <= k then
				hr.CFrame = d.Magnitude > 0.1 and CFrame.lookAt(en, en + d.Unit) or CFrame.new(en) * hr.CFrame.Rotation
				hr.AssemblyLinearVelocity = Vector3.zero
				return true
			end
			local np = hr.Position + d.Unit * k
			np = Vector3.new(np.X, gy2(np, Vector3.zero, 60, gg()), np.Z)
			hr.CFrame = CFrame.lookAt(np, np + d.Unit)
			hr.AssemblyLinearVelocity = Vector3.zero
			if lq and (np - lq).Magnitude >= st.hr then
				task.wait(st.hw)
				local ok, wy = rl2()
				if not ok then return false, wy end
				lq = np
			end
			task.wait(0.1)
		end
	end
	local function hm2()
		local h = rt()
		local lo, hi, zn = nk()
		if not (h and lo) then return false, "Home Failed: No Safe Zone" end
		local d0 = lp:GetAttribute("HalloweenDelivered")
		local ok, wy = true, nil
		if h.Position.Z > zn then
			local x = math.clamp(h.Position.X, lo, hi)
			ok, wy = sh3(Vector3.new(x, gy2(Vector3.new(x, h.Position.Y, zn), Vector3.zero, 60, gg()) - st.gh + 3, zn))
		end
		h = rt()
		if ok and h then
			local x, zi = math.clamp(h.Position.X, lo, hi), zn - 55
			ok, wy = sh3(Vector3.new(x, gy2(Vector3.new(x, h.Position.Y, zi), Vector3.zero, 60, gg()) - st.gh + 3, zi))
		end
		local t = os.clock()
		repeat task.wait(0.1) until lp:GetAttribute("HalloweenDelivered") ~= d0 or os.clock() - t > 3
		if lp:GetAttribute("HalloweenDelivered") ~= d0 then return true end
		return false, ok and "Not Delivered" or "Egg Lost | " .. tostring(wy)
	end
	local function ml()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local o, h, t = {}, rt(), os.clock()
		for _, b in cl:GetTagged("BatDamagable") do
			local x = b.Parent
			while x and x ~= m and not cl:HasTag(x, "HalloweenMonster") do x = x.Parent end
			local v = b:IsA("BasePart") and b:GetAttribute("Health")
			if m and h and x and x ~= m and type(v) == "number" and v > 0 and zq(b.Position) and (st.hbl[x] or 0) < t then
				o[#o + 1] = {m = x, b = b, n = x.Name, k = ({Small = 1, Medium = 2, Large = 3})[x:GetAttribute("MonsterSize")] or 0, d = (b.Position - h.Position).Magnitude}
			end
		end
		table.sort(o, function(x, y)
			if x.k ~= y.k then return x.k > y.k end
			return x.d < y.d
		end)
		return o
	end
	local function kl(x)
		local h = rt()
		if not h then return false, "Kill Failed: No Character" end
		local p = x.b.Position
		local u = Vector3.new(p.X - h.Position.X, 0, p.Z - h.Position.Z)
		local q = u.Magnitude > 15 and p - u.Unit * 15 or p
		if not own(true) then return false, "Waiting To Swap" end
		local ok, wy = hp(Vector3.new(q.X, gy2(Vector3.new(q.X, p.Y, q.Z), Vector3.zero, 60, gg()) - st.gh + 3, q.Z), nil, false, function()
			if not on() then return "Stopped" end
			if not x.b.Parent or (tonumber(x.b:GetAttribute("Health")) or 0) <= 0 then return "Monster Gone" end
			return nil
		end, gg())
		if not ok then return wy == "Monster Gone", wy end
		local b = gb()
		if not b then return false, "Kill Failed: No Bat" end
		local t0, a0, nx, ns = os.clock(), math.random() * math.pi * 2, 0, 0
		while on() and os.clock() - t0 < 25 do
			if not x.b.Parent or (tonumber(x.b:GetAttribute("Health")) or 0) <= 0 then return true end
			if st.hd and #el() > 0 then return false, "Eggs Back" end
			local h2, hu = rt()
			if not h2 or not hu or hu.Health <= 0 or not (st.sc and st.sc.Parent == lp.Character) then return false, "Kill Failed: Character Lost" end
			if b.Parent ~= lp.Character then pcall(hu.EquipTool, hu, b) end
			if os.clock() >= ns then
				ns, st.bsq = os.clock() + st.bsi, st.bsq + 1
				pcall(function() rm.BatSwing.Trigger:FireServer(nil, string.format("%d:%d:%d", lp.UserId, st.bsq, math.floor(workspace:GetServerTimeNow() * 1000))) end)
			end
			if os.clock() >= nx then
				nx, a0 = os.clock() + 0.3, a0 + math.pi / 3
				local c0 = x.b.Position
				local q2 = c0 + Vector3.new(math.cos(a0) * 12, 0, math.sin(a0) * 12)
				q2 = Vector3.new(q2.X, gy2(q2, Vector3.zero, 60, gg()) - st.gh + 3, q2.Z)
				fz(true)
				h2.CFrame = CFrame.lookAt(q2, Vector3.new(c0.X, q2.Y, c0.Z))
				h2.AssemblyLinearVelocity = Vector3.zero
			end
			task.wait(0.05)
		end
		return false, "Kill Timeout"
	end
	local function px()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local pp = m and m:FindFirstChild("PortalHome", true)
		pp = pp and pp:FindFirstChild("Portal", true)
		if not (pp and pp:IsA("BasePart")) then return false, "Exit Failed: No Portal" end
		local h = rt()
		local q = Vector3.new(pp.Position.X, 0, pp.Position.Z + 30)
		if h and (Vector3.new(h.Position.X, 0, h.Position.Z) - q).Magnitude > 60 then
			if not own(true) then return false, "Waiting To Swap" end
			local ok, wy = hp(Vector3.new(q.X, gy2(Vector3.new(q.X, pp.Position.Y, q.Z), Vector3.zero, 60, gg()) - st.gh + 3, q.Z), nil, false, function() return not on() and "Stopped" or nil end, gg())
			if not ok then return false, wy end
		end
		if st.hb then own(false) end
		local t0 = os.clock()
		while hin() and os.clock() - t0 < 30 do
			if not on() then return false, "Stopped" end
			local _, hu = rt()
			if hu then hu:MoveTo(pp.Position) end
			task.wait(0.25)
		end
		if hin() then return false, "Exit Failed: Timeout" end
		local t = os.clock()
		repeat task.wait(0.2) until not tostring(lp:GetAttribute("HalloweenTransition") or ""):find(":cover:") or os.clock() - t > 10
		t = os.clock()
		repeat
			task.wait(0.1)
			local h2, hu = rt()
		until not on() or os.clock() - t > 8 or (h2 and hu and hu.FloorMaterial ~= Enum.Material.Air and Vector3.new(h2.AssemblyLinearVelocity.X, 0, h2.AssemblyLinearVelocity.Z).Magnitude < 2)
		if not on() then return false, "Stopped" end
		task.wait(0.3)
		if not own(true) then
			st.bo, st.hb = false, false
			return false, "Place Failed: Swap"
		end
		local n, wy = pe()
		own(false)
		return true, string.format("Placed %d%s", n, wy and (" | " .. wy) or "")
	end
	local o4, hdg = pcall(function() return require(rs.Data.HalloweenDimensionEgg) end)
	local hpr = o4 and type(hdg) == "table" and tonumber(hdg.Price) or 2250
	local function tkn()
		local o, s2 = pcall(sv.Await)
		if not o or type(s2) ~= "table" then return 0 end
		local c = type(s2.Currency) == "table" and s2.Currency.HalloweenTokens
		return tonumber(c or s2.HalloweenTokens) or 0
	end
	local function by()
		local m = workspace:FindFirstChild("HalloweenDimension")
		local sh = m and m:FindFirstChild("EggShop")
		local o0, sp = pcall(function() return sh:GetPivot().Position end)
		if not o0 then return false, "Buy Failed: No Shop" end
		local h = rt()
		if h and (Vector3.new(h.Position.X, sp.Y, h.Position.Z) - sp).Magnitude > 9 then
			if not own(true) then return false, "Waiting To Swap" end
			local q = sp + Vector3.new(0, 0, 6)
			local ok, wy = hp(Vector3.new(q.X, gy2(q, Vector3.zero, 60, gg()) - st.gh + 3, q.Z), nil, false, function() return not on() and "Stopped" or nil end, gg())
			if not ok then return false, wy end
		end
		local n, wy = 0, nil
		while on() and tkn() >= hpr do
			local o, a, b = pcall(rm.HalloweenDimension.AskBuyEgg.InvokeServer, rm.HalloweenDimension.AskBuyEgg)
			if not o or not a then
				wy = "Buy Failed: " .. tostring(o and (b or "Denied") or a)
				break
			end
			n += 1
			task.wait(0.3)
		end
		return n > 0, string.format("Bought %d%s", n, wy and " | " .. wy or "")
	end
	local nd, nk2 = 0, 0
	local su = false
	local function sx(v)
		if su == v then return end
		su = v
		pcall(function() rm.TrainEvent.Suction:FireServer(v) end)
	end
	local function tsg()
		if type(st.ts) ~= "table" then
			local ok, l = pcall(filtergc, "table", {Keys = {"ArrivalOpen", "DepartureAt", "StationAvailable"}}, false)
			local b
			for _, t in ok and type(l) == "table" and l or {} do
				if not b or (tonumber(rawget(t, "ReturnAt")) or 0) > (tonumber(rawget(b, "ReturnAt")) or 0) then b = t end
			end
			st.ts = b
		end
		return st.ts
	end
	local function aro()
		local t = tsg()
		return t ~= nil and rawget(t, "ArrivalOpen") == true and workspace:GetServerTimeNow() < (tonumber(rawget(t, "DepartureAt")) or 0) and rawget(t, "Phase") == "Home"
	end
	local pk = {}
	local function pfn(a, en2)
		local d = pk[a]
		if not (d and d.Parent) then
			d = nil
			for _, x in workspace:GetDescendants() do
				if x:IsA("ProximityPrompt") and not x:GetAttribute("TrainLocalBoarding") and (x:GetAttribute("TrainEventAction") == a or x.ActionText == a) then
					d = x
					if not en2 or x.Enabled then break end
				end
			end
			pk[a] = d
		end
		if d and (not en2 or d.Enabled) then return d end
		return nil
	end
	local function ppos(d)
		local pp = d.Parent
		return pp:IsA("Attachment") and pp.WorldPosition or pp:IsA("BasePart") and pp.Position or pp:GetPivot().Position
	end
	local function brd()
		local tb = pk.TrainBoard
		if not (tb and tb.Parent) then
			tb = nil
			for _, d in workspace:GetDescendants() do
				if d:IsA("ProximityPrompt") and d.Name == "TrainBoard" and not d:GetAttribute("TrainLocalBoarding") then tb = d break end
			end
			pk.TrainBoard = tb
		end
		if not tb then return false, "Board Failed: No Station" end
		local a, b = tb:GetAttribute("BoardRailStart"), tb:GetAttribute("BoardRailEnd")
		local q = typeof(a) == "Vector3" and typeof(b) == "Vector3" and (a + b) / 2 or ppos(tb)
		local h = rt()
		if h and (Vector3.new(q.X - h.Position.X, 0, q.Z - h.Position.Z)).Magnitude > 20 then
			if not own(true) then return false, "Waiting To Swap" end
			local ok, wy = hp(Vector3.new(q.X, gy2(q, Vector3.zero, 60, gg()) - st.gh + 3, q.Z), nil, false, function() return not on() and "Stopped" or nil end, gg())
			if not ok then return false, wy end
		end
		if st.hb then own(false) end
		local ok, r1, r2 = pcall(rm.TrainEvent.Action.InvokeServer, rm.TrainEvent.Action, "Board")
		if not ok or not r1 then return false, "Board Failed: " .. tostring(ok and (r2 or "Denied") or r1) end
		return true
	end
	local function hj(q, lk)
		if not own(true) then return false end
		local h = rt()
		if not h then return false end
		local y = gy2(q, Vector3.zero, 30) - st.gh + 3
		local p = Vector3.new(q.X, y, q.Z)
		fz(true)
		h.CFrame = CFrame.lookAt(p, Vector3.new(lk.X, y, lk.Z))
		h.AssemblyLinearVelocity = Vector3.zero
		return true
	end
	local bsu, bnx, gan, gnx, csx = false, 0, math.random() * math.pi * 2, 0, 0
	local function bsx(v, lk)
		if not v then
			if bsu then
				bsu = false
				pcall(function() rm.GhostBoss.Suction:FireServer(false) end)
			end
			return
		end
		if os.clock() < bnx and bsu then return end
		bsu, bnx = true, os.clock() + 0.25
		pcall(function() rm.GhostBoss.Suction:FireServer(true, lk) end)
	end
	local function gbp()
		local g2 = rs:FindFirstChild("GhostBossState")
		if not g2 or g2:GetAttribute("Realm") ~= "Town" or g2:GetAttribute("Phase") ~= "Alive" then return nil end
		local gp, vl, mt2 = g2:GetAttribute("Ground"), g2:GetAttribute("Velocity"), tonumber(g2:GetAttribute("MovedAt"))
		if typeof(gp) ~= "Vector3" then return nil end
		if typeof(vl) == "Vector3" and mt2 then gp += vl * math.clamp(workspace:GetServerTimeNow() - mt2, 0, 2) end
		return gp, g2:GetAttribute("AttackTarget") == lp.UserId and (g2:GetAttribute("AttackPhase") == "Windup" or g2:GetAttribute("AttackPhase") == "Charge")
	end
	local function rdn(f)
		local cs2, nw = st.cs, workspace:GetServerTimeNow()
		if f and (type(cs2) ~= "table" or (tonumber(rawget(cs2, "StartsAt")) or 0) < nw - 900) and os.clock() >= csx then
			csx = os.clock() + 2
			local o6, l6 = pcall(filtergc, "table", {Keys = {"VacuumOwned", "Holding", "Captured"}}, false)
			cs2 = o6 and type(l6) == "table" and l6[1] or cs2
			st.cs = cs2
		end
		return type(cs2) == "table" and (tonumber(rawget(cs2, "StartsAt")) or 0) >= nw - 900 and (rawget(cs2, "Phase") == "Completed" or (tonumber(rawget(cs2, "EndsAt")) or math.huge) < nw or (tonumber(rawget(cs2, "Captured")) or 0) >= (tonumber(rawget(cs2, "Goal")) or math.huge))
	end
	local function twn()
		local c = lp.Character
		local h, hu = rt()
		if not h or not hu or hu.Health <= 0 then
			sx(false)
			return "No Character"
		end
		local o2, s2 = pcall(sv.Await)
		local te = o2 and type(s2) == "table" and s2.TrainEvent
		local o3, tf = pcall(function() return require(rs.Shared.Flags.TrainEventFlags) end)
		local o5, cst = pcall(function() return tf.SpectralSoulCost:Get() end)
		cst = o3 and o5 and tonumber(cst) or 1000
		if type(te) == "table" and (tonumber(te.Souls) or 0) >= cst and os.clock() >= st.hbt then
			local sp4 = pfn("OpenSoulShop", true)
			if sp4 then
				sx(false)
				local q = ppos(sp4)
				if (q - h.Position).Magnitude > 12 then
					local u2 = Vector3.new(h.Position.X - q.X, 0, h.Position.Z - q.Z)
					hj(q + (u2.Magnitude > 0.1 and u2.Unit or Vector3.new(1, 0, 0)) * 6, q)
					return "Going To Soul Keeper"
				end
				st.hbt = os.clock() + 3
				local ok, r1, r2 = pcall(rm.TrainEvent.Action.InvokeServer, rm.TrainEvent.Action, "TradeSouls", cst)
				return ok and r1 and "Traded Souls" or "Trade Failed: " .. tostring(ok and (r2 or "Denied") or r1)
			end
		end
		local vc
		for _, t in c and c:GetChildren() or {} do if t:IsA("Tool") and t.Name:find("Vacuum") then vc = t end end
		if not vc then
			local bp = lp:FindFirstChildOfClass("Backpack")
			for _, t in bp and bp:GetChildren() or {} do
				if t:IsA("Tool") and t.Name:find("Vacuum") then
					pcall(hu.EquipTool, hu, t)
					return "Equipping Vacuum"
				end
			end
			local pr = pfn("PickupVacuum", true)
			if pr then
				sx(false)
				local q = ppos(pr)
				if (q - h.Position).Magnitude > 8 then
					local u2 = Vector3.new(h.Position.X - q.X, 0, h.Position.Z - q.Z)
					hj(q + (u2.Magnitude > 0.1 and u2.Unit or Vector3.new(1, 0, 0)) * 4, q)
				else
					pcall(fireproximityprompt, pr)
				end
				return "Getting Vacuum"
			end
		end
		if rdn(true) and not gbp() then
			sx(false)
			local rp2 = pk.Ret
			if not (rp2 and rp2.Parent) then
				rp2 = nil
				for _, d in workspace:GetDescendants() do
					if d:IsA("ProximityPrompt") and d.Name == "TrainReturn" and d:GetAttribute("TrainEventRequiredPhase") == "Town" then
						rp2 = d
						if d:GetAttribute("TrainLocalReturn") then break end
					end
				end
				pk.Ret = rp2
			end
			if not rp2 then return "Return Failed: No Platform" end
			local q = ppos(rp2)
			if (Vector3.new(q.X - h.Position.X, 0, q.Z - h.Position.Z)).Magnitude > 10 then
				hj(q, q + Vector3.new(0, 0, 1))
				return "Going To Platform"
			end
			if os.clock() < st.rtn then return "Returning" end
			st.rtn = os.clock() + 2
			if st.hb then own(false) end
			local ok, r1, r2 = pcall(rm.TrainEvent.Action.InvokeServer, rm.TrainEvent.Action, "Return")
			return ok and r1 and "Returning" or "Return Failed: " .. tostring(ok and (r2 or "Denied") or r1)
		end
		local gp, ak = gbp()
		if gp and vc then
			sx(false)
			local fl = Vector3.new(h.Position.X - gp.X, 0, h.Position.Z - gp.Z)
			local dd = fl.Magnitude
			if math.abs(dd - st.gbd) > 3 then
				hj(gp + (dd > 0.1 and fl.Unit or Vector3.new(1, 0, 0)) * st.gbd, gp)
			elseif dd > 0.1 then
				h.CFrame = CFrame.lookAt(h.Position, Vector3.new(gp.X, h.Position.Y, gp.Z))
			end
			local h2 = rt()
			local bc2 = gp + Vector3.new(0, 5, 0)
			bsx(h2 ~= nil, h2 and (bc2 - h2.Position).Unit)
			return ak and "Boss | Dodging" or "Boss | Sucking"
		end
		bsx(false)
		local f = workspace:FindFirstChild("TrainGhostVisuals")
		local bq2, bdd
		for _, x in f and f:GetChildren() or {} do
			local ok, q = pcall(function() return x:IsA("Model") and x:GetPivot().Position or x.Position end)
			if ok and (not bdd or (q - h.Position).Magnitude < bdd) then bq2, bdd = q, (q - h.Position).Magnitude end
		end
		if not bq2 then
			sx(false)
			return "No Ghosts"
		end
		local fl = Vector3.new(bq2.X - h.Position.X, 0, bq2.Z - h.Position.Z)
		if fl.Magnitude > 18 or os.clock() >= gnx then
			gnx, gan = os.clock() + 0.3, gan + math.pi / 3
			hj(bq2 + Vector3.new(math.cos(gan) * 12, 0, math.sin(gan) * 12), bq2)
		elseif fl.Magnitude > 0.5 then
			h.CFrame = CFrame.lookAt(h.Position, h.Position + fl)
		end
		local h2 = rt()
		sx(h2 ~= nil and (bq2 - h2.Position).Magnitude < 22)
		return "Hunting Ghosts"
	end
	st.hl = true
	while on() do
		if st.on or (st.bo and not st.hb) then
			if st.hb then own(false) end
			l2("Waiting For Control")
			task.wait(0.5)
			continue
		end
		local ph = lp:GetAttribute("TrainEventPhase")
		if st.hx and ph ~= nil and ph ~= "Home" then
			if ph ~= "Town" and st.hb then own(false) end
			if ph ~= "Town" then bsx(false) end
			l2("Train | " .. (ph == "Town" and twn() or tostring(ph)))
			task.wait(0.1)
			continue
		end
		sx(false)
		local ar = st.hx and aro() and not hca() and not rdn(false)
		if not hin() and not (st.hd or st.hm or ar) then
			if st.hb then own(false) end
			l2("Waiting For Train")
			task.wait(1)
			continue
		end
		if ar and hin() and not tostring(lp:GetAttribute("HalloweenTransition") or ""):find(":cover:") then
			l2("Train | Boarding")
			local ok, wy = brd()
			l2(ok and "Train | Boarded" or "Train | " .. tostring(wy))
			task.wait(ok and 2 or 1)
			continue
		end
		if not hin() then
			if st.hb then own(false) end
			l2("Entering Dimension")
			local ok, wy = en()
			if not ok then
				l2(tostring(wy))
				task.wait(2)
			end
			continue
		end
		if tostring(lp:GetAttribute("HalloweenTransition") or ""):find(":cover:") then
			task.wait(0.3)
			continue
		end
		if hca() then
			if not own(true) then
				st.bo, st.hb = false, false
				l2("Waiting To Swap")
				task.wait(0.3)
				continue
			end
			l2("Going Home")
			local ok, wy = hm2()
			if ok then nd += 1 end
			l2(ok and string.format("Delivered #%d", nd) or tostring(wy))
			continue
		end
		if os.clock() >= st.hbt and tkn() >= hpr then
			st.hbt = os.clock() + 15
			l2("Buying Halloween Egg")
			local _, wy = by()
			l2(tostring(wy))
			continue
		end
		local d = dl()
		local l = st.hd and el() or {}
		local h, hu = rt()
		if not h or not hu then
			task.wait(0.5)
			continue
		end
		if #l == 0 and st.hm and d and d > 0 then
			local mo = ml()
			if #mo == 0 then
				if st.hb then own(false) end
				l2("No Monsters")
				task.wait(1)
				continue
			end
			local x = mo[1]
			l2(string.format("Fighting %s", x.n))
			local ok, wy = kl(x)
			if ok then
				nk2 += 1
				l2(string.format("Killed #%d | %s", nk2, x.n))
			else
				if wy ~= "Eggs Back" then st.hbl[x.m] = os.clock() + 15 end
				l2(tostring(wy))
			end
			continue
		end
		if st.hd then
			local _, hu3 = rt()
			local c3 = lp.Character
			if hu3 and c3 and c3:FindFirstChildOfClass("Tool") then pcall(hu3.UnequipTools, hu3) end
		end
		if #l == 0 or not d or d < (l[1].p - h.Position).Magnitude / math.max(hu.WalkSpeed, 16) * 2 + 9 then
			local ub, pb = ow()
			if st.ap and d == 0 and os.clock() >= st.hpx and #ub > 0 and not (st.pf and #pb >= st.pf) then
				st.hpx = os.clock() + 120
				l2("Night | Leaving To Place Eggs")
				local ok, wy = px()
				l2(ok and "Night | " .. tostring(wy) or tostring(wy))
				continue
			end
			if st.hb then own(false) end
			l2(#l == 0 and "No Eggs" or "Waiting For Day")
			task.wait(1)
			continue
		end
		local e = l[1]
		if not own(true) then
			st.bo, st.hb = false, false
			l2("Waiting To Swap")
			task.wait(0.3)
			continue
		end
		l2(string.format("Flying To %s (Zone %s)", e.n, tostring(e.z)))
		local ok, wy = gt(e)
		if not ok then
			st.hbl[e.u] = os.clock() + 30
			l2(tostring(wy))
			task.wait(0.2)
			continue
		end
		l2(string.format("Stole %s | Going Home", e.n))
		ok, wy = hm2()
		if ok then nd += 1 end
		l2(ok and string.format("Delivered #%d | %s | Zone %s", nd, e.n, tostring(e.z)) or tostring(wy))
	end
	sx(false)
	bsx(false)
	if st.hb then own(false) end
	lg("Idle")
end

local function hd(g)
	local ok, e = xpcall(hdb, debug.traceback, g)
	if st.hg == g then st.hl = false end
	if ok then
		if ge.__BkSae == st and (st.hd or st.hm or st.hx) and st.hg == g then
			st.hg += 1
			task.spawn(hd, st.hg)
		end
		return
	end
	if ge.__BkSae ~= st or st.hg ~= g then return end
	pcall(function() rm.TrainEvent.Suction:FireServer(false) end)
	pcall(function() rm.GhostBoss.Suction:FireServer(false) end)
	if st.hb then
		pcall(fz, false)
		local _, hu = rt()
		local t = os.clock()
		while hu and hu.Parent and hu.FloorMaterial == Enum.Material.Air and os.clock() - t < 3 do task.wait(0.1) end
		pcall(un)
		st.bo, st.hb = false, false
	end
	xs("Auto Halloween", "ahd", "Halloween Crashed", e)
end

pcall(function() st.cn[#st.cn + 1] = rm.TrainEvent.State.OnClientEvent:Connect(function(a) if type(a) == "table" then st.ts = a end end) end)
pcall(function() st.cn[#st.cn + 1] = rm.TrainEvent.CaptureState.OnClientEvent:Connect(function(a) if type(a) == "table" then st.cs = a end end) end)

local function ht()
	local ok, o = pcall(es.ReadOwnerEggs, lp.UserId)
	if not ok or type(o) ~= "table" then return 0 end
	local n, t = 0, os.clock()
	for k, v in pairs(o) do
		if ge.__BkSae ~= st or not st.ah or n >= 5 then break end
		if type(k) == "string" and type(v) == "table" and v.Placement and (st.hf[k] or 0) < t then
			local o2, r = pcall(es.IsReadyToHatch, k)
			if o2 and r == true then
				local o3, a = pcall(es.BeginHatch, k)
				local o4, b = false, false
				if o3 and a then o4, b = pcall(es.FinishHatch, k) end
				if o4 and b then
					n += 1
				else
					st.hf[k] = t + 60
				end
				task.wait(0.3)
			end
		end
	end
	return n
end

task.spawn(function()
	while ge.__BkSae == st do
		task.wait(10)
		if ge.__BkSae ~= st then break end
		if not kv() then continue end
		if st.ah then
			local n = ht()
			if n > 0 then zx(`[Hatch] Hatched {n}`) end
		end
		if st.ps or st.es then
			local p, e = sc()
			if #p + #e > 0 then
				sl(p, e)
				zx(`[Sell] Sold {#p} Pets, {#e} Eggs`)
			end
		end
	end
end)

L = (function()
local ps, uis, tws, gs, hs = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("GuiService"), game:GetService("HttpService")
local ge = getgenv and getgenv() or _G
local hx, wt = Color3.fromHex, Color3.new(1, 1, 1)
local c = {cr = hx("07101C"), sh = hx("8CDCFF"), ac = hx("4FD8FF"), a2 = hx("8FE3FF"), dm = hx("9FC6D6"), ok = hx("7DFFB0"), er = hx("FF5A6A"), r1 = hx("FF2A6A"), r2 = hx("2AF0FF"), hi = hx("BFF2FF")}
local bs = "rbxasset://fonts/families/BuilderSans.json"
local fn, fs, fb, fm, fj = Font.new(bs, Enum.FontWeight.Medium), Font.new(bs, Enum.FontWeight.SemiBold), Font.new(bs, Enum.FontWeight.Bold), Font.fromEnum(Enum.Font.Michroma), Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Bold)
local ir = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json")
local ww, wh, nw, th = 580, 340, 136, 48
local mb, tc, mm, kb = Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch, Enum.UserInputType.MouseMovement, Enum.UserInputType.Keyboard
local ti, tb2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local L = {Flags = {}}

local function mk(k, p, ch)
	local o = Instance.new(k)
	for i, v in p do
		if i ~= "Parent" then o[i] = v end
	end
	for _, x in ch or {} do x.Parent = o end
	o.Parent = p.Parent
	return o
end

local function rc(r) return mk("UICorner", {CornerRadius = UDim.new(0, r)}) end
local function sk(t, col, w) return mk("UIStroke", {Color = col or wt, Transparency = t, Thickness = w or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}) end
local function pd(l, r, t, b) return mk("UIPadding", {PaddingLeft = UDim.new(0, l), PaddingRight = UDim.new(0, r or l), PaddingTop = UDim.new(0, t or 0), PaddingBottom = UDim.new(0, b or t or 0)}) end
local function ll(g) return mk("UIListLayout", {Padding = UDim.new(0, g), SortOrder = Enum.SortOrder.LayoutOrder}) end
local function tw(o, p, i) tws:Create(o, i or ti, p):Play() end
local function ns(t) local k = {}; for i = 1, #t, 2 do k[#k + 1] = NumberSequenceKeypoint.new(t[i], t[i + 1]) end; return NumberSequence.new(k) end

local function tl(p, ch)
	local d = {BackgroundTransparency = 1, FontFace = fn, TextColor3 = wt, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Text = ""}
	for i, v in p do d[i] = v end
	return mk("TextLabel", d, ch)
end

local function ig(p, ch)
	local d = {BackgroundTransparency = 1, FontFace = ir, TextColor3 = c.dm, TextSize = 14, Text = ""}
	for i, v in p do d[i] = v end
	return mk("TextLabel", d, ch)
end

local function bt(p, ch)
	local d = {BackgroundTransparency = 1, AutoButtonColor = false, Text = "", BorderSizePixel = 0}
	for i, v in p do d[i] = v end
	return mk("TextButton", d, ch)
end

local function rg(s, w, col, t, q)
	return mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(s, s), BackgroundTransparency = 1}, {rc(s), mk("UIStroke", {Color = col, Thickness = w, Transparency = t or 0}, {q and mk("UIGradient", {Transparency = ns(q)}) or nil})})
end

local function rx(p, s)
	local f = mk("Frame", {Size = UDim2.fromOffset(s, s), BackgroundTransparency = 1, Parent = p})
	local a = rg(s - 2, 2, c.ac, 0, {0, 0, 0.34, 0, 0.35, 1, 0.65, 1, 0.66, 0, 1, 0})
	local b = rg(math.round(s * 0.62), 1, c.a2, 0, {0, 0, 0.5, 0, 0.6, 1, 1, 1})
	a.Parent, b.Parent = f, f
	local d = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(math.round(s * 0.3), math.round(s * 0.3)), BackgroundColor3 = c.hi, BorderSizePixel = 0, Parent = f}, {rc(s), sk(0.4, c.ac, 2)})
	for _, x in {a, b, d} do
		x.Size = UDim2.fromScale(x.Size.X.Offset / s, x.Size.Y.Offset / s)
		x:FindFirstChildOfClass("UICorner").CornerRadius = UDim.new(0.5, 0)
	end
	return f, a, b
end
L.Reactor = rx

local function gui()
	local sg = mk("ScreenGui", {Name = hs:GenerateGUID(false), IgnoreGuiInset = true, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999})
	if not pcall(function() sg.Parent = gethui and gethui() or game:GetService("CoreGui") end) then sg.Parent = ps.LocalPlayer:WaitForChild("PlayerGui") end
	return sg
end

local function fit(sg, f, sc)
	local s, i = sg.AbsoluteSize, gs:GetGuiInset().Y
	local v = math.clamp(math.min((s.X - 24) / ww, (s.Y - i - 24) / wh), 0.5, 1)
	sc.Scale = v
	f.Position = UDim2.fromOffset(s.X / 2, i + (s.Y - i) / 2)
	return v
end

local function cfn(s)
	if s == nil then return true end
	if type(s) ~= "string" or s == "" then return false end
	for sg in (s .. "/"):gmatch("([^/]*)/") do
		if not sg:match("^[%w _%-]+$") then return false end
	end
	return true
end

local function mkd(p)
	local d = ""
	for sg in p:gmatch("([^/]+)/") do
		d = d == "" and sg or d .. "/" .. sg
		if not isfolder(d) then makefolder(d) end
	end
end

local function hv(f, st)
	f.MouseEnter:Connect(function()
		if not uis.MouseEnabled then return end
		tw(f, {BackgroundColor3 = c.ac, BackgroundTransparency = 0.93})
		tw(st, {Color = c.ac, Transparency = 0.67})
	end)
	f.MouseLeave:Connect(function()
		tw(f, {BackgroundColor3 = wt, BackgroundTransparency = 0.957})
		tw(st, {Color = wt, Transparency = 0.92})
	end)
	f.MouseButton1Down:Connect(function() tw(f, {BackgroundColor3 = c.ac, BackgroundTransparency = 0.85}, TweenInfo.new(0.05)) end)
	f.MouseButton1Up:Connect(function() tw(f, {BackgroundColor3 = uis.MouseEnabled and c.ac or wt, BackgroundTransparency = uis.MouseEnabled and 0.93 or 0.957}) end)
end

local function bx(p, w)
	local b = bt({AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(w or 150, 28), BackgroundColor3 = wt, BackgroundTransparency = 0.937, Parent = p}, {rc(8), sk(0.81, c.ac)})
	return b, b:FindFirstChildOfClass("UIStroke")
end

function L:Window(o)
	o = o or {}
	if not cfn(o.Config) then error("Window Failed: Bad Config", 0) end
	if ge.__BkW then pcall(ge.__BkW.Destroy, ge.__BkW) end
	local W = {Tabs = {}, Current = nil, cn = {}, key = o.Key == nil and Enum.KeyCode.LeftControl or o.Key, kw = false, fc = nil, sv = 1, gd = 0.82, hc = false, ag = 0, op = true, ln = false}
	local sg = gui()
	W.Gui = sg
	local mn = mk("Frame", {Name = "Main", Size = UDim2.fromOffset(ww, wh), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Parent = sg})
	W.Main = mn
	local sc = mk("UIScale", {Parent = mn})
	local shl = mk("Frame", {Name = "Shell", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), BackgroundColor3 = c.sh, BackgroundTransparency = 0.88, BorderSizePixel = 0, Parent = mn}, {rc(24), mk("UIStroke", {Color = wt, Thickness = 1.4}, {mk("UIGradient", {Rotation = 60, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, wt), ColorSequenceKeypoint.new(0.35, wt), ColorSequenceKeypoint.new(0.65, c.ac), ColorSequenceKeypoint.new(1, c.hi)}), Transparency = ns({0, 0, 0.35, 0.81, 0.65, 0.87, 1, 0.13})})})})
	local bks = {}
	for i, a in {{0, 0}, {1, 0}, {0, 1}, {1, 1}} do
		local x, y = a[1], a[2]
		local f = mk("Frame", {AnchorPoint = Vector2.new(x, y), Position = UDim2.new(x, x == 0 and -6 or 6, y, y == 0 and -6 or 6), Size = UDim2.fromOffset(20, 20), BackgroundTransparency = 1, ZIndex = 3, Name = "Bk" .. i, Parent = mn})
		mk("Frame", {AnchorPoint = Vector2.new(x, y), Position = UDim2.fromScale(x, y), Size = UDim2.fromOffset(20, 2), BackgroundColor3 = c.ac, BorderSizePixel = 0, ZIndex = 3, Parent = f})
		mk("Frame", {AnchorPoint = Vector2.new(x, y), Position = UDim2.fromScale(x, y), Size = UDim2.fromOffset(2, 20), BackgroundColor3 = c.ac, BorderSizePixel = 0, ZIndex = 3, Parent = f})
		bks[i] = {f, f.Position, UDim2.new(x, x == 0 and -36 or 36, y, y == 0 and -36 or 36)}
	end
	local cr = mk("Frame", {Name = "Core", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14), BackgroundColor3 = c.cr, BackgroundTransparency = 1 - W.gd, BorderSizePixel = 0, ClipsDescendants = true, Parent = mn}, {rc(18), sk(0.81, c.ac)})
	W.Core = cr
	local bgh = mk("Frame", {Name = "Fx", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = cr})
	local tb = mk("Frame", {Size = UDim2.new(1, 0, 0, th), BackgroundTransparency = 1, Parent = cr})
	local re, ra, rb = rx(tb, 30)
	re.Position = UDim2.fromOffset(16, 9)
	local ttx = tostring(o.Title or "BAKHI HUB")
	local tt = tl({Text = ttx, FontFace = fm, TextSize = 14, Position = UDim2.fromOffset(57, 8), Size = UDim2.new(1, -250, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3, Parent = tb})
	local t1 = tl({Text = ttx, FontFace = fm, TextSize = 14, TextColor3 = c.r1, TextTransparency = 0.45, Position = UDim2.fromOffset(56, 8), Size = tt.Size, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2, Parent = tb})
	local t2 = tl({Text = ttx, FontFace = fm, TextSize = 14, TextColor3 = c.r2, TextTransparency = 0.45, Position = UDim2.fromOffset(58, 8), Size = tt.Size, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2, Parent = tb})
	W.tt = {tt, t1, t2}
	local sbt = tl({Text = tostring(o.Subtitle or ""), FontFace = fb, TextSize = 10, TextColor3 = c.a2, Position = UDim2.fromOffset(57, 28), Size = UDim2.new(1, -250, 0, 12), TextTruncate = Enum.TextTruncate.AtEnd, Parent = tb})
	local function sst(s, a) W.ss.Text = `SYS <font color="#{c.ok:ToHex()}" transparency="{a or 0}">{s}</font>` end
	W.ss = tl({Text = `SYS <font color="#{c.ok:ToHex()}">ONLINE</font>`, RichText = true, FontFace = fj, TextSize = 10, TextColor3 = c.a2, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -84, 0, 0), Size = UDim2.fromOffset(100, th), Parent = tb})
	local function cap(x, g)
		local b = bt({Size = UDim2.fromOffset(28, 24), Position = UDim2.new(1, x, 0, 12), BackgroundColor3 = wt, Parent = tb}, {rc(6)})
		local i = ig({Text = g, Size = UDim2.fromScale(1, 1), Parent = b})
		b.MouseEnter:Connect(function() if uis.MouseEnabled then tw(b, {BackgroundTransparency = 0.9}) end end)
		b.MouseLeave:Connect(function() tw(b, {BackgroundTransparency = 1}) end)
		return b, i
	end
	local xb, xi = cap(-42, "x")
	local nb = cap(-74, "minus")
	local tsf = mk("Frame", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -12, 1, -12), Size = UDim2.fromOffset(300, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 100, Parent = sg}, {ll(8)})

	function W:Notify(n)
		n = n or {}
		if n.Title == nil and n.Text == nil then error("Notify Failed: No Text", 0) end
		local t = n.Time == nil and 4 or n.Time
		if type(t) ~= "number" or t ~= t or t <= 0 then error("Notify Failed: Bad Time", 0) end
		local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = c.cr, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 100, Parent = tsf}, {rc(12), sk(0.6, n.Error and c.er or c.ac), pd(20, 14, 10, 10)})
		mk("Frame", {Position = UDim2.fromOffset(-12, 2), Size = UDim2.new(0, 3, 1, -4), BackgroundColor3 = n.Error and c.er or c.ac, BorderSizePixel = 0, ZIndex = 101, Parent = f}, {rc(2)})
		local ly = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 101, Parent = f}, {ll(2)})
		tl({Text = tostring(n.Title or "BaKhi Hub"), FontFace = fb, Size = UDim2.new(1, 0, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 102, LayoutOrder = 1, Parent = ly})
		if n.Text ~= nil then tl({Text = tostring(n.Text), TextSize = 13, TextColor3 = c.dm, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, ZIndex = 102, LayoutOrder = 2, Parent = ly}) end
		local us = mk("UIScale", {Scale = 0.9, Parent = f})
		tw(us, {Scale = 1}, tb2)
		task.delay(t, function() if f.Parent then f:Destroy() end end)
		return f
	end

	local function run(f, ...)
		if not f then return end
		local ok, e = pcall(f, ...)
		if ok then return end
		warn("Callback Failed: " .. tostring(e))
		W:Notify({Title = "Callback Failed", Text = tostring(e), Error = true})
	end

	local cp, cd, dirty, pend, dead = o.Config and `BaKhi/Configs/{o.Config}.json`, {}, false, false, false
	if cp and isfile and isfile(cp) then
		local ok, d = pcall(function() return hs:JSONDecode(readfile(cp)) end)
		if ok and type(d) == "table" then cd = d else
			pcall(function() writefile(cp .. ".bad", readfile(cp)); delfile(cp) end)
			W:Notify({Title = "Config Load Failed", Text = "Invalid Json", Error = true})
		end
	end
	local function save()
		if not cp or not dirty then return end
		dirty = false
		pcall(function()
			mkd(cp)
			writefile(cp, hs:JSONEncode(cd))
		end)
	end
	local function put(e, v)
		if not e.Flag then return end
		L.Flags[e.Flag] = v
		if not cp then return end
		if e.sv then cd[e.Flag] = e.sv(v) else cd[e.Flag] = v end
		dirty = true
		if pend or dead then return end
		pend = true
		task.delay(0.5, function() pend = false; save() end)
	end
	local function done(e)
		if not e.Flag then return end
		L.Flags[e.Flag] = e:Get()
		local s = cd[e.Flag]
		if s == nil then return end
		pcall(function()
			if e.ld then s = e.ld(s) end
			e:Set(s)
		end)
	end

	local nv = mk("Frame", {Name = "Nav", Position = UDim2.fromOffset(12, th), Size = UDim2.new(0, nw, 1, -(th + 12)), BackgroundColor3 = wt, BackgroundTransparency = 0.969, BorderSizePixel = 0, Parent = cr}, {rc(14), pd(6, 6, 6, 6)})
	local tf = mk("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = nv})
	local ind = mk("Frame", {Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = c.ac, BorderSizePixel = 0, Visible = false, Parent = tf}, {rc(10), sk(0.53, c.ac), mk("UIGradient", {Transparency = ns({0, 0.69, 1, 0.92})})})
	mk("Frame", {Position = UDim2.fromOffset(0, 8), Size = UDim2.fromOffset(3, 16), BackgroundColor3 = c.ac, BorderSizePixel = 0, ZIndex = 2, Parent = ind}, {rc(2)})
	local pa = mk("Frame", {Name = "Pages", Position = UDim2.fromOffset(nw + 22, th), Size = UDim2.new(1, -(nw + 34), 1, -(th + 12)), BackgroundTransparency = 1, ClipsDescendants = true, Parent = cr})
	local ov = bt({Name = "Overlay", Size = UDim2.fromScale(1, 1), ZIndex = 50, Visible = false, Parent = mn})
	ov.Activated:Connect(function() if W.fc then W.fc() end end)

	local fl = bt({Name = "Float", Size = UDim2.fromOffset(44, 44), BackgroundColor3 = c.cr, BackgroundTransparency = 0.15, Parent = sg}, {rc(22), sk(0.45, c.ac)})
	local fr, fa, fq = rx(fl, 26)
	fr.AnchorPoint, fr.Position = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5)
	for _, x in fr:GetDescendants() do
		if x:IsA("GuiObject") then x.Active = false end
	end

	local function fx()
		W.sv = fit(sg, mn, sc)
		fl.Position = UDim2.fromOffset(16, gs:GetGuiInset().Y + 8)
	end
	fx()
	table.insert(W.cn, sg:GetPropertyChangedSignal("AbsoluteSize"):Connect(fx))

	local lv = {Full = true, Light = true, Off = true}
	W.fx, W.ba, W.on, W.bk = lv[cd.fx] and cd.fx or ((uis.TouchEnabled and not uis.MouseEnabled) and "Light" or "Full"), cd.ba ~= false, false, false
	if type(cd.gd) == "number" and cd.gd == cd.gd then W.gd = math.clamp(cd.gd, 40, 95) / 100 end
	cr.BackgroundTransparency = 1 - W.gd
	local hr = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -65, 1, -55), Size = UDim2.fromOffset(250, 250), BackgroundTransparency = 1, Parent = bgh})
	local hl, pt = {}, {}
	for _, d in {{236, 1, 0.55, {0, 0, 0.3, 0, 0.31, 1, 0.45, 1, 0.46, 0, 1, 0}, 20}, {214, 5, 0.78, {0, 0, 0.6, 0, 0.61, 1, 1, 1}, -12}, {176, 2, 0.6, {0, 1, 0.2, 1, 0.21, 0, 0.5, 0, 0.51, 1, 0.75, 1, 0.76, 0, 1, 0}, -40}, {128, 1, 0.65}, {100, 3, 0.55, {0, 0, 0.25, 0, 0.26, 1, 1, 1}, 72}} do
		local r = rg(d[1], d[2], c.ac, d[3], d[4])
		r.Parent = hr
		if d[5] then hl[#hl + 1] = {r, d[5]} end
	end
	for i = 1, 12 do
		pt[i] = {f = mk("Frame", {Size = UDim2.fromOffset(3, 3), BackgroundColor3 = c.ac, BackgroundTransparency = 1, BorderSizePixel = 0, Parent = bgh}, {rc(2)}), t = math.random(), d = 5 + math.random() * 7, x = math.random(), y = 0.6 + math.random() * 0.45}
	end
	local swp = mk("Frame", {Name = "Sweep", Size = UDim2.fromScale(1, 1), BackgroundColor3 = wt, BorderSizePixel = 0, ZIndex = 40, Parent = cr}, {rc(18)})
	local sgd = mk("UIGradient", {Rotation = 20, Offset = Vector2.new(-1, 0), Transparency = ns({0, 1, 0.42, 1, 0.47, 0.82, 0.5, 0.74, 0.53, 0.82, 0.58, 1, 1, 1}), Parent = swp})
	local ru = game:GetService("RunService")
	local s0, b0 = 3, 0
	local function hb(dt)
		for _, x in {{ra, 164}, {rb, -90}, {fa, 164}, {fq, -90}} do x[1].Rotation = (x[1].Rotation + x[2] * dt) % 360 end
		if W.fx == "Full" then
			for _, x in hl do x[1].Rotation = (x[1].Rotation + x[2] * dt) % 360 end
			for _, q in pt do
				q.t += dt / q.d
				if q.t >= 1 then q.t, q.x, q.y, q.d = 0, math.random(), 0.6 + math.random() * 0.45, 5 + math.random() * 7 end
				q.f.Position, q.f.BackgroundTransparency = UDim2.new(q.x, 0, q.y, -q.t * 260), 1 - (q.t < 0.15 and q.t / 0.15 or (1 - q.t) / 0.85) * 0.8
			end
		end
		s0 += dt
		if s0 >= (W.fx == "Full" and 6 or 12) then
			s0, sgd.Offset = 0, Vector2.new(-1, 0)
			tw(sgd, {Offset = Vector2.new(1, 0)}, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
		end
		b0 += dt
		if W.on and b0 >= 0.7 then
			b0, W.bk = 0, not W.bk
			sst("ONLINE", W.bk and 0.65 or 0)
		end
	end
	function W.up()
		local on = mn.Visible and W.fx ~= "Off" and not dead
		if on and not W.hc then W.hc = ru.Heartbeat:Connect(hb) elseif not on and W.hc then W.hc:Disconnect(); W.hc = false end
		hr.Visible = W.fx == "Full"
		for _, q in pt do q.f.Visible = W.fx == "Full" end
		if W.fx == "Off" and W.on then sst("ONLINE") end
	end
	function W:Effects(v)
		if not lv[v] then error("Effects Failed: Bad Level", 0) end
		W.fx = v
		W.up()
	end
	local function fl2(f)
		if W.fx == "Off" then return end
		f.BackgroundColor3, f.BackgroundTransparency = c.ac, 0.75
		tw(f, {BackgroundColor3 = wt, BackgroundTransparency = 0.957}, TweenInfo.new(0.5))
	end
	local function rpl(a)
		if W.fx == "Off" then return end
		local r = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(), BackgroundTransparency = 1, ZIndex = 5, Parent = a}, {rc(200), sk(0, c.ac, 2)})
		tw(r, {Size = UDim2.fromOffset(120, 120)}, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
		tw(r:FindFirstChildOfClass("UIStroke"), {Transparency = 1}, TweenInfo.new(0.6))
		task.delay(0.65, function() r:Destroy() end)
	end
	local function scn(f, d)
		if W.fx == "Off" or not f:IsA("GuiButton") then return end
		local s = mk("Frame", {Position = UDim2.fromOffset(-94, 0), Size = UDim2.new(0, 60, 1, 0), BackgroundColor3 = c.ac, BorderSizePixel = 0, ZIndex = 4, Parent = f}, {mk("UIGradient", {Transparency = ns({0, 1, 0.5, 0.6, 1, 1})})})
		task.delay(d, function() if s.Parent then tw(s, {Position = UDim2.new(1, 20, 0, 0)}, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)) end end)
		task.delay(d + 0.75, function() s:Destroy() end)
	end
	local function glt(p)
		if W.fx == "Off" then return end
		for i, q in {{4, 52, 62}, {-3, 59, 53}, {0, 56, 58}} do
			task.delay((i - 1) * 0.09, function()
				p.Position = UDim2.fromOffset(q[1], 0)
				t1.Position, t2.Position = UDim2.fromOffset(q[2], 8), UDim2.fromOffset(q[3], 8)
			end)
		end
		for i, e in W.Current.Rows do scn(e.Row, 0.05 + (i - 1) * 0.06) end
	end
	local function ty(ls, sp, g)
		local n = utf8.len(ls[1].Text) or #ls[1].Text
		for i = 0, n do
			if dead or W.ag ~= g then return end
			for _, l in ls do l.MaxVisibleGraphemes = i end
			task.wait(sp)
		end
		for _, l in ls do l.MaxVisibleGraphemes = -1 end
	end
	local t0 = TweenInfo.new(0)
	local function lnf(w)
		if W.ln then W.ln:Destroy() end
		W.ln = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(w, 0, 0, 2), BackgroundColor3 = wt, BorderSizePixel = 0, ZIndex = 6, Parent = mn}, {mk("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, c.ac), ColorSequenceKeypoint.new(0.5, wt), ColorSequenceKeypoint.new(1, c.ac)}), Transparency = ns({0, 1, 0.2, 0, 0.8, 0, 1, 1})})})
		return W.ln
	end
	local function whole()
		if W.ln then W.ln:Destroy(); W.ln = false end
		tw(shl, {Size = UDim2.fromScale(1, 1)}, t0)
		cr.Visible = true
		for _, b in bks do
			b[1].Visible = true
			tw(b[1], {Position = b[2]}, t0)
		end
		for _, l in {tt, t1, t2, sbt} do l.MaxVisibleGraphemes = -1 end
		for _, T in W.Tabs do tw(T.nm, {TextTransparency = 0}, t0) end
		ind.Visible = W.Current ~= nil
		W.on = true
		sst("ONLINE")
	end
	local function boot(g)
		local k = W.fx == "Light" and 0.4 or 1
		W.on = false
		sst("BOOT")
		local ln = lnf(0)
		tw(shl, {Size = UDim2.new(1, 0, 0, 2)}, t0)
		cr.Visible = false
		for _, b in bks do
			b[1].Visible = false
			tw(b[1], {Position = b[3]}, t0)
		end
		for _, l in {tt, t1, t2, sbt} do l.MaxVisibleGraphemes = 0 end
		task.spawn(function()
			local function z(s) task.wait(s * k); return dead or W.ag ~= g end
			tw(ln, {Size = UDim2.new(1, 0, 0, 2)}, TweenInfo.new(0.35 * k, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			if z(0.35) then return end
			tw(ln, {BackgroundTransparency = 1}, TweenInfo.new(0.4 * k))
			tw(shl, {Size = UDim2.fromScale(1, 1)}, TweenInfo.new(0.45 * k, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
			if z(0.4) then return end
			for _, T in W.Tabs do tw(T.nm, {TextTransparency = 1}, t0) end
			ind.Visible = false
			for _, s in {0.06, 0.05, 0.07, 0.04, 0.08, 0.05} do
				cr.Visible = not cr.Visible
				if z(s) then return end
			end
			cr.Visible = true
			if W.ln == ln then ln:Destroy(); W.ln = false end
			for _, b in bks do
				b[1].Visible = true
				tw(b[1], {Position = b[2]}, TweenInfo.new(0.45 * k, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
			end
			task.spawn(ty, {tt, t1, t2}, 0.055 * k, g)
			task.delay(0.4 * k, ty, {sbt}, 0.022 * k, g)
			if z(0.25) then return end
			for i, T in W.Tabs do task.delay((i - 1) * 0.07 * k, function() if W.ag == g then tw(T.nm, {TextTransparency = 0}) end end) end
			if z(0.2) then return end
			ind.Visible = W.Current ~= nil
			for i, e in W.Current and W.Current.Rows or {} do scn(e.Row, (i - 1) * 0.08 * k) end
			if z(0.6) then return end
			W.on = true
			sst("ONLINE")
		end)
	end
	local function fold(g)
		local k = W.fx == "Light" and 0.4 or 1
		local function z(s) task.wait(s * k); return dead or W.ag ~= g end
		W.on = false
		sst("OFFLINE")
		for _, b in bks do tw(b[1], {Position = b[3]}, TweenInfo.new(0.2 * k, Enum.EasingStyle.Quad, Enum.EasingDirection.In)) end
		if z(0.15) then return end
		for _, b in bks do b[1].Visible = false end
		for _, s in {0.04, 0.05, 0.03, 0.05} do
			cr.Visible = not cr.Visible
			if z(s) then return end
		end
		cr.Visible = false
		local ln = lnf(1)
		tw(shl, {Size = UDim2.new(1, 0, 0, 2)}, TweenInfo.new(0.25 * k, Enum.EasingStyle.Quint, Enum.EasingDirection.In))
		if z(0.25) then return end
		tw(ln, {Size = UDim2.new(0, 0, 0, 2)}, TweenInfo.new(0.2 * k, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
		if z(0.2) then return end
		if W.ln == ln then ln:Destroy(); W.ln = false end
		mn.Visible = false
		W.up()
	end
	local function an2() return W.ba and W.fx ~= "Off" end

	function W:Show()
		W.ag += 1
		W.op, mn.Visible, sc.Scale = true, true, W.sv
		W.up()
		if an2() then boot(W.ag) else whole() end
	end
	function W:Hide()
		W.ag += 1
		W.op = false
		if an2() and mn.Visible then task.spawn(fold, W.ag); return end
		whole()
		mn.Visible = false
		W.up()
	end
	local function tg() if W.op then W:Hide() else W:Show() end end
	fl.Activated:Connect(tg)
	nb.Activated:Connect(function() W:Hide() end)
	local arm, an = false, 0
	xb.Activated:Connect(function()
		if arm then (W :: any):Destroy(); return end
		arm, an = true, an + 1
		local n = an
		tw(xb, {BackgroundColor3 = c.er, BackgroundTransparency = 0})
		xi.TextColor3 = wt
		task.delay(3, function()
			if an ~= n or not arm then return end
			arm = false
			tw(xb, {BackgroundColor3 = wt, BackgroundTransparency = 1})
			xi.TextColor3 = c.dm
		end)
	end)

	local dr
	table.insert(W.cn, tb.InputBegan:Connect(function(i)
		if i.UserInputType ~= mb and i.UserInputType ~= tc then return end
		local p0, d0 = mn.Position, i.Position
		dr = {i = i, mv = function(p)
			local s, n, hw, hh = sg.AbsoluteSize, gs:GetGuiInset().Y, mn.AbsoluteSize.X / 2, mn.AbsoluteSize.Y / 2
			mn.Position = UDim2.fromOffset(math.clamp(p0.X.Offset + p.X - d0.X, hw, s.X - hw), math.clamp(p0.Y.Offset + p.Y - d0.Y, n + hh, s.Y - hh))
		end}
	end))
	table.insert(W.cn, uis.InputChanged:Connect(function(i)
		if not dr or (i.UserInputType ~= mm and i ~= dr.i) then return end
		dr.mv(i.Position)
	end))
	table.insert(W.cn, uis.InputEnded:Connect(function(i)
		if not dr or (i ~= dr.i and i.UserInputType ~= mb) then return end
		if dr.up then dr.up() end
		dr = nil
	end))
	table.insert(W.cn, uis.InputBegan:Connect(function(i)
		if i.UserInputType ~= kb or W.kw or not W.key or i.KeyCode ~= W.key or uis:GetFocusedTextBox() then return end
		tg()
	end))

	function W:Tab(t)
		t = t or {}
		local T = {Rows = {}, Name = tostring(t.Name or "Tab"), W = W, n = 0, sec = nil, i = #W.Tabs + 1}
		local b = bt({Position = UDim2.fromOffset(0, (T.i - 1) * 36), Size = UDim2.new(1, 0, 0, 32), ZIndex = 2, Parent = tf})
		local nm = tl({Text = T.Name, FontFace = fs, TextSize = 13, TextColor3 = c.dm, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -16, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2, Parent = b})
		local p = mk("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = c.a2, ScrollBarImageTransparency = 0.4, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, Parent = pa}, {ll(6), pd(1, 8, 1, 4)})
		T.Page, T.Btn, T.nm = p, b, nm
		function T.pt(on) tw(nm, {TextColor3 = on and wt or c.dm}) end
		b.MouseEnter:Connect(function() if uis.MouseEnabled and W.Current ~= T then tw(nm, {TextColor3 = c.a2}) end end)
		b.MouseLeave:Connect(function() if W.Current ~= T then tw(nm, {TextColor3 = c.dm}) end end)
		function T:Select()
			if W.Current == T then return end
			local f = W.Current == nil
			if W.Current then W.Current.Page.Visible = false; W.Current.pt(false) end
			W.Current, p.Visible = T, true
			T.pt(true)
			local y = UDim2.fromOffset(0, (T.i - 1) * 36)
			if f then ind.Position, ind.Visible = y, true else tw(ind, {Position = y}, tb2); glt(p) end
		end
		b.Activated:Connect(function() T:Select() end)
		table.insert(W.Tabs, T)
		if not W.Current then T:Select() end

		local function add(e)
			T.n += 1
			e.Row.LayoutOrder = T.n
			table.insert(T.Rows, e)
			return e
		end
		local function row(k, r)
			if type(r.Name) ~= "string" then error(`{k} Failed: Bad Name`, 0) end
			if r.Flag ~= nil and type(r.Flag) ~= "string" then error(`{k} Failed: Bad Flag`, 0) end
			local f = bt({Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = wt, BackgroundTransparency = 0.957, ClipsDescendants = true, Parent = p}, {rc(12), sk(0.92), pd(14, 14)})
			hv(f, f:FindFirstChildOfClass("UIStroke"))
			local l = tl({Text = r.Name, FontFace = fs, Size = UDim2.new(0.5, 0, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = f})
			local e = {Row = f, Kind = k, Name = r.Name, Flag = r.Flag, Tab = T, Sec = T.sec, Label = l}
			function e:Get() return (e :: any).v end
			return add(e), f, l
		end
		local function txt(e, l, u)
			local s0 = l.Text
			function e:Set(s) s0 = tostring(s); l.Text = u and s0:upper() or s0 end
			function e:Get() return s0 end
			e:Set(s0)
			return e
		end

		function T:Section(r)
			r = r or {}
			local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1, Parent = p})
			local l = tl({Text = tostring(r.Name or ""), FontFace = fj, TextSize = 11, TextColor3 = c.a2, Position = UDim2.fromOffset(4, 10), Size = UDim2.new(0, 0, 0, 14), AutomaticSize = Enum.AutomaticSize.X, Parent = f})
			local ln = mk("Frame", {AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = c.ac, BorderSizePixel = 0, Parent = f}, {mk("UIGradient", {Transparency = ns({0, 0.6, 1, 1})})})
			local function lay() ln.Position, ln.Size = UDim2.fromOffset(l.AbsoluteSize.X / math.max(sc.Scale, 0.01) + 12, 17), UDim2.new(1, -(l.AbsoluteSize.X / math.max(sc.Scale, 0.01) + 16), 0, 1) end
			l:GetPropertyChangedSignal("AbsoluteSize"):Connect(lay)
			lay()
			T.sec = r.Name and tostring(r.Name) or ""
			return txt(add({Row = f, Kind = "Section", Name = T.sec, Tab = T}), l, true)
		end

		function T:Label(r)
			r = r or {}
			local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = wt, BackgroundTransparency = 0.957, BorderSizePixel = 0, Parent = p}, {rc(12), sk(0.92), pd(14, 14, 10, 10)})
			local l = tl({Text = tostring(r.Text or ""), TextSize = 13, TextColor3 = c.dm, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, Parent = f})
			return txt(add({Row = f, Kind = "Label", Name = l.Text, Tab = T, Sec = T.sec}), l)
		end

		function T:Button(r)
			r = r or {}
			local e, f, l = row("Button", r)
			ig({Text = "chevron-small-right", TextColor3 = c.a2, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(16, 40), Parent = f})
			f.Activated:Connect(function()
				fl2(f)
				run(r.Callback)
			end)
			return txt(e, l)
		end

		function T:Toggle(r)
			r = r or {}
			local e, f = row("Toggle", r)
			local sw = mk("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(42, 22), BackgroundColor3 = wt, BackgroundTransparency = 0.84, BorderSizePixel = 0, Parent = f}, {rc(11)})
			local kn = mk("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(18, 18), BackgroundColor3 = hx("D6E6EE"), BorderSizePixel = 0, Parent = sw}, {rc(9)})
			e.sw, e.v, e.ld = sw, r.Default == true, function(s) return s == true end
			local function draw(a)
				local on = e.v
				local q = {sw, {BackgroundColor3 = on and c.ac or wt, BackgroundTransparency = on and 0 or 0.84}, kn, {Position = UDim2.new(0, on and 22 or 2, 0.5, 0), BackgroundColor3 = on and wt or hx("D6E6EE")}}
				for i = 1, #q, 2 do
					if a then tw(q[i], q[i + 1], i == 3 and tb2 or ti) else for k, v in q[i + 1] do q[i][k] = v end end
				end
			end
			draw(false)
			function e:Set(v)
				v = v == true
				if v == e.v then return end
				e.v = v
				draw(true)
				put(e, v)
				run(r.Callback, v)
			end
			f.Activated:Connect(function()
				e:Set(not e.v)
				rpl(sw)
				fl2(f)
			end)
			done(e)
			return e
		end

		function T:Slider(r)
			r = r or {}
			local lo, hi, st = tonumber(r.Min), tonumber(r.Max), r.Step == nil and 1 or tonumber(r.Step)
			if not (lo and hi and hi > lo) then error("Slider Failed: Bad Range", 0) end
			if not (st and st > 0) then error("Slider Failed: Bad Step", 0) end
			local e, f = row("Slider", r)
			local vl = mk("TextBox", {BackgroundTransparency = 1, Text = "", FontFace = fj, TextSize = 12, TextColor3 = c.a2, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(40, 40), TextXAlignment = Enum.TextXAlignment.Right, ClearTextOnFocus = false, Parent = f})
			local hit = bt({AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -52, 0.5, 0), Size = UDim2.fromOffset(110, 28), Parent = f})
			local tr = mk("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 5), BackgroundColor3 = wt, BackgroundTransparency = 0.84, BorderSizePixel = 0, Parent = hit}, {rc(3)})
			local fi = mk("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = c.ac, BorderSizePixel = 0, Parent = tr}, {rc(3)})
			local kn = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = wt, BorderSizePixel = 0, Parent = hit}, {rc(8), sk(0.55, c.ac, 3)})
			local function q(v) return math.clamp(lo + math.round((v - lo) / st) * st, lo, hi) end
			local d0 = r.Default
			e.v, e.ld = q(type(d0) == "number" and d0 == d0 and d0 or lo), tonumber
			local function draw()
				local a = (e.v - lo) / (hi - lo)
				fi.Size, kn.Position, vl.Text = UDim2.new(a, 0, 1, 0), UDim2.new(a, 0, 0.5, 0), ("%g"):format(e.v)
			end
			draw()
			function e:Set(v)
				if type(v) ~= "number" or v ~= v then error("Slider Set Failed: Not A Number", 0) end
				v = q(v)
				if v == e.v then return end
				e.v = v
				draw()
				put(e, v)
				run(r.Callback, v)
			end
			vl.FocusLost:Connect(function()
				local n = tonumber(vl.Text)
				if n and n == n then e:Set(n) end
				draw()
			end)
			local function at(x) e:Set(lo + math.clamp((x - hit.AbsolutePosition.X) / hit.AbsoluteSize.X, 0, 1) * (hi - lo)) end
			hit.InputBegan:Connect(function(i)
				if i.UserInputType ~= mb and i.UserInputType ~= tc then return end
				p.ScrollingEnabled = false
				dr = {i = i, mv = function(v) at(v.X) end, up = function() p.ScrollingEnabled = true end}
				at(i.Position.X)
			end)
			done(e)
			return e
		end

		function T:Dropdown(r)
			r = r or {}
			if type(r.Options) ~= "table" then error("Dropdown Failed: Bad Options", 0) end
			local e, f = row("Dropdown", r)
			local mu = r.Multi == true
			e.Options = {}
			local function opts(l)
				local seen = {}
				e.Options = {}
				for _, s in l do
					if type(s) == "string" and not seen[s] then seen[s] = true; table.insert(e.Options, s) end
				end
			end
			opts(r.Options)
			local box = bx(f)
			local bl = tl({Text = "", FontFace = fs, TextSize = 12, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = box})
			local ch = ig({Text = "chevron-small-down", TextColor3 = c.a2, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 0), Size = UDim2.fromOffset(16, 28), Parent = box})
			local function norm(v)
				if mu then
					if type(v) ~= "table" then error("Dropdown Set Failed: Not A Table", 0) end
					local wn, out = {}, {}
					for _, s in v do wn[s] = true end
					for _, s in e.Options do
						if wn[s] then table.insert(out, s) end
					end
					return out
				end
				if v == nil then return nil end
				if table.find(e.Options, v) then return v end
				error("Dropdown Set Failed: Unknown Option", 0)
			end
			local function same(a, b)
				if not mu then return a == b end
				if #a ~= #b then return false end
				for i, s in a do
					if b[i] ~= s then return false end
				end
				return true
			end
			e.v = if mu then (if type(r.Default) == "table" then norm(r.Default) else {}) else (if table.find(e.Options, r.Default) then r.Default else nil)
			if mu then e.ld = function(s) return type(s) == "table" and s or {} end else e.sv, e.ld = function(v) return if v == nil then false else v end, function(s) return s ~= false and s or nil end end
			local function has(s) return mu and table.find(e.v, s) ~= nil or not mu and e.v == s end
			local function draw()
				local an = mu and #e.v > 0 or not mu and e.v ~= nil
				bl.Text, bl.TextColor3 = an and (mu and table.concat(e.v, ", ") or e.v) or "None", an and wt or c.dm
			end
			draw()
			function e:Get() return mu and table.clone(e.v) or e.v end
			local function emit(v)
				e.v = v
				draw()
				put(e, e:Get())
				run(r.Callback, e:Get())
			end
			function e:Set(v)
				v = norm(v)
				if same(v, e.v) then return end
				emit(v)
			end
			function e:Refresh(l)
				if type(l) ~= "table" then error("Dropdown Refresh Failed: Bad Options", 0) end
				opts(l)
				local v = mu and norm(e.v) or (table.find(e.Options, e.v) and e.v or nil)
				if not same(v, e.v) then emit(v) end
				draw()
			end
			local fy
			local function close()
				if not fy then return end
				fy:Destroy()
				fy, ov.Visible, ch.Text, W.fc = nil, false, "chevron-small-down", nil
			end
			local function open()
				if fy then close(); return end
				if W.fc then W.fc() end
				W.fc, ov.Visible, ch.Text = close, true, "chevron-small-up"
				local s, bp = sc.Scale, (box.AbsolutePosition - mn.AbsolutePosition) / sc.Scale
				local h = math.max(math.min(#e.Options, 5), 1) * 30 + 8
				local y = bp.Y + 32
				if y + h > wh - 8 then y = bp.Y - h - 4 end
				fy = mk("Frame", {Position = UDim2.fromOffset(bp.X, y), Size = UDim2.fromOffset(box.AbsoluteSize.X / s, h), BackgroundColor3 = c.cr, BackgroundTransparency = 0.05, BorderSizePixel = 0, Parent = ov}, {rc(10), sk(0.6, c.ac), pd(4, 4, 4, 4)})
				local ls = mk("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = c.a2, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), ScrollingDirection = Enum.ScrollingDirection.Y, Parent = fy}, {ll(0)})
				if #e.Options == 0 then tl({Text = "No Options", TextSize = 12, TextColor3 = c.dm, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -10, 0, 30), Parent = ls}) end
				for n, s in e.Options do
					local sl = has(s)
					local b = bt({Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = c.ac, BackgroundTransparency = sl and 0.8 or 1, LayoutOrder = n, Parent = ls}, {rc(6)})
					tl({Text = s, FontFace = fs, TextSize = 12, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -36, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = b})
					local ck = ig({Text = "check", TextColor3 = c.ac, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 0), Size = UDim2.fromOffset(16, 30), Visible = sl, Parent = b})
					b.MouseEnter:Connect(function() if uis.MouseEnabled then tw(b, {BackgroundTransparency = 0.88}) end end)
					b.MouseLeave:Connect(function() tw(b, {BackgroundTransparency = has(s) and 0.8 or 1}) end)
					b.Activated:Connect(function()
						if not mu then e:Set(s); close(); return end
						local v, i = e:Get(), table.find(e.v, s)
						if i then table.remove(v, i) else table.insert(v, s) end
						e:Set(v)
						ck.Visible = has(s)
						tw(b, {BackgroundTransparency = ck.Visible and 0.8 or 1})
					end)
				end
			end
			box.Activated:Connect(open)
			done(e)
			return e
		end

		function T:TextBox(r)
			r = r or {}
			local e, f = row("TextBox", r)
			local b, st = bx(f)
			b.ClipsDescendants = true
			local x = mk("TextBox", {BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), FontFace = fs, TextSize = 12, TextColor3 = wt, PlaceholderText = tostring(r.Placeholder or ""), PlaceholderColor3 = c.dm, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Text = type(r.Default) == "string" and r.Default or "", Parent = b})
			e.v, e.ld = x.Text, tostring
			function e:Set(v)
				v = tostring(v)
				x.Text = v
				if v == e.v then return end
				e.v = v
				put(e, v)
				run(r.Callback, v)
			end
			x.Focused:Connect(function() tw(st, {Transparency = 0}) end)
			x.FocusLost:Connect(function()
				tw(st, {Transparency = 0.81})
				e:Set(x.Text)
			end)
			done(e)
			return e
		end

		local function kc(v)
			if v == nil then return nil end
			if typeof(v) == "EnumItem" and v.EnumType == Enum.KeyCode then return v end
			return false
		end

		function T:Keybind(r)
			r = r or {}
			local d = kc(r.Default)
			if d == false then error("Keybind Failed: Bad Key", 0) end
			local e, f = row("Keybind", r)
			local cb, st = bx(f, 0)
			cb.Size, cb.AutomaticSize = UDim2.fromOffset(0, 24), Enum.AutomaticSize.X
			pd(10, 10).Parent = cb
			local kl = tl({Text = "", FontFace = fj, TextSize = 11, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, TextXAlignment = Enum.TextXAlignment.Center, Parent = cb})
			local wk = false
			e.v, e.sv, e.ld = d, function(v) return v and v.Name or false end, function(s) return type(s) == "string" and Enum.KeyCode[s] or nil end
			local function draw()
				kl.Text, kl.TextColor3 = wk and "..." or (e.v and e.v.Name:upper() or "NONE"), (wk or e.v) and wt or c.dm
				st.Transparency = wk and 0 or 0.81
			end
			draw()
			function e:Set(v)
				local k = kc(v)
				if k == false then error("Keybind Set Failed: Bad Key", 0) end
				if k == e.v then return end
				e.v = k
				draw()
				put(e, k)
			end
			cb.Activated:Connect(function()
				wk = not wk
				W.kw = wk
				draw()
			end)
			table.insert(W.cn, uis.InputBegan:Connect(function(i, gp)
				if i.UserInputType ~= kb then return end
				if wk then
					wk, W.kw = false, false
					if i.KeyCode == Enum.KeyCode.Backspace then e:Set(nil) elseif i.KeyCode ~= Enum.KeyCode.None then e:Set(i.KeyCode) end
					draw()
					return
				end
				if gp or not e.v or i.KeyCode ~= e.v or uis:GetFocusedTextBox() then return end
				run(r.Callback)
			end))
			done(e)
			return e
		end

		return T
	end

	function W:Interface(T)
		T:Section({Name = "Interface"})
		T:Dropdown({Name = "Effects", Options = {"Full", "Light", "Off"}, Default = W.fx, Flag = "fx", Callback = function(v) W:Effects(v or "Full") end})
		T:Slider({Name = "Glass Density", Min = 40, Max = 95, Step = 1, Default = math.round(W.gd * 100), Flag = "gd", Callback = function(v)
			W.gd = v / 100
			cr.BackgroundTransparency = 1 - W.gd
		end})
		T:Toggle({Name = "Boot Animation", Default = W.ba, Flag = "ba", Callback = function(v) W.ba = v end})
	end

	function W:Destroy()
		dead = true
		for _, x in W.cn do x:Disconnect() end
		W.cn = {}
		if W.hc then W.hc:Disconnect(); W.hc = false end
		save()
		sg:Destroy()
		if ge.__BkW == W then ge.__BkW = nil end
	end

	if an2() then boot(W.ag) else whole() end
	W.up()
	ge.__BkW = W
	return W
end

return L
end)()

local function bo()
	if ge.__SaeP then return nil, "Already On" end
	ge.__SaeP = true
	local li, tr = game:GetService("Lighting"), workspace.Terrain
	local function ko(d, k)
		k = k or "Enabled"
		d[k] = false
		d:GetPropertyChangedSignal(k):Connect(function() if d[k] then d[k] = false end end)
	end
	local function lf() if li.GlobalShadows then li.GlobalShadows = false end end
	lf()
	li:GetPropertyChangedSignal("GlobalShadows"):Connect(lf)
	local function kx(d) if d:IsA("PostEffect") then ko(d) end end
	for _, d in li:GetDescendants() do pcall(kx, d) end
	li.DescendantAdded:Connect(function(d) pcall(kx, d) end)
	local cu = tr:FindFirstChildOfClass("Clouds")
	if cu then pcall(ko, cu) end
	pcall(function() tr.WaterWaveSize, tr.WaterWaveSpeed, tr.WaterReflectance = 0, 0, 0 end)
	local function px(d)
		if d:IsA("ParticleEmitter") then
			d.Lifetime = NumberRange.new(0)
			ko(d)
		elseif d:IsA("Beam") or d:IsA("Trail") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") or d:IsA("Light") or d:IsA("Highlight") then
			ko(d)
		elseif d:IsA("Decal") then
			d.Transparency = 1
		elseif d:IsA("SurfaceAppearance") then
			task.defer(pcall, d.Destroy, d)
		elseif d:IsA("VideoFrame") then
			ko(d, "Playing")
			ko(d, "Visible")
		elseif d:IsA("BasePart") and d.Material ~= Enum.Material.Water then
			d.Material, d.Reflectance, d.CastShadow = Enum.Material.SmoothPlastic, 0, false
		end
	end
	workspace.DescendantAdded:Connect(function(d) pcall(px, d) end)
	task.spawn(function()
		for i, d in workspace:GetDescendants() do
			pcall(px, d)
			if i % 2000 == 0 then task.wait() end
		end
	end)
	local pg2 = lp:FindFirstChildOfClass("PlayerGui")
	if pg2 then
		for _, d in pg2:GetDescendants() do if d:IsA("VideoFrame") then pcall(px, d) end end
		pg2.DescendantAdded:Connect(function(d) if d:IsA("VideoFrame") then pcall(px, d) end end)
	end
	local ok, aa = pcall(function() return require(rs.Controllers.Game.Plots.ActiveAssetsController) end)
	if ok and type(aa) == "table" and type(aa.SetAllPetsHidden) == "function" then
		task.spawn(function()
			while ge.__SaeP do
				pcall(aa.SetAllPetsHidden, true)
				task.wait(5)
			end
		end)
	end
	local ui = game:GetService("UserInputService")
	ui.WindowFocusReleased:Connect(function() pcall(ru.Set3dRenderingEnabled, ru, false) end)
	ui.WindowFocused:Connect(function() pcall(ru.Set3dRenderingEnabled, ru, true) end)
	local function ax(d)
		if d:IsA("Accoutrement") or d:IsA("Clothing") or d:IsA("ShirtGraphic") or d:IsA("CharacterMesh") then task.defer(pcall, d.Destroy, d) end
	end
	local function cx(c)
		for _, d in c:GetDescendants() do pcall(ax, d) end
		c.DescendantAdded:Connect(function(d) pcall(ax, d) end)
	end
	local function pa(p)
		if p == lp then return end
		if p.Character then cx(p.Character) end
		p.CharacterAdded:Connect(cx)
	end
	for _, p in ps:GetPlayers() do pa(p) end
	ps.PlayerAdded:Connect(pa)
	if not ok then return nil, "Hide Pets Failed: No Controller" end
	return true
end

local function hx(lo2)
	local hs, ts = game:GetService("HttpService"), game:GetService("TeleportService")
	local function go2(f)
		local fe
		local cn = ts.TeleportInitFailed:Connect(function(p, _, m) if p == lp then fe = tostring(m) end end)
		local o3, e3 = pcall(f)
		if not o3 then fe = tostring(e3) end
		local t = os.clock()
		while not fe and os.clock() - t < 10 do task.wait(0.25) end
		cn:Disconnect()
		return fe == nil
	end
	while ge.__BkSae == st do
		local ok, r = pcall(function() return game:HttpGet(("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId), true) end)
		local o2, d = false, nil
		if ok then o2, d = pcall(hs.JSONDecode, hs, r) end
		local l = {}
		for _, v in o2 and type(d) == "table" and type(d.data) == "table" and d.data or {} do
			if v.id ~= game.JobId and type(v.playing) == "number" and type(v.maxPlayers) == "number" and v.playing < v.maxPlayers then l[#l + 1] = v end
		end
		if lo2 then
			table.sort(l, function(x, y) return x.playing < y.playing end)
		else
			for i = #l, 2, -1 do
				local j = math.random(1, i)
				l[i], l[j] = l[j], l[i]
			end
		end
		for _, v in l do
			if ge.__BkSae ~= st then return false, "Hop Failed: Stopped" end
			if go2(function() ts:TeleportToPlaceInstance(game.PlaceId, v.id, lp) end) then return true end
			task.wait(1)
		end
		if not lo2 and ge.__BkSae == st and go2(function() ts:Teleport(game.PlaceId, lp) end) then return true end
		task.wait(3)
	end
	return false, "Hop Failed: Stopped"
end

local W = L:Window({Title = "BAKHI HUB", Subtitle = "STEAL AN EGG v1.1 | YTB PHU ROBLOX", Config = `StealAnEgg/{lp.Name}`})
do
	local wn = W.Notify
	W.Notify = function(s2, o)
		pcall(zx, `[{tostring(type(o) == "table" and o.Title)}] {tostring(type(o) == "table" and o.Text)}`)
		return wn(s2, o)
	end
	local ex = identifyexecutor and select(2, pcall(identifyexecutor)) or "?"
	local ui = game:GetService("UserInputService")
	zx(`[Hub] Loaded | Place {game.PlaceVersion} | Server {game.JobId:sub(1, 8)} | {#ps:GetPlayers()} Players | {tostring(ex)} | {ui.TouchEnabled and not ui.KeyboardEnabled and "Mobile" or "PC"}`, true)
end
st.nt = function(n, m) W:Notify({Title = n, Text = m, Error = true}) end
local pg = W:Tab({Name = "General", Icon = "egg"})
local function rk()
	local m, o = {}, {}
	for _, a in pairs(dr) do
		local r = type(a) == "table" and a.Rarity
		if type(r) == "table" and type(r._id) == "string" and not m[r._id] then
			m[r._id] = true
			o[#o + 1] = r
		end
	end
	table.sort(o, function(x, y) return (tonumber(x.Rank) or 0) < (tonumber(y.Rank) or 0) end)
	local n = {}
	for _, r in o do n[#n + 1] = r._id end
	return n
end

local function rs2(v)
	local t = {}
	for _, x in v or {} do t[x] = true end
	return t
end

local function an()
	local w = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	local a = w and w:FindFirstChild("Areas")
	local g = a and a:FindFirstChild("GuardAreas")
	local o = {}
	for _, z in g and g:GetChildren() or {} do
		local b = z:FindFirstChild("Bounds")
		if b and b:IsA("BasePart") then o[#o + 1] = {z.Name, b.Position.X - b.Size.X / 2} end
	end
	table.sort(o, function(x, y) return x[2] < y[2] end)
	local n = {}
	for _, v in o do n[#n + 1] = v[1] end
	return n
end

local ra = rk()
pg:Section({Name = "Farm"})
local xe, xa
xa = pg:Dropdown({Name = "Select Area", Options = an(), Multi = true, Default = {}, Flag = "ar", Callback = function(v)
	st.az = rs2(v)
	if #v > 0 and xe then xe:Set({}) end
end})
xe = pg:Dropdown({Name = "Select Egg", Options = ra, Multi = true, Default = {}, Flag = "mr", Callback = function(v)
	st.mr = rs2(v)
	if #v > 0 and xa then xa:Set({}) end
end})
st.ui.ae = pg:Toggle({Name = "Auto Steal Egg", Default = false, Flag = "ae", Callback = function(v)
	local x = rawget(st.ui, "ahd")
	if v and x and x.v then x:Set(false) end
	if v then st.Start() else st.Stop() end
end})
local xp = pg:Toggle({Name = "Auto Place Egg", Default = true, Flag = "ape", Callback = function(v) st.ap = v == true end})
st.ap = xp.v == true
local xh = pg:Toggle({Name = "Auto Hatch Egg", Default = true, Flag = "ahe", Callback = function(v) st.ah = v == true end})
st.ah = xh.v == true
pg:Toggle({Name = "Pet Index", Default = false, Flag = "pix", Callback = function(v) st.pi = v == true end})
pg:Button({Name = "Leave Treadmill", Callback = function()
	local ok, wy = false, "Treadmill Failed: Not Mounted"
	if st.bt or tm() then ok, wy = lt() end
	lg(ok and "Treadmill Left" or tostring(wy))
	W:Notify({Title = "Leave Treadmill", Text = ok and "Treadmill Left" or tostring(wy), Error = not ok})
end})

pg:Section({Name = "Pet"})
pg:Dropdown({Name = "Sell Pet Rarity", Options = ra, Multi = true, Default = {}, Flag = "spr", Callback = function(v) st.sp = rs2(v) end})
pg:Toggle({Name = "Auto Sell Pet", Default = false, Flag = "asp", Callback = function(v) st.ps = v end})
pg:Section({Name = "Egg"})
pg:Dropdown({Name = "Sell Egg Rarity", Options = ra, Multi = true, Default = {}, Flag = "ser", Callback = function(v) st.se = rs2(v) end})
pg:Toggle({Name = "Auto Sell Egg", Default = false, Flag = "ase", Callback = function(v) st.es = v end})

local et = W:Tab({Name = "Event", Icon = "calendar-star"})
et:Section({Name = "Butterfly"})
local xb = et:Label({Text = bc()})
task.spawn(function()
	while ge.__BkSae == st do
		pcall(function() xb:Set(bc()) end)
		task.wait(1)
	end
end)
st.ui.abf = et:Toggle({Name = "Auto Butterfly", Default = false, Flag = "abf", Callback = function(v)
	local x = rawget(st.ui, "ahd")
	if v and x and x.v then x:Set(false) end
	st.bf = v == true
	st.bi += 1
	if st.bf then task.spawn(bg, st.bi) end
end})
et:Button({Name = "Teleport To Station", Callback = function()
	local ok, wy = bu()
	lg(ok and "At Station" or tostring(wy))
	W:Notify({Title = "Teleport To Station", Text = ok and "At Station" or tostring(wy), Error = not ok})
end})
et:Section({Name = "Halloween"})
local function hq()
	if not (st.hd or st.hm or st.hx) then return end
	if not kv() then
		lg("Key Check Failed: No Valid Key")
		return
	end
	for _, k in {"ae", "abf", "arl", "atx"} do
		local x = rawget(st.ui, k)
		if x and x.v then x:Set(false) end
	end
	if st.hl then return end
	st.hg += 1
	task.spawn(hd, st.hg)
end
local function hz3(v)
	local x = rawget(st.ui, "ahd")
	if v and x and x.v then x:Set(false) end
end
st.ui.ahd = et:Toggle({Name = "Auto Halloween", Default = false, Flag = "ahd", Callback = function(v)
	st.hd, st.hm, st.hx = v == true, v == true, v == true
	hq()
end})
et:Section({Name = "Admin"})
st.ui.arl = et:Toggle({Name = "Auto Red Light Green Light", Default = false, Flag = "arl", Callback = function(v)
	hz3(v)
	st.gx = v == true
	st.gg += 1
	if st.gx then task.spawn(gq, st.gg, lc) end
end})
st.ui.atx = et:Toggle({Name = "Auto T-Rex Run", Default = false, Flag = "atx", Callback = function(v)
	hz3(v)
	st.tq = v == true
	st.th += 1
	if st.tq then task.spawn(gq, st.th, tc2) end
end})

local mi = W:Tab({Name = "Misc", Icon = "four-squares-grid"})
mi:Section({Name = "Player"})
mi:Toggle({Name = "Anti Stun", Default = false, Flag = "ast", Callback = function(v) su(v == true) end})
local xt = mi:Toggle({Name = "Anti Trap", Default = true, Flag = "atr", Callback = function(v) aq(v == true) end})
if xt.v then aq(true) end

local tp2 = W:Tab({Name = "Teleport", Icon = "person-teleport"})
tp2:Section({Name = "Server"})
for _, z in {{"Hop Server", false}, {"Hop Low Server", true}} do
	tp2:Button({Name = z[1], Callback = function()
		if st.hq then
			W:Notify({Title = z[1], Text = "Already Hopping"})
			return
		end
		st.hq = true
		W:Notify({Title = z[1], Text = "Hopping"})
		task.spawn(function()
			local ok, wy = hx(z[2])
			st.hq = false
			if not ok then W:Notify({Title = z[1], Text = tostring(wy), Error = true}) end
		end)
	end})
end

local tz = W:Tab({Name = "Setting", Icon = "gear"})
tz:Section({Name = "Game"})
tz:Button({Name = "FPS Booster", Callback = function()
	local ok, e = bo()
	W:Notify({Title = "FPS Booster", Text = ok and "On Until Rejoin" or e, Error = not ok and e ~= "Already On"})
end})
local lgv, lgd = false, {["Select Area"] = "Ch\u{1ecd}n Khu V\u{1ef1}c", ["Select Egg"] = "Ch\u{1ecd}n Tr\u{1ee9}ng", ["Auto Steal Egg"] = "T\u{1ef1} \u{110}\u{1ed9}ng Tr\u{1ed9}m Tr\u{1ee9}ng", ["Auto Place Egg"] = "T\u{1ef1} \u{110}\u{1ed9}ng \u{110}\u{1eb7}t Tr\u{1ee9}ng", ["Auto Hatch Egg"] = "T\u{1ef1} \u{110}\u{1ed9}ng \u{1ea4}p Tr\u{1ee9}ng", ["Pet Index"] = "S\u{1b0}u T\u{1ea7}m Pet", ["Leave Treadmill"] = "R\u{1edd}i M\u{e1}y Ch\u{1ea1}y B\u{1ed9}", ["Sell Pet Rarity"] = "\u{110}\u{1ed9} Hi\u{1ebf}m Pet C\u{1ea7}n B\u{e1}n", ["Auto Sell Pet"] = "T\u{1ef1} \u{110}\u{1ed9}ng B\u{e1}n Pet", ["Sell Egg Rarity"] = "\u{110}\u{1ed9} Hi\u{1ebf}m Tr\u{1ee9}ng C\u{1ea7}n B\u{e1}n", ["Auto Sell Egg"] = "T\u{1ef1} \u{110}\u{1ed9}ng B\u{e1}n Tr\u{1ee9}ng", ["Auto Butterfly"] = "T\u{1ef1} \u{110}\u{1ed9}ng B\u{1eaf}t B\u{1b0}\u{1edb}m", ["Teleport To Station"] = "D\u{1ecb}ch Chuy\u{1ec3}n T\u{1edb}i Nh\u{e0} Ga", ["Auto Halloween"] = "T\u{1ef1} \u{110}\u{1ed9}ng Halloween", ["Auto Red Light Green Light"] = "T\u{1ef1} \u{110}\u{1ed9}ng \u{110}\u{e8}n Xanh \u{110}\u{e8}n \u{110}\u{1ecf}", ["Auto T-Rex Run"] = "T\u{1ef1} \u{110}\u{1ed9}ng Ch\u{1ea1}y T-Rex", ["Anti Stun"] = "Ch\u{1ed1}ng Cho\u{e1}ng", ["Anti Trap"] = "Ch\u{1ed1}ng B\u{1eab}y", ["Hop Server"] = "\u{110}\u{1ed5}i Server", ["Hop Low Server"] = "\u{110}\u{1ed5}i Server \u{cd}t Ng\u{1b0}\u{1edd}i", ["FPS Booster"] = "T\u{103}ng FPS", ["Select Language"] = "Ch\u{1ecd}n Ng\u{f4}n Ng\u{1eef}", ["Steal Hop Distance"] = "Steal: Kho\u{1ea3}ng Nh\u{1ea3}y", ["Steal Drop Wait"] = "Steal: Ch\u{1edd} Drop", ["Steal Drop Every (Zones)"] = "Steal: Drop M\u{1ed7}i (Khu)", ["Halloween Hop Distance"] = "Halloween: Kho\u{1ea3}ng Nh\u{1ea3}y", ["Halloween Drop Wait"] = "Halloween: Ch\u{1edd} Drop", ["Halloween Drop Every (Studs)"] = "Halloween: Drop M\u{1ed7}i (Stud)", ["Default Setting"] = "C\u{e0}i \u{110}\u{1eb7}t M\u{1eb7}c \u{110}\u{1ecb}nh", ["Describe The Problem"] = "M\u{f4} T\u{1ea3} L\u{1ed7}i", ["Send Log To Developer"] = "G\u{1eed}i Log Cho Admin"}
local function lgp()
	for _, T in W.Tabs do
		for _, e in T.Rows do
			if not e.Label then continue end
			e.en = e.en or e.Name
			e.Name = lgv and lgd[e.en] or e.en
			e.Label.Text = e.Name
		end
	end
end
tz:Dropdown({Name = "Select Language", Options = {"Vietnamese", "English"}, Default = "English", Flag = "lg", Callback = function(v)
	lgv = v == "Vietnamese"
	lgp()
end})
local sdf = {}
for _, r in {
	{"Steal Hop Distance", "shd", 50, 400, 1, "hs"},
	{"Steal Drop Wait", "sdw", 0, 2, 0.05, "dw"},
	{"Steal Drop Every (Zones)", "srz", 1, 6, 1, "rz"},
	{"Halloween Hop Distance", "hhd", 50, 400, 1, "hk"},
	{"Halloween Drop Wait", "hdw", 0, 2, 0.05, "hw"},
	{"Halloween Drop Every (Studs)", "hdr", 100, 1500, 1, "hr"},
} do
	local k, d0 = r[6], st[r[6]]
	local e = tz:Slider({Name = r[1], Flag = r[2], Min = r[3], Max = r[4], Step = r[5], Default = d0, Callback = function(v) st[k] = v end})
	st[k], sdf[#sdf + 1] = e.v, {e, d0}
end
tz:Button({Name = "Default Setting", Callback = function()
	for _, x in sdf do x[1]:Set(x[2]) end
	W:Notify({Title = "Default Setting", Text = "Back To Default"})
end})
lgp()
st.gr = true

W:Interface(tz)

local hd = lp:FindFirstChildOfClass("PlayerGui") and lp:FindFirstChildOfClass("PlayerGui"):FindFirstChild("HUD")
local hb = false
for _, n in {"GameHUD", "TradmilHud"} do
	local rb = hd and hd:FindFirstChild(n) and hd[n]:FindFirstChild("RightButtons")
	local eb = rb and rb:FindFirstChild("EggsButton")
	if eb then
		local o = rb:FindFirstChild("BaKhiButton")
		if o then o:Destroy() end
		local b = eb:Clone()
		for _, k in {"Notification", "ReadyNotification", "NightImage", "NightText", "GamepadGlyph"} do
			local x = b:FindFirstChild(k)
			if x then x:Destroy() end
		end
		b.Name, b.LayoutOrder = "BaKhiButton", 5
		b:SetAttribute("PressBound", nil)
		local gd2, s1, s2 = b:FindFirstChild("UIGradient"), b:FindFirstChild("UIStroke"), b:FindFirstChild("UIStrokeClr")
		if gd2 and gd2:IsA("UIGradient") then gd2.Color = ColorSequence.new(Color3.fromRGB(7, 16, 28), Color3.fromRGB(16, 58, 88)) end
		if s1 and s1:IsA("UIStroke") then s1.Color = Color3.fromRGB(3, 8, 14) end
		if s2 and s2:IsA("UIStroke") then s2.Color = Color3.fromRGB(79, 216, 255) end
		local im = b:FindFirstChild("ImageLabel")
		if im then
			im.ImageTransparency = 1
			local f = L.Reactor(im, 40)
			f.AnchorPoint, f.Position, f.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), UDim2.fromScale(0.7, 0.7)
			Instance.new("UIAspectRatioConstraint").Parent = f
		end
		b.Parent = rb
		hb = true
		st.cn[#st.cn + 1] = b.Activated:Connect(function() if W.op then W:Hide() else W:Show() end end)
		task.spawn(pcall, function() require(rs.Client.UI.VFX.ButtonFX)(b) end)
	end
end
if hb and W.Gui:FindFirstChild("Float") then W.Gui.Float.Visible = false end
task.spawn(function()
	local o1, qa = pcall(require, rs.Shared.Util.AssetEarnings)
	local o2, qf = pcall(require, rs.Packages.FormatNumber.Simple)
	if not (o1 and o2) then
		zx("[Egg Value] Load Failed: Missing Module")
		return
	end
	local qv = {}
	while ge.__BkSae == st do
		local ok, wy = pcall(function()
			local g = lp:FindFirstChildOfClass("PlayerGui") and lp:FindFirstChildOfClass("PlayerGui"):FindFirstChild("GrowingEggs")
			local sf = g and g.Enabled and g:FindFirstChild("Frame") and g.Frame:FindFirstChild("ScrollingFrame")
			if not sf then return end
			local o3, rc = pcall(es.ReadOwnerEggs, lp.UserId)
			if not o3 or type(rc) ~= "table" then return end
			for _, r in sf:GetChildren() do
				local e, sp = rc[r.Name], r:FindFirstChild("Spacer")
				if type(e) ~= "table" or not sp then continue end
				local k = `{e.AssetCategory}|{e.AssetScale}|{table.concat(e.Mutations or {}, ",")}`
				if not qv[r.Name] or qv[r.Name].k ~= k then
					local o4, v = pcall(qa.MutationOnlyRatePerSecond, {Category = e.AssetCategory, Scale = e.AssetScale, Mutations = e.Mutations or {}})
					qv[r.Name] = {k = k, t = o4 and type(v) == "number" and v > 0 and `${qf.FormatCompact(v)}/s` or ""}
				end
				local l = sp:FindFirstChild("SaeV")
				if not l then
					local t0 = sp:FindFirstChild("Progress") and sp.Progress:FindFirstChild("TextLabel")
					l = Instance.new("TextLabel")
					l.Name, l.BackgroundTransparency, l.Position, l.Size = "SaeV", 1, UDim2.fromScale(0.247, 0.02), UDim2.fromScale(0.587, 0.27)
					l.TextScaled, l.TextXAlignment, l.TextColor3 = true, Enum.TextXAlignment.Left, Color3.fromRGB(166, 255, 111)
					if t0 then l.FontFace = t0.FontFace end
					local s0 = t0 and t0:FindFirstChildOfClass("UIStroke")
					if s0 then s0:Clone().Parent = l end
					l.Parent = sp
				end
				l.Text = qv[r.Name].t
			end
		end)
		if not ok then zx(`[Egg Value] Failed: {wy}`) end
		task.wait(0.5)
	end
end)
