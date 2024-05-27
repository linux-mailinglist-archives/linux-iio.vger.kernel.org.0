Return-Path: <linux-iio+bounces-5329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A78D04EE
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917D51C21716
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D017333B;
	Mon, 27 May 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzh25/BI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F61172BCB;
	Mon, 27 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819989; cv=none; b=proyMpDWT1jtWkg6f6RHE7+a+6dWaHBD6VZJJnf/3fFxBQQdhHOfTb/YcSJQ9mpQxZN2IWTKe+0fXaBVpdFClv3+zJK2VIoNqGdb6juZf+E0wfHEHz8LGUGLWQuhMVx2LYAU/WIz2AI9XFgAgeVJ2VI/WA8lzdn3kHBb3gVRLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819989; c=relaxed/simple;
	bh=ZlwyzcB9bhnoWgMAnmPiA5mWO6l8sdiIHNU8T7/gj/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sl8mUQpwp9VYoaGNsPdpNKQMBERu6W1VdF1R1Mf6kgr45QfzEgAGOMepFMRzqLC3M1H5QbEaM4fVqgPJMoSU+ntMg3qgBqdnQTJ7HGBMPWqaHFoUuj93m1TU3mFQkgTBHe4fZrnHIdLYSrajuGP+rFuxoIY90QzlyvZDwUuGehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzh25/BI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420180b5898so79655055e9.2;
        Mon, 27 May 2024 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819986; x=1717424786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKBL1jiOA3aAvx3p5BJnVQjWdh8f3DgBew9fnCKqXL8=;
        b=Vzh25/BIFyn2lZ4PXuVm/zGT5wccjVl/510w/p4KHdcacMogpXqXfZRoFW2DolFIph
         9GpxvidDufdyalUBACbSc7vK6JGIwLoIjBgSg0vDtZs/X1q8rzD2t2cmkGZJ6QaEP1j7
         9HjstpuR6E7RrwJ0FP4lXNvMnSqJkYN+nXatfwN+FOEeKjbiqbA0R/jpQUhLVxa90gc9
         do8M+R3Ry/Kd27S8DQa9Ood4ejUmo3KGeHAWSYFHayHMfBHKePXzXUBRtl5tW07WGE3f
         WxfhLaOiMkFPqd3pDrut/upSrQ22jGlc9d2EnNl9swarTaNFZez3Eu4NFBKcNIHwwfth
         QKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819986; x=1717424786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKBL1jiOA3aAvx3p5BJnVQjWdh8f3DgBew9fnCKqXL8=;
        b=SSgIurd+OenVC7xMo44fg4Kawf8K/UG0SliN44sSbCdB/FQGIXnVdb2MUMbhGlRrhe
         zSRv552rgtHVjobQL89AV07MRuhMPNtZ0SlcZ1GQ7IbguT3D7oHgrVMrsSodjtCuxIdr
         7V7oylq5jKN6mpgVs4x8LGSb6aaPzwt5Dx0jmHofhdlUSTVQXuSF9f5hI9NpLSL+Q1j+
         30GWNOMMlWkJKU9kaZZ16wYXDc3/WnR2bmF8kyEOzEfk+gdEowyLcT4kzzcoQ/gRdQDu
         TLfn2ggiaiNND0dWevlBatfT7F8nEDMaD8dqpLZfVzSef855yPnqABwM0ymPrfTmyTdI
         S+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe3DnOHr6P3ltIEPqpUDwNn82PtYBnGp4WMKc5G+DIteR1X2u7OcnZCS96EqRtrhw/5qY6qvHPPDUaei34MtcRg/gcJmZ0hkR5XyxqPyCSGowfJA4I+EwJg3LRIJR2T6cZA7XMAQ==
X-Gm-Message-State: AOJu0YxVoIkHmnmvT+4KWgw0HERjZz8nG7vP6gtAGl+R8mdZHOD1Abin
	xqYVvmuWN5EertRF9X+CdPhM5VSGVv9NQQusLXbUTLXEULIuqXMp/5G+G56lZcg=
X-Google-Smtp-Source: AGHT+IEguuVdebVfpck8C35Hn8CwCqD7T4/qy4SYJbXVJ9FF85rfzfzNGZmNXwhlBeK/Oe1Yi37TYg==
X-Received: by 2002:a7b:cb19:0:b0:418:6138:6777 with SMTP id 5b1f17b1804b1-42108a00005mr84052045e9.31.1716819985959;
        Mon, 27 May 2024 07:26:25 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:25 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v5 2/9] drivers: iio: imu: Add support for ADIS16501
Date: Mon, 27 May 2024 17:26:11 +0300
Message-Id: <20240527142618.275897-3-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ADIS16501 device in already existing ADIS16475
driver.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 drivers/iio/imu/Kconfig     |  4 ++--
 drivers/iio/imu/adis16475.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff3250..782fb80e44c2 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -36,8 +36,8 @@ config ADIS16475
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16470, ADIS16475,
-	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507 inertial
-	  sensors.
+	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16501, ADIS16505,
+	  ADIS16507 inertial sensors.

 	  To compile this driver as a module, choose M here: the module will be
 	  called adis16475.
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..53872b716f4a 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -661,6 +661,7 @@ enum adis16475_variant {
 	ADIS16467_2,
 	ADIS16467_3,
 	ADIS16500,
+	ADIS16501,
 	ADIS16505_1,
 	ADIS16505_2,
 	ADIS16505_3,
@@ -980,6 +981,25 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
 	},
+	[ADIS16501] = {
+		.name = "adis16501",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 125,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
+		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
 		.num_channels = ARRAY_SIZE(adis16477_channels),
@@ -1482,6 +1502,8 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16467_3] },
 	{ .compatible = "adi,adis16500",
 		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16501",
+		.data = &adis16475_chip_info[ADIS16501] },
 	{ .compatible = "adi,adis16505-1",
 		.data = &adis16475_chip_info[ADIS16505_1] },
 	{ .compatible = "adi,adis16505-2",
@@ -1513,6 +1535,7 @@ static const struct spi_device_id adis16475_ids[] = {
 	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
 	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
 	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
+	{ "adis16501", (kernel_ulong_t)&adis16475_chip_info[ADIS16501] },
 	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
 	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
 	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
--
2.34.1


