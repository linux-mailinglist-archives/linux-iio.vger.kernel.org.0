Return-Path: <linux-iio+bounces-3578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5D87E123
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE81C2091B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C7219ED;
	Sun, 17 Mar 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJcL6k00"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B3200C1
	for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710719125; cv=none; b=tu8BMHmkmaci/Uh5U0IrJssdip9fpRENHzooTc+oQiMcSzAdGBvWVWzrVFOmQRhj7uLxAUmEkxORXIBhLyp24VoTRyCwQx85pM2LlazQ/JQdARCOaWbnR7bwNxeTNzCrUslOtnkYT7x2u4wom7mc23Orb7G093Dvuw7uiO/Wv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710719125; c=relaxed/simple;
	bh=qS8OgpafELdrr8mpjENTulc1x7WVHvCrGR8KpMl/ioE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQ0PVNPT7Do7eO/WwkTaP6NN8WQfZE/ZVRsqB5D1is6WyDVyyl/B+Gc8LcQuf84SecsBj41MGpCIz1gq5dfg2pcDH57BBvVq/Tn1bjYi0DetlLj+MVklGez/SCDumCcxUmo1Nm5E1sUsS7EYHSHR4MRB1GJU5BIrvQwKZfF9xxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJcL6k00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A859C43394
	for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2024 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710719125;
	bh=qS8OgpafELdrr8mpjENTulc1x7WVHvCrGR8KpMl/ioE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MJcL6k00HSYJeQ7IXgwb7dtDZR9f8OznzhZJbnAI9euwMQ/FMxZSFNV3Uc+r3P56G
	 wHXk3TO8/B11t1745orqwsl09ml/0bOgFpRbWwRbx1Dp4nd4MHTUHu8pbF9YXw4Uls
	 QbHxjR1AprUR5HHFGV2QlrHJaiILQ4Ei2Duulg9hGl+fRJz0zZroep2sPUiztgif5f
	 31xQrrpobo52WTvUxQeNUCpvjZFs6NezzsQ0wlZ6H/18ZjNaHEwIEiLYjP2d6NvFtg
	 h8EFszfbtxT5QpY1c+oTn07+4qqc/YyjZ6g+G+YWy9ti8ryUrW+KMGzeuQ9/7iqE/I
	 55LdJ0Naa8AAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08645C53BCD; Sun, 17 Mar 2024 23:45:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Sun, 17 Mar 2024 23:45:24 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-yFF4x53bsR@https.bugzilla.kernel.org/>
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

--- Comment #16 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Thanks for the continued support Hans!  I have actually never compiled my o=
wn
kernel before, but there's a first time for everything.  I'm down to give i=
t a
go.

Also FWIW, my further testing has indicated that there are also problems wh=
en
coming out of a sleep state.  Will your proposed fix also be likely to corr=
ect
that behavior too?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

