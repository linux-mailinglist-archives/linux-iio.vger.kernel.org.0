Return-Path: <linux-iio+bounces-4882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0328BFE2B
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C232867BD
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B084FC5;
	Wed,  8 May 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDRZ5ecj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996D84DF0;
	Wed,  8 May 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174005; cv=none; b=bajzhqlDovnGMtSXM/AoYA3jE13vegaGspbj91DdJfv9ZNwd9RkHpLL2SxbDkVnxGbJCBKGacFTfwQ7yBlrQOprEO8MW5OS2hH2GFnuAQ9EnRTGic7Px8dpVMaZCQDNQpIp1kzn9Xs35p4CfU5oFNa3vJiX40W0Cnyh736KU3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174005; c=relaxed/simple;
	bh=4I8E2sBPuO8+nynFN/s6cGSxh8EzM0Wb26q7BbHT1aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAbFe16BbmNxye7t4SDahtwv2YMIXlsQD9ZG1PlsxRZHuSnSxF5yVfyiUUHFA8zCiaRj4drX0eH5NXc2z5vBBOdNbqkPS1a+4aFA/sWvaoPVcFeJvOdhcjpWq+eEwNPUaToefMn2dGBM8HzBMBzTuyaOVqmNL/j4/42eEzF8yMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDRZ5ecj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41dc9f98e8dso4635665e9.1;
        Wed, 08 May 2024 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174002; x=1715778802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/My0wz9H5POJSB8HyilobjLOC1JutD1Zpu8a0jdhGtk=;
        b=HDRZ5ecjAnBq44wgyMfUfS97Vx2/rVJOKuoZSKCZVx1ssSNvisnrNQlZGb1JzcbNiG
         5Tyj6X0Q4yUdcVDkpPjxKhON0+/X/ds3EIkgN4fpCXiMJ19cstIpf7vlV31SpD7Af5rL
         aDyTx2uDs8KQ7CA8cM+MmfG/VkvMN7GAF02/92o9ym/ywl3jyHiT57sOdMLRzRVPOA9k
         4IL+oVZxQfqP7PfLGasN5SenrTnYCjPtIxLsrETnO1iErj1pCQcm95U4nXx4FwLruyYt
         yJOgcOn/Qvnx4SW0eQW+O8aMQQ/BuqN0jWwZu7+zMTDZqB/nvSXFct3fVWv7PBapLtOQ
         E7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174002; x=1715778802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/My0wz9H5POJSB8HyilobjLOC1JutD1Zpu8a0jdhGtk=;
        b=Q5zyNhXstupkx8uFEYpk3lRoqKhOYbZDH+xSOScweQcLOWbWyw+Uoj2ijdfg/2TH0g
         6UApBpkZ1Wdtw9QYXz/7xEPaYDW8GJzjJ5n4JdfFKowCsYbe4/qWsGVJPV/Dnua+g4z2
         yhQ9YYVYEjNCECYeAsvGpLJwfqROVofhBs5hwNU+JipHgscJ1xVTWaCiVE3RdOz+J4ez
         9ieYHaKOIKF6xFBEkEj5SLMnVGNchMpSrlsE7dwYRRk345ypFsuLQOFCZXhHuVVfsZo+
         //ihfYAWBVXRknn3oWykSBGOMAW137FBzV2Icj7eRQuYTQqGqZSwKUMHcJD17FCk7yhA
         Ngnw==
X-Forwarded-Encrypted: i=1; AJvYcCVYolf/tQC9He/cJt6lAfuSZklKvB4qgqOnpbtTIJTVeg0cKUMK+rz6KxcFAI/fkd35d+3VvsySIVU3YMW96DH+hqmyc3nzjLVqu0e+ukSa2H6pUfGTvFTCI4U0xkM/UjdcmziLtw==
X-Gm-Message-State: AOJu0YzAmpXYU1J+wl9cS43R0iGctiYdtVbHU1tXtw3S5LxQO1fnUmsJ
	qasBj413CyiBxJIcrSUxHmaBsSBJVpijOlTTaeAqbusMOc/D6RdCmExWNcnPqQs=
X-Google-Smtp-Source: AGHT+IEyKIITlVSuSSC5TT5Fv3rl3EopUEisIa5QqhBkcRFAqXSSkRKJUl41UeLn6bb7pnXN4MP2QA==
X-Received: by 2002:a05:600c:3c90:b0:418:c6a:1765 with SMTP id 5b1f17b1804b1-41f2da2d398mr49709785e9.16.1715174002376;
        Wed, 08 May 2024 06:13:22 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:21 -0700 (PDT)
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
Subject: [PATCH v2 7/8] dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
Date: Wed,  8 May 2024 16:13:09 +0300
Message-Id: <20240508131310.880479-8-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS1657X family devices compatibles and specify the according
maximum SPI baudrate.
Similarly to other ADIS1650X devices, ADIS1657X supports sync-mode
values [0,2].
Each newly added device has a different angular velocity/linear
acceleration/ delta velocity scale combination, as follows:
Accel dynamic range sensitivity:
- 262144000 LSB/g: ADIS16575
- 52428800 LSB/g: ADIS16576, ADIS16577
Gyro dynamic range sensitivity:
- 2621440 LSB/deg/sec: ADIS1575-2, ADIS1576-2, ADIS1577-2
- 655360 LSB/deg/sec: ADIS1575-3, ADIS1576-3, ADIS1577-3
Delta velocity sensitivity:
- 2^15/100 LSB/m/sec: ADIS16575
- 2^15/125 LSB/m/sec: ADIS16576
- 2^15/400 LSB/m/sec: ADIS16577
Each ADIS1657X device supports FIFO usage and a sample-rate of 4.1KHz,
meanwhile the already existing devices do not support FIFO usage and
have a maximum sample-rate of 2.1KHz.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - updated commit message stating the differences between the new added devices
 and existing ones supported by this driver
 .../bindings/iio/imu/adi,adis16475.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index db52e7063116..9d185f7bfdcb 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -37,6 +37,12 @@ properties:
       - adi,adis16507-1
       - adi,adis16507-2
       - adi,adis16507-3
+      - adi,adis16575-2
+      - adi,adis16575-3
+      - adi,adis16576-2
+      - adi,adis16576-3
+      - adi,adis16577-2
+      - adi,adis16577-3

   reg:
     maxItems: 1
@@ -98,6 +104,12 @@ allOf:
               - adi,adis16507-1
               - adi,adis16507-2
               - adi,adis16507-3
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3

     then:
       properties:
@@ -114,6 +126,23 @@ allOf:
       dependencies:
         adi,sync-mode: [ clocks ]

+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3
+
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 15000000
+
 unevaluatedProperties: false

 examples:
--
2.34.1


