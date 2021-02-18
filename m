Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7631E967
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 13:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBRLzc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:55:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31790 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231791AbhBRLj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 06:39:26 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IBUh8u031307;
        Thu, 18 Feb 2021 06:38:31 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjaxkwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 06:38:31 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11IBcUmU054476
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Feb 2021 06:38:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 18 Feb 2021
 06:38:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 18 Feb 2021 06:38:29 -0500
Received: from nsa.sphairon.box ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11IBcOqx013165;
        Thu, 18 Feb 2021 06:38:26 -0500
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 1/4] iio: adis16480: fix pps mode sampling frequency math
Date:   Thu, 18 Feb 2021 12:40:36 +0100
Message-ID: <20210218114039.216091-2-nuno.sa@analog.com>
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
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When using PPS mode, the input clock needs to be scaled so that we have
an IMU sample rate between (optimally) 4000 and 4250. After this, we can
use the decimation filter to lower the sampling rate in order to get what
the user wants. Optimally, the user sample rate is a multiple of both the
IMU sample rate and the input clock. Hence, calculating the sync_scale
dynamically gives us better chances of achieving a perfect/integer value
for DEC_RATE. The math here is:
 1. lcm of the input clock and the desired output rate.
 2. get the highest multiple of the previous result lower than the adis
    max rate.
 3. The last result becomes the IMU sample rate. Use that to calculate
    SYNC_SCALE and DEC_RATE (to get the user output rate).

Fixes: 326e2357553d3 ("iio: imu: adis16480: Add support for external clock")

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 128 ++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index dfe86c589325..c41b8ef1e250 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -10,6 +10,7 @@
 #include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/math.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -17,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/lcm.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -170,6 +172,11 @@ static const char * const adis16480_int_pin_names[4] = {
 	[ADIS16480_PIN_DIO4] = "DIO4",
 };
 
+static bool low_rate_allow;
+module_param(low_rate_allow, bool, 0444);
+MODULE_PARM_DESC(low_rate_allow,
+		 "Allow IMU rates below the minimum advisable when external clk is used in PPS mode (default: N)");
+
 #ifdef CONFIG_DEBUG_FS
 
 static ssize_t adis16480_show_firmware_revision(struct file *file,
@@ -312,7 +319,8 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
-	unsigned int t, reg;
+	unsigned int t, sample_rate = st->clk_freq;
+	int ret;
 
 	if (val < 0 || val2 < 0)
 		return -EINVAL;
@@ -321,28 +329,65 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (t == 0)
 		return -EINVAL;
 
+	mutex_lock(&st->adis.state_lock);
 	/*
-	 * When using PPS mode, the rate of data collection is equal to the
-	 * product of the external clock frequency and the scale factor in the
-	 * SYNC_SCALE register.
-	 * When using sync mode, or internal clock, the output data rate is
-	 * equal with  the clock frequency divided by DEC_RATE + 1.
+	 * When using PPS mode, the input clock needs to be scaled so that we have an IMU
+	 * sample rate between (optimally) 4000 and 4250. After this, we can use the
+	 * decimation filter to lower the sampling rate in order to get what the user wants.
+	 * Optimally, the user sample rate is a multiple of both the IMU sample rate and
+	 * the input clock. Hence, calculating the sync_scale dynamically gives us better
+	 * chances of achieving a perfect/integer value for DEC_RATE. The math here is:
+	 *	1. lcm of the input clock and the desired output rate.
+	 *	2. get the highest multiple of the previous result lower than the adis max rate.
+	 *	3. The last result becomes the IMU sample rate. Use that to calculate SYNC_SCALE
+	 *	   and DEC_RATE (to get the user output rate)
 	 */
 	if (st->clk_mode == ADIS16480_CLK_PPS) {
-		t = t / st->clk_freq;
-		reg = ADIS16495_REG_SYNC_SCALE;
-	} else {
-		t = st->clk_freq / t;
-		reg = ADIS16480_REG_DEC_RATE;
+		unsigned long scaled_rate = lcm(st->clk_freq, t);
+		int sync_scale;
+
+		/*
+		 * If lcm is bigger than the IMU maximum sampling rate there's no perfect
+		 * solution. In this case, we get the highest multiple of the input clock
+		 * lower than the IMU max sample rate.
+		 */
+		if (scaled_rate > st->chip_info->int_clk)
+			scaled_rate = st->chip_info->int_clk / st->clk_freq * st->clk_freq;
+		else
+			scaled_rate = st->chip_info->int_clk / scaled_rate * scaled_rate;
+
+		/*
+		 * This is not an hard requirement but it's not advised to run the IMU
+		 * with a sample rate lower than 4000Hz due to possible undersampling
+		 * issues. However, there are users that might really want to take the risk.
+		 * Hence, we provide a module parameter for them. If set, we allow sample
+		 * rates lower than 4KHz. By default, we won't allow this and we just roundup
+		 * the rate to the next multiple of the input clock bigger than 4KHz. This
+		 * is done like this as in some cases (when DEC_RATE is 0) might give
+		 * us the closest value to the one desired by the user...
+		 */
+		if (scaled_rate < 4000000 && !low_rate_allow)
+			scaled_rate = roundup(4000000, st->clk_freq);
+
+		sync_scale = scaled_rate / st->clk_freq;
+		ret = __adis_write_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, sync_scale);
+		if (ret)
+			goto error;
+
+		sample_rate = scaled_rate;
 	}
 
+	t = DIV_ROUND_CLOSEST(sample_rate, t);
+	if (t)
+		t--;
+
 	if (t > st->chip_info->max_dec_rate)
 		t = st->chip_info->max_dec_rate;
 
-	if ((t != 0) && (st->clk_mode != ADIS16480_CLK_PPS))
-		t--;
-
-	return adis_write_reg_16(&st->adis, reg, t);
+	ret = __adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
+error:
+	mutex_unlock(&st->adis.state_lock);
+	return ret;
 }
 
 static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
@@ -350,34 +395,35 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	struct adis16480 *st = iio_priv(indio_dev);
 	uint16_t t;
 	int ret;
-	unsigned int freq;
-	unsigned int reg;
+	unsigned int freq, sample_rate = st->clk_freq;
 
-	if (st->clk_mode == ADIS16480_CLK_PPS)
-		reg = ADIS16495_REG_SYNC_SCALE;
-	else
-		reg = ADIS16480_REG_DEC_RATE;
+	mutex_lock(&st->adis.state_lock);
+
+	if (st->clk_mode == ADIS16480_CLK_PPS) {
+		u16 sync_scale;
+
+		ret = __adis_read_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, &sync_scale);
+		if (ret)
+			goto error;
 
-	ret = adis_read_reg_16(&st->adis, reg, &t);
+		sample_rate = st->clk_freq * sync_scale;
+	}
+
+	ret = __adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
 	if (ret)
-		return ret;
+		goto error;
 
-	/*
-	 * When using PPS mode, the rate of data collection is equal to the
-	 * product of the external clock frequency and the scale factor in the
-	 * SYNC_SCALE register.
-	 * When using sync mode, or internal clock, the output data rate is
-	 * equal with  the clock frequency divided by DEC_RATE + 1.
-	 */
-	if (st->clk_mode == ADIS16480_CLK_PPS)
-		freq = st->clk_freq * t;
-	else
-		freq = st->clk_freq / (t + 1);
+	mutex_unlock(&st->adis.state_lock);
+
+	freq = DIV_ROUND_CLOSEST(sample_rate, (t + 1));
 
 	*val = freq / 1000;
 	*val2 = (freq % 1000) * 1000;
 
 	return IIO_VAL_INT_PLUS_MICRO;
+error:
+	mutex_unlock(&st->adis.state_lock);
+	return ret;
 }
 
 enum {
@@ -1278,6 +1324,20 @@ static int adis16480_probe(struct spi_device *spi)
 
 		st->clk_freq = clk_get_rate(st->ext_clk);
 		st->clk_freq *= 1000; /* micro */
+		if (st->clk_mode == ADIS16480_CLK_PPS) {
+			u16 sync_scale;
+
+			/*
+			 * In PPS mode, the IMU sample rate is the clk_freq * sync_scale. Hence,
+			 * default the IMU sample rate to the highest multiple of the input clock
+			 * lower than the IMU max sample rate. The internal sample rate is the
+			 * max...
+			 */
+			sync_scale = st->chip_info->int_clk / st->clk_freq;
+			ret = __adis_write_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, sync_scale);
+			if (ret)
+				return ret;
+		}
 	} else {
 		st->clk_freq = st->chip_info->int_clk;
 	}
-- 
2.30.1

