Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35CF1AD18F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgDPUyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 16:54:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54883 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgDPUyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 16:54:37 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 00A58240003;
        Thu, 16 Apr 2020 20:54:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
Date:   Thu, 16 Apr 2020 22:54:27 +0200
Message-Id: <20200416205428.437503-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The first received byte is the MSB, followed by the LSB so the value needs
to be byte swapped.

Also, the ADC actually has a delay of one clock on the SPI bus. Read three
bytes to get the last bit.

Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/ti-ads8344.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index 9a460807d46d..abe4b56c847c 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -29,7 +29,7 @@ struct ads8344 {
 	struct mutex lock;
 
 	u8 tx_buf ____cacheline_aligned;
-	u16 rx_buf;
+	u8 rx_buf[3];
 };
 
 #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
@@ -89,11 +89,11 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
 
 	udelay(9);
 
-	ret = spi_read(spi, &adc->rx_buf, 2);
+	ret = spi_read(spi, adc->rx_buf, sizeof(adc->rx_buf));
 	if (ret)
 		return ret;
 
-	return adc->rx_buf;
+	return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;
 }
 
 static int ads8344_read_raw(struct iio_dev *iio,
-- 
2.25.2

