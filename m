Return-Path: <linux-iio+bounces-27789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58ED20270
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66A72301CA15
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E73A4AAF;
	Wed, 14 Jan 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e8iQnYGM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF013A35D1;
	Wed, 14 Jan 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407517; cv=none; b=Wdcf3Cmk3d1G23WV9+aMXembfdyE9p9r5TwKqdcTdHMbtv+h032nBZXX/xMSqcjCgCIUXBn/FkAskU6m3pNK9mUVWQ8ASM40VqZyurf0gW8xRtaB8ASm/Wk708d7WaDV+eZxNpaZ9Jhx1NplLP4EFjEkRxnF7q8yTGb1bAUWNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407517; c=relaxed/simple;
	bh=EWfJO7jFVLZ+Fcp2RSEahJgjxLAW9axaX6hsND6gi3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GY6d3avX/2V0i8vyD7NaLK7w/Fo7tsmLafDC2xY8sf7vugIdOCIRXIy53T1SHErAOGxoB+lT6sMCp7qJbXUpslNWRmxCIlagntXqms+8h0GegzpMAcLnfQgWWD48g6UBeVsR4s0xBNd7z98Iq20UiEvwJu346Tx9UYeGvCbSUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e8iQnYGM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EFtf5l3765811;
	Wed, 14 Jan 2026 11:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u+654
	13mvxBkL4qiI1vkzy9LWfIALr2m3eopt7tg93o=; b=e8iQnYGMJwwbF0wJ4cxsP
	H78NREjEkg7RhbfGgtPtX+eAFDWyKkX1vcyJKxa2PQ8yXfjEt6Pi95jZBFBZhJpd
	XZ1k2YxdveD6Jn7aSpiocQgXMdtAf5eHmEi7+3+t6IMR+h53R4nOs8dAc+a5L1zO
	869QMJUxPGS56ST9L4e05DPOP8LDFQrH90EuN9Z22o4wX71Qpi1mZEheK0+BLTUB
	oF9ARHNGbfKOCOL4iS1hA18Smdq3XGmAc3fYfvOxCdnLCKhFm9hxaLiDiD9i6W9Y
	tgcIDxnWelMm48VBjJU6y7MC+RFNUHCWmfOYrPprJ1x+1W1gGJTadDBNCpBkQPg1
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau0bkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:18:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EGIAiT028151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 11:18:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Jan
 2026 11:18:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 11:18:10 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.126])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EGHmHW028201;
	Wed, 14 Jan 2026 11:18:02 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 14 Jan 2026 17:17:02 +0100
Subject: [PATCH v3 2/2] iio: dac: Add MAX22007 DAC driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260114-max22007-patch-v3-2-769298f50b8a@analog.com>
References: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
In-Reply-To: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, <gastmaier@gmail.com>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768407468; l=16118;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=EWfJO7jFVLZ+Fcp2RSEahJgjxLAW9axaX6hsND6gi3w=;
 b=85GUX6hq3Cf+Q8tte/bonsnLO3gFXndv01LZ3GvZSTVUULMSxKCltb683XRwBRQi7Ildm990A
 Bqu1jpSLeoeAoSAtjuO2eR9F93Yvsffig0wBEe8MBB20TODWlwvtoPd
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzNCBTYWx0ZWRfX50orxXGmEbG6
 lgPw08H1yJ5cUxCj2TNBWZ98dsP/ur6e+mxAOEhbmbO9LK9qZ//2jzzaCeTnwVamE+x28D4iLlV
 CTE3KpMm6ue+WsrRdIFxOawi0xb/X+FTmvIDLTW8RF6CHw1Pr1vIW+qQ2qQXA3vfHqmOyquQCGD
 VV3/QlD3nrqn8dqWC8T4TXPCNsjBhDycNjyWYEhf9SAnBUnCdVQc6ocJfELjmHFFF6uwld7kQC0
 xQ4DuiLrJ7H8W5j/op8zxp9dZp8g0wwRNSIMgBZ0NaFjq1e/bOSw1/HYr4j/pxzwT8uE/UYOa69
 /h6YN7abiuf7P8EOEOM1p30v9KY5FrS2vERy1esQJLJX3fUYMdZ9X5XeGn7SR6co1Vd9tToT6Bs
 Z27+tAfKeXIjI5P7LX5O/M/R/VR5Gz1qs8Xgry9gVXD3a6U6bgT0bBdYf4tUFp0st7kUc4h14gm
 dllTGUTdk+xjaZUOpzA==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967c1c7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=FkLXPJOX-0igJ3_mPEIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: psVLbB2LuzGrYustU4DA9A0sSe56t4qW
X-Proofpoint-GUID: psVLbB2LuzGrYustU4DA9A0sSe56t4qW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140134

Add support for the MAX22007 4 channel DAC
that drives a voltage or current output on each channel.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/dac/Kconfig    |  13 ++
 drivers/iio/dac/Makefile   |   1 +
 drivers/iio/dac/max22007.c | 488 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 503 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c378d4b8f5ae..eb234ed3e897 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,6 +1608,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
+F:	drivers/iio/dac/max22007.c
 
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7cd3caec1262..4a31993f5b14 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -482,6 +482,19 @@ config MAX517
 	  This driver can also be built as a module.  If so, the module
 	  will be called max517.
 
+config MAX22007
+	tristate "Analog Devices MAX22007 DAC Driver"
+	depends on SPI
+	select REGMAP_SPI
+	select CRC8
+	help
+	  Say Y here if you want to build a driver for Analog Devices MAX22007.
+
+	  MAX22007 is a quad-channel, 12-bit, voltage-output digital to
+	  analog converter (DAC) with SPI interface.
+
+	  If compiled as a module, it will be called max22007.
+
 config MAX5522
 	tristate "Maxim MAX5522 DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index e6ac4c67e337..0bbc6d09d22c 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_LTC2664) += ltc2664.o
 obj-$(CONFIG_LTC2688) += ltc2688.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
+obj-$(CONFIG_MAX22007) += max22007.o
 obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
new file mode 100644
index 000000000000..e95036a10991
--- /dev/null
+++ b/drivers/iio/dac/max22007.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max22007.c - MAX22007 DAC driver
+ *
+ * Driver for Analog Devices MAX22007 Digital to Analog Converter.
+ *
+ * Copyright (c) 2026 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/crc8.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+#define MAX22007_NUM_CHANNELS				4
+#define MAX22007_REV_ID_REG				0x00
+#define MAX22007_STAT_INTR_REG				0x01
+#define MAX22007_INTERRUPT_EN_REG			0x02
+#define MAX22007_CONFIG_REG				0x03
+#define MAX22007_CONTROL_REG				0x04
+#define MAX22007_CHANNEL_MODE_REG			0x05
+#define MAX22007_SOFT_RESET_REG				0x06
+#define MAX22007_DAC_CHANNEL_REG(ch)			(0x07 + (ch))
+#define MAX22007_GPIO_CTRL_REG				0x0B
+#define MAX22007_GPIO_DATA_REG				0x0C
+#define MAX22007_GPI_EDGE_INT_CTRL_REG			0x0D
+#define MAX22007_GPI_INT_STATUS_REG			0x0E
+
+/* Channel mask definitions */
+#define     MAX22007_CH_MODE_CH_MASK(ch)		BIT(12 + (ch))
+#define     MAX22007_CH_PWRON_CH_MASK(ch)		BIT(8 + (ch))
+#define     MAX22007_DAC_LATCH_MODE_MASK(ch)		BIT(12 + (ch))
+#define     MAX22007_LDAC_UPDATE_MASK(ch)		BIT(12 + (ch))
+#define     MAX22007_SW_RST_MASK			BIT(8)
+#define     MAX22007_SW_CLR_MASK			BIT(12)
+#define     MAX22007_SOFT_RESET_BITS_MASK		(MAX22007_SW_RST_MASK | \
+							 MAX22007_SW_CLR_MASK)
+#define     MAX22007_DAC_DATA_MASK			GENMASK(15, 4)
+#define     MAX22007_DAC_MAX_RAW			GENMASK(11, 0)
+#define     MAX22007_CRC8_POLYNOMIAL			0x8C
+#define     MAX22007_CRC_EN_MASK			BIT(0)
+#define     MAX22007_RW_MASK				BIT(0)
+#define     MAX22007_CRC_OVERHEAD			1
+#define     MAX22007_NUM_SUPPLIES			3
+#define     MAX22007_REF_MV				2500
+
+/* Field value preparation macros with masking */
+#define     MAX22007_CH_PWR_VAL(ch, val)		(((val) & 0x1) << (8 + (ch)))
+#define     MAX22007_CH_MODE_VAL(ch, val)		(((val) & 0x1) << (12 + (ch)))
+#define     MAX22007_DAC_LATCH_MODE_VAL(ch, val)	(((val) & 0x1) << (12 + (ch)))
+
+static u8 max22007_crc8_table[CRC8_TABLE_SIZE];
+
+static const char * const max22007_supply_names[MAX22007_NUM_SUPPLIES] = {
+	"vdd",
+	"hvdd",
+	"hvss",
+};
+
+struct max22007_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct iio_chan_spec *iio_chans;
+	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[4];
+};
+
+static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
+			     void *val, size_t val_size)
+{
+	struct max22007_state *st = context;
+	u8 calculated_crc, received_crc;
+	u8 rx_buf[4];
+	u8 reg_byte;
+	int ret;
+
+	if (reg_size != 1)
+		return -EINVAL;
+
+	if (val_size == 0 || val_size > 3)
+		return -EINVAL;
+
+	memcpy(&reg_byte, reg, 1);
+
+	ret = spi_write_then_read(st->spi, &reg_byte, 1, rx_buf,
+				  val_size + MAX22007_CRC_OVERHEAD);
+	if (ret) {
+		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
+		return ret;
+	}
+
+	calculated_crc = crc8(max22007_crc8_table, &reg_byte, 1, 0x00);
+	calculated_crc = crc8(max22007_crc8_table, rx_buf, 2, calculated_crc);
+	received_crc = rx_buf[val_size];
+
+	if (calculated_crc != received_crc) {
+		dev_err(&st->spi->dev, "CRC mismatch on read register %02x\n", reg_byte);
+		return -EIO;
+	}
+
+	memcpy(val, rx_buf, val_size);
+
+	return 0;
+}
+
+static int max22007_spi_write(void *context, const void *data, size_t count)
+{
+	struct max22007_state *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+	};
+
+	if (count + MAX22007_CRC_OVERHEAD > sizeof(st->tx_buf))
+		return -EINVAL;
+
+	memset(st->tx_buf, 0, sizeof(st->tx_buf));
+
+	xfer.len = count + MAX22007_CRC_OVERHEAD;
+
+	memcpy(st->tx_buf, data, count);
+	st->tx_buf[count] = crc8(max22007_crc8_table, st->tx_buf,
+				 sizeof(st->tx_buf) - 1, 0x00);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static bool max22007_reg_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX22007_REV_ID_REG:
+	case MAX22007_STAT_INTR_REG:
+	case MAX22007_CONFIG_REG:
+	case MAX22007_CONTROL_REG:
+	case MAX22007_CHANNEL_MODE_REG:
+	case MAX22007_SOFT_RESET_REG:
+	case MAX22007_GPIO_CTRL_REG:
+	case MAX22007_GPIO_DATA_REG:
+	case MAX22007_GPI_EDGE_INT_CTRL_REG:
+	case MAX22007_GPI_INT_STATUS_REG:
+		return true;
+	case MAX22007_DAC_CHANNEL_REG(0) ... MAX22007_DAC_CHANNEL_REG(MAX22007_NUM_CHANNELS - 1):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max22007_reg_writable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX22007_CONFIG_REG:
+	case MAX22007_CONTROL_REG:
+	case MAX22007_CHANNEL_MODE_REG:
+	case MAX22007_SOFT_RESET_REG:
+	case MAX22007_GPIO_CTRL_REG:
+	case MAX22007_GPIO_DATA_REG:
+	case MAX22007_GPI_EDGE_INT_CTRL_REG:
+		return true;
+	case MAX22007_DAC_CHANNEL_REG(0) ... MAX22007_DAC_CHANNEL_REG(MAX22007_NUM_CHANNELS - 1):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_bus max22007_regmap_bus = {
+	.read = max22007_spi_read,
+	.write = max22007_spi_write,
+	.read_flag_mask = MAX22007_RW_MASK,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static const struct regmap_config max22007_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.reg_shift = -1,
+	.readable_reg = max22007_reg_readable,
+	.writeable_reg = max22007_reg_writable,
+	.max_register = 0x0E,
+};
+
+static int max22007_write_channel_data(struct max22007_state *st,
+				       unsigned int channel, int data)
+{
+	unsigned int reg_val;
+
+	if (data < 0 || data > MAX22007_DAC_MAX_RAW)
+		return -EINVAL;
+
+	reg_val = FIELD_PREP(MAX22007_DAC_DATA_MASK, data);
+
+	return regmap_write(st->regmap, MAX22007_DAC_CHANNEL_REG(channel), reg_val);
+}
+
+static int max22007_read_channel_data(struct max22007_state *st,
+				      unsigned int channel, int *data)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
+	if (ret)
+		return ret;
+
+	*data = FIELD_GET(MAX22007_DAC_DATA_MASK, reg_val);
+
+	return 0;
+}
+
+static int max22007_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max22007_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max22007_read_channel_data(st, chan->channel, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLTAGE)
+			*val = 5 * MAX22007_REF_MV;  /* 5 * Vref in mV */
+		else
+			*val = 25;  /* Vref / (2 * Rsense) = MAX22007_REF_MV / 100 */
+		*val2 = 12;  /* 12-bit DAC resolution */
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max22007_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct max22007_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return max22007_write_channel_data(st, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max22007_info = {
+	.read_raw = max22007_read_raw,
+	.write_raw = max22007_write_raw,
+};
+
+static ssize_t max22007_read_dac_powerdown(struct iio_dev *indio_dev,
+					   uintptr_t private,
+					   const struct iio_chan_spec *chan,
+					   char *buf)
+{
+	struct max22007_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	bool powerdown;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX22007_CHANNEL_MODE_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	powerdown = !(reg_val & MAX22007_CH_PWRON_CH_MASK(chan->channel));
+
+	return sysfs_emit(buf, "%d\n", powerdown);
+}
+
+static ssize_t max22007_write_dac_powerdown(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    const struct iio_chan_spec *chan,
+					    const char *buf, size_t len)
+{
+	struct max22007_state *st = iio_priv(indio_dev);
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
+				 MAX22007_CH_PWRON_CH_MASK(chan->channel),
+				 MAX22007_CH_PWR_VAL(chan->channel, powerdown ? 0 : 1));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info max22007_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = max22007_read_dac_powerdown,
+		.write = max22007_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ }
+};
+
+static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
+{
+	struct device *dev = &st->spi->dev;
+	int ret, num_chan;
+	int i = 0;
+	u32 reg;
+
+	num_chan = device_get_child_node_count(dev);
+	if (!num_chan)
+		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
+
+	st->iio_chans = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chans), GFP_KERNEL);
+	if (!st->iio_chans)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 ch_func;
+		enum iio_chan_type chan_type;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read reg property of %pfwP\n", child);
+
+		if (reg >= MAX22007_NUM_CHANNELS)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg out of range in %pfwP\n", child);
+
+		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing adi,ch-func property for %pfwP\n", child);
+
+		switch (ch_func) {
+		case CH_FUNC_VOLTAGE_OUTPUT:
+			chan_type = IIO_VOLTAGE;
+			break;
+		case CH_FUNC_CURRENT_OUTPUT:
+			chan_type = IIO_CURRENT;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid adi,ch-func %u for %pfwP\n",
+					     ch_func, child);
+		}
+
+		st->iio_chans[i++] = (struct iio_chan_spec) {
+			.output = 1,
+			.indexed = 1,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					      BIT(IIO_CHAN_INFO_SCALE),
+			.ext_info = max22007_ext_info,
+			.channel = reg,
+			.type = chan_type,
+		};
+
+		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
+					 MAX22007_CH_MODE_CH_MASK(reg),
+					 MAX22007_CH_MODE_VAL(reg, ch_func - 1));
+		if (ret)
+			return ret;
+
+		/* Set DAC to transparent mode (immediate update) */
+		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
+					 MAX22007_DAC_LATCH_MODE_MASK(reg),
+					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
+		if (ret)
+			return ret;
+	}
+
+	*num_channels = num_chan;
+
+	return 0;
+}
+
+static int max22007_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct gpio_desc *reset_gpio;
+	struct max22007_state *st;
+	struct iio_dev *indio_dev;
+	u8 num_channels;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
+
+	st->regmap = devm_regmap_init(dev, &max22007_regmap_bus, st,
+					 &max22007_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, MAX22007_NUM_SUPPLIES,
+					     max22007_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable regulators\n");
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 5000);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		usleep_range(1000, 5000);
+	} else {
+		ret = regmap_write(st->regmap, MAX22007_SOFT_RESET_REG,
+				   MAX22007_SOFT_RESET_BITS_MASK);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_set_bits(st->regmap, MAX22007_CONFIG_REG,
+			      MAX22007_CRC_EN_MASK);
+	if (ret)
+		return ret;
+
+	ret = max22007_parse_channel_cfg(st, &num_channels);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &max22007_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->iio_chans;
+	indio_dev->num_channels = num_channels;
+	indio_dev->name = "max22007";
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id max22007_id[] = {
+	{ "max22007" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max22007_id);
+
+static const struct of_device_id max22007_of_match[] = {
+	{ .compatible = "adi,max22007" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max22007_of_match);
+
+static struct spi_driver max22007_driver = {
+	.driver = {
+		.name = "max22007",
+		.of_match_table = max22007_of_match,
+	},
+	.probe = max22007_probe,
+	.id_table = max22007_id,
+};
+module_spi_driver(max22007_driver);
+
+MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices MAX22007 DAC");
+MODULE_LICENSE("GPL");

-- 
2.43.0


