Return-Path: <linux-iio+bounces-23349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7EB3B130
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B83517B83D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 02:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BF21CC55;
	Fri, 29 Aug 2025 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uru/erYi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995D1A58D;
	Fri, 29 Aug 2025 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436032; cv=none; b=OKa87iucsKahQAWfR0AS7VvGWDBSSMLn9J6T538SddSXh4DT7xunDMVojX1D5M4Lx/JvYKKkn1fAbv+BTVhPs+D9KWq9wmblt3xnLgYAKGNTIrXna0WJ79Q++Im3sTaZHv9frUTFjTFIYTk525ymojPbMPqafYDtxCtS49aApus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436032; c=relaxed/simple;
	bh=lrS8eTipz4hDoFsgRLsz8MsynQluWMp6bwHNB/jKdJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYtWm+U9ZxvjMBAc+yMAWuuJRhtsfLVCTiVJwIulyG3ZPVlkdQT340qUwxpwRadWlRfNhZE87GaAGA3oxSZGzaVIOVXjSeWMRY2g4aF9+J6x7UzdYnXY6TCFRVAtrvgalrjUl4UpMQUgNhVx8en62h2DomqzDX6z1UdIhD4BX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uru/erYi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c72e4f1b6so611114a12.1;
        Thu, 28 Aug 2025 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436030; x=1757040830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smUOFTCCAsMnkVgaiyRy7urEquHn3iGsJACNQr9d3Uo=;
        b=Uru/erYiYOvo+N1BkrwwvD9V2dDk2H8JnQwyhAf2/+ctas4W2TijDIr9r7lvN44llW
         aIRmIcXLG5g1HZbtX9ehUQM9PgJ5YuyBQzoRXYEuj3R5If/EYv/SOKOKxmR6t38lezH3
         YJdq9/96/61eQDtj/6zstHqxgI1RgluBy5MLkONL/qXqktY0AMsAUPiHjEARNm4+Tq6b
         +Dehs2WWJuaajBDjA4Bt+Zbk7Q34pZXLAcr7X1Mfi9oDcgNi0E9PI8QQ0uap1dsbxziT
         itgVIiGMt6CwQU0ZIfikxj0M1znrQZDDIqoUS642+PaESUodKO0hqqJpwU62/U4mIH2z
         Fqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436030; x=1757040830;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smUOFTCCAsMnkVgaiyRy7urEquHn3iGsJACNQr9d3Uo=;
        b=akSF6STtKXV1GUwZ4wnWewVNoKlTYq6v5esO3BDjfjggMBPbioxc5XLoeYYmwSAnZE
         HqM1myFvtg5I4ly/lWYuh2CrCh93ACowrxR4+g0Z+EvwrgI/LAQZIlqhymyvOazkS7sP
         DiJGFCs4jwJPHeTwIoeP4yPz7f4+stGkPCxB+bDqene5YC/3VXiYW7CQcn0y5BRFSBFa
         uL8eFNNyGV9nmQ5de2/R9plxfeBtVqdUWYjbcgWpDnD3ToLgDPEnrLo/ymVdTGyrbWbA
         Dth8Xxd6+UK9aPf4ekIhOVTwz+GgEukRuYN5w5hLbak0m6Y9r6ULpyql+TKp9mwsIFo1
         I4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWNNjbshP1J9wcOOFMcQ5B+DZfaqjcNkW9vDSz56P0BmrrYmOc1kCJ2h28F34h2wTrEHFP2hYLpmsKR@vger.kernel.org, AJvYcCXln5tvmqbpjEUTTmoLks/YFWyrSXhA7hOejxS/J3VGlNJN3CMuIRGZJLO6RPP84MubnxquT3zx5qyQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzt3zSnzUdit35Y7EqaWAS8goQIFibv1Ww4DrAPlhVAPUa5Ijd
	90jw0H8k/Qt4GBK6BaINZq7rL1X/6Xwn8KceGRUY29RfM70CHis4yZZM
X-Gm-Gg: ASbGncsH6Kku54cQUkcAGVP3YZa6j5rAjxFntt6pm1TTWyqT+ZUF5LWMp9zBtXC67Ap
	PUkbQQbxLok8fh4XDIKuPTPoKv7cmOakXguzvpmS/Zk6F4k+cEa05hXMsQCrCmthOQVtP9MtexH
	Tmn2r2CoK9Ie5lQVOM2PcJ5AsOoue0IJ/KLW2P3YZKu1ZWBr14wS5Qca6VTgVl9WbjyVvZdnZza
	DYvreWBiqZBdSy7CcAXAfjED1V9WrrrJa3R0+X1lVfi3DBtT05DCCzTT1j2T1k6NAd/8CtKNI55
	1pfcP9X7K/e+5v28A9ke20LmmnzW2dSjRYAaFrBPGyRqOSQuLCtk6fTNEQ+yg9/Bmincildo40A
	dKT+v09K87nkfRSG5Cp0Cdt77C1CJUI7jbpV5NvkFai8RMMkJPNg=
X-Google-Smtp-Source: AGHT+IEqGhRIDYKI/lqwT57D+eDPyWZcdztRjOO2pHzS6/z1ptk8OZbYTFEYJfhy8y8mDy4P9HsLBg==
X-Received: by 2002:a17:902:d50b:b0:248:fbdc:ed20 with SMTP id d9443c01a7336-248fbdcf21cmr31410825ad.19.1756436030015;
        Thu, 28 Aug 2025 19:53:50 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c45:7912:56c:6aaf:9eff:c2ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm9581335ad.14.2025.08.28.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 19:53:49 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v5 0/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magnetic Sensor
Date: Fri, 29 Aug 2025 08:23:41 +0530
Message-Id: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUWsWgC/43OwYrDIBCA4VcpntdlHI2anvY9SilGJ63QJosWa
 Sl595pcNuxC2OM/MN/Mi2VKkTLb714sUYk5jkON5mPH/MUNZ+Ix1GYI2IBBze/XoloZeKYhj4k
 XfRKaJ99wYb0RCK3s0LC6/p2oj4+FPhxrX2K+j+m5XCpinv4DLYIDD+Q8oCHdS/w631y8fvrxx
 ma04A9kATcgrBBZbUJvtQut/A3JNWQ2IFmhzkJA3ymBfz9SK0ioDUhVyIrOooXGOYI1NE3TG7i
 plt2bAQAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756436024; l=4306;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=lrS8eTipz4hDoFsgRLsz8MsynQluWMp6bwHNB/jKdJ8=;
 b=f3P9qrZfLMQo+6RBDOCGT4xek/k5u+XMa/bxV/afANzwoxYAbJKpiIaDpfWXKwA0GaRmhPapo
 +VxNwGoHmCGCzo9KzpM5zKbWI9NXDI/qAJuIDKv9hvnS1zs+OElEnvc
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
applications includes joysticks, control elements (white goods,
multifunction knops), or electric meters (anti tampering) and any
other application that requires accurate angular measurements at
low power consumptions.

The Sensor is configured over I2C, and as part of Sensor measurement
data it provides 3-Axis magnetic fields and temperature core measurement.

The driver supports raw value read and buffered input via external trigger
to allow streaming values with the same sensing timestamp.

While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
But for bus configurations interrupt(INT) is not recommended, unless timing
constraints between I2C data transfers and interrupt pulses are monitored
and aligned.

The Sensor's I2C register map and mode information is described in product
User Manual [1].

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
Changes in v5:
- Use USEC_PER_MSEC for 1000 multiplier.
- Change if (ret < 0) -> if (ret).
- Style and indentation fixes.
- Added entry in MAINTAINERS file.
- Link to v4: https://lore.kernel.org/r/20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com

Changes in v4:
- Include required headers.
- Drop struct device *dev from the sensor data structure and use
  i2c_client *client to derive it wherever needed.
- Use FIELD_MODIFY instead of FIELD_PREP to keep other bits intacts.
- Remove unused defines TLV493D_WR_REG_RES*.
- Drop the pm_runtime_mark_last_busy(). As now always called in the
  pm_runtime_put_autosuspend().
- Change goto labels to make it more descriptive.
- Fix style & typo errors.
- Link to v3: https://lore.kernel.org/r/20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com

Changes in v3:
- dt-binding: rename to infineon,tlv493d-a1b6.yaml.
- dt-binding: fix convention errors.
- Switch to using enums for mode and channel where applicable.
- Drop unnecesary input argument checks in functions.
- Switch to u32 array for mode sample rate timing from single member struct.
- Add note describing the I2C communication characteristics at the top.
- Drop tlv493d_setup_ops and use NULL directly.
- Fix typos in comments and commit messages.
- Link to v2: https://lore.kernel.org/r/20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com

Changes in v2:
- Drop regmap implementation in favor of using direct i2c APIs to
  have uniform communication APIs across the driver.
- Remove custom device-tree properties as suggested and hardcode
  setting operating mode in probe().
- Derive and hardcode temperature offset from raw offset and compensation.
- Add missing device name(tlv493_) prefix in global variables.
- Change float operation with multiplier to fixed value(1100).
- Change Magnetic field reporting to Guass SI unit.
- User FIELD_PREP instead of direct bitwise ops.
- Convert sensor channel parsing logic from Macro to function for
  better readability.
- Discard unused #define's.
- Discard IIO_CHAN_INFO_PROCESSED.
- Maintain alphabetical order of config options in Makefile and Kconfig.
- Readability fixes.
- Link to v1: https://lore.kernel.org/r/20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com

---
Dixit Parmar (2):
      iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor
      dt-bindings: iio: magnetometer: document Infineon TLV493D 3D Magnetic sensor

 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    |  45 ++
 .../devicetree/bindings/trivial-devices.yaml       |   2 -
 MAINTAINERS                                        |   8 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 533 +++++++++++++++++++++
 6 files changed, 601 insertions(+), 2 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


