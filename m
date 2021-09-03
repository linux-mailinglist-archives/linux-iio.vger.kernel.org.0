Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164EE400117
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhICOMo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17772 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhICOMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:43 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1838x6u6008658;
        Fri, 3 Sep 2021 10:11:33 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3augp61ck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:32 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 183EBVI4040552
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 3 Sep 2021 10:11:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 3 Sep 2021 10:11:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 3 Sep 2021 10:11:30 -0400
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFF024311;
        Fri, 3 Sep 2021 10:11:29 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 5/5] iio: adis16480: fix devices that do not support sleep mode
Date:   Fri, 3 Sep 2021 16:14:23 +0200
Message-ID: <20210903141423.517028-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LbveKb0kfjuX2CD74A-Yb6QjcWup-bzo
X-Proofpoint-ORIG-GUID: LbveKb0kfjuX2CD74A-Yb6QjcWup-bzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Not all devices supported by this driver support being put to sleep
mode. For those devices, when calling 'adis16480_stop_device()' on the
unbind path, we where actually writing in the SYNC_SCALE register.

Fixes: 80cbc848c4fa0 ("iio: imu: adis16480: Add support for ADIS16490")
Fixes: 82e7a1b250170 ("iio: imu: adis16480: Add support for ADIS1649x family of devices")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index a869a6e52a16..ed129321a14d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -144,6 +144,7 @@ struct adis16480_chip_info {
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
+	bool has_sleep_cnt;
 	const struct adis_data adis_data;
 };
 
@@ -939,6 +940,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
 	},
@@ -952,6 +954,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
 	},
@@ -965,6 +968,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
 	},
@@ -978,6 +982,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
 	},
@@ -1425,9 +1430,12 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, adis16480_stop, indio_dev);
-	if (ret)
-		return ret;
+	if (st->chip_info->has_sleep_cnt) {
+		ret = devm_add_action_or_reset(&spi->dev, adis16480_stop,
+					       indio_dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
 	if (ret)
-- 
2.33.0

