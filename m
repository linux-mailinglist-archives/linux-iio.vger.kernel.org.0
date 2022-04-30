Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7674D515B68
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiD3ITs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbiD3ITq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3D69CCD
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH3-0001Iw-1l; Sat, 30 Apr 2022 10:16:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH2-0066YY-5d; Sat, 30 Apr 2022 10:16:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGz-006az6-Oy; Sat, 30 Apr 2022 10:16:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Subject: [PATCH 9/9] iio:light:tsl2583: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:07 +0200
Message-Id: <20220430081607.15078-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; h=from:subject; bh=SOQeCVCK05+5ktyNKo67KJfuK9AYd8RWaj5Y3wRiGp8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPA+IJ0luLCvhor20larPoZEpXsXnl8qbhuDbPuH +NPBKvGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwPgAKCRDB/BR4rcrsCXbYB/ 97RyI0+xF79G99uzLSJAWzajxQabHVNlGGZ9OYWqtUrV+9rIkv8cm2uK5iULaGLCEbpLzj8w8X0o3p wXq2uv7K+hEgvzZlD+Yb3rwFdddSN97Qv+u743iYWPuQD++p+QUXjvT5Y0uOOtb6sfxaEvjuDkbWU/ 4bCkDEwd57hLshzWkiFDk58EPsUiz3xeK+56fbLqN3CZI5bNHIESqphz5ucXALr3sr76iGRH3kmV82 ao1cEAjck3/Htf3IndK+0Q2tw7UuAOF6vYWy/nhVziEdEF104PYVlhv2IMPCt62GeVxF1aolM/WYyT BwijiRJ8wm08bUGHviqnmq5TUPlOCt
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

Returning an error value in an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference. The device goes away anyhow and the devm cleanups are
called.

As tsl2583_set_power_state() already emits an error message on failure
and the additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/tsl2583.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 7e101d5f72ee..efb3c13cfc87 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -883,7 +883,9 @@ static int tsl2583_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
+	tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
+
+	return 0;
 }
 
 static int __maybe_unused tsl2583_suspend(struct device *dev)
-- 
2.35.1

