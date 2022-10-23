Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE81609396
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJWNXh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiJWNXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFDC6F27A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-0006ri-5K; Sun, 23 Oct 2022 15:23:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-000yh7-E5; Sun, 23 Oct 2022 15:23:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-00A3RT-Hb; Sun, 23 Oct 2022 15:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 14/23] iio: accel: mma7660: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:53 +0200
Message-Id: <20221023132302.911644-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CRtotGYhzACBZ+4+U7YqIeeEW/cmInGqjuAg4qsRL84=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9seXj0XA8dj30QiRlGizm58qR30LGbV1dVjhvJ PD4H3nSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/bAAKCRDB/BR4rcrsCUesB/ kByEGpIlkah2ddYttAXPFolHnJYl7vKCbJC6gKjnmTmFBzA3SGBsnl/BZ2tTfxWZ23/q3SFtfeTqQJ sj2y91LBL03dO1TZtAKTb7elOnKoGYqREMcuUJaXDhxhl4VujAJQhJj7mTeXf6odp3tlHox/U7NIht Yw02SwrbfgWKWQlt03jtPqgL3aSssEpt4J7D9q9158vpz4TT57VN26sePFfknJoRmDY4otyuf9rCrb MfWOjn4rso/zUZomZXUPvqFlRZdcul/cqNLooJgnMnqbhD/3j+61NoPsYVBe/VIZdX8/Jl4f73ldPE 3DHjWfJ+9Rdikd9ZS7nYJeozJBQtTd
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
 drivers/iio/accel/mma7660.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 85829990bbad..b279ca4dcdc0 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -169,8 +169,7 @@ static const struct iio_info mma7660_info = {
 	.attrs			= &mma7660_attribute_group,
 };
 
-static int mma7660_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int mma7660_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -267,7 +266,7 @@ static struct i2c_driver mma7660_driver = {
 		.of_match_table = mma7660_of_match,
 		.acpi_match_table = mma7660_acpi_id,
 	},
-	.probe		= mma7660_probe,
+	.probe_new	= mma7660_probe,
 	.remove		= mma7660_remove,
 	.id_table	= mma7660_i2c_id,
 };
-- 
2.37.2

