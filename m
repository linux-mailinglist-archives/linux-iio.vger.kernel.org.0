Return-Path: <linux-iio+bounces-22099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE24B13BCE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD85317CB4D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1526B748;
	Mon, 28 Jul 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZwmoyXUM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4526E140;
	Mon, 28 Jul 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710344; cv=none; b=XJoTH9uX5nBOt8s4esUxArAq3L0j8B0kdELXpCa/EsCqF2YFVheEgb+M7mSo8zDfOXrRzdhSuuVXz0aP9sjIAoGwKNGjM9s+19AcQ1d5eqr8kqOu+8kmNJozIROB5BTe6n9X71tu4ae3A0ocZ6fY7dQ2XAXaeLLCzA/CRjgWalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710344; c=relaxed/simple;
	bh=N0tHQvkMAId9EsS+rwsBRdfopgu/oyZZEtFC6WbYcEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DthpEHIpzZz1agRWxtahsj9neO7sezjE4PfnjDy29pRcdmquvn5E+GGqCKZZABI6ikUb09zJmfANDnCc9pkNQDbw0U2QNRDrb+1tB5ORG7YM3WIWzCfNs7ZBrB6NiUAILYApbH9ajJCofGw3LJVC+BojIVqTv/ldA1yEj/xgm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZwmoyXUM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SADPXt016035;
	Mon, 28 Jul 2025 09:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ee43n
	pTgqOuMzdiiroU1b/vC3298Xn8LI2wzlJV0Mt4=; b=ZwmoyXUMmG5Mv1WhHB/Te
	JwcfOrYOhfIwirKE3dxdLKs3yMOSGGSw6vLdemIflbjUu3q2ozk+cPPcxXi6mmaR
	zLOfmICqVl+CWvB4afbZ0Kj5RW6y02YMGAn4mimrNsoWfVfF3TiLkt2M4d/VXoMj
	jayeTeJDAIAitfkEjBHYb6Q/EyyywCM9EVVb+OUioHjBrOEWtFiFbS9ffPVN8NBG
	XbZKHywSj2uoQV+b1tN/dR5zb6jDNdDF04JZUUQYilGT9pKD7szfPp+l/3rG/9D2
	p66afzWRhkI2yVItm5U0yt72Xcdgd7UpzmS6/eQdeVYtkWPsuvCY/u6dQ14/NSgo
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 485dbhwx51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:45:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56SDjJ5c047165
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Jul 2025 09:45:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 28 Jul 2025 09:45:19 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.169])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56SDitBV027767;
	Mon, 28 Jul 2025 09:45:13 -0400
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
Subject: [PATCH 4/4] iio: adc: Update ad7779 to use IIO backend
Date: Mon, 28 Jul 2025 16:43:36 +0300
Message-ID: <20250728134340.3644-5-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5OSBTYWx0ZWRfX7EtbNhme0PaH
 AdkM5SsuyrE55G8IESpPBqQ78GFmZ1XRzhagAZHnVAJXoEI5Z5zt6I0I8CJGGqufwC/xcBJ3NPV
 ui4rpvpZ8aCWI7WzH8zDe4VPfMVpFfKMO/rK4vJrcpnVyrs8ZonQhR80JJMaEep/XK1r7FcO+Ll
 VGlS/kniVf0E8L8+MvVSYuzBokUZP//zzpbuORQx1gk2w1CexLEiVsXfDfNJDL8/MVn5rqTCDBG
 1elf38rw9F8hf2dfldQIa7Yo4CihRU+yuxlbYEX4lLRz7jcC2+KJuxb2jFBDd9/OwjFsiyElETQ
 oXwpet4Vo2Au8PFkQTVsmS6ds/b3HkzMvz2dSL62a9QcMqI22Y1K7Pftvi5A2iXiK0h0ry8ijnj
 /Z7J+dJwNYpCw8eBzMzMBtGW5/uPYoMBFhr1/he8YyfZBGC9FITW5A1jzpIU3mqqWOUxtNIk
X-Authority-Analysis: v=2.4 cv=WN9/XmsR c=1 sm=1 tr=0 ts=68877ef0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=J2y4Sem60MisZtHZY1wA:9
X-Proofpoint-GUID: TTquj49XyucnDCi0oNVHKjs1cmFzymtX
X-Proofpoint-ORIG-GUID: TTquj49XyucnDCi0oNVHKjs1cmFzymtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280099

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 drivers/iio/adc/ad7779.c | 299 +++++++++++++++++++++++++++++++++------
 1 file changed, 256 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 845adc510239..872c551eadf6 100644
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
+	AD7779_4LINES,
+	AD7779_2LINES,
+	AD7779_1LINE,
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
@@ -164,6 +174,12 @@ static const char * const ad7779_filter_type[] = {
 	[AD7779_SINC5] = "sinc5",
 };
 
+static const char * const ad7779_data_lines_modes[] = {
+	[AD7779_4LINES] = "4_data_lines",
+	[AD7779_2LINES] = "2_data_lines",
+	[AD7779_1LINE]  = "1_data_line",
+};
+
 static const char * const ad7779_power_supplies[] = {
 	"avdd1", "avdd2", "avdd4",
 };
@@ -339,6 +355,59 @@ static int ad7779_set_sampling_frequency(struct ad7779_state *st,
 	return 0;
 }
 
+static int ad7779_set_data_lines(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 unsigned int mode)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DOUT_FORMAT_MSK,
+				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, mode));
+	switch (mode) {
+	case AD7779_4LINES:
+		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_FREQ);
+		if (ret)
+			return ret;
+		ret = iio_backend_num_lanes_set(st->back, 4);
+		break;
+	case AD7779_2LINES:
+		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_2LINE);
+		if (ret)
+			return ret;
+		ret = iio_backend_num_lanes_set(st->back, 2);
+		break;
+	case AD7779_1LINE:
+		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_1LINE);
+		if (ret)
+			return ret;
+		ret = iio_backend_num_lanes_set(st->back, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ad7779_get_data_lines(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	u8 temp;
+	int ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_DOUT_FORMAT, &temp);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD7779_DOUT_FORMAT_MSK, temp);
+}
+
 static int ad7779_get_filter(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan)
 {
@@ -630,12 +699,45 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
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
+static const struct iio_enum ad7779_data_lines_enum = {
+	.items = ad7779_data_lines_modes,
+	.num_items = ARRAY_SIZE(ad7779_data_lines_modes),
+	.get = ad7779_get_data_lines,
+	.set = ad7779_set_data_lines,
+};
+
 static const struct iio_enum ad7779_filter_enum = {
 	.items = ad7779_filter_type,
 	.num_items = ARRAY_SIZE(ad7779_filter_type),
@@ -643,6 +745,13 @@ static const struct iio_enum ad7779_filter_enum = {
 	.set = ad7779_set_filter,
 };
 
+static const struct iio_chan_spec_ext_info ad7779_ext_info[] = {
+	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad7779_data_lines_enum),
+	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
+			   &ad7779_data_lines_enum),
+	{ }
+};
+
 static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7779_filter_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
@@ -650,6 +759,16 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 	{ }
 };
 
+static const struct iio_chan_spec_ext_info ad7779_ext_info_filter[] = {
+	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad7779_data_lines_enum),
+	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
+			   &ad7779_data_lines_enum),
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7779_filter_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+			   &ad7779_filter_enum),
+	{ }
+};
+
 #define AD777x_CHAN_S(index, _ext_info)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
@@ -669,11 +788,34 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
 		},							\
 	}
 
+#define AD777X_CHAN(index, _ext_info)					       \
+	{								       \
+		.type = IIO_VOLTAGE,					       \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
+		.address = (index),					       \
+		.indexed = 1,						       \
+		.channel = (index),					       \
+		.scan_index = (index),					       \
+		.ext_info = (_ext_info),				       \
+		.scan_type = {						       \
+			.sign = 's',					       \
+			.realbits = 24,					       \
+			.storagebits = 32,				       \
+		},							       \
+	}
+
 #define AD777x_CHAN_NO_FILTER_S(index)					\
 	AD777x_CHAN_S(index, NULL)
 
+#define AD777X_CHAN_NO_FILTER(index)					       \
+	AD777X_CHAN(index, ad7779_ext_info)
+
 #define AD777x_CHAN_FILTER_S(index)					\
 	AD777x_CHAN_S(index, ad7779_ext_filter)
+
+#define AD777X_CHAN_FILTER(index)					       \
+	AD777X_CHAN(index, ad7779_ext_info_filter)
+
 static const struct iio_chan_spec ad7779_channels[] = {
 	AD777x_CHAN_NO_FILTER_S(0),
 	AD777x_CHAN_NO_FILTER_S(1),
@@ -686,6 +828,17 @@ static const struct iio_chan_spec ad7779_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
+static const struct iio_chan_spec ad7779_channels_data[] = {
+	AD777X_CHAN_NO_FILTER(0),
+	AD777X_CHAN_NO_FILTER(1),
+	AD777X_CHAN_NO_FILTER(2),
+	AD777X_CHAN_NO_FILTER(3),
+	AD777X_CHAN_NO_FILTER(4),
+	AD777X_CHAN_NO_FILTER(5),
+	AD777X_CHAN_NO_FILTER(6),
+	AD777X_CHAN_NO_FILTER(7),
+};
+
 static const struct iio_chan_spec ad7779_channels_filter[] = {
 	AD777x_CHAN_FILTER_S(0),
 	AD777x_CHAN_FILTER_S(1),
@@ -698,6 +851,17 @@ static const struct iio_chan_spec ad7779_channels_filter[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
+static const struct iio_chan_spec ad7779_channels_filter_data[] = {
+	AD777X_CHAN_FILTER(0),
+	AD777X_CHAN_FILTER(1),
+	AD777X_CHAN_FILTER(2),
+	AD777X_CHAN_FILTER(3),
+	AD777X_CHAN_FILTER(4),
+	AD777X_CHAN_FILTER(5),
+	AD777X_CHAN_FILTER(6),
+	AD777X_CHAN_FILTER(7),
+};
+
 static const struct iio_buffer_setup_ops ad7779_buffer_setup_ops = {
 	.preenable = ad7779_buffer_preenable,
 	.postdisable = ad7779_buffer_postdisable,
@@ -752,6 +916,91 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_register_irq(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &st->spi->dev;
+
+	indio_dev->info = &ad7779_info;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
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
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad7779_register_back(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->spi->dev;
+	int ret = -EINVAL;
+
+	indio_dev->info = &ad7779_info_data;
+
+	if (strcmp(st->chip_info->name, "ad7771") == 0) {
+		indio_dev->channels = ad7779_channels_filter_data;
+		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_filter_data);
+	} else {
+		indio_dev->channels = ad7779_channels_data;
+		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_data);
+	}
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
+	ret = iio_backend_num_lanes_set(st->back, 4);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -760,8 +1009,8 @@ static int ad7779_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int ret = -EINVAL;
 
-	if (!spi->irq)
-		return dev_err_probe(dev, ret, "DRDY irq not present\n");
+	if (!spi->irq && !device_property_present(dev, "io-backends"))
+		return dev_err_probe(dev, ret, "Either DRDY interrupt or io-backends property required\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
@@ -804,49 +1053,12 @@ static int ad7779_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->chip_info->name;
-	indio_dev->info = &ad7779_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
-
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
 
-	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
-				    AD7779_DCLK_CLK_DIV_MSK,
-				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(dev, indio_dev);
+	if (spi->irq)
+		return ad7779_register_irq(st, indio_dev);
+	else
+		return ad7779_register_back(st, indio_dev);
 }
 
 static int ad7779_suspend(struct device *dev)
@@ -936,3 +1148,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2


