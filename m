Return-Path: <linux-iio+bounces-16965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBEA64E5D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE6A1656C9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB382376F7;
	Mon, 17 Mar 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/hZFUao"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D105236445
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213746; cv=none; b=cHAtXGST9OFbm1/MbuZMeYHogoGsG3UKSiMCVzN5clnJ9EAuy8O9BiX/wtbN8yTo80mlFKFmwsX2S7ExMJsrGGzUGvdcZ38OklUHaC7RySVRhDN3S5b/V/EdUFSyZCVZQaIavDk+ImzrXfPgdIuJUy9+JmZcvMQ5CE65L4tt7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213746; c=relaxed/simple;
	bh=fxkorLjVyxpOK7bk6XxM6/iffyTLs+XiCwC55pE9TOk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRy0RBtkdE9obzIRQzwiqE18GA7AGCHeuhL2tyI82wtsOpWrpeye1wiO6JzGZG0V7HTiORyb6YxK9PxCO/BnBiU9otvyF0ZlZYWU6hb0+YtWxSH6FV3jo2Du+dnqDGjSWlOUJWzfEgdjbzi6m/9OZpZLErDkMJMyAMIypBUJlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/hZFUao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D67FEC4CEE3
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742213745;
	bh=fxkorLjVyxpOK7bk6XxM6/iffyTLs+XiCwC55pE9TOk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o/hZFUao6KNH+6F3HFPla2ZFjkYW8wxV2RkT9PKV8t+sYB2gjH9PjSxbIqn18WF8y
	 Q5irfeV3ZyblFOQjsCOndy8EFtyeqrlUOE1xcQzNWw+cGvyjcj7yNitFijlrftKVhR
	 ThX1y7q2piwFtAmDuHIQdUTaHZOfF+YTV7oNmKHzFoqfpCwRp7R/aM85peg+LIl6R2
	 LEDigwhX6fZajD/2bU2T1lpwb4RZTLARCeLfEDQrhWRSBSc2oOmOLnRdiiGRMSa4/i
	 kWaqLB2ClXMGyRfIpoakvex9yNv1n5dzRbI13jqU76fWuzdc/OrEOsZq3BikIyKZgA
	 1YaRzq2AAZIAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1051C4160E; Mon, 17 Mar 2025 12:15:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 12:15:37 +0000
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
Message-ID: <bug-219890-217253-Cg8L5IyXY0@https.bugzilla.kernel.org/>
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

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
On Mon, 17 Mar 2025 09:38:50 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>=20
>             Bug ID: 219890
>            Summary: illuminance sensor is jittering between correct value
>                     and 0.03lux
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: wysiwyg81@rbox.co
>         Regression: No
>=20
> Hello,
>=20
> I have a Lenovo thinkbook 13x gen4.
> Automatic brightness control is flickering in Gnome, so I checked sensor =
with
> monitor-sensor command (iio-sensor-proxy).
>=20
> it shows following behavior:
> monitor-sensor  --light
>     Waiting for iio-sensor-proxy to appear
> +++ iio-sensor-proxy appeared
> =3D=3D=3D Has ambient light sensor (value: 316,000000, unit: lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 305,000000 (lux)
>=20
>=20
> the 0.03 is unexpected has it has never been that dark.
> it seems it's not a iio-sensor-proxy bug as I can see similar behavior by
> checking directly content of here :
> /sys/bus/iio/devices/iio:device0/in_illuminance_raw
>=20
>=20
> I checked the behavior on windows to make sure it's not an hardware failu=
re
> from my sensor.
> While I cannot have direct access to raw sensor data on windows, the
> automatic
> brightness is perfectly smooth: no flickering of any kind.
>=20
> I didn't found sensor name:
> =E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
> als

Two possibles types. It's either a hid sensor or an ACPI class interface
with a sensor wrapped up in firmware.

My guess is hid-sensor.  Can you do an
ls -lh in /sys/iio/devices/
so we can see what the parent is.
+CC Srinivas based on playing guess the sensor.

Jonathan





>=20
> But if there is other place I could look, let me know.
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

