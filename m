Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B397B10AD3A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2019 11:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfK0KHh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Nov 2019 05:07:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16124 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbfK0KHh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2019 05:07:37 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARA7AGl032453;
        Wed, 27 Nov 2019 11:07:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VAggDD7eOOudtLCJRIZWwLHbOcnWRF07mVpnmo9075g=;
 b=Xhl35aFk4FKmIqnDte+5HLyVlueiHnEO478B0pFnD948tio0UouOKZVf1p5ug0J3FF6b
 GQahQBaXYLsF+G0iXQFc3njAHBeXohOOjfLhHs0p92fjbeOaS0ZLvRpd+WmqPWTvSAs1
 3FayiqM255Dv43/6E3ndE+Bs4J3zqL/EhECsINQO6V652R7XCOJJ0qXxrwsDQuLkMsQB
 rc7tBT7uCKWG1CWsNe+JiRoht0vHA1y7lrf3jluG4vd2UsP2inL5RC5rmh3FlHfJMFtt
 lPO/oYlNdv+by9JGnpcen2O1AN07t5jyftnYezEnmHH2rHmgsbjtoo/afOASpM3NITTn aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsax09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:07:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E14A100038;
        Wed, 27 Nov 2019 11:07:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C806E2B11EF;
        Wed, 27 Nov 2019 11:07:15 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Nov 2019 11:07:15
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH] iio: adc: stm32-dfsdm: adapt sampling rate to oversampling ratio
Date:   Wed, 27 Nov 2019 11:07:12 +0100
Message-ID: <20191127100712.24558-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update sampling rate when oversampling ratio is changed
through the IIO ABI.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 32 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 0339ecdd06bd..87a842507509 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1221,14 +1221,32 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 	unsigned int spi_freq;
 	int ret = -EINVAL;
 
+	switch (ch->src) {
+	case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL:
+		spi_freq = adc->dfsdm->spi_master_freq;
+		break;
+	case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING:
+	case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING:
+		spi_freq = adc->dfsdm->spi_master_freq / 2;
+		break;
+	default:
+		spi_freq = adc->spi_freq;
+	}
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
+
 		ret = stm32_dfsdm_compute_all_osrs(indio_dev, val);
-		if (!ret)
+		if (!ret) {
+			dev_dbg(&indio_dev->dev,
+				"Sampling rate changed from (%u) to (%u)\n",
+				adc->sample_freq, spi_freq / val);
 			adc->oversamp = val;
+			adc->sample_freq = spi_freq / val;
+		}
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
@@ -1240,18 +1258,6 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		switch (ch->src) {
-		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL:
-			spi_freq = adc->dfsdm->spi_master_freq;
-			break;
-		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING:
-		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING:
-			spi_freq = adc->dfsdm->spi_master_freq / 2;
-			break;
-		default:
-			spi_freq = adc->spi_freq;
-		}
-
 		ret = dfsdm_adc_set_samp_freq(indio_dev, val, spi_freq);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
-- 
2.17.1

