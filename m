Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028E518DEF9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgCUJIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:08:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27284 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbgCUJIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:08:51 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L97Ee4020975;
        Sat, 21 Mar 2020 05:08:35 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu501fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:08:34 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02L98Xal009387
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:08:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sat, 21 Mar
 2020 05:08:32 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 05:08:32 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L98VkS010119;
        Sat, 21 Mar 2020 05:08:31 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/5] iio: adc: ad7780: define/use own IIO channel macros
Date:   Sat, 21 Mar 2020 11:07:58 +0200
Message-ID: <20200321090802.11537-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003210053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change gets rid of the AD_SD_*_CHANNEL macros in favor of defining
it's own. The ad7780 is quite simpler than it's other Sigma-Delta brothers.

It turned out that centralizing the AD_SD_*_CHANNEL macros doesn't scale
too well, especially with some more complicated drivers. Some of the
variations in the more complicated drivers require new macros, and that way
things can become harder to maintain.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* re-send + change author @analog.com; GMail messed it up

 drivers/iio/adc/ad7780.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 291c1a898129..f47606ebbbbe 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -206,10 +206,29 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
-#define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL(1, 0, 0, bits, 32, (wordsize) - (bits))
-#define AD7170_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, (wordsize) - (bits))
+#define _AD7780_CHANNEL(_bits, _wordsize, _mask_all)		\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = 0,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_OFFSET),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all = _mask_all,			\
+	.scan_index = 1,					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 32,				\
+		.shift = (_wordsize) - (_bits),			\
+		.endianness = IIO_BE,				\
+	},							\
+}
+
+#define AD7780_CHANNEL(_bits, _wordsize)	\
+	_AD7780_CHANNEL(_bits, _wordsize, BIT(IIO_CHAN_INFO_SAMP_FREQ))
+#define AD7170_CHANNEL(_bits, _wordsize)	\
+	_AD7780_CHANNEL(_bits, _wordsize, 0)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-- 
2.17.1

