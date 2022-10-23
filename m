Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5A609389
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJWNX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJWNX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F336FA04
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-00070y-Gk; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawa-000yhj-9g; Sun, 23 Oct 2022 15:23:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-00A3Rx-6I; Sun, 23 Oct 2022 15:23:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 22/23] iio: accel: st_magn: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:23:01 +0200
Message-Id: <20221023132302.911644-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bzEQORsV7CC8iq735P333ifpo8EwBAep5rQS6r3vJy4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+aGWOillPaMKPZlK6RuIR3iOqfQUoVexsfRg4P 7SWV39KJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/mgAKCRDB/BR4rcrsCelNB/ 95Z2PFFFsHU8IR4uT4upY7UPd42/sB01eRxCgTwkuUkWmtmKfKTR1p7udH7MQn0I6/036Yxeez8xtW m6r7T/D6NXSAIwRECqb5J0qsgx4rA2efCT6GCNAn1PKz9lIPwuol6km6I1qImiJ079ieGTqKnawSwO MquKfJ8/2FKopP/ImdqQmR5BohbBsa5CRJGdMT1seHK1opwMQ00qpIo+wt9nXkDCq3di10J5JXmEzs FjxFmVG9CRjwrKfrz2I7M50nUdjthN5HBEaflAaj7TYlobmhxnuZIpf7trqzq9yYLVvFL3UH76KUBt /5I9elgWxV7tA76y9aD1OQfQfghAKd
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
 drivers/iio/magnetometer/st_magn_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index c5d8c303db4e..b4098d3b3813 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -54,8 +54,7 @@ static const struct of_device_id st_magn_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
 
-static int st_magn_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int st_magn_i2c_probe(struct i2c_client *client)
 {
 	const struct st_sensor_settings *settings;
 	struct st_sensor_data *mdata;
@@ -107,7 +106,7 @@ static struct i2c_driver st_magn_driver = {
 		.name = "st-magn-i2c",
 		.of_match_table = st_magn_of_match,
 	},
-	.probe = st_magn_i2c_probe,
+	.probe_new = st_magn_i2c_probe,
 	.id_table = st_magn_id_table,
 };
 module_i2c_driver(st_magn_driver);
-- 
2.37.2

