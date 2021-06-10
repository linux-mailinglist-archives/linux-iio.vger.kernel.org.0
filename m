Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22B3A2D66
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFJNs0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhFJNs0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:48:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC13BC061574
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:46:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrL0u-0002aN-AD
        for linux-iio@vger.kernel.org; Thu, 10 Jun 2021 15:46:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4A244638516
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 13:46:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D91F56384F8;
        Thu, 10 Jun 2021 13:46:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 53fa84ef;
        Thu, 10 Jun 2021 13:46:22 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 3/4] iio: ltr501: ltr501_read_ps(): add missing endianness conversion
Date:   Thu, 10 Jun 2021 15:46:18 +0200
Message-Id: <20210610134619.2101372-4-mkl@pengutronix.de>
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

From: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>

The PS ADC Channel data is spread over 2 registers in little-endian
form. This patch adds the missing endianness conversion.

Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
Signed-off-by: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
- move endianness conversion ltr501_read_ps()

 drivers/iio/light/ltr501.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 79898b72fe73..74ed2d88a3ed 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -409,18 +409,19 @@ static int ltr501_read_als(const struct ltr501_data *data, __le16 buf[2])
 
 static int ltr501_read_ps(const struct ltr501_data *data)
 {
-	int ret, status;
+	__le16 status;
+	int ret;
 
 	ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
 	if (ret < 0)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
-			       &status, 2);
+			       &status, sizeof(status));
 	if (ret < 0)
 		return ret;
 
-	return status;
+	return le16_to_cpu(status);
 }
 
 static int ltr501_read_intr_prst(const struct ltr501_data *data,
-- 
2.30.2


