Return-Path: <linux-iio+bounces-14621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C818A1D92B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EED3A4FBB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB3413AD22;
	Mon, 27 Jan 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WK6U6xDf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333F13C809;
	Mon, 27 Jan 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990794; cv=none; b=QY0ibi7Vuz68vDe/9F6eLijQ+VyPpdh5hkQGNZqf1SiSbpSToq/P3xQma382LcpnQRxZCazbHJM7HCQERbV0UTUp/43jIUiS2Nm/BWihYtGHVrVR9FMjyTdcA5HK9DPQ+tSgR7gAmEB2dLud8gedlLo7dIlVH3VsUFGOB5PpdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990794; c=relaxed/simple;
	bh=bo91lLc374d58BLY0qSELC7/XEICs7m0/4pChC9tSNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZfNBgnq12uMaSJ64RdQ5LHK2Xc1NfsqrOLcIJehCvU7JQUSwVeLGICYuOlzRCZkhQU+qqSLTM0CTWFVpNjYLtLcgJZbtm5ECoSWCryf7teOkrlTa8FNaLZai69BzXSilSeKPbVmO4XuVeeEaxF7A/+SrHtIMy9CSMfHHwJew1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WK6U6xDf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9qf6p005403;
	Mon, 27 Jan 2025 10:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5yMcE
	54VQjcf6SeoSNw1A5vOpUq3YnPrnhct8E5RiiY=; b=WK6U6xDfIq8xV0l6ZVx+6
	DCA5yToDkQk5zY3ITo2KgHwueXdzqpS/t/PdkJFKn1eacJ3bw9Zou7C/aCKTKok2
	zK2CnBialFQrB+/cj31XkP1PbXIl2sD6WTWxNj38gjwEzqUieTHulo9qbsGK03CJ
	F1MeeojvNpF6hmWW1M5HBkpA7LoRfwty61ZBxsmBLtX4ZgpyFCzevTqnBXBbioBh
	gbuTGPayMz7YNIROqPAzpOCYBzwsCmQx2xSPHwWcQIpe+M704QTMV6Ug3qW9bSqB
	iCPkjRS7gp7QhGfKoOusbMS54HLf2VsOxOM3c05oQirW8k8nijJHjYAOOa9H8h7R
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e2n128ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:12:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFCwM7038563
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:12:58 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:58 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:12:57 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFCiua008423;
	Mon, 27 Jan 2025 10:12:46 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 07/16] iio: adc: ad7768-1: convert driver to use regmap
Date: Mon, 27 Jan 2025 12:12:43 -0300
Message-ID: <0968f9cfc55c5ac80492a88bbe95fc8ff7208fa5.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AHekaWd_ZdkzEDftGqMuzIhqjjCls8ac
X-Proofpoint-ORIG-GUID: AHekaWd_ZdkzEDftGqMuzIhqjjCls8ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

Convert the AD7768-1 driver to use the regmap API for register
access. This change simplifies and standardizes register interactions,
reducing code duplication and improving maintainability.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* New patch in v2.
---
 drivers/iio/adc/ad7768-1.c | 82 +++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 95ba89435652..fb8d6fae5f8a 100644
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
@@ -153,6 +154,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct regmap *regmap;
 	struct regulator *vref;
 	struct mutex lock;
 	struct clk *mclk;
@@ -176,12 +178,17 @@ struct ad7768_state {
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
-static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
-			       unsigned int len)
+static int ad7768_spi_reg_read(void *context, unsigned int addr,
+			       unsigned int *val)
 {
-	unsigned int shift;
+	struct iio_dev *dev = context;
+	struct ad7768_state *st;
+	unsigned int shift, len;
 	int ret;
 
+	st = iio_priv(dev);
+	/* Regular value size is 1 Byte, but 3 Bytes for ADC data */
+	len = (addr == AD7768_REG_ADC_DATA) ? 3 : 1;
 	shift = 32 - (8 * len);
 	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
 
@@ -190,13 +197,19 @@ static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
 	if (ret < 0)
 		return ret;
 
-	return (be32_to_cpu(st->data.d32) >> shift);
+	*val = be32_to_cpu(st->data.d32) >> shift;
+
+	return 0;
 }
 
-static int ad7768_spi_reg_write(struct ad7768_state *st,
+static int ad7768_spi_reg_write(void *context,
 				unsigned int addr,
 				unsigned int val)
 {
+	struct iio_dev *dev = context;
+	struct ad7768_state *st;
+
+	st = iio_priv(dev);
 	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
 	st->data.d8[1] = val & 0xFF;
 
@@ -206,16 +219,16 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
-	int regval;
+	int regval, ret;
 
-	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
-	if (regval < 0)
-		return regval;
+	ret = regmap_read(st->regmap, AD7768_REG_CONVERSION, &regval);
+	if (ret)
+		return ret;
 
 	regval &= ~AD7768_CONV_MODE_MSK;
 	regval |= AD7768_CONV_MODE(mode);
 
-	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
+	return regmap_write(st->regmap, AD7768_REG_CONVERSION, regval);
 }
 
 static int ad7768_scan_direct(struct iio_dev *indio_dev)
@@ -234,9 +247,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
-	if (readval < 0)
-		return readval;
+	ret = regmap_read(st->regmap, AD7768_REG_ADC_DATA, &readval);
+	if (ret)
+		return ret;
+
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -258,13 +272,11 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	if (readval) {
-		ret = ad7768_spi_reg_read(st, reg, 1);
-		if (ret < 0)
+		ret = regmap_read(st->regmap, reg, readval);
+		if (ret)
 			goto err_unlock;
-		*readval = ret;
-		ret = 0;
 	} else {
-		ret = ad7768_spi_reg_write(st, reg, writeval);
+		ret = regmap_write(st->regmap, reg, writeval);
 	}
 err_unlock:
 	mutex_unlock(&st->lock);
@@ -283,7 +295,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 	else
 		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
 
-	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
+	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
 	if (ret < 0)
 		return ret;
 
@@ -320,7 +332,7 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	 */
 	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
 		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
-	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
+	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
 	if (ret < 0)
 		return ret;
 
@@ -447,11 +459,11 @@ static int ad7768_setup(struct ad7768_state *st)
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
 
@@ -509,18 +521,19 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
 	 * continuous read mode. Subsequent data reads do not require an
 	 * initial 8-bit write to query the ADC_DATA register.
 	 */
-	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
+	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
 }
 
 static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 
 	/*
 	 * To exit continuous read mode, perform a single read of the ADC_DATA
 	 * reg (0x2C), which allows further configuration of the device.
 	 */
-	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
+	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &regval);
 }
 
 static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
@@ -563,6 +576,20 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static const struct regmap_bus ad7768_regmap_bus = {
+	.reg_write = ad7768_spi_reg_write,
+	.reg_read = ad7768_spi_reg_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static const struct regmap_config ad7768_regmap_config = {
+	.name = "ad7768-1",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD7768_REG_MCLK_COUNTER,
+};
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -592,6 +619,13 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
+	st->regmap = devm_regmap_init(&spi->dev,
+				      &ad7768_regmap_bus, indio_dev,
+				      &ad7768_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap");
+
 	st->vref = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->vref))
 		return PTR_ERR(st->vref);
-- 
2.34.1


