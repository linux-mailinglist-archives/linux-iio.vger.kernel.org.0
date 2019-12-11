Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213B311BF59
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 22:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLKVia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 16:38:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42774 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 16:38:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so17830962lfl.9
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2019 13:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+zPd04AQaeVHMLYY/Z5Njm+dB8FTeXRC+xGAD4RZWE=;
        b=wlnXGgeXt8DyEHHlhLeGdWHUf0BBscDXNEtLvaiilr+fwETcGiguKMdcxEDHtcZVgV
         JJxk+m01npRfmbGDV09sQk0LvCRGAUGNVg5RYBaUPz4GOT8qpqL0o8uDzlPtRoDGPrDY
         g66NB+pYRcOGL5K79Wyoa6d+jsOUUyOyDDz+12tPrQb6+tsXg28Bx+ZaIetgvVJo9l0Z
         SMj+zBI9EWgL85VCcF57rRmS6m4OwqZEMIRgflTwEmzHONODL1gIJb1ihXJCtR/oHOkQ
         kTq17JamK0ZKv8PtXLXKXcS0uuAKNztOeA8qmjga1EwwDY908G6HjganpESbcx4cMxsY
         2+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+zPd04AQaeVHMLYY/Z5Njm+dB8FTeXRC+xGAD4RZWE=;
        b=kJt11qZr7JT9OCzt2gRO7RD4rZtJ9yulci51mJWtYiXhEpuX03eaSGjiwfP+sa8jJq
         H6IkD9npJIlyPp6TKYnd2UFMlmjd0y34cxVXbMKaU9RPuLFWta+WSvYk7RjkWsgEbNm4
         LPW2JogaC+wDP68hT2UD5g/n/fTHvIkJ190/NY4X6pCofK/+c2fsBjO8bQxGKrp0TWRR
         eB3Lt5/weEl4Ac71LDzYlTPaFT2eT6WIF9Xta7AYlGcDA/SH+8VliZi40650p2DuzcMt
         zk/Qf9tL+CZi4lAp7QC9S6Ktfyt8OgozTYVbWD4IXis1R0olTvmqd4SpsvcX4BKCs88C
         D03g==
X-Gm-Message-State: APjAAAWvbJerkybFvseNV2TVXCwlUmcWvFzUUKGHSRnsO4rK0T/lU9Mi
        RsFbDWmmT+Eh6dfB54pbH5ftgA==
X-Google-Smtp-Source: APXvYqxNqBnBQrPBYd93vMdee+miAhMoTjd65AYnqUWECkNwKBsPMjm0EXMSXq5tc47KhGkWqX1l1g==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr3568694lfh.192.1576100308200;
        Wed, 11 Dec 2019 13:38:28 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id e8sm2074199ljb.45.2019.12.11.13.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:38:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 2/4] iio: accel: bma180: Basic regulator support
Date:   Wed, 11 Dec 2019 22:38:17 +0100
Message-Id: <20191211213819.14024-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211213819.14024-1-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This brings up the VDD and VDDIO regulators using the
regulator framework. Platforms that do not use regulators
will provide stubs or dummy regulators.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bma180.c | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 518efbe4eaf6..4a619b5a544a 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/bitops.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/iio/iio.h>
@@ -110,6 +111,8 @@ struct bma180_part_info {
 #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
 
 struct bma180_data {
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	const struct bma180_part_info *part_info;
@@ -736,6 +739,40 @@ static int bma180_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	data->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->vdd_supply)) {
+		if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vdd regulator %d\n",
+				(int)PTR_ERR(data->vdd_supply));
+		return PTR_ERR(data->vdd_supply);
+	}
+	data->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(data->vddio_supply)) {
+		if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vddio regulator %d\n",
+				(int)PTR_ERR(data->vddio_supply));
+		return PTR_ERR(data->vddio_supply);
+	}
+	/* Typical voltage 2.4V these are min and max */
+	ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
+	if (ret)
+		return ret;
+	ret = regulator_set_voltage(data->vddio_supply, 1200000, 3600000);
+	if (ret)
+		return ret;
+	ret = regulator_enable(data->vdd_supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
+		return ret;
+	}
+	ret = regulator_enable(data->vddio_supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable vddio regulator: %d\n", ret);
+		goto err_disable_vdd;
+	}
+	/* Wait to make sure we started up properly (3 ms at least) */
+	usleep_range(3000, 5000);
+
 	ret = data->part_info->chip_config(data);
 	if (ret < 0)
 		goto err_chip_disable;
@@ -798,7 +835,9 @@ static int bma180_probe(struct i2c_client *client,
 	iio_trigger_free(data->trig);
 err_chip_disable:
 	data->part_info->chip_disable(data);
-
+	regulator_disable(data->vddio_supply);
+err_disable_vdd:
+	regulator_disable(data->vdd_supply);
 	return ret;
 }
 
@@ -817,6 +856,8 @@ static int bma180_remove(struct i2c_client *client)
 	mutex_lock(&data->mutex);
 	data->part_info->chip_disable(data);
 	mutex_unlock(&data->mutex);
+	regulator_disable(data->vddio_supply);
+	regulator_disable(data->vdd_supply);
 
 	return 0;
 }
-- 
2.21.0

