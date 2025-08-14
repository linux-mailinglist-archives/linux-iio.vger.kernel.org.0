Return-Path: <linux-iio+bounces-22705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC3B2599F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE031C85DEF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE29B248F4F;
	Thu, 14 Aug 2025 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeCJ9QXz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007442FF64F;
	Thu, 14 Aug 2025 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140050; cv=none; b=XUPRk5/B0zkdzQw77ijyqA1TmOR3A9a25J15vR6fbAk5OZEIEy4xG+ZBhATCYZ5Y145h+JWrruyI4zJhOsfWS2bjF+6cIj2nFqkE76F6dxkYcgHk4PLqlFvmu6yX+vu5nbeETmYotZ8dbTkPJi0XZ/OKlyVIbft9vRd6Gym6nVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140050; c=relaxed/simple;
	bh=IPs/CdU5SFShcZUAmrgYz+ngCG9M0YqvInrd5rVzTYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S7U1cqlmVGDcl4z8LOeXMzeQK1Igm3xmlI07ahiIoOaEz4eiacfd9AFNPG3XQTa9TYi9BinstVt3Vqdn7XKcm1dssZlEL4YoZM4LrwoAi65lS82fN6JtNct8wXMJE8hOP2N6J9riaOvn7b+JCVclyXJ9uzYKMYymC3WOtpHrIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeCJ9QXz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea79219so637574b3a.2;
        Wed, 13 Aug 2025 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755140048; x=1755744848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPK6XhCB6BaLw2B2fuHUmN4hdU/b4ajunJ9+s3/wbF4=;
        b=BeCJ9QXzaGCVxE6bpOs+t/Foxz/uG4RgbhSi5hwodWmqrXCDQs1eAzOJ++4nhmbyDF
         O/JMdYqoPyzDlZ/G93oprEj6VLOgkK+t/aCss9q3OKVLdbf8Srej5whSzjMxDP1TIzfr
         rOafFqpvy3cJJ7vMV+EBB1J98H3JZWVOUxVhpPbbP8T4dt52RaZWS7ERna4Hjrg3GKbh
         NiA5dSh1H8V8SRiCU0iGsXyC3+Y4j4Ba9Xr9w3qgrwRa6zAgPZvYPgIhSe4IyMvmJSqi
         h7r1OEE3LMR8lYH801aPtnD6OdNObpqanjr+NhMD0nHBTKJFNMZIeVkjzyWA7A/ylS9o
         eJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755140048; x=1755744848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPK6XhCB6BaLw2B2fuHUmN4hdU/b4ajunJ9+s3/wbF4=;
        b=uN2lj1FTJTa7yUuXaCnO4MEiPU2YzHGOgxDfe/XjqmucY7r4+mk5rAJVIRF+v0sP8X
         hkrAsyfY2ekEVum6VQfHGzepNwKu+SSEHftp8XVKgot0cisj+MWf89UhICcGhnWEP7eW
         eSNVHqA2lVcTOEgHlXNXmtkQxut7HoLCm3VoaNjfzC+vvcky4HYtPBzFpH6EGY9lpwNi
         PC4PYQm5v8FxGARnwp6/6yR4jX10+5tcyXxx5cPNS7oRpPyDhxKoP2SdOjj2S/RYyWzp
         ZlvzqWCU1S4FUHhaGlYA5XIsiY/Xkd6xfTTZKkoJ129GrVAoWokDziG2jnVLhdDp0FAq
         Swzw==
X-Forwarded-Encrypted: i=1; AJvYcCXQiDMBdIrE3YwcXMK3/H9CQzBSWnjJm2qBazG79RXifFpF8Rt07nDWsuEL5aqKk6WakiK+qGkiO2KV@vger.kernel.org, AJvYcCXnBoqB/7BRQGH2kxmXZLuqDiOd9rA8jWoR+XlNbGRB+DOtlvDvPPxHphbPBL9xGcUZ/L7/wSknReZM@vger.kernel.org
X-Gm-Message-State: AOJu0YwalY5s2D3zqUI8xWaeHRgRoD4Du2Y6aeLMXsfBLAAoBf46nhao
	zQf4PRgPfjuDp7LVDscPkBMOr4+Rvy2HNZklOjPqyRUHxtrDJGRcRYeaVwn/fKE5
X-Gm-Gg: ASbGncsxuogmJXpMpyP0Id4TZ22Dep7zzSheDr/oV0V4rLln7+YfHgVhKO63e1lYJwS
	B0PMUTGxr6H8iIghqsHIE2wOpQjt8r13V5p7MRcFncq8hMXGapnX132WLFEEmP1fdHN65WSOZkk
	HiYnJSTw/R7kbUpIyW2o8rycashUz5E/KrCKVPRRF7cziDEqZAMU2zdC+cTrzz4AY/ivlvZwH5T
	2sh8K6UYpy9SccVA3mtzyr4dv32S9Rx+GRrRvZuzoIyD5NcJm+v9IaoxtrHpSLxIehi1ADBpQe/
	1IGJHV8WCeqbwW/4JGKvlzMxERiKcdvQ5xu/3ZZKh+kWnn9Dnod0hefmtx1CNTToZN3+o6ajZ8M
	PdCXYVpoRvcXKi4ZJjxTl0GlLK1b4Eg==
X-Google-Smtp-Source: AGHT+IGf3HXKd4TVqr4Z4ivYYKjCOUIY2Zt6JclfblUFUGBE7+7FiJuKmTiE3oVAvNQ68GHzR0Bflg==
X-Received: by 2002:a05:6a00:1708:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-76e2fbf0868mr1834486b3a.1.1755140048119;
        Wed, 13 Aug 2025 19:54:08 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c45:768d:a218:ee72:b12d:78b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c09adf8efsm24716473b3a.68.2025.08.13.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 19:54:07 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v4 0/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magnetic Sensor
Date: Thu, 14 Aug 2025 08:23:42 +0530
Message-Id: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZPnWgC/43OzQrCMAzA8VeRno206dZ2nnwPEdnaTAu6STuKM
 vbudrv4cRCP/0B+ycgiBU+RbVcjC5R89H2Xo1ivmD3X3YnAu9wMOZZco4LhkopKOojUxT5AUke
 hINgShLFaIK9kg5rl9Vug1t8Xen/IffZx6MNjuZTEPP0DTQI4OKotR02qlbg7XWt/2dj+ymY04
 QsyHH9AmCEySrvWqNpV8huS75D+AckMNYY7tE0h8POjaZqe5J7BLFIBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755140034; l=3978;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=IPs/CdU5SFShcZUAmrgYz+ngCG9M0YqvInrd5rVzTYs=;
 b=qw2YUpgO7mNzZROiyyFHEzQYsUfB8ql67ghrmJ7LFXiNRpKEFP5vhBM9/q7++NO+uaUufnk1N
 B+Qlvm0/IvoB5owhIMvH3pCoZ7DadSEAtHVrJYkSGlZaZ2NX79G5tkW
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
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 530 +++++++++++++++++++++
 5 files changed, 590 insertions(+), 2 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


