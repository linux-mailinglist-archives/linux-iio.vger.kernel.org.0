Return-Path: <linux-iio+bounces-26114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F487C4468C
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 20:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D98D3ADC1C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56346221290;
	Sun,  9 Nov 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEXa4GP8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108041482E8
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718380; cv=none; b=mOlAdHmz/2kcXB6UQD6N7mNOYwnvL3unlwjGVVTr7AW4lfznx/TDZ9XtXpEisKXp6dnVpgApgNxw9FAbWyMs3A0Yg+izMqJam66Nzkt7JtGLpgT3R98YGn60T2sebHfEasmIjAGEXC4RH3rZQFr3f7cJTNqq3x+9kuFR55Iu2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718380; c=relaxed/simple;
	bh=svoZKUY3kAzj5IEptJ/S8AhkkwZa6268a+vxbjorPeI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vnf1Mq3FvUH9MHQaRxcpL4VVPLx9ObJS9qke++RsSpOK/rUzqNh1kv7f91xHrb4FQpJtR4qx8CVEBjyBtbh5guMtj8Acmu0SI68utlxJyhniheP0Ut1qTdGR8znCO/jxu5CQ7vB3gdgz/TxXNdnEotTvyvwK6GdNs5x1KbULImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEXa4GP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FDF3C116B1
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762718379;
	bh=svoZKUY3kAzj5IEptJ/S8AhkkwZa6268a+vxbjorPeI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pEXa4GP8U9jD8I0ZvJSf/rRs1hRwj5DJK+mcxKpotxlQJA6yJTEDccGtYOMq+OUIa
	 reLzFu7dtxzLPCxzs96ITjwUObZgGKkvcl63uWaX1NDd3kPO4or/GVCcdoxibCdgr2
	 0M7IT6pFVrqozPNOA2RxY/EODyxGTwxEBvBYT+ARUBOhPJ/bhU2LvHVGA3TZjQeB0v
	 rhI+Urls6LKx87jzqUI3W1AfdIhueTox5WChNZJtAYopceX6tAb3jrWWfo4uZ7u6Mh
	 1wd+3VOufUFJmRXmMzSXbp4mK1ZKtDRN0l9dvGUfedyGwC/ktu4d/MXy6z4RKim/k2
	 hbdm3QGqexwEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 86B8AC53BC5; Sun,  9 Nov 2025 19:59:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Sun, 09 Nov 2025 19:59:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alon4dota2@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-220772-217253-xYMFkeZqGv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220772-217253@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220772

Alon Ohana (alon4dota2@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alon4dota2@gmail.com

--- Comment #1 from Alon Ohana (alon4dota2@gmail.com) ---
Created attachment 308926
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308926&action=3Dedit
bmc150_accel_buffer_postenable NULL deref diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

