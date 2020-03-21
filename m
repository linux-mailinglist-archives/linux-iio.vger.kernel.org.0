Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BA18DEF6
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgCUJIu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:08:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26174 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbgCUJIu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:08:50 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L97K0h021046;
        Sat, 21 Mar 2020 05:08:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu501g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:08:38 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02L98ar2009402
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:08:37 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:08:35 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:08:35 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 02:08:35 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L98VkT010119;
        Sat, 21 Mar 2020 05:08:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/5] iio: adc: ad7791: define/use own IIO channel macros
Date:   Sat, 21 Mar 2020 11:07:59 +0200
Message-ID: <20200321090802.11537-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200321090802.11537-1-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
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

This driver seems to use most of the AD_SD_*_CHANNEL. This change will move
them in the driver. The intent is that if a new part comes along which
would require tweaks per IIO channel, these should be doable in the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7791.c | 62 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index abb239392631..ba22808507d0 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -64,25 +64,73 @@
 #define AD7791_MODE_SEL_MASK		(0x3 << 6)
 #define AD7791_MODE_SEL(x)		((x) << 6)
 
+#define __AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
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
+#define AD7991_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
+	_shift) \
+	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
 #define DECLARE_AD7787_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
+	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
-	AD_SD_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
+	AD7991_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
+	AD7991_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
+	AD7991_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
 		(bits), (storagebits), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7791_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
+	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
+	AD7991_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
+	AD7991_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
 		(bits), (storagebits), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(3), \
 }
-- 
2.17.1

