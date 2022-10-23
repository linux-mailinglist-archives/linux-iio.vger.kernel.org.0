Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A2609390
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJWNXf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F56F56C
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawa-0006vp-JK; Sun, 23 Oct 2022 15:23:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-000yhO-Dn; Sun, 23 Oct 2022 15:23:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-00A3Ri-Dk; Sun, 23 Oct 2022 15:23:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 18/23] iio: accel: mxc4005: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:57 +0200
Message-Id: <20221023132302.911644-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Kz2hpwDyICoZsQNdqlmd+QKs2GlcWENpGtSotzVGTEs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+L4kpEQFPPrNP8YTaJB2X744SNyS1Wuh7ycJMe 3PG/lY+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/iwAKCRDB/BR4rcrsCbaaB/ 9qabwUrhAM8fgN1Veipz5RcA0Xgu2osEKG3ENTzBuBQ5FXV7LMhzm3CaVFFMTwC//8xRJt5Oe07UAR o+qqEjfVhk4imcuPTHr4iBB8lfQgC44piqH5mtbZJpdy2EaEW/JqRT9flz4cvMEQzX2Iwn2SUSDHzH no/jYhBVnk6zbDa/g5F5zkMBPS/EKG0LOcv9RykE9cKnromMCr38Num/JnWcHTCuOWBs0fKz5axZZf 2Yd9W1OBdTC0RYhVFQ6klft5NqMqOfsrj4mTSQ1GsEdvv4j7gMoaJEozY4tIwlSq32JA8GtT3GJWFZ 3q6xjEReQEUWjgcn73u5bGI+LbzSpq
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
 drivers/iio/accel/mxc4005.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index df600d2917c0..b146fc82738f 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -385,8 +385,7 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 	return 0;
 }
 
-static int mxc4005_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int mxc4005_probe(struct i2c_client *client)
 {
 	struct mxc4005_data *data;
 	struct iio_dev *indio_dev;
@@ -489,7 +488,7 @@ static struct i2c_driver mxc4005_driver = {
 		.name = MXC4005_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
 	},
-	.probe		= mxc4005_probe,
+	.probe_new	= mxc4005_probe,
 	.id_table	= mxc4005_id,
 };
 
-- 
2.37.2

