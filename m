Return-Path: <linux-iio+bounces-15381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D8A319C8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF221649BC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70626A0CF;
	Tue, 11 Feb 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jlEOJlwN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8426A08D;
	Tue, 11 Feb 2025 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317701; cv=none; b=Tw8BhKRC3rpZQEmvpATQEOgU6IC1Q3wzMPyTnTWxbA6HSAFG0jMuhKmza3YrGQf3COB4xWQiAZpKyaI1g02cOEiYvBUjWrK8Wi0032KwfMWvswwu+ikHCwIbze4Zr0C4K7z5D7jNAIZSikxIUjf6dC2+eTcJX+ajAIkrXimlbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317701; c=relaxed/simple;
	bh=fqCLVTQ4v4HRae1dND4LZGPXts75n+vTfjoEtBPBAnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GWnm28mf/v2s7/NY/Vw8ZV7qnYVa6BtSo0zoFsKwK8I9+PepTNUG5pbRrEPin41edczaNMl0VDnIZ3mtxOyPHWRg2KSBK+c4AvVVb9xBVsalIilbsLVMPzDlB2wK2TOWqspt0X9oKnAxnIQyzWZseCgcw7FqPp9egLHn8NuYAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jlEOJlwN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJXJed001679;
	Tue, 11 Feb 2025 18:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ClmUb2fgPOQ/VC7ShfO5PDVMYGo
	/R/d42SATNe7wMnY=; b=jlEOJlwNCwuPSqI1oOM6NB4kTRMpOfDnXNr/1d+4Ien
	Mz/Q7glYJPGx1Goyoh0ixwS/f+F2pVKiU8KGdVmwk7mbEgf3+1Wg4GBv5Gjhg5Ld
	hF4wb7pWLldQ/xhauN+f+jLuHGJOJh+rERRvVhBYKe1QcRtyPwGndbF+iF/5yMWy
	3WM3xtP5Z+ac/kwlm6WG1pXDMrA15LC/1OyfJgYUhUyCgXSrTFV4ysZCevN4whkh
	zQuQSE9Ppgi5RL86OSVWDXH+scByAJOy1MTdSJpfBe+u6aCWXWdVHrzcwjl+xZt7
	WbVtswyWKgtfoQeSnWYSmUaOX+sKKzRJK6xmL4H4EZw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857j5uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:48:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNm4P3017079
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:48:04 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:48:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:48:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:48:04 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNlrsf009897;
	Tue, 11 Feb 2025 18:47:55 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 08/17] iio: adc: ad7768-1: convert driver to use regmap
Date: Tue, 11 Feb 2025 20:47:50 -0300
Message-ID: <20250211234750.1008589-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1dqQELZ_hI_WIbh4IIJkmrj-tGEaIfbJ
X-Proofpoint-ORIG-GUID: 1dqQELZ_hI_WIbh4IIJkmrj-tGEaIfbJ
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67abe1b5 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=TTykNLNcmczWsnS9fc4A:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

Convert the AD7768-1 driver to use the regmap API for register
access. This change simplifies and standardizes register interactions,
reducing code duplication and improving maintainability.

Create two regmap configurations, one for 8-bit register values and
other for 24-bit register values.

Since we are using regmap now, define the remaining registers from 0x32
to 0x34.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Included a second register map for the 24-bit register values.
* Added register tables to separate the 24-bit from the 8-bit values.

v2 Changes:
* New patch in v2.
---
 drivers/iio/adc/ad7768-1.c | 148 +++++++++++++++++++++++++------------
 1 file changed, 101 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index f5509a0a36ab..64d123b52b02 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -12,6 +12,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
@@ -59,6 +60,9 @@
 #define AD7768_REG_ADC_DIAG_STATUS	0x2F
 #define AD7768_REG_DIG_DIAG_STATUS	0x30
 #define AD7768_REG_MCLK_COUNTER		0x31
+#define AD7768_REG_COEFF_CONTROL	0x32
+#define AD7768_REG_COEFF_DATA		0x33
+#define AD7768_REG_ACCESS_KEY		0x34
 
 /* AD7768_REG_POWER_CLOCK */
 #define AD7768_PWR_MCLK_DIV_MSK		GENMASK(5, 4)
@@ -153,6 +157,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct regmap *regmap;
+	struct regmap *regmap24;
 	struct regulator *vref;
 	struct clk *mclk;
 	unsigned int mclk_freq;
@@ -175,46 +181,76 @@ struct ad7768_state {
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
-static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
-			       unsigned int len)
-{
-	unsigned int shift;
-	int ret;
+static const struct regmap_range ad7768_regmap_rd_ranges[] = {
+	regmap_reg_range(AD7768_REG_CHIP_TYPE, AD7768_REG_DIG_DIAG_ENABLE),
+	regmap_reg_range(AD7768_REG_MASTER_STATUS, AD7768_REG_COEFF_CONTROL),
+	regmap_reg_range(AD7768_REG_ACCESS_KEY, AD7768_REG_ACCESS_KEY),
+};
 
-	shift = 32 - (8 * len);
-	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
+static const struct regmap_access_table ad7768_regmap_rd_table = {
+	.yes_ranges = ad7768_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap_rd_ranges),
+};
 
-	ret = spi_write_then_read(st->spi, st->data.d8, 1,
-				  &st->data.d32, len);
-	if (ret < 0)
-		return ret;
+static const struct regmap_range ad7768_regmap_wr_ranges[] = {
+	regmap_reg_range(AD7768_REG_SCRATCH_PAD, AD7768_REG_SCRATCH_PAD),
+	regmap_reg_range(AD7768_REG_INTERFACE_FORMAT, AD7768_REG_GPIO_WRITE),
+	regmap_reg_range(AD7768_REG_OFFSET_HI, AD7768_REG_DIG_DIAG_ENABLE),
+	regmap_reg_range(AD7768_REG_SPI_DIAG_STATUS, AD7768_REG_SPI_DIAG_STATUS),
+	regmap_reg_range(AD7768_REG_COEFF_CONTROL, AD7768_REG_COEFF_CONTROL),
+};
 
-	return (be32_to_cpu(st->data.d32) >> shift);
-}
+static const struct regmap_access_table ad7768_regmap_wr_table = {
+	.yes_ranges = ad7768_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap_wr_ranges),
+};
 
-static int ad7768_spi_reg_write(struct ad7768_state *st,
-				unsigned int addr,
-				unsigned int val)
-{
-	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
-	st->data.d8[1] = val & 0xFF;
+static const struct regmap_config ad7768_regmap_config = {
+	.name = "ad7768-1-8",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(6),
+	.rd_table = &ad7768_regmap_rd_table,
+	.wr_table = &ad7768_regmap_wr_table,
+	.max_register = AD7768_REG_ACCESS_KEY,
+	.use_single_write = true,
+	.use_single_read = true,
+};
 
-	return spi_write(st->spi, st->data.d8, 2);
-}
+static const struct regmap_range ad7768_regmap24_rd_ranges[] = {
+	regmap_reg_range(AD7768_REG_ADC_DATA, AD7768_REG_ADC_DATA),
+	regmap_reg_range(AD7768_REG_COEFF_DATA, AD7768_REG_COEFF_DATA),
+};
 
-static int ad7768_set_mode(struct ad7768_state *st,
-			   enum ad7768_conv_mode mode)
-{
-	int regval;
+static const struct regmap_access_table ad7768_regmap24_rd_table = {
+	.yes_ranges = ad7768_regmap24_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap24_rd_ranges),
+};
 
-	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
-	if (regval < 0)
-		return regval;
+static const struct regmap_range ad7768_regmap24_wr_ranges[] = {
+	regmap_reg_range(AD7768_REG_COEFF_DATA, AD7768_REG_COEFF_DATA),
+};
 
-	regval &= ~AD7768_CONV_MODE_MSK;
-	regval |= AD7768_CONV_MODE(mode);
+static const struct regmap_access_table ad7768_regmap24_wr_table = {
+	.yes_ranges = ad7768_regmap24_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap24_wr_ranges),
+};
+
+static const struct regmap_config ad7768_regmap24_config = {
+	.name = "ad7768-1-24",
+	.reg_bits = 8,
+	.val_bits = 24,
+	.read_flag_mask = BIT(6),
+	.rd_table = &ad7768_regmap24_rd_table,
+	.wr_table = &ad7768_regmap24_wr_table,
+	.max_register = AD7768_REG_COEFF_DATA,
+};
 
-	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
+static int ad7768_set_mode(struct ad7768_state *st,
+			   enum ad7768_conv_mode mode)
+{
+	return regmap_update_bits(st->regmap, AD7768_REG_CONVERSION,
+				 AD7768_CONV_MODE_MSK, AD7768_CONV_MODE(mode));
 }
 
 static int ad7768_scan_direct(struct iio_dev *indio_dev)
@@ -233,9 +269,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
-	if (readval < 0)
-		return readval;
+	ret = regmap_read(st->regmap24, AD7768_REG_ADC_DATA, &readval);
+	if (ret)
+		return ret;
+
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -260,15 +297,21 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 		return ret;
 
 	if (readval) {
-		ret = ad7768_spi_reg_read(st, reg, 1);
-		if (ret < 0)
-			goto err_release;
-		*readval = ret;
-		ret = 0;
+		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_rd_table))
+			ret = regmap_read(st->regmap, reg, readval);
+
+		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_rd_table))
+			ret = regmap_read(st->regmap24, reg, readval);
+
 	} else {
-		ret = ad7768_spi_reg_write(st, reg, writeval);
+		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_wr_table))
+			ret = regmap_write(st->regmap, reg, writeval);
+
+		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_wr_table))
+			ret = regmap_write(st->regmap24, reg, writeval);
+
 	}
-err_release:
+
 	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
@@ -285,7 +328,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 	else
 		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
 
-	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
+	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
 	if (ret < 0)
 		return ret;
 
@@ -322,7 +365,7 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	 */
 	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
 		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
-	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
+	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
 	if (ret < 0)
 		return ret;
 
@@ -449,11 +492,11 @@ static int ad7768_setup(struct ad7768_state *st)
 	 * to 10. When the sequence is detected, the reset occurs.
 	 * See the datasheet, page 70.
 	 */
-	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
+	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
 	if (ret)
 		return ret;
 
-	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
+	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
 	if (ret)
 		return ret;
 
@@ -508,18 +551,19 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
 	 * continuous read mode. Subsequent data reads do not require an
 	 * initial 8-bit write to query the ADC_DATA register.
 	 */
-	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
+	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
 }
 
 static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int unused;
 
 	/*
 	 * To exit continuous read mode, perform a single read of the ADC_DATA
 	 * reg (0x2C), which allows further configuration of the device.
 	 */
-	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
+	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &unused);
 }
 
 static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
@@ -590,6 +634,16 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
+	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap");
+
+	st->regmap24 = devm_regmap_init_spi(spi, &ad7768_regmap24_config);
+	if (IS_ERR(st->regmap24))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap24),
+				     "Failed to initialize regmap24");
+
 	st->vref = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->vref))
 		return PTR_ERR(st->vref);
-- 
2.34.1


