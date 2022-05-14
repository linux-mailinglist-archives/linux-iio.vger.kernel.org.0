Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685D452711F
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiENNFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiENNFP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 09:05:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597BC7675
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 06:05:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprSE-0002IR-UY; Sat, 14 May 2022 15:05:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprSD-002HSD-Rh; Sat, 14 May 2022 15:05:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nprSB-009frf-Ob; Sat, 14 May 2022 15:05:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] io:health:afe4404: Remove duplicated error reporting in .remove()
Date:   Sat, 14 May 2022 15:04:32 +0200
Message-Id: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; h=from:subject; bh=EK4yR+2Dc91Z9U/lz8fikR/YQbhM/aJ4riTXORcqm9Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBif6jceQ1Sz+Oz6W5eD94vt0JJUILtj+MYWC2zdic7 ZZX9a2OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYn+o3AAKCRDB/BR4rcrsCSQuB/ oD9oLgd6mZQPyfTEMFngAhERxr2vocUk5jKucHUNk8FtE02Apd9YZEyI0KAJ2B/Dbj9AztcOe+i6se NEqQRZUUFQ3w8qs8Fy0twjnny9WYNYUv2+fsZkxil9sCSypZwDMDRy1E05JSeD/GIkn96kBWtnVQVC bSt+bluPAyINz5siEHZrTfDO53Hq+TGWO/8+WGXVWCQyC2efj7yEP6hnyz37kn0J3FyHetDL5mNtXT JedygODJvgcyndv/GyHQCfj80fU7re3vJkz7XcbriQkQ5wPyAfIUSpTd2bO33TVbwk8vyJXATgsn+F AyZscfXWtY5sgNwsWwEs03UOCpj1sv
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

Returning an error value in an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference.

As afe4404_remove() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is similar to the patches I sent recently.
(https://lore.kernel.org/linux-iio/20220430081607.15078-1-u.kleine-koenig@pengutronix.de/)
Just missed this driver when I intended to address this problem type for
all of drivers/iio/.

Best regards
Uwe

 drivers/iio/health/afe4404.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index aa9311e1e655..1bb7de60f8ca 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -591,10 +591,8 @@ static int afe4404_remove(struct i2c_client *client)
 		iio_trigger_unregister(afe->trig);
 
 	ret = regulator_disable(afe->regulator);
-	if (ret) {
+	if (ret)
 		dev_err(afe->dev, "Unable to disable regulator\n");
-		return ret;
-	}
 
 	return 0;
 }

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

