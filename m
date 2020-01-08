Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E14133CA0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgAHIHv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 03:07:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgAHIHv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 03:07:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00887X51031711;
        Wed, 8 Jan 2020 02:07:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578470854;
        bh=0LePNPhQjsmvdB/jZvsH1FkQ9eB2wIq3NeRdkh9stOI=;
        h=From:To:CC:Subject:Date;
        b=x68cq71G1ZrJDnEb6xr6XEElxXdouhAOMrrfbhF4udA+QkkBpxSv2IEdh/b5sjQpv
         coZyuJeDPGrfLlfSnRNA3gD8Xs6tlHtCTZ5IXtX+aZvJK7aDFxmnj3xFlAtslKKejw
         GAFA9uHtuAhSKkA11/VI0Y5YJ3KFKu+z0UEWW9ss=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00887XRG002530;
        Wed, 8 Jan 2020 02:07:33 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 02:07:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 02:07:33 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00887UcT009067;
        Wed, 8 Jan 2020 02:07:31 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3] iio: adc: stm32-adc: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Wed, 8 Jan 2020 10:08:01 +0200
Message-ID: <20200108080801.14144-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Hi,

Changes since v2:
- Replace the comment as suggested by Fabrice

Changes since v1:
- Fall back to IRQ mode only in case of ENODEV

Regards,
Peter

 drivers/iio/adc/stm32-adc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3b291d72701c..a8d2414ee2eb 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1746,9 +1746,21 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
 	struct dma_slave_config config;
 	int ret;
 
-	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
-	if (!adc->dma_chan)
+	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
+	if (IS_ERR(adc->dma_chan)) {
+		ret = PTR_ERR(adc->dma_chan);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(&indio_dev->dev,
+					"DMA channel request failed with %d\n",
+					ret);
+			return ret;
+		}
+
+		/* DMA is optional: fall back to IRQ mode */
+		adc->dma_chan = NULL;
 		return 0;
+	}
 
 	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
 					 STM32_DMA_BUFFER_SIZE,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

