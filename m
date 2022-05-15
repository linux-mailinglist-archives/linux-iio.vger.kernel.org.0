Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E65278A9
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiEOQAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEOQAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62315FDE
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001DT-2u; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-002V3G-AD; Sun, 15 May 2022 17:59:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGex-009uGA-5c; Sun, 15 May 2022 17:59:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 5/8] iio:light:pa12203001: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:26 +0200
Message-Id: <20220515155929.338656-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; h=from:subject; bh=6dBOIS62JAJeYZsnqVdR5KwvKbER3ILLZ/8yd+koxlw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSNF260Q6GAvjzZ19T/ADa2CyAfHeT+Gmqvb+c7a 9ZyOLqmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjRQAKCRDB/BR4rcrsCZ1lB/ 4ugH3RAUlXmQoWi1FnI28q6X1dN+xW/ALbWj3mo0PiwuF4JuttdMVvYfOR6/y0v1fyDkhg3qe6tyC7 NCtDiVHbucdyQ+s8CEbHT7PiTOwh+554Le8LsGuIdKkrW6eAPUvmJs2l4FPci5WqaBi8jQMAOY/xO+ ALFOFVkjpKLC8VCQYnKRY07cG13HsuuiOZLmEdoHPRryy38FvLVNWdLIme3jw06piBgvAXudDaKtVN 8i+/OSMv0p3p11oNZr5iDTtxNs0z8F4bU3iFB9gtxT75jCfh6jM7OEm1mbEF3z5TIiUkMUv/LkT2li 8jGg2LFgFWNpQFXSbJoSaMEWhoO/zs
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
 drivers/iio/light/pa12203001.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 528fa5dd2b13..772874e707ae 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -397,13 +397,19 @@ static int pa12203001_probe(struct i2c_client *client,
 static int pa12203001_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
+	ret = pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
+	if (ret)
+		dev_warn(&client->dev, "Failed to power down (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
-- 
2.35.1

