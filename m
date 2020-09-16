Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EDC26BDA9
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPHIp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 03:08:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:35266 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPHIo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 03:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600240123; x=1631776123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kRZu+9DWwWzAavQX/XVNxGelxwlfukUlgQUjykqNXgE=;
  b=qayZ3XUtssFFSofofV9lDD9LARyKq+DrCf0ir+sruFo8BEZTlQ9OTpWu
   gHL5mMhaFvLeUPXERjq9nLh7GXJiOZaG8/Gy2htd50LbWn1TINfAuLeEP
   JhYv4aLlaSLzsJptYc17TCUxbWGVLNgctOIwijnjGxY2PcRhNAl4CcToE
   aWOIrwt01ga0WPeBfESQhb+jN/Z7rBGCSo802NY22uMQJRQqhTeYTmffE
   Lq2oZdT/AYdxCVLWGsC8Vkiy+zpo5kAtXSLMXzzZVk439erj69VIgia8b
   DkPeX5+i58codOnG/2UMeiRSvD5SCvAqWEstuvPByAWQbdzmqmp1R0FwH
   g==;
IronPort-SDR: bBHBK/VezAlFji1zCJrRtPFxLjwXVigFQKQlyGvAIn6RS6fh9U3ofpmFJEG+57br9oPDxPI3qL
 ODMEn98DgMCAc5aHXy2cRa2YQs/AlGHowLxOnIwYsNWOO6KoNZNnURbHwoTmG6+v67FJinZOHG
 2f5rLekrUieffD9dhrzmQUob/WFesDNjonG7ETXeLN39os0S/XI3Ht5kTzvo40IXMLuk/8AQI1
 rH6TObkb28putEQ+xFQK51msWCzLSnzsVk+vcfZYVN9AxxbPNC9x5Ry8VqvdR8yHmoMVxCjLJs
 zC4=
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="91976494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 00:08:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 00:08:26 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Sep 2020 00:08:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: fix DMA conversion crash
Date:   Wed, 16 Sep 2020 10:08:21 +0300
Message-ID: <20200916070821.118374-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
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

Hi,

This crash is in the kernel since 5.8-rc1

Please have a look at discussion here:
https://lore.kernel.org/linux-iio/CA+U=DsqRUtjjoe5nevP_wNxTgr27+O2V1h9w7d3QijBQ+5f3XA@mail.gmail.com/T/#t

Thanks !

 drivers/iio/adc/at91-sama5d2_adc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index de9583d6cddd..b5196797dcb8 100644
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
 
@@ -1586,7 +1585,11 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	else if (val > 1)
 		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
 
-	return 0;
+	/*
+	 * We can start the DMA only after setting the watermark and
+	 * having the DMA initialization completed
+	 */
+	return at91_adc_buffer_prepare(indio_dev);
 }
 
 static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
-- 
2.25.1

