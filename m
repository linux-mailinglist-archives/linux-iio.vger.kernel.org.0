Return-Path: <linux-iio+bounces-22354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BAB1CC89
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D0018C574D
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37272BD598;
	Wed,  6 Aug 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VKG9QgfK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEE2BD58A;
	Wed,  6 Aug 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508498; cv=none; b=fpF/JxlsE+wAT6FrTLM6zpEdyMtLRWmbPt6dql2+r2aLGTjEri4+QSEh8+g+WNqNNPuIg3vSdENj5Hs/2N5imO5MaRBgrdbek4UKk0fE3Pi7Wz1IZQYTI4DmI/f/5KumxZ/k5mFWn3MkTN4vRG0Ygp3xfZG5yL6VpXxH5jvMmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508498; c=relaxed/simple;
	bh=zPvIyE5SVNz3oGYXYMglpHhiDbqD0EkBvQ4vnkEqvKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/IboWa+dm6K+Net1ONtb9mvgt1qlszC/IBgjY4zsR6cOSL24y6X8N2y9hB0yRnofctQ5bsS7uI/IfpBt20FkvJN/bA6BjXdddWxGZIE31QeL2AumHPUhWBsbl/PZ/eD8mnedgHeTrcA+oGOdkzzS4rmow18o5cI2xVfhy5c010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VKG9QgfK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576J3KXq013500;
	Wed, 6 Aug 2025 15:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Kf7z
	6Ft5KKcNUwUTWHYmG368LzX20z4mjmc9JV2O70=; b=VKG9QgfK25JsNtYw1ZI5W
	qYfVIf9YTZr0xMAQM5JrGH04uRXNKpwkfFd8szVPk02Db/G2imDCKfbqhNebGM3X
	4m3lAHyfNhuG6scY0+5CK0xY2fHGNq9sUSmN/BO1740UO1Jgd3QEXunVZDocn7YH
	11k1Splq0k8e35nnJ7+IaKyqDG3MX/198mlrf2Adxbxw1BrNWe4bRGVhyeNoWSAK
	usgtKrRDMFF99O/YTycCfAzYKZu1Xpu3sZAjq2rqV+RM20AXISiKev4I5P/1l7PB
	uxJXhptGq12qYwVKlPQbtsbRJVi1fhBzwkhH0IviuVoMoZwFrhTk0MW1vnqypgQK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48bpw26a4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:28:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 576JS1pD053751
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Aug 2025 15:28:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:28:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:28:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 6 Aug 2025 15:28:00 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.132.255.77])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 576JQAa5004911;
	Wed, 6 Aug 2025 15:27:51 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
Date: Wed, 6 Aug 2025 22:25:00 +0300
Message-ID: <20250806192502.10120-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I79lRMgg c=1 sm=1 tr=0 ts=6893acc2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=JDRFuUvREIAUBeFSvZUA:9
X-Proofpoint-ORIG-GUID: Ikr0X-_NqFS_p1fSF4fljdQbXiQVcUsk
X-Proofpoint-GUID: Ikr0X-_NqFS_p1fSF4fljdQbXiQVcUsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE2MyBTYWx0ZWRfXzUskJcgTaHDY
 iR/ns5chMzOeJ5o36UoknT6W1pRDMMOgaH8wI9d68jiZYaoe7S1JiSe4c2tnStw3uyLpXBZfGWU
 doB5Ar/Wl9EfgQ3hO17RdHu3mH8zJj3arpJM58NQqWkeFLEX7UTnOsCQ4IvmH/lxDDLJyhSZ7VN
 mOYhr5DzgqvJysWTtYm0EyFNhjliP9TAqr+LGFOaHeR+0SyAAG+FmSUUWVbMTEsnWlUNMET35OI
 j2iD9reD5KAj5uOPI0b2FahsaWm9bGyXXN4ZjC07AGSYRZKPC0qVW5eoM13nW8mm5r1f4DYmuf0
 6Inkwhn/COf+o95wgP45ZeLe9HgyABDkuY4D6ECA4dsw+xTuMZhUsXx/AECN68LlcmjEsCJnVUu
 9277tj00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508050163

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 drivers/iio/adc/ad7779.c | 242 +++++++++++++++++++++++++++++----------
 1 file changed, 183 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 845adc510239..a69fda1f4581 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -31,6 +31,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <linux/iio/backend.h>
+
 #define AD7779_SPI_READ_CMD			BIT(7)
 
 #define AD7779_DISABLE_SD			BIT(7)
@@ -116,6 +118,12 @@
 #define AD7779_CRC8_POLY			0x07
 DECLARE_CRC8_TABLE(ad7779_crc8_table);
 
+enum ad7779_data_lines {
+	AD7779_4LINES = 4,
+	AD7779_2LINES = 2,
+	AD7779_1LINE = 1,
+};
+
 enum ad7779_filter {
 	AD7779_SINC3,
 	AD7779_SINC5,
@@ -157,6 +165,8 @@ struct ad7779_state {
 	u8			reg_rx_buf[3];
 	u8			reg_tx_buf[3];
 	u8			reset_buf[8];
+
+	struct iio_backend *back;
 };
 
 static const char * const ad7779_filter_type[] = {
@@ -630,12 +640,38 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
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
@@ -650,7 +686,7 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 	{ }
 };
 
-#define AD777x_CHAN_S(index, _ext_info)					\
+#define AD777X_CHAN_S(index, _ext_info)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE)  |	\
@@ -669,32 +705,33 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 		},							\
 	}
 
-#define AD777x_CHAN_NO_FILTER_S(index)					\
-	AD777x_CHAN_S(index, NULL)
+#define AD777X_CHAN_NO_FILTER_S(index)					\
+	AD777X_CHAN_S(index, NULL)
+
+#define AD777X_CHAN_FILTER_S(index)					\
+	AD777X_CHAN_S(index, ad7779_ext_filter)
 
-#define AD777x_CHAN_FILTER_S(index)					\
-	AD777x_CHAN_S(index, ad7779_ext_filter)
 static const struct iio_chan_spec ad7779_channels[] = {
-	AD777x_CHAN_NO_FILTER_S(0),
-	AD777x_CHAN_NO_FILTER_S(1),
-	AD777x_CHAN_NO_FILTER_S(2),
-	AD777x_CHAN_NO_FILTER_S(3),
-	AD777x_CHAN_NO_FILTER_S(4),
-	AD777x_CHAN_NO_FILTER_S(5),
-	AD777x_CHAN_NO_FILTER_S(6),
-	AD777x_CHAN_NO_FILTER_S(7),
+	AD777X_CHAN_NO_FILTER_S(0),
+	AD777X_CHAN_NO_FILTER_S(1),
+	AD777X_CHAN_NO_FILTER_S(2),
+	AD777X_CHAN_NO_FILTER_S(3),
+	AD777X_CHAN_NO_FILTER_S(4),
+	AD777X_CHAN_NO_FILTER_S(5),
+	AD777X_CHAN_NO_FILTER_S(6),
+	AD777X_CHAN_NO_FILTER_S(7),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 static const struct iio_chan_spec ad7779_channels_filter[] = {
-	AD777x_CHAN_FILTER_S(0),
-	AD777x_CHAN_FILTER_S(1),
-	AD777x_CHAN_FILTER_S(2),
-	AD777x_CHAN_FILTER_S(3),
-	AD777x_CHAN_FILTER_S(4),
-	AD777x_CHAN_FILTER_S(5),
-	AD777x_CHAN_FILTER_S(6),
-	AD777x_CHAN_FILTER_S(7),
+	AD777X_CHAN_FILTER_S(0),
+	AD777X_CHAN_FILTER_S(1),
+	AD777X_CHAN_FILTER_S(2),
+	AD777X_CHAN_FILTER_S(3),
+	AD777X_CHAN_FILTER_S(4),
+	AD777X_CHAN_FILTER_S(5),
+	AD777X_CHAN_FILTER_S(6),
+	AD777X_CHAN_FILTER_S(7),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
@@ -752,6 +789,126 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
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
+static int ad7779_conf_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
+{
+	struct iio_chan_spec *channels;
+	struct device *dev = &st->spi->dev;
+	int num_channels = ARRAY_SIZE(ad7779_channels);
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	memcpy(channels, st->chip_info->channels, num_channels * sizeof(struct iio_chan_spec));
+
+	for (int i = 0; i < 8; i++)
+		channels[i].scan_type.endianness = IIO_CPU;
+
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
+static int setup_irq(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &st->spi->dev;
+
+	indio_dev->info = &ad7779_info;
+	indio_dev->channels = st->chip_info->channels;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7779_trigger_ops;
+
+	iio_trigger_set_drvdata(st->trig, st);
+
+	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
+			       st->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
+					st->spi->irq);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	init_completion(&st->completion);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad7779_trigger_handler,
+					      &ad7779_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int setup_back(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->spi->dev;
+	int ret = -EINVAL;
+	int num_lanes;
+
+	indio_dev->info = &ad7779_info_data;
+
+	ret = ad7779_conf_channels(indio_dev, st);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back)) {
+		dev_err_probe(dev, ret, "failed to get iio backend");
+		return PTR_ERR(st->back);
+	}
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
+	if (ret < 0)
+		return ad7779_set_data_lines(indio_dev, 4);
+
+	return ad7779_set_data_lines(indio_dev, num_lanes);
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -760,9 +917,6 @@ static int ad7779_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int ret = -EINVAL;
 
-	if (!spi->irq)
-		return dev_err_probe(dev, ret, "DRDY irq not present\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -804,45 +958,14 @@ static int ad7779_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->chip_info->name;
-	indio_dev->info = &ad7779_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &ad7779_trigger_ops;
-
-	iio_trigger_set_drvdata(st->trig, st);
-
-	ret = devm_request_irq(dev, spi->irq, iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
-			       st->trig);
-	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
-				     st->spi->irq);
-
-	ret = devm_iio_trigger_register(dev, st->trig);
-	if (ret)
-		return ret;
-
-	indio_dev->trig = iio_trigger_get(st->trig);
-
-	init_completion(&st->completion);
-
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7779_trigger_handler,
-					      &ad7779_buffer_setup_ops);
-	if (ret)
-		return ret;
+	if (device_property_present(dev, "io-backends"))
+		ret = setup_back(st, indio_dev);
+	else
+		ret = setup_irq(st, indio_dev);
 
-	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
-				    AD7779_DCLK_CLK_DIV_MSK,
-				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
 	if (ret)
 		return ret;
 
@@ -936,3 +1059,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2


