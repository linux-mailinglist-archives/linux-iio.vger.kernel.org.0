Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5BC5278A6
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiEOQAM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiEOQAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2515FDF
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001DQ-2v; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGey-002V34-HI; Sun, 15 May 2022 17:59:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGew-009uFy-7x; Sun, 15 May 2022 17:59:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/8] iio:adc:ti-ads1015: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:23 +0200
Message-Id: <20220515155929.338656-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; h=from:subject; bh=ak8Y8sq731dMELFQ5nkm9vBb7hyEAU85OD6bWIqdHtk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSMrWdSfl8gOwknD1ulfe1h5uDp4f/IOeEwFRNQz SnSDFzqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjKwAKCRDB/BR4rcrsCRelCA CMnjeh4kxr3sPiG5G5wfEj1A9oLCiHzPzrSSaNbkZ1q2MkOVMgsluHIJFjxAvXDNZXlwJuNYOTQtqq 8uO7Nl3jwuG56C2fZGVWY1rrQZYprTfG8WAkOfxYJgBmVum8b+xbXpuWCC5ZFoy32Vod3kvvpPmCb1 cpXE2HzpnqhXObhioYvaF9f5cGiatKGRRDDNZHBap+kL7hEqDOaoLU6BEiDvvAf0Xu5lBpMsvnYbJD YkML/yuTMWnECjhgK5qyXnkgPlgyOL8oh9zhT8lLng6mpQaCDYpiWDDTa2ViIEZ2px7p+8trUdMf4t wr+GQ0RtdkgfWWRpUCzOTWmgt5sDmG
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
 drivers/iio/adc/ti-ads1015.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 068efbce1710..f8021d99db64 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1061,6 +1061,7 @@ static int ads1015_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 
@@ -1068,7 +1069,12 @@ static int ads1015_remove(struct i2c_client *client)
 	pm_runtime_set_suspended(&client->dev);
 
 	/* power down single shot mode */
-	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	if (ret)
+		dev_warn(&client->dev, "Failed to power down (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
-- 
2.35.1

