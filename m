Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289731E969
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhBRL4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:56:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35168 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhBRLjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 06:39:35 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IBUUKG028885;
        Thu, 18 Feb 2021 06:38:35 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb6ssc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 06:38:35 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11IBcXCt054485
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 18 Feb 2021 06:38:34 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 18 Feb
 2021 03:38:32 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 18 Feb 2021 03:38:32 -0800
Received: from nsa.sphairon.box ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11IBcOr2013165;
        Thu, 18 Feb 2021 06:38:30 -0500
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 4/4] iio: adis: add helpers for locking
Date:   Thu, 18 Feb 2021 12:40:39 +0100
Message-ID: <20210218114039.216091-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210218114039.216091-1-nuno.sa@analog.com>
References: <20210218114039.216091-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_04:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some helpers to lock and unlock the device. As this is such a simple
change, we update all the users that were using the lock already in this
patch.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c  | 22 ++++++++++------------
 drivers/iio/imu/adis16475.c  | 10 +++++-----
 drivers/iio/imu/adis16480.c  | 15 +++++++--------
 include/linux/iio/imu/adis.h | 10 ++++++++++
 4 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 54af2ed664f6..b1ec14bf439f 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -505,7 +505,6 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long info)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	struct mutex *slock = &st->adis.state_lock;
 	int ret, sps;
 
 	switch (info) {
@@ -518,18 +517,18 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 		 * Need to cache values so we can update if the frequency
 		 * changes.
 		 */
-		mutex_lock(slock);
+		adis_dev_lock(&st->adis);
 		st->filt_int = val;
 		/* Work out update to current value */
 		sps = st->variant->get_freq(st);
 		if (sps < 0) {
-			mutex_unlock(slock);
+			adis_dev_unlock(&st->adis);
 			return sps;
 		}
 
 		ret = __adis16400_set_filter(indio_dev, sps,
 			val * 1000 + val2 / 1000);
-		mutex_unlock(slock);
+		adis_dev_unlock(&st->adis);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		sps = val * 1000 + val2 / 1000;
@@ -537,9 +536,9 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 		if (sps <= 0)
 			return -EINVAL;
 
-		mutex_lock(slock);
+		adis_dev_lock(&st->adis);
 		ret = st->variant->set_freq(st, sps);
-		mutex_unlock(slock);
+		adis_dev_unlock(&st->adis);
 		return ret;
 	default:
 		return -EINVAL;
@@ -550,7 +549,6 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	struct mutex *slock = &st->adis.state_lock;
 	int16_t val16;
 	int ret;
 
@@ -606,17 +604,17 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = st->variant->temp_offset;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		mutex_lock(slock);
+		adis_dev_lock(&st->adis);
 		/* Need both the number of taps and the sampling frequency */
 		ret = __adis_read_reg_16(&st->adis,
 						ADIS16400_SENS_AVG,
 						&val16);
 		if (ret) {
-			mutex_unlock(slock);
+			adis_dev_unlock(&st->adis);
 			return ret;
 		}
 		ret = st->variant->get_freq(st);
-		mutex_unlock(slock);
+		adis_dev_unlock(&st->adis);
 		if (ret)
 			return ret;
 		ret /= adis16400_3db_divisors[val16 & 0x07];
@@ -624,9 +622,9 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val2 = (ret % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(slock);
+		adis_dev_lock(&st->adis);
 		ret = st->variant->get_freq(st);
-		mutex_unlock(slock);
+		adis_dev_unlock(&st->adis);
 		if (ret)
 			return ret;
 		*val = ret / 1000;
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 5759cd8ffbef..8f6bea4b6608 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -263,7 +263,7 @@ static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 	u16 dec;
 	u32 sample_rate = st->clk_freq;
 
-	mutex_lock(&st->adis.state_lock);
+	adis_dev_lock(&st->adis);
 
 	if (st->sync_mode == ADIS16475_SYNC_SCALED) {
 		u16 sync_scale;
@@ -279,13 +279,13 @@ static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 	if (ret)
 		goto error;
 
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 
 	*freq = DIV_ROUND_CLOSEST(sample_rate, dec + 1);
 
 	return 0;
 error:
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 	return ret;
 }
 
@@ -298,7 +298,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	if (!freq)
 		return -EINVAL;
 
-	mutex_lock(&st->adis.state_lock);
+	adis_dev_lock(&st->adis);
 	/*
 	 * When using sync scaled mode, the input clock needs to be scaled so that we have
 	 * an IMU sample rate between (optimally) 1900 and 2100. After this, we can use the
@@ -366,7 +366,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 
 	return 0;
 error:
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 	return ret;
 }
 
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index c41b8ef1e250..f81b86690b76 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -329,7 +329,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (t == 0)
 		return -EINVAL;
 
-	mutex_lock(&st->adis.state_lock);
+	adis_dev_lock(&st->adis);
 	/*
 	 * When using PPS mode, the input clock needs to be scaled so that we have an IMU
 	 * sample rate between (optimally) 4000 and 4250. After this, we can use the
@@ -386,7 +386,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 
 	ret = __adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
 error:
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 	return ret;
 }
 
@@ -397,7 +397,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	int ret;
 	unsigned int freq, sample_rate = st->clk_freq;
 
-	mutex_lock(&st->adis.state_lock);
+	adis_dev_lock(&st->adis);
 
 	if (st->clk_mode == ADIS16480_CLK_PPS) {
 		u16 sync_scale;
@@ -413,7 +413,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	if (ret)
 		goto error;
 
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 
 	freq = DIV_ROUND_CLOSEST(sample_rate, (t + 1));
 
@@ -422,7 +422,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 
 	return IIO_VAL_INT_PLUS_MICRO;
 error:
-	mutex_unlock(&st->adis.state_lock);
+	adis_dev_unlock(&st->adis);
 	return ret;
 }
 
@@ -598,7 +598,6 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int freq)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
-	struct mutex *slock = &st->adis.state_lock;
 	unsigned int enable_mask, offset, reg;
 	unsigned int diff, best_diff;
 	unsigned int i, best_freq;
@@ -609,7 +608,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	offset = ad16480_filter_data[chan->scan_index][1];
 	enable_mask = BIT(offset + 2);
 
-	mutex_lock(slock);
+	adis_dev_lock(&st->adis);
 
 	ret = __adis_read_reg_16(&st->adis, reg, &val);
 	if (ret)
@@ -637,7 +636,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 
 	ret = __adis_write_reg_16(&st->adis, reg, val);
 out_unlock:
-	mutex_unlock(slock);
+	adis_dev_unlock(&st->adis);
 
 	return ret;
 }
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 04e96d688ba9..f9b728d490b1 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -428,6 +428,16 @@ static inline int adis_initial_startup(struct adis *adis)
 	return ret;
 }
 
+static inline void adis_dev_lock(struct adis *adis)
+{
+	mutex_lock(&adis->state_lock);
+}
+
+static inline void adis_dev_unlock(struct adis *adis)
+{
+	mutex_unlock(&adis->state_lock);
+}
+
 int adis_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int error_mask,
 	int *val);
-- 
2.30.1

