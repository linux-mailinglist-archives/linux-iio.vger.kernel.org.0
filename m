Return-Path: <linux-iio+bounces-13981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A15A04478
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365F23A688F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258CB1F428C;
	Tue,  7 Jan 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ARwWR6Ph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FA1F5429;
	Tue,  7 Jan 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263667; cv=none; b=DOpAl3bXDV2t2oILv/IqpRCjZYgbKccsEMp4GneSYo7UqjGXHAuvsYyEpBk3lgGMpMn5rAr5qm6e6MFG7MVaS9zANs+T8KYGI8d8C35MMeT4PtdmYlo2FoTcjaHBgXxMHlRyCK4x/1bD3keK1ujOoZLPD3Xpb8FutQ8FMHAkbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263667; c=relaxed/simple;
	bh=jVMSXNaeWXXx2w+SZhuQEGKuwaadbqpZ+xGiZAV1kZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjgFtwGBQzvFyQ+KXB0Lswh965i6oypN91V5Ro/Mn1zPudIMWp+Q4ajAjlKOROeGeRVSGVZ54ZRTCAmGkx74Gdr2YF8L6EMxb7EBafejtWIU1Ni9Lj7/w5ETdKHwfByLAJAPfbx9jSfm1AXNQXwQDn7Pr+polV/gf8/CK90eBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ARwWR6Ph; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDrd008016;
	Tue, 7 Jan 2025 10:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=E2Y3h
	Ym9N8TVH3+JcC9+a87Ezyq6t5LSWkujtQWIOQU=; b=ARwWR6PhZXwmIySoWFfol
	H3ud1kDPujZ+0h4o1fQ9Y7QbsXdQs4WsjWK/dKREvMVbsqfqdgVlX8YjWw0duaV6
	7/2EBp6GVstBs11V/yHENkI/SWUcIzCRdKOihRRD34g8wH16USCI7nOLDLXE2Ti/
	wPUmusVDW21aOkiik1WTtUqNwcNDxhDMjC+tt29NO99t3lKK6Hkn6/s9ObZX0d3u
	PwGsc0VrZeBTla0RnT3MRMjW9VGhWZE7fBkOnLfAhc9ZLDyCar5zfaFdkt0CheDi
	fNCoX8veMe7CwiTib3zqdndS/UNFpBY3/ZVir9TY9MoxUAwvJFLGbYvBrQ5hHCO5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4410d0src8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:27:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FRRDJ034225
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:27:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:27:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:27:27 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FREPc030360;
	Tue, 7 Jan 2025 10:27:17 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, PopPaul2021 <paul.pop@analog.com>
Subject: [PATCH v1 15/15] iio: adc: ad7768-1: add filter type and decimation rate attributes
Date: Tue, 7 Jan 2025 12:27:14 -0300
Message-ID: <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yrTqi__9hFnjA_4vyyHUj7siBWqfjx0G
X-Proofpoint-GUID: yrTqi__9hFnjA_4vyyHUj7siBWqfjx0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070130

Separate filter type and decimation rate from the sampling frequency
attribute. The new filter type attribute enables SINC3 and WIDEBAND
filters, which were previously unavailable.

Previously, combining decimation and MCLK divider in the sampling
frequency obscured performance trade-offs. Lower MCLK divider
settings increase power usage, while lower decimation rates reduce
precision by decreasing averaging. By creating a decimation attribute,
users gain finer control over performance.

The addition of those attributes allows a wider range of sampling
frequencies and more access to the device features.

Co-developed-by: PopPaul2021 <paul.pop@analog.com>
Signed-off-by: PopPaul2021 <paul.pop@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 429 +++++++++++++++++++++++++++++++------
 1 file changed, 366 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0b0cb3b396ff..842acef1410d 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include "linux/util_macros.h"
 #include <linux/spi/spi.h>
 
 #include <linux/iio/buffer.h>
@@ -75,6 +76,10 @@
 #define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
 #define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
 
+/* AD7768_SINC3_DEC_RATE */
+#define AD7768_SINC3_DEC_RATE_MSB_MSK	GENMASK(12, 8)
+#define AD7768_SINC3_DEC_RATE_LSB_MSK	GENMASK(7, 0)
+
 /* AD7768_REG_CONVERSION */
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
@@ -95,6 +100,18 @@
 #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
 #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
 
+/* Decimation Rate Limits */
+#define SINC5_DEC_RATE_MIN		8
+#define SINC5_DEC_RATE_MAX		1024
+#define SINC3_DEC_RATE_MIN		32
+#define SINC3_DEC_RATE_MAX		163840
+#define WIDEBAND_DEC_RATE_MIN		32
+#define WIDEBAND_DEC_RATE_MAX		1024
+
+enum {
+	DEC_RATE,
+};
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -116,22 +133,12 @@ enum ad7768_mclk_div {
 	AD7768_MCLK_DIV_2
 };
 
-enum ad7768_dec_rate {
-	AD7768_DEC_RATE_32 = 0,
-	AD7768_DEC_RATE_64 = 1,
-	AD7768_DEC_RATE_128 = 2,
-	AD7768_DEC_RATE_256 = 3,
-	AD7768_DEC_RATE_512 = 4,
-	AD7768_DEC_RATE_1024 = 5,
-	AD7768_DEC_RATE_8 = 9,
-	AD7768_DEC_RATE_16 = 10
-};
-
-struct ad7768_clk_configuration {
-	enum ad7768_mclk_div mclk_div;
-	enum ad7768_dec_rate dec_rate;
-	unsigned int clk_div;
-	enum ad7768_pwrmode pwrmode;
+enum ad7768_flt_type {
+	SINC5,
+	SINC5_DEC_X8,
+	SINC5_DEC_X16,
+	SINC3,
+	WIDEBAND
 };
 
 enum ad7768_scan_type {
@@ -154,18 +161,16 @@ static const int ad7768_mclk_div_rates[4] = {
 	16, 8, 4, 2,
 };
 
-static const struct ad7768_clk_configuration ad7768_clk_config[] = {
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
+static const int dec_rate_values[6] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
+static const  int sinc3_dec_rate_max_values[4] = {
+	20480, 40960, 81920, 163840,
+};
+
+static const char * const ad7768_filter_enum[] = {
+	"sinc5", "sinc3", "wideband"
 };
 
 static const struct iio_scan_type ad7768_scan_type[] = {
@@ -186,6 +191,23 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
 static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
 			  unsigned int mode);
+static int ad7768_get_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan);
+static int ad7768_set_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan, unsigned int filter);
+static ssize_t ad7768_ext_info_write(struct iio_dev *indio_dev,
+				     uintptr_t private, const struct iio_chan_spec *chan,
+				     const char *buf, size_t len);
+static ssize_t ad7768_ext_info_read(struct iio_dev *indio_dev,
+				    uintptr_t private, const struct iio_chan_spec *chan,
+				    char *buf);
+
+static const struct iio_enum ad7768_flt_type_iio_enum = {
+	.items = ad7768_filter_enum,
+	.num_items = ARRAY_SIZE(ad7768_filter_enum),
+	.set = ad7768_set_fil_type_attr,
+	.get = ad7768_get_fil_type_attr,
+};
 
 static const struct iio_enum ad7768_vcm_mode_enum = {
 	.items = ad7768_vcm_modes,
@@ -201,6 +223,15 @@ static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
 	IIO_ENUM_AVAILABLE("common_mode_voltage",
 			   IIO_SHARED_BY_ALL,
 			   &ad7768_vcm_mode_enum),
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
+	{
+		.name = "decimation_rate",
+		.read = ad7768_ext_info_read,
+		.write = ad7768_ext_info_write,
+		.shared = IIO_SHARED_BY_ALL,
+		.private = DEC_RATE,
+	},
 	{ },
 };
 
@@ -228,7 +259,9 @@ struct ad7768_state {
 	struct gpio_chip gpiochip;
 	unsigned int gpio_avail_map;
 	unsigned int mclk_freq;
+	unsigned int mclk_div;
 	unsigned int dec_rate;
+	enum ad7768_flt_type filter_type;
 	unsigned int samp_freq;
 	unsigned int common_mode_voltage;
 	struct completion completion;
@@ -252,6 +285,9 @@ struct ad7768_state {
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
+static int ad7768_set_freq(struct ad7768_state *st,
+			   unsigned int freq);
+
 static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
 			       unsigned int *data, unsigned int len)
 {
@@ -309,6 +345,31 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 	return 0;
 }
 
+static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
+{
+	unsigned int mclk_div_value;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_POWER_CLOCK, &mclk_div_value, 1);
+	if (ret)
+		return ret;
+
+	mclk_div_value &= ~(AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK);
+	/* Set mclk_div value */
+	mclk_div_value |= AD7768_PWR_MCLK_DIV(mclk_div);
+	/*
+	 * Set power mode based on mclk_div value.
+	 * ECO_MODE is only recommended for MCLK_DIV 16
+	 */
+	if (mclk_div > AD7768_MCLK_DIV_16)
+		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_FAST_MODE);
+	else
+		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
+
+	return ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, mclk_div_value);
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -377,23 +438,185 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ad7768_spi_reg_write(st, reg, writeval);
 }
 
-static int ad7768_set_dig_fil(struct ad7768_state *st,
-			      enum ad7768_dec_rate dec_rate)
+static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
+				     unsigned int dec_rate)
+{
+	unsigned int dec_rate_msb, dec_rate_lsb, max_dec_rate;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * Maximum dec_rate is limited by the MCLK_DIV value
+	 * and by the ODR. The edge case is for MCLK_DIV = 2
+	 * ODR = 50 SPS.
+	 * max_dec_rate <= MCLK / (2 * 50)
+	 */
+	max_dec_rate = st->mclk_freq / 100;
+	dec_rate = clamp_t(unsigned int, dec_rate, 32, max_dec_rate);
+	/*
+	 * Calculate the equivalent value to sinc3 decimation ratio
+	 * to be written on the SINC3_DECIMATION_RATE register:
+	 *  Value = (DEC_RATE / 32) -1
+	 */
+	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
+	dec_rate_msb = FIELD_GET(AD7768_SINC3_DEC_RATE_MSB_MSK, dec_rate);
+	dec_rate_lsb = FIELD_GET(AD7768_SINC3_DEC_RATE_LSB_MSK, dec_rate);
+
+	ret = ad7768_spi_reg_write(st, AD7768_REG_SINC3_DEC_RATE_MSB, dec_rate_msb);
+	if (ret)
+		return ret;
+
+	ret = ad7768_spi_reg_write(st, AD7768_REG_SINC3_DEC_RATE_LSB, dec_rate_lsb);
+	if (ret)
+		return ret;
+
+	st->dec_rate = (dec_rate + 1) * 32;
+
+	return 0;
+}
+
+static int ad7768_set_dec_rate(struct ad7768_state *st, unsigned int dec_rate)
 {
+	unsigned int mode, dec_rate_reg;
+	int ret;
+
+	dec_rate_reg = find_closest(dec_rate, dec_rate_values,
+				    ARRAY_SIZE(dec_rate_values));
+
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_DIGITAL_FILTER, &mode, 1);
+	if (ret)
+		return ret;
+
+	mode &= ~AD7768_DIG_FIL_DEC_MSK;
+	mode |= AD7768_DIG_FIL_DEC_RATE(dec_rate_reg);
+	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
+	if (ret)
+		return ret;
+
+	st->dec_rate = dec_rate_values[dec_rate_reg];
+
+	return 0;
+}
+
+static int ad7768_set_filter_type(struct iio_dev *dev,
+				  enum ad7768_flt_type filter_type)
+{
+	struct ad7768_state *st = iio_priv(dev);
 	unsigned int mode;
 	int ret;
 
-	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
-		mode = AD7768_DIG_FIL_FIL(dec_rate);
-	else
-		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_DIGITAL_FILTER, &mode, 1);
+	if (ret)
+		return ret;
+
+	mode &= ~AD7768_DIG_FIL_FIL_MSK;
+	mode |= AD7768_DIG_FIL_FIL(filter_type);
 
 	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
 	if (ret < 0)
 		return ret;
 
-	/* A sync-in pulse is required every time the filter dec rate changes */
-	return ad7768_send_sync_pulse(st);
+	st->filter_type = filter_type;
+
+	return 0;
+}
+
+static int ad7768_configure_dig_fil(struct iio_dev *dev,
+				    enum ad7768_flt_type filter_type,
+				    unsigned int dec_rate)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	if (filter_type == SINC3) {
+		ret = ad7768_set_filter_type(dev, SINC3);
+		if (ret)
+			return ret;
+
+		/* recalculate the decimation for this filter mode */
+		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
+	} else if (filter_type == WIDEBAND) {
+		ret = ad7768_set_filter_type(dev, filter_type);
+		if (ret)
+			return ret;
+
+		/* recalculate the decimation rate */
+		ret = ad7768_set_dec_rate(st, dec_rate);
+	} else {
+		/* For SINC5 filter */
+		/* Decimation 8 and 16 are set in the digital filter field */
+		if (dec_rate <= 8) {
+			ret = ad7768_set_filter_type(dev, SINC5_DEC_X8);
+			if (ret)
+				return ret;
+
+			st->dec_rate = 8;
+		} else if (dec_rate <= 16) {
+			ret = ad7768_set_filter_type(dev, SINC5_DEC_X16);
+			if (ret)
+				return ret;
+
+			st->dec_rate = 16;
+		} else {
+			ret = ad7768_set_filter_type(dev, SINC5);
+			if (ret)
+				return ret;
+
+			ret = ad7768_set_dec_rate(st, dec_rate);
+		}
+	}
+
+	/* Update scale table: scale values vary according to the precision */
+	ad7768_fill_scale_tbl(dev);
+
+	return ret;
+}
+
+static int ad7768_set_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int filter)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	/*
+	 * Filters of types 0, 1, and 2 correspond to SINC5.
+	 * For SINC3 and wideband filter types, an offset of 2 is added
+	 * to align with the expected register values.
+	 */
+	if (filter != SINC5)
+		filter += 2;
+
+	ret = ad7768_configure_dig_fil(dev, filter, st->dec_rate);
+	if (ret)
+		return ret;
+
+	/* Update sampling frequency */
+	return ad7768_set_freq(st, st->samp_freq);
+}
+
+static int ad7768_get_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+	unsigned int mode;
+
+	ret = ad7768_spi_reg_read(st, AD7768_REG_DIGITAL_FILTER, &mode, 1);
+	if (ret)
+		return ret;
+
+	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
+	/* Filter types from 0 to 2 are represented as SINC5 */
+	if (mode < SINC3)
+		return SINC5;
+
+	/* Remove the offset for the sinc3 and wideband filters
+	 * to get the corresponding attribute enum value
+	 */
+	return mode - 2;
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -496,46 +719,84 @@ static int ad7768_gpio_init(struct ad7768_state *st)
 	return gpiochip_add_data(&st->gpiochip, st);
 }
 
+static ssize_t ad7768_ext_info_read(struct iio_dev *indio_dev,
+				    uintptr_t private,
+				    const struct iio_chan_spec *chan, char *buf)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	switch (private) {
+	case DEC_RATE:
+		return sysfs_emit(buf, "%d\n", st->dec_rate);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad7768_ext_info_write(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	int ret = -EINVAL;
+	long long dec_rate;
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	switch (private) {
+	case DEC_RATE:
+		ret = kstrtoll(buf, 10, &dec_rate);
+		if (ret)
+			return ret;
+
+		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, dec_rate);
+		if (ret)
+			return ret;
+
+		/* Update sampling frequency */
+		ret = ad7768_set_freq(st, st->samp_freq);
+		if (ret)
+			return ret;
+
+		return len;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
-	unsigned int diff_new, diff_old, pwr_mode, i, idx;
+	unsigned int diff_new, diff_old, i, idx;
 	int res, ret;
 
+	freq = clamp_t(unsigned int, freq, 50, 1024000);
 	diff_old = U32_MAX;
 	idx = 0;
 
-	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
+	if (freq == 0)
+		return -EINVAL;
+
+	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->dec_rate);
 
 	/* Find the closest match for the desired sampling frequency */
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		diff_new = abs(res - ad7768_clk_config[i].clk_div);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		diff_new = abs(res - ad7768_mclk_div_rates[i]);
 		if (diff_new < diff_old) {
 			diff_old = diff_new;
 			idx = i;
 		}
 	}
 
-	/*
-	 * Set both the mclk_div and pwrmode with a single write to the
-	 * POWER_CLOCK register
-	 */
-	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
-		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
-	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
-	if (ret < 0)
-		return ret;
-
-	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
-	if (ret < 0)
+	/* Set both the mclk_div and pwrmode */
+	ret = ad7768_set_mclk_div(st, idx);
+	if (ret)
 		return ret;
 
-	st->dec_rate = ad7768_clk_config[idx].clk_div /
-		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					  ad7768_clk_config[idx].clk_div);
+					  ad7768_mclk_div_rates[idx] * st->dec_rate);
 
-	return 0;
+	/* A sync-in pulse is required every time the filter dec rate changes */
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan)
@@ -566,13 +827,16 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7768_state *st = iio_priv(indio_dev);
-	unsigned int freq;
+	unsigned int freq, freq_filtered;
 	int i, len = 0;
 
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					 ad7768_clk_config[i].clk_div);
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
+	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->dec_rate);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		freq = DIV_ROUND_CLOSEST(freq_filtered,
+					 ad7768_mclk_div_rates[i]);
+		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
+		if (freq >= 50)
+			len += sysfs_emit_at(buf, len, "%d ", freq);
 	}
 
 	buf[len - 1] = '\n';
@@ -582,6 +846,38 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
 
+static ssize_t decimation_rate_available_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int len = 0;
+
+	/* Return decimation rate available in range format */
+	buf[len++] = '[';
+	if (st->filter_type == SINC3) {
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MAX);
+	} else if (st->filter_type == WIDEBAND) {
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MAX);
+	} else {
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MAX);
+	}
+
+	buf[len - 1] = ']';
+	buf[len++] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RO(decimation_rate_available, 0);
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -653,6 +949,7 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
 
 static struct attribute *ad7768_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_decimation_rate_available.dev_attr.attr,
 	NULL
 };
 
@@ -678,7 +975,7 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
-static int ad7768_setup(struct ad7768_state *st)
+static int ad7768_setup(struct ad7768_state *st, struct iio_dev *indio_dev)
 {
 	int ret;
 
@@ -727,6 +1024,12 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Set Default Digital Filter configuration:
+	 * SINC5 filter with x32 Decimation rate
+	 */
+	ret = ad7768_configure_dig_fil(indio_dev, SINC5, 32);
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
@@ -915,7 +1218,7 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad7768_setup(st);
+	ret = ad7768_setup(st, indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
 		return ret;
-- 
2.34.1


