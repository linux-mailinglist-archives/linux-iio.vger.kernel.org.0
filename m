Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB1505E6B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbiDRTYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347673AbiDRTYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BC35862
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49D98B8108C
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E986C385AA;
        Mon, 18 Apr 2022 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309680;
        bh=ogcRt7PB/AZsDLc4SrFvNvZ+Kb4tStRL7ozwnmVE3/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2AVeLADt0vWmlR+poP+MTV9N+0uN3ryGpy/PCmnkc6Hmu2ld8KQy2ejY+2XVN4KO
         dfqJx/xu41dIakWBcxdtKCh23SbdLrBhKC3+ssthcM90fiLb5HttbupHtFwSu+NZuJ
         6BMuIgO3Erd9w51vpUDLE15NqB+y6bPek4n+i4VeKy3qDXmDtEFZuwhw/v2jjEIkrt
         QpU/SsF/phBKtAj+Iw0geLinVYPVp0kzFgEUWGaAYeqrm5ZrYe1FO9bznmJ1DzOyCN
         Q9L4Oz7Pox+dfD/bXKP42xH3G9QQknIyGoxs2KiOUYPHWA4Z4iBG6ep8vCr6mXNzv3
         8+sOp8GBdGBAw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/17] staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
Date:   Mon, 18 Apr 2022 20:28:56 +0100
Message-Id: <20220418192907.763933-7-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
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
index e4b882586891..6b9530bd12cc 100644
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
+					    3, data);
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
@@ -516,49 +549,17 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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
-						    chan->address >> 8, 3,
-						    data);
-
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
2.35.3

