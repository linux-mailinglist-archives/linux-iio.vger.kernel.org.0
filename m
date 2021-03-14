Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40D33A774
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhCNSST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhCNSSA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2371B64E77;
        Sun, 14 Mar 2021 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745880;
        bh=diLHehv8Mv2+cM2498jtDHOuWokJ4UKt+sDnQoVha58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIDHJxo99rCv9Hm59nw/kdeEoUp8y3s513r6fFtTYZ1AKkY6y3BWLqR1p8CglWWJk
         foLg3a3StRaul4z/uXqOIIBMXxQp6UDUv+l3IEvkFbGUBvlAdGAJE1Cilxhy3y60q/
         IQjM4c589P+WrWBCg9Wv0VZK4VjWoJ7LoFi9I7eSBbGKnAoRcS1itNp3BfxAC9Uwsk
         SImgxFWhwL/DX1MkD6SdK7CUTA4m1EFmzq+u3yOa0cG8QjcjizBo7mV6dPxwYE21Lj
         202Q5M8gHqf9yanesz9fpA5eQs/qbc5KEs4aApSHl1wEz4S5MaRet+0zW4NNrBEbk3
         lYYbbQiK8KyKQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 19/24] staging:iio:cdc:ad7150: Really basic regulator support.
Date:   Sun, 14 Mar 2021 18:15:06 +0000
Message-Id: <20210314181511.531414-20-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given DT docs will include regulators, lets just turn them on and
off with driver probe() and remove().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-20-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 39d70805d2a6..30abfacda074 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
@@ -538,11 +539,19 @@ static const struct iio_info ad7150_info_no_irq = {
 	.read_raw = &ad7150_read_raw,
 };
 
+static void ad7150_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -557,6 +566,18 @@ static int ad7150_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	ret = regulator_enable(reg);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, ad7150_reg_disable, reg);
+	if (ret)
+		return ret;
+
 	chip->interrupts[0] = fwnode_irq_get(dev_fwnode(&client->dev), 0);
 	if (chip->interrupts[0] < 0)
 		return chip->interrupts[0];
-- 
2.30.2

