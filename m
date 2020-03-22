Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF118E99D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVP1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:27:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53016 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgCVP1h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 11:27:37 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MFOvBe003233;
        Sun, 22 Mar 2020 11:27:23 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5uuap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 11:27:23 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02MFRM74063936
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 22 Mar 2020 11:27:22 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 22 Mar 2020 11:27:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 22 Mar 2020 11:27:21 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 22 Mar 2020 11:27:21 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02MFRJf0019168;
        Sun, 22 Mar 2020 11:27:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3] iio: adc: ad7793: use read_avail iio hook for scale available
Date:   Sun, 22 Mar 2020 17:26:56 +0200
Message-ID: <20200322152656.41669-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_05:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220093
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change uses the read_avail and '.info_mask_shared_by_type_available'
modifier to set the available scale.
Essentially, nothing changes to the driver's ABI.

The main idea for this patch is to remove the AD7793 driver from
checkpatch's radar. There have been about ~3 attempts to fix/break the
'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
it to be an arithmetic operation and people were trying to change that.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* split from series https://patchwork.kernel.org/project/linux-iio/list/?series=259659
* moved -EINVAL return to default case

 drivers/iio/adc/ad7793.c | 55 +++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5592ae573e6b..7005bde50a76 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -354,29 +354,28 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
 	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
 
-static ssize_t ad7793_show_scale_available(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static int ad7793_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7793_state *st = iio_priv(indio_dev);
-	int i, len = 0;
 
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
-			       st->scale_avail[i][1]);
-
-	len += sprintf(buf + len, "\n");
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		/* Values are stored in a 2D matrix  */
+		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
-	return len;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
 }
 
-static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
-		in_voltage-voltage_scale_available, S_IRUGO,
-		ad7793_show_scale_available, NULL, 0);
-
 static struct attribute *ad7793_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
 	NULL
 };
 
@@ -534,6 +533,7 @@ static const struct iio_info ad7793_info = {
 	.read_raw = &ad7793_read_raw,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
+	.read_avail = ad7793_read_avail,
 	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
@@ -547,7 +547,7 @@ static const struct iio_info ad7797_info = {
 };
 
 #define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift, _extend_name, _type, _mask_all) \
+	_storagebits, _shift, _extend_name, _type, _mask_type_av, _mask_all) \
 	{ \
 		.type = (_type), \
 		.differential = (_channel2 == -1 ? 0 : 1), \
@@ -559,6 +559,7 @@ static const struct iio_info ad7797_info = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 			BIT(IIO_CHAN_INFO_OFFSET), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type_available = (_mask_type_av), \
 		.info_mask_shared_by_all = _mask_all, \
 		.scan_index = (_si), \
 		.scan_type = { \
@@ -574,23 +575,41 @@ static const struct iio_info ad7797_info = {
 	_storagebits, _shift) \
 	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
 	_storagebits, _shift) \
 	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
 		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
 	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_TEMP, \
+		0, \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
 	_shift) \
 	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
 		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7797_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7797_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		0, \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
@@ -620,8 +639,8 @@ const struct iio_chan_spec _name##_channels[] = { \
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7797_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7797_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
 	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
 	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
-- 
2.17.1

