Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE98609397
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJWNXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWNXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9316F240
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-0006qK-6W; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-000ygT-M5; Sun, 23 Oct 2022 15:23:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-00A3Qn-JI; Sun, 23 Oct 2022 15:23:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 04/23] iio: accel: bmc150: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:43 +0200
Message-Id: <20221023132302.911644-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fHItEGJyJDkYJNBVev9dQabYNuL2uv9gbyYFmhiShnY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9LJMvZ+jA5scSFMdKL4LJv3woZofUfXUzsNFS2 CH3I8pSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/SwAKCRDB/BR4rcrsCYYrB/ 4pOKMyeusXANJlgY8EpUmAJWim9gDDAEcV421zpgY7Durt+cVUu6dDQo+GJRwKf/FdukQ91o6PEKKr xodhh+0FliC3TDKk9ihelq5XmnejOpglhUZzSuhcT4S1CY1ZOqEeZJ9Bf3D7Xeu40zQTX3boLS8YoX y28qqyeOJMTQ3glI5S7IuWAZrAMy+OnOY/r9czzs9nNvfpbcxZNom3Auu0hQxd1rE1JJ3eEWZDIImN 9HbSS6vDXzVDQTjxCFJf3etbesd0eIJbRdK4cFHqKxZqAdd+TQktLnk656WsFXCw2Ta48aBOPcneju Ud4hCJpSx5bB5iC+oFGMiHQD68VdKX
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
 drivers/iio/accel/bmc150-accel-i2c.c | 37 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index be8cc598b88e..0184106d0b65 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -171,9 +171,24 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client) {}
 static void bmc150_acpi_dual_accel_remove(struct i2c_client *client) {}
 #endif
 
-static int bmc150_accel_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static const struct i2c_device_id bmc150_accel_id[] = {
+	{"bma222"},
+	{"bma222e"},
+	{"bma250e"},
+	{"bma253"},
+	{"bma254"},
+	{"bma255"},
+	{"bma280"},
+	{"bmc150_accel"},
+	{"bmc156_accel", BOSCH_BMC156},
+	{"bmi055_accel"},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
+
+static int bmc150_accel_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(bmc150_accel_id, client);
 	struct regmap *regmap;
 	const char *name = NULL;
 	enum bmc150_type type = BOSCH_UNKNOWN;
@@ -231,22 +246,6 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
-static const struct i2c_device_id bmc150_accel_id[] = {
-	{"bma222"},
-	{"bma222e"},
-	{"bma250e"},
-	{"bma253"},
-	{"bma254"},
-	{"bma255"},
-	{"bma280"},
-	{"bmc150_accel"},
-	{"bmc156_accel", BOSCH_BMC156},
-	{"bmi055_accel"},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
-
 static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bma222" },
 	{ .compatible = "bosch,bma222e" },
@@ -269,7 +268,7 @@ static struct i2c_driver bmc150_accel_driver = {
 		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
 		.pm	= &bmc150_accel_pm_ops,
 	},
-	.probe		= bmc150_accel_probe,
+	.probe_new	= bmc150_accel_probe,
 	.remove		= bmc150_accel_remove,
 	.id_table	= bmc150_accel_id,
 };
-- 
2.37.2

