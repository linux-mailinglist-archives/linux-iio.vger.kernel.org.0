Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72C7431662
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJRKre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 06:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJRKre (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 06:47:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 23FC7610A3
        for <linux-iio@vger.kernel.org>; Mon, 18 Oct 2021 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634553923;
        bh=Ap7XEP7xXlsWnqOwNO2qaKh9CKM7ORw5YQnKyyPZNVg=;
        h=From:To:Subject:Date:From;
        b=SpdkSNvWyymdg2yYDGWx05zX7mD4z71oS2J1Wg1oIpzA5keIgLx0dcQ8MOoBOOiMH
         oLAm1Rlw6EMDL/lwgmp81tu1bzjCq+RzJO3Dwh7lw1VM4VTI6MSCIEOu0WoyFlHSxN
         N8A2jUP6+KC/4fmUeBhQz8bOD9SQk7hUmxCyTUL2cuzcdECCjjvmCP5EwQGhxf2cmz
         jbpLxIUC3efVBjL+BVDRpiOidmcM0QK4YoA1zRB/+J+ftyxciWYooxjv7v3pt9EGOO
         fIgJ1wyI2AiZISC4T1PQe5qLjUHuSmA2tq/3d9nspprKtJlZQuCk7HUUaVwjHVNQBk
         cQUjZD1ujqV8w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 0F9C560F52; Mon, 18 Oct 2021 10:45:23 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] New: Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Mon, 18 Oct 2021 10:45:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waownn@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214751-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214751

            Bug ID: 214751
           Summary: Lenovo Yoga Chromebook C630 i7 missing support for
                    sound, microphone, touchscreen and gyroscope
           Product: Drivers
           Version: 2.5
    Kernel Version: Kernel: 5.14.9-1-default
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: waownn@gmail.com
        Regression: No

Description of problem:

Lenovo Yoga Chromebook C630 missing support for sound, microphone, touchscr=
een
and gyroscope

I don't know

Steps to Reproduce:

    Install openSUSE tumbleweed on Lenovo Yoga Chromebook C630 i7

    Sound, microphone, touchscreen and gyroscope don't work


dmesg -l err

[ 0.102481] x86/cpu: SGX disabled by BIOS.

[ 1.773005] bbswitch: No discrete VGA device found

[ 6.557733] bbswitch: No discrete VGA device found

[ 7.619221] raydium_ts i2c-RAYD0001:00: failed to get reset gpio: -16

[ 7.644559] elants_i2c i2c-ELAN0001:00: nothing at this address

[ 7.778824] cros-ec-typec GOOG0014:00: No port entries found.

[ 8.992072] snd_soc_skl 0000:00:1f.3: Fallback tplg fw dfw_sst.bin load fai=
led
with -2

[ 8.992190] snd_soc_skl 0000:00:1f.3: Failed to init topology!

[ 8.992269] snd_soc_skl 0000:00:1f.3: ASoC: error at snd_soc_component_prob=
e on
0000:00:1f.3: -2 [ 8.992423] kbl_da7219_max98357a kbl_da7219_mx98357a: ASoC:
failed to instantiate card -2


dmesg -l warn

[ 0.112434] MDS CPU bug present and SMT on, data leak possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more
details.

[ 0.112434] #2 #3 #4 #5 #6 #7

[ 0.797040] i8042**: PNP: PS/2 appears to have AUX port disabled, if this is
incorrect please boot with i8042.nopnp**

[ 0.797490] i8042**: Warning: Keylock active**

[ 1.745759] systemd[1]: /usr/lib/systemd/system/plymouth-start.service:15: =
Unit
configured to use KillMode=3Dnone. This is unsafe, as it disables systemd's
process lifecycle management for the service. Please update your service to=
 use
a safer KillMode=3D, such as 'mixed' or 'control-group'. Support for
KillMode=3Dnone is deprecated and will eventually be removed.

[ 1.772713] bbswitch**: loading out-of-tree module taints kernel.**

[ 7.619142] elants_i2c i2c-ELAN0001:00**: supply vcc33 not found, using dum=
my
regulator**

[ 7.619161] raydium_ts i2c-RAYD0001:00**: supply avdd not found, using dummy
regulator**

[ 7.619176] elants_i2c i2c-ELAN0001:00**: supply vccio not found, using dum=
my
regulator**

[ 7.619192] raydium_ts i2c-RAYD0001:00**: supply vccio not found, using dum=
my
regulator**

[ 7.764465] raydium_ts**: probe of i2c-RAYD0001:00 failed with error -16**

[ 7.780375] elan_i2c i2c-ELAN0000:00**: supply vcc not found, using dummy
regulator**

[ 8.377570] Could not create tracefs 'cros_ec_sensorhub_filter' directory

[ 8.377575] Could not create tracefs 'cros_ec_sensorhub_data' directory

[ 8.377578] Could not create tracefs 'cros_ec_sensorhub_timestamp' directory

[ 8.377583] Could not create tracefs 'cros_ec_request_done' directory

[ 8.377586] Could not create tracefs 'cros_ec_request_start' directory

[ 8.393085] da7219 i2c-DLGS7219:00**: Using default DAI clk names:
da7219-dai-wclk, da7219-dai-bclk**

[ 8.659892] thermal thermal_zone7**: failed to read out thermal zone (-61)**

[ 8.980605] HDMI HDA Codec ehdaudio0D2**: Max dais supported: 3**

[ 8.991953] snd_soc_skl 0000:00:1f.3**: Direct firmware load for
9d71-GOOGLE-NAMIMAX-0-tplg.bin failed with error -2**

[ 8.992017] snd_soc_skl 0000:00:1f.3**: Direct firmware load for
kbl_da7219_mx98357a-tplg.bin failed with error -2**

[ 8.992067] snd_soc_skl 0000:00:1f.3**: Direct firmware load for dfw_sst.bin
failed with error -2**

[ 8.992851] kbl_da7219_max98357a**: probe of kbl_da7219_mx98357a failed with
error -2**

[ 94.340046] pcieport 0000:00:1c.0**: PCIe Bus Error: severity=3DCorrected,
type=3DPhysical Layer, (Receiver ID)**

[ 94.340051] pcieport 0000:00:1c.0**: device [8086:9d13] error
status/mask=3D00000001/00002000**

[ 94.340058] pcieport 0000:00:1c.0**: [ 0] RxErr**

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
