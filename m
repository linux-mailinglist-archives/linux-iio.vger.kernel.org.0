Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3E1225E7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 08:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLQHwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 02:52:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53936 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfLQHwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 02:52:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBH7q8a8082887;
        Tue, 17 Dec 2019 01:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576569128;
        bh=JVOtlzp4SCMmIRdgV0Dwkwtw1zBJBOLFQP857cg/zhQ=;
        h=From:To:CC:Subject:Date;
        b=DQagl2Z9mA1II7/LrIfOiy+kvnFSvq3LR3YTlC9lD84Uor6OTYU0zqJ5QNAkjXRS5
         IqFGPMfHchR75vQ7BqWh0VTz+v6B76K3TtXcE1DJupzGuHCBVn16BaYcag7sw8h2k5
         rGBNOjHJ1PoW29Y8SrgJfYWZE47i88SCielTyrJY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBH7q8jP049798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 01:52:08 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 01:52:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 01:52:08 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBH7q5MV115230;
        Tue, 17 Dec 2019 01:52:06 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-dfsdm: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 09:52:21 +0200
Message-ID: <20191217075221.23895-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
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
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index e493242c266e..3aac1a21f9d0 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1383,9 +1383,9 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
-	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
-	if (!adc->dma_chan)
-		return -EINVAL;
+	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
+	if (IS_ERR(adc->dma_chan))
+		return PTR_ERR(adc->dma_chan);
 
 	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
 					 DFSDM_DMA_BUFFER_SIZE,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

