Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD49144DFE
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVIyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 03:54:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18648 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgAVIyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 03:54:32 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M8j9l1010854;
        Wed, 22 Jan 2020 03:54:29 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbj8hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 03:54:29 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00M8sS6P017807
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jan 2020 03:54:28 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Jan
 2020 03:54:27 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jan 2020 00:54:27 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00M8sPUP021932;
        Wed, 22 Jan 2020 03:54:25 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: adc: ad7124: add 3db filter
Date:   Wed, 22 Jan 2020 10:54:14 +0200
Message-ID: <20200122085414.16950-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds the LOW_PASS_FILTER_3DB_FREQUENCY attribute
in iio_chan_spec for each channel. The used filters are sinc3
or sinc4. The filter type with the highest output data rate
is used when setting a low pass frequency in the channel's sysfs.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 52f45b13da4a..8f48c0581f02 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -70,6 +70,11 @@
 /* AD7124_FILTER_X */
 #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
 #define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
+#define AD7124_FILTER_TYPE_MSK		GENMASK(23, 21)
+#define AD7124_FILTER_TYPE_SEL(x)	FIELD_PREP(AD7124_FILTER_TYPE_MSK, x)
+
+#define AD7124_SINC3_FILTER 2
+#define AD7124_SINC4_FILTER 0
 
 enum ad7124_ids {
 	ID_AD7124_4,
@@ -119,6 +124,7 @@ struct ad7124_channel_config {
 	unsigned int vref_mv;
 	unsigned int pga_bits;
 	unsigned int odr;
+	unsigned int filter_type;
 };
 
 struct ad7124_state {
@@ -138,7 +144,8 @@ static const struct iio_chan_spec ad7124_channel_template = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,
@@ -281,6 +288,58 @@ static int ad7124_set_channel_gain(struct ad7124_state *st,
 	return 0;
 }
 
+static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
+				      unsigned int channel)
+{
+	unsigned int fadc;
+
+	fadc = st->channel_config[channel].odr;
+
+	switch (st->channel_config[channel].filter_type) {
+	case AD7124_SINC3_FILTER:
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+	case AD7124_SINC4_FILTER:
+		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
+				      unsigned int channel,
+				      unsigned int freq)
+{
+	unsigned int sinc4_3db_odr;
+	unsigned int sinc3_3db_odr;
+	unsigned int new_filter;
+	unsigned int new_odr;
+
+	sinc4_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 230);
+	sinc3_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 262);
+
+	if (sinc4_3db_odr > sinc3_3db_odr) {
+		new_filter = AD7124_SINC3_FILTER;
+		new_odr = sinc4_3db_odr;
+	} else {
+		new_filter = AD7124_SINC4_FILTER;
+		new_odr = sinc3_3db_odr;
+	}
+
+	if (st->channel_config[channel].filter_type != new_filter) {
+		int ret;
+
+		st->channel_config[channel].filter_type = new_filter;
+		ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
+					    AD7124_FILTER_TYPE_MSK,
+					    AD7124_FILTER_TYPE_SEL(new_filter),
+					    3);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ad7124_set_channel_odr(st, channel, new_odr);
+}
+
 static int ad7124_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -322,6 +381,9 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = st->channel_config[chan->address].odr;
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = ad7124_get_3db_filter_freq(st, chan->scan_index);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -355,6 +417,11 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 		gain = DIV_ROUND_CLOSEST(res, val2);
 
 		return ad7124_set_channel_gain(st, chan->address, gain);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ad7124_set_3db_filter_freq(st, chan->address, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

