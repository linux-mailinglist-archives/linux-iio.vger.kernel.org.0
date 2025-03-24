Return-Path: <linux-iio+bounces-17232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A038FA6D70B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FA67A3E40
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CFC25D91A;
	Mon, 24 Mar 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t9Tq5xJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8C14EC46;
	Mon, 24 Mar 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807473; cv=none; b=E+Rs7Wb68IdkbzsBVdAYfcnffF7WhenPn7mYZQZtDT0y2oLusY90Jkc8SgU7w8zDbhRl0WEzlEt5cewCP+DRPsdSaUK7KaRbGHUTrSWoBG4hwSVahZTXVAlmo7ZEGCkcKJLPvxKkSJkvraW6DHQgc4ioIMpsr7GD3NU5RR1vUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807473; c=relaxed/simple;
	bh=Q/bMuKRNaJxK8Xj+Cj3p0bILcfFYQhz+mkD/FNKINsA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjFLuzyaCkHgiaAK81rnU9vTLceLtmLTXXjgPXfhQ6oMn3wvLjylwKMyCipg/bQijW2IOLWdN2l4lOgNu3fzt5GO6KmJrQmF1dAX9SosZNrO2ybIrlL6Gp02POMgDcxURbfy3S9eIFDKZWRaS6buD8cPDrAPOvoyLsXl8o8uhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t9Tq5xJ0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5tB4q000579;
	Mon, 24 Mar 2025 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qosvk
	KF90iXKnrJt1urw7U6F0qXU4/S9Zt0tJgi00JU=; b=t9Tq5xJ0Wq+6jQaV2+9uS
	oe7gQoh57rhiVAEIoyNN2rDg0trQMeJVbEDQyI1gb2uBoZytTjZPPsyfZ6W4cOQ8
	qJPVHz/TT+ZW8DOq7TqcNoaviVYncvOHaPI1G+yD9x2g3q5YmXYFwfL10g66HCcY
	Nqkrjr9d6gRe/SOjQ7tSdAXSeBNSAPGnECaEu3Vs5TKye0KqIaNI2Bwdq7JtLLKM
	mweaz+D91MhxJwm+NXyb+jEm/IQNUNZVHRR8+otEaZF8y98RF8lhiz177obAoos0
	eDf3BI0Osk49h20qEcYgQb5jNpPtN/yPDQxfRa4p/XtfEiBlbJeKEt3WhtBiG8Sm
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45hq27a5py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:10:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O9Anwp059021
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:10:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 05:10:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 05:10:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:10:48 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y6E001058;
	Mon, 24 Mar 2025 05:10:39 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        "Javier
 Carrasco" <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Michael Walle
	<michael@walle.cc>,
        Herve Codina <herve.codina@bootlin.com>,
        "Thomas
 Bonnefille" <thomas.bonnefille@bootlin.com>,
        Pop Ioan Daniel
	<pop.ioan-daniel@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] iio: adc: ad7405: add ad7405 driver
Date: Mon, 24 Mar 2025 11:08:00 +0200
Message-ID: <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7Q0XEZaNTTlgPCfJpx1qciN6bpKcMM8z
X-Proofpoint-GUID: 7Q0XEZaNTTlgPCfJpx1qciN6bpKcMM8z
X-Authority-Analysis: v=2.4 cv=DoZW+H/+ c=1 sm=1 tr=0 ts=67e1219a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=3EAs76dHXMSs3TCrLnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add support for the AD7405/ADUM770x, a high performance isolated ADC,
1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
analog input signal into a high speed, single-bit data stream.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7405.c | 301 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 drivers/iio/adc/ad7405.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f64b5faeb257..321a1ee7304f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -203,6 +203,16 @@ config AD7380
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7380.
 
+config AD7405
+	tristate "Analog Device AD7405 ADC Driver"
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
+	  ADUM7702, ADUM7703 analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7405.
+
 config AD7476
 	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..0c3c1c69b6b4 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7380) += ad7380.o
+obj-$(CONFIG_AD7405) += ad7405.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
new file mode 100644
index 000000000000..40fe072369d5
--- /dev/null
+++ b/drivers/iio/adc/ad7405.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD7405 driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/log2.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
+#include <linux/util_macros.h>
+#include <linux/regulator/consumer.h>
+
+#define AD7405_DEFAULT_DEC_RATE 1024
+
+const unsigned int ad7405_dec_rates[] = {
+		4096, 2048, 1024, 512, 256, 128, 64, 32,
+};
+
+struct ad7405_chip_info {
+	const char *name;
+	unsigned int num_channels;
+	unsigned int max_rate;
+	unsigned int min_rate;
+	struct iio_chan_spec channel[3];
+	const unsigned long *available_mask;
+};
+
+struct ad7405_state {
+	struct iio_backend *back;
+	struct clk *axi_clk_gen;
+	/* lock to protect multiple accesses to the device registers */
+	struct mutex lock;
+	struct regmap *regmap;
+	struct iio_info iio_info;
+	const struct ad7405_chip_info *info;
+	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];
+	unsigned int sample_frequency;
+	unsigned int ref_frequency;
+};
+
+static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
+		st->sample_frequency_tbl[i] = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);
+}
+
+static int ad7405_set_sampling_rate(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int samp_rate)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+	unsigned int dec_rate, idx;
+	int ret;
+
+	dec_rate = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, samp_rate);
+
+	idx = find_closest_descending(dec_rate, ad7405_dec_rates,
+				      ARRAY_SIZE(ad7405_dec_rates));
+
+	    dec_rate = ad7405_dec_rates[idx];
+
+	ret = iio_backend_set_dec_rate(st->back, dec_rate);
+	if (ret)
+		return ret;
+
+	st->sample_frequency = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, dec_rate);
+
+	return 0;
+}
+
+static int ad7405_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < indio_dev->num_channels; c++) {
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
+static int ad7405_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+			*val = st->sample_frequency;
+
+			return IIO_VAL_INT;
+	default:
+			return -EINVAL;
+	}
+}
+
+static int ad7405_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+
+			return ad7405_set_sampling_rate(indio_dev, chan, val);
+
+	default:
+			return -EINVAL;
+	}
+}
+
+static int ad7405_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+				 const int **vals, int *type, int *length,
+				 long info)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+			*vals = st->sample_frequency_tbl;
+			*length = ARRAY_SIZE(st->sample_frequency_tbl);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+	default:
+			return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7405_iio_info = {
+	.read_raw = &ad7405_read_raw,
+	.write_raw = &ad7405_write_raw,
+	.read_avail = &ad7405_read_avail,
+	.update_scan_mode = ad7405_update_scan_mode,
+};
+
+#define AD7405_IIO_CHANNEL(_chan, _bits, _sign)		  \
+	{ .type = IIO_VOLTAGE,					  \
+	  .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	  .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	  .indexed = 1,						 \
+	  .channel = _chan,					 \
+	  .scan_type = {				\
+		.sign = _sign,				\
+		.realbits = _bits,			\
+		.storagebits = 16,			\
+		.shift = 0,				\
+	  },						\
+	}
+
+static const unsigned long ad7405_channel_masks[] = {
+		BIT(0),
+		0,
+};
+
+static const struct ad7405_chip_info ad7405_chip_info = {
+		.name = "AD7405",
+		.max_rate = 625000UL,
+		.min_rate = 4883UL,
+		.num_channels = 1,
+		.channel = {
+			AD7405_IIO_CHANNEL(0, 16, 'u'),
+		},
+		.available_mask = ad7405_channel_masks,
+};
+
+static const struct ad7405_chip_info adum7701_chip_info = {
+		.name = "ADUM7701",
+		.max_rate = 656250UL,
+		.min_rate = 5127UL,
+		.num_channels = 1,
+		.channel = {
+			AD7405_IIO_CHANNEL(0, 16, 'u'),
+		},
+		.available_mask = ad7405_channel_masks,
+};
+
+static const char * const ad7405_power_supplies[] = {
+	"vdd1",	"vdd2",
+};
+
+static int ad7405_probe(struct platform_device *pdev)
+{
+	const struct ad7405_chip_info *chip_info;
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct ad7405_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	chip_info = &ad7405_chip_info;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	st->axi_clk_gen = devm_clk_get(dev, NULL);
+	if (IS_ERR(st->axi_clk_gen))
+		return PTR_ERR(st->axi_clk_gen);
+
+	ret = clk_prepare_enable(st->axi_clk_gen);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
+					     ad7405_power_supplies);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get and enable supplies");
+
+	st->ref_frequency = clk_get_rate(st->axi_clk_gen);
+
+	ad7405_fill_samp_freq_table(st);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->name = pdev->dev.of_node->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels = chip_info->channel;
+	indio_dev->num_channels = chip_info->num_channels;
+
+	st->iio_info = ad7405_iio_info;
+	indio_dev->info = &st->iio_info;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get IIO backend");
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	/* Reset all HDL Cores */
+	iio_backend_disable(st->back);
+	iio_backend_enable(st->back);
+
+	ret = ad7405_set_sampling_rate(indio_dev, &indio_dev->channels[0],
+				       chip_info->max_rate);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Match table for of_platform binding */
+static const struct of_device_id ad7405_of_match[] = {
+	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
+	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
+	{ .compatible = "adi,adum7702", .data = &adum7701_chip_info, },
+	{ .compatible = "adi,adum7703", .data = &adum7701_chip_info, },
+	{ /* end of list */ },
+};
+
+MODULE_DEVICE_TABLE(of, ad7405_of_match);
+
+static struct platform_driver ad7405_driver = {
+	.driver = {
+		.name = "ad7405",
+		.owner = THIS_MODULE,
+		.of_match_table = ad7405_of_match,
+	},
+	.probe = ad7405_probe,
+};
+
+module_platform_driver(ad7405_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7405 driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.34.1


