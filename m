Return-Path: <linux-iio+bounces-7967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C893DF52
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42876B21D48
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98681720;
	Sat, 27 Jul 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8gBJkfv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0688062A;
	Sat, 27 Jul 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083463; cv=none; b=QJH1Agjw1fT2ENrbYYTkbHyBDcqiw+EX6nWwO9CsHr+IJnqDlN0zsg+7BZqfrY9YD1nAqeivVd/YGGW4PPbuxxfJe5hRRHlFMpVntM6S2XSa1w6xePe6mg9B1SgmkAnTv6AuZ5ybFj1yWDdbyyv1b8T3u8aND7oFoh291HNo/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083463; c=relaxed/simple;
	bh=yLUM8AXqlF1x4Tyxs2XWbhqMlveOggFhgxkLX0meD+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMx2pH8vv88Eg4MeeYPIG2aquINfwwMLQzVJYrVP3nF2ySdnrfPC/fjX/BoPMI/vsAPMxUMkkgyq4RVqUfR1D+MDAGMMnZHEOVl5RFUmb9YGqTaSNUmUIQjB92NyB7adCKs9MSTS767tBNjrJAPNWqZLteTLEX2Dz/JRoB/mpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8gBJkfv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so5319085e9.2;
        Sat, 27 Jul 2024 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722083460; x=1722688260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+OBHIG3D8KPMwZH7IuhBbwzoU/QaG9OLelyWCTryvA=;
        b=Q8gBJkfvUkurxS+8xCc7J9l9gUncakxZIAo6TysQwB1Q/IToQaA4yemm1KrDb4/cpx
         1ukRbFaPNzghXzE3CkMEcL0kzNaEWbOhM+PLjVdIWhiJkC3lW9zfcqq/vygJ4yqM9zJ5
         sVzQrS+erMhRfNZ+6/zvLn38kshuWYfTfMwoUH8hakzXjqH6tPcD77obE622QhgXFAxp
         VAuq7ktu2LJzqvWpwsQ/noGY2hlZ3Rm0M5lvuutOquvEC3asQ1AJChOZWR/Rn3yHl7xh
         tdBi1TlgiHbeOYL5tKprbekklCq9m/94Z4/oFlYcTK44u9geB3bZthYhKJlGx41qUAXM
         RbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722083460; x=1722688260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+OBHIG3D8KPMwZH7IuhBbwzoU/QaG9OLelyWCTryvA=;
        b=fFrZLPTziHFsE1ifBH/X/r4mv41FC288Qi5bTdE9YkdNkjHtVBS8jVY5x4lhJzdYjB
         m1hfE+UZQCnBRh/LuCEH3eVpOI60R3Lm2l1sK2eVxH/LNzDRDewdgOfab7ic8UN9rTxW
         JwPH+IMbuQ3impqH/KWG6F1SdlLqVKdFrm7f8HVBvQ4ODgnkKMrSj/NnMp/KlLONplWL
         FlJVM6EwJcjip+VFtyiSDhrPDKzybJtqbE0CuoOO1Dp8gZk84gcAQ5NCBuLWvv/JKIWG
         G8Z0BeB63NrQvIZ1oJBZN54aIJxaDksUYHsXGtmA4Z5yum8JAq6M2J4FO0UcQruREgZ0
         1VKA==
X-Forwarded-Encrypted: i=1; AJvYcCUMSGcZ3fO6SmhD4fq1Oi/KZuF3sbI16JCVw3ceeIsczBx6kdk5LQP3Nwj8WcfeNgKsR76ZFdZX2ZNmt6wz+5K7GE9J5L28Kr3qg/Bfu/6j8ILio6VReeWcihiI+mqI3sSjDUdX0yQr
X-Gm-Message-State: AOJu0Yzbk8ITW4Ty7erE9p+O9ZUnhE3oP6UC6n3ssjqXy2yFeqnyNXa9
	lhycGjIEp8DRfQm0P8Ya93VGMiOEM4t5z/+Jy8Foz6aD/0z6r7IO
X-Google-Smtp-Source: AGHT+IEEI8+Shh3rxg3Mp87iw84iJ065h6GF2sXmUFhxAHfriaFy7KjKI13ONAzzGnir82E7yGV+JA==
X-Received: by 2002:a05:600c:138f:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-42811d8bb34mr20090225e9.10.1722083460544;
        Sat, 27 Jul 2024 05:31:00 -0700 (PDT)
Received: from localhost.localdomain ([176.206.92.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm114913215e9.38.2024.07.27.05.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:31:00 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v2 2/2] iio: bmi323: suspend and resume triggering on relevant pm operations
Date: Sat, 27 Jul 2024 14:30:34 +0200
Message-ID: <20240727123034.5541-3-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727123034.5541-1-benato.denis96@gmail.com>
References: <20240727123034.5541-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent triggers from stop working after the device has entered sleep:
use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323.h      |  1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
 drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
index dff126d41658..209bccb1f335 100644
--- a/drivers/iio/imu/bmi323/bmi323.h
+++ b/drivers/iio/imu/bmi323/bmi323.h
@@ -205,5 +205,6 @@
 struct device;
 int bmi323_core_probe(struct device *dev);
 extern const struct regmap_config bmi323_regmap_config;
+extern const struct dev_pm_ops bmi323_core_pm_ops;
 
 #endif
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index d708d1fe3e42..4b2b211a3e88 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2121,6 +2121,29 @@ int bmi323_core_probe(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
+#if defined(CONFIG_PM)
+static int bmi323_core_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_suspend_triggering(indio_dev);
+}
+
+static int bmi323_core_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_resume_triggering(indio_dev);
+}
+
+#endif
+
+const struct dev_pm_ops bmi323_core_pm_ops = {
+	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
+			   bmi323_core_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
+
 MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
 MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 52140bf05765..057342f4f816 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
 static struct i2c_driver bmi323_i2c_driver = {
 	.driver = {
 		.name = "bmi323",
+		.pm = pm_ptr(&bmi323_core_pm_ops),
 		.of_match_table = bmi323_of_i2c_match,
 		.acpi_match_table = bmi323_acpi_match,
 	},
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
index 7b1e8127d0dd..487d4ee05246 100644
--- a/drivers/iio/imu/bmi323/bmi323_spi.c
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
 static struct spi_driver bmi323_spi_driver = {
 	.driver = {
 		.name = "bmi323",
+		.pm = pm_ptr(&bmi323_core_pm_ops),
 		.of_match_table = bmi323_of_spi_match,
 	},
 	.probe = bmi323_spi_probe,
-- 
2.45.2


