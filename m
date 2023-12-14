Return-Path: <linux-iio+bounces-924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E0813315
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DE6B21542
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8F59E50;
	Thu, 14 Dec 2023 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv3UEZ7b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48A9C
	for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 06:29:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d069b1d127so48990945ad.0
        for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702564139; x=1703168939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkRidhTbj9PN2WMK244LM2MKDK+U9KtTG9k+99K5HCo=;
        b=fv3UEZ7bsEaodLAJxJKNW7ff1oxqYhKh5XvR3PCH614fTZP6Y6o0TOjOjLAtZAexNf
         KoMEt/AhHorWx7oyz302TkHMNY04XcuWVqLG2UiKqmbluWfgGvSCNAksHafxA2Gu95xQ
         GmWBJiV/aFJnswx3s2F3qArdP6Ehuo209Opwqna6j4EF+h1VXh2fkLE3QcL946SrFjrI
         Fx6+FFYhEdpfrcRBoHxVFKBkPvoL7bVRkg8DZdU31LZ0dNLE1a6hc9baRZ88g12K1DBj
         GvxbUhgK6j++xloBVwD7XgZxdljIii47TSUxm5L8fc/VmhtavS7jEwj5r/u71ntlW89Y
         Bocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564139; x=1703168939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkRidhTbj9PN2WMK244LM2MKDK+U9KtTG9k+99K5HCo=;
        b=QhYFB7bMnO9ti72g9CwpT+NMF8YXdlxrYo1WWaetwKGsoVuY+dlYobPaC8p/H0+ZIY
         tThaKRX6pzM3hykLeDDYWPHfTRbCeEd75+kEu2R0IwNx4JxHfY9zxhWcLcerCcu5AqIX
         qimVVnklzXtHRGYts8Jkd8b84uIclpMeLj8dJbmYoKpgnIT2kh0Oedune0kbfuM9wXR3
         rkp/BJQ80uyUjZ6rVwI3FZbVKwMscYqwDaxCzinAgZM/1JxidqP5k0rDlRLpOyX8EORc
         ZuAAYz8I5nLlTy7pBaMXa8HEd4jwn8hyxzkHYEOyXIjOzB4WrYtaDDG5WgT40FsjQFCY
         1ZWA==
X-Gm-Message-State: AOJu0YzjUQ20cSlQ1f0y8AqAbj5lxhFoRs9DVxazxPHDum/6ByEVuMkd
	plrs7EbEoqY2NLh34Dm4tmyuxoT5jkItnkk4OgrLfaNp
X-Google-Smtp-Source: AGHT+IGhFYGgaWQRA+cg8bglRhDhZlKf4HOlZ/sddlYpI+Kb0s6I1O69WyFD9RxfBoelvDpsW9Jt8g==
X-Received: by 2002:a17:902:650b:b0:1d3:7643:b95a with SMTP id b11-20020a170902650b00b001d37643b95amr246320plk.64.1702564139421;
        Thu, 14 Dec 2023 06:28:59 -0800 (PST)
Received: from arch.localdomain ([152.69.227.198])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001d37bdc4934sm46339plo.110.2023.12.14.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:28:58 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Jonathan.Cameron@huawei.com
Cc: lars@metafoo.de,
	Qing-wu.Li@leica-geosystems.com.cn,
	linux-iio@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH] iio: accel: bmi088: update comments and Kconfig
Date: Thu, 14 Dec 2023 22:27:33 +0800
Message-ID: <20231214142733.85910-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update the comments and Kconfig file with more descriptive and
accurate information about newly added device: BMI085, BMI090L.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/accel/Kconfig             | 7 ++++---
 drivers/iio/accel/bmi088-accel-core.c | 2 ++
 drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index f113dae59048..91adcac875a4 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -260,10 +260,11 @@ config BMI088_ACCEL
 	select REGMAP
 	select BMI088_ACCEL_SPI
 	help
-	  Say yes here to build support for the Bosch BMI088 accelerometer.
+	  Say yes here to build support for the following Bosch accelerometers:
+	  BMI088, BMI085, BMI090L. Note that all of these are combo module that
+	  include both accelerometer and gyroscope.
 
-	  This is a combo module with both accelerometer and gyroscope. This
-	  driver only implements the accelerometer part, which has its own
+	  This driver only implements the accelerometer part, which has its own
 	  address and register map. BMG160 provides the gyroscope driver.
 
 config BMI088_ACCEL_SPI
diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 84edcc78d796..4d989708e6c3 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -2,6 +2,8 @@
 /*
  * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
  *  - BMI088
+ *  - BMI085
+ *  - BMI090L
  *
  * Copyright (c) 2018-2021, Topic Embedded Products
  */
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index ee540edd8412..7b419a7b2478 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -2,6 +2,8 @@
 /*
  * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
  *  - BMI088
+ *  - BMI085
+ *  - BMI090L
  *
  * Copyright (c) 2018-2020, Topic Embedded Products
  */
-- 
2.43.0


