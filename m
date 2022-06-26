Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3577055B1D2
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiFZMUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiFZMUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1158E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881BBB80D8A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70664C34114;
        Sun, 26 Jun 2022 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246034;
        bh=/hYaWLT9QXO9lIGSAHFY/tiE5t83QP77db35F53zM14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv3nWgDSxhWwjXLaFu2jTMbsRBuy0IrE9lx3ZYmfuwQlHc2e+n2loxAdalz7zCje0
         zIPplLKOnygPY/wwLgbv51tp0CPfT4cysIoHsCqovx3yM5ENxj5HftZY2EzoNvFDMj
         fQGSzQn/yHbf++3e4nzZV/XkVEVv9/Yler53dLAoP9yMS85/9jB/OcEOUyh78BWRG6
         KnMRjMNKMGup8Lcy3/rgDdXgoOzfdHcsh2qOYLxr4ATBbY2o0EwaJNWY9Ht2/YuN6R
         xSRYiruUS9S3FYlnb4n6uRaOt9bq2hesfZyKocef/sEdCMwlooE7oVtY+Bhjw5wVKi
         4zAYiWgq+Cm5Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 06/17] staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
Date:   Sun, 26 Jun 2022 13:29:27 +0100
Message-Id: <20220626122938.582107-7-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduce deep indenting and simplify the locking cleanup that follows.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 80 ++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 496e90f559c7..8052ac2696d3 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -512,54 +512,66 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad7746_read_channel(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val)
+{
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	int ret, delay;
+	u8 data[3];
+	u8 regval;
+
+	ret = ad7746_select_channel(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	delay = ret;
+
+	regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
+	if (ret < 0)
+		return ret;
+
+	msleep(delay);
+	/* Now read the actual register */
+	ret = i2c_smbus_read_i2c_block_data(chip->client,  chan->address >> 8,
+					    sizeof(data), data);
+	if (ret < 0)
+		return ret;
+
+	*val = get_unaligned_be24(data) - 0x800000;
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * temperature in milli degrees Celsius
+		 * T = ((*val / 2048) - 4096) * 1000
+		 */
+		*val = (*val  * 125) / 256;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int ad7746_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2,
 			   long mask)
 {
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, delay, idx;
-	u8 regval, reg;
-	u8 data[3];
+	int ret, idx;
+	u8 reg;
 
 	mutex_lock(&chip->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = ad7746_select_channel(indio_dev, chan);
+		ret = ad7746_read_channel(indio_dev, chan, val);
 		if (ret < 0)
 			goto out;
-		delay = ret;
-
-		regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
-		ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
-						regval);
-		if (ret < 0)
-			goto out;
-
-		msleep(delay);
-		/* Now read the actual register */
-
-		ret = i2c_smbus_read_i2c_block_data(chip->client,
-						    chan->address >> 8,
-						    sizeof(data), data);
-		if (ret < 0)
-			goto out;
-
-		*val = get_unaligned_be24(data) - 0x800000;
-
-		switch (chan->type) {
-		case IIO_TEMP:
-			/*
-			 * temperature in milli degrees Celsius
-			 * T = ((*val / 2048) - 4096) * 1000
-			 */
-			*val = (*val * 125) / 256;
-			break;
-		default:
-			break;
-		}
 
 		ret = IIO_VAL_INT;
 		break;
-- 
2.36.1

