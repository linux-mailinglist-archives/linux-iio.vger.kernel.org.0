Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31142A80E3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgKEOaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 09:30:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3798 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726874AbgKEOaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 09:30:13 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5ENFYl017987;
        Thu, 5 Nov 2020 15:29:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=dyr85PgFl8sA9doMkGgOgiUNMN6lTP8JG0WtqSphbx4=;
 b=zFxqWEENfSHmbpanJVS5772LhH4wFSvPdg02ozNDbwrg1lBIcEujAVvl8PGcRELM1qpa
 95gyu6ZNtzTWP6Iv0r0YGOcQozJ4qkga3b6zrEhp/+xiivO+0t4hXKTvbbOXg9AVv2r8
 JPySjkc8hIHf3blHUxO7QgFq0yx7M1j0PJfPkycfgSpg3u4EwXlxLL7cCRLcULBGMxyC
 QHhDG+ediz0YaH4+0Z7NY2Qff6swhKb/cKsUPXkkV8BjUzPYUbCb8Dy+uJ2FenNZQCOK
 HVgMs+14Ch82KvlRFrVkrj2+3k5swGvE35ZxXulaZtyofqjQTxpCsLI6ns3bEk6yv+/J kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h0321by7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 15:29:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8F5710002A;
        Thu,  5 Nov 2020 15:29:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9100B2BA2DA;
        Thu,  5 Nov 2020 15:29:48 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov 2020 15:29:47
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: stm32-adc: dma transfers cleanup
Date:   Thu, 5 Nov 2020 15:29:41 +0100
Message-ID: <20201105142941.27301-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_07:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Remove processing related to DMA in irq handler as this
data transfer is managed directly in DMA callback.
- Update comment in stm32_adc_set_watermark() function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-adc.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b3f31f147347..08be826f1462 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1310,7 +1310,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	 * dma cyclic transfers are used, buffer is split into two periods.
 	 * There should be :
 	 * - always one buffer (period) dma is working on
-	 * - one buffer (period) driver can push with iio_trigger_poll().
+	 * - one buffer (period) driver can push data.
 	 */
 	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
 	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
@@ -1573,31 +1573,14 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
 
 	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
 
-	if (!adc->dma_chan) {
-		/* reset buffer index */
-		adc->bufi = 0;
-		iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
-						   pf->timestamp);
-	} else {
-		int residue = stm32_adc_dma_residue(adc);
-
-		while (residue >= indio_dev->scan_bytes) {
-			u16 *buffer = (u16 *)&adc->rx_buf[adc->bufi];
-
-			iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-							   pf->timestamp);
-			residue -= indio_dev->scan_bytes;
-			adc->bufi += indio_dev->scan_bytes;
-			if (adc->bufi >= adc->rx_buf_sz)
-				adc->bufi = 0;
-		}
-	}
-
+	/* reset buffer index */
+	adc->bufi = 0;
+	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
+					   pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	/* re-enable eoc irq */
-	if (!adc->dma_chan)
-		stm32_adc_conv_irq_enable(adc);
+	stm32_adc_conv_irq_enable(adc);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

