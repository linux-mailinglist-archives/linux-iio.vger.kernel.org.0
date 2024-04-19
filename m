Return-Path: <linux-iio+bounces-4349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4D8AA94E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B80A1C20B97
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC543ACB;
	Fri, 19 Apr 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsabzreP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5444314E
	for <linux-iio@vger.kernel.org>; Fri, 19 Apr 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512237; cv=none; b=BW/2Xj2nYxJOvL852TUTDoYBNeZfx5CWRGWiNnu3Tm1TiCsNa3J22Z1OQTV2+A0JBgailn4yG86fVxfLXwdOJvaIHOhk0tnnmKCLI34PRUbP2p+F0yFMpLUvHPTtK3B4iV5OdAbA3DS/NLhd/x9a4epkg4KAcrjIrkeusnate30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512237; c=relaxed/simple;
	bh=FjudQEObzRPxzjSMMcAabDi7Qczsym6VSreKEpR34Jc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGwzm1IgbYumX7u8P8e3Kvi7DxgMv1/VdFPh3whwOYxZ8E190kf2A+QC85hHbcM4N6zMOBVxyLOgtBXWqXbXmk+CTAAlnwAZM0DNoMk2hMOKcvpPnaEiTSMJVMlId0gD3LottX2cUV+g98GQv26VefBre2s//HILrlQjfKAYTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsabzreP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69C74C2BD11
	for <linux-iio@vger.kernel.org>; Fri, 19 Apr 2024 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713512236;
	bh=FjudQEObzRPxzjSMMcAabDi7Qczsym6VSreKEpR34Jc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bsabzreP+F0nhPxSE1fhOhmeJdejJ29qlez8jwFSNHGAfGsTd625eTq5cp5LcJ60z
	 /pZYu+PEBkn3pwIykTKCCrTJ4FhtmNJFubp+7BQYuQ+g4O1AAfaTgpg5kNvYUOvNod
	 gfPrEFQJoNfDBDV8SZDp80NkmtfjOaU2QhhpZeRzpKON4hVDiTxbCd4ssOkpHEs730
	 +2c5pp2Ggzvd7z5G7DyMOLChiUp4XPUddsENl+mhsdsjmsu4mZooJqaAV6jlyiVCFI
	 Q/N1SO7plBv9DLavCf345EKF58XV8/vRaKYtfPSNCKJznF71KL/vlOp2tDhFOtM19j
	 epIp6/QUJ9omA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 594BBC433E2; Fri, 19 Apr 2024 07:37:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 19 Apr 2024 07:37:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-0TG6RWUVjK@https.bugzilla.kernel.org/>
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

--- Comment #32 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
(In reply to Kirk Schnable from comment #31)
> Awesome, thanks!  I tested the new build (and removed my udev workaround)=
.=20
> It looks to be working perfectly. :)=20

Great thank you for testing. I've send a reply to the upstream patch submis=
sion
to indicate that this has been tested now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

