Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA82DBC77
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPINt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 03:13:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41520 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgLPINt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 03:13:49 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG8AEoY026748;
        Wed, 16 Dec 2020 03:12:51 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35cun8wc9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 03:12:51 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BG8CoEE001938
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 03:12:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2; Wed, 16 Dec 2020
 03:12:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 16 Dec 2020 03:12:49 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BG8CkZw028714;
        Wed, 16 Dec 2020 03:12:46 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: adc: ad7476: Add LTC2314-14 support
Date:   Wed, 16 Dec 2020 10:17:10 +0200
Message-ID: <20201216081710.89047-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

The LTC2314-14 is a 14-bit, 4.5Msps, serial sampling A/D converter that draws only
6.2mA from a wide range analog supply adjustable from 2.7V to 5.25V.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7476.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 66c55ae67791..d0c42c2d433b 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -67,6 +67,7 @@ enum ad7476_supported_device_ids {
 	ID_ADS7866,
 	ID_ADS7867,
 	ID_ADS7868,
+	ID_LTC2314_14,
 };
 
 static void ad7091_convst(struct ad7476_state *st)
@@ -248,6 +249,8 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	},
 	[ID_ADS7868] = {
 		.channel[0] = ADS786X_CHAN(8),
+	[ID_LTC2314_14] = {
+		.channel[0] = AD7940_CHAN(14),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 };
@@ -365,6 +368,7 @@ static const struct spi_device_id ad7476_id[] = {
 	{"ads7866", ID_ADS7866},
 	{"ads7867", ID_ADS7867},
 	{"ads7868", ID_ADS7868},
+	{"ltc2314-14", ID_LTC2314_14},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
-- 
2.17.1

