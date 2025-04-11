Return-Path: <linux-iio+bounces-17942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4489A85D7A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DF24C5599
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F92367B3;
	Fri, 11 Apr 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UKlgBY0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC37221FAB;
	Fri, 11 Apr 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375021; cv=none; b=CP6tGhcedWRUDqRn+r48UGCna0lLsFw/nj9MiImhw3hN38LMODAgtwzlYfE2JeDjp0wl+EK0k4eijgQ31yf5PmLWjX5Qx2GD8epZUDCD3wAUUVUpH2vPUVFdKA7iOWrV4FBM1WjiI3bJcGIq2sONEioZNJSsxjPxcnamZDAc9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375021; c=relaxed/simple;
	bh=kU0AR27GQD1vZPJJ+9z2/9Wdbuu3FNdPRizD9S9aPTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7t1Nu7pfBo+PCelNFqlrtW95RFkMjNG/vx1Xdygn+TLiaA6b1rnZWtQFp6/nh+5iAblHWpVK6drjPJ/Pm/zkrxfN8KmBK3YxP0lm6/Ue46EUOb5sYJ1OvuAoVzL69y3j9hn+CSK6UqX1q/Oylz+lHM0uvyNxiR7tP5/IsuLICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UKlgBY0u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9sxYv001960;
	Fri, 11 Apr 2025 08:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4LvTr
	2cXcbzOEZn6aaihG96WcetYN1VrNFXraYhuvXo=; b=UKlgBY0u8x6QuWnX/hd+y
	XYKUX8nfqJ93Ih1pUgeGdi+xUw58tK/OWxFXwN7Ff3D6ljVvoB0EIXlpMGXOm6QN
	L+8avDMaC/mIafFFw8U7hMvn+SWXbDWSKBWf1kO2armAhdT/TCd03nyaF0js4qS4
	0V+YNyJTAgs16JS8Drie0Ttc/igYeuBmMX6KgLk4M0CsptwRxEFMUkj7pKhbLfWO
	sBCdG4X+eYOWNcn9ftk6F2G+q+8SvF/368xqB0wNkmpzMAapBI7ozTWN9pEhICfe
	B25QvI8YsVfHmEcW0mP2ySepd04wv3QuMUS7W9nQqClyNHNC+uMobuVztIrayxIm
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp0bsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BCas44001297
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 08:36:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:54 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPX006015;
	Fri, 11 Apr 2025 08:36:48 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Date: Fri, 11 Apr 2025 15:36:27 +0300
Message-ID: <20250411123627.6114-14-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 0Mcssml94OgsFIUWvdB3OlAPExOlZ_It
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f90ce7 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=XWQM0tir05fXBLfBid0A:9
X-Proofpoint-GUID: 0Mcssml94OgsFIUWvdB3OlAPExOlZ_It
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add support for AD4080 high-speed, low noise, low distortion,
20-bit, Easy Drive, successive approximation register (SAR)
analog-to-digital converter (ADC).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - set num_lanes during probe.
 - rename bitslitp to iio_backend_data_alignment_enable
 - do ad4080_lvds_sync_write only once during probe.
 - use ETIMEDOUT
 - rename to `cnv` instead of `adc-clk`
 - update Kconfig help section
 - drop extra blank line.
 - replace `/**` with `/*` for comments
 - drop redundant return 0.
 - use `dev_dbg` during while(--timeout) procedure
 - use while (--timeout && !sync_en)
 - return -ETIME where applicable and check missing return codes.
 - regmap_update_bits used where applicable
 - use defines instead of GENMASK inline.
 - return FIELD_GET()
 - st->filter_enabled = mode and dropping the if else statement.
 - remove redundant brackets.
 - use OVERSAMPLING_RATIO attribute and drop custom ABI for it
 - use already existing filter_type attribute
 - fix indentation
 - remove comma on 'terminators'
 - use dev_err_probe instead of dev_err
 - check missing return values.
 - rework num_lanes property parse.
 - keep ad4080_chip_info since the driver will be extended for more parts
   in the future (also stated in cover letter).
 drivers/iio/adc/Kconfig  |  14 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4080.c | 653 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 668 insertions(+)
 create mode 100644 drivers/iio/adc/ad4080.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 27413516216c..17df328f5322 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -47,6 +47,20 @@ config AD4030
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4030.
 
+config AD4080
+	tristate "Analog Devices AD4080 high speed ADC"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD4080
+	  high speed, low noise, low distortion, 20-bit, Easy Drive,
+	  successive approximation register (SAR) analog-to-digital
+	  converter (ADC). Supports iio_backended devices for AD4080.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4080.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9f26d5eca822..e6efed5b4e7a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
+obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
new file mode 100644
index 000000000000..3a0b1ad13765
--- /dev/null
+++ b/drivers/iio/adc/ad4080.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD4080 SPI ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+
+#include <linux/clk.h>
+
+/* Register Definition */
+#define AD4080_REG_INTERFACE_CONFIG_A		0x00
+#define AD4080_REG_INTERFACE_CONFIG_B		0x01
+#define AD4080_REG_DEVICE_CONFIG		0x02
+#define AD4080_REG_CHIP_TYPE			0x03
+#define AD4080_REG_PRODUCT_ID_L			0x04
+#define AD4080_REG_PRODUCT_ID_H			0x05
+#define AD4080_REG_CHIP_GRADE			0x06
+#define AD4080_REG_SCRATCH_PAD			0x0A
+#define AD4080_REG_SPI_REVISION			0x0B
+#define AD4080_REG_VENDOR_L			0x0C
+#define AD4080_REG_VENDOR_H			0x0D
+#define AD4080_REG_STREAM_MODE			0x0E
+#define AD4080_REG_TRANSFER_CONFIG		0x0F
+#define AD4080_REG_INTERFACE_CONFIG_C		0x10
+#define AD4080_REG_INTERFACE_STATUS_A		0x11
+#define AD4080_REG_DEVICE_STATUS		0x14
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_A	0x15
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_B	0x16
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_C	0x17
+#define AD4080_REG_PWR_CTRL			0x18
+#define AD4080_REG_GPIO_CONFIG_A		0x19
+#define AD4080_REG_GPIO_CONFIG_B		0x1A
+#define AD4080_REG_GPIO_CONFIG_C		0x1B
+#define AD4080_REG_GENERAL_CONFIG		0x1C
+#define AD4080_REG_FIFO_WATERMARK_LSB		0x1D
+#define AD4080_REG_FIFO_WATERMARK_MSB		0x1E
+#define AD4080_REG_EVENT_HYSTERESIS_LSB		0x1F
+#define AD4080_REG_EVENT_HYSTERESIS_MSB		0x20
+#define AD4080_REG_EVENT_DETECTION_HI_LSB	0x21
+#define AD4080_REG_EVENT_DETECTION_HI_MSB	0x22
+#define AD4080_REG_EVENT_DETECTION_LO_LSB	0x23
+#define AD4080_REG_EVENT_DETECTION_LO_MSB	0x24
+#define AD4080_REG_OFFSET_LSB			0x25
+#define AD4080_REG_OFFSET_MSB			0x26
+#define AD4080_REG_GAIN_LSB			0x27
+#define AD4080_REG_GAIN_MSB			0x28
+#define AD4080_REG_FILTER_CONFIG		0x29
+
+/* AD4080_REG_INTERFACE_CONFIG_A Bit Definition */
+#define AD4080_SW_RESET_MSK			(BIT(7) | BIT(0))
+#define AD4080_ADDR_ASC_MSK			BIT(5)
+#define AD4080_SDO_ENABLE_MSK			BIT(4)
+
+/* AD4080_REG_INTERFACE_CONFIG_B Bit Definition */
+#define AD4080_SINGLE_INST_MSK			BIT(7)
+#define AD4080_SHORT_INST_MSK			BIT(3)
+
+/* AD4080_REG_DEVICE_CONFIG Bit Definition */
+#define AD4080_OPERATING_MODES_MSK		GENMASK(1, 0)
+
+/* AD4080_REG_TRANSFER_CONFIG Bit Definition */
+#define AD4080_KEEP_STREAM_LENGTH_VAL_MSK	BIT(2)
+
+/* AD4080_REG_INTERFACE_CONFIG_C Bit Definition */
+#define AD4080_STRICT_REG_ACCESS_MSK		BIT(5)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_A Bit Definition */
+#define AD4080_RESERVED_CONFIG_A_MSK		BIT(6)
+#define AD4080_INTF_CHK_EN_MSK			BIT(4)
+#define AD4080_SPI_LVDS_LANES_MSK		BIT(2)
+#define AD4080_DATA_INTF_MODE_MSK		BIT(0)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_B Bit Definition */
+#define AD4080_LVDS_CNV_CLK_CNT_MSK		GENMASK(7, 4)
+#define AD4080_LVDS_SELF_CLK_MODE_MSK		BIT(3)
+#define AD4080_LVDS_CNV_EN_MSK			BIT(0)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_C Bit Definition */
+#define AD4080_LVDS_VOD_MSK			GENMASK(6, 4)
+
+/* AD4080_REG_PWR_CTRL Bit Definition */
+#define AD4080_ANA_DIG_LDO_PD_MSK		BIT(1)
+#define AD4080_INTF_LDO_PD_MSK			BIT(0)
+
+/* AD4080_REG_GPIO_CONFIG_A Bit Definition */
+#define AD4080_GPO_1_EN				BIT(1)
+#define AD4080_GPO_0_EN				BIT(0)
+
+/* AD4080_REG_GPIO_CONFIG_B Bit Definition */
+#define AD4080_GPIO_1_SEL			GENMASK(7, 4)
+#define AD4080_GPIO_0_SEL			GENMASK(3, 0)
+
+/* AD4080_REG_FIFO_CONFIG Bit Definition */
+#define AD4080_FIFO_MODE_MSK			GENMASK(1, 0)
+
+/* AD4080_REG_FILTER_CONFIG Bit Definition */
+#define AD4080_SINC_DEC_RATE_MSK		GENMASK(6, 3)
+#define AD4080_FILTER_SEL_MSK			GENMASK(1, 0)
+
+/* Miscellaneous Definitions */
+#define AD4080_SW_RESET				(BIT(7) | BIT(0))
+#define AD4080_SPI_READ				BIT(7)
+#define BYTE_ADDR_H				GENMASK(15, 8)
+#define BYTE_ADDR_L				GENMASK(7, 0)
+#define AD4080_CHIP_ID				GENMASK(2, 0)
+
+#define AD4080_MAX_SAMP_FREQ			40000000
+#define AD4080_MIN_SAMP_FREQ			1250000
+
+#define AXI_AD4080_ENABLE_FILTER_BIT		BIT(0)
+#define AXI_AD4080_SELF_SYNC_BIT		BIT(1)
+
+enum ad4080_filter_type {
+	FILTER_DISABLE,
+	SINC_1,
+	SINC_5,
+	SINC_5_COMP
+};
+
+static const unsigned int ad4080_scale_table[][2] = {
+	{6000, 0},
+};
+
+static const char *const ad4080_filter_type_iio_enum[] = {
+	[FILTER_DISABLE]   = "disabled",
+	[SINC_1]           = "sinc1",
+	[SINC_5]           = "sinc5",
+	[SINC_5_COMP]      = "sinc5_plus_compensation",
+};
+
+static const int ad4080_dec_rate_iio_enum[] = {
+	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
+};
+
+static const char * const ad4080_power_supplies[] = {
+	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
+};
+
+struct ad4080_chip_info {
+	const char *name;
+	unsigned int product_id;
+	int num_scales;
+	const unsigned int (*scale_table)[2];
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+struct ad4080_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct clk			*clk;
+	struct iio_backend		*back;
+	const struct ad4080_chip_info	*info;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive regmap operations.
+	 */
+	struct mutex			lock;
+	unsigned int			num_lanes;
+	unsigned int			dec_rate;
+	enum ad4080_filter_type		filter_type;
+	bool				filter_en;
+	bool				lvds_cnv_en;
+};
+
+static const struct regmap_config ad4080_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = 0x29,
+};
+
+static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
+{
+	unsigned int tmp;
+
+	tmp = (st->info->scale_table[0][0] * 1000000ULL) >>
+		    st->info->channels[0].scan_type.realbits;
+	*val = tmp / 1000000;
+	*val2 = tmp % 1000000;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	if (ret)
+		return ret;
+
+	return (1 << (FIELD_GET(AD4080_SINC_DEC_RATE_MSK, data) + 1));
+}
+
+static int ad4080_set_dec_rate(struct iio_dev *dev,
+			       const struct iio_chan_spec *chan,
+			       unsigned int mode)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	int ret;
+	unsigned int data;
+	unsigned int reg_val;
+
+	if (st->filter_type >= SINC_5 && mode >= 512)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);
+	if (ret)
+		return ret;
+
+	data = ((ilog2(mode) - 1) << 3) | (reg_val & AD4080_FILTER_SEL_MSK);
+	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
+	if (ret)
+		return ret;
+
+	st->dec_rate = mode;
+
+	return ret;
+}
+
+static int ad4080_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long m)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	int dec_rate;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad4080_get_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (st->filter_type == SINC_5_COMP)
+			dec_rate = st->dec_rate * 2;
+		else
+			dec_rate = st->dec_rate;
+		if (st->filter_en)
+			*val = DIV_ROUND_CLOSEST(clk_get_rate(st->clk), dec_rate);
+		else
+			*val = clk_get_rate(st->clk);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = ad4080_get_dec_rate(indio_dev, chan);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4080_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return -EINVAL;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4080_set_dec_rate(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4080_lvds_sync_write(struct ad4080_state *st)
+{
+	unsigned int timeout = 100;
+	bool sync_en;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	if (st->num_lanes == 1)
+		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+				   AD4080_RESERVED_CONFIG_A_MSK |
+				   AD4080_INTF_CHK_EN_MSK);
+	else
+		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+				   AD4080_RESERVED_CONFIG_A_MSK |
+				   AD4080_INTF_CHK_EN_MSK |
+				   AD4080_SPI_LVDS_LANES_MSK);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_data_alignment_enable(st->back);
+	if (ret)
+		return ret;
+
+	do {
+		ret = iio_backend_sync_status_get(st->back, &sync_en);
+		if (ret)
+			return ret;
+
+		if (!sync_en)
+			dev_dbg(&st->spi->dev, "Not Locked: Running Bit Slip\n");
+	} while (--timeout && !sync_en);
+
+	if (timeout) {
+		dev_info(&st->spi->dev, "Success: Pattern correct and Locked!\n");
+		if (st->num_lanes == 1)
+			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+					    AD4080_RESERVED_CONFIG_A_MSK);
+		else
+			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+					    AD4080_RESERVED_CONFIG_A_MSK |
+					    AD4080_SPI_LVDS_LANES_MSK);
+	} else {
+		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
+		if (st->num_lanes == 1) {
+			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+					   AD4080_RESERVED_CONFIG_A_MSK);
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+					   AD4080_RESERVED_CONFIG_A_MSK |
+					   AD4080_SPI_LVDS_LANES_MSK);
+			if (ret)
+				return ret;
+		}
+
+		return -ETIMEDOUT;
+	}
+}
+
+static ssize_t ad4080_get_filter_type(struct iio_dev *dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD4080_FILTER_SEL_MSK, data);
+}
+
+static int ad4080_set_filter_type(struct iio_dev *dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int mode)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	int ret;
+	unsigned int data;
+	unsigned int reg_val;
+
+	if (mode >= SINC_5 && st->dec_rate >= 512)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	if (mode)
+		ret = iio_backend_filter_enable(st->back);
+	else
+		ret = iio_backend_filter_disable(st->back);
+	if (ret)
+		return ret;
+
+	st->filter_en = mode;
+
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);
+	if (ret)
+		return ret;
+
+	data = (reg_val & AD4080_SINC_DEC_RATE_MSK) |
+	       (mode & AD4080_FILTER_SEL_MSK);
+
+	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
+	if (ret)
+		return ret;
+
+	st->filter_type = mode;
+
+	return ret;
+}
+
+static int ad4080_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4080_dec_rate_iio_enum;
+		*length = ARRAY_SIZE(ad4080_dec_rate_iio_enum);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad4080_iio_info = {
+	.debugfs_reg_access = ad4080_reg_access,
+	.read_raw = ad4080_read_raw,
+	.write_raw = ad4080_write_raw,
+	.read_avail = ad4080_read_avail,
+};
+
+static const struct iio_enum ad4080_filter_type_enum = {
+	.items = ad4080_filter_type_iio_enum,
+	.num_items = ARRAY_SIZE(ad4080_filter_type_iio_enum),
+	.set = ad4080_set_filter_type,
+	.get = ad4080_get_filter_type,
+};
+
+static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
+	IIO_ENUM("filter_type",
+		 IIO_SHARED_BY_ALL,
+		 &ad4080_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type",
+			   IIO_SHARED_BY_ALL,
+			   &ad4080_filter_type_enum),
+	{}
+};
+
+#define AD4080_CHAN(_chan, _si, _bits, _sign, _shift)		\
+	{ .type = IIO_VOLTAGE,						\
+	  .indexed = 1,							\
+	  .channel = _chan,						\
+	  .info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),		\
+	  .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	  .info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	  .ext_info = ad4080_ext_info,					\
+	  .scan_index = _si,						\
+	  .scan_type = {						\
+			.sign = _sign,					\
+			.realbits = _bits,				\
+			.storagebits = 32,				\
+			.shift = _shift,				\
+	  },								\
+	}
+
+static const struct iio_chan_spec ad4080_channels[] = {
+	AD4080_CHAN(0, 0, 20, 's', 0)
+};
+
+static const struct ad4080_chip_info ad4080_chip_info = {
+	.name = "AD4080",
+	.product_id = AD4080_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = ad4080_channels,
+};
+
+static int ad4080_setup(struct iio_dev *indio_dev)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int id;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+			   AD4080_SW_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+			   AD4080_SDO_ENABLE_MSK);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	if (ret)
+		return ret;
+
+	if (id != AD4080_CHIP_ID)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+				     "Unrecognized CHIP_ID 0x%X\n", id);
+
+	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
+			      AD4080_GPO_1_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
+			   FIELD_PREP(AD4080_GPIO_1_SEL, 3));
+	if (ret)
+		return ret;
+
+	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_self_sync_enable(st->back);
+	if (ret)
+		return ret;
+
+	if (st->lvds_cnv_en) {
+		if (st->num_lanes) {
+			ret = regmap_update_bits(st->regmap,
+						 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
+						 AD4080_LVDS_CNV_CLK_CNT_MSK,
+						 FIELD_PREP(AD4080_LVDS_CNV_CLK_CNT_MSK, 7));
+			if (ret)
+				return ret;
+		}
+
+		ret = regmap_set_bits(st->regmap,
+				      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
+				      AD4080_LVDS_CNV_EN_MSK);
+		if (ret)
+			return ret;
+
+		return ad4080_lvds_sync_write(st);
+	}
+
+	return 0;
+}
+
+static void ad4080_properties_parse(struct ad4080_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	st->lvds_cnv_en = device_property_read_bool(&st->spi->dev,
+						    "adi,lvds-cnv-enable");
+
+	st->num_lanes = 1;
+	ret = device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val);
+	if (!ret)
+		st->num_lanes = val;
+}
+
+static int ad4080_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct device *dev = &spi->dev;
+	struct ad4080_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad4080_power_supplies),
+					     ad4080_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies\n");
+
+	st->regmap = devm_regmap_init_spi(spi, &ad4080_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad4080_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ad4080_properties_parse(st);
+
+	st->clk = devm_clk_get_enabled(&spi->dev, "cnv");
+	if (IS_ERR(st->clk))
+		return PTR_ERR(st->clk);
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	ret = ad4080_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad4080_id[] = {
+	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4080_id);
+
+static const struct of_device_id ad4080_of_match[] = {
+	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4080_of_match);
+
+static struct spi_driver ad4080_driver = {
+	.driver = {
+		.name = "ad4080",
+		.of_match_table = ad4080_of_match,
+	},
+	.probe = ad4080_probe,
+	.id_table = ad4080_id,
+};
+module_spi_driver(ad4080_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices AD4080");
+MODULE_LICENSE("GPL");
-- 
2.49.0


