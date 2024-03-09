Return-Path: <linux-iio+bounces-3412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D4877299
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC8128206B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FD28366;
	Sat,  9 Mar 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTQEG5Ji"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235423741
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007529; cv=none; b=OsaKMSEWautlt5XZw5IMlaNduh2Ddq4PKR1C9KXSccDIIBgEU+v7AIr9i2zDxIO/swgqPLPxCCDDjO2MwhCijGA4K7QZ0FWYFvWQ9y+ANh8pa5UgLAsdeH8n2XrAhxbXOmsyHq2Y9ouD9NE9An1+dvsj9hgimKb/ZQgFubySsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007529; c=relaxed/simple;
	bh=CcNnKCqH9TV9Eic+JWlEGT6WdlaSHR2h61uJwaVWwHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBsvQ61C8AePc1x3Si+ohJit0TaPLoBBCDKfBXYgVDfppGKVe3IpTTQu1ch4Xl6R2lgaUgBWSMt7hUd+yAas7rRCEJMNSBBR11KvQEdLgRGcIY4MPX2X0DsE9CVHd1lMNWuHErTx0Yv9hj36/OYQ+SslSoNvxSAeraXiQxmBt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTQEG5Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5377FC433F1
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710007529;
	bh=CcNnKCqH9TV9Eic+JWlEGT6WdlaSHR2h61uJwaVWwHs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RTQEG5JiUKSO35yKM7nkt3i6l2tqgHi+WbclyRaJa4q1Y1RzKvP18fUX73bvYqWPd
	 UVkceqakNpfUcrAtehZrco+UAGSYidGVU9XsCLxubs4K7yh2qCMAyZqz1CorokrHTN
	 RTiYtt6sHnQzzxG3otc5EZYW/4iBLO+v0z/qAdvi+nfpAoxDV4vr9Vjn+70ouaaZnL
	 umOoHpVRocQ19Dz37dmcQ+i3gguDf0c8EiI6Ks8v5UYRDS+a2V+8aMZrZs++3J9/Rm
	 dKhoVVhm5bebtlMO0ewoywXEFRL8d+6wYZYL8Hq5ClLJYfLIf2jXY/uLmTbUgoj0Om
	 W2VKaUHy8HA/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37BA3C4332E; Sat,  9 Mar 2024 18:05:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Sat, 09 Mar 2024 18:05:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218578-217253-puquXTwpif@https.bugzilla.kernel.org/>
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

Kirk Schnable (kernelbugzilla@kirkschnable.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.5.6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

