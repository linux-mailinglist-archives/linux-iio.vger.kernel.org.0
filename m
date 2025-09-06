Return-Path: <linux-iio+bounces-23822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21809B46A2E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6904A08126
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164C27D77A;
	Sat,  6 Sep 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en1yONm9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C31EB9E1;
	Sat,  6 Sep 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757147885; cv=none; b=c6GH1V0rOV2bJ7G54yBBEgeiuykNTWgSSoAvy0SJgF+O9oGPsFXdsesKodt9bXG/GI1u2QpsHwev6fo7KaYsts3r4heKdJGB8xESMwOmyzOlR7eR9LplKYoRAO/wF4lFCNHxMLH5mpFHoo211csJCBvGqQQkJHdqW8FAa6kiZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757147885; c=relaxed/simple;
	bh=JraSxymtxrQ7rVKbYQEgzRtR5BKEvUbZ2v8Rl3tGfWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OKKhmTXxIGLYMVS8/gXtGkvE4srN/ILZr6EYMiGRjHOHwzKL4iJ+hSJ666wJT5TM8HYpteJA9dtRjABg78GpovxLtziapYyv9sbHEeJ53UNLN/ZiPG2qTttjDfLujwcmZKnz4W5ScdVckkD6OufSB+Wkh5rd3uQP3Vk1lX+hzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en1yONm9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244582738b5so23734365ad.3;
        Sat, 06 Sep 2025 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757147883; x=1757752683; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Em0A8Wyzxt8kNZyBnifQUAZnvXVnEcP6+pUCU/msrk=;
        b=en1yONm9iQ0gbGgNw2vL1mciManYhp403ny+kuCWQKBpBCgGwpe/FCUOc09Uem2xKu
         5ZycnkuWlt7KOiq9Z/lweHv7k27d7pPSXhoHcyHLxgk4dQR97wUV7skq1JSM275aoius
         xQqctfFjZKa/wEy0vW9NaSx/1eTEbNXVvkOb4kACMR+ePqESjNVqdc6DmXfdU+CVrFvs
         qYQt9Rz9kDBdYIMg3jRc92RHwUJ/ov6OJeepw3Xk4EgY4Vqjlgfnp7d3wst5S+PTazUB
         R2PfL52QXSXAcKc+x5fpncdZEfwLB0VqudW/2T2XUNNX9rS9NInkGcspDBZFlBpszCmf
         Cy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757147883; x=1757752683;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Em0A8Wyzxt8kNZyBnifQUAZnvXVnEcP6+pUCU/msrk=;
        b=OYxsb3b6oAwUCnIV0xuoeTy4Xy0LAQgu9HytYiaIErs2JKd0KDzD6tSDIMsLQQ2q0S
         YnH2tsq04Fi8thfmfAVhVYm2WzleCSb6YyYnRUTS2ZwGzlmvVkiD+YCduYbuzi57tUsV
         7aMoO/7QyUiZeibf4wFZD6qzY5SIH+j9MFSUbKU4fUZpXaXMuVqDsgC6OqmZ8sVPr7+J
         RvhV2EmAx/BSiNC5v+odta8mgNF0rwZX83PSQLpRB5nmxdubyONCvmfeWrPw/GTd8yeS
         mzonYi83WHVRjEk5RHeaxWJici8UY+ovK3/ZWAwi1VjgZ5jZakRmkjqDzYT8fN9cFT4N
         hUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy1t0SPqi1H29s50gLMqI/l3mqEEP6bKY8PmuSZNoXeo9q7eAqIfeLHic0C7eFQKOFusW3vxI8toF7@vger.kernel.org, AJvYcCWZ3eMIBB/YbrTFlZfh8pCU0pPBgpPi22aCUEMgtraJ37r0f+FUfaSDxEqipD+BVH9hJPERmb8EmoP3@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVKJ1F0gkIe1fTELUWNvmK+Ib5myKG9b+JSoWxSNq4tOO6s2k
	TWlu1Kbs0RrZ42YxJW6i06Xlo/hMMFELZH7d6ZSLVABLIBAKXdQ56OOS
X-Gm-Gg: ASbGncuyDpUyDHTatsmMnssMXxmuF7gcgHTG7/L/rrAWeuqbrik9WCZuO5TqTBQ+Tr8
	Cjxd/qF7RYFckP6S7zdlp+4XrV/MXWgnhpEfE3a+WrGNrd55EYxOE0DapWCqJLVaMpLStmOUJgx
	R2mDRqjlt7HRWbPf/4KxYdlwFTULi1cdqAqKLipjqtZzOTrdyQKcaL/mf0uLie0jSQGz8Q1bNos
	sqToG6W5XTS0B4Z17cRogkrLiAsHXSomfqIvzsYEFo5ynqOJMtvpitDb7O5l6tIXGp8fc112Cq8
	dkHfVlSOVVteivqmbdfH0dT3GIQaBgNnj0HOdRX91xEyfEEMoTu5+zcjxIVUlgoU/y4zaHmEZaZ
	hRLNRKzMp42rztlIHVtBzOrTA1GZhN22DsmXvqy3aXg==
X-Google-Smtp-Source: AGHT+IFtjWsDYHe1VkjVTyT6R7VE9dCGUqdAugEsnIBccOXYANPwe/MI+qzPBv1E36t97qCyCMsGSg==
X-Received: by 2002:a17:902:ef0c:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-25174c1cd4fmr17870245ad.46.1757147883208;
        Sat, 06 Sep 2025 01:38:03 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:6dc9:9ee4:9664:de3c:82ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e480sm116577765ad.130.2025.09.06.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 01:38:02 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v6 0/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magnetic Sensor
Date: Sat, 06 Sep 2025 14:07:55 +0530
Message-Id: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPyu2gC/43OS2oDMQyA4asEr+tiyc/pqvcoofihSQzJTLGDS
 Qlz9zrZdEhh6PIX6JNurFLJVNnb7sYKtVzzPPUwLzsWj346EM+pN0OBWlg0/HJqapCJV5rqXHg
 zn2B4iZqDixZQDDKgZX39q9CYrw/6Y9/7mOtlLt+PSw3u03+gDbjgiXwUaMmMEt8PZ59Pr3E+s
 zva8BdyAjcg7BA5Y9PojE+DfIbkGrIbkOxQcCJhDArw70dqBYHagFSHHASHTmjvSTxDegXhsAH
 pDlllyMoQTQRYQ8uy/ACxJSmX5AEAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757147878; l=4659;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=JraSxymtxrQ7rVKbYQEgzRtR5BKEvUbZ2v8Rl3tGfWM=;
 b=299bzWg6I2Bvykcn6mIeosMNjuMt8zXZ5sa9lv8k3Yj/rrZVKJ0X2V4Qplbma1pp50ETrcfba
 zb593469qpbBwpykFBkmCUMlsVX4bmjUFTghc7QnYkJVsB2Kh1L0PuU
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
Changes in v6:
- Reorder patches as recommended.
- Reword patch subject for dt-bindings patch and discarded "Reviewed by" as it got modified.
- Bifurcate MAINTAINERS file modifications in separate patches as applicable.
- Style and indentations fixes.
- Link to v5: https://lore.kernel.org/r/20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com

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
      dt-bindings: iio: magnetometer: Infineon TLV493D 3D Magnetic sensor
      iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor

 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    |  45 ++
 .../devicetree/bindings/trivial-devices.yaml       |   2 -
 MAINTAINERS                                        |   8 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 531 +++++++++++++++++++++
 6 files changed, 599 insertions(+), 2 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


