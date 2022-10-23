Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C30609394
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJWNXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJWNXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FB70E7A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-0006r2-4C; Sun, 23 Oct 2022 15:23:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-000ygo-Qw; Sun, 23 Oct 2022 15:23:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-00A3RH-VK; Sun, 23 Oct 2022 15:23:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>, Ajay Gupta <ajayg@nvidia.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/23] iio: accel: kxsd9: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:50 +0200
Message-Id: <20221023132302.911644-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AgXJgfOEf0EZfJW6EUQ2AGZwz1abIYHAMx6wgPz7o3I=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9i9uyHGl+Ikl1+g/eF1KOtNiWFA0MxftPoNtUQ gB8shmCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/YgAKCRDB/BR4rcrsCQwJB/ 9AxUH8Zz8YtuYl89kBYS8cKltP1MHQVh0oGYh6qyARvJ9Z1GQxIVTAZS8RSzHXWfXQuEAVG9nX/RE7 EI5hnHOLr29+CvE+mw2lrUJryZBAvZKoeb7ldzPMADc7lAfBE1VVbdLdALXqqVom08cgtsd0Atlg7t 3ZDNfnaSGj9hZ8xr/DJnAWzGkyYFOii3J5YK416M9ZrWi9b9oFIYi8VN9Bo7Cx2eXZAsgwWUSsZZ44 d+pxPak78QsaS4tJo/kjsectCOoe1XORAoFxEOs3WqhuhlbLuiim6iCrgj1Bsvn+xkP2Sxa72jlboW 3+pFpdbNDH9xsK6rx0+SNnoPhRxI0B
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

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/kxsd9-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 61346ea8ef19..6b3683ddce36 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -10,8 +10,7 @@
 
 #include "kxsd9.h"
 
-static int kxsd9_i2c_probe(struct i2c_client *i2c,
-			   const struct i2c_device_id *id)
+static int kxsd9_i2c_probe(struct i2c_client *i2c)
 {
 	static const struct regmap_config config = {
 		.reg_bits = 8,
@@ -55,7 +54,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
 		.of_match_table = kxsd9_of_match,
 		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 	},
-	.probe		= kxsd9_i2c_probe,
+	.probe_new	= kxsd9_i2c_probe,
 	.remove		= kxsd9_i2c_remove,
 	.id_table	= kxsd9_i2c_id,
 };
-- 
2.37.2

