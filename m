Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF61D7A08
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgERNgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERNgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:36:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A1C061A0C;
        Mon, 18 May 2020 06:36:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so9326848wmj.3;
        Mon, 18 May 2020 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kpmmawvu7m53+G2z+U2iQBPta6NzjZNKXgNes+IuTFU=;
        b=Rak24QphoCQrzPOtrnitJI0RNmLhe1FbEuKmfPJZc4xaywZ2FVHVQFMsiozNgp+unJ
         xN7j2We97V0SkkQW5/FQfa2tFdw90EFUTAWcdD2VTLeHY/s0iSeWkp6bjpx2pCMd40lR
         SOjWJGo4QBKu4FaOMjud13/wk5yOk4Jxjpn47VrytvsxJIx+WXAQKPcOTQYeHLEDIbYh
         7wlzYe+P2/XuGzr61vlYdQIAvK8JadTszbCjQMIagpt4CXi+agt8EkVzMC2SwU/SNUkT
         +7SpKNXSXEdYdTlv1ZI1GjtKUTfsFieZIpZly1exPiCP+sAc5LBIoEYkuQWJOsEol9Ta
         c2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kpmmawvu7m53+G2z+U2iQBPta6NzjZNKXgNes+IuTFU=;
        b=c7FLqYfI7Xxj1KOQjirFWBPpgUAgWXjFUihX6x0m1DCbKRBZN8Xt1iy1zT9h7z1F44
         L+HOP70+ZEMyLFcu01ff5qKLUQaRr6PsCsT29JGYO5AkVspygBDItOrMi+wMVoOAfFYJ
         vyHLErdKJ8tQ90ganzjwyZgVEC902LOrGOkRtFvXxfR2GKHbLc82bRyNuuB/dfwFoSnz
         t3e5Hit6jaOp1GFMEFMbqNJvCV3FHf4yDoY59dqFwNpFl2JB+cPTwXeuKyW1kKoPGYfy
         /+2nCbNBx9RrAdkijKkgo2U9FqmSeDLnGYjI0PTV2JIkvZ5eI9IQ7m0D1QkqnkdJc6an
         h5oQ==
X-Gm-Message-State: AOAM5308Pm60P0uJlLjlRvAsg1B8m07nboCHRjoqGbJLMfZL0OJIgQy/
        JU6n6eE9r9vfvYPW9eKdV80A9ZLwmEg=
X-Google-Smtp-Source: ABdhPJxpm6LSkW/8+hxU16SHx/5L0dEjWgGKnpJaEhUiklN+ijyH4WOU4JkSEJE7yslKcKNVo0WINQ==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr19506256wma.15.1589808958572;
        Mon, 18 May 2020 06:35:58 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l19sm17086772wmj.14.2020.05.18.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:57 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/4] iio: imu: bmi160: added regulator support
Date:   Mon, 18 May 2020 15:33:47 +0200
Message-Id: <20200518133358.18978-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
References: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

---
 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 621f5309d735..923c3b274fde 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -3,10 +3,12 @@
 #define BMI160_H_
 
 #include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
 
 struct bmi160_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
+	struct regulator_bulk_data supplies[2];
 };
 
 extern const struct regmap_config bmi160_regmap_config;
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 6af65d6f1d28..9bbe0d8e6720 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/of_irq.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
@@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	unsigned int val;
 	struct device *dev = regmap_get_device(data->regmap);
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
 	if (ret)
 		return ret;
@@ -793,9 +800,17 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 static void bmi160_chip_uninit(void *data)
 {
 	struct bmi160_data *bmi_data = data;
+	struct device *dev = regmap_get_device(bmi_data->regmap);
+	int ret;
 
 	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
 	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
+				     bmi_data->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to disable regulators: %d\n", ret);
+	}
 }
 
 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
@@ -815,6 +830,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev,
+				      ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
 	ret = bmi160_chip_init(data, use_spi);
 	if (ret)
 		return ret;
@@ -853,6 +878,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_GPL(bmi160_core_probe);
 
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

