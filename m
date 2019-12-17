Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09DD1225D4
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfLQHul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 02:50:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53716 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLQHul (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 02:50:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBH7oVs8082175;
        Tue, 17 Dec 2019 01:50:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576569031;
        bh=MaH2sErLpxeYmngtjI6q6hiIGh8Im8kVUfACGcBFcxM=;
        h=From:To:CC:Subject:Date;
        b=PedRStQaXUiBsqBd4AfT4VL/96DIog1txXfMnHGsrybqDCxfPSyzFld91tz8U6+DR
         13N1UVnHNBYrgp8zJ/Mg9lJuefHkWDkIvWvGdGFtype1chQL2ENwJTgzLooUjFC5lg
         +2U/4y1ERYRNd6ikLtR7D99HljeV9y2Ib0PzjRDI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBH7oVOT047317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 01:50:31 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 01:50:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 01:50:30 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBH7oSVU088646;
        Tue, 17 Dec 2019 01:50:29 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: at91: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 09:50:43 +0200
Message-ID: <20191217075043.23539-1-peter.ujfalusi@ti.com>
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
 drivers/iio/adc/at91-sama5d2_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e1850f3d5cf3..a5c7771227d5 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1444,10 +1444,10 @@ static void at91_adc_dma_init(struct platform_device *pdev)
 	if (st->dma_st.dma_chan)
 		return;
 
-	st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
-
-	if (!st->dma_st.dma_chan)  {
+	st->dma_st.dma_chan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(st->dma_st.dma_chan))  {
 		dev_info(&pdev->dev, "can't get DMA channel\n");
+		st->dma_st.dma_chan = NULL;
 		goto dma_exit;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

