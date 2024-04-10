Return-Path: <linux-iio+bounces-4185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC68A0360
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622151F21C2E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089818412C;
	Wed, 10 Apr 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkL47iLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBE16D4FC
	for <linux-iio@vger.kernel.org>; Wed, 10 Apr 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788198; cv=none; b=VuOHN81pT/uLblEG202gyNvYwtf2Yt+iWiL23pjEoIbRa3wHJ7rhVP6iL7QNwQBVn/jO3xoPBUeUH38UAIQwteg0FiXnSajlhRbbEopQj701wAPFP/vFp/azlriGHMDkhvx6snQAS5jzygx0WQOx5YV8S+3Nag0DE0rRqAECHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788198; c=relaxed/simple;
	bh=Wv0e4es5rzO7kNVxj7uH4O0tqSXDOWGXKXc4bBO0gT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSN/fjERfxm8VdslAsdd8mTKSOKtAeBBiW7d3IjCWDlN9B2x9VA8Pnmgkdg4pwG0XBuUKptn8WpsKd8ITedSoXZajyqF17SUruNhdHTMpvxKwM5sZBp2muNZwOfHDJI8l75psl+lo47+UOg3jVToTa94YeNl/AvRZUKZzoGvIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkL47iLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 740CAC433C7
	for <linux-iio@vger.kernel.org>; Wed, 10 Apr 2024 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712788197;
	bh=Wv0e4es5rzO7kNVxj7uH4O0tqSXDOWGXKXc4bBO0gT0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fkL47iLY4QuwS34XGF1+fUTNQ1vzb0IjGT+mVOnwpotJA+BFxKsp/F4MgMkrUFHe8
	 TqYRNJLBOJMCOFTSeD0wJFnbkWP8inzmcvnPoLeG0UjA5E/l1Z40kEl9e5pejU9BK1
	 0EEDGUaMVLuyqxkqnmcQr4Uv0FX9jCR8mSXjIZr/YKWJZ0t39xYOT70bwHqIkoQdf+
	 Y7lnRyEjqUJtkOYDTJPxzt0quo64edFnUGupDMI1p2PcGoXJWLwd2cwIpediN9e6sW
	 2orBSMS2MQOB2bhTK8fJIkY14hKNDjuo3bpEydX9cOf/JxVmtgx6PQIGRT45Xjgm87
	 omPnKIpR7FJqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 688EDC53BDA; Wed, 10 Apr 2024 22:29:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 10 Apr 2024 22:29:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218578-217253-bVdNquH4K7@https.bugzilla.kernel.org/>
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

--- Comment #26 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 306125
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306125&action=3Dedit
acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

