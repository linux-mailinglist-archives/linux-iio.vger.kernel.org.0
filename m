Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62AF550CA6
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiFSS7b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiFSS7M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CDBC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E829AB80D8D
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1789C34114;
        Sun, 19 Jun 2022 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665148;
        bh=ANd2PHLClSaxetFXMSGBtb8MufLNbd6LdSMYiBOpOoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGIgyFypMmgFdSnvP205yObSzBYQCvVVWlqbNlgIeFbMrxQcTwzxqTXL9eXZHPLiw
         j8Lf/x96z1HZC0wFmBg2+drw4/0biFVSHPYN68VycvHXgvgA7Q+YBYoR07IDDteHkC
         EKhIJ9KgZnIfBQGS9kqir6l4V7m9lDO+asK+tRgEdnG134xcLXTmenvjKHWV9znTDy
         ++0K7npJwWBYE1NnENHZoxlH9vvxRW+fEVovXuIDNyRHKIlXUaXjZLeBTbW4mtTYFb
         3HikpMFvb3pTMtjActYtV/0KSB5ixkYdGsbK7CAA4AAgv5PYGCr3ljYrdUCI1oj7f8
         vJSxgz3Q8OQ0w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/17] staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
Date:   Sun, 19 Jun 2022 19:58:28 +0100
Message-Id: <20220619185839.1363503-7-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/staging/iio/cdc/ad7746.c | 79 ++++++++++++++++----------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f909b841c4d6..bf20c14f60e4 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -500,14 +500,47 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		default:
 			ret = -EINVAL;
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
 		break;
 	default:
-		ret = -EINVAL;
+		break;
 	}
 
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
+	return 0;
 }
 
 static int ad7746_read_raw(struct iio_dev *indio_dev,
@@ -516,50 +549,18 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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
-		if (ret < 0)
-			goto out;
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
-						    sizeof(chip->data),
-						    chip->data);
+		ret = ad7746_read_channel(indio_dev, chan, val);
 		if (ret < 0)
 			goto out;
 
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
-
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
-- 
2.36.1

