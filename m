Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BAC18DEFE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgCUJJE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:09:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27420 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbgCUJIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:08:52 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L94hoR022869;
        Sat, 21 Mar 2020 05:08:40 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5rema-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:08:40 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02L98cOH009406
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:08:39 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:08:38 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 02:08:37 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L98VkV010119;
        Sat, 21 Mar 2020 05:08:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/5] iio: ad_sigma_delta: remove unused IIO channel macros
Date:   Sat, 21 Mar 2020 11:08:01 +0200
Message-ID: <20200321090802.11537-4-alexandru.ardelean@analog.com>
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

Now that all channel SigmaDelta IIO channel macros have been localized,
remove the generic ones.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 58 --------------------------
 1 file changed, 58 deletions(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5a127c0ed200..a3a838dcf8e4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -133,62 +133,4 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
 
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
-#define __AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift, _extend_name, _type, _mask_all) \
-	{ \
-		.type = (_type), \
-		.differential = (_channel2 == -1 ? 0 : 1), \
-		.indexed = 1, \
-		.channel = (_channel1), \
-		.channel2 = (_channel2), \
-		.address = (_address), \
-		.extend_name = (_extend_name), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-			BIT(IIO_CHAN_INFO_OFFSET), \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-		.info_mask_shared_by_all = _mask_all, \
-		.scan_index = (_si), \
-		.scan_type = { \
-			.sign = 'u', \
-			.realbits = (_bits), \
-			.storagebits = (_storagebits), \
-			.shift = (_shift), \
-			.endianness = IIO_BE, \
-		}, \
-	}
-
-#define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, _channel, _address, _bits, \
-		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, \
-		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_CHANNEL_NO_SAMP_FREQ(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
-
-#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_TEMP, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
-	_shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, "supply", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
 #endif
-- 
2.17.1

