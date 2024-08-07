Return-Path: <linux-iio+bounces-8317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FB94B01E
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79DD284601
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD622143C72;
	Wed,  7 Aug 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvH6apEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD21143891;
	Wed,  7 Aug 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057001; cv=none; b=KtnnD96jG5+uOxWyHv7swKCrDLUuH1rij/bJ4RVdTmmF+wc294SO+nS3kJzNsnMSwfuhxzLDPwpsuluRM7mV+G5drnw0K77qeqH+aY4Sk6eMItL++xO8y6+UB3qRbdSlDmlJVLhW2hzN6dGoFf5o4t7ueTDoiLRcVDtVYgZXP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057001; c=relaxed/simple;
	bh=+F0WyewUnXT3w09NXRtI/LrPLq7JvuykbRUqBvCNccQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpvpVMluDU6x1gO/r+3TgwWP5oc6xE9CbejHymmNKz9hFgOyr7x3cpqReu4E17+51OO87QYltwbsfsP0zz9r7pmBeCOwZ3Az7mWnZ+7XF7BK9V8ql1fmcR3WQQQAnUGT37h65o09FDxodve3Hcn7e6e8TXBKP5zDp0W8e8Eai5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvH6apEM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso134244a12.0;
        Wed, 07 Aug 2024 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723056998; x=1723661798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBRg56Ji8N26DNOeCY4BDLeRmt9MaxXXPicaugfdq7A=;
        b=dvH6apEMR2C7ZofT6GqdmxI9gzNpI7aWm+BEtQA5+f0gQV+0lm9Mii73RzvLP6KicQ
         ybNS1cbIb8WQVr1XcXq6Ec028RvqXjAYoZZtOnvHsi13mLsBP+zVthxVY/QqO94PoKWZ
         CjALbiOGSH8164DhIzXytQ9thWdC1KJIY8ySNqiic3DiGpyhz6T/04bXNc37vIKSIGzH
         CgopRuV2AHUFAA8xlp0Npe4EUYRclU7/IQwcp42OYWBISowcLFrvjGaucPnDP11xRtfF
         25eWHi2xLmTMNbmndCS712T19cWFJ7JNsVS6snQ4ygm2da1N+rja6KVCLe7hfKS8mAug
         b/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056998; x=1723661798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBRg56Ji8N26DNOeCY4BDLeRmt9MaxXXPicaugfdq7A=;
        b=eNVakvlGAPHP0MvOGsGiQVgCN19D91NmjMk2FVcJL52jPUCQOsY51QdLtU9ixEANki
         zDfVncc6uhJVLNeVk7yoveXfwxoB72g6OxB8oqiMK+G7B6w05OAWnWnLxLB1Zu7vxwf3
         /zavSAU/0oppNyo/xk/re7B2HFE5EG5BvXYUAou3iws3hmWHR1+hfjTcPl9YFMcAoi0i
         p3jNwtQAt2AEJE0l38zpn715Z8NMEjT0jASRligEexxFdxwEVFWV0pxPQ2YBLu7fF3iB
         Qdf24T2b06lEBoWmLNwuLxhr+g51288Xe5jBP0sMjyMD0lAcD53Hqd7ZWqv3y5hkv8AX
         R3gg==
X-Forwarded-Encrypted: i=1; AJvYcCWoCw3Qzi2tRTyvgR5e3vTqLHCjPZ+XK/h/P+TcrrM2FDMzrkwKhyULNLZKyhBoe1UNYX0Jl/UHkfK1tvT3vvbJOgfGLV4yMzzq9pqxLNATWOyfy+coLMgBEtd5AFvTa6DMaJWeJ88W
X-Gm-Message-State: AOJu0YzH7HmZ0PnECtr31eI0tPl38t5PV3jjm64DsiAV7w+EX9Zsplmu
	DnIPgb5OCl1LWtHS04oXmuIodpbqqW0jUqnjOuSiP94gZbAwmEYQ
X-Google-Smtp-Source: AGHT+IFJwH9jY0f24gTaNavYSe9oAVD+14UOMj/NbGzr/8u5IBuA0yozlZuC4OJNQJfkfpUkF/WkcQ==
X-Received: by 2002:aa7:df97:0:b0:5a2:ff64:1218 with SMTP id 4fb4d7f45d1cf-5b7f0dd33bdmr13490495a12.0.1723056998020;
        Wed, 07 Aug 2024 11:56:38 -0700 (PDT)
Received: from localhost.localdomain ([151.49.208.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba51da9c41sm5482270a12.36.2024.08.07.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:56:37 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v3 2/2] iio: bmi323: suspend and resume triggering on relevant pm operations
Date: Wed,  7 Aug 2024 20:56:19 +0200
Message-ID: <20240807185619.7261-3-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807185619.7261-1-benato.denis96@gmail.com>
References: <20240807185619.7261-1-benato.denis96@gmail.com>
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
index 3298e027c97e..0ba5d69d8329 100644
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
index 571e1cd7ce72..9de3ade78d71 100644
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
2.46.0


