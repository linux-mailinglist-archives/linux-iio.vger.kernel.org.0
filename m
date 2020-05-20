Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9891DBE4F
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgETTsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgETTsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:48:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DBAC061A0E;
        Wed, 20 May 2020 12:48:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p12so3560949qtn.13;
        Wed, 20 May 2020 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7dEuExu+9nzLFNcGG5lhUu0m/vxx9QxDZgwULvJaokQ=;
        b=KZH9PT/PGeCGhHyyEfu1A52E/sLv/KbKDoJSVCAnbgC72NRyOILNJ5IkpzAAVDQ3Pt
         CvqJjk2WRNewK2N1FDZV9ZGG/OJBpbH40O1euLzSIfmL+zvAU2cxVxqPCe6U+Modz8Du
         P3rNkJJjm40vV+jUfePplExH55BWaP9MZ8HkLkdh93QMg03t8HtYNnsckRsyDGOkfmhp
         zzS3wN4LLdskZ5tBI94M+Dh3xH1s1XKwvz//ONgQ10HZx1R16+jJqTukkIE//+S2IKTA
         4MYxwDQxKK6JZ9Hgz2ZdviQJSmBbYMlbt5d4UN++8eklit7SZzXViQCuzL7lTdWfzrYO
         p+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7dEuExu+9nzLFNcGG5lhUu0m/vxx9QxDZgwULvJaokQ=;
        b=erx/dRJOrIXhNgYormbINN4GOy3j07+VEj7NoXtybzqr31FlrZLv8+nPkRndAO7g6s
         iSxAwgkI3BVJrjoiuj7w930ByLT0MEaNy+jYHJ9n3LpQg9z69wmDuOLhFiuWzsjbyjeZ
         KxwYrgfqtK1BBKHSzNcTRyF+NzcwFCy3BZnf0o8TZVLxZcx5qqnXLpJb9ZgSk5QwTn47
         lYvNtYG9o9ncg1hsRRMq+Y+zDU6k+1RjyrrtWCsF7LVeVm7GPeS0vde93DYUz9NuMkWe
         nbE4hz94pOkubCiMqpum1Xc1TbVStCTeD9PuzNGVuWpvWHE7K4Qv+G2z5Dq/z+89n2sB
         MOEQ==
X-Gm-Message-State: AOAM532UTmTvArumjtk6zlrh/H6z+XSB6rt42d7tmOzbcOhpIrwx01ap
        nDfFyNG407nrmwbc7T7soQvshwEiWa9XDw==
X-Google-Smtp-Source: ABdhPJxCRf6EBAl3t+4KkcqdCplFla7TOi9pKWVX5O4BufA3M9xnLUzuiXdX/Mlb+CkNJ1FFSnW1Tw==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr7277316qtj.181.1590004088836;
        Wed, 20 May 2020 12:48:08 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:48:08 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 4/5] iio: imu: bmi160: added regulator support
Date:   Wed, 20 May 2020 21:46:43 +0200
Message-Id: <20200520194656.16218-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add vdd-supply and vddio-supply support.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 77b05bd4a2b2..d3316ca02fbd 100644
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
@@ -793,9 +800,16 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
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
+	if (ret)
+		dev_err(dev, "Failed to disable regulators: %d\n", ret);
 }
 
 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
@@ -815,6 +829,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
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
-- 
2.17.1

