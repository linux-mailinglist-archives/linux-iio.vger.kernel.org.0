Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4361D9161
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgESHwE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 03:52:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACCFC061A0C;
        Tue, 19 May 2020 00:52:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 50so14663949wrc.11;
        Tue, 19 May 2020 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9q/lrH8Rz1lWaiznxolgZJjw54jdIA13oGlCCkqVWE=;
        b=VFppNQKOwslJ52Bhq5aKyGSXmyfKM+y2ofM/uTjfNjFGd9ihqxIKnPgbhGXVPF6/hZ
         GhtvBF3u3B2SfohsCfVczsf+2vu1p+xwr3VHtEm4PRoP4/B6f4jH26u2V7nujIfF30EN
         DMjXrIHUTpSO3eRw099p5Bz35WAzW048regqgbVMt4t3IYCk1GGLnjFrmHjr+1wh85xM
         nexPtzQ3AQThkprrL7lJ+fN4YiYup+IdCDaU4YESO7BmKAcciJT367yVWvbQ3oG7x2Xs
         H6pR4ULWy9Q6ctuX5W65BKRCQb/2APLvqGTNYF5Q3S1CPWM5QZF+o00ATmALRK00LPRY
         MPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9q/lrH8Rz1lWaiznxolgZJjw54jdIA13oGlCCkqVWE=;
        b=IPjic6i5EdzMJ1jlOIRuOid7hMygLaHcZkDm55NdJeB6dE7R6POmKE/sfFBPCFjmPz
         yMEOpedHoKApO1z2T2dm/acp79JYbyRY/7XI82SBaIHQJLIbgQukNGwOuEZ8BjjAgHT3
         L9S0UqDdK88gFadcdH2/isSxP6ZHxCSvFLiHaAOJgJGdZ+3tuh16fr6iP0RgEvPwxHH0
         kXuPV37R5Gcv0xOhMWCnwRknZlkK97Zr2ba55hAQoQ/CLxWn8SmW/wjDCVzkmJUEvzG5
         2AXqdOWg7c4jqILTX/SdniWpFWzeDnQtOf9hjpAcAozLa1QYakgHeOBzsGc6GxWtqVYn
         OJtg==
X-Gm-Message-State: AOAM531liISiLThYrcFiswkycW8X1dleqswCI3dm+mLUSYkU3iNTQE88
        Gj9vDjOZn3d7TT7sIIKf8LnPR8VcLhQ=
X-Google-Smtp-Source: ABdhPJxIz2vOS+zMIvTdjRmEANZlTkljXpVaVGC6bSoPaePYn8jUR2aXIUq24cRHqc3d0fbDP9vtIA==
X-Received: by 2002:adf:e985:: with SMTP id h5mr25204106wrm.239.1589874721123;
        Tue, 19 May 2020 00:52:01 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w18sm20019697wro.33.2020.05.19.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:52:00 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 3/4] iio: imu: bmi160: added regulator support
Date:   Tue, 19 May 2020 09:50:59 +0200
Message-Id: <20200519075111.6356-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2: fixed missing description

Add vdd-supply and vddio-supply support. Without this support vdd and vddio
should be set to always-on in device tree

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

