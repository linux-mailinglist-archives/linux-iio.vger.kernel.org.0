Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916DF31E95E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 12:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBRLzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:55:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32750 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231794AbhBRLj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 06:39:26 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IBUYjA029179;
        Thu, 18 Feb 2021 06:38:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb6ss8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 06:38:32 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11IBcUgk023543
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Feb 2021 06:38:31 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 18 Feb 2021
 03:38:29 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 18 Feb 2021 03:38:29 -0800
Received: from nsa.sphairon.box ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11IBcOr0013165;
        Thu, 18 Feb 2021 06:38:27 -0500
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 2/4] iio: adis16475: improve sync scale mode handling
Date:   Thu, 18 Feb 2021 12:40:37 +0100
Message-ID: <20210218114039.216091-3-nuno.sa@analog.com>
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

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 118 +++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 197d48240991..5759cd8ffbef 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -17,6 +17,8 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/irq.h>
+#include <linux/lcm.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -101,6 +103,7 @@ struct adis16475 {
 	u32 clk_freq;
 	bool burst32;
 	unsigned long lsb_flag;
+	u16 sync_mode;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16475_MAX_SCAN_DATA] __aligned(8);
 };
@@ -117,6 +120,11 @@ enum {
 	ADIS16475_SCAN_CRC_FAILURE,
 };
 
+static bool low_rate_allow;
+module_param(low_rate_allow, bool, 0444);
+MODULE_PARM_DESC(low_rate_allow,
+		 "Allow IMU rates below the minimum advisable when external clk is used in SCALED mode (default: N)");
+
 #ifdef CONFIG_DEBUG_FS
 static ssize_t adis16475_show_firmware_revision(struct file *file,
 						char __user *userbuf,
@@ -253,25 +261,92 @@ static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 {
 	int ret;
 	u16 dec;
+	u32 sample_rate = st->clk_freq;
+
+	mutex_lock(&st->adis.state_lock);
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
 
-	*freq = DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
+	mutex_unlock(&st->adis.state_lock);
+
+	*freq = DIV_ROUND_CLOSEST(sample_rate, dec + 1);
 
 	return 0;
+error:
+	mutex_unlock(&st->adis.state_lock);
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
+	mutex_lock(&st->adis.state_lock);
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
+
+		/*
+		 * If lcm is bigger than the IMU maximum sampling rate there's no perfect
+		 * solution. In this case, we get the highest multiple of the input clock
+		 * lower than the IMU max sample rate.
+		 */
+		if (scaled_rate > 2100000)
+			scaled_rate = 2100000 / st->clk_freq * st->clk_freq;
+		else
+			scaled_rate = 2100000 / scaled_rate * scaled_rate;
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
+		if (scaled_rate < 1900000 && !low_rate_allow)
+			scaled_rate = roundup(1900000, st->clk_freq);
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
@@ -281,7 +356,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 
 	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
 	if (ret)
-		return ret;
+		goto error;
 
 	/*
 	 * If decimation is used, then gyro and accel data will have meaningful
@@ -290,6 +365,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
 
 	return 0;
+error:
+	mutex_unlock(&st->adis.state_lock);
+	return ret;
 }
 
 /* The values are approximated. */
@@ -1085,6 +1163,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	}
 
 	sync = &st->info->sync[sync_mode];
+	st->sync_mode = sync->sync_mode;
 
 	/* All the other modes require external input signal */
 	if (sync->sync_mode != ADIS16475_SYNC_OUTPUT) {
@@ -1112,37 +1191,20 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 
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
2.30.1

