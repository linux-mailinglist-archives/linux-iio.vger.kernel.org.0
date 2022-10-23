Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F460938B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiJWNXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJWNX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F2D6FC4A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-00071e-E6; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawa-000yhm-Fs; Sun, 23 Oct 2022 15:23:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawY-00A3Rm-Jh; Sun, 23 Oct 2022 15:23:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/23] iio: accel: mxc6255: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:22:58 +0200
Message-Id: <20221023132302.911644-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Y7ce1pV7EnM1dRLT3xI6AVuwYLbTY0ewHvg0g9pegL0=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSH2k8wuizdxNoqdK5PSjP75/nNztnMXyx/sygfUnkru/4r x8rbnYzGLAyMXAyyYoosdUVaYhMk1vy3K1nCDTOIlQlkCgMXpwBMZPV89v9lZwwumEgZ1Cw9e3Rx4W vJlxHJnmZPVn6UKf+/6OkMRem8fMnkrl/vqnpyHzpo/T2R7qAr+76F48rnMPVZN/ufRD7fGnT6vL33 1ZLia4lC0480fXTh13jnIfnzM/v3jMW+szwK+h6US2S9PlXTqZ8Raap+TdnodNW9r0KSooFFvc28T8 L/B7wQW5aWIXhoGR/vwiy1hLlWsQ8zUpaxbPCapVuo8eRi2a7E3n1iJ/ya3CNfFkboiXolmIq8C/qn mvxj1evV++rU3OP4Hqa9sjZ7Idr9wllWLVEj1c9W7d0W/fi7p27FJObue7DT07I7pvVl0c8mizqrGH afmflbZ20Q1RF4+tc4/ryufaYdAA==
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
 drivers/iio/accel/mxc6255.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 9aeeadc420d3..aa2e660545f8 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -113,8 +113,7 @@ static const struct regmap_config mxc6255_regmap_config = {
 	.readable_reg = mxc6255_is_readable_reg,
 };
 
-static int mxc6255_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int mxc6255_probe(struct i2c_client *client)
 {
 	struct mxc6255_data *data;
 	struct iio_dev *indio_dev;
@@ -184,7 +183,7 @@ static struct i2c_driver mxc6255_driver = {
 		.name = MXC6255_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc6255_acpi_match),
 	},
-	.probe		= mxc6255_probe,
+	.probe_new	= mxc6255_probe,
 	.id_table	= mxc6255_id,
 };
 
-- 
2.37.2

