Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EC60938C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJWNXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJWNX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED086FC51
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qI-Vn; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-000ygM-EQ; Sun, 23 Oct 2022 15:23:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-00A3Qq-PN; Sun, 23 Oct 2022 15:23:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/23] iio: accel: da280: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:44 +0200
Message-Id: <20221023132302.911644-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QIQs/Y/e+MIhj8+TvOC6A0wy0PmK3cz0xM5StBM1B8I=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9P3G6bGq1xiHzZMOzU9Uqa/q17y3vtaiI9CzIQ tSllCpCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/TwAKCRDB/BR4rcrsCUUbB/ 9UzGWMwvaJiSua1Tkm1RczKdabi1QmRS4PcexO7tWXgDde1eEnr0jmF7YTFiTYAirCYnIBK1Rgnvci Rf4nHbvOfooeriCtSV7ZHOVt2TNKW+xFM9it9JzPlqGLKgL1te4xKv+jSPEw7ZOe1+K0pJhLovRxUo fg+r5TBAxneAlfKKDt0LzZOhLN+fuIL9BA8NP2kZoQUKgxn9D/9LbpOBSWO2GSxTbqsF9sg3tkJ6ed 1IlsuLB1qt8X5YgIAM9YfXh0kHRiWQ0RSn1/xJkAivVHia5g6drFLF2mtqTCwkgO4Y87MKazEbCfrZ 3m8wgqj40cV+Wblg+gDLR7dVB2bFQq
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
 drivers/iio/accel/da280.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 04e9c5678964..72a6a835ee74 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -105,8 +105,14 @@ static void da280_disable(void *client)
 	da280_enable(client, false);
 }
 
-static int da280_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static const struct i2c_device_id da280_i2c_id[] = {
+	{ "da226", da226 },
+	{ "da280", da280 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
+
+static int da280_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -131,6 +137,9 @@ static int da280_probe(struct i2c_client *client,
 	if (ACPI_HANDLE(&client->dev)) {
 		chip = da280_match_acpi_device(&client->dev);
 	} else {
+		const struct i2c_device_id *id =
+			i2c_match_id(da280_i2c_id, client);
+
 		chip = id->driver_data;
 	}
 
@@ -171,20 +180,13 @@ static const struct acpi_device_id da280_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
 
-static const struct i2c_device_id da280_i2c_id[] = {
-	{ "da226", da226 },
-	{ "da280", da280 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
-
 static struct i2c_driver da280_driver = {
 	.driver = {
 		.name = "da280",
 		.acpi_match_table = ACPI_PTR(da280_acpi_match),
 		.pm = pm_sleep_ptr(&da280_pm_ops),
 	},
-	.probe		= da280_probe,
+	.probe_new	= da280_probe,
 	.id_table	= da280_i2c_id,
 };
 
-- 
2.37.2

