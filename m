Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B160939A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJWNXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJWNXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A566FC4A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-0006yL-2t; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-000yhU-MH; Sun, 23 Oct 2022 15:23:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-00A3Ra-W3; Sun, 23 Oct 2022 15:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 16/23] iio: accel: mma9551: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:55 +0200
Message-Id: <20221023132302.911644-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=S9AlV+kyx6oIrLd9f7ye+Lmvnmf93OpnPVzwUoz29ik=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT94sMzdu7QKeUMXGH+TNnYk4xeFuN2Ye+exZZtG DwrNgM+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/eAAKCRDB/BR4rcrsCWVdB/ 4i/ud+4GBIFuMNql+sWQmC/yTYottHwJbRllZmBtPS09eoluWm69/7J3Xvn3zE9x8QIse4ILxYpoOb YufV3NsC+Xy+Yrh8Ac9N3xeLmzmtOcmk7BnuqKuqbJUhdX+43MZ/CSJw9K0l9abssyXbG/Kx2kmv5R B+dymdZ2DNzLUbb1EEBtDN/seTuSaF6TsKw9uh3/ljSzc5wUy2h5QOFPrUWIKzrwPxVH1dR6mPftij cl9rTPpJo9DwH3psmIWvh8Wmw25TMF39A0PlWDEmZI17Ws4eujhj2P3r4FfVOpGVawGuUywiPuyKri TXEvBYAwhGYfZG4z8L/Zl+83ODkULp
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
 drivers/iio/accel/mma9551.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index f7a793f4a8e3..f7c72e8d9fb8 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -446,9 +446,15 @@ static const char *mma9551_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
-static int mma9551_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static const struct i2c_device_id mma9551_id[] = {
+	{"mma9551", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mma9551_id);
+
+static int mma9551_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(mma9551_id, client);
 	struct mma9551_data *data;
 	struct iio_dev *indio_dev;
 	const char *name = NULL;
@@ -594,20 +600,13 @@ static const struct acpi_device_id mma9551_acpi_match[] = {
 
 MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
 
-static const struct i2c_device_id mma9551_id[] = {
-	{"mma9551", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, mma9551_id);
-
 static struct i2c_driver mma9551_driver = {
 	.driver = {
 		   .name = MMA9551_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
 		   .pm = pm_ptr(&mma9551_pm_ops),
 		   },
-	.probe = mma9551_probe,
+	.probe_new = mma9551_probe,
 	.remove = mma9551_remove,
 	.id_table = mma9551_id,
 };
-- 
2.37.2

