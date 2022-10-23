Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D431A609392
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJWNXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJWNXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBA71726
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-000700-97; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawa-000yhc-0N; Sun, 23 Oct 2022 15:23:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-00A3Rq-Oz; Sun, 23 Oct 2022 15:23:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jean Delvare <jdelvare@suse.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 20/23] iio: accel: stk8312: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:59 +0200
Message-Id: <20221023132302.911644-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PM5/Dm1kk3LHWe/wcBSCpCscaBmSwFmVDkwGKTWOvGs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+TcbfQtmHVte2w/m+Bc3FsUb7w6uIhoUPVpK0U Q7uByraJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/kwAKCRDB/BR4rcrsCRe6CA CWUGy1/Tq3fuUZm3x1NlAjvieRH0fqKwMwppdqHCCKD6YhCFAdHHF2ttYPqq3scezWnZ9NzE9YoBFC fp/Q5cgqEzmMbpduV8NCPq0ZS36OOpH4Hh8E7OL2D9i2mFGn/ja0Fj6YltIlxdzYlEt0CuzFCi1SXm XZ1iZYFQwkqU+oH/SZo6XN0bRMflZxTkoOtUsYp7biGo07gdZkXpms8FP1INI+ZMhVcSqDb5xuhERN X+5KXTCPdLh4/02EnyH4SwNeiHJG88rdc6CIrUi8eI3hw/c3GGBZUFyl9lGko4FXc1Q/vbyLlOSRkY cFe4YgSshUv8hIVjOq+lj4uVcmVeEt
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
 drivers/iio/accel/stk8312.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 7b1d6fb692b3..68f680db7505 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -498,8 +498,7 @@ static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
 	.postdisable = stk8312_buffer_postdisable,
 };
 
-static int stk8312_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int stk8312_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -645,7 +644,7 @@ static struct i2c_driver stk8312_driver = {
 		.name = STK8312_DRIVER_NAME,
 		.pm = pm_sleep_ptr(&stk8312_pm_ops),
 	},
-	.probe =            stk8312_probe,
+	.probe_new =        stk8312_probe,
 	.remove =           stk8312_remove,
 	.id_table =         stk8312_i2c_id,
 };
-- 
2.37.2

