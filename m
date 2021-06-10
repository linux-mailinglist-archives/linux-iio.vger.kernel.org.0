Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8672E3A2D65
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhFJNs0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhFJNs0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:48:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F2C061760
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:46:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrL0u-0002aO-A1
        for linux-iio@vger.kernel.org; Thu, 10 Jun 2021 15:46:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 496E6638515
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 13:46:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F0EC06384FA;
        Thu, 10 Jun 2021 13:46:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a3258e8f;
        Thu, 10 Jun 2021 13:46:22 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 4/4] iio: ltr501: mark ltr501_chip_info as const
Date:   Thu, 10 Jun 2021 15:46:19 +0200
Message-Id: <20210610134619.2101372-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610134619.2101372-1-mkl@pengutronix.de>
References: <20210610134619.2101372-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch marks the struct ltr501_chip_info as constant.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/iio/light/ltr501.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 74ed2d88a3ed..1830221da48d 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -152,7 +152,7 @@ struct ltr501_chip_info {
 struct ltr501_data {
 	struct i2c_client *client;
 	struct mutex lock_als, lock_ps;
-	struct ltr501_chip_info *chip_info;
+	const struct ltr501_chip_info *chip_info;
 	u8 als_contr, ps_contr;
 	int als_period, ps_period; /* period in micro seconds */
 	struct regmap *regmap;
@@ -739,7 +739,7 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
 	int i, ret, freq_val, freq_val2;
-	struct ltr501_chip_info *info = data->chip_info;
+	const struct ltr501_chip_info *info = data->chip_info;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -1086,7 +1086,7 @@ static ssize_t ltr501_show_proximity_scale_avail(struct device *dev,
 						 char *buf)
 {
 	struct ltr501_data *data = iio_priv(dev_to_iio_dev(dev));
-	struct ltr501_chip_info *info = data->chip_info;
+	const struct ltr501_chip_info *info = data->chip_info;
 	ssize_t len = 0;
 	int i;
 
@@ -1108,7 +1108,7 @@ static ssize_t ltr501_show_intensity_scale_avail(struct device *dev,
 						 char *buf)
 {
 	struct ltr501_data *data = iio_priv(dev_to_iio_dev(dev));
-	struct ltr501_chip_info *info = data->chip_info;
+	const struct ltr501_chip_info *info = data->chip_info;
 	ssize_t len = 0;
 	int i;
 
@@ -1188,7 +1188,7 @@ static const struct iio_info ltr301_info = {
 	.write_event_config	= &ltr501_write_event_config,
 };
 
-static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
+static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 	[ltr501] = {
 		.partid = 0x08,
 		.als_gain = ltr501_als_gain_tbl,
-- 
2.30.2


