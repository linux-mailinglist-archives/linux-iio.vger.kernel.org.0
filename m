Return-Path: <linux-iio+bounces-7870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF493B9CC
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 02:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECE01C2171E
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 00:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1A4687;
	Thu, 25 Jul 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsvnNWj3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8726FC6;
	Thu, 25 Jul 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867254; cv=none; b=fcXwo7BSVT/9dfYN7gXVz/KI0F5Gn7NvMj6AioVdgVuqkb/JCYluNJZdi6fNAwY4z6KBYG1TNYwBQg2Ava+GZEweO7ds43f8Dhx8BZklWhbIB7YEJi6Sy+EFyYySyAK2KHpZ0KZXkIalULOZRZ5nl4U3fFK8diqzLvzlVUcarn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867254; c=relaxed/simple;
	bh=T9DLii8v4aOaUBaU7hCbTIYyBZYb9oXvlzIku2iOGBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMj181Rk1YaaPtnSRZ/OmVfGX2R4Gth/EYpAI/wyGyqUa6S6iW3V83sCbcSE1MN687x+pbdBD8IaFb3nhO8fzZlWvH5v0GWFnHHLqbiGC3HGMVm7Q23Mn+G2rzv3lmMhxwioW7ldqSqCm9q/lDQKZofpUbdvU3f5mACmv8WGusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsvnNWj3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266fd39527so2509835e9.1;
        Wed, 24 Jul 2024 17:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721867251; x=1722472051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKRmX5Q90wGaZsCyydkQv8Fblb74XnzTuhdZqPGvWi4=;
        b=VsvnNWj3RVI2JYjVQTHmMK24PX2sa2LkhqDh5uYkcPhVLb4wtti+JrRWDSuRi2newp
         aLavrzekxCLFZb2VAF4ADW4OvCfkKBcesSnRnEfMHLjoOjB0rgL9TadotjQ/NCRYtl/Q
         L5VoS8EQx28eODOIaUDIuGIv+Ij3vUt6i4peXvFdqB44dJ9ituQi7ou/W6WpoWwjYhTn
         QJhwDQVfWgNt7q9xbtaIR+WmMGS98VZm9jEizfjL8wx56hm3BuecHClgs21+Nhh2vhhQ
         1laZnXKQ5x/Cu5xK7f5fMbGSf3aOAtspNSmlyxlJExAorDfnCMPX+sSvSvHTeYsfok0I
         gWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721867251; x=1722472051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKRmX5Q90wGaZsCyydkQv8Fblb74XnzTuhdZqPGvWi4=;
        b=gKwo5DwPn7TDQ7VcM1jh3G08eo+zp57fnFNlGg8w+AhyS9XyK+RmuRj0KTVj7wAS+g
         b+0byOHQmX3KUiqtj2ZsRcvsk8/sn0emvwNuWbYw8rDZoZrLLRHP0jzIIy29Srg7QYH8
         Hjugh2/KKfCsXAPCFy5sryOVhYy0gD48QesDTZj2QJ0oIQ0oe9OLutKiqwfcTflEY647
         DEJ6tJEiQCW4Idj8gnmQsBmB4lXdORnkDYovPK1GvlzgrpO2pPNa+2kbyQNgl0AXLQep
         b0xIK7/YJ/FtUuzV6drfIRkurZRJqI9wQAD9jlsOssi+TVWu/Zd5jg+83lL/veXYHrDg
         RgtA==
X-Forwarded-Encrypted: i=1; AJvYcCXql6+yLi7EQLG8rq+PFlzzo6LgWV9XY/OrQQnsBBNnb6eHV9MMAZ48VsL+I1OVX2W+urFfGWcQoppcXOhXBdVTkqLBgVw4/faCTh2A9JAHj9pmigPSLebmzcT22i9yv1QlyTT8/0Zw
X-Gm-Message-State: AOJu0YzvR2bU9+23G5t1LMyWpiKKkVZLeFggrCWS0l7z7//1YnXJTMBG
	gZHOtuS0IRVVBemukWmydjNniXGUi9rQBn+MBpzjMjuQoE/dKCcA17LMDUX3
X-Google-Smtp-Source: AGHT+IEbH/V1J78wj0w4t7L0lsKvXZ34C8HDFZriiGxjfoioTMkjpZ1CzV/4JpdHFJIkfjsjQvJ+rQ==
X-Received: by 2002:a05:600c:154f:b0:426:5b3a:96c with SMTP id 5b1f17b1804b1-4280573c824mr3302895e9.28.1721867251063;
        Wed, 24 Jul 2024 17:27:31 -0700 (PDT)
Received: from localhost.localdomain ([151.49.92.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b0e8sm8233605e9.26.2024.07.24.17.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:27:30 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH 2/2] iio: bmi323: suspend and resume triggering on relevant pm operations
Date: Thu, 25 Jul 2024 02:26:41 +0200
Message-ID: <20240725002641.191509-3-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725002641.191509-1-benato.denis96@gmail.com>
References: <20240725002641.191509-1-benato.denis96@gmail.com>
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
 drivers/iio/imu/bmi323/bmi323_core.c | 29 ++++++++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
 drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
 4 files changed, 32 insertions(+)

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
index d708d1fe3e42..b318544957de 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2121,6 +2121,35 @@ int bmi323_core_probe(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
+#if defined(CONFIG_PM)
+static int bmi323_core_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	int ret = iio_device_suspend_triggering(indio_dev);
+
+	return ret;
+}
+
+static int bmi323_core_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	int ret = iio_device_resume_triggering(indio_dev);
+
+	return ret;
+}
+
+#endif
+
+const struct dev_pm_ops bmi323_core_pm_ops = {
+#if defined(CONFIG_PM)
+	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
+			   bmi323_core_runtime_resume, NULL)
+#endif
+};
+EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
+
 MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
 MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 52140bf05765..79c9b029a209 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
 static struct i2c_driver bmi323_i2c_driver = {
 	.driver = {
 		.name = "bmi323",
+		.pm = &bmi323_core_pm_ops,
 		.of_match_table = bmi323_of_i2c_match,
 		.acpi_match_table = bmi323_acpi_match,
 	},
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
index 7b1e8127d0dd..ec3238d93862 100644
--- a/drivers/iio/imu/bmi323/bmi323_spi.c
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
 static struct spi_driver bmi323_spi_driver = {
 	.driver = {
 		.name = "bmi323",
+		.pm = &bmi323_core_pm_ops,
 		.of_match_table = bmi323_of_spi_match,
 	},
 	.probe = bmi323_spi_probe,
-- 
2.45.2


