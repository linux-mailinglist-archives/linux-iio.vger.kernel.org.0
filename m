Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08417DCE1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIKDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 06:03:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCIKDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 06:03:21 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029A2fit029340;
        Mon, 9 Mar 2020 11:02:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=EEpTmJLKqEHuccfl2GlQ14M0nlV3ck8Nzcse6ro+Vy0=;
 b=DozwLS7K8kjaoo53KukoT1Z+NXxCmbP7h3EUHK7cGIQZrZXjKmG+JsYRiDtBupGmmVFH
 vhxxpC7Ivt0Fo+dg+5NcWdK1VGixf6WupJXPGrCB+pFWpbxVcraRToID8QB3Bnic0bME
 Z0hV84ISLOxIFJv33Oa3bNQVirotzVg5Hs5mjQAg1yRc0XsxDyvBAoQAFueJVV5RqhBa
 rRfLUEJezI83Ku6w0tRJGxJaB6FONysIPAmNI7aDl5gnUOQ4sljXC666unlI53lxPOUS
 oR8pvNXS1kBXVWW7eE2/ue/nn96RT86i7eq+xc8lv9/krJ4jBk82tJDd5vV8PT/aynXG /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ym292391k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 11:02:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68A0E100038;
        Mon,  9 Mar 2020 11:02:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D6082A9719;
        Mon,  9 Mar 2020 11:02:48 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Mar 2020 11:02:47
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: stm32-adc: fix sleep in atomic context
Date:   Mon, 9 Mar 2020 11:02:12 +0100
Message-ID: <20200309100212.16499-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_02:2020-03-08,2020-03-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit fixes the following error:
"BUG: sleeping function called from invalid context at kernel/irq/chip.c"

In DMA mode suppress the trigger irq handler, and make the buffer
transfers directly in DMA callback, instead.

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
Changes in v2:
- Add "Fixes" tag in commit message

This solution has been already discussed in the thread
https://lkml.org/lkml/2019/3/30/171, and applied in STM32 DFSDM driver:
e19ac9d9a978 ("iio: adc: stm32-dfsdm: fix sleep in atomic context")
---
 drivers/iio/adc/stm32-adc.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 80c3f963527b..ae622ee6d08c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1418,8 +1418,30 @@ static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
 static void stm32_adc_dma_buffer_done(void *data)
 {
 	struct iio_dev *indio_dev = data;
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int residue = stm32_adc_dma_residue(adc);
+
+	/*
+	 * In DMA mode the trigger services of IIO are not used
+	 * (e.g. no call to iio_trigger_poll).
+	 * Calling irq handler associated to the hardware trigger is not
+	 * relevant as the conversions have already been done. Data
+	 * transfers are performed directly in DMA callback instead.
+	 * This implementation avoids to call trigger irq handler that
+	 * may sleep, in an atomic context (DMA irq handler context).
+	 */
+	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
 
-	iio_trigger_poll_chained(indio_dev->trig);
+	while (residue >= indio_dev->scan_bytes) {
+		u16 *buffer = (u16 *)&adc->rx_buf[adc->bufi];
+
+		iio_push_to_buffers(indio_dev, buffer);
+
+		residue -= indio_dev->scan_bytes;
+		adc->bufi += indio_dev->scan_bytes;
+		if (adc->bufi >= adc->rx_buf_sz)
+			adc->bufi = 0;
+	}
 }
 
 static int stm32_adc_dma_start(struct iio_dev *indio_dev)
@@ -1845,6 +1867,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
+	irqreturn_t (*handler)(int irq, void *p) = NULL;
 	struct stm32_adc *adc;
 	int ret;
 
@@ -1911,9 +1934,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (!adc->dma_chan)
+		handler = &stm32_adc_trigger_handler;
+
 	ret = iio_triggered_buffer_setup(indio_dev,
-					 &iio_pollfunc_store_time,
-					 &stm32_adc_trigger_handler,
+					 &iio_pollfunc_store_time, handler,
 					 &stm32_adc_buffer_setup_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "buffer setup failed\n");
-- 
2.17.1

