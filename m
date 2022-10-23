Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272060939B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJWNXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJWNXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40B6FC51
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-0006yB-03; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-000yhT-M2; Sun, 23 Oct 2022 15:23:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-00A3Re-6l; Sun, 23 Oct 2022 15:23:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Miaoqian Lin <linmq006@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/23] iio: accel: mma9553: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:56 +0200
Message-Id: <20221023132302.911644-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yJ2HAm0fwDVaQvfFsnkon255fKUr7LSRo6Qj+PA7AJU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+HkV69BldzBCE8Dw4MTiXsBFdQp3jKA2Q6bZiM ErbnFiSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/hwAKCRDB/BR4rcrsCRL6B/ 0VKcXrpKeh/JfXfAkWg5j64HckR6HPRbLHspAqIt4UicSVHZ62VkUiIwf88+KymtC1rpvQV24KOuaf XLaKQ+saqaBPiSVlQjqCNgs0lj1G6iMgz9mDiEogkwRD9QFsnE2CkQZKgiyRK8qjEwDpiMtovRsnAF 0RlQERwZPxyYndvIt6B4YefYVbfL0gcBTrDkz1mtmn8LVidSuvENNUzls0J5GxsGMb/cOBI/1dhVvp n7yDEa7nG6O6CMCGmfXMr2rUq4M7HZ7pX13njMsxBZTN5FxxZuBzHXzfByKRtiYYTyeA12fYeVXkJh hvN5Hm0NJU2SXz9Fa+VcNl61j8d9gS
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
 drivers/iio/accel/mma9553.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 2da0e005b13e..0aa6f2092108 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1073,9 +1073,16 @@ static const char *mma9553_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
-static int mma9553_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+
+static const struct i2c_device_id mma9553_id[] = {
+	{"mma9553", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, mma9553_id);
+
+static int mma9553_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(mma9553_id, client);
 	struct mma9553_data *data;
 	struct iio_dev *indio_dev;
 	const char *name = NULL;
@@ -1230,23 +1237,15 @@ static const struct acpi_device_id mma9553_acpi_match[] = {
 	{"MMA9553", 0},
 	{},
 };
-
 MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
 
-static const struct i2c_device_id mma9553_id[] = {
-	{"mma9553", 0},
-	{},
-};
-
-MODULE_DEVICE_TABLE(i2c, mma9553_id);
-
 static struct i2c_driver mma9553_driver = {
 	.driver = {
 		   .name = MMA9553_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
 		   .pm = pm_ptr(&mma9553_pm_ops),
 		   },
-	.probe = mma9553_probe,
+	.probe_new = mma9553_probe,
 	.remove = mma9553_remove,
 	.id_table = mma9553_id,
 };
-- 
2.37.2

