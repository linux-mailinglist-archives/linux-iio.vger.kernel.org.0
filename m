Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8510A50E95B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Apr 2022 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiDYTVK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Apr 2022 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiDYTVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2022 15:21:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1792D3A
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 12:18:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj4Dc-0003Sj-VH; Mon, 25 Apr 2022 21:17:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj4Dd-005CmI-8c; Mon, 25 Apr 2022 21:17:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj4Db-005aTp-2m; Mon, 25 Apr 2022 21:17:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] iio: gyro: mpu3050: Make mpu3050_common_remove() return void
Date:   Mon, 25 Apr 2022 21:17:35 +0200
Message-Id: <20220425191735.59032-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; h=from:subject; bh=V8by6PXOLwXoGKM0w7puhYcmt7G/82TgpTjexbpNcxQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiZvPL00oPDrUUhk35CTyLY2K2YbdS4q3urwbo16Mm TF+fG4CJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmbzywAKCRDB/BR4rcrsCdmvB/ 0ZIja+AwqD1JS9gJdb1scB49TYuxgmONBoUO8n5Havuk4veeUV2cTkU3hGHhmf6VLad2gbOjpw7xH1 SDcQ5QIBDbLbOzjJdtDWFJmDJGkCBmclgUOn/ngMGgROkX2jR7QZQCb1ZygZp8nZ3OwMaYzwR4C0Mr wkCYyLDdq0OHDdGDhIvaF8W/afElgEVydd6GniQU69xQAL0qDEvQ4F6Icn/VAQTnU1bmQscKaEMDkQ 3VbH8sgxdtF8K29bnVuW9iVEYgt8xlGZjFzY8xfcsNkcZ+T6PRVX78lg6QpATOeA/3zbZWxR6eBTUZ noQn5r8zs+Au/TQBqnHeChlrukrX+K
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

This function (up to now) returns zero unconditionally, so there isn't
any benefit of returning a value. Make it return void to be able to see
at a glance that the return value of mpu3050_i2c_remove is always zero.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/gyro/mpu3050-core.c | 4 +---
 drivers/iio/gyro/mpu3050-i2c.c  | 4 +++-
 drivers/iio/gyro/mpu3050.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ea387efab62d..b8e538a33cd6 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1263,7 +1263,7 @@ int mpu3050_common_probe(struct device *dev,
 }
 EXPORT_SYMBOL(mpu3050_common_probe);
 
-int mpu3050_common_remove(struct device *dev)
+void mpu3050_common_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
@@ -1276,8 +1276,6 @@ int mpu3050_common_remove(struct device *dev)
 		free_irq(mpu3050->irq, mpu3050);
 	iio_device_unregister(indio_dev);
 	mpu3050_power_down(mpu3050);
-
-	return 0;
 }
 EXPORT_SYMBOL(mpu3050_common_remove);
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index ef5bcbc4b45b..5b5f58baaf7f 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -86,7 +86,9 @@ static int mpu3050_i2c_remove(struct i2c_client *client)
 	if (mpu3050->i2cmux)
 		i2c_mux_del_adapters(mpu3050->i2cmux);
 
-	return mpu3050_common_remove(&client->dev);
+	mpu3050_common_remove(&client->dev);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/iio/gyro/mpu3050.h b/drivers/iio/gyro/mpu3050.h
index 835b0249c376..faf4168a3b07 100644
--- a/drivers/iio/gyro/mpu3050.h
+++ b/drivers/iio/gyro/mpu3050.h
@@ -91,7 +91,7 @@ int mpu3050_common_probe(struct device *dev,
 			 struct regmap *map,
 			 int irq,
 			 const char *name);
-int mpu3050_common_remove(struct device *dev);
+void mpu3050_common_remove(struct device *dev);
 
 /* PM ops */
 extern const struct dev_pm_ops mpu3050_dev_pm_ops;

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

