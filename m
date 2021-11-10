Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0B44BFD1
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 12:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKJLK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 06:10:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13096 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhKJLK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 06:10:28 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA82ZPH018401;
        Wed, 10 Nov 2021 06:07:40 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c8a7p0jdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 06:07:40 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AAB7cRI020129
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 06:07:38 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 10 Nov 2021
 03:07:37 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 10 Nov 2021 03:07:37 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AAB7ODA030773;
        Wed, 10 Nov 2021 06:07:34 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 5/5] iio: adc: ad7192: add sequencer support
Date:   Wed, 10 Nov 2021 13:17:50 +0200
Message-ID: <20211110111750.27263-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110111750.27263-1-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bYZI2FYpJ58SNFrG_jlAls_x1HOdq3fa
X-Proofpoint-GUID: bYZI2FYpJ58SNFrG_jlAls_x1HOdq3fa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111100059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add sequencer support for AD7192.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7192.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1fc0f4eb858e..e70f86d9a219 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -58,7 +58,8 @@
 /* Mode Register Bit Designations (AD7192_REG_MODE) */
 #define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
 #define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
-#define AD7192_MODE_DAT_STA	BIT(20) /* Status Register transmission */
+#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
+#define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
@@ -287,12 +288,25 @@ static int ad7192_set_mode(struct ad_sigma_delta *sd,
 	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 }
 
+static int ad7192_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
+
+	st->mode &= ~AD7192_MODE_STA_MASK;
+	st->mode |= AD7192_MODE_STA(append);
+
+	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+}
+
 static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.set_channel = ad7192_set_channel,
+	.append_status = ad7192_append_status,
 	.set_mode = ad7192_set_mode,
 	.has_registers = true,
 	.addr_shift = 3,
 	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.num_slots = 4,
 	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
-- 
2.25.1

