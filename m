Return-Path: <linux-iio+bounces-17164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A72A6B43F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD7F189B3FC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E31E98E1;
	Fri, 21 Mar 2025 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7BOTWIS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A21E3DDE
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537085; cv=none; b=bSa2B0clVlGhdzwhS4lPO5rwz1sqqTPJdX6yv85kB725Z2pkvqv4cqdvnvcJR2+J+KVOyOBgXi1QbgqEzeII5LFJa76d0UzGjKCnWVKMOCbul/1rYlVsf9l3woaLrB3aWJYi3u9MUjSYUWFfV5ZB+cpjCikz68Lj2hkkFZz29cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537085; c=relaxed/simple;
	bh=4rsh7FzrXwhkTgoJ5xl8zntgq39hcvu7ydEZY0vnWWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDyB77Z9u78/E1OXuTw6Ui2HfqlmbufIxw9fhjj2xwNZ/enQDVx/XuUTT/42+zrZ8Jjrr5RlCpInXjGzTnH63FFMAzKmUmPV3cCezO+LrROCnL4yzy5lO0YcaJGMn2zzq5Z5ThFNDh69DITZALLFzlzRb7MFNHFSZKawKIpW0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7BOTWIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84124C4CEE8
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742537084;
	bh=4rsh7FzrXwhkTgoJ5xl8zntgq39hcvu7ydEZY0vnWWk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s7BOTWISENb0ZWU8CFwszMbJ5I1vgR02gOCsXsnuyH2eo4sUbdMWoJY2UggtQSloT
	 +KZ2HRTDrExzpEd3obfRPQJkkLpyoWhu+iQhuXdPVjZz9IyVqypQuOujyIi7D602MQ
	 jqkS9TcXloePqTzc02/tW42EgEANzuXVvOMmaERl4iGywfPoDL9EScCEBE7IERs4UU
	 PqZVbi/A4xiq7PXrqzykNeL2rAmug9itLNY+vFaiCKeF7zKrVdzAOSRYkqEHtuj94G
	 oOm1uSkZn5hbpuMkMlD86dWQl9ap2qwesiqM62U2xcm2rsGhyPuVtI8ok5E1LA+U21
	 nCywvdai+dCHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 55BA7C41612; Fri, 21 Mar 2025 06:04:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Fri, 21 Mar 2025 06:04:43 +0000
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
Message-ID: <bug-219890-217253-nAEgNmgUD7@https.bugzilla.kernel.org/>
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

--- Comment #28 from Fred (wysiwyg81@rbox.co) ---
Hello,
After test as suggested here :
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/407#note_28=
28458

it seems buffer work better than polling !


Disable polling :

=E2=9D=AF cat /usr/lib/udev/rules.d/80-iio-sensor-proxy.rules
# iio-sensor-proxy
# IIO sensor to D-Bus proxy

ACTION=3D=3D"remove", GOTO=3D"iio_sensor_proxy_end"

# Set the sensor type for all the types we recognise
SUBSYSTEM=3D=3D"hwmon", TEST=3D=3D"light", ENV{IIO_SENSOR_PROXY_TYPE}+=3D"h=
wmon-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_accel_x_raw", TEST=3D=3D"in_accel_y_raw=
",
TEST=3D=3D"in_accel_z_raw", ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-accel"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"scan_elements/in_accel_x_en",
TEST=3D=3D"scan_elements/in_accel_y_en", TEST=3D=3D"scan_elements/in_accel_=
z_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-accel"
SUBSYSTEM=3D=3D"iio",
TEST=3D=3D"scan_elements/in_rot_from_north_magnetic_tilt_comp_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-compass"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_input",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance0_input",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_clear_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_intensity_clear_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"scan_elements/in_intensity_both_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_proximity_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-proximity"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_proximity0_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-proximity"
SUBSYSTEM=3D=3D"input", ENV{ID_INPUT_ACCELEROMETER}=3D=3D"1",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"input-accel"

ENV{IIO_SENSOR_PROXY_TYPE}=3D=3D"", GOTO=3D"iio_sensor_proxy_end"

# We got here because we have a sensor type, which means we need the service
TAG+=3D"systemd", ENV{SYSTEMD_WANTS}+=3D"iio-sensor-proxy.service"

LABEL=3D"iio_sensor_proxy_end"

~
=E2=9D=AF monitor-sensor  --light
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=3D=3D=3D Has ambient light sensor (value: 234,999995, unit: lux)
    Light changed: 163,999996 (lux)
    Light changed: 133,999997 (lux)
    Light changed: 237,999995 (lux)
    Light changed: 207,999995 (lux)
    Light changed: 133,999997 (lux)
    Light changed: 228,999995 (lux)
    Light changed: 231,999995 (lux)
    Light changed: 229,999995 (lux)
    Light changed: 133,999997 (lux)
    Light changed: 225,999995 (lux)
    Light changed: 229,999995 (lux)
    Light changed: 173,999996 (lux)
    Light changed: 237,999995 (lux)
    Light changed: 188,999996 (lux)
    Light changed: 137,999997 (lux)
    Light changed: 227,999995 (lux)





Disabling buffer:



cat /usr/lib/udev/rules.d/80-iio-sensor-proxy.rules
# iio-sensor-proxy
# IIO sensor to D-Bus proxy

ACTION=3D=3D"remove", GOTO=3D"iio_sensor_proxy_end"

# Set the sensor type for all the types we recognise
SUBSYSTEM=3D=3D"hwmon", TEST=3D=3D"light", ENV{IIO_SENSOR_PROXY_TYPE}+=3D"h=
wmon-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_accel_x_raw", TEST=3D=3D"in_accel_y_raw=
",
TEST=3D=3D"in_accel_z_raw", ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-accel"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"scan_elements/in_accel_x_en",
TEST=3D=3D"scan_elements/in_accel_y_en", TEST=3D=3D"scan_elements/in_accel_=
z_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-accel"
SUBSYSTEM=3D=3D"iio",
TEST=3D=3D"scan_elements/in_rot_from_north_magnetic_tilt_comp_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-compass"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_input",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance0_input",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_clear_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_illuminance_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_intensity_clear_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-als"
#SUBSYSTEM=3D=3D"iio", TEST=3D=3D"scan_elements/in_intensity_both_en",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-buffer-als"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_proximity_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-proximity"
SUBSYSTEM=3D=3D"iio", TEST=3D=3D"in_proximity0_raw",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"iio-poll-proximity"
SUBSYSTEM=3D=3D"input", ENV{ID_INPUT_ACCELEROMETER}=3D=3D"1",
ENV{IIO_SENSOR_PROXY_TYPE}+=3D"input-accel"

ENV{IIO_SENSOR_PROXY_TYPE}=3D=3D"", GOTO=3D"iio_sensor_proxy_end"

# We got here because we have a sensor type, which means we need the service
TAG+=3D"systemd", ENV{SYSTEMD_WANTS}+=3D"iio-sensor-proxy.service"

LABEL=3D"iio_sensor_proxy_end"

~
=E2=9D=AF monitor-sensor  --light
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=3D=3D=3D Has ambient light sensor (value: 263,000000, unit: lux)
    Light changed: 203,000000 (lux)
    Light changed: 148,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 230,000000 (lux)
    Light changed: 237,000000 (lux)
    Light changed: 172,000000 (lux)
    Light changed: 143,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 233,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 237,000000 (lux)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

