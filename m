Return-Path: <linux-iio+bounces-17069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0BA682A1
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 02:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DA14618A5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7415CD52;
	Wed, 19 Mar 2025 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz34bTMC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B22158D94
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345695; cv=none; b=RSMCogxbEYLdcorcHu9xxhArf1ZqenRIwnIydqcMHu9t8rttdhg6MCSVD44jhclB8sP7Q/IV4foJd0MXCBRn6v64AUxzo4nZC9fLAFUCgnY1q8/OiDIl/FK5XpFyBth3PGieQ8YMSX5mrH2MQx5RhoAi9NlyFu0CFDgplVUIHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345695; c=relaxed/simple;
	bh=r5FDJ2bgWrKMLU1U0Ar4lQNXllIhA7n1uHz2c//OXtI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwUzwsyJcx3XCi3llAxEbgZEN5r8R2HdwCOasvARhL5kFCWaDdyn2qigw3GwlWac5Y1V0PVvvX9AlvP1Py+iELXcI2xtWHj3MAuSgbA5cjh4w43sWK2m2U+OyjM+E5FhFML540Q5c8wBBpYSF+TOqR1oLusDb4u7FkiBwDAa5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz34bTMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97A9CC4CEE3
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742345693;
	bh=r5FDJ2bgWrKMLU1U0Ar4lQNXllIhA7n1uHz2c//OXtI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wz34bTMCumnCtgDH/4sgwtEj3K4krgRkAclkf96jE2uMdSv164EeKKNfHzF7mmjp7
	 ocs/NOJiKC+Xb3x1E17nsW94+kqRb12XQE4TqKDqqUbjudRrJdwETb4qT0astyNogp
	 8/+xqYmVmw/pxJrjDK9wdsaF+1XeM6QuUUCVlGU9almnhDpOmzYyYYK7MyUcNI6gWr
	 10yJCMvX7wTt4j8LjhcrPGkEH9GjZm74CBVfLWDwrgyqGaVAo+UTyrqiW+kwIQKdhO
	 5vDMrwANR3cmVELLSbM2TRqXX+MM/uHzegxX1X/NzZKLQvG7aV997dUF5AyKNujmL4
	 fels/VwI3/v1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85827C433E1; Wed, 19 Mar 2025 00:54:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 00:54:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-KIjyZdnYeI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #16 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
It seems that with raw reads with ON/OFF there may be some bad data from se=
nsor
hub.
Unfortunately, need a kernel built with patch for debug dump.

Remove iio sensor proxy from running and reboot

Before run
echo 'file hid-sensor-trigger.c +p' > /sys/kernel/debug/dynamic_debug/contr=
ol
echo 'file hid-sensor-hub.c +p' > /sys/kernel/debug/dynamic_debug/control

watch -n 0.7 cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw

Send the output from dmesg command.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

