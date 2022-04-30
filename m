Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7955515B66
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiD3ITo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiD3ITn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E1A69CD4
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH2-0001IW-5b; Sat, 30 Apr 2022 10:16:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH1-0066YQ-I8; Sat, 30 Apr 2022 10:16:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGz-006ayz-DE; Sat, 30 Apr 2022 10:16:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jiri Valek - 2N <valek@2n.cz>, linux-iio@vger.kernel.org
Subject: [PATCH 7/9] iio:light:opt3001: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:16:05 +0200
Message-Id: <20220430081607.15078-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; h=from:subject; bh=jp68kHvZVFA2TNSPUEwZBFrkdizumMvUxTX4vs3LMPY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPA3XEYgcEdOH3hFJPfhziFE9ibHXhrBoplB/B62 UnpAw9mJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwNwAKCRDB/BR4rcrsCbzAB/ oCBVUfuGx1AGLQe/VaFs/eqyOecr+Q+5F13WGkhCUk4yVp1ePMGuqSBKirbQ7eXMJxuifuDEZLOJy4 l1WgwogNUS2FMLHnoMl1oPxNuA1TzKZcZ+vDVyuyeN+5Zr6cmp0moDV97n9F+Nhz6SUmRSolgyjDqT 4HiJNilR5hayIwFMTNwOjYuZ0KgZvC/XmLJB584xUCCeF6BjPh+rs5TNSlEireteX15Ay5C6fj8QY3 wNJ1JNSF0Q5gNUeVgqTbOcz3f+kTBX8dtedLn7IgxxJm7kACi1JL0t96B63rKLodkZH/w4yXGnH18z 5O34wcTLd+2lVgqjRtT8Kw5EZ5IaDG
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

As opt3001_remove() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/opt3001.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 1880bd5bb258..a326d47afc9b 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -808,7 +808,7 @@ static int opt3001_remove(struct i2c_client *client)
 	if (ret < 0) {
 		dev_err(opt->dev, "failed to read register %02x\n",
 				OPT3001_CONFIGURATION);
-		return ret;
+		return 0;
 	}
 
 	reg = ret;
@@ -819,7 +819,6 @@ static int opt3001_remove(struct i2c_client *client)
 	if (ret < 0) {
 		dev_err(opt->dev, "failed to write register %02x\n",
 				OPT3001_CONFIGURATION);
-		return ret;
 	}
 
 	return 0;
-- 
2.35.1

