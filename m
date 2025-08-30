Return-Path: <linux-iio+bounces-23489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B90B3CEB5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A20174E1284
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5002D8381;
	Sat, 30 Aug 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWn8JVLM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63C242D7B;
	Sat, 30 Aug 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579394; cv=none; b=fEaMzI6uMYeSq7L1ZldgToKG/wTS7Z7SXk4olbjq2hZPmYmTJat9qHSy14XC7FIhc3L9nrYErmZjxix36GuOQfbdhMhKrCI2RdWw/9WfJVkooSQcLhGMXG1NuGLaROYr0404opF1p8uPhGo9Geqdt6GcP0F5PAhfp/wjz72qiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579394; c=relaxed/simple;
	bh=NuigVOEZ/cYqOt8OMOvaJK9qIh6+nyF9VkvmUAda2Ew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJlMR+Cjyg8tRBBY0T6pqtV4Tj5M4Vfpt2j5HhTmDcFJdGuKrj01rXngWbhK9aySt6mVGp4r+NTFcCAipviRPjYCeF9+f4vKBqiHRiN2e88LRUUXKON36tkqGSz8ncKraedCOJtknjMbmryEMM6NyuEbgBJgU6lbYL2tQpRHhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWn8JVLM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-249406d5878so6331845ad.0;
        Sat, 30 Aug 2025 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579392; x=1757184192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYREeVlOdDs9rQ2KO1/3o8IfJt1R8n4X9aqIPV4hwak=;
        b=EWn8JVLMGqrFOod/+O6+xTnaulm/HsK3MSRN6BCZJhc5BgCu5fbi8CVNKUCDZoQFam
         DJLRYNus6I8elq+03ToW3RgG1zqyr3Ol361T0vxG15uUzoj9OKMWmjQRCJlNPPA2APAz
         f3gO7yVB5xZ2/P71M5veSQ/25u3onCqO60oUxvLTrrjAWYy85yl5IBR3sHFagIfMQybl
         /LWKVS63AOnh/yjM5SloSHH5p4ltzLm6LA9NruK3qqjNYHtgMj31GfSYHdUvLW+kDx8y
         d1pwC0QcF6jjQeBqMuSyj96pInR/P+PdDiLMCBaXtepUG/YBv9ypSbkvQCXydDltVGn7
         xvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579392; x=1757184192;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYREeVlOdDs9rQ2KO1/3o8IfJt1R8n4X9aqIPV4hwak=;
        b=n52R3vyEhZTcBBH1i7bRqXgbpQOFvP5nhuuMK6+ppTH/Q5NwixoGXft7WpLu0wb7GS
         1xXIGRZlzq70/Cjau86tW3K4p0ielFoONw/yw9PdcTYPezF9+gnXjBZSdW5xC7j5UdgV
         +drxTxJPWjJOOGh6dVq9PLSsPG184BuTIHdOlV9LwnSqNrw/Z7wvFu1YV83C4Tc/C0hr
         ncsoNLGfTimITCT49WqVUpeNkjscqSAnhN9xd4MK4vpIMOz+yuv2WcTGe/UJqX57irrD
         oG7JC+JCfgMXtotnEoO4SffFuK/+fHdRTdq9hVce3YjODMzIsaV8OIGrx7V++8uTDq7V
         r7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUazn+WAlrpDg78uHQehgT4ehcnibQBBF1n4l8OnC7w/90Jj6EEo0yVA9/UrQZUQO0R+lcJ+uEBmTHFfBO0@vger.kernel.org, AJvYcCXKUbEVc9wJPNwh0w+RmKI1ZtR1ZiwPc9Es2UnkEoWFvtbbveRjjIzJ7jJvrAh2B4mCHcI0PDPsvOpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmyXs0O/I6sagPAyyhYyHxoPxxIw0jmT6V4kWusUmWT8MkEZf
	WBw7eQ7W0QPTfsTYgmMWpTMe72ClDzwx4uzza+mtCUqOgec/zeJWjTuvozyz03+/
X-Gm-Gg: ASbGnct6fm0shvi0UCizJPvY70FxDDEw8B67nIebbwhxG36RJbslidvidoeFwjWhrPm
	p3YttNHSTMp8JawF/HGE4jXtlBvlaF42BaT5MJ7dGxirN+4r3Oo0zEuDOVeMbF+t/iKfu3tKOgq
	JzDrI18mn7OTi5VA6TBaqQI91/t0itz7LZ1ezAjZ9ikiZDxt0Dg1MxpbxifPnALiO+xlmErZkWO
	nOPncSOGrOEDMDDuinBkdStXgtfiWNfLirlYsw4saXlJeU7ooCPjSBGGghp6v6LDusXejz/p+dC
	WiA26+fNWacqHrQFCpOtrCibUuVuFXXLnTZnBojeiDHJk4zZANMfiJ+ghAdy0srQ1ED4y3vWxZK
	c6btH5FKx4C8xOdv9lIK59NUmhKbHVyslTrVwYr6MgN/ibRWSteu+51JSBAk=
X-Google-Smtp-Source: AGHT+IHT4nSra45cYGgNoSfIe6PhXzKr9iGUKs+Jrx6ss6kBH7JdX9bqMR4ggGI0HK1hOye7ql4ZGw==
X-Received: by 2002:a17:902:f642:b0:240:11ba:3842 with SMTP id d9443c01a7336-24944a9a70emr37334285ad.35.1756579391915;
        Sat, 30 Aug 2025 11:43:11 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:11 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Subject: [PATCH 0/5] iio: imu: New driver for InvenSense ICM-20948 9-Axis
 sensor
Date: Sun, 31 Aug 2025 00:12:44 +0530
Message-Id: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRGs2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3czkXCMDSxMLXQPztORkE2OjRBNTCyWg8oKi1LTMCrBR0bG1tQB
 0jghIWgAAAA==
X-Change-ID: 20250825-icm20948-07fcc432a458
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org, 
 linux-kernel-mentees@lists.linux.dev, 
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=1612;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=NuigVOEZ/cYqOt8OMOvaJK9qIh6+nyF9VkvmUAda2Ew=;
 b=ysbnyq7dGiZI9VE+RUh68FNyPZxL3DBVSpDPI+ewUk7bIYyc71WGdZJvCMF8IN0D4BnO3JYZB
 W+FvLF+g6KVA1fu9NhT2nSTOD5kR+pDGR1Xv+Vijq3UPLM03O2nwnU7
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

This series adds a driver for the InvenSense ICM-20948 9-axis IMU.

The IMU includes a gyrometer, accelerometer, magnetometer, and a
temperature sensor.

For now, this series only adds support for the gyrometer and temperature
sensor, and doesn't yet support the FIFO features.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
Bharadwaj Raju (5):
      dt-bindings: iio: imu: Add ICM-20948
      iio: imu: add inv_icm20948
      iio: imu: icm20948: add support for gyroscope
      MAINTAINERS: add entry for inv_icm20948 driver
      iio: imu: icm20948: add runtime power management support

 .../bindings/iio/imu/invensense,icm20948.yaml      |  36 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/inv_icm20948/Kconfig               |  17 +
 drivers/iio/imu/inv_icm20948/Makefile              |  10 +
 drivers/iio/imu/inv_icm20948/inv_icm20948.h        |  92 ++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_core.c   | 128 ++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c   | 355 +++++++++++++++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c    |  48 +++
 drivers/iio/imu/inv_icm20948/inv_icm20948_power.c  |  73 +++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c   | 115 +++++++
 12 files changed, 883 insertions(+)
---
base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
change-id: 20250825-icm20948-07fcc432a458

Best regards,
-- 
Bharadwaj Raju <bharadwaj.raju777@gmail.com>


