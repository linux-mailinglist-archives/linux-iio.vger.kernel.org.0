Return-Path: <linux-iio+bounces-26441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3522C82CFA
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29BDC348B1C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9B2F8BD1;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edqoi3Qx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17521248F4D;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=ididoSfT2SXkZdwHxYHAMmiDd3KcJtHOdohCgrC501njWMDgy+bR0tvsS3hSO6azLdh3y9BIVpEw9LMxId+sUXVZq80It40Fplt8ncGSiy5/f/j75Zv13dF1BtEwLPyx442cdu6yKSlBaokrzyksFYpwqt9j7hnX97UH3soke2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=rs/PPMlFdCT/Pf3PQDX54OBNFXURzd0TYtU1/M9BHno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O5ixC8AkhiLRMBekj284AHVmJFaMVaCzn9Cprt41hkAs3n4ov7nZ1w/b7x+7ALBdbKkBDybrMszbUaOKgln6cwcffQmMqZRZZj+aoTvFO8oUNdYg7G3xMQ2VT4pWpn3ucjtxpZGupOzzC1/OSB5lpxG34GORGC9LGNHuR8Su4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edqoi3Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9153CC4CEF1;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=rs/PPMlFdCT/Pf3PQDX54OBNFXURzd0TYtU1/M9BHno=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Edqoi3QxeYOGJpFApMZpJyH/bWlWpzANYys35f0IyqrVjeHuL8ettusUgju5E+zvM
	 YwD4ClU9HiCojDRDSoZCqsTLd1xpsE2G+bow5yry+3jx5Wti2DQzR4lOtVXUPzBlxX
	 bL0zQUOQzi+LH467VSmszA8AC77vZAE2SAJzhe0Yje7fjGQjWDa7kduDmm+QqdLhw9
	 b+zjrt7HbYtdOdRcceaSh/9Qk0kund3oW1nt3Z2XQmn6lI6vJ2tkH2dsjYOFoG4LQt
	 2KRQkQjSrQe26jqtEmUBZITxEcfNxVlhXnsEfVgxQH1VHQxkMZeDH200PoSiWY0YwV
	 fZAtmIvxphW1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AFECFD35F;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH v4 0/6] ARM: dts: qcom: msm8960: expressatt: Add more
 peripherals
Date: Mon, 24 Nov 2025 15:35:21 -0800
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALrrJGkC/43QTW7DIBAF4KtErIvFAMYQVVXuUVWWSwYbxT8tU
 CtR5LsXOxurm3T5Ruh7w9xJxOAxkuPhTgLOPvppzEG+HIjtmrFF6s85E854CQCG4vUrYIxNSvX
 obN1Yi309NO1Y977tEnWVRsa1qUArkpX82vnr1vD+8cgBv39yUXoMybByW9Hx8AqV4sCU0UqYw
 ohKgyiUFKUuOTMAWgsDxhSfkqbb6YJhxL6YQvtGVrvzMU3htn1mhg3/994zUEaVUA6UY6V18tQ
 Oje8LOw2bPfOdx+G5x7NXSovSCGuVdX89sff4c09kr9JnWE/DhWJ7b1mWX5nezQTKAQAA
X-Change-ID: 20251119-expressatt_nfc_accel_magn_light-f78e02897186
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=4872;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=rs/PPMlFdCT/Pf3PQDX54OBNFXURzd0TYtU1/M9BHno=;
 b=7sljrFwOBw9yYgoPfrpm19GZ6nr/hmUDcEwqn5vSqnNQ9x1yx5ZAPsUg3TZDCmhYHQy0pTV/0
 1JAUFOuPMEqD8q2KqXZ2kZOKGPhN6jF+6/m7U2/KObqzX5XHGGV7iPK
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

Intro:
=================
The following is now working on the Samsung Galaxy Express SGH-I437, an
old 2012 Android phone:
- Light Sensor
    - Proximity is currently floating, even though it matches downstream
      GPIO pin
- Magnetometer
    - Regardless of orientation:
        - X axis seems to always be negative
        - Y and Z axis seems to always be positive
- NFC
- Accelerometer

Tests:
=================
Light Sensor
=================
// no external light on sensor
samsung-expressatt:~$ doas monitor-sensor --light
doas (user@samsung-expressatt) password: 
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=== Has ambient light sensor (value: 0.000000, unit: lux)
    Light changed: 7.000000 (lux)

// external light shining on sensor
samsung-expressatt:~$ doas monitor-sensor --light
doas (user@samsung-expressatt) password: 
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=== Has ambient light sensor (value: 0.000000, unit: lux)
    Light changed: 318.000000 (lux)
    Light changed: 390.000000 (lux)
    Light changed: 421.000000 (lux)

=================
NFC
=================
samsung-expressatt:~$ sudo nfctool -d nfc0 -1 -p
doas (user@samsung-expressatt) password: 
nfc0:
          Tags: [ ]
          Devices: [ ]
          Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
          Powered: Yes
          RF Mode: None
          lto: 150
          rw: 15
          miux: 2047

Start polling on nfc0 as initiator

Targets found for nfc0
  Tags: [ tag0 ]
  Devices: [ ]

=================
Magnetometer
=================
// no matter the orientation x is always negative and y and z are always
// positive. The values seem to be changing during rotation, but for some
// reason the magnitude is extremely large
/sys/bus/iio/devices/iio:device1 # cat in_magn_x_raw && cat \
in_magn_y_raw && cat in_magn_z_raw
-441672
1223706
3275580

=================
Accelerometer
=================
// Rotating the device with `monitor-sensor --accel` running yields the
// correct output:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy

More Information:
=================
- Device page:
https://wiki.postmarketos.org/wiki/Samsung_Galaxy_Express_SGH-I437_(samsung-expressatt)
- Downstream kernel (uses board files):
https://github.com/LineageOS/android_kernel_samsung_d2/blob/stable/cm-12.0-YNG4N/arch/arm/mach-msm/board-express.c

Note: These patches were assisted with AI (specifically Claude) as it
was easily able to translate the old board file into a DTS format that
mainline understands.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
Changes in v4:
- corrected accelerometer's mount matrix
- fix a nullptr issue in the accelerometer's driver code
- Link to v3: https://lore.kernel.org/r/20251122-expressatt_nfc_accel_magn_light-v3-0-78d198632360@gmail.com

Changes in v3:
- More formatting changes
- Remove output-low on nfc_enable
- Resolved TODO mount matrix for accelerometer. My tests are above.
- Will try to eventually solve the following problems:
    - Couldn't figure out the mount matrix for magnetometer
    - Proximity is a floating value even though the downstream kernel
      matches the GPIO pin
- Link to v2: https://lore.kernel.org/r/20251121-expressatt_nfc_accel_magn_light-v2-0-54ce493cc6cf@gmail.com

Changes in v2:
- Fixed formatting issues
- Use GSBI instead of i2c-gpio
- Remove regulator-always-on
- Link to v1: https://lore.kernel.org/r/20251119-expressatt_nfc_accel_magn_light-v1-0-636f16f05cf4@gmail.com

---
Rudraksha Gupta (6):
      ARM: dts: qcom: msm8960: Add GSBI2 & GSBI7
      ARM: dts: qcom: msm8960: expressatt: Add Light/Proximity Sensor
      ARM: dts: qcom: msm8960: expressatt: Add NFC
      ARM: dts: qcom: msm8960: expressatt: Add Magnetometer
      iio: accel: Prevent NULL pointer dereference in interrupt setup
      ARM: dts: qcom: msm8960: expressatt: Add Accelerometer

 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 109 +++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           |  96 ++++++++++++++++++
 drivers/iio/accel/bmc150-accel-core.c              |   3 +
 3 files changed, 208 insertions(+)
---
base-commit: a771210bab42017434c91411e16694ac4fd7afc2
change-id: 20251119-expressatt_nfc_accel_magn_light-f78e02897186
prerequisite-message-id: <176210698639.937813.643585209118839199.b4-ty@kernel.org>
prerequisite-patch-id: befdfe1948c2fbfb867597a6de917c8067fd57be
prerequisite-patch-id: 70a2b0837b9846d8a775f464295da73ca8ff26b4
prerequisite-patch-id: 20e005aa4312c3525e1b90f33a398189b9e2b3b7
prerequisite-patch-id: 970e0eb8af1736e4565fc37830576a67bf7b3227
prerequisite-patch-id: babd3b55d9ff28f19dbc3f7978742c58ef436aee

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>



