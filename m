Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B682757D3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWMZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 08:25:03 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53718 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgIWMZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2020 08:25:03 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 08:25:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600863904; x=1632399904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QmuxF1k6JrlZgiNhVt0KMHpx0TS8HpqXkv0zvHy4YP4=;
  b=fuqfqEXO/8WMwMglwLLb0zvbageEvXZGg8wvfp/BuQKQ0SaebW3un+M2
   VbitoNdJSmqwuRD4Yow4QxQQFV5aNpLjkzmk8n6ZWZNHNapGY/gCRVE6V
   CAiYRyeuHR0Ox0d44Z8LNHcbuswxUQzwBkHpLj2yXxRL3g59ZPOHzzRDK
   nLKQc72o0/x3WdcYTW0RV8NaLpfrTZx9/bCRyHExww8+2Jn+lTrFGI1Y8
   da7XGT46crSh04Tl6t7Q5SVinY/8YPuOp/UI33Vzyp8zbZF5vU/97kfBY
   PqvVffhwBiSI+74KVZw6gJ9Zu3TXqsL0xevEed+GhbUyuYbyXnDJ+oUWl
   g==;
IronPort-SDR: fjcb6KWeS9NeUAPNPl/nN/NLjSpbTnZei5ymP1HDxx6lRKrG50OQTwp2KgNaRbf8CSfPsgkybx
 Eam5i78MzduCr8RtPKel9XAkI+uO1vBdNaBLG8JfDI6wfOMEV5E4EwyC6qTzcJ2yQv/XCx1PqK
 h6/Guf524PLoA83Fnl62A3Nl9NjBVNmetZObd69J8Op8Pg+a2ROBOLHu+Vdoiu0Yf6IV3fKYMk
 oKl87jXDwYFaV3I33jQGs//NJ0DcgqE/oKxOa7fZmvjr1wapdwkjbIeRtsTvcI/cvJHVatYFw2
 sPg=
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="92080952"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2020 05:17:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 05:17:37 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 23 Sep 2020 05:17:52 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2] iio: adc: at91-sama5d2_adc: fix DMA conversion crash
Date:   Wed, 23 Sep 2020 15:17:48 +0300
Message-ID: <20200923121748.49384-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After the move of the postenable code to preenable, the DMA start was
done before the DMA init, which is not correct.
The DMA is initialized in set_watermark. Because of this, we need to call
the DMA start functions in set_watermark, after the DMA init, instead of
preenable hook, when the DMA is not properly setup yet.

Fixes: f3c034f61775 ("iio: at91-sama5d2_adc: adjust iio_triggered_buffer_{predisable,postenable} positions")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- check return value of buffer prepare, and in case of error, unwind DMA
- validated by trying to force an error :

# echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/length
# echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/watermark
# iio_generic_buffer -n fc030000.adc -t fc030000.adc-dev0-external_rising -c 5
iio device number being used is 0
iio trigger number being used is 0
/sys/bus/iio/deviciio io:device0 fc030000.adc-dev0-external_risingiio:device0: using dma0chan10 for rx DMA transfers

iio iio:device0: continuing without DMA support
505.151367
983.715820
1352.709961
1485.644531


Original patch message:

Hi,

This crash is in the kernel since 5.8-rc1

Please have a look at discussion here:
https://lore.kernel.org/linux-iio/CA+U=DsqRUtjjoe5nevP_wNxTgr27+O2V1h9w7d3QijBQ+5f3XA@mail.gmail.com/T/#t

Thanks !

 drivers/iio/adc/at91-sama5d2_adc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index de9583d6cddd..f94641193b98 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -884,7 +884,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
 			       AT91_SAMA5D2_MAX_CHAN_IDX + 1);
 }
 
-static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
+static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 {
 	int ret;
 	u8 bit;
@@ -901,7 +901,7 @@ static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
 	/* we continue with the triggered buffer */
 	ret = at91_adc_dma_start(indio_dev);
 	if (ret) {
-		dev_err(&indio_dev->dev, "buffer postenable failed\n");
+		dev_err(&indio_dev->dev, "buffer prepare failed\n");
 		return ret;
 	}
 
@@ -989,7 +989,6 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
-	.preenable = &at91_adc_buffer_preenable,
 	.postdisable = &at91_adc_buffer_postdisable,
 };
 
@@ -1563,6 +1562,7 @@ static void at91_adc_dma_disable(struct platform_device *pdev)
 static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
 
 	if (val > AT91_HWFIFO_MAX_SIZE)
 		return -EINVAL;
@@ -1586,7 +1586,15 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	else if (val > 1)
 		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
 
-	return 0;
+	/*
+	 * We can start the DMA only after setting the watermark and
+	 * having the DMA initialization completed
+	 */
+	ret = at91_adc_buffer_prepare(indio_dev);
+	if (ret)
+		at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
+
+	return ret;
 }
 
 static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
-- 
2.25.1

