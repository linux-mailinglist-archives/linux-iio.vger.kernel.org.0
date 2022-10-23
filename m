Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB98609398
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJWNXj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJWNXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428367173E
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qG-Vn; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-000ygD-Tg; Sun, 23 Oct 2022 15:23:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawU-00A3Qe-WB; Sun, 23 Oct 2022 15:23:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 01/23] iio: accel: adxl367: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:40 +0200
Message-Id: <20221023132302.911644-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nWmLzYKzE7R8Q3GvuNL7ihDfXgv5MnRVXj6oD/1j3f8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9BOYnJF+OtrhIWZjiOMeBOvs3AQOy9HZA44BJX mYeCrrqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/QQAKCRDB/BR4rcrsCSEdB/ 0RhunkJZLseqfB4UPhFaFYApg2QamMXcNXR5DyBq1LDRNSfVYpkO4wBHXxkvZzi/B6O5OBJebgbpUy MA9HrOr/5PpYiJhleICFfijdYCJHoiw4HMJcPwxuyZ7HXUDHQRBECgRoUGHEVMM5PS2feAN76X09Kn D6vkj7Fwi+YxaFxVtFgpPicprSnPkie/itCtOtdXWyfQWcFJPbM/+f09eTCvLXBLpCYix52/FftorG 6tXMQBEFwTdqy8pw90tcRSF+tyHDcHWsmsMCS+zv9bzYQkPzXVdj1JJxql/Zn91Yvju3mbxOSl+zIh fZRwdkI0ep1ky2o0UhbcU60EkvJJyY
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

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/adxl367_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index 3606efa25835..070aad724abd 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -41,8 +41,7 @@ static const struct adxl367_ops adxl367_i2c_ops = {
 	.read_fifo = adxl367_i2c_read_fifo,
 };
 
-static int adxl367_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int adxl367_i2c_probe(struct i2c_client *client)
 {
 	struct adxl367_i2c_state *st;
 	struct regmap *regmap;
@@ -78,7 +77,7 @@ static struct i2c_driver adxl367_i2c_driver = {
 		.name = "adxl367_i2c",
 		.of_match_table = adxl367_of_match,
 	},
-	.probe = adxl367_i2c_probe,
+	.probe_new = adxl367_i2c_probe,
 	.id_table = adxl367_i2c_id,
 };
 
-- 
2.37.2

