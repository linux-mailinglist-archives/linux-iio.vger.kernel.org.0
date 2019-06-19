Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA594B956
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 15:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFSNE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 09:04:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfFSNE1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 09:04:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCu4JD023632;
        Wed, 19 Jun 2019 15:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Snd2JSaEu7Z6XLdmFflA+YpQRWPbEmDirJH8rOIN+Hg=;
 b=gC2g+F4FLTf8VKpowhrkPjLvh3D1Z8GAwMlQcrwkCJqInZztHxLKi7EiFOGIcoW/A0cL
 8qsClG8aWxwyaxd89UcdM43p0QwEZiFKeuAqzkvXm/7AX7654e6Oi3VztmklY/ptDJ+Z
 ON680YGi/YAgsylciwmqJxfMhGQl+Zcujqu5qegb6YZNYEaJW9zSpAI00nCPkTc4WgVs
 JjSH9/rKKd4mn3knLbjuJfJPNAHl9H6OYJYKQstqcgim0+rMWdMXFBrGcDnYmfDH60dh
 yXu4eSrkGkzxLufxNpNl4FCKC1B1kzHH4X+XNHxz7QZivq5DI7HLCL+SwW583U7btRVG /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813c0a8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:03:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 639B631;
        Wed, 19 Jun 2019 13:03:57 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42B362831;
        Wed, 19 Jun 2019 13:03:57 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 15:03:57 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 15:03:56
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
Subject: [PATCH 2/5] iio: adc: stm32-dfsdm: fix data type
Date:   Wed, 19 Jun 2019 15:03:48 +0200
Message-ID: <1560949431-22948-3-git-send-email-olivier.moysan@st.com>
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

Fix the data type as DFSDM raw output is complements 2,
24bits left aligned in a 32-bit register.
This change does not affect AUDIO path
- Set data as signed for IIO (as for AUDIO)
- Set 8 bit right shift for IIO.
The 8 LSBs bits of data contains channel info and are masked.

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index cb596f104919..6b90a40882f2 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1365,11 +1365,11 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
 	if (adc->dev_data->type == DFSDM_AUDIO) {
-		ch->scan_type.sign = 's';
 		ch->ext_info = dfsdm_adc_audio_ext_info;
 	} else {
-		ch->scan_type.sign = 'u';
+		ch->scan_type.shift = 8;
 	}
+	ch->scan_type.sign = 's';
 	ch->scan_type.realbits = 24;
 	ch->scan_type.storagebits = 32;
 
-- 
2.7.4

