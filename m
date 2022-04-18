Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F43505E73
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiDRTYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347675AbiDRTYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23035A80
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A90760E16
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A123C385A7;
        Mon, 18 Apr 2022 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309696;
        bh=EjO9q3akkN+aIPxTyZeloHCvdZ06XlTfElMKLOn/fIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDSPCJBqJJ6S25Lz6fpIgJzetAgIo2cXwU50xBU8tHSP+0brPLOqe98Ol19TTCchC
         qboEAD5VvkqooYB6cYumno3IazqD/ewQ4AVZaJA0C/5v0BON+FdNxjOXCRvBVErG7v
         II4CpHEhLsuDZKZfuFdBIW7eBgASQTkMdVcD2ir0M/UjX2/ef+Pdq0/PBSYoPnoeRG
         3DIcDLwpVDHB3gQjK+K8Q6m/BAIThV3CbpWTOQAwIkIabp/9FhEI9Hy37T1aQLNL7p
         hJ7z2S9k/hoqjgzVnoGfTjlBfsW9q+AoGUdBgHVWBACwhYaRWrwmZ1UdlOT3Gh1WDy
         nz1rbgWa/ZNeg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/17] staging: iio: ad7746: White space cleanup
Date:   Mon, 18 Apr 2022 20:29:04 +0100
Message-Id: <20220418192907.763933-15-jic23@kernel.org>
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

Tidy up some trivial whitespace issues.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 6fe3221c8ace..058f1b74122e 100644
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
2.35.3

