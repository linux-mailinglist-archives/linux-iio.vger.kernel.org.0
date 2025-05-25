Return-Path: <linux-iio+bounces-19902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A1AC352A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B311895286
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B561F5838;
	Sun, 25 May 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0DIrWDz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4911F4722;
	Sun, 25 May 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183154; cv=none; b=u7852LbI0emL86un5KjJNde6Vez3tYU5wrt8xo0II4nQmccr72Cuvh8/eufLqP5hM9yZ1xjazOyJ5R50fZT4geaKSc/s2wEJryw2j8HgukNIi02tM1ToJp7pJi8GDDyiOfhcaQBaLA0IQRyfGNTToH2848MS4RMlqb/rP3ogoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183154; c=relaxed/simple;
	bh=aHnD4aYlWpzvqcHp6TuRN269gQbJ95C1TbZL/nGwa4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITaD6/phIKKz00Uuati/13fQr7zY/EI+u17LpgQwPDJQj6e4V9B1vu7gXquH7G88k6e10dGZtDZ+J+r5JMFV95nKhRbOrGImFYO1OzvM4xIc2lEia0mrHNMYJYcjXN1zWyeksBiF9qPr4Zwabc5VSmA7FEsAsp9EKpTtrsYxEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0DIrWDz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a375d758a0so1277153f8f.0;
        Sun, 25 May 2025 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748183150; x=1748787950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C81VlGyDHS+D2C2SAJvj/0wedl3Km6XndAvDij5f9pw=;
        b=c0DIrWDz+9p/pnp0apGOqUKfDjOu7LZ70NbFZ3hbKK2khpt+CRtz9HBUrrlBEOvFwj
         DT8mx+EEVU5gOvQoKLeYy+43l2UN6K6ddGpID++whnlgz4uMeRtoSMzRXnXQmGI+O9Rc
         00xCNgzL9eK5545TsW51lWWw1NUXqcv2qfFi40AXob8UKG6ZCfn6W0djmvCpajR66Xo7
         3G2CPmk5CmSXmV03EX2QPAAKnd1WR6IfDXBOf61mUBPy6v7Ij1k1EqNgoKS68SFVCk7Z
         q29flpQgtgBup7N0kLLbQhXA1SQfL2cG19V9/Qomn1278Sb2BYJ8ao7DlMvq3jkD0ryS
         mutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748183150; x=1748787950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C81VlGyDHS+D2C2SAJvj/0wedl3Km6XndAvDij5f9pw=;
        b=SFMpL2d7Oi9Y4e2ftkhW12+fERrfi62bR/m7/PU1OiUKnEowcfSH9FvA0TLVOAj5ZD
         8BnJx8nAa0IeGM9q3n/CJa2cz8zzxdaRBqr7jL2G7lCBZ2/3wsSCSdmO/w+HSBHkHPKF
         bAgS4CiKNoPDNK3Lrxgt3bdu0Tctm1NbounlszVLj8FP/IoZbCwZ6lcbnSJMDH/1AQyH
         nyYpAwiyYP/lMsbtMDEk8i7bQTUjebnOVSFHS5FkOkOfg/gdAaY1ssFHzz8vrWnyXy6w
         qX5Zkw+Ih3ZuSlG7njzSScr2fYVXYocARmg0GgBs0ASRcjP+hFeIXy+pu8xehBAC3vVz
         8A+w==
X-Forwarded-Encrypted: i=1; AJvYcCVWKAIsu+Z3uvB436RoLneqw3c+OGzDS1SS1jXj3YBrOmaEDyrI8MMIaWcIjMGq9ApM7J88d/jyIME=@vger.kernel.org, AJvYcCX1FxR2otp2281t3oufk5+cVH364C8Hbma63S3ILCVNNEnQSgoShujAX6XoORAZ3u8HK0ovg7AYh2K3Un0L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PQ5JCfAb/Qp57BuPka8jqmy29YBWxnjTUw9vVoADJ7bLs/f1
	ejill99jKnf8PioP+LDCFvdX/TApIUZw7zWoSv/mp/dSgIi8yGP1TTm+
X-Gm-Gg: ASbGnctomryG23Dbso8UQcrL3d+p0zae7OjTkN1PZ2UBt+HyEJg/jAV3qlnVJgQ8qW/
	hvw727k1sAttqBcad5QSfIxqq+AVLxh/ZhHu2HchDTVDMpOvkzVtN9NpRllpTG12vKehSoaiOLW
	2dagc6Pu7/mrx4UbsQa3ImQKxrmgA2ShL2/NUr12P1kjqAgWPQU2aXHWDB+2LG9l9QIMs+tX0Na
	Rggdo0IIAFKsIxRjqLnjKHgNXxE88bHaSmVOxU5RCZ4lyfqb1Pr3GSO2b4AqHwEG2/R43zfmUPw
	OZh2bBTxBNMr3BN+mNTAYSrOsOJY07RXwSy+Jit/6bLEL6zGbEr6ZaIOn3sw41bzq3ui38WNVRX
	GbJAaTw==
X-Google-Smtp-Source: AGHT+IHrdt3IaDS7d4JUb3WHmLgchmHyrCYAoYt8a3L4Z0rVzB6dfmR5yDhn4tsQM1WFGEeFFbP7Vg==
X-Received: by 2002:a05:6000:2905:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3a4d6eda647mr1223063f8f.33.1748183150476;
        Sun, 25 May 2025 07:25:50 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb8c92d9sm216428135e9.2.2025.05.25.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:25:50 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v2 2/2] iio: bmi160: suspend and resume triggering on relevant pm operations
Date: Sun, 25 May 2025 16:25:30 +0200
Message-ID: <20250525142530.71955-3-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525142530.71955-1-benato.denis96@gmail.com>
References: <20250525142530.71955-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent triggers from stop working after the device has entered sleep:
use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 19 +++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  2 ++
 drivers/iio/imu/bmi160/bmi160_spi.c  |  2 ++
 4 files changed, 25 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 32c2ea2d7112..ffbe8205e703 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -28,4 +28,6 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable);
 
 int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type);
 
+extern const struct dev_pm_ops bmi160_core_pm_ops;
+
 #endif  /* BMI160_H_ */
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 0423ef6f9571..9aa54b95b89f 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -890,6 +890,25 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_NS_GPL(bmi160_core_probe, "IIO_BMI160");
 
+static int bmi160_core_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_suspend_triggering(indio_dev);
+}
+
+static int bmi160_core_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_resume_triggering(indio_dev);
+}
+
+const struct dev_pm_ops bmi160_core_pm_ops = {
+	RUNTIME_PM_OPS(bmi160_core_runtime_suspend, bmi160_core_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(bmi160_core_pm_ops, "IIO_BMI160");
+
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 9fa3a19a8977..3e2758f4e0d3 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #include "bmi160.h"
@@ -69,6 +70,7 @@ MODULE_DEVICE_TABLE(of, bmi160_of_match);
 static struct i2c_driver bmi160_i2c_driver = {
 	.driver = {
 		.name			= "bmi160_i2c",
+		.pm			= pm_ptr(&bmi160_core_pm_ops),
 		.acpi_match_table	= bmi160_acpi_match,
 		.of_match_table		= bmi160_of_match,
 	},
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index ebb586904215..3581bd788483 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -7,6 +7,7 @@
  */
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -61,6 +62,7 @@ static struct spi_driver bmi160_spi_driver = {
 		.acpi_match_table	= bmi160_acpi_match,
 		.of_match_table		= bmi160_of_match,
 		.name			= "bmi160_spi",
+		.pm			= pm_ptr(&bmi160_core_pm_ops),
 	},
 };
 module_spi_driver(bmi160_spi_driver);
-- 
2.49.0


