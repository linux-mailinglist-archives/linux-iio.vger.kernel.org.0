Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406A41AB352
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442365AbgDOVXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 17:23:17 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:27701 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438905AbgDOVXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 17:23:11 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1768124000C;
        Wed, 15 Apr 2020 21:23:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] iio: adc: ti-ads8344: remove tx_buf from driver data
Date:   Wed, 15 Apr 2020 23:22:56 +0200
Message-Id: <20200415212257.161238-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
References: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to keep tx_buf around, it is only used for the conversion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/ti-ads8344.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index 6da50ea35217..9b2d3a8ea6bd 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -22,13 +22,7 @@
 struct ads8344 {
 	struct spi_device *spi;
 	struct regulator *reg;
-	/*
-	 * Lock protecting access to adc->tx_buff and rx_buff,
-	 * especially from concurrent read on sysfs file.
-	 */
-	struct mutex lock;
-
-	u8 tx_buf ____cacheline_aligned;
+	struct mutex lock; /* protect from concurrent conversions */
 };
 
 #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
@@ -77,13 +71,13 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
 	int ret;
 	u8 buf[3];
 
-	adc->tx_buf = ADS8344_START;
+	buf[0] = ADS8344_START;
 	if (!differential)
-		adc->tx_buf |= ADS8344_SINGLE_END;
-	adc->tx_buf |= ADS8344_CHANNEL(channel);
-	adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
+		buf[0] |= ADS8344_SINGLE_END;
+	buf[0] |= ADS8344_CHANNEL(channel);
+	buf[0] |= ADS8344_CLOCK_INTERNAL;
 
-	ret = spi_write(spi, &adc->tx_buf, 1);
+	ret = spi_write(spi, buf, 1);
 	if (ret)
 		return ret;
 
-- 
2.25.2

