Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F11609399
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJWNXk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJWNXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D786FA04
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawd-0006rm-1W; Sun, 23 Oct 2022 15:23:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-000yhB-K7; Sun, 23 Oct 2022 15:23:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-00A3RQ-AU; Sun, 23 Oct 2022 15:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/23] iio: accel: mma7455: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:52 +0200
Message-Id: <20221023132302.911644-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6AZK09z5aZbKSiicqPfRwz2zib92fXlB3DHpRQg0zzg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9paC8w1zjzusj2KpheVQfoNr2ycOMpyczWIwfh rvr6ZEmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/aQAKCRDB/BR4rcrsCXg+B/ 998ppriBIjg5xgd7F0aAUr3jSgGBLWpYmGjPs9K+RmWlOCxtViPKrLd+oJ+C14/SL1xnYsEyysCdvK BmQJLv+Xbt94h9W+48v604k7grc2dRXYrxv09F0H3YSt/XySFH21+nKef0gqKx7VmcdGGKGrwJMS3Y qU6WTEQDgRx6tfhHtERGt7yzPFs2qC2QhFrtPi0FycomgQ0OFx+mAPbvCDOqcdt+bfxHGIytcKzeML 4dMi0i9fho6nPQf9NzpkZLdQ7cFai0TeInhYZaEIVkp1ACS9cg8bwF8UXzRU+wQJkNyYMT2HMkaSTm Iafs+uEtMGQOgvZxQyfNf8jNBMiR8v
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
Alternatively it would be possible to just pass i2c->name to
mma7455_core_probe(). That's a simpler patch but that changes things
in case id == NULL, so I didn't do that here even though it might be
considered an improvement.
---
 drivers/iio/accel/mma7455_i2c.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index c63b321b01cd..9518bd81f9e5 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -10,9 +10,16 @@
 
 #include "mma7455.h"
 
-static int mma7455_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id mma7455_i2c_ids[] = {
+	{ "mma7455", 0 },
+	{ "mma7456", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
+
+static int mma7455_i2c_probe(struct i2c_client *i2c)
 {
+	const struct i2c_device_id *id = i2c_match_id(mma7455_i2c_ids, i2c);
 	struct regmap *regmap;
 	const char *name = NULL;
 
@@ -31,13 +38,6 @@ static void mma7455_i2c_remove(struct i2c_client *i2c)
 	mma7455_core_remove(&i2c->dev);
 }
 
-static const struct i2c_device_id mma7455_i2c_ids[] = {
-	{ "mma7455", 0 },
-	{ "mma7456", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
-
 static const struct of_device_id mma7455_of_match[] = {
 	{ .compatible = "fsl,mma7455" },
 	{ .compatible = "fsl,mma7456" },
@@ -46,7 +46,7 @@ static const struct of_device_id mma7455_of_match[] = {
 MODULE_DEVICE_TABLE(of, mma7455_of_match);
 
 static struct i2c_driver mma7455_i2c_driver = {
-	.probe = mma7455_i2c_probe,
+	.probe_new = mma7455_i2c_probe,
 	.remove = mma7455_i2c_remove,
 	.id_table = mma7455_i2c_ids,
 	.driver = {
-- 
2.37.2

