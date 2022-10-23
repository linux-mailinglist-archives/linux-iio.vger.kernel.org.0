Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C219C60939C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJWNXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJWNXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256A6F27A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-0006z9-I3; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-000yhZ-Qj; Sun, 23 Oct 2022 15:23:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-00A3Rt-Vl; Sun, 23 Oct 2022 15:23:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Peter Rosin <peda@axentia.se>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 21/23] iio: accel: stk8ba50: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:23:00 +0200
Message-Id: <20221023132302.911644-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=blqSJR1vQED6Phwn6GV3cYhB15BBqwEbzJcH3mrSz5E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+X5yIWA83Sw2ZcGVuWDbWlf+mkxbUH1ecRsEcF WXfQRbqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/lwAKCRDB/BR4rcrsCS4FB/ wLIsvAW7DPrraBCEMmv/Pu0D4uEUXdptk7qbGi3XgUeJO7jZDEz1fOHZHukBGyNY8Hb2AMFe+d4r48 feNIWS3ZcMPIOvh55sXDpIg7H5NA0ofOk8fVJRCDtyJ+Z8ZkpwMvCOVy0oCoI5BUmAck7UDnK8rLjO j7Km+lWRjbt4XfYlGceSDEQRr7nT3BF+ybN+Uw6FFJEKCoGejfAK91j3+DwYDlBcMvDBgbuttA06Ix v69czAP8WGdWgexYarCAyYe6atfZv1iZ4bN8C7kGvLZ+nIJ6NKlY1SUE4O/12+YeUdcoq6iN9tvtde 9IJa/m8jQ9J/IwI0GSeNg4tpp8lGuI
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
 drivers/iio/accel/stk8ba50.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 2f5e4ab2a6e7..44f6e0fbdfcc 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -379,8 +379,7 @@ static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
 	.postdisable = stk8ba50_buffer_postdisable,
 };
 
-static int stk8ba50_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int stk8ba50_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -544,7 +543,7 @@ static struct i2c_driver stk8ba50_driver = {
 		.pm = pm_sleep_ptr(&stk8ba50_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
 	},
-	.probe =            stk8ba50_probe,
+	.probe_new =        stk8ba50_probe,
 	.remove =           stk8ba50_remove,
 	.id_table =         stk8ba50_i2c_id,
 };
-- 
2.37.2

