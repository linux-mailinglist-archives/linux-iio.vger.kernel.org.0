Return-Path: <linux-iio+bounces-11345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D19B18B7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6561F21FD1
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C1CA9C;
	Sat, 26 Oct 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHI7lVSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B2AD24
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954182; cv=none; b=j/jRSKpfFXJuPU7SyDFF8d7PBZmIn9aqyyZTlI7wPyIruCO/1R+4LtdLXDooaBUFTdkQ/OUlh2aiJconywDjMFhEbrH7VCvOhJoTcnP2Lsgq9I/bmuwcbw6vH2WSNZXWLu3GUxPEtmjo5JBpBTsHdT7Cqxy1qAZtBeM6r0gbkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954182; c=relaxed/simple;
	bh=EYx2+Sbp0HY6dcVsED4qQnux7/lXXxEQL23FvHEMi6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdks/mZQz/EFNuHtYBSnkpBhz9XjKGfsJsPWDVjXN3d52FUtXq5G92ZDDWjmAmpD1OiO5VaEsRB7O/yd5LGDJ+W7U+EW/lOF8RHcLy/xB//pIBe4L6dgV9gDDXolwY5ZJWQhjK5EKslpqrDNZzmkqVKxdIDofC8r/Pk44UTIUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHI7lVSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1E09C4CECC
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729954182;
	bh=EYx2+Sbp0HY6dcVsED4qQnux7/lXXxEQL23FvHEMi6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AHI7lVSGWwQvhwJEsms/XI7XZ59d6vN9hELFTwIQ+XQUvU2b/G0aW8KEN1dZk0IB0
	 Q+4qNkj7iqNP/fSxkRXihNA+lPJioSNHnRo0DtN5LnEJe8JC8uJOc4fX36UTX1XqzC
	 yTwHbP7zGTmXZcaanoKL01KCZZKh4cARrq2282bDL+2eojAZ2BQslosbVILNiBptlk
	 CxFjoVpJpLZAgtya4w9jC/R6ktsXIwQYAYOV0KfQZSx8cS0tPq4TaSECe108HafzzH
	 aHNKNwOR81z9qfwJr0ZKUHdETCQKAZ9xi7DZoMDPMBYUxCnPv46xxKNqnmbVZz/EX0
	 UrFvFmEBANb1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2A18C53BBF; Sat, 26 Oct 2024 14:49:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Sat, 26 Oct 2024 14:49:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219418-217253-9vwdgPF0Z0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

--- Comment #3 from Jonathan Cameron (jic23@kernel.org) ---
On Tue, 22 Oct 2024 13:17:20 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219418
>=20
>             Bug ID: 219418
>            Summary: BOSC0200 Accelerometer Invalid chip 12 initialization
>                     error
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: cameraphone77@gmail.com
>         Regression: No
>=20
> Created attachment 307035
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D307035&action=3Dedi=
t=20=20
> lspci output
>=20
> Hardware: Acer aspire spin 3 A3SP14-31PT-38YA
>=20
> One line summary of the problem:
> BOSC0200 Accelerometer Invalid chip 12 initialization error

Unfortunately that ID is used by the windows Bosch drivers for numerous
completely incompatible devices.  So we can't do soft matching on this one.
We need to know what the device actually is and add explicit support for
it.

So it's going to take some detective work to find a device with ID 12.

Any other information on what device this might be?

Jonathan
>=20
> Full description of the problem/report:
> The Accelerometer is not detected by iio and does not function
>=20
> Kernel version (from /proc/version):
> Linux version 6.11.4-arch2-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240910,
> GNU
> ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sun, 20 Oct 2024 18:20:12
> +0000
>=20
>=20
> sudo /usr/lib/iio-sensor-proxy -v
> ** (iio-sensor-proxy:2007): DEBUG: 22:33:10.952: Starting iio-sensor-proxy
> version 3.5
> (iio-sensor-proxy:2007): GLib-GIO-DEBUG: 22:33:10.954: Using cross-namesp=
ace
> EXTERNAL authentication (this will deadlock if server is GDBus < 2.73.3)
> ** (iio-sensor-proxy:2007): DEBUG: 22:33:10.991: No sensors or missing ke=
rnel
> drivers for the sensors
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

