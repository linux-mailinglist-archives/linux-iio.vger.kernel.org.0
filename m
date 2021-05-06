Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1985374FCE
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhEFHK4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 03:10:56 -0400
Received: from first.geanix.com ([116.203.34.67]:43834 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhEFHKz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 03:10:55 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id DFA3C467C14;
        Thu,  6 May 2021 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620284995; bh=jOibTSPS6GfMEalWCAqhIQ4KL1a+okB78aZWmriQ+lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KxxVfgQzoGmw50+YvlAS+k2qAOsInZqyudtO3UjToJlcJ2psBtv2SbpRT0uZDG6s8
         mIc25oNQ5HFwEXELnB14cdr312fLzMgSXbLhL5euoLvRFHcdHgcxlDmOR7GE3khXEz
         f4yN08Y9dLYzv9mVCNMcSH1B1BkoGWxt2cs3vyM/MzY+1UIs3LKJOPCOmTgVxbjO23
         p2MhxLRCCEfJm5KP8jguVt9oAsph6CkhO70UqPRJ0WgyhFoKzbjHd6h3UtQxWddluI
         hEoAbrb4uYnXQgK1SQu/VMR23zV2CCEsR+yui/G31v2m2q6aKsj/3GskJpdtj9aZ+1
         bgSnOdcvkSKgA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        tomas.melin@vaisala.com
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v5 6/6] iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads
Date:   Thu,  6 May 2021 09:09:40 +0200
Message-Id: <20210506070940.312959-6-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210506070940.312959-1-sean@geanix.com>
References: <20210506070940.312959-1-sean@geanix.com>
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

Changes for v5:
 - added errata function

 drivers/iio/accel/fxls8962af-core.c | 33 ++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 889e470658b9..9f4fdddfee41 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -14,6 +14,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
@@ -624,16 +625,42 @@ static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
 	.postdisable = fxls8962af_buffer_postdisable,
 };
 
+static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
+					   u16 *buffer, int samples,
+					   int sample_length)
+{
+	int i, ret;
+
+	for (i = 0; i < samples; i++) {
+		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
+				      &buffer[i * 3], sample_length);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 				    u16 *buffer, int samples)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int sample_length = 3 * sizeof(*buffer);
-	int ret;
 	int total_length = samples * sample_length;
+	int ret;
+
+	if (i2c_verify_client(dev))
+		/*
+		 * Due to errata bug:
+		 * E3: FIFO burst read operation error using I2C interface
+		 * We have to avoid burst reads on I2C..
+		 */
+		ret = fxls8962af_i2c_raw_read_errata3(data, buffer, samples,
+						      sample_length);
+	else
+		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
+				      total_length);
 
-	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
-			      total_length);
 	if (ret)
 		dev_err(dev, "Error transferring data from fifo: %d\n", ret);
 
-- 
2.31.0

