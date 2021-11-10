Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6662644BFCF
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKJLK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 06:10:27 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8662 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231418AbhKJLKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 06:10:25 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA6IBfJ012022;
        Wed, 10 Nov 2021 06:07:37 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c88pq8vgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 06:07:36 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AAB7ZEl020124
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 06:07:35 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 06:07:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 06:07:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 10 Nov 2021 06:07:34 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AAB7OD9030773;
        Wed, 10 Nov 2021 06:07:33 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 4/5] iio: adc: ad7124: add sequencer support
Date:   Wed, 10 Nov 2021 13:17:49 +0200
Message-ID: <20211110111750.27263-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110111750.27263-1-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: z7_7OhXN6BnWvtIgb-DzmeX1j_4wbcP5
X-Proofpoint-GUID: z7_7OhXN6BnWvtIgb-DzmeX1j_4wbcP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add sequencer support for AD7124.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 30299b899799..5760a222df5f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -43,6 +43,8 @@
 #define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_STATUS_EN_MSK	BIT(10)
+#define AD7124_ADC_STATUS_EN(x)		FIELD_PREP(AD7124_ADC_STATUS_EN_MSK, x)
 #define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
 #define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
 #define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
@@ -512,14 +514,27 @@ static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 	return ret;
 }
 
+static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	st->adc_control &= ~AD7124_ADC_STATUS_EN_MSK;
+	st->adc_control |= AD7124_ADC_STATUS_EN(append);
+
+	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+}
+
 static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.set_channel = ad7124_set_channel,
+	.append_status = ad7124_append_status,
 	.set_mode = ad7124_set_mode,
 	.has_registers = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7124_DATA,
-	.irq_flags = IRQF_TRIGGER_FALLING
+	.num_slots = 8,
+	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
 static int ad7124_read_raw(struct iio_dev *indio_dev,
-- 
2.25.1

