Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A260939E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJWNXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWNXl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4A7173E
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawf-0006rb-85; Sun, 23 Oct 2022 15:23:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-000yh2-5q; Sun, 23 Oct 2022 15:23:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-00A3RD-Oe; Sun, 23 Oct 2022 15:23:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Vladimir Oltean <olteanv@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:49 +0200
Message-Id: <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xPhaMhuh+x1zFOy+/opyWCtfU7DE3ZNhjEULYbez0xk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9fLT+o/GIJ7Y1eRPbuTYuGNepoNViyqVXJIM0N D2WLX3eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/XwAKCRDB/BR4rcrsCfxKB/ 9lTYwI9GTUp1Yr/OcQk/SKIww1L1bZ75adsF1TBrkRSbyt9c0QpUT7ZUfrPusMKX8QS6EEdwSfKuFo w6Lxp6iX+1LLHBh/Z8fH8LYBA7Qaj9oILBcoiz+ikyPIMM8BwR8F8jfCSV6l6eDvFXjRWWeERF9HHo uYqZ2IeZD0y/46/Ze2xa8wsRKuvTWLRUxUlpw+co6+AAkHncT2oLEIaZwdj52H5B5mRmLwmv/ivvLH yfguYxC1Ca4Ih9zAqnGS57WEQySFDwJRR17xfTphF4BMNsr4r4r7GuSkv2lQjIj/NCICV5f+oslJVq DtAbcfbYp4zg9FuErhf/Bcz8n0qxW0
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

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in .probe(). The device_id array has to move up for that
to work.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/kxcjk-1013.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index adc66b3615c0..e043dd698747 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1432,9 +1432,20 @@ static void kxcjk1013_disable_regulators(void *d)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
 
-static int kxcjk1013_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static const struct i2c_device_id kxcjk1013_id[] = {
+	{"kxcjk1013", KXCJK1013},
+	{"kxcj91008", KXCJ91008},
+	{"kxtj21009", KXTJ21009},
+	{"kxtf9",     KXTF9},
+	{"kx023-1025", KX0231025},
+	{"SMO8500",   KXCJ91008},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
+
+static int kxcjk1013_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(kxcjk1013_id, client);
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
@@ -1720,18 +1731,6 @@ static const struct acpi_device_id kx_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 
-static const struct i2c_device_id kxcjk1013_id[] = {
-	{"kxcjk1013", KXCJK1013},
-	{"kxcj91008", KXCJ91008},
-	{"kxtj21009", KXTJ21009},
-	{"kxtf9",     KXTF9},
-	{"kx023-1025", KX0231025},
-	{"SMO8500",   KXCJ91008},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
-
 static const struct of_device_id kxcjk1013_of_match[] = {
 	{ .compatible = "kionix,kxcjk1013", },
 	{ .compatible = "kionix,kxcj91008", },
@@ -1749,7 +1748,7 @@ static struct i2c_driver kxcjk1013_driver = {
 		.of_match_table = kxcjk1013_of_match,
 		.pm	= &kxcjk1013_pm_ops,
 	},
-	.probe		= kxcjk1013_probe,
+	.probe_new	= kxcjk1013_probe,
 	.remove		= kxcjk1013_remove,
 	.id_table	= kxcjk1013_id,
 };
-- 
2.37.2

