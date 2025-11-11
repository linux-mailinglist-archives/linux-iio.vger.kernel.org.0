Return-Path: <linux-iio+bounces-26176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4ECC4FAB5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 21:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51BBB4E9AA5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD83A8D78;
	Tue, 11 Nov 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCZEh1N6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F393A8D65
	for <linux-iio@vger.kernel.org>; Tue, 11 Nov 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891772; cv=none; b=uaeXRJj73ApVvjWuLbBV6v8jkhxNVlxr8LlOlVAE85+wuQSRA8Z/nli3IeUbcZBcC5/25ezoULXnGvblm7PNUx6h3bPxNr8wZ8I9LgraBx7wo32ajWaPII85t169hNoODliG22Q4meYanHLL/8oAR2gTTgnnFHE1WOG6/gX48ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891772; c=relaxed/simple;
	bh=8L3q2CNPH0883T0SGBa+Pa8zmOzFVNpx8B1Naqg4fgI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEtuUUDBvaUbeNE8BZKaArljDah6RO+NPZ6oss3Hdd4sLqQD5R8n8OFlLdJ7S2iRUtmgaRGYNhDnMX6P7mNv96IwWyCAqgCGLHjdFdVRk1CpLoDCaDglwixEV/Tc2i15zDWiiJF67bsHb7WjZVuZvRlHK3qrlkLtb9euSJ0SfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCZEh1N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C7F2C2BC86
	for <linux-iio@vger.kernel.org>; Tue, 11 Nov 2025 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762891772;
	bh=8L3q2CNPH0883T0SGBa+Pa8zmOzFVNpx8B1Naqg4fgI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OCZEh1N6vqMEBYQZdz9xgRMVaXPH3VjU+Z4cTvlFO94EmREjfamKwofX7Y8XsgYas
	 lUWpdQPZJnCJRBLo/jBowga4ltjJdg46qcEL6E+Vz6AZUoGj+xsdnorWyQFvJSbz0o
	 WUthxAMYEPwYX1ttfSup2AIEti/DJg2DOnSFoUC/Hk8wE2pzxSfA25lCftCtNpGfef
	 mx9jyu0qeYPPjO7dknirrxVr+huCsXyBoPVHQXyJsaMWj30KTsGIxkNQE39CIVbFXz
	 8R0Beag06U5npyI0TVzW2O5G3VrsWDZI5IHbtKhi6dX2yMs7l1Fbu2CTLWuTQ08X9l
	 bt+pFE6+tLHoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9F48CAB782; Tue, 11 Nov 2025 20:09:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Tue, 11 Nov 2025 20:09:31 +0000
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
Message-ID: <bug-220772-217253-6scLnwUP5Z@https.bugzilla.kernel.org/>
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

--- Comment #2 from Jonathan Cameron (jic23@kernel.org) ---
On Sun, 09 Nov 2025 19:59:38 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D220772
>=20
> Alon Ohana (alon4dota2@gmail.com) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |alon4dota2@gmail.com
>=20
> --- Comment #1 from Alon Ohana (alon4dota2@gmail.com) ---
> Created attachment 308926
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D308926&action=3Dedi=
t=20=20
> bmc150_accel_buffer_postenable NULL deref diff
>=20

Thanks for the report. The thread you reference does discuss
the correct fix.  The ability to enable interrupts at all should be
prevented by removing the userspace interfaces (that are misleading
if there is no interrupt available!).

A few oddities that didn't come up in that thread though.
The trigger provided by this device is not registered if irq <=3D 0
So we must be using some other trigger or something else is going on.

Could you share the names of the triggers under
/sys/bus/iio/devices/trigger*/name
and
cat /proc/interrupts

Maybe the tooling is using an hrtimer or sysfs trigger but the
driver seems to have a validate_trigger callback that should prevent that
so I think we need a little more information.

Thanks

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

