Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92D515B64
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiD3ITq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiD3ITo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893169CCD
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0001IO-Iu; Sat, 30 Apr 2022 10:16:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH1-0066YF-62; Sat, 30 Apr 2022 10:16:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGy-006ayn-Sr; Sat, 30 Apr 2022 10:16:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/9] iio:light:bh1780: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:02 +0200
Message-Id: <20220430081607.15078-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; h=from:subject; bh=pmZI+SKvg18J6ZIUxTXLriEEylgoCbEw4pJUSaBp42g=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPAu9CFP8UYkDGdbT7chw+zqiuCalplcjmty+fAg mWcg8SGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwLgAKCRDB/BR4rcrsCWBfB/ wMXoVKCIQ5gcDWnCjw2wdyXl0ZtR5gHJXjezGw8PrWb2bIiNuAuqr71dTy0YgZHs9aqwd8cmfwylBw ZbS+Nn159F4R4OfSrjJFiM4r0R8E0VDca9L8Am+duzYAbcjp0InYhM1aAqwqwXDvcUrXkmOk2ItaRK yDOkVPlPpalVYWg4BzuWCosqNp5XLrrupt0EZ5uGMtBS7IN89a1fAG4vv5UpTdbsCxzNcdADdrapKj MB0suR85y7Ft6tfv2ShmFRLanA/N/626mOsU8KtdxpGwEuD8Jm4J1jfxVR7ZxXACKWM2/aY+eRcBHo bDhch1YJ9IBU7r9an20aBImDiFR+wU
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

As bh1780_remove() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.
While at it, add the error code to the remaining error message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/bh1780.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 790d3d613979..fc7141390117 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -213,10 +213,9 @@ static int bh1780_remove(struct i2c_client *client)
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to power off\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_err(&client->dev, "failed to power off (%pe)\n",
+			ERR_PTR(ret));
 
 	return 0;
 }
-- 
2.35.1

