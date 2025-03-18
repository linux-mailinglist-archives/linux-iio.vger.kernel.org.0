Return-Path: <linux-iio+bounces-17039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2CA67BEE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB94176A1D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA819F11F;
	Tue, 18 Mar 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9LLXDpl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572220322
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322664; cv=none; b=g/ECsQrzSxF46BzTlWM8JbKxsvTm7yp4tee6YmmirM2OqE9mIlzUYR2Wp5ODh9sYTeP6Uul9CJ9PnEAKVJItHOZZNxKiP7M/yfCebYWdirikREcLul6FCO7t+9MSHqxIjrloUgG98xDSWrxT/KWqDCTG6Rth7FBLx20RcdUXHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322664; c=relaxed/simple;
	bh=AW5BD49DUev8H6MGVnWalp1xEYMpqT/ngc8bad8e2to=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+xj9OjuXptg2+oZJdy1FGfTM3NA7Kq9qzP0hBsO9Ci6KzvtYiN3hXF52Olf3L88RcFePlZeTmqYUec3Aw9PArJnpR0coB3GvaPCf5Uu2oCYyxN9l4yJCuVA6esJKPWbrgzpH2iOrk06NhfDpBJkyiU7GfqGKf04jcm0dSlzaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9LLXDpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AF1BC4CEE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322664;
	bh=AW5BD49DUev8H6MGVnWalp1xEYMpqT/ngc8bad8e2to=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B9LLXDplcg6q68pPZePb92ohVcQMj8PoQFxFrvIy2hC82PNuOGfrE/5lKw1clu+Z+
	 nHJX9PBqmnWwdW8I3valRi0cjcPhDVp3acWQHt0/9kuvyxVX8pMy5feCp41/R/mjKl
	 nMLnp7J/6siTsW7KIOlYvsTRcEfEBnDNtwfcFdbMsWVn2o5eRSFG/CvLpeewn7oE2t
	 XEuYPE+h74MeTwloAjp1WtZqs8UGjsqTeQ/HcXnnkYBvTj8UsiFiF7q06zA/iEk/oO
	 tf9oNk0VN2gCwG4IEjnTy6Q2d/IWO9aPgYrAYVv+NPeepOsxc0uZ4Nxvm6j7vgWQoF
	 P67rQjnujpjdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C12CC41612; Tue, 18 Mar 2025 18:31:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 18:31:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-FwlrYjgduj@https.bugzilla.kernel.org/>
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

--- Comment #13 from Fred (wysiwyg81@rbox.co) ---
note :  I also tried this:
watch -n 0.7 cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw

after setting /sys/bus/platform/devices/HID-SENSOR-200041.6.auto/power/cont=
rol
to on.

it is still "blinking" between "3" and some higher value.
the "3" match the 0.03lux from monitor-sensor.
( /sys/bus/iio/devices/iio:device1/in_illuminance_scale  =3D 0.01 )

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

