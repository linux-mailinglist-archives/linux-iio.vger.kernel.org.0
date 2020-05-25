Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B51E12FA
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbgEYQsF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbgEYQsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:48:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FEC061A0E;
        Mon, 25 May 2020 09:48:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so2037690qtn.2;
        Mon, 25 May 2020 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xCXlo4z6q8wFTdTTHGR9qbnBVj136ztzEt0J9ce9F0c=;
        b=AKB49A/ybaEjv3ZjiZLKoft8hKCuF2YoxC0KfSFdFOVp0DlBtTRTFw8rNeHqZC+8aV
         J729slwtgG+gfJIShBkDaa6xAIjnJSuvs9Z1RylVTIGOOXigYOEXp3/AKA7wNpIRNMI8
         /ZESVxhTbommQTNbnolrDcWadOE/OcvxJ4o3SKmx56DYC6RHhI9dQ4NiJOW1B8fCQ1CM
         9BjwGqXZedcglScsvPU1hthsm1tnd9w8ugS1zM7T7tibWaVSWdQIi/ndYJcDIdZbqeNc
         M8lfCpk5MMFTRb3MVEgGW/nsIGL3iFg5YPmveZhkxJcBIhnMASxKw5YG/78Ob1Dk5S7U
         +FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xCXlo4z6q8wFTdTTHGR9qbnBVj136ztzEt0J9ce9F0c=;
        b=s8vbdjzzwUaSRMAO+4h3USyr/OGMuc6v1au+n9/nBdz/vvf3pXp32cCeilxNatMoUh
         JBK76kcr0ARoU4zHsAcincqbaPJ8ywgG1xmrycVHfeUr9l9QvO8NAGRqwbt7TcyojUJU
         PD7gd901yZTZtM5LRrn/FmD0hihlDmkQXgbFp+yiWOLQ++bUpjSQX5BvXWKs5LWqQoGh
         siWMTsHpxGqt/e8GuiFMeKhFOCkZuVa2gRinAS8A8QOu0tGpcOejl/3ZXZFJq8eQy0ah
         01773bIJ5kcXdqE03vMXwFwMeGF88KMTwC/eDM3b/gDnp7ZDQd0z6f/7xu6RDW7SYXRd
         4LfA==
X-Gm-Message-State: AOAM533vOjracf5VDuj4VDoePLLusALe+C5Li1DKWRwV4LkT8ZV38HN/
        stlSyIYMy6gD/Q8D7fK8Ce8iOLvMjWU=
X-Google-Smtp-Source: ABdhPJycUE6ab7dcczQP1Vh2PeOatQob4Hr/z14nS7tERErBqyUNAoSSMx4PdRui6tUXgqck2SvEew==
X-Received: by 2002:ac8:6b03:: with SMTP id w3mr29640224qts.275.1590425282142;
        Mon, 25 May 2020 09:48:02 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:48:01 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 4/5] iio: imu: bmi160: added regulator support
Date:   Mon, 25 May 2020 18:46:03 +0200
Message-Id: <20200525164615.14962-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add vdd-supply and vddio-supply support.

While working on an msm8916 device and having explicit declarations for
regulators, without setting these regulators to regulators-always-on it
happened those lines weren't ready because they could have been controlled
by other components, causing failure in module's probe.

This patch aim is to solve this situation by adding regulators control
during bmi160_chip_init() and bmi160_chip_uninit(), assuring power to
this component.

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

