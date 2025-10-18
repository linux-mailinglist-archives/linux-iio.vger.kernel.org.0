Return-Path: <linux-iio+bounces-25215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1CBEC3E3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 03:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0621A66D46
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9313E41A;
	Sat, 18 Oct 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywy9/Qlf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A131CA6F
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751487; cv=none; b=S8ZkiN4zUin2M9B6QkBS1UAauLZeJHHQQHRC1H6Wmwpu1HKipmTI6qxBlk0UVO7XT+rnEdqMlBVRN3q0o3SEo1POGpQGSJsA7UtGVKYm5zrTKn8NOTgPFc79xr/bPUUD+TDw1LumEqP/iIXHFsz5nxq25OYcbS5+IbsbF1nVCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751487; c=relaxed/simple;
	bh=/ViPKXp7jKlDfNztsCVCeDvq4pSxmMoPgY6I9dhz548=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nuZSf2PxK0XU2vNHWiPKXpOf7bi/hgMR7YWD1n845uzUFPpEqL44XuE0SULBFu83bNX9i0SarGbbZV0CoJt5H2WX9YXG27Ag9ZgDPqt11l/x85Wlmcw/awsjzog0Qe+SLv4ApUPjaAayskpJ1Ty77lkSLCbQkvHZrTcdj2zGAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywy9/Qlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6FBCC4CEE7
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760751485;
	bh=/ViPKXp7jKlDfNztsCVCeDvq4pSxmMoPgY6I9dhz548=;
	h=From:To:Subject:Date:From;
	b=Ywy9/QlfSWp4/2EoO1iWXagr/y7j2kwz6tivrf7AquFyvP3F+4Fi4n7t8+HUM+tKh
	 BuwrJZ36PdsZPorRh4yvpEiSAbdgINUMWYX6mKx//FX7njSsxayh9oD7mkH/eyZR9T
	 je63IOgA0+uCqYW8H4uFfQsnQ8jkWwqt820M+9KNRlgnmTOa2v4S2hoiYxZXgB/I5B
	 1bO7IFNxnGnVm8kzHXswzm+0Imu/9d+RaafenQEAf8CrFn4+w2KVEuYzfqSRPD0nP6
	 aqf1/Y5n4J2cM0HYpLBnfG1OaBJQfg2de8EUsTl+p73ox9lykqCIC3LKMUWVpSi7I7
	 VrmpRQokRu3Lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 95A99C4160E; Sat, 18 Oct 2025 01:38:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220678] New: XPS 9440 ALS value spikes
Date: Sat, 18 Oct 2025 01:38:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: boliverworK@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220678-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220678

            Bug ID: 220678
           Summary: XPS 9440 ALS value spikes
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: boliverworK@gmail.com
        Regression: No

# Dell XPS 9440: Ambient Light Sensor wildly incorrect values

## Summary
Ambient light sensor reports increasingly erratic values over time, spiking
from ~15 lux to millions. Worsens with uptime, clears on reboot - suggests
driver state corruption.

## System Info
- **Model**: Dell XPS 9440
- **OS**: Fedora-based (Project Bluefin)
- **Kernel**: [INSERT: uname -r]
- **Device**: `/sys/bus/iio/devices/iio:device0` (name: "als")
- **Sensor Hub**: Intel ISH (hid-sensor-hub 001F:8087:0AC2)

## Problem
Raw kernel values from `/sys/bus/iio/devices/iio:device0/in_illuminance_raw=
`:
```
Normal: 15000
Spike:  1596251
Normal: 15000
Spike:  778328
```

Progressively worsens without reboot. Scale factor constant at 0.001.

## Logs
```
iio-sensor-prox[1502]: Buffer '/dev/iio:device0' did not have data within 0=
.5s
iio-sensor-prox[1502]: Invalid bitmask entry for
/sys/devices/LNXSYSTM:00/.../event7
```

## Verification
Raw kernel IIO values spike (not just userspace). Bug is in ISH kernel driv=
er.

## Impact
Function key backlight and screen brightness flicker unpredictably.

## Workaround
```bash
sudo systemctl mask iio-sensor-proxy
```

## Notes
Progressive degradation pattern suggests ISH driver state corruption or mem=
ory
leak. May affect other Dell XPS models with Intel ISH.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

