Return-Path: <linux-iio+bounces-27221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B0ECD0896
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E503107A17
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6BC33D4F1;
	Fri, 19 Dec 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0afRbzzb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98A33C199;
	Fri, 19 Dec 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158317; cv=none; b=tnrhKBLzEsvm7z/ORMYKERfgsj+BGx2eGYh1q5kOZ0aN9Fuxoz7wC4wRSvniLsgs/RLf+vKJ63kfa9P7X179w38372xu27LqbiV5B+cnkOHBN6ijhuHcjSiiGhkyxqi0luriQlcPoj2od7sav8vKH7E8IK02AiKek6DgEb1I80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158317; c=relaxed/simple;
	bh=HLfmjfSksFXOiFK7tzDolD0RnFJGx+FPYSQzaKAdP6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hXTDqoNGklrh7+OrQH8aj247BpjKQwBXzOqbshfmzClAUe+OoOvp8FLaoGYAz3fwPFez9KZ22MWjz2DiDWeKFRKEZ5voTvhKV7fE0c0wUVT5AXfGTBvKgmMrG7omPXYhawI6zC3QpmZSWh0lfcNwNFQ+qyzzvHjLufevP6bvEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0afRbzzb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJFJbfR2393780;
	Fri, 19 Dec 2025 10:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SY7Pc
	Co6IOBy7BOsPzc2/39lmPEabkDovevpwISlQqE=; b=0afRbzzbjv/WAyMlMQk8Z
	cZZcykg8qG0OwnU2G27a34z/xeOEoDnDrRGkeJg6zWfEN7GJLPO30AbxyajZkY4z
	ueJrXvpWBuV3XcSmV8wq8dyLKQWjlFpo7VW7mVkwemiYMDxOJ2RyqzlFhZB0ElZV
	+/DT34/BSx/1PV/vs3EQvIMTZko4YNaFqzEbDUOkGKw+Efc09X4f/6couGdl/19D
	8RUUUGeTDYtJ8W1niR21o9K5ieSXnKPfypAVQgrejqGrkNWoCbDGE/WY7V9W5ReL
	4CZu/a5AEbmyaMV5xHKUUEp7i7zImcCYJS9u+FtVqwdJKsBIhyQ5w8DGVceb2h2u
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b4r3v4nkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 10:31:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BJFVagQ051288
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Dec 2025 10:31:36 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 19 Dec 2025 10:31:35 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BJFVIW5004160;
	Fri, 19 Dec 2025 10:31:29 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 19 Dec 2025 16:31:17 +0100
Subject: [PATCH 3/3] iio: dac: Add MAX22007 DAC driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251219-max22007-dev-v1-3-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
In-Reply-To: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158278; l=16256;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=HLfmjfSksFXOiFK7tzDolD0RnFJGx+FPYSQzaKAdP6s=;
 b=+87hU/725Y8pc9D3uC/IXZDFI6uVr6+8girsGFc39zZ/EC0zZMBtXKHl/lOXCOBWcMfRFUsGb
 0GV/XnoAJwQAXLC9zZDTOdpYJb3zbIVNUajew2VRK0BMON+GKO+6Ex5
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=LtafC3dc c=1 sm=1 tr=0 ts=69456fd9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=m_tgWmm3jMfkRiQ7QVwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MDOk6NDtStZfSYMabAWBtLAfaZ0g4PmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMCBTYWx0ZWRfX25KK95HYcaON
 9j/qc5R0wBU3MIu4JofvE17IlmOLf9IgxCcooXZIir5V098Xumit6yqJHbH/IPUuFT0SKh+JK1I
 zS38N9gsS91YGRpRRXc3SWpAQWfOxCBcjxx94kQuPzEXd2WqOgrW3cWIzVsijTX4YBDmJf+CpZG
 t/qVo35Ob7bH3FCVCz0X68gM/MkNFpMM4851Gbn+90HWDz3ht9miAMIDPM0lKxLZ1HCHnYJXsbs
 vmLO9zVgF33bvRon0jhX1gLJmqqdjKMjjNLIunqel99/mW8BzAySSxa0DFxPz13jJKoQdqt0w3S
 j0OlFaMvgBJ45hk1ipRUgQUauuFBjzQegU3WbwV7feQW1HA/nFfcHnEiOK+1mep/TxoPvLFN4gW
 5keq9Xm1sbQxDpjwEr+62d37sWeheFbOvgyPiV1/CGTVFtf/HlNoXaKBeJ8bKqfzzG8JMQext16
 aDYQGLRlFSS/DB6dOLw==
X-Proofpoint-GUID: MDOk6NDtStZfSYMabAWBtLAfaZ0g4PmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190130

Add support for the MAX22007 4 channel DAC
that drives a voltage or current output on each channel.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/dac/Kconfig    |  13 ++
 drivers/iio/dac/Makefile   |   1 +
 drivers/iio/dac/max22007.c | 487 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 502 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6561455732c9..7efd5cf98023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1600,6 +1600,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
 F:	Documentation/iio/max22007.rst
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
index 000000000000..0d57fee27367
--- /dev/null
+++ b/drivers/iio/dac/max22007.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max22007.c - MAX22007 DAC driver
+ *
+ * Driver for Analog Devices MAX22007 Digital to Analog Converter.
+ *
+ * Copyright (c) 2025 Analog Devices Inc.
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
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
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
+#define     MAX22007_CH_MODE_CH_MASK(channel)		BIT(12 + (channel))
+#define     MAX22007_CH_PWR_CH_MASK(channel)		BIT(8 + (channel))
+#define     MAX22007_DAC_LATCH_MODE_MASK(channel)	BIT(12 + (channel))
+#define     MAX22007_LDAC_UPDATE_MASK(channel)		BIT(12 + (channel))
+#define     MAX22007_SW_RST_MASK			BIT(8)
+#define     MAX22007_SW_CLR_MASK			BIT(12)
+#define     MAX22007_SOFT_RESET_BITS_MASK		(MAX22007_SW_RST_MASK | \
+	    MAX22007_SW_CLR_MASK)
+#define     MAX22007_DAC_DATA_MASK			GENMASK(15, 4)
+#define     MAX22007_DAC_MAX_RAW			GENMASK(11, 0)
+#define     MAX22007_CRC8_POLYNOMIAL			0x8C
+#define     MAX22007_CRC_EN_MASK			BIT(0)
+#define     MAX22007_RW_MASK				BIT(0)
+#define     MAX22007_CRC_OVERHEAD			1
+
+/* Field value preparation macros with masking */
+#define     MAX22007_CH_PWR_VAL(channel, val)	(((val) & 0x1) << (8 + (channel)))
+#define     MAX22007_CH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
+#define     MAX22007_DAC_LATCH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
+
+static u8 max22007_crc8_table[256];
+
+enum max22007_channel_mode {
+	MAX22007_VOLTAGE_MODE,
+	MAX22007_CURRENT_MODE
+};
+
+enum max22007_channel_power {
+	MAX22007_CH_POWER_OFF,
+	MAX22007_CH_POWER_ON,
+};
+
+struct max22007_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct iio_chan_spec *iio_chan;
+	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[4];
+};
+
+static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
+			     void *val, size_t val_size)
+{
+	struct max22007_state *st = context;
+	u8 calculated_crc, received_crc;
+	u8 crc_data[3];
+	int ret;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+	};
+
+	xfer.len = reg_size + val_size + MAX22007_CRC_OVERHEAD;
+
+	memcpy(st->tx_buf, reg, reg_size);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret) {
+		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
+		return ret;
+	}
+
+	crc_data[0] = st->tx_buf[0];
+	crc_data[1] = st->rx_buf[1];
+	crc_data[2] = st->rx_buf[2];
+
+	calculated_crc = crc8(max22007_crc8_table, crc_data, 3, 0x00);
+	received_crc = st->rx_buf[3];
+
+	if (calculated_crc != received_crc) {
+		dev_err(&st->spi->dev, "CRC mismatch on read register %02x:\n", *(u8 *)reg);
+		return -EIO;
+	}
+
+	/* Ignore the dummy byte 0 */
+	memcpy(val, &st->rx_buf[1], val_size);
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
+static int max22007_write_channel_data(struct max22007_state *state, unsigned int channel,
+				       unsigned int data)
+{
+	unsigned int reg_val;
+
+	if (data > MAX22007_DAC_MAX_RAW)
+		return -EINVAL;
+
+	reg_val = FIELD_PREP(MAX22007_DAC_DATA_MASK, data);
+
+	return regmap_write(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), reg_val);
+}
+
+static int max22007_read_channel_data(struct max22007_state *state, unsigned int channel,
+				      int *data)
+{
+	int ret;
+	unsigned int reg_val;
+
+	ret = regmap_read(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
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
+		if (chan->type == IIO_VOLTAGE) {
+			*val = 5 * 2500;  /* 5 * Vref(2.5V) in mV */
+			*val2 = 12;  /* 12-bit DAC resolution (2^12) */
+		} else {
+			*val = 25;  /* Vref / (2 * Rsense) = 2500mV / 100 */
+			*val2 = 12;  /* 12-bit DAC resolution (2^12) */
+		}
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
+	powerdown = !(reg_val & MAX22007_CH_PWR_CH_MASK(chan->channel));
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
+	if (powerdown)
+		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
+					 MAX22007_CH_PWR_CH_MASK(chan->channel),
+					 MAX22007_CH_PWR_VAL(chan->channel, MAX22007_CH_POWER_OFF));
+	else
+		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
+					 MAX22007_CH_PWR_CH_MASK(chan->channel),
+					 MAX22007_CH_PWR_VAL(chan->channel, MAX22007_CH_POWER_ON));
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
+	{ },
+};
+
+static const struct iio_chan_spec max22007_channel_template = {
+	.output = 1,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = max22007_ext_info,
+};
+
+static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
+{
+	struct device *dev = &st->spi->dev;
+	struct iio_chan_spec *iio_chan;
+	int ret, num_chan = 0, i = 0;
+	u32 reg;
+
+	num_chan = device_get_child_node_count(dev);
+	if (!num_chan)
+		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
+
+	st->iio_chan = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chan), GFP_KERNEL);
+	if (!st->iio_chan)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		const char *channel_type_str;
+		enum max22007_channel_mode mode;
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
+		iio_chan = &st->iio_chan[i];
+
+		*iio_chan = max22007_channel_template;
+		iio_chan->channel = reg;
+
+		ret = fwnode_property_read_string(child, "adi,type", &channel_type_str);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing adi,type property for %pfwP\n", child);
+
+		if (strcmp(channel_type_str, "current") == 0) {
+			mode = MAX22007_CURRENT_MODE;
+			iio_chan->type = IIO_CURRENT;
+		} else if (strcmp(channel_type_str, "voltage") == 0) {
+			mode = MAX22007_VOLTAGE_MODE;
+			iio_chan->type = IIO_VOLTAGE;
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid adi,type '%s' for %pfwP\n",
+					     channel_type_str, child);
+		}
+
+		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
+					 MAX22007_CH_MODE_CH_MASK(reg),
+					 MAX22007_CH_MODE_VAL(reg, mode));
+		if (ret)
+			return ret;
+
+		/* Set DAC to transparent mode (immediate update) */
+		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
+					 MAX22007_DAC_LATCH_MODE_MASK(reg),
+					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
+		if (ret)
+			return ret;
+
+		i++;
+	}
+
+	*num_channels = num_chan;
+
+	return 0;
+}
+
+static int max22007_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max22007_state *state;
+	struct gpio_desc *reset_gpio;
+	u8 num_channels;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	state->spi = spi;
+
+	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
+
+	state->regmap = devm_regmap_init(&spi->dev, &max22007_regmap_bus, state,
+					 &max22007_regmap_config);
+	if (IS_ERR(state->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
+				     "Failed to initialize regmap\n");
+
+	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		ret = regmap_write(state->regmap, MAX22007_SOFT_RESET_REG,
+				   MAX22007_SOFT_RESET_BITS_MASK);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(state->regmap, MAX22007_CONFIG_REG,
+				 MAX22007_CRC_EN_MASK,
+				 MAX22007_CRC_EN_MASK);
+	if (ret)
+		return ret;
+
+	ret = max22007_parse_channel_cfg(state, &num_channels);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &max22007_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = state->iio_chan;
+	indio_dev->num_channels = num_channels;
+	indio_dev->name = "max22007";
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
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


