Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331925278A3
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiEOQAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiEOQAH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB615FD1
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001DO-2v; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGex-002V2w-Vt; Sun, 15 May 2022 17:59:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGew-009uFv-0Z; Sun, 15 May 2022 17:59:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/8] iio:adc:ina2xx: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:22 +0200
Message-Id: <20220515155929.338656-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; h=from:subject; bh=eSoAuM+RqK9CmLa4IQtEe24MxktVn2AHwMkORW+3VUk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSMnVG5qTUKTzhEtT/KD8rGMbQUoRekEJ2WmyFOK BBCn8ByJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjJwAKCRDB/BR4rcrsCUO7B/ 9pPNJp395QnFzsMSUxNwNUw3ex0sfmbheVUOMz01FzhMantWtGoBCVtEwy9niZwybKtzp/1OmJnF4o TwOQAws0WS1dZOpxE+gJD+BDMCxG/GcB1FGS5DMqbxEWrsOT/l2uJTdOSouM7bFxxPvS4xC0G0KyDk y05UL39uQ3R+Y7k6jwtfmjFLUwbI2hVNSn382Q4fCXeJ/NGbbkJ0rZj0pb8RL9Qgtsvb5YC7CqomuM OsS1YVYjIpqjx8F8kqfEROk/Uwq8uRr1xlYuKB6eTh1ftUSLc4GG8d1nD8JRD0o1lT66k476xj4t93 Jtz1IuQ2DXaNOUBSh7g+uEy8BM9H7M
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
 drivers/iio/adc/ina2xx-adc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 8d902a32a0fd..2eafe98cff3e 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1039,12 +1039,18 @@ static int ina2xx_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 
 	/* Powerdown */
-	return regmap_update_bits(chip->regmap, INA2XX_CONFIG,
-				  INA2XX_MODE_MASK, 0);
+	ret = regmap_update_bits(chip->regmap, INA2XX_CONFIG,
+				 INA2XX_MODE_MASK, 0);
+	if (ret)
+		dev_warn(&client->dev, "Failed to power down device (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 static const struct i2c_device_id ina2xx_id[] = {
-- 
2.35.1

