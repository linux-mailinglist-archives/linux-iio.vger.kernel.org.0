Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F021B923
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfEMOxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 10:53:52 -0400
Received: from ch3vs01.rockwellcollins.com ([205.175.226.27]:63586 "EHLO
        ch3vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730696AbfEMOxw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2019 10:53:52 -0400
Received: from ofwch3n02.rockwellcollins.com (HELO ciulimr01.rockwellcollins.com) ([205.175.226.14])
  by ch3vs01.rockwellcollins.com with ESMTP; 13 May 2019 09:53:51 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id 0C6FE601D0;
        Mon, 13 May 2019 09:53:51 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v3 1/5] iio: ad7949: Fix dummy read cycle placement
Date:   Mon, 13 May 2019 09:53:01 -0500
Message-Id: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7949 requires two conversion cycles following the first
configuration change, and one extra cycle following any other
configuration change (including changing the analog channel being
sampled). Therefore, adding a dummy read cycle when config is changed
and removing the extra cycle at initial configuration (the first dummy
cycle is now performed as part of applying the configuration change).

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2:
	- Add some defines to reduce use of magic numbers.
	V3:
	- Switch back to using a u32 data buffer.
	- Add-back the second dummy cycle on initialization.
	- Move to first patch in series.
---
 drivers/iio/adc/ad7949.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index ac0ffff6c5ae..c7fe27aa2519 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -100,6 +100,23 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 	 * send a new command to the device
 	 */
 	udelay(2);
+
+	/*
+	 * Perform extra read cycle to allow configuration, acquisition,
+	 * and conversion sequences to complete for new configuration.
+	 */
+	ad7949_adc->buffer = 0;
+
+	spi_message_init_with_transfers(&msg, tx, 1);
+
+	ret = spi_sync(ad7949_adc->spi, &msg);
+
+	/*
+	 * This delay is to avoid a new request before the required time
+	 * to send a new command to the device.
+	 */
+	udelay(2);
+
 	return ret;
 }
 
@@ -229,11 +246,10 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
 
 	/*
-	 * Do two dummy conversions to apply the first configuration setting.
+	 * Do a dummy conversion to apply the first configuration setting.
 	 * Required only after the start up of the device.
 	 */
 	ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);
-	ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);
 
 	return ret;
 }
-- 
1.9.1

