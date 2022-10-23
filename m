Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA160938F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJWNXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1C6F562
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-0006qN-IL; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-000yge-4B; Sun, 23 Oct 2022 15:23:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-00A3R4-C7; Sun, 23 Oct 2022 15:23:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/23] iio: accel: dmard09: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:47 +0200
Message-Id: <20221023132302.911644-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uvFvi615xvhp1lwh884R/Mulpt4zvhwe4O3mxXE+y7o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9YNGxnKgX6tWvghBcWa/rua5wXPGBlZqyrPqy0 u6vXvXOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/WAAKCRDB/BR4rcrsCfbTB/ wMFNGPytUrkAWa4fGpvuxfA6gIAsujQzLKNmzhkwwkTlb8yDoTxCUaRx81Pa77CzS+B2/6icwNpvaF WlnER7mSBuxUGyUwVtBXXuO48OYTukCN3KHwPwB/pQLW0tDOZOfeUurpkt8m37tRLVIAISRaMglwSx 31UCBUcgjM+8XE9uwi5jHJ3bxYgYXuAaNw1TI4g3Y5dVvch0SnfWvWzKu+CyNRm0yxq968U7EPcYtC lpR4uwYSiN5EpcHeW7GwpLeuHKX+INCcT01j0KKmF3B4qzzxvRIDHJYtWux1IgWdGNHFkfy8+5q2Ri aDoyiRN28MZ612YQkzL0F9oigZCvqK
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
 drivers/iio/accel/dmard09.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index cb0246ca72f3..4b7a537f617d 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -88,8 +88,7 @@ static const struct iio_info dmard09_info = {
 	.read_raw	= dmard09_read_raw,
 };
 
-static int dmard09_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int dmard09_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -136,7 +135,7 @@ static struct i2c_driver dmard09_driver = {
 	.driver = {
 		.name = DMARD09_DRV_NAME
 	},
-	.probe = dmard09_probe,
+	.probe_new = dmard09_probe,
 	.id_table = dmard09_id,
 };
 
-- 
2.37.2

