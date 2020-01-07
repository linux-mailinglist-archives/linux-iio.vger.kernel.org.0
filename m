Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A655132503
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgAGLhJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 06:37:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52724 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgAGLhI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 06:37:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 007Bb3Ih031529;
        Tue, 7 Jan 2020 05:37:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578397023;
        bh=DRchkeBbfpXpoPDU4rLABJfItAYPhwbN4UBzSTInVco=;
        h=From:To:CC:Subject:Date;
        b=PwUaLm7vhc1r8FlRTJWufFy66U8m0B793SmevJROLewAoDC/DlN8QXKvYRyYSWPaQ
         Dt4RMedAx46Z2f7Xtqvm68DiIVq4Me7uaBs+LujNRtXyHb/qQTEv7jRO1KttX2Tqbk
         L+bo8d5lZrrir4BxxtgN+fvwz2WgPUSVYrSlDSrc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007Bb2Ff065450;
        Tue, 7 Jan 2020 05:37:03 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 05:37:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 05:37:01 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007BawCS104100;
        Tue, 7 Jan 2020 05:36:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] iio: adc: at91-sama5d2_adc: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 7 Jan 2020 13:37:29 +0200
Message-ID: <20200107113729.5505-1-peter.ujfalusi@ti.com>
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

The dma_request_chan() is the standard API to request slave channel,
clients should be moved away from the legacy API to allow us to retire
them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v2:
- Commit message updated

Changes since v1:
- Subject prefix is corrected to "iio: adc: at91-sama5d2_adc:"

Regards,
Peter

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

