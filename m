Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791A85278AA
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiEOQAM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiEOQAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693315FDA
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001Db-NG; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGf0-002V3Q-81; Sun, 15 May 2022 17:59:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGex-009uGM-QC; Sun, 15 May 2022 17:59:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 8/8] iio:light:vcnl4035: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:29 +0200
Message-Id: <20220515155929.338656-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; h=from:subject; bh=QfcrT1ThkHTUpK9GPGoefXE9mnGpnAv0Bq36YG9gZO4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSNZZO2mjXLNh6fChHfUC3kW2m99IPlJ9AVseb31 /ai7I02JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjWQAKCRDB/BR4rcrsCS9IB/ 49AgtVjE9kledMmjOmQm+SZwZhsqJGm/I/yoABWQ2yrLnPqXBg+yFnWZoqBWiAAjqitCe2UnYnmXt3 3Wir8+xKjKW+d10rGRpe5uM3odwKpCsz/SlfEFTzxAEbQUTX6WwA1IsvChOf6RjdUH7GVTaJwEwa6t 2tnZdxi+kl5vNrH5HKAMrl5WeyU1saYJUNz+bBdsxa7o2snRv/SSc+JkjphMdYVMhJ84cq/M+/2hrK OuZ9h5at3o+QgVPl6VCPi9XWQpLCLtMBfnQV2n8a0GWmBHVeR1fcTmRurk1xlyJj55PhCUQ8z6+lDc /78WQt1FVGl6/HgYskj/XioZOfjSD2
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
 drivers/iio/light/vcnl4035.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index da2bf622a67b..2aaec6bef64c 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -604,14 +604,20 @@ static int vcnl4035_probe(struct i2c_client *client,
 static int vcnl4035_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	int ret;
 
 	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return vcnl4035_set_als_power_state(iio_priv(indio_dev),
-					VCNL4035_MODE_ALS_DISABLE);
+	ret = vcnl4035_set_als_power_state(iio_priv(indio_dev),
+					   VCNL4035_MODE_ALS_DISABLE);
+	if (ret)
+		dev_warn(&client->dev, "Failed to put device into standby (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 static int __maybe_unused vcnl4035_runtime_suspend(struct device *dev)
-- 
2.35.1

