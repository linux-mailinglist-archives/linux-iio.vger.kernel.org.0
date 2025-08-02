Return-Path: <linux-iio+bounces-22179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287CB18AE6
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB43189F9ED
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B11E7C1B;
	Sat,  2 Aug 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnWSVOMC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425261ADC93;
	Sat,  2 Aug 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117080; cv=none; b=LwO0yImiNxo4ZVap/nSDxYoLgTFqZO46NWRY5X4/S5lT90YA8u52ymkEMYm6FL9FQkP4cteD3YuOY9xShVCo5Mmm48XGAi+ppIiwLPfOj3B/c5OYTUvPSi8CGpdpReF3Q2ot99tAy8XhxhlEJhXtw20u9rnEyUSwzAnf2phMU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117080; c=relaxed/simple;
	bh=0mQPov0rVCRElCFXUgeMav7fHbvPFpDuvftPRtczvPI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gcAUqibI8vwdeOpMbhVISV/mIN6nFjVkwng35MxoG/vHk+1PM3iU2nvVmKTYBOxe1OgDNv7Q/wh409v04hYf6MixeWWBvSjlIYpQ9wxIbBkxU2oiaieKnlChO1z0EeieQk8uEFlChLZQzFLst4nnVNdkPLTNGMVvb3kJxpvYMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnWSVOMC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1515288b3a.3;
        Fri, 01 Aug 2025 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754117078; x=1754721878; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hSbLG/kXsTfrc0omd0Uf8l9GUcnOAkkKSRkCbB5vVo=;
        b=YnWSVOMC6ahtK1r11C/PsDaduHFoNTICnsAyPLJyabJTUh459ULBpRBLyCiigyJ8S2
         47+LPxO8k9YiHl+Bx+nErL+CUNYifnRXQnGfI0taXJZFYZNlYmQvpBC06hoL85CTpzi0
         YQTsPhqj/N8sCL0aCK7NH29SXtz+3Fzpgjiio2Uao6o4U6LD3iqQFo4tcC2WxeGtu7KU
         8cmOZW7YUSyLkpL5Ubd8oDKXoPJFeHVXuu/SLjmuFvmncBfvZNOfT4GV/P70qsgGp65n
         znC/eRDY+FD5qrxhxHKCCayQ4DFWObH8MYThRca/LRokKbTAhXxtMJID7TNHKVzWVZxG
         562Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754117078; x=1754721878;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hSbLG/kXsTfrc0omd0Uf8l9GUcnOAkkKSRkCbB5vVo=;
        b=cllxRn7cqPoM0zhWxlPasqN756Eb+ZVRMFrcmZSfhz5Ydk9z5KWLf70RBCZVoans0Z
         QBgIEfSkSvtbOa+JJiUkzLwS4blJ2JR4kNFKzIgUslB/40aTBQI5Bygf6QmUbJ8zXGG9
         CPSN6RZr1y35pzx/kjx7ArY9uS8Njt/vxd6CIe+SeosZlS4kMWcYRLWzlbG26Dxbropt
         pC/liAYt8dT4+7UWrCNTG9lRV4bh9My3Jdq3VhrDGjY+q6NG0IWKinn5HyMFETjGJLAo
         E2dncbwW+O0do5QCLOTtESfYQC8ge4OAZoxr3b3iWkRzNuQ0hVOjMspI16TO7V3ET7sv
         7OaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC2BlqervPDtRFdbziAqsveHTPRN7t7A7bQYMYgpafWAimDyYvnHf9mN6GO8VS0qpYcnRsEZjuLZ6+@vger.kernel.org, AJvYcCWJP+eU4fNjgEYr9TzxU/mFXOa8KvRSPmkWgiPdP8XLDS6ySrAWW5/+oGeW+pfNkCMpIGQ+DcZPsA10@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIahb5oxLPRXLZ2+dJoSR4EjdB6VFuBLoRXAyxrmMoq2PuuWo
	74wDKBIJydE/NFNLkEcTpXkWBEoZ/symYpTBDMoxNzAPyf7N3hnXIq1qm93t0Zz0Zf0=
X-Gm-Gg: ASbGnctDzGz3ytkWcvUWvaqraQo5m9BcSsXL8sKh8qiqwpTNbD6dGI5JzEZtIVvoyNz
	eoYlboaj50chT22rvpLe+0Zg8tugY1tEqQyKR81H6RAhjqFL5HvCfvN+bZACBq8SVC7gKTnB0JL
	cd6gVNR+g3qkWe1o3VXg7Vy2ca+UZKfjvzqerAsG+Li9KxiGUUbvU98fxdjuXAbqPmUxN49eKjj
	B+msiazgrWFgHfXrvg4RM5dT7qv4I7wzCYrc2k0eKWdyibVFiydd19DYKUFNEx17A5Y8uAikOOU
	KULpfMI6+qmKoNg2CUinKMulxFZ1G54cR6wzMR5XDrnUdrKTkoMM40s9yFmgcF1MpA9oamHW03f
	PAd5uB/KMVW23jrd9aDkWGa7srcwHAJo=
X-Google-Smtp-Source: AGHT+IHfAxGhYe3/HsjF60/jsO7axYdU9Dm+rvGTwd6Ds1cQzOQT6OAtuF8+9Qiw/p2lU5mb+Q0oKw==
X-Received: by 2002:a05:6a00:23c5:b0:748:f74f:6d27 with SMTP id d2e1a72fcca58-76bec4ec39bmr3091386b3a.24.1754117078143;
        Fri, 01 Aug 2025 23:44:38 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c43:2e47:cb90:ffcc:76af:a5b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9003sm5639676b3a.125.2025.08.01.23.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 23:44:37 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v2 0/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magnetic Sensor
Date: Sat, 02 Aug 2025 12:14:26 +0530
Message-Id: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqzjWgC/42NQQ6CMBBFr2Jm7Zh2kFZceQ9DDJYBJgFqWtJoC
 He3cgKX7yX//RUiB+EI18MKgZNE8XMGOh7ADc3cM0qbGUhRqSwZXMZ0rooWI8/RB0zmoQ0GV6K
 +OKtJVcWTLOT5K3An7z19rzMPEhcfPvtT0j/7RzRpVNhy4xRZNl1Bt35qZDw5P0G9bdsXIAr0j
 sAAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754117073; l=2823;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=0mQPov0rVCRElCFXUgeMav7fHbvPFpDuvftPRtczvPI=;
 b=0V7O3YzB19tSDjPnpVgepEEBAZ+rbqhTfEJH9d8C/x93RykR74ErwVfufuwYLvHeWmqGUHXLO
 FizKoqUG0ZiD2eL8/CKj2Qmy5N1sjbYi5mtsecT+AI2BKbmUrTDcRpl
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

While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
configurations interrupt(INT) is not recommended, unless timing constraints
between I2C data transfers and interrupt pulses are monitored and aligned.

The Sensor's I2C register map and mode information is described in product
User Manual[Link].

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
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

 .../iio/magnetometer/infineon,tlv493d.yaml         |  45 ++
 .../devicetree/bindings/trivial-devices.yaml       |   2 -
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 556 +++++++++++++++++++++
 5 files changed, 616 insertions(+), 2 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


