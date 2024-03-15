Return-Path: <linux-iio+bounces-3548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E896B87CFE7
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED73284A31
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444B3D575;
	Fri, 15 Mar 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUUWuD3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609C3FB9B
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515601; cv=none; b=U8lRkJ3KFeC9foSvt7esNfllsRWIqtiY7P0U/NT7gB7VL0n0gnw2veufWh0ehpbrmzDdmD8/lNYD6Q72Uu9Pb646xsIxcbS6IAGQT6t0GOcNw7S0P4MMqI0ncRgZXhQvTs4p8H7dvVZ5mt8xVoG83/sC99+Kcm8KiqVl4qGE95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515601; c=relaxed/simple;
	bh=pZWWXScl83l/Jpre7MSH0iGk2xPHCMXuWzE93KVxt7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQ0D+ITrJa1I6FIGJ0X9tncB/LdKhXkjVYHuhRui1nt5vi+sG0B0kiGwBpBxnV++riu4vu+L8d+c2zdszV/Hq/++JrJ/OiimgVGLUQagKCESbqE7/qAZ8v5bARlK55wka6/5sLT1uOZ6mybSLzlAdDY6wkIVcSQamKZknwmQGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUUWuD3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C65CEC433F1
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515600;
	bh=pZWWXScl83l/Jpre7MSH0iGk2xPHCMXuWzE93KVxt7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dUUWuD3Mic+idrY7/8VCSGbXnK4rgE3k5vE1YWpfFzI2a8EPkb7oLpxU85xnQUJGk
	 9ePDBR355B5VK3V4z63GB3OeFLK454pQe3A5YQJwPTCicreiXglT73zhatIrnXvUBN
	 bqZ0HR8e9EeXLb7EkGjQYZZXt/Cl3t+1M1Q2ETw70X7vmf2wUfkN0A0eHplmRHR2Gt
	 u428nrFjLumrDqlVRpGP746GIy4mEa1pmOepJKwZLyz4yj21R28PxpEtFeezYYazAk
	 7svujHgI9IyL/jp3MLwmWzxLKpQ41qB5DYmpKMasBwsb1WJn5Z5NaBL0DGqsiHB2P3
	 s0c/UmEbkItnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B8634C53BCD; Fri, 15 Mar 2024 15:13:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 15 Mar 2024 15:13:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-xGqQX53vSx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218578-217253@https.bugzilla.kernel.org/>
References: <bug-218578-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218578

--- Comment #15 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
(In reply to Kirk Schnable from comment #14)
> Thanks!  I think your diagnosis is spot on.  I went ahead with the process
> and attached the files.=20
>=20
> Resetting the accelerometer with the provided command immediately made it
> start updating again.

Ok, that is good news, so we just need to add the reset command to the prob=
e()
method of the driver.

If Jonathan or me provide a kernel patch for this, would you be able to test
this (this requires building your own kernel with the patch) ?

Jonathan, I'm buried in work atm, so I would not mind if you beat me to
providing a patch for this.

FWIW the (main?) problem seems to be that sometimes the chip comes up with =
bit
0 register 0x0d set putting the chip in power-down mode. Although some of t=
he
other register values are suspect to in the bad dump (all the interrupt bits
are set) but that might be due to the powerdown mode ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

