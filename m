Return-Path: <linux-iio+bounces-4346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F08AA5A2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15ED1C2105C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9454EB2B;
	Thu, 18 Apr 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMlCSOn6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EF441D
	for <linux-iio@vger.kernel.org>; Thu, 18 Apr 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481731; cv=none; b=fHVLAbjeUcAyFM0eU/FTWRcVDKiADB01LMT8CKFBBQH53xSQupJYvr3tlsTAfgtIyLrFAs7iU99C1ozRPDagAjl0M2/VAfkJcNY3NzXA1p/ySA4prIER1C487P+yi9AEy7VBDb4Qvlctez4xqttxjy3pgZGgeaoKvOxDngeEq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481731; c=relaxed/simple;
	bh=6Tn+baBpfbVeKdzkRacF/IVL+28v0EuG9c/v9KI/rM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZrGgi1ZSjnnbBJ0ULKssT4hWddDEXofxhqGz9iguUxJC77FzR6eDV3HYAotGvYPGrYWy+u0iUw3TWSzm1+Ca5xgjvhKyaUiqzL4nir3UXpv3kG9ie/nikJ2XYtRq+cm2X5ad+7yzypyqDy4YDpEJRybkb6hnyapdBVXxDLWvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMlCSOn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C801FC32781
	for <linux-iio@vger.kernel.org>; Thu, 18 Apr 2024 23:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713481730;
	bh=6Tn+baBpfbVeKdzkRacF/IVL+28v0EuG9c/v9KI/rM4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CMlCSOn6DQawvJE/Syxa5vqj6FZ/BpRQrP20G86l4TmdAeRXx/iTh7OAFMLkorbhf
	 tb6tUDj7lXIl0/uKWINtYJCwMhL/fFWHiShSVSOiXlqvd4Cuk9omwbI/+SpwKyH27e
	 O1+VOANiC+5dZt+nZlcnBKhF9L9nggLY+e5+NBGgSM4HLfEvZDKyfXKsq58B4suroT
	 MbekAUNQ+LZnY3+XX4z28pRdFIHtHf1wtPnDiFJeCC86aIXBBWf12u5oHxSN5/+Xjg
	 Xg/0U4PNrtdJ0/boSNPHBSQDDYjsxMVhxOT9sxIzlWNJVCs/P7posKuOHrz/Harpcy
	 SAY7TCk/0tg+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B9B77C433E5; Thu, 18 Apr 2024 23:08:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Thu, 18 Apr 2024 23:08:50 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-mSrQO1cBDi@https.bugzilla.kernel.org/>
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

--- Comment #31 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

Awesome, thanks!  I tested the new build (and removed my udev workaround). =
 It
looks to be working perfectly. :)=20

The path /sys/bus/iio/devices/iio:device0/in_mount_matrix didn't exist but I
found /sys/bus/iio/devices/iio:device0/in_accel_mount_matrix which does con=
tain
the matrix.

Looks like this now resolves all of the issues!

Cheers,
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

