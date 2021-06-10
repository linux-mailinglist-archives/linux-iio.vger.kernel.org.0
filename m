Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB83A2C0F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFJM4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJM4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:56:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A27C0617A6
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 05:54:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrKCD-00033K-QB
        for linux-iio@vger.kernel.org; Thu, 10 Jun 2021 14:54:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4DA2563841F
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 12:54:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 97B89638403;
        Thu, 10 Jun 2021 12:54:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8b6f0f2;
        Thu, 10 Jun 2021 12:54:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/4] iio: ltr501: ltr501_read_ps(): add missing endianness conversion
Date:   Thu, 10 Jun 2021 14:53:57 +0200
Message-Id: <20210610125358.2096497-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610125358.2096497-1-mkl@pengutronix.de>
References: <20210610125358.2096497-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>

The PS ADC Channel data is spread over 2 registers in little-endian
form. This patch adds the missing endianness conversion.

Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
Signed-off-by: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/iio/light/ltr501.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 79898b72fe73..0e3f97ef3cdd 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -407,20 +407,16 @@ static int ltr501_read_als(const struct ltr501_data *data, __le16 buf[2])
 				buf, 2 * sizeof(__le16));
 }
 
-static int ltr501_read_ps(const struct ltr501_data *data)
+static int ltr501_read_ps(const struct ltr501_data *data, __le16 *buf)
 {
-	int ret, status;
+	int ret;
 
 	ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
-			       &status, 2);
-	if (ret < 0)
-		return ret;
-
-	return status;
+	return regmap_bulk_read(data->regmap, LTR501_PS_DATA,
+				buf, sizeof(__le16));
 }
 
 static int ltr501_read_intr_prst(const struct ltr501_data *data,
@@ -668,11 +664,11 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_PROXIMITY:
 			mutex_lock(&data->lock_ps);
-			ret = ltr501_read_ps(data);
+			ret = ltr501_read_ps(data, buf);
 			mutex_unlock(&data->lock_ps);
 			if (ret < 0)
 				break;
-			*val = ret & LTR501_PS_DATA_MASK;
+			*val = le16_to_cpu(buf[0]) & LTR501_PS_DATA_MASK;
 			ret = IIO_VAL_INT;
 			break;
 		default:
-- 
2.30.2


