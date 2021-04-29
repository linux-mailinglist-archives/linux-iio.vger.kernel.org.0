Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8536EA7A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhD2M3K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 08:29:10 -0400
Received: from first.geanix.com ([116.203.34.67]:50676 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhD2M3J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Apr 2021 08:29:09 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 44643466699;
        Thu, 29 Apr 2021 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619699301; bh=f/d1enRQkRJtaWSp6G4i9eygpUWyG+QO1k1J0/b1mUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UZFkm3VZZSqlK/ZlgbwjrRGuYFYypskBV/S3n7vcWp2HEZ9B2ZUH0+MM3W+JFAb7U
         L5+VoEMzz8aJakD6bZUaMG9spv1QudgXYLaJXR1DAsI29Pbw0QLXqvsILRpiicvMXu
         uGlawLcn5Y4pgstDkJEAjraWbC3TadbCROwmsZh3Qlrwpla8yCtxZBWvdrFdGPY5pJ
         xhNksduUP27unN4gYbUvq9xImXlNAd60gFkhEbNDmlMU7Kn+ylauC9p8OnAe5Hc17O
         Llixt4Yjgvey0qBkb2oMbS30h8IkA1NgQ01d2E4nqn2rORwG4PK0++egC/NveHpYCl
         i6c3Tq/Eag9wg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v4 6/6] iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads
Date:   Thu, 29 Apr 2021 14:28:06 +0200
Message-Id: <20210429122806.3814330-6-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210429122806.3814330-1-sean@geanix.com>
References: <20210429122806.3814330-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When flushing the hw fifo there is a bug in the I2C that prevents burst
reads of more than one sample pair.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes from RFC:
 - using i2c_verify_client() to detect if hw is connected on I2C bus

 drivers/iio/accel/fxls8962af-core.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 2e863ef71a7d..e45c9e88bf6e 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -14,6 +14,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
@@ -631,11 +632,28 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int sample_length = 3 * sizeof(*buffer);
-	int ret;
+	int ret, i;
 	int total_length = samples * sample_length;
 
-	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
-			      total_length);
+	if (i2c_verify_client(dev)) {
+		/*
+		 * Due to errata bug:
+		 * E3: FIFO burst read operation error using I2C interface
+		 * We have to avoid burst reads on I2C..
+		 */
+		for (i = 0; i < samples; i++) {
+			ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
+					      &buffer[i],
+					      sample_length);
+			if (ret < 0)
+				goto out;
+		}
+	} else {
+		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
+				      total_length);
+	}
+
+ out:
 	if (ret < 0)
 		dev_err(dev, "Error transferring data from fifo: %d\n", ret);
 
-- 
2.31.0

