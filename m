Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521F4515B60
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiD3ITn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiD3ITm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FED569CCD
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH1-0001Io-Aq; Sat, 30 Apr 2022 10:16:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH2-0066YU-2i; Sat, 30 Apr 2022 10:16:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGz-006az3-JO; Sat, 30 Apr 2022 10:16:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org
Subject: [PATCH 8/9] iio:light:stk3310: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:06 +0200
Message-Id: <20220430081607.15078-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; h=from:subject; bh=jeBOu6GxzNpAZs1ilUmEmXXaU0A76NBDF02smFwACRA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPA75A9akx37Wc+zB3SKp1lYFAp8xs5vXqMygzlk pWTXHbOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwOwAKCRDB/BR4rcrsCfGZB/ wI60WGRkvHSINnWlN32hfNPkEVo7V6ZIE3JP6Xrd+Cq4MSrdWTYTrYXl1KvO8VEMtdHZHgz9YGfgMd l2WKvPAZ0usnGJvTPMGVfy9cI8drffQZbRAkhbg9c8zWEl3z7voRiDFpqUROGvT21EtpI16iJxw1F4 S3PZ3BYnW58OYbnotlv8gcSNilgAdWNRqM71Ehg+m1aAOkqRUn1j0z6iYIN6iN6pOhUs2i3InS/cJi iI6EszISVMccRbd89GJGTMM+hV+jRu/UqghrwKCD23H/7yRMGKiP2gyRKGlLXphVaYRZtaj8rR6wlI /Ur/YGozurSDvhm+92r+C7EevQ6eDI
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

As stk3310_set_state() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/stk3310.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 1d02dfbc29d1..95a98af08b8a 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -627,9 +627,12 @@ static int stk3310_probe(struct i2c_client *client,
 static int stk3310_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	int ret;
 
 	iio_device_unregister(indio_dev);
-	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
+	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
+
+	return 0;
 }
 
 static int stk3310_suspend(struct device *dev)
-- 
2.35.1

