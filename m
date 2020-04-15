Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90321AB351
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438958AbgDOVXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 17:23:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:59015 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438917AbgDOVXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 17:23:11 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C7B2C200004;
        Wed, 15 Apr 2020 21:23:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] iio: adc: ti-ads8344: optimize consumption
Date:   Wed, 15 Apr 2020 23:22:57 +0200
Message-Id: <20200415212257.161238-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
References: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set the clock mode only once, at probe time and then keep the ADC powered
down between conversions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/ti-ads8344.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index 9b2d3a8ea6bd..0804650d8d8a 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -65,7 +65,7 @@ static const struct iio_chan_spec ads8344_channels[] = {
 };
 
 static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
-				  bool differential)
+				  bool differential, u8 clock)
 {
 	struct spi_device *spi = adc->spi;
 	int ret;
@@ -75,7 +75,7 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
 	if (!differential)
 		buf[0] |= ADS8344_SINGLE_END;
 	buf[0] |= ADS8344_CHANNEL(channel);
-	buf[0] |= ADS8344_CLOCK_INTERNAL;
+	buf[0] |= clock;
 
 	ret = spi_write(spi, buf, 1);
 	if (ret)
@@ -100,7 +100,7 @@ static int ads8344_read_raw(struct iio_dev *iio,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&adc->lock);
 		*value = ads8344_adc_conversion(adc, channel->scan_index,
-						channel->differential);
+						channel->differential, 0);
 		mutex_unlock(&adc->lock);
 		if (*value < 0)
 			return *value;
@@ -155,6 +155,11 @@ static int ads8344_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* Do a dummy read and set external clock mode */
+	ret = ads8344_adc_conversion(adc, 0, 0, ADS8344_CLOCK_INTERNAL);
+	if (ret < 0)
+		return ret;
+
 	spi_set_drvdata(spi, indio_dev);
 
 	ret = iio_device_register(indio_dev);
-- 
2.25.2

