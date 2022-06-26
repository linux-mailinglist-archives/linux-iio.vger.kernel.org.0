Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FF55B1D7
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiFZMVC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiFZMU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F9E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89895B80D64
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F835C34114;
        Sun, 26 Jun 2022 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246056;
        bh=Xi2rgt2mN60SDnhcrY3JD5flJN8ktDPB0PYPrAsvGrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViXtkMVeTsJc7OEll/CJ6N7H89XVPFcu0RCTZqYjZE226qTsC902n8DRZlLdgCi7C
         jkqI7vir6piG6a7A1RM27SLP1BdyL59GKJGgkMfAgl8bPmVsHW4JtxVvoFqXXLRGG3
         YX43MNAKYAQJ2bmw3SlAwksvYcC6PyMtv7Z8lzbXDU/paSyV3cbCeLFnlFGxriUleI
         gWvW4FCUdsUQ/rrB3D3/IUa7/p1Gb5C5zVuHz9LqJ4z6btk8N5h7yRZOQYIVgh5+bX
         mJRqLX3kyxwP33cY4K3t4AUlO9OH+isyYTkStQ48CgL8EDNdBjlUYxiQOaSZ1S/Wyj
         DW4XU6jt3QgCg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 14/17] staging: iio: ad7746: White space cleanup
Date:   Sun, 26 Jun 2022 13:29:35 +0100
Message-Id: <20220626122938.582107-15-jic23@kernel.org>
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

Tidy up some trivial whitespace issues.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 034054b09b6f..9ef14405a260 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -21,9 +21,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-/*
- * AD7746 Register Definition
- */
+/* AD7746 Register Definition */
 
 #define AD7746_REG_STATUS		0
 #define AD7746_REG_CAP_DATA_HIGH	1
@@ -244,12 +242,12 @@ static const struct iio_chan_spec ad7746_channels[] = {
 
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
@@ -732,6 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->lock);
 
@@ -782,8 +781,8 @@ static int ad7746_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = i2c_smbus_write_byte_data(chip->client,
-					AD7746_REG_EXC_SETUP, regval);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_EXC_SETUP,
+					regval);
 	if (ret < 0)
 		return ret;
 
@@ -796,7 +795,6 @@ static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7747", 7747 },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
 
 static const struct of_device_id ad7746_of_match[] = {
@@ -805,7 +803,6 @@ static const struct of_device_id ad7746_of_match[] = {
 	{ .compatible = "adi,ad7747" },
 	{ },
 };
-
 MODULE_DEVICE_TABLE(of, ad7746_of_match);
 
 static struct i2c_driver ad7746_driver = {
-- 
2.36.1

