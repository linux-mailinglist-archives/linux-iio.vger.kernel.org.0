Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B20609388
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJWNX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJWNX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3176F240
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qM-Vo; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-000ygb-2q; Sun, 23 Oct 2022 15:23:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-00A3R0-5w; Sun, 23 Oct 2022 15:23:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/23] iio: accel: dmard06: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:46 +0200
Message-Id: <20221023132302.911644-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+4i03y1bOf5kLI4Gr3ydWtojkzOgNa34s+opu7prNmg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9VEZQ78l6aPSNGCv3/NPbR6CHM3v32M9WtQJTE PJljOc2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/VQAKCRDB/BR4rcrsCbsZB/ 4yYYyZf0YgMcFboDXTbWN5Xxj9ed3hBZP9ykAZMtS8V1OzucmyZ59B8x4FtRuvSoQ7nbFioG/NJOB/ KJq2cAOwoI4DIEwpdjIm6Q1wJxsSUluHvRsFn9Q2izIjI5j01q6z8c6xVCRIOswWtxf6Tp+Rp/Z4mU ZZtNPzqzlgjXHIz2+gK1zniNTVlZmQdxRZHtq5qDU3aDAA4PVWjgc/cbosg7mNlV0aiXukKp6VB+SN +9YjBfaIVMkjx3tp2fET/bnyGA/g9rFahq233jfUgg+nhgaItDgoEareFhujnEN2YsPyhNxS5oWJUU hSqIHfH/O6atYr9CFuW1DKLs1RCQsd
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
 drivers/iio/accel/dmard06.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 4b69c8530f5e..7390509aaac0 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -125,8 +125,7 @@ static const struct iio_info dmard06_info = {
 	.read_raw	= dmard06_read_raw,
 };
 
-static int dmard06_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int dmard06_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -218,7 +217,7 @@ static const struct of_device_id dmard06_of_match[] = {
 MODULE_DEVICE_TABLE(of, dmard06_of_match);
 
 static struct i2c_driver dmard06_driver = {
-	.probe = dmard06_probe,
+	.probe_new = dmard06_probe,
 	.id_table = dmard06_id,
 	.driver = {
 		.name = DMARD06_DRV_NAME,
-- 
2.37.2

