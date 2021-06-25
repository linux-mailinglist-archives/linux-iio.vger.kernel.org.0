Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFC3B3CF1
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 08:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFYHBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhFYHBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jun 2021 03:01:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD0C061574
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 23:59:33 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lwfoD-0007c1-8u; Fri, 25 Jun 2021 08:59:25 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lwfoC-0002BN-0A; Fri, 25 Jun 2021 08:59:24 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/2] iio: adc: tsc2046: fix scan interval warning
Date:   Fri, 25 Jun 2021 08:59:21 +0200
Message-Id: <20210625065922.8310-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sync if statement with the actual warning.

Fixes: 9504db5765e8 ("iio: adc: tsc2046: fix a warning message in tsc2046_adc_update_scan_mode()")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 170950d5dd49..d84ae6b008c1 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -398,7 +398,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 	priv->xfer.len = size;
 	priv->time_per_scan_us = size * 8 * priv->time_per_bit_ns / NSEC_PER_USEC;
 
-	if (priv->scan_interval_us > priv->time_per_scan_us)
+	if (priv->scan_interval_us < priv->time_per_scan_us)
 		dev_warn(&priv->spi->dev, "The scan interval (%d) is less then calculated scan time (%d)\n",
 			 priv->scan_interval_us, priv->time_per_scan_us);
 
-- 
2.29.2

