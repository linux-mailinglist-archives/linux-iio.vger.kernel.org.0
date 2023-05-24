Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8470F9E7
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjEXPRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjEXPRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 11:17:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD01A9
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2023 08:17:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEP-0005ax-P8; Wed, 24 May 2023 17:16:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEO-002W9Q-7f; Wed, 24 May 2023 17:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEN-007b3a-9z; Wed, 24 May 2023 17:16:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de
Subject: [PATCH v2 1/5] staging: iio: Switch i2c drivers back to use .probe()
Date:   Wed, 24 May 2023 17:16:42 +0200
Message-Id: <20230524151646.486847-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524151646.486847-1-u.kleine-koenig@pengutronix.de>
References: <20230524151646.486847-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Gwu+Mh0DhEZ7ybQIRlPUcRglEwC5T2tpje3jqRxKjEs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbipWFMqMrKLOElp8Drclyk3lKg0aUJPv4qmKU b+zVfKr23eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4qVgAKCRCPgPtYfRL+ TkFcB/oDWLdLuEZ3eLrCQFWnUv9xFDYU8NfeHyCXokpoZJ8p8r9YICFBgUGH5GuiMtw36gCXET/ aOCeJfteHZkNthi3bLueVXcG5JE38kYBy5YRGkrW30EikLDRoConsUfHtFKuUfgZ6oqp+4tjkoi hjlTrhzkTsSC7/Fu1mN91OU8ItQL0Io36wXJRIwiGuhpc7jpvvSOwH5b9XpK1pmyoIc590i1KFw PQXUwVjIAjBfOXiKBh0IcsOj7p7pRpTYcVmqCiRXoPyFhhwfpOVV43bXlEMbr58YTq5qYfU0bwF bnb1JHYVYfmdR8ovTzHuEF07Tsm9QZtZZh6W9AyBOKAMC3fe
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

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
back to (the new) .probe() to be able to eventually drop .probe_new() from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/iio/addac/adt7316-i2c.c         | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 7e3d1a6f30ba..6c1f91c859ca 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -138,7 +138,7 @@ static struct i2c_driver adt7316_driver = {
 		.of_match_table = adt7316_of_match,
 		.pm = ADT7316_PM_OPS,
 	},
-	.probe_new = adt7316_i2c_probe,
+	.probe = adt7316_i2c_probe,
 	.id_table = adt7316_i2c_id,
 };
 module_i2c_driver(adt7316_driver);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b3152f7153fb..46db6d91542a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -781,7 +781,7 @@ static struct i2c_driver ad5933_driver = {
 		.name = "ad5933",
 		.of_match_table = ad5933_of_match,
 	},
-	.probe_new = ad5933_probe,
+	.probe = ad5933_probe,
 	.id_table = ad5933_id,
 };
 module_i2c_driver(ad5933_driver);
-- 
2.39.2

