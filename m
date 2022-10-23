Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73EE60938A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJWNXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJWNX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA386F27A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qO-Vn; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-000ygi-7o; Sun, 23 Oct 2022 15:23:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-00A3R8-IW; Sun, 23 Oct 2022 15:23:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/23] iio: accel: dmard10: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:48 +0200
Message-Id: <20221023132302.911644-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6Nv7J0OqdrzQLyNHELbm+F+umy26zjOXMd6AGbdlM8E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9bbFj6NY03zboNKMevMl4mBFu7mQNaUBTsc2mi 0HEWItuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/WwAKCRDB/BR4rcrsCc2JB/ 93XL9Cl9MJ+oPhurVBHwYUqomveXVDhiX4I4nVl+fd9mELGhUG33x1iZTZ0zjM7GOOphyGW9qbGwIa PsEfzVGlvg1zf582Ey56xDbXr+3owXdgzc3eNo4pNqYCFCp+X26xF6/wbvv3P/4i0tayot2gaxxRvZ Tn0WGGTI4dRg4qG/Tae/L8VOBCq0xvDJQClq0b/ZnsrB6jzvnJoJdCsa7BR/P7w3wxocIZpSbbWvpi 3KHfyL/+vIdVpWsz5Sye2kU9hkto1Cp/EptFvhgpneI1cFEJxeq8EC/J4IOUZEgxgcuI2PjmHz7H8F WIage/3ri0Sci/845hBAnMj36qUV/H
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
 drivers/iio/accel/dmard10.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 8ac62ec0a04a..07e68aed8a13 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -175,8 +175,7 @@ static void dmard10_shutdown_cleanup(void *client)
 	dmard10_shutdown(client);
 }
 
-static int dmard10_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int dmard10_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -242,7 +241,7 @@ static struct i2c_driver dmard10_driver = {
 		.name = "dmard10",
 		.pm = pm_sleep_ptr(&dmard10_pm_ops),
 	},
-	.probe		= dmard10_probe,
+	.probe_new	= dmard10_probe,
 	.id_table	= dmard10_i2c_id,
 };
 
-- 
2.37.2

