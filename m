Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28CB550CAF
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiFSTBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiFSS7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872BBC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9ABAB80D6F
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADADFC34114;
        Sun, 19 Jun 2022 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665169;
        bh=VXFhydopQSl3sgAET4zWMBD8bvYfX4DlZXF455MN9CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6+/v3VGzlY1RSBY+YrNRkvRG6ZXAnIBXhAIGA1aicwNO3Va9wPhsQqop0QlqLJV5
         NUxRyyzEa4HJKdEV9VGbSm3andQKp5Z+9OQO6w0rlmq99R3OmJDVE2iuMff+dBL3Z3
         8cr21FBq4c0vPOekWK/JZBWJ0w8HK4c6BseJineF+nuNv65Ag74xlX9oxE+ME6UBQy
         LUGrEGrZH2gf6xTAPD8+Z3/3M7iHe1gjtlJLBv1DmXqjYYrvhSk9NDuWV0NC+h9W9v
         dLVq3C6YeZTQ2+61t0Xa0N0TzugS5UJ/DkSTCkJXosuRAgz5FSXGk7EoX/5vj6AF6Y
         OFpi9rerx9nKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 14/17] staging: iio: ad7746: White space cleanup
Date:   Sun, 19 Jun 2022 19:58:36 +0100
Message-Id: <20220619185839.1363503-15-jic23@kernel.org>
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

Tidy up some trivial whitespace issues.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 70dfb35d6135..480f2734b5ad 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -19,9 +19,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-/*
- * AD7746 Register Definition
- */
+/* AD7746 Register Definition */
 
 #define AD7746_REG_STATUS		0
 #define AD7746_REG_CAP_DATA_HIGH	1
@@ -242,12 +240,12 @@ static const struct iio_chan_spec ad7746_channels[] = {
 
 /* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
 static const unsigned char ad7746_vt_filter_rate_table[][2] = {
-	{50, 20 + 1}, {31, 32 + 1}, {16, 62 + 1}, {8, 122 + 1},
+	{ 50, 20 + 1 }, { 31, 32 + 1 }, { 16, 62 + 1 }, { 8, 122 + 1 },
 };
 
 static const unsigned char ad7746_cap_filter_rate_table[][2] = {
-	{91, 11 + 1}, {84, 12 + 1}, {50, 20 + 1}, {26, 38 + 1},
-	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
+	{ 91, 11 + 1 }, { 84, 12 + 1 }, { 50, 20 + 1 }, { 26, 38 + 1 },
+	{ 16, 62 + 1 }, { 13, 77 + 1 }, { 11, 92 + 1 }, { 9, 110 + 1 },
 };
 
 static int ad7746_set_capdac(struct ad7746_chip_info *chip, int channel)
@@ -730,6 +728,7 @@ static int ad7746_probe(struct i2c_client *client,
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->lock);
 
@@ -780,8 +779,8 @@ static int ad7746_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = i2c_smbus_write_byte_data(chip->client,
-					AD7746_REG_EXC_SETUP, regval);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_EXC_SETUP,
+					regval);
 	if (ret < 0)
 		return ret;
 
@@ -794,7 +793,6 @@ static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7747", 7747 },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
 
 static const struct of_device_id ad7746_of_match[] = {
@@ -803,7 +801,6 @@ static const struct of_device_id ad7746_of_match[] = {
 	{ .compatible = "adi,ad7747" },
 	{ },
 };
-
 MODULE_DEVICE_TABLE(of, ad7746_of_match);
 
 static struct i2c_driver ad7746_driver = {
-- 
2.36.1

