Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273F60939D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJWNXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJWNXj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3BA6FC51
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawd-0006rX-1X; Sun, 23 Oct 2022 15:23:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-000ygs-3M; Sun, 23 Oct 2022 15:23:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-00A3RK-4Y; Sun, 23 Oct 2022 15:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/23] iio: accel: mc3230: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:51 +0200
Message-Id: <20221023132302.911644-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dT17HSfsKIwmgupLWarOdfzGSzchGhnysPukyKfnRoA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9lab4pUFVrcqgGYklYdIkGLWjCO9o0BOkDltsK /P3h1gmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/ZQAKCRDB/BR4rcrsCdh7CA CaZeVGbMGdnlGO8dSoLeby35mNExPMAlJYlkvHvdySGZscwFWHrUKGLb0ZqOHTemyWNOU4gc3HjfzW vq1DnbgFy9l2UDNxDsiQK0rnC5S83jmBHwKksVwxnbRD5x1RCb6wbj0+UA1J7d82V+8iMFznEWED72 EJ9I7GOzPcENH0qvPwpkMeCrqKAfsHelDfXDNFK3Y2czY1eR76hyKU81BDXkk9EBWe70N43QDXtV86 QUKANvFLaFaCLX2VIYcw9GvQgAzH3cugBo1VCdK3NMwjF1sDIbZKSKW9kTgJoDrQkl7pmH4b+U6wwN 7vlgHn17oHWtiW9CqxYQ/g4xnCf8Kd
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
 drivers/iio/accel/mc3230.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 2462000e0519..efc21871de42 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -106,8 +106,7 @@ static const struct iio_info mc3230_info = {
 	.read_raw	= mc3230_read_raw,
 };
 
-static int mc3230_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int mc3230_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -191,7 +190,7 @@ static struct i2c_driver mc3230_driver = {
 		.name = "mc3230",
 		.pm = pm_sleep_ptr(&mc3230_pm_ops),
 	},
-	.probe		= mc3230_probe,
+	.probe_new	= mc3230_probe,
 	.remove		= mc3230_remove,
 	.id_table	= mc3230_i2c_id,
 };
-- 
2.37.2

