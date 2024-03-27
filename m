Return-Path: <linux-iio+bounces-3828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8F88E810
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D091F308F5
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BDB13A3E2;
	Wed, 27 Mar 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU5ydbSy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9812DDA9
	for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550338; cv=none; b=idtVJNo9y2/gZiuycn19qD1Hq5ucKcOxMWBj6XpjuJ32l9xUV9dONd5UE2k1W6ZJ3/TAhjGW/7xgZ4Nv43UZ8B4bg7HqERPFYRDwoH9radRBQfl7FvQ30o+io/2rfpty/gdMGRSSsiPhbsdKNnrbpTr/BoEHnsHTGvveHsS7y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550338; c=relaxed/simple;
	bh=+TRzaHSjW+rlZlz7PpxvfsXP2WDgpRLQbsWSU2FVe+0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uc5laiXPBoGM5n3/VE/EWgfogDXI31b7a+eGHpAAdKSGG31I/5lGD8Ru3xyV3rVSybSvPxV0M7OF/SNqwTyXRUYBc2fwdvJPXhLvp8Tsi/U6oRLiFuXuIEMTReY8/HxCyYIcjeh/85vmJEpxqXrTCtbYAr+jhUWd3aWiO6IzNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU5ydbSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C238C433C7
	for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550338;
	bh=+TRzaHSjW+rlZlz7PpxvfsXP2WDgpRLQbsWSU2FVe+0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aU5ydbSyWBXvKY4ys+3yYvB2Qf3SoCzF5nhN/uRI0lYY1y+IFwxjk82J24zWPxX+i
	 5lOzyxbJFcEGF2zUxOl81XRSuNPjVSqcEScKBfMWXIg3huqzZBeU3CwvRHx2hErYhF
	 NBt0dgdD1Grm0CwgmoRS270gFnIe1JBUtcUYwLKR+vzDD3qIIglJepkdvOvhQo45Xb
	 rzOZamj7bnGhbTJRSlP/4AKTZPi+Mddgqdctvwhh7+X7t4FshLlzRuvepify3h40mv
	 bai+7eqiH9ZTqdPSkMuDlOmstRqbyJ5TFAqTDib49miDXwP5J/iuLWzh/upCgyVVYf
	 9V1HmXymk6+mw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3EA03C53BD1; Wed, 27 Mar 2024 14:38:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 27 Mar 2024 14:38:57 +0000
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
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218578-217253-fZpDPWKY91@https.bugzilla.kernel.org/>
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

Hans de Goede (jwrdegoede@fedoraproject.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #23 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
> In all cases, the accelerometer is now working 100% of the time. :)=20

That is great, thank you for testing.

> My issue is resolved, but I am still leaving the file I put in
> /etc/udev/hwdb.d/
ubook.hwdb
> which is necessary to fix the orientation of the accelerometer.  Without =
this
> updated ACCEL_MOUNT_MATRIX, I found the screen rotation was upside down.

Right accelerometers needing a hwdb entry to set ACCEL_MOUNT_MATRIX
unfortunately is quite normal. The hwdb with this entries is maintained as =
part
of the systemd project.

I see in the attached file that your DMI "pn" (product name) is somewhat
generic if possible please make this more specific to your model. After this
please modify:

https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb

To add the entry for your tablet (or 2 entries one for each model if necess=
ary)
to the existing Chuwi section and then submit a pull-request to systemd
upstream to get these orientation quirks added to the official hwdb. If you
mention me: "@jwrdegoede" in the pull-request then I can review it.

Let me know if you need any help with creating the pull-request.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

