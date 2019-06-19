Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB77F4B958
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 15:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfFSNEe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 09:04:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63798 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731894AbfFSNEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 09:04:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCu1vs023624;
        Wed, 19 Jun 2019 15:04:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1RIed4PSnLNoF/Qg8Sp7JJ0Sajo64o3gdxbSWUs/b4M=;
 b=0xenS9bcGVcF8713j77nhv9uVF0N+3rssP3bIA4M00CmyUSAdrwem78TNJJNHfTMdReb
 hibMRJP0HII90WclTnhXFen799MWDD/raHoZnqsHbOBbPWUJFplV8tYCsdK8h7BOWAgB
 xk1FVwbkGYx828MwMagijwfaNOg1olBktgZfIZ5utfW8B/d5l+iFdSI+juK5e5c9iuKR
 x4dpT76VUixZ5pa0Yz+5LRtRPnSyXKu7GCWx+etdZhJt7Ei2O0LF3lXSLgV/jD/V4e1U
 Rs27nGZcFT54Z0W4601g8h6Ui5MHlqxcEanwRD+C6rqGePLtRs9XHJiNAg7pWbj8FW+J cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813c0aq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:04:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC7D638;
        Wed, 19 Jun 2019 13:04:02 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5A452834;
        Wed, 19 Jun 2019 13:04:02 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 15:04:02 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 15:04:02
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
Subject: [PATCH 5/5] iio: adc: stm32-dfsdm: add comment for 16 bits record
Date:   Wed, 19 Jun 2019 15:03:51 +0200
Message-ID: <1560949431-22948-6-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
References: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a comment on DMA configuration for 16 bits record.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index d855a605eab6..ee1e0569d0e1 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -918,6 +918,11 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
 static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	/*
+	 * The DFSDM supports half-word transfers. However, for 16 bits record,
+	 * 4 bytes buswidth is kept, to avoid losing samples LSBs when left
+	 * shift is required.
+	 */
 	struct dma_slave_config config = {
 		.src_addr = (dma_addr_t)adc->dfsdm->phys_base,
 		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
-- 
2.7.4

