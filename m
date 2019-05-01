Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2B10941
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEAOnS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 10:43:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbfEAOnS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 10:43:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EasRi086040
        for <linux-iio@vger.kernel.org>; Wed, 1 May 2019 10:43:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7cxy99jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2019 10:43:16 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 1 May 2019 15:43:15 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:43:11 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EhA7419398888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:43:10 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517C9AC065;
        Wed,  1 May 2019 14:43:10 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3A8BAC05E;
        Wed,  1 May 2019 14:43:09 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 May 2019 14:43:09 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] iio: dps310: Add pressure sensing capability
Date:   Wed,  1 May 2019 09:43:07 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19050114-2213-0000-0000-00000384D112
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011029; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197064; UDB=6.00627822; IPR=6.00977917;
 MB=3.00026683; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-01 14:43:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-2214-0000-0000-00005E3F4AA2
Message-Id: <1556721787-28500-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010094
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DPS310 supports measurement of pressure, so support that in the
driver. Use background measurement like the temperature sensing and
default to lowest precision and lowest measurement rate.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 350 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 314 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index beb8b11..48cf83c 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -36,13 +37,15 @@
 #define DPS310_TMP_B1		0x04
 #define DPS310_TMP_B2		0x05
 #define DPS310_PRS_CFG		0x06
+#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
+#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
 #define DPS310_TMP_CFG		0x07
 #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
 #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
 #define  DPS310_TMP_EXT		BIT(7)
 #define DPS310_MEAS_CFG		0x08
 #define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
-#define   DPS310_PRESSURE_EN	BIT(0)
+#define   DPS310_PRS_EN		BIT(0)
 #define   DPS310_TEMP_EN	BIT(1)
 #define   DPS310_BACKGROUND	BIT(2)
 #define  DPS310_PRS_RDY		BIT(4)
@@ -58,16 +61,17 @@
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	(BIT(0) | BIT(3))
 #define DPS310_COEF_BASE	0x10
+#define DPS310_NUM_COEF_REGS	0x12
 
 #define DPS310_PRS_BASE		DPS310_PRS_B0
 #define DPS310_TMP_BASE		DPS310_TMP_B0
 
-#define DPS310_TMP_RATE(_n)	ilog2(_n)
-#define DPS310_TMP_PRC(_n)	ilog2(_n)
+#define DPS310_CALC_RATE(_n)	ilog2(_n)
+#define DPS310_CALC_PRC(_n)	ilog2(_n)
 
 #define MCELSIUS_PER_CELSIUS	1000
 
-const int scale_factor[] = {
+static const int scale_factor[] = {
 	 524288,
 	1572864,
 	3670016,
@@ -83,6 +87,8 @@ struct dps310_data {
 	struct regmap *regmap;
 
 	s32 c0, c1;
+	s32 c00, c10, c20, c30, c01, c11, c21;
+	s32 pressure_raw;
 	s32 temp_raw;
 };
 
@@ -95,33 +101,80 @@ struct dps310_data {
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
 
-/* To be called after checking the TMP_RDY bit in MEAS_CFG */
-static int dps310_get_temp_coef(struct dps310_data *data)
+/* To be called after checking the COEF_RDY bit in MEAS_CFG */
+static int dps310_get_coefs(struct dps310_data *data)
 {
 	struct regmap *regmap = data->regmap;
-	uint8_t coef[3] = {0};
 	int r;
+	u8 coef[DPS310_NUM_COEF_REGS] = {0};
 	u32 c0, c1;
+	u32 c00, c10, c20, c30, c01, c11, c21;
 
-	/*
-	 * Read temperature calibration coefficients c0 and c1 from the
-	 * COEF register. The numbers are 12-bit 2's compliment numbers
-	 */
-	r = regmap_bulk_read(regmap, DPS310_COEF_BASE, coef, 3);
+	/* Read all sensor calibration coefficients from the COEF registers. */
+	r = regmap_bulk_read(regmap, DPS310_COEF_BASE, coef,
+			     DPS310_NUM_COEF_REGS);
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
@@ -137,6 +190,24 @@ static int dps310_get_temp_precision(struct dps310_data *data)
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
@@ -147,13 +218,26 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 
 	shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
 	ret = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			DPS310_TMP_SHIFT_EN,
-			shift_en);
+				DPS310_TMP_SHIFT_EN, shift_en);
+
 	if (ret)
 		return ret;
 
 	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
-			DPS310_TMP_PRC_BITS, DPS310_TMP_PRC(val));
+				  DPS310_TMP_PRC_BITS, DPS310_CALC_PRC(val));
+}
+
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
 }
 
 static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
@@ -163,12 +247,23 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 	if (freq < 0 || freq > 128)
 		return -EINVAL;
 
-	val = DPS310_TMP_RATE(freq) << 4;
+	val = DPS310_CALC_RATE(freq) << 4;
 
 	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
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
@@ -180,12 +275,53 @@ static int dps310_get_temp_samp_freq(struct dps310_data *data)
 	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
 }
 
+static int dps310_get_pres_k(struct dps310_data *data)
+{
+	int r = dps310_get_pres_precision(data);
+
+	if (r < 0)
+		return r;
+
+	return scale_factor[DPS310_CALC_PRC(r)];
+}
+
 static int dps310_get_temp_k(struct dps310_data *data)
 {
-	return scale_factor[DPS310_TMP_PRC(dps310_get_temp_precision(data))];
+	int r = dps310_get_temp_precision(data);
+
+	if (r < 0)
+		return r;
+
+	return scale_factor[DPS310_CALC_PRC(r)];
+}
+
+static int dps310_read_pres_raw(struct dps310_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int r, ready;
+	u8 val[3];
+	s32 raw;
+
+	r = regmap_read(data->regmap, DPS310_MEAS_CFG, &ready);
+	if (r < 0)
+		return r;
+
+	if (!(ready & DPS310_PRS_RDY)) {
+		dev_dbg(dev, "pressure not ready\n");
+		return -EAGAIN;
+	}
+
+	r = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, 3);
+	if (r < 0)
+		return r;
+
+	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	data->pressure_raw = sign_extend32(raw, 23);
+
+	return 0;
 }
 
-static int dps310_read_temp(struct dps310_data *data)
+static int dps310_read_temp_raw(struct dps310_data *data)
 {
 	struct device *dev = &data->client->dev;
 	struct regmap *regmap = data->regmap;
@@ -251,26 +387,139 @@ static int dps310_write_raw(struct iio_dev *iio,
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
+	int i;
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
+	/* Ignore errors and use the latest temperature */
+	dps310_read_temp_raw(data);
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
-
-	return -EINVAL;
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
@@ -279,7 +528,7 @@ static int dps310_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_RAW:
-		ret = dps310_read_temp(data);
+		ret = dps310_read_temp_raw(data);
 		if (ret)
 			return ret;
 
@@ -302,8 +551,24 @@ static int dps310_read_raw(struct iio_dev *iio,
 	default:
 		return -EINVAL;
 	}
+}
 
-	return -EINVAL;
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
 }
 
 static const struct regmap_config dps310_regmap_config = {
@@ -385,24 +650,37 @@ static int dps310_probe(struct i2c_client *client,
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
-	r = regmap_write(data->regmap, DPS310_TMP_CFG,
-			DPS310_TMP_EXT | DPS310_TMP_RATE(1) | DPS310_TMP_PRC(1));
+	r = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT |
+		DPS310_CALC_RATE(1) | DPS310_CALC_PRC(1));
 	if (r < 0)
 		return r;
 
-	/* Temp shift is disabled when PRC <= 8 */
+	/* Temp and pressure shifts are disabled when PRC <= 8 */
 	r = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			DPS310_TMP_SHIFT_EN, 0);
+			      DPS310_TMP_SHIFT_EN | DPS310_PRS_SHIFT_EN, 0);
+	if (r < 0)
+		return r;
+
+	/* MEAS_CFG doesn't seem to update unless first written with 0 */
+	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			      DPS310_MEAS_CTRL_BITS, 0);
 	if (r < 0)
 		return r;
 
-	/* Turn on temperature measurement in the background */
+	/* Turn on temperature and pressure measurement in the background */
 	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
 			DPS310_MEAS_CTRL_BITS,
-			DPS310_TEMP_EN | DPS310_BACKGROUND);
+			DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND);
 	if (r < 0)
 		return r;
 
@@ -417,7 +695,7 @@ static int dps310_probe(struct i2c_client *client,
 	if (r < 0)
 		return r;
 
-	r = dps310_get_temp_coef(data);
+	r = dps310_get_coefs(data);
 	if (r < 0)
 		return r;
 
-- 
1.8.3.1

