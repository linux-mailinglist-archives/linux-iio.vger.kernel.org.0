Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56C2FE946
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbhAULtD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 06:49:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9250 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730760AbhAULs4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 06:48:56 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10LBeZK8004255;
        Thu, 21 Jan 2021 06:47:57 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rce6sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 06:47:57 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10LBltKj005262
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 21 Jan 2021 06:47:56 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 21 Jan 2021 03:47:54 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 21 Jan 2021 03:47:54 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 21 Jan 2021 03:47:54 -0800
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10LBllDi013729;
        Thu, 21 Jan 2021 06:47:52 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/4] iio: adis16475: improve sync scale mode handling
Date:   Thu, 21 Jan 2021 12:49:53 +0100
Message-ID: <20210121114954.64156-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121114954.64156-1-nuno.sa@analog.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_04:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With this patch, we don't force users to define the IMU scaled internal
sampling rate once in the devicetree. Now it's dynamically calculated
at runtime depending on the desired output rate given by users.

Calculating the sync_scale dynamically gives us better chances of
achieving a perfect/integer value for DEC_RATE (thus giving more
flexibility). The math is:
 1. lcm of the input clock and the desired output rate.
 2. get the highest multiple of the previous result lower than the adis
    max rate.
 3. The last result becomes the IMU sample rate. Use that to calculate
    SYNC_SCALE and DEC_RATE (to get the user output rate).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 110 +++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 197d48240991..cd44226d0672 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -17,6 +17,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/irq.h>
+#include <linux/lcm.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -101,6 +102,7 @@ struct adis16475 {
 	u32 clk_freq;
 	bool burst32;
 	unsigned long lsb_flag;
+	u16 sync_mode;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16475_MAX_SCAN_DATA] __aligned(8);
 };
@@ -253,25 +255,90 @@ static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 {
 	int ret;
 	u16 dec;
+	u32 sample_rate = st->clk_freq;
+
+	adis_dev_lock(&st->adis);
+
+	if (st->sync_mode == ADIS16475_SYNC_SCALED) {
+		u16 sync_scale;
+
+		ret = __adis_read_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, &sync_scale);
+		if (ret)
+			goto error;
+
+		sample_rate = st->clk_freq * sync_scale;
+	}
 
-	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, &dec);
+	ret = __adis_read_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, &dec);
 	if (ret)
-		return -EINVAL;
+		goto error;
+
+	adis_dev_unlock(&st->adis);
 
-	*freq = DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
+	*freq = DIV_ROUND_CLOSEST(sample_rate, dec + 1);
 
 	return 0;
+error:
+	adis_dev_unlock(&st->adis);
+	return ret;
 }
 
 static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 {
 	u16 dec;
 	int ret;
+	u32 sample_rate = st->clk_freq;
 
 	if (!freq)
 		return -EINVAL;
 
-	dec = DIV_ROUND_CLOSEST(st->clk_freq, freq);
+	adis_dev_lock(&st->adis);
+	/*
+	 * When using sync scaled mode, the input clock needs to be scaled so that we have
+	 * an IMU sample rate between (optimally) 1900 and 2100. After this, we can use the
+	 * decimation filter to lower the sampling rate in order to get what the user wants.
+	 * Optimally, the user sample rate is a multiple of both the IMU sample rate and
+	 * the input clock. Hence, calculating the sync_scale dynamically gives us better
+	 * chances of achieving a perfect/integer value for DEC_RATE. The math here is:
+	 *	1. lcm of the input clock and the desired output rate.
+	 *	2. get the highest multiple of the previous result lower than the adis max rate.
+	 *	3. The last result becomes the IMU sample rate. Use that to calculate SYNC_SCALE
+	 *	   and DEC_RATE (to get the user output rate)
+	 */
+	if (st->sync_mode == ADIS16475_SYNC_SCALED) {
+		unsigned long scaled_rate = lcm(st->clk_freq, freq);
+		int sync_scale;
+		struct device *dev = &st->adis.spi->dev;
+
+		/*
+		 * If lcm is bigger than the IMU maximum sampling rate there's no perfect
+		 * solution. In this case, we get the highest multiple of the input clock
+		 * lower that the IMU max sample rate.
+		 */
+		if (scaled_rate > 2100000)
+			scaled_rate = 2100000 / st->clk_freq * st->clk_freq;
+		else
+			scaled_rate = 2100000 / scaled_rate * scaled_rate;
+
+		/*
+		 * This is not an hard requirement but it's not advised to run the IMU
+		 * with a sample rate lower than 1900Hz due to possible undersampling
+		 * issues so we will log a warning here. We could even force the rate
+		 * to 1900 but some users might really want this...
+		 */
+		if (scaled_rate < 1900000)
+			dev_warn(dev, "Possible undersampling issues due to sampling rate=%lu < 1900\n",
+				 scaled_rate / 1000);
+
+		sync_scale = scaled_rate / st->clk_freq;
+		ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, sync_scale);
+		if (ret)
+			goto error;
+
+		sample_rate = scaled_rate;
+	}
+
+	dec = DIV_ROUND_CLOSEST(sample_rate, freq);
 
 	if (dec)
 		dec--;
@@ -281,7 +348,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 
 	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
 	if (ret)
-		return ret;
+		goto error;
 
 	/*
 	 * If decimation is used, then gyro and accel data will have meaningful
@@ -290,6 +357,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
 
 	return 0;
+error:
+	adis_dev_unlock(&st->adis);
+	return ret;
 }
 
 /* The values are approximated. */
@@ -1085,6 +1155,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	}
 
 	sync = &st->info->sync[sync_mode];
+	st->sync_mode = sync->sync_mode;
 
 	/* All the other modes require external input signal */
 	if (sync->sync_mode != ADIS16475_SYNC_OUTPUT) {
@@ -1112,37 +1183,20 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 
 		if (sync->sync_mode == ADIS16475_SYNC_SCALED) {
 			u16 up_scale;
-			u32 scaled_out_freq = 0;
+
 			/*
-			 * If we are in scaled mode, we must have an up_scale.
-			 * In scaled mode the allowable input clock range is
-			 * 1 Hz to 128 Hz, and the allowable output range is
-			 * 1900 to 2100 Hz. Hence, a scale must be given to
-			 * get the allowable output.
+			 * In sync scaled mode, the IMU sample rate is the clk_freq * sync_scale.
+			 * Hence, default the IMU sample rate to the highest multiple of the input
+			 * clock lower than the IMU max sample rate. The optimal range is
+			 * 1900-2100 sps...
 			 */
-			ret = device_property_read_u32(dev,
-						       "adi,scaled-output-hz",
-						       &scaled_out_freq);
-			if (ret) {
-				dev_err(dev, "adi,scaled-output-hz must be given when in scaled sync mode");
-				return -EINVAL;
-			} else if (scaled_out_freq < 1900 ||
-				   scaled_out_freq > 2100) {
-				dev_err(dev, "Invalid value: %u for adi,scaled-output-hz",
-					scaled_out_freq);
-				return -EINVAL;
-			}
-
-			up_scale = DIV_ROUND_CLOSEST(scaled_out_freq,
-						     st->clk_freq);
+			up_scale = 2100 / st->clk_freq;
 
 			ret = __adis_write_reg_16(&st->adis,
 						  ADIS16475_REG_UP_SCALE,
 						  up_scale);
 			if (ret)
 				return ret;
-
-			st->clk_freq = scaled_out_freq;
 		}
 
 		st->clk_freq *= 1000;
-- 
2.30.0

