Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F2609393
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJWNXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C736FC51
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qJ-Vo; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-000ygP-Io; Sun, 23 Oct 2022 15:23:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-00A3Qh-6X; Sun, 23 Oct 2022 15:23:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/23] iio: accel: adxl372: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:41 +0200
Message-Id: <20221023132302.911644-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jhwmHl4KehWAQNkUqeCSBfJJ0hRVOmxjhfMDDNXfRbI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9EOsEr6zhCa/Z7YivkPrtQ6BsnxeXSdmJ2tU2X m0srv+eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/RAAKCRDB/BR4rcrsCUV5CA CdtYAJtL6vMnbJNLli5SSmCYYPHdWZ6NLVEWHPbVUk2aFXuPYhzisktbI5tG5rLkz+SrPqDgsXIXy7 3wiUDTyAdSly6UssvsKi6HRV8FgVL7KbEwZm4T3YfDtbBYRGVdKaJhwZ9L3mePuSUrI74XOlNInEY5 JkOxU8K2Za5fYyN5tvq+oMlsS02F1xvpulUOYlnsT/vlF2hrfRUZoOGhMeUeNsyqfiI9jOHi+6A1dN fBBRMR21VLRKqvYhkxZSXne30JB/FQwGDlnrmKlxhSyKypZ7QPCNUaIBRHww8rET+/8tZcmEyCyyKK L9VYGNq2BSTr/KLTV32A2asxEuoYC5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in .probe(). The device_id array has to move up for that
to work.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/adxl372_i2c.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 4efb70a5fe40..5a21c1bcf2d8 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -18,9 +18,15 @@ static const struct regmap_config adxl372_regmap_config = {
 	.readable_noinc_reg = adxl372_readable_noinc_reg,
 };
 
-static int adxl372_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id adxl372_i2c_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
+
+static int adxl372_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(adxl372_i2c_id, client);
 	struct regmap *regmap;
 	unsigned int regval;
 	int ret;
@@ -41,12 +47,6 @@ static int adxl372_i2c_probe(struct i2c_client *client,
 	return adxl372_probe(&client->dev, regmap, client->irq, id->name);
 }
 
-static const struct i2c_device_id adxl372_i2c_id[] = {
-	{ "adxl372", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
-
 static const struct of_device_id adxl372_of_match[] = {
 	{ .compatible = "adi,adxl372" },
 	{ }
@@ -58,7 +58,7 @@ static struct i2c_driver adxl372_i2c_driver = {
 		.name = "adxl372_i2c",
 		.of_match_table = adxl372_of_match,
 	},
-	.probe = adxl372_i2c_probe,
+	.probe_new = adxl372_i2c_probe,
 	.id_table = adxl372_i2c_id,
 };
 
-- 
2.37.2

