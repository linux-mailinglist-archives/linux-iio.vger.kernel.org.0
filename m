Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A584B95A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfFSNEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 09:04:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21770 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731893AbfFSNEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 09:04:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCuBJM023659;
        Wed, 19 Jun 2019 15:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=C0tl/h814D0dle+nbGO9SjbYs9XOpojrEDl6X9DrGZk=;
 b=C+5wGk3MVghtvj2ZPqHqBd879zWEVlGy1+cHcWHfZJLamn5UpaeJmy76ZytA6VbsysO2
 wux/QZZQWvad9ncNuWbKycEIZ5VTNtlIFpHb8NROBbs3Ef+n8EDgmBUKzijO7FMDYNXo
 Ung3f4qZmquXtoya/lHjHlSpRujkcTr46nF97aXbZxZHqA2GGS0hgsI5NYGgNrCleTPI
 SVl8lSHSfHlivocxiKtIooseqkw+O+q1JGnhjoO6CS9xLVljcSwPSrVA9b432Uufh087
 Avjl83tOnvAbxtkEisTzNd+H/gXMapOHcAh9FSEWdIHCOJ9089S5SyfW6Vhr9kA7WnBi /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813c0ah-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:04:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BE8938;
        Wed, 19 Jun 2019 13:03:59 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D6B92835;
        Wed, 19 Jun 2019 13:03:59 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 15:03:59 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 15:03:58
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
Subject: [PATCH 3/5] iio: adc: stm32-dfsdm: manage data resolution in trigger mode
Date:   Wed, 19 Jun 2019 15:03:49 +0200
Message-ID: <1560949431-22948-4-git-send-email-olivier.moysan@st.com>
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

Add output sample resolution management in scan mode.
Add stm32_dfsdm_process_data() function to share sample
processing between continuous and trigger modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 6b90a40882f2..5b19a88412a6 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -779,6 +779,30 @@ static unsigned int stm32_dfsdm_adc_dma_residue(struct stm32_dfsdm_adc *adc)
 	return 0;
 }
 
+static inline void stm32_dfsdm_process_data(struct stm32_dfsdm_adc *adc,
+					    s32 *buffer)
+{
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
+	unsigned int i = adc->nconv;
+	s32 *ptr = buffer;
+
+	while (i--) {
+		/* Mask 8 LSB that contains the channel ID */
+		*ptr &= 0xFFFFFF00;
+		/* Convert 2^(n-1) sample to 2^(n-1)-1 to avoid wrap-around */
+		if (*ptr > flo->max)
+			*ptr -= 1;
+		/*
+		 * Samples from filter are retrieved with 23 bits resolution
+		 * or less. Shift left to align MSB on 24 bits.
+		 */
+		*ptr <<= flo->lshift;
+
+		ptr++;
+	}
+}
+
 static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -787,7 +811,9 @@ static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
 	int available = stm32_dfsdm_adc_dma_residue(adc);
 
 	while (available >= indio_dev->scan_bytes) {
-		u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
+		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
+
+		stm32_dfsdm_process_data(adc, buffer);
 
 		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
 						   pf->timestamp);
@@ -806,8 +832,6 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
 {
 	struct iio_dev *indio_dev = data;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
-	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
 	int available = stm32_dfsdm_adc_dma_residue(adc);
 	size_t old_pos;
 
@@ -832,16 +856,7 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
 	while (available >= indio_dev->scan_bytes) {
 		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
 
-		/* Mask 8 LSB that contains the channel ID */
-		*buffer &= 0xFFFFFF00;
-		/* Convert 2^(n-1) sample to 2^(n-1)-1 to avoid wrap-around */
-		if (*buffer > flo->max)
-			*buffer -= 1;
-		/*
-		 * Samples from filter are retrieved with 23 bits resolution
-		 * or less. Shift left to align MSB on 24 bits.
-		 */
-		*buffer <<= flo->lshift;
+		stm32_dfsdm_process_data(adc, buffer);
 
 		available -= indio_dev->scan_bytes;
 		adc->bufi += indio_dev->scan_bytes;
-- 
2.7.4

