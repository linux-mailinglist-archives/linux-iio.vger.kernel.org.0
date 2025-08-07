Return-Path: <linux-iio+bounces-22367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF71B1D109
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 04:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80D37AC6A5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230111C5D72;
	Thu,  7 Aug 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3vmQgB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D679EA;
	Thu,  7 Aug 2025 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535419; cv=none; b=kACJId9QYqPXkwkGoIZ0VBBdeIh1K6InFXeLbWJhSGkol9tSFzVFXCLRuA3pbUkCjzPS7N3oGpw0RdQBOkx5eMc6galbJ46Xr4VeYMcIsfWT/6vYMKE93EfUh6T+b/6uSECInl5tQGur8M+jCURE9V7wEqjalVRpx6alBJBN33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535419; c=relaxed/simple;
	bh=5gsDhUUu0YewVraajI5ST4xNFfyjkzz4iZ6/WurMj1k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tBOXr1eWyXtEAKLZvYMQMYM/WwMXEKbW3ZGFeojZP1o1kkG2n9GSsIZnogECARRw1rtzBRhH460UsG9AB7vxHyu2S9ovyKgHh0yon9q4aejSu/rmlQWRa6nP5XaiUGpGw3BjMyDZIoHmOPWkWfetBq1qvkUnuaMMDROhtrujshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3vmQgB+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24031a3e05cso4084245ad.1;
        Wed, 06 Aug 2025 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754535417; x=1755140217; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3LODisSP9Am9xo+yK6CL+zDBg1PshH0c9TCWiHfwok=;
        b=D3vmQgB+RLkdUFu5j0iBqmLL8X4J7lDwTj9yQ9KpiruWBVwLFM801oxlksS13UxV//
         XiziU1uUbpmsZn+8W4JMP/oEoh0DtlXZRLH4FeKltNXuI6NUd2FhxGPZfqQbYd2e1iE6
         kH2RjQ4nzxmVIqFrzC5FY9eIv98fkP2KIXp3USwh6+WRcTIR2IRInEpni4WOq9pjTKAG
         4ZuZK93hMHVpasUlX98LfFH6e9frWZTDeTK7QdacYtzVc9X4FCbSasvjt2dKSoiFcWyZ
         +hAp++n25JzRiqFSxJhVkasKSmPl69seiKutrzuSB/oVgZ9OYIaW4Rzcax1CbVmuWtot
         aGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754535417; x=1755140217;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3LODisSP9Am9xo+yK6CL+zDBg1PshH0c9TCWiHfwok=;
        b=jPP5Hd7ea4j9RPLKKzbW2oy5SNP3FYh4e2KUBGhWubsED970BK1hFXiFwIoTff09V+
         TqMFs0G73y20MJNeNvXsyXFzfYJTrK4u/TMpXi2Xhp9fvzlRaBPneZYG3bkTVU0Ah0Ul
         Zp+rCLYw34cr1bzGZqIhk2fVglzCylrM5Rb91RmqaChJ2ZwJ1qZM1mckUIS3xmo/M4hI
         7mpdPeyNqrINwh2siib8zgZHdW5vbmoVFlGmzVFWAlLer+jnU2P6a46x1+ArC7qEr+Jj
         zwIEVwciRTjPNjtIBlifp74BEjO3C34pVjVh1PkxRtlTUVwI9E++mO9Hi2mBQQIF57hC
         lenA==
X-Forwarded-Encrypted: i=1; AJvYcCU93HXBVbvm+X4Ye4chDWb27QcM9VV/YxULeKy+aRSUYsooihjuXABT591jezfcsnJtAsJcelBxw8ZK@vger.kernel.org, AJvYcCVl1HZ5xGm/J9fGfh60KrFUAlT1lVah/aXEkQ4sItUYgZV9C7PC00TAy8DUMy1KfJM6mr4mkrXF9K4s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yc5pV9E4RyiGYIvE+eAggr8Y+l6gtyMjZDPMjCWeTkzV7++R
	dbTtkuETX/3limMwns4f84dfbMrg5+4W384kLyKXJ/tAgtMs7a+zNz6PSErNGcp8
X-Gm-Gg: ASbGncv3gCMm90kCSSSk3AKRphUVyx0Oay+ce7YnbbIFvQpEu3lBFDfibaxanNsLxqR
	B39ovuBi6dXUwHylYbIEGoy5hZIBW00m+eU+sOu0igQKp2OVOm7lEdyavkbcLYG0b2SLaBdPTP0
	3as0HZRc4lmOXSd9pQzZIvuJvPr3zfFYx20ohdkvnF75RWujPxaCzP6Re+Hn7Hv88LhUds3iu+g
	yvJWXm/J0XDPmYahmVXD/MdVY2IiwZyKic6oMpjJjorWlH1MqCsNrfXhku8SAFU+GpcpIBDR3yC
	cIzZTIZY+u/eV1eVsuE40bHzUkmDit8NyRZgZaib2f+gf1ePnGSn51voLckgZJprbp758OxM4IB
	cPpvpEPuijDAKxwOUamZbBhtPf2bHqiM=
X-Google-Smtp-Source: AGHT+IEVdJUXne67I4vdWYVsDxe2YgAwJOPhzPFGtFjxwyq5LYsupjylXEoXDYH48HUE224pCs+OHA==
X-Received: by 2002:a17:903:186:b0:23f:b94d:7da7 with SMTP id d9443c01a7336-242b06df8f5mr26776535ad.14.1754535417100;
        Wed, 06 Aug 2025 19:56:57 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:c940:e6ba:2cae:4deb:130b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0bb79sm20885560a91.31.2025.08.06.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 19:56:56 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v3 0/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magnetic Sensor
Date: Thu, 07 Aug 2025 08:26:34 +0530
Message-Id: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIVlGgC/43NQQ7CIBCF4as0rMXAYIG68h7GGIRpS1KLgYZom
 t5d2o2ujMv/JfPNTBJGj4kcq5lEzD75MJYQu4rY3owdUu9KE2BQMwWSTkM+NMLRhGMKkWZ55ZJ
 GW1OureLAGnEDRcr5I2Lrnxt9vpTufZpCfG2fMl/XP9DMKaMOjWWgULYCTt3d+GFvw52saIYPp
 Bn8gKBAqKVyrZbGNeIbWpblDZVNo1MJAQAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754535409; l=3413;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=5gsDhUUu0YewVraajI5ST4xNFfyjkzz4iZ6/WurMj1k=;
 b=Q0DHCKJdSP7RIdywNL7YamVmu2PXOLKmXoSvrg0WVJeWDg7AUwSYx99GLwAT+agPdaITJCKmn
 qkQ3ne0NcvqBm0RfsSogLvBTHugM1vdJ+BNaHTbwYoeUHkTdAS8p12X
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
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 524 +++++++++++++++++++++
 5 files changed, 584 insertions(+), 2 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


