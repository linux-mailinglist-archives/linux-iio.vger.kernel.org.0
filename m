Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F60E4FCD
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2019 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439903AbfJYPFK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Oct 2019 11:05:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436893AbfJYPFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Oct 2019 11:05:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PEpUFx014286;
        Fri, 25 Oct 2019 17:04:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ZMeMc+3j8pjf5jMQ5pjGKgdHlK3Le3Ui9+EuWowxw6E=;
 b=RxVRLetyW5JQMuy2I9X0ZoPm9auwGLD+WdqLLjbs2TevbHp7vBBsif1Nw4JE8qqwZ1w9
 cMpUSFhPXmYLQ1h3jj1rBIDMc6JEsVbe8tv454DYRi4stSFp14H0FCmVWH/vWgoM46nt
 F5BfIrj4qwRZgAw2mHu8PpoEsJGo4IGOup8or7MMCLiXk7W7JK1hUoY/IEETYtkY4GI1
 iGVtknMmCatf1sigl2xA6UfE5oIrCaWkou97M72kp/+FR/W307qCcyT/kfKZUlHEIjcr
 bOwrSFqLhByOUSpFGgB1qId+VUQmeRzz1GdpeseHg5+j+bpDZZaC2SFvlLBzIW3REnIT 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vt9s58dgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:04:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E67C10002A;
        Fri, 25 Oct 2019 17:04:42 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B1CD2A9711;
        Fri, 25 Oct 2019 17:04:42 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 25 Oct
 2019 17:04:42 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 25 Oct 2019 17:04:41 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-adc: fix stopping dma
Date:   Fri, 25 Oct 2019 17:04:20 +0200
Message-ID: <1572015860-8931-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_08:2019-10-25,2019-10-25 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There maybe a race when using dmaengine_terminate_all(). The predisable
routine may call iio_triggered_buffer_predisable() prior to a pending DMA
callback.
Adopt dmaengine_terminate_sync() to ensure there's no pending DMA request
before calling iio_triggered_buffer_predisable().

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 663f8a5..73aee59 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1399,7 +1399,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
 	if (ret) {
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 		return ret;
 	}
 
@@ -1477,7 +1477,7 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 		stm32_adc_conv_irq_disable(adc);
 
 	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
-- 
2.7.4

