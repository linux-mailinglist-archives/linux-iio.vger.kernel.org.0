Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D55278A4
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiEOQAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiEOQAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E115FD9
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001DU-2w; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-002V3I-B3; Sun, 15 May 2022 17:59:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGex-009uGE-DI; Sun, 15 May 2022 17:59:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 6/8] iio:light:us5182d: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:27 +0200
Message-Id: <20220515155929.338656-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; h=from:subject; bh=L6jC/LjutKKO276LY8apTidLyjyXQqJ4c1JIhDFeOuQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSNNqsME04vvQcWyAMSzrOMYHWjIdxKPXY+4ICde wg6337CJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjTQAKCRDB/BR4rcrsCbQtCA CD0EpZ2yn0hf6oh+yNbkXl26SaMNd6j2ixN2R8kFH4Us2h69e08c2iMpP9KGZPqDtPNnCR9cszSBBA doh02C72A5viPz/uGw3r3tYaJw8TEiI+qoNIvth4d8Re5gZn+lmf09zYEaE9j/xcYVaMswQof79BY1 GYYWAYGcUl1NxiYtFncAs/vMIxvHDUOAK/FcIRic/b/bMezVZ2omc3u8cC4Xwy1votV80Xtm6hN+gw D+d/rhFlpR+otP7zSty/FzkIs5u7O1ykWNlkI3sKDzu5Vr94L5x7/FkMcfArLN2DQYSHkKFzou3xQA yp9g5FhHaad+GZlk9blV0qBT76Dqiv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Returning an error value in an i2c remove callback results in a generic
error message being emitted by the i2c core, but otherwise it doesn't
make a difference. The device goes away anyhow and the devm cleanups are
called.

So instead of triggering the generic i2c error message, emit a more
helpful message if a problem occurs and return 0 to suppress the generic
message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/us5182d.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 1492aaf8d84c..cbd9978540fa 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -907,13 +907,19 @@ static int us5182d_probe(struct i2c_client *client,
 static int us5182d_remove(struct i2c_client *client)
 {
 	struct us5182d_data *data = iio_priv(i2c_get_clientdata(client));
+	int ret;
 
 	iio_device_unregister(i2c_get_clientdata(client));
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
+	ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
+	if (ret)
+		dev_warn(&client->dev, "Failed to shut down (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
-- 
2.35.1

