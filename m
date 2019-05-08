Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028D918085
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 21:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEHTfu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 15:35:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfEHTfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 15:35:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48JXTSV137662
        for <linux-iio@vger.kernel.org>; Wed, 8 May 2019 15:35:45 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sc3uxvhdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 15:35:44 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 8 May 2019 20:35:43 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 20:35:40 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x48JZdBH4784410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 19:35:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8008113604F;
        Wed,  8 May 2019 19:35:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11077136051;
        Wed,  8 May 2019 19:35:39 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 19:35:38 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 3/3] iio: dps310: Add pressure sensing capability
Date:   Wed,  8 May 2019 14:35:28 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050819-8235-0000-0000-00000E91AB52
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011072; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200485; UDB=6.00629893; IPR=6.00981371;
 MB=3.00026797; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-08 19:35:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050819-8236-0000-0000-0000457A5C62
Message-Id: <1557344128-690-4-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DPS310 supports measurement of pressure, so support that in the
driver. Use background measurement like the temperature sensing and
default to lowest precision and lowest measurement rate.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 331 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 307 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c42808e..a7ee28c 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -11,11 +11,11 @@
  *   c0 * 0.5 + c1 * T_raw / kT °C
  *
  * TODO:
- *  - Pressure sensor readings
  *  - Optionally support the FIFO
  */
 
 #include <linux/i2c.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -29,6 +29,8 @@
 #define DPS310_TMP_B1		0x04
 #define DPS310_TMP_B2		0x05
 #define DPS310_PRS_CFG		0x06
+#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
+#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
 #define DPS310_TMP_CFG		0x07
 #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
 #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
@@ -82,6 +84,8 @@ struct dps310_data {
 	struct regmap *regmap;
 
 	s32 c0, c1;
+	s32 c00, c10, c20, c30, c01, c11, c21;
+	s32 pressure_raw;
 	s32 temp_raw;
 };
 
@@ -94,33 +98,79 @@ struct dps310_data {
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_RAW),
 	},
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_RAW),
+	},
 };
 
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
-static int dps310_get_temp_coef(struct dps310_data *data)
+static int dps310_get_coefs(struct dps310_data *data)
 {
 	struct regmap *regmap = data->regmap;
-	u8 coef[3];
 	int r;
+	u8 coef[18];
 	u32 c0, c1;
+	u32 c00, c10, c20, c30, c01, c11, c21;
 
-	/*
-	 * Read temperature calibration coefficients c0 and c1 from the
-	 * COEF register. The numbers are 12-bit 2's compliment numbers
-	 */
+	/* Read all sensor calibration coefficients from the COEF registers. */
 	r = regmap_bulk_read(regmap, DPS310_COEF_BASE, coef, sizeof(coef));
 	if (r < 0)
 		return r;
 
+	/*
+	 * Calculate temperature calibration coefficients c0 and c1. The numbers
+	 * are 12-bit 2's complement numbers.
+	 */
 	c0 = (coef[0] << 4) | (coef[1] >> 4);
 	data->c0 = sign_extend32(c0, 11);
 
 	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
 	data->c1 = sign_extend32(c1, 11);
 
+	/*
+	 * Calculate pressure calibration coefficients. c00 and c10 are 20 bit
+	 * 2's complement numbers, while the rest are 16 bit 2's complement
+	 * numbers.
+	 */
+	c00 = (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
+	data->c00 = sign_extend32(c00, 19);
+
+	c10 = ((coef[5] & GENMASK(3, 0)) << 16) | (coef[6] << 8) | coef[7];
+	data->c10 = sign_extend32(c10, 19);
+
+	c01 = (coef[8] << 8) | coef[9];
+	data->c01 = sign_extend32(c01, 15);
+
+	c11 = (coef[10] << 8) | coef[11];
+	data->c11 = sign_extend32(c11, 15);
+
+	c20 = (coef[12] << 8) | coef[13];
+	data->c20 = sign_extend32(c20, 15);
+
+	c21 = (coef[14] << 8) | coef[15];
+	data->c21 = sign_extend32(c21, 15);
+
+	c30 = (coef[16] << 8) | coef[17];
+	data->c30 = sign_extend32(c30, 15);
+
 	return 0;
 }
 
+static int dps310_get_pres_precision(struct dps310_data *data)
+{
+	int val, r;
+
+	r = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	if (r < 0)
+		return r;
+
+	return BIT(val & GENMASK(2, 0));
+}
+
 static int dps310_get_temp_precision(struct dps310_data *data)
 {
 	int val, r;
@@ -136,6 +186,24 @@ static int dps310_get_temp_precision(struct dps310_data *data)
 	return BIT(val & GENMASK(2, 0));
 }
 
+static int dps310_set_pres_precision(struct dps310_data *data, int val)
+{
+	int ret;
+	u8 shift_en;
+
+	if (val < 0 || val > 128)
+		return -EINVAL;
+
+	shift_en = val >= 16 ? DPS310_PRS_SHIFT_EN : 0;
+	ret = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+				DPS310_PRS_SHIFT_EN, shift_en);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
+				  DPS310_PRS_PRC_BITS, DPS310_CALC_PRC(val));
+}
+
 static int dps310_set_temp_precision(struct dps310_data *data, int val)
 {
 	int ret;
@@ -154,6 +222,19 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 				  DPS310_TMP_PRC_BITS, DPS310_CALC_PRC(val));
 }
 
+static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
+{
+	u8 val;
+
+	if (freq < 0 || freq > 128)
+		return -EINVAL;
+
+	val = DPS310_CALC_RATE(freq) << 4;
+
+	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
+				  DPS310_PRS_RATE_BITS, val);
+}
+
 static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
@@ -167,6 +248,17 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 				  DPS310_TMP_RATE_BITS, val);
 }
 
+static int dps310_get_pres_samp_freq(struct dps310_data *data)
+{
+	int val, r;
+
+	r = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	if (r < 0)
+		return r;
+
+	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
+}
+
 static int dps310_get_temp_samp_freq(struct dps310_data *data)
 {
 	int val, r;
@@ -178,6 +270,16 @@ static int dps310_get_temp_samp_freq(struct dps310_data *data)
 	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
 }
 
+static int dps310_get_pres_k(struct dps310_data *data)
+{
+	int r = dps310_get_pres_precision(data);
+
+	if (r < 0)
+		return r;
+
+	return scale_factors[DPS310_CALC_PRC(r)];
+}
+
 static int dps310_get_temp_k(struct dps310_data *data)
 {
 	int r = dps310_get_temp_precision(data);
@@ -188,21 +290,37 @@ static int dps310_get_temp_k(struct dps310_data *data)
 	return scale_factors[DPS310_CALC_PRC(r)];
 }
 
-static int dps310_read_temp(struct dps310_data *data)
+static int dps310_read_pres_raw(struct dps310_data *data)
 {
+	int r, ready;
 	u8 val[3];
 	s32 raw;
-	int r, ready;
-	int rate = dps310_get_temp_samp_freq(data);
+	int rate = dps310_get_pres_samp_freq(data);
 	int timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
 	r = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				     ready & DPS310_TMP_RDY,
+				     ready & DPS310_PRS_RDY,
 				     DPS310_POLL_SLEEP_US(timeout), timeout);
+	if (r)
+		return r;
+
+	r = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (r < 0)
 		return r;
 
+	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	data->pressure_raw = sign_extend32(raw, 23);
+
+	return 0;
+}
+
+static int dps310_read_temp_ready(struct dps310_data *data)
+{
+	int r;
+	u8 val[3];
+	s32 raw;
+
 	r = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
 	if (r < 0)
 		return r;
@@ -213,6 +331,22 @@ static int dps310_read_temp(struct dps310_data *data)
 	return 0;
 }
 
+static int dps310_read_temp_raw(struct dps310_data *data)
+{
+	int r, ready;
+	int rate = dps310_get_temp_samp_freq(data);
+	int timeout = DPS310_POLL_TIMEOUT_US(rate);
+
+	/* Poll for sensor readiness; base the timeout upon the sample rate. */
+	r = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
+				     ready & DPS310_TMP_RDY,
+				     DPS310_POLL_SLEEP_US(timeout), timeout);
+	if (r < 0)
+		return r;
+
+	return dps310_read_temp_ready(data);
+}
+
 static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -253,24 +387,141 @@ static int dps310_write_raw(struct iio_dev *iio,
 {
 	struct dps310_data *data = iio_priv(iio);
 
-	if (chan->type != IIO_TEMP)
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			return dps310_set_pres_samp_freq(data, val);
+
+		case IIO_TEMP:
+			return dps310_set_temp_samp_freq(data, val);
+
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			return dps310_set_pres_precision(data, val);
+
+		case IIO_TEMP:
+			return dps310_set_temp_precision(data, val);
+
+		default:
+			return -EINVAL;
+		}
+
+	default:
 		return -EINVAL;
+	}
+}
+
+static int dps310_calculate_pressure(struct dps310_data *data)
+{
+	int i, r, t_ready;
+	int kpi = dps310_get_pres_k(data);
+	int kti = dps310_get_temp_k(data);
+	s64 rem = 0ULL;
+	s64 pressure = 0ULL;
+	s64 p;
+	s64 t;
+	s64 denoms[7];
+	s64 nums[7];
+	s64 rems[7];
+	s64 kp;
+	s64 kt;
+
+	if (kpi < 0)
+		return kpi;
+
+	if (kti < 0)
+		return kti;
+
+	kp = (s64)kpi;
+	kt = (s64)kti;
+
+	/* Refresh temp if it's ready, otherwise just use the latest value */
+	r = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
+	if (r >= 0 && t_ready & DPS310_TMP_RDY)
+		dps310_read_temp_ready(data);
+
+	p = (s64)data->pressure_raw;
+	t = (s64)data->temp_raw;
+
+	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
+	nums[0] = (s64)data->c00;
+	denoms[0] = 1LL;
+	nums[1] = p * (s64)data->c10;
+	denoms[1] = kp;
+	nums[2] = p * p * (s64)data->c20;
+	denoms[2] = kp * kp;
+	nums[3] = p * p * p * (s64)data->c30;
+	denoms[3] = kp * kp * kp;
+	nums[4] = t * (s64)data->c01;
+	denoms[4] = kt;
+	nums[5] = t * p * (s64)data->c11;
+	denoms[5] = kp * kt;
+	nums[6] = t * p * p * (s64)data->c21;
+	denoms[6] = kp * kp * kt;
+
+	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
+	for (i = 0; i < 7; ++i) {
+		u64 rem;
+
+		if (nums[i] < 0LL) {
+			pressure -= div64_u64_rem(-nums[i], denoms[i], &rem);
+			rems[i] = -rem;
+		} else {
+			pressure += div64_u64_rem(nums[i], denoms[i], &rem);
+			rems[i] = (s64)rem;
+		}
+	}
+
+	/* Increase precision and calculate the remainder sum */
+	for (i = 0; i < 7; ++i)
+		rem += div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
+
+	pressure += div_s64(rem, 1000000000LL);
+
+	return (int)pressure;
+}
+
+static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
+				long mask)
+{
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return dps310_set_temp_samp_freq(data, val);
+		*val = dps310_get_pres_samp_freq(data);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_RAW:
+		ret = dps310_read_pres_raw(data);
+		if (ret)
+			return ret;
+
+		*val = dps310_calculate_pressure(data);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
+		return IIO_VAL_FRACTIONAL;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return dps310_set_temp_precision(data, val);
+		*val = dps310_get_pres_precision(data);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
 }
 
-static int dps310_read_raw(struct iio_dev *iio,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
+			    long mask)
 {
-	struct dps310_data *data = iio_priv(iio);
 	int ret;
 
 	switch (mask) {
@@ -279,7 +530,7 @@ static int dps310_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_RAW:
-		ret = dps310_read_temp(data);
+		ret = dps310_read_temp_raw(data);
 		if (ret)
 			return ret;
 
@@ -312,6 +563,24 @@ static int dps310_read_raw(struct iio_dev *iio,
 	}
 }
 
+static int dps310_read_raw(struct iio_dev *iio,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		return dps310_read_pressure(data, val, val2, mask);
+
+	case IIO_TEMP:
+		return dps310_read_temp(data, val, val2, mask);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct regmap_config dps310_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -393,6 +662,13 @@ static int dps310_probe(struct i2c_client *client,
 		return PTR_ERR(data->regmap);
 
 	/*
+	 * Set up pressure sensor in single sample, one measurement per second
+	 * mode
+	 */
+	r = regmap_write(data->regmap, DPS310_PRS_CFG,
+			 DPS310_CALC_RATE(1) | DPS310_CALC_PRC(1));
+
+	/*
 	 * Set up external (MEMS) temperature sensor in single sample, one
 	 * measurement per second mode
 	 */
@@ -402,16 +678,23 @@ static int dps310_probe(struct i2c_client *client,
 	if (r < 0)
 		goto err;
 
-	/* Temp shift is disabled when PRC <= 8 */
+	/* Temp and pressure shifts are disabled when PRC <= 8 */
 	r = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			      DPS310_TMP_SHIFT_EN, 0);
+			      DPS310_TMP_SHIFT_EN | DPS310_PRS_SHIFT_EN, 0);
+	if (r < 0)
+		goto err;
+
+	/* MEAS_CFG doesn't seem to update unless first written with 0 */
+	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			      DPS310_MEAS_CTRL_BITS, 0);
 	if (r < 0)
 		goto err;
 
-	/* Turn on temperature measurement in the background */
+	/* Turn on temperature and pressure measurement in the background */
 	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
 			      DPS310_MEAS_CTRL_BITS,
-			      DPS310_TEMP_EN | DPS310_BACKGROUND);
+			      DPS310_PRS_EN | DPS310_TEMP_EN |
+			      DPS310_BACKGROUND);
 	if (r < 0)
 		goto err;
 
@@ -424,7 +707,7 @@ static int dps310_probe(struct i2c_client *client,
 	if (r < 0)
 		goto err;
 
-	r = dps310_get_temp_coef(data);
+	r = dps310_get_coefs(data);
 	if (r < 0)
 		goto err;
 
-- 
1.8.3.1

