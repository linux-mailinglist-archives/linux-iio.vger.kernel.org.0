Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3F515B67
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbiD3ITr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiD3ITp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8369CD1
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0001IM-Is; Sat, 30 Apr 2022 10:16:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0066Y7-On; Sat, 30 Apr 2022 10:16:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGy-006ayk-NQ; Sat, 30 Apr 2022 10:16:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/9] iio:accel:stk8ba50: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:01 +0200
Message-Id: <20220430081607.15078-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; h=from:subject; bh=Ek48z4TMAclDv0XMQ3lqjoa1O7GUUH+sC06Xit9z5Mw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPAqDUb26gNoWLx2CLATlpwOiwuprhXcOvKCf1yC t6ABJWiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwKgAKCRDB/BR4rcrsCadyB/ sFkCrRfNTqj1pD8g4uqaTcyJQ6mvdRskktimz5FFGmo57/rZTomuYzj2kMBS36852e/sPUZdsj+whj KudoH5MKMDhFd2TRHzuNYkJm9yN8JXn46rCIcuuTNxEjFrzt16m6pLYiRSlwheOnh0eLfQjHDRuQS8 FoOmmp7IJRAxDN11XfkVXNkhIbWNBv0CJ/xrrpJ8TvdlDTuWpeHimDmrszGsMpKXA5Nxj6iTpld6uQ osi0dcBVadVha+Y96xbfPB+owX0M0e9qQA1AgTbZ0gj1RTGWciZmB0zcL54oKCmSdMdmB/5pEF1xIp 34CLqu2fJy6RoklvRwGT8cbQ6a3Tjo
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

As stk8ba50_set_mode() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/stk8ba50.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 0067ec5cbae8..7d59efb41e22 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -501,7 +501,9 @@ static int stk8ba50_remove(struct i2c_client *client)
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
 
-	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+
+	return 0;
 }
 
 static int stk8ba50_suspend(struct device *dev)
-- 
2.35.1

