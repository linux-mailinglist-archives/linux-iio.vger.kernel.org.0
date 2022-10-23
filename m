Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177960938E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiJWNXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A66F27A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-0006s1-Tf; Sun, 23 Oct 2022 15:23:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-000yhH-0B; Sun, 23 Oct 2022 15:23:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-00A3RW-Ps; Sun, 23 Oct 2022 15:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Haibo Chen <haibo.chen@nxp.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 15/23] iio: accel: mma8452: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:54 +0200
Message-Id: <20221023132302.911644-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bWa3Ctf92eeJrieS4pWQzl57MTSahKKbQ+jv4KxAgLw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9vDh5q13U3eGd/jKd3TXMZ7W4nc5ok9lq4HCPn a1GKUWmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/bwAKCRDB/BR4rcrsCeNUB/ 40a0cCFILp7e3AmexftzQNvnjaNXM/ExAeDAl0mqoZBKsoETShPldsHurTphAI1Vu7m1Eos3nXMmTr ovccbttx9bXQ0cTr8uEF3Cxzo4J2PvdHHwG3fus7NSghzZ5SfAobkmAYfblePbxZZ0+nN2s+x6vNsw qfoiN4Dnxn+FWTtS/fKMHYNVbNZCXMvhGalqj757Z3uOfjkjYqdZiycTr8YXx5pVJpD0IQ5ptJjdc3 GUJORQ/q0LA2kneYkdsSlHsxPzxA7jA34hZLAGTSzVL5UUPv2vHuik+XWKboJNXzhWW7OvaPf0eJjy JaULv/hSijeKIkrVtiGbI4l73qg8h7
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
 drivers/iio/accel/mma8452.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3ba28c2ff68a..2ce13c051363 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1545,8 +1545,18 @@ static const struct of_device_id mma8452_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
 
-static int mma8452_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static const struct i2c_device_id mma8452_id[] = {
+	{ "mma8451", mma8451 },
+	{ "mma8452", mma8452 },
+	{ "mma8453", mma8453 },
+	{ "mma8652", mma8652 },
+	{ "mma8653", mma8653 },
+	{ "fxls8471", fxls8471 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mma8452_id);
+
+static int mma8452_probe(struct i2c_client *client)
 {
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
@@ -1562,6 +1572,7 @@ static int mma8452_probe(struct i2c_client *client,
 
 	data->chip_info = device_get_match_data(&client->dev);
 	if (!data->chip_info) {
+		const struct i2c_device_id *id = i2c_match_id(mma8452_id, client);
 		if (id) {
 			data->chip_info = &mma_chip_info_table[id->driver_data];
 		} else {
@@ -1829,24 +1840,13 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 			   mma8452_runtime_resume, NULL)
 };
 
-static const struct i2c_device_id mma8452_id[] = {
-	{ "mma8451", mma8451 },
-	{ "mma8452", mma8452 },
-	{ "mma8453", mma8453 },
-	{ "mma8652", mma8652 },
-	{ "mma8653", mma8653 },
-	{ "fxls8471", fxls8471 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mma8452_id);
-
 static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
 		.pm	= &mma8452_pm_ops,
 	},
-	.probe = mma8452_probe,
+	.probe_new = mma8452_probe,
 	.remove = mma8452_remove,
 	.id_table = mma8452_id,
 };
-- 
2.37.2

