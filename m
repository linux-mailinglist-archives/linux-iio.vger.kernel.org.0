Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36637527147
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiENNdL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiENNdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 09:33:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FC22536
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 06:33:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprtA-0004sK-5m; Sat, 14 May 2022 15:32:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprtA-002HtA-E4; Sat, 14 May 2022 15:32:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprt8-009fvX-C0; Sat, 14 May 2022 15:32:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] iio:magnetometer:mbc150: Make bmc150_magn_remove() return void
Date:   Sat, 14 May 2022 15:32:50 +0200
Message-Id: <20220514133250.307955-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; h=from:subject; bh=t+OPSaDrfq/MLParFt7NgHrHvSyexuQsQjU/VbXXOgI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBif699jaSHq3JLvVGelRpFylgv/DxB3DHb7bcKs0Xl GPVC4K+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYn+vfQAKCRDB/BR4rcrsCWQLB/ 9LNpA7TS9mWVhBKgRZQb62+OcmhQfpF9Gu13Xn3QT2pi1i6WbGHEIRWg5+ygwR7zjTYyLkd0gGc1qr sKr1IakD55WtnpdMgjsgqJK4WtxM01JAUWVWOnvkSngNWFLKJ4rk441prSYP3GikkzJ2bv+6A/Xc6g 5QXnOxl1o2foZJsnpkSqqI3DLOhd7EGhQpelGST/K2iKupK/awb8+9yfuqIZUCLsd9EIEAfK3W4XLp cPHw7ZSKDYBpODeMjRrGkYjZafsVZovGXyI+fNfuWFFX+q0Mx4KWLVdfY0O/whk5gcaD0etw8tLnRQ RN+Bn89rgxIcf3eXjQnSN7hYJvSrRl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

bmc150_magn_remove() always returns zero. Make it return no value which
makes it easier to see in the callers that there is no error to handle.

Also the return value of i2c driver remove callbacks is ignored anyway.
This prepares making i2c remove callbacks return void, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/magnetometer/bmc150_magn.c     | 3 +--
 drivers/iio/magnetometer/bmc150_magn.h     | 2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 4 +++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 64e8b04e654b..06d5a1ef1fbd 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -985,7 +985,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_NS(bmc150_magn_probe, IIO_BMC150_MAGN);
 
-int bmc150_magn_remove(struct device *dev)
+void bmc150_magn_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
@@ -1008,7 +1008,6 @@ int bmc150_magn_remove(struct device *dev)
 	mutex_unlock(&data->mutex);
 
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-	return 0;
 }
 EXPORT_SYMBOL_NS(bmc150_magn_remove, IIO_BMC150_MAGN);
 
diff --git a/drivers/iio/magnetometer/bmc150_magn.h b/drivers/iio/magnetometer/bmc150_magn.h
index 3b69232afd2c..98c086d10c13 100644
--- a/drivers/iio/magnetometer/bmc150_magn.h
+++ b/drivers/iio/magnetometer/bmc150_magn.h
@@ -7,6 +7,6 @@ extern const struct dev_pm_ops bmc150_magn_pm_ops;
 
 int bmc150_magn_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name);
-int bmc150_magn_remove(struct device *dev);
+void bmc150_magn_remove(struct device *dev);
 
 #endif /* _BMC150_MAGN_H_ */
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index e39b89661ad1..65c004411d0f 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -36,7 +36,9 @@ static int bmc150_magn_i2c_probe(struct i2c_client *client,
 
 static int bmc150_magn_i2c_remove(struct i2c_client *client)
 {
-	return bmc150_magn_remove(&client->dev);
+	bmc150_magn_remove(&client->dev);
+
+	return 0;
 }
 
 static const struct acpi_device_id bmc150_magn_acpi_match[] = {

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

