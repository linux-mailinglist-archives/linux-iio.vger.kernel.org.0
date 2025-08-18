Return-Path: <linux-iio+bounces-22921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34611B2A49A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E2318985FB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7665320CD2;
	Mon, 18 Aug 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gLOWiNOS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2C32142A;
	Mon, 18 Aug 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522880; cv=none; b=bcVxL5xqhAgJIbzUs6QYZNrya0yQB7NP47Bugt09OZJ92I4NbSgIL9XjH/bKhVQRXXjzPw5Idi6ifi7dhps/I52B5ZJbj1xhlU+bwxG69QhntDdyaJmmic6jFWhUywUFmN06UL6Bsv5r2O/fJl+eR0Dgx/dVYCDoxs+j8ngtnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522880; c=relaxed/simple;
	bh=VzaCyAy2htS8qS21zGo3UG++H4hRnYMu/4KgfTGxFhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVlbBmcHh/6uyKIAlrP89B0RBIz5vvgZImZ0gmtPNFT8B+G7WDn+RriqBZ5CPOUzOkNAGJ1qp5K95rEJZjuBwD4QptHKtYQz5jr119WECtV3Jt3842yO7Ddk0eTXneV2TdUY5Mjfcm7sGtRJHGYaTWBXqHFV+h6wdRR6QyxN8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gLOWiNOS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBnFQb023229;
	Mon, 18 Aug 2025 09:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=isQY0
	mAR2XnjXkg8107t7+TbnXq4mjM4Y+HqY56c2MA=; b=gLOWiNOSoTcTSQDb+M29f
	9VvKRjj2hmFvTxEDGTDflfjOQ2LGt4QFo5zNZjL4i+ULjrQZ/3/NpJSQ6X3F/QBK
	+7Xk00S1mG1igkhOq2FVuiKEf4zjOGGfrRDb7qd3hRCdrmXJ/WGU6wbnw8u/Rz1p
	U2quA2Bg/oH24vkN9ZjDljfGDP2cPby37xR2QJ0xO+geZcrMNnU1FxoxxQB7btqn
	InUTnW6cSVFn/ixT2DpY2uMyXbOcyQVXMOWQ8SEMkb6skH3lJgS3G66gnzlUFmgE
	kLxAhMIlmzgA5YpmY93ebnYoEnRU3nqb47hWBOarXmpq55Vedyrp1TlUWd9MTLGd
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48k8afe7ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 09:14:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57IDENeo044148
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 09:14:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 09:14:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 09:14:23 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IDD8Op008451;
	Mon, 18 Aug 2025 09:14:17 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v3 4/4] iio: adc: update ad7779 to use IIO backend
Date: Mon, 18 Aug 2025 16:12:50 +0300
Message-ID: <20250818131253.8854-5-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDA0NiBTYWx0ZWRfX241/XXzW6ukb
 3d7D1g74+I/9Sgi/ACKyuXei1qv4QqZHdMn9R2f4+JZImZte99Seo3QyROynwqaif1+Be/N3Oh5
 Z/OUPyBICzWXOzAJLGFhkrLOzKfpK49tN+LpBAIJcmjgY74JJ6Ts86V9JwpWL2LBplc1TLYTD5M
 obn0ta7zeUACIZFd5X2gZwfLNTgUBhpuGDpuR1lG9uKx/btuLdrEl/fnmWsMYm1R6JU7VYQ2Emp
 xNDgU9WHU039nH7y3UKerDoLMNVLxlZOEvXN7VVx/ci1GghaljIr6/lDZ0+E4DH5Q60ZTC8dlMK
 g5RV3adHz8djrE1YfANo7XhlwnXmid9aXK1Ao+5adu1j0PLPMGq6Ld7A/MT+tEax+CQ+nl6b0b+
 sDtD/Akl
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=68a32731 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VjRcvFoKhyOr0kwuT1sA:9
X-Proofpoint-GUID: snqDfVzoHa0s5LdFkNtb21qdUZjRAfSE
X-Proofpoint-ORIG-GUID: snqDfVzoHa0s5LdFkNtb21qdUZjRAfSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508170046

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 drivers/iio/adc/ad7779.c | 107 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index f7e681c0e8c0..abf3fff20dd4 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -31,6 +31,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <linux/iio/backend.h>
+
 #define AD7779_SPI_READ_CMD			BIT(7)
 
 #define AD7779_DISABLE_SD			BIT(7)
@@ -157,6 +159,8 @@ struct ad7779_state {
 	u8			reg_rx_buf[3];
 	u8			reg_tx_buf[3];
 	u8			reset_buf[8];
+
+	struct iio_backend *back;
 };
 
 static const char * const ad7779_filter_type[] = {
@@ -630,12 +634,38 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
 	return ret;
 }
 
+static int ad7779_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < AD7779_NUM_CHANNELS; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct iio_info ad7779_info = {
 	.read_raw = ad7779_read_raw,
 	.write_raw = ad7779_write_raw,
 	.debugfs_reg_access = &ad7779_reg_access,
 };
 
+static const struct iio_info ad7779_info_data = {
+	.read_raw = ad7779_read_raw,
+	.write_raw = ad7779_write_raw,
+	.debugfs_reg_access = &ad7779_reg_access,
+	.update_scan_mode = &ad7779_update_scan_mode,
+};
+
 static const struct iio_enum ad7779_filter_enum = {
 	.items = ad7779_filter_type,
 	.num_items = ARRAY_SIZE(ad7779_filter_type),
@@ -674,6 +704,7 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 
 #define AD777x_CHAN_FILTER_S(index)					\
 	AD777x_CHAN_S(index, ad7779_ext_filter)
+
 static const struct iio_chan_spec ad7779_channels[] = {
 	AD777x_CHAN_NO_FILTER_S(0),
 	AD777x_CHAN_NO_FILTER_S(1),
@@ -752,6 +783,44 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_set_data_lines(struct iio_dev *indio_dev,
+				 unsigned int num_lanes)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_num_lanes_set(st->back, num_lanes);
+	if (ret)
+		return ret;
+
+	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DOUT_FORMAT_MSK,
+				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
+}
+
+static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
+{
+	struct iio_chan_spec *channels;
+	struct device *dev = &st->spi->dev;
+
+	channels = devm_kmemdup_array(dev, st->chip_info->channels,
+					ARRAY_SIZE(ad7779_channels),
+					sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	for (int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)
+		channels[i].scan_type.endianness = IIO_CPU;
+
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
 static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
 {
 	int ret;
@@ -796,6 +865,38 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
 }
 
+static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->spi->dev;
+	int ret = -EINVAL;
+	int num_lanes;
+
+	indio_dev->info = &ad7779_info_data;
+
+	ret = ad7779_setup_channels(indio_dev, st);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get iio backend");
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
+	if (ret)
+		return ad7779_set_data_lines(indio_dev, 4);
+
+	return ad7779_set_data_lines(indio_dev, num_lanes);
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -848,7 +949,10 @@ static int ad7779_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	ret = ad7779_setup_without_backend(st, indio_dev);
+	if (device_property_present(dev, "io-backends"))
+		ret = ad7779_setup_backend(st, indio_dev);
+	else
+		ret = ad7779_setup_without_backend(st, indio_dev);
 
 	if (ret)
 		return ret;
@@ -943,3 +1047,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2


