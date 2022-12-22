Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F810654367
	for <lists+linux-iio@lfdr.de>; Thu, 22 Dec 2022 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLVOyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Dec 2022 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLVOyu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Dec 2022 09:54:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9D1C137
        for <linux-iio@vger.kernel.org>; Thu, 22 Dec 2022 06:54:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8My1-0001dk-Bk; Thu, 22 Dec 2022 15:54:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8Mxz-0011ve-VK; Thu, 22 Dec 2022 15:54:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8Mxz-0078tN-0a; Thu, 22 Dec 2022 15:54:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        kernel@pengutronix.de
Subject: [PATCH] iio: light: max44009: Convert to i2c's .probe_new()
Date:   Thu, 22 Dec 2022 15:54:29 +0100
Message-Id: <20221222145429.614781-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AiFCehDj/tWOvOrCLzilJ+VcTmJHRmPvTx6ZJhirWI8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjpG+hqJnEJRQKfnGBgYQJGwQsc+m3nsHfPQe4eNOI FloQnFOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY6RvoQAKCRDB/BR4rcrsCYndB/ 4nBdqZ1FGL/qYh8fP1Qb0MLxDmizK76JdY6j3BAczqgu2iz6V5tFIjcTQoGe9hPzm3nZZsTVM6gfpg ml+NQtBuWDdh5smoMPCP6kjk0ednbBTJ9qGq0jNNLFMHh7vBbvgV1qJ57STYlOmT4wfjeZa2y/z/dc dKErgpQsQPoMEoKO5DCjvCREKsmrFQhvXE7pmir8G16u8Cqtwr3Oyn+00jvBuEbLsR2azsd3YpE/jp 7tLiv1ZdZXfP38NeDjmvbzv6azY8xd0gHpwgGhL1bairOWauMPvfG273lstMPF32Ah2Vzv2t/AjK8t qmbGK4mwaSp5f7Kgr1AZrzSCK0QGSY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The probe function doesn't make use of the i2c_device_id * parameter so
it can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

since the series that mass converted drivers to probe_new this driver
was added with the old probe prototype. Fix is accordingly.

Best regards
Uwe

 drivers/iio/light/max44009.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496..3dadace09fe2 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -487,8 +487,7 @@ static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
 	return IRQ_NONE;
 }
 
-static int max44009_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int max44009_probe(struct i2c_client *client)
 {
 	struct max44009_data *data;
 	struct iio_dev *indio_dev;
@@ -538,7 +537,7 @@ static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
 	},
-	.probe = max44009_probe,
+	.probe_new = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);

base-commit: 9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
-- 
2.38.1

