Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B118DEF8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgCUJIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:08:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27288 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728205AbgCUJIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:08:51 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L94k0R023184;
        Sat, 21 Mar 2020 05:08:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5rem8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:08:39 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02L98cuI050782
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:08:38 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:08:37 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:07:14 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 02:08:36 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L98VkU010119;
        Sat, 21 Mar 2020 05:08:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/5] iio: adc: ad7793: define/use own IIO channel macros
Date:   Sat, 21 Mar 2020 11:08:00 +0200
Message-ID: <20200321090802.11537-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200321090802.11537-1-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver seems to use most of the AD_SD_*_CHANNEL. This change will move
them in the driver. The intent is that if a new part comes along which
would require tweaks per IIO channel, these should be doable in the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7793.c | 95 ++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b747db97f78a..5592ae573e6b 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -546,47 +546,94 @@ static const struct iio_info ad7797_info = {
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
+#define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift, _extend_name, _type, _mask_all) \
+	{ \
+		.type = (_type), \
+		.differential = (_channel2 == -1 ? 0 : 1), \
+		.indexed = 1, \
+		.channel = (_channel1), \
+		.channel2 = (_channel2), \
+		.address = (_address), \
+		.extend_name = (_extend_name), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = _mask_all, \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 'u', \
+			.realbits = (_bits), \
+			.storagebits = (_storagebits), \
+			.shift = (_shift), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define AD7793_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
+	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_TEMP, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
+	_shift) \
+	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
-	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
+	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
+	AD7793_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
+	AD7793_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
 	IIO_CHAN_SOFT_TIMESTAMP(6), \
 }
 
 #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(9), \
 }
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(5), \
 }
 
-- 
2.17.1

