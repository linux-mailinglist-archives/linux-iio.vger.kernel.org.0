Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A7010E76
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAVRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 17:17:46 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:64199 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfEAVRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 17:17:46 -0400
Received: from ofwgwc03.rockwellcollins.com (HELO crulimr01.rockwellcollins.com) ([205.175.225.12])
  by secvs01.rockwellcollins.com with ESMTP; 01 May 2019 16:17:43 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by crulimr01.rockwellcollins.com (Postfix) with ESMTP id 8B92F6021C;
        Wed,  1 May 2019 16:17:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH 6/6] iio: ad7949: Fix dummy read cycle placement
Date:   Wed,  1 May 2019 16:17:03 -0500
Message-Id: <1556745423-11368-6-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7949 requires two conversion cycles following any configuration
change (including changing the analog channel being sampled). Therefore,
adding a dummy read cycle when config is changed and removing the extra
cycles at initial configuration.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
 drivers/iio/adc/ad7949.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index dc1ae4c143b0..4e8ad4217e5b 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -115,6 +115,25 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 		 * time to send a new command to the device
 		 */
 		udelay(2);
+
+		/*
+		 * Perform extra read cycle to allow configuration, acquisition,
+		 * and conversion sequences to complete for new configuration.
+		 */
+		(void)memset(&tx, 0, sizeof(tx));
+		(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
+
+		tx.rx_buf = ad7949_adc->buffer;
+		tx.len = ad7949_spi_cfg_is_read_back(ad7949_adc) ? 4 : 2;
+
+		spi_message_init_with_transfers(&msg, &tx, 1);
+		ret = spi_sync(ad7949_adc->spi, &msg);
+
+		/*
+		 * This delay is to avoid a new request before the required time
+		 * to send a new command to the device.
+		 */
+		udelay(2);
 	}
 
 	return ret;
@@ -247,7 +266,6 @@ static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
 static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
-	int val;
 	u16 adc_config = 0;
 
 	ad7949_adc->current_channel = 0;
@@ -261,13 +279,6 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 
 	ret = ad7949_spi_write_cfg(ad7949_adc, adc_config, AD7949_MASK_TOTAL);
 
-	/*
-	 * Do two dummy conversions to apply the first configuration setting.
-	 * Required only after the start up of the device.
-	 */
-	ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);
-	ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);
-
 	return ret;
 }
 
-- 
1.9.1

