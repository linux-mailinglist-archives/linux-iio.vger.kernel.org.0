Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43FB5278A8
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiEOQAO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiEOQAO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A215FE7
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGf2-0001DV-Qy; Sun, 15 May 2022 18:00:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-002V3N-Nf; Sun, 15 May 2022 17:59:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGex-009uGJ-J9; Sun, 15 May 2022 17:59:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 7/8] iio:light:vcnl4000: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:28 +0200
Message-Id: <20220515155929.338656-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; h=from:subject; bh=LYLLH8JHqpkhqapmKf7rt6zhz2W7TsS502lsRZkueuo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSNWoMG644npi0Op5gIN2hULvPgPg7ozXF0tmkYm qG2G83qJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjVgAKCRDB/BR4rcrsCdBxCA Cc7Rks0scPlOox7Kje4FCCwnp0NXaiurl4lfOYcojj8CqyLX7kWRTVPROFAMe8FlAaAdaizBemY6xl H8PSzXKAqJM+qRfbCuEg/IEzzocWNX+19mdwI93ZMpqcZqhYtvI1+HqeKbHWM93Z2YGqMutXX5ElTc HXolAYYaWPxgIh2K1GHt3IoAxd8/cpuJdL0AcybLQon1P7Zx0pcV266Q5M+u1dmLRV8GxQSqDRL3gL dAZ38gIABXOV27lQHlgg8xP0gHzSU+l5VCnHJ8tjduyav7oKirlgUUGh6JKD4jQapto1wzqVLHMM7T 0GvGJg0gTVGmnQJatJZ5bN1tXbaU6q
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
 drivers/iio/light/vcnl4000.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e02e92bc2928..947a41b86173 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1115,13 +1115,19 @@ static int vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
 
 	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return data->chip_spec->set_power_state(data, false);
+	ret = data->chip_spec->set_power_state(data, false);
+	if (ret)
+		dev_warn(&client->dev, "Failed to power down (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
-- 
2.35.1

