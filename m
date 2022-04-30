Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C31515B62
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiD3ITn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiD3ITm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984F69CC4
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0001IR-L7; Sat, 30 Apr 2022 10:16:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH1-0066YK-BK; Sat, 30 Apr 2022 10:16:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGz-006ayq-2U; Sat, 30 Apr 2022 10:16:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 5/9] iio:light:isl29028: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:03 +0200
Message-Id: <20220430081607.15078-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; h=from:subject; bh=ledxJqETrx+gIzE0JloH+QkMnJ1iTPyNpj82jtf8+/o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPAxBDQg/jCs0qzucfGYzTI+H58+5SpbF+FKB50F 4/20VMuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwMQAKCRDB/BR4rcrsCQjCB/ 9SiZiawoDWSqz7355F2+oJot6BIhmPSHXWVw7t93eVTWuSxSRiwu2H0Uin9xrzv0c/F9K8dGp/WRvP 0ekX2SVaASKEmibNsqqCKwTSREJpFBshs5p/9frIQyl+ZPW02yTfc/8KaNJQQW3DW+sfM1QvB7YYUR lHbsAEAr4moInXQCh5KIntI42BmZmaIdMjjuKPPYtvVSzav+l+iRhlv7a0nLUUkqqhWSzn7FzFqV4x 427CO6AoNC1WAb+hLuSJ0/o0yJ3vVXAaY2BiEueGtRpZK+AbqXVBDPwncbkvUXd7lCwTYsrpglQzgZ I1uw3g588iXAsuivVB+IK8VoLq1f1R
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

As isl29028_clear_configure_ret() already emits an error message on
failure and the additional error message by the i2c core doesn't add any
useful information, change the return value to zero to suppress this
message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/isl29028.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 9de3262aa688..720fa83d44e0 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -646,7 +646,9 @@ static int isl29028_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return isl29028_clear_configure_reg(chip);
+	isl29028_clear_configure_reg(chip);
+
+	return 0;
 }
 
 static int __maybe_unused isl29028_suspend(struct device *dev)
-- 
2.35.1

