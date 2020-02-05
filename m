Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB56215361C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBERPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 12:15:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727443AbgBERPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 12:15:33 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015HEBuW022135;
        Wed, 5 Feb 2020 12:15:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhm9280g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 12:15:31 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 015HFUMu030470
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Feb 2020 12:15:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 5 Feb 2020
 12:15:29 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 5 Feb 2020 12:15:29 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 015HFNaj010661;
        Wed, 5 Feb 2020 12:15:26 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 2/5 V2] staging: iio: adc: ad7192: modify iio_chan_spec array
Date:   Wed, 5 Feb 2020 19:15:08 +0200
Message-ID: <20200205171511.25912-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171511.25912-1-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
 <20200205171511.25912-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_05:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch changes the static const struct iio_chan_spec arrays
in a way that all the necessary attributes are set at
compile time. Now ad7192_channels_config only makes the
channels attribute of iio_dev point to the right array depending
on the chip.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 112 ++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 4780ddf99b13..8f2fa154876a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -786,73 +786,93 @@ static const struct iio_info ad7195_info = {
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
+#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
+	_type, _mask_type_av, _ext_info) \
+	{ \
+		.type = (_type), \
+		.differential = ((_channel2) == -1 ? 0 : 1), \
+		.indexed = 1, \
+		.channel = (_channel1), \
+		.channel2 = (_channel2), \
+		.address = (_address), \
+		.extend_name = (_extend_name), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.info_mask_shared_by_type_available = (_mask_type_av), \
+		.ext_info = (_ext_info), \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 'u', \
+			.realbits = 24, \
+			.storagebits = 32, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
+	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, NULL, \
+		IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE), \
+		ad7192_calibsys_ext_info)
+
+#define AD719x_CHANNEL(_si, _channel1, _address) \
+	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
+
+#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
+	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
+
+#define AD719x_TEMP_CHANNEL(_si, _address) \
+	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
+
 static const struct iio_chan_spec ad7192_channels[] = {
-	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0),
-	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0),
-	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0),
-	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0),
-	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0),
-	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0),
-	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0),
-	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0),
+	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
+	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
+	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
+	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
+	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
+	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
+	AD719x_CHANNEL(7, 4, AD7192_CH_AIN4),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 static const struct iio_chan_spec ad7193_channels[] = {
-	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M, 24, 32, 0),
-	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M, 24, 32, 0),
-	AD_SD_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M, 24, 32, 0),
-	AD_SD_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M, 24, 32, 0),
-	AD_SD_TEMP_CHANNEL(4, AD7193_CH_TEMP, 24, 32, 0),
-	AD_SD_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M, 24, 32, 0),
-	AD_SD_CHANNEL(6, 1, AD7193_CH_AIN1, 24, 32, 0),
-	AD_SD_CHANNEL(7, 2, AD7193_CH_AIN2, 24, 32, 0),
-	AD_SD_CHANNEL(8, 3, AD7193_CH_AIN3, 24, 32, 0),
-	AD_SD_CHANNEL(9, 4, AD7193_CH_AIN4, 24, 32, 0),
-	AD_SD_CHANNEL(10, 5, AD7193_CH_AIN5, 24, 32, 0),
-	AD_SD_CHANNEL(11, 6, AD7193_CH_AIN6, 24, 32, 0),
-	AD_SD_CHANNEL(12, 7, AD7193_CH_AIN7, 24, 32, 0),
-	AD_SD_CHANNEL(13, 8, AD7193_CH_AIN8, 24, 32, 0),
+	AD719x_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
+	AD719x_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
+	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
+	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
+	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
+	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
+	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
+	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
+	AD719x_CHANNEL(9, 4, AD7193_CH_AIN4),
+	AD719x_CHANNEL(10, 5, AD7193_CH_AIN5),
+	AD719x_CHANNEL(11, 6, AD7193_CH_AIN6),
+	AD719x_CHANNEL(12, 7, AD7193_CH_AIN7),
+	AD719x_CHANNEL(13, 8, AD7193_CH_AIN8),
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
 static int ad7192_channels_config(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	const struct iio_chan_spec *channels;
-	struct iio_chan_spec *chan;
-	int i;
 
 	switch (st->devid) {
 	case ID_AD7193:
-		channels = ad7193_channels;
+		indio_dev->channels = ad7193_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
 		break;
 	default:
-		channels = ad7192_channels;
+		indio_dev->channels = ad7192_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
 		break;
 	}
 
-	chan = devm_kcalloc(indio_dev->dev.parent, indio_dev->num_channels,
-			    sizeof(*chan), GFP_KERNEL);
-	if (!chan)
-		return -ENOMEM;
-
-	indio_dev->channels = chan;
-
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		*chan = channels[i];
-		chan->info_mask_shared_by_all |=
-			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
-		if (chan->type != IIO_TEMP) {
-			chan->info_mask_shared_by_type_available |=
-				BIT(IIO_CHAN_INFO_SCALE);
-			chan->ext_info = ad7192_calibsys_ext_info;
-		}
-		chan++;
-	}
-
 	return 0;
 }
 
-- 
2.20.1

