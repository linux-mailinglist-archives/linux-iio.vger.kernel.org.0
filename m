Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32631179299
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgCDOl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 09:41:27 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6744 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388109AbgCDOlY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 09:41:24 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024EeCaF007443;
        Wed, 4 Mar 2020 09:41:11 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52bhde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 09:41:11 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 024EfAE0044816
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 09:41:10 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 09:41:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 09:41:09 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 09:41:09 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 024Eew6l008599;
        Wed, 4 Mar 2020 09:41:07 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP core
Date:   Wed, 4 Mar 2020 16:43:58 +0200
Message-ID: <20200304144401.17794-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304144401.17794-1-alexandru.ardelean@analog.com>
References: <20200304144401.17794-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This change adds support for the Analog Devices Generic AXI ADC IP core.
The IP core is used for interfacing with analog-to-digital (ADC) converters
that require either a high-speed serial interface (JESD204B/C) or a source
synchronous parallel interface (LVDS/CMOS).

Usually, some other interface type (i.e SPI) is used as a control interface
for the actual ADC, while the IP core (controlled via this driver), will
interface to the data-lines of the ADC and handle  the streaming of data
into memory via DMA.

Because of this, the AXI ADC driver needs the other SPI-ADC driver to
register with it. The SPI-ADC needs to be register via the SPI framework,
while the AXI ADC registers as a platform driver. The two cannot be ordered
in a hierarchy as both drivers have their own registers, and trying to
organize this [in a hierarchy becomes] problematic when trying to map
memory/registers.

There are some modes where the AXI ADC can operate as standalone ADC, but
those will be implemented at a later point in time.

Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/Kconfig             |  20 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/adi-axi-adc.c       | 566 ++++++++++++++++++++++++++++
 include/linux/iio/adc/adi-axi-adc.h |  63 ++++
 4 files changed, 650 insertions(+)
 create mode 100644 drivers/iio/adc/adi-axi-adc.c
 create mode 100644 include/linux/iio/adc/adi-axi-adc.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f4da821c4022..445070abf376 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -246,6 +246,26 @@ config AD799X
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad799x.
 
+config ADI_AXI_ADC
+	tristate "Analog Devices Generic AXI ADC IP core driver"
+	select IIO_BUFFER
+	select IIO_BUFFER_HW_CONSUMER
+	select IIO_BUFFER_DMAENGINE
+	help
+	  Say yes here to build support for Analog Devices Generic
+	  AXI ADC IP core. The IP core is used for interfacing with
+	  analog-to-digital (ADC) converters that require either a high-speed
+	  serial interface (JESD204B/C) or a source synchronous parallel
+	  interface (LVDS/CMOS).
+	  Typically (for such devices) SPI will be used for configuration only,
+	  while this IP core handles the streaming of data into memory via DMA.
+
+	  Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adi-axi-adc.
+
 config ASPEED_ADC
 	tristate "Aspeed ADC"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 8462455b4228..7c6594d049f9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
+obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
new file mode 100644
index 000000000000..82ad179538da
--- /dev/null
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices Generic AXI ADC IP core
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+ *
+ * Copyright 2012-2020 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
+
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/iio/adc/adi-axi-adc.h>
+
+/**
+ * Register definitions:
+ *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
+ */
+
+#define AXI_ADC_UPPER16_MSK		GENMASK(31, 16)
+#define AXI_ADC_UPPER16_SET(x)		FIELD_PREP(AXI_ADC_UPPER16_MSK, x)
+#define AXI_ADC_UPPER16_GET(x)		FIELD_GET(AXI_ADC_UPPER16_MSK, x)
+
+#define AXI_ADC_LOWER16_MSK		GENMASK(15, 0)
+#define AXI_ADC_LOWER16_SET(x)		FIELD_PREP(AXI_ADC_UPPER16_MSK, x)
+#define AXI_ADC_LOWER16_GET(x)		FIELD_GET(AXI_ADC_LOWER16_MSK, x)
+
+/* ADC controls */
+
+#define AXI_ADC_REG_RSTN			0x0040
+#define   AXI_ADC_MMCM_RSTN			BIT(1)
+#define   AXI_ADC_RSTN				BIT(0)
+
+#define AXI_ADC_REG_CNTRL			0x0044
+#define   AXI_ADC_R1_MODE			BIT(2)
+#define   AXI_ADC_DDR_EDGESEL			BIT(1)
+#define   AXI_ADC_PIN_MODE			BIT(0)
+
+#define AXI_ADC_REG_CLK_FREQ			0x0054
+#define AXI_ADC_REG_CLK_RATIO			0x0058
+
+#define AXI_ADC_REG_STATUS			0x005C
+#define   AXI_ADC_MUX_PN_ERR			BIT(3)
+#define   AXI_ADC_MUX_PN_OOS			BIT(2)
+#define   AXI_ADC_MUX_OVER_RANGE		BIT(1)
+#define   AXI_ADC_STATUS			BIT(0)
+
+#define AXI_ADC_REG_DRP_CNTRL			0x0070
+#define   AXI_ADC_DRP_SEL			BIT(29)
+#define   AXI_ADC_DRP_RWN			BIT(28)
+#define   AXI_ADC_DRP_ADDRESS_MSK		GENMASK(27, 16)
+#define   AXI_ADC_DRP_ADDRESS_SET(x)		\
+		FIELD_PREP(AXI_ADC_DRP_ADDRESS_MSK, x)
+#define   AXI_ADC_DRP_ADDRESS_GET(x)		\
+		FIELD_GET(AXI_ADC_DRP_ADDRESS_MSK, x)
+#define   AXI_ADC_DRP_WDATA_SET			AXI_ADC_LOWER16_SET
+#define   AXI_ADC_DRP_WDATA_GET			AXI_ADC_LOWER16_GET
+
+#define AXI_REG_DRP_STATUS			0x0074
+#define   AXI_ADC_DRP_STATUS			BIT(16)
+#define   AXI_ADC_DRP_RDATA_SET			AXI_ADC_LOWER16_SET
+#define   AXI_ADC_DRP_RDATA_GET			AXI_ADC_LOWER16_GET
+
+#define AXI_ADC_REG_DMA_STATUS			0x0088
+#define   AXI_ADC_DMA_OVF			BIT(2)
+#define   AXI_ADC_DMA_UNF			BIT(1)
+#define   AXI_ADC_DMA_STATUS			BIT(0)
+
+#define ADI_REG_DMA_BUSWIDTH			0x008C
+#define AXI_ADC_REG_GP_CONTROL			0x00BC
+#define AXI_ADC_REG_ADC_DP_DISABLE		0x00C0
+
+/* ADC Channel controls */
+
+#define AXI_ADC_REG_CHAN_CNTRL(c)		(0x0400 + (c) * 0x40)
+#define   AXI_ADC_PN_SEL			BIT(10)
+#define   AXI_ADC_IQCOR_ENB			BIT(9)
+#define   AXI_ADC_DCFILT_ENB			BIT(8)
+#define   AXI_ADC_FORMAT_SIGNEXT		BIT(6)
+#define   AXI_ADC_FORMAT_TYPE			BIT(5)
+#define   AXI_ADC_FORMAT_ENABLE			BIT(4)
+#define   AXI_ADC_PN23_TYPE			BIT(1)
+#define   AXI_ADC_ENABLE			BIT(0)
+
+#define AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
+#define   AXI_ADC_PN_ERR			BIT(2)
+#define   AXI_ADC_PN_OOS			BIT(1)
+#define   AXI_ADC_OVER_RANGE			BIT(0)
+
+#define AXI_ADC_REG_CHAN_CNTRL_1(c)		(0x0410 + (c) * 0x40)
+#define   AXI_ADC_DCFILT_OFFSET_MSK		AXI_ADC_UPPER16_MSK
+#define   AXI_ADC_DCFILT_OFFSET_SET		AXI_ADC_UPPER16_SET
+#define   AXI_ADC_DCFILT_OFFSET_GET		AXI_ADC_UPPER16_GET
+#define   AXI_ADC_DCFILT_COEFF_MSK		AXI_ADC_LOWER16_MSK
+#define   AXI_ADC_DCFILT_COEFF_SET		AXI_ADC_LOWER16_SET
+#define   AXI_ADC_DCFILT_COEFF_GET		AXI_ADC_LOWER16_GET
+
+#define AXI_ADC_REG_CHAN_CNTRL_2(c)		(0x0414 + (c) * 0x40)
+#define   AXI_ADC_IQCOR_COEFF_1_MSK		AXI_ADC_UPPER16_MSK
+#define   AXI_ADC_IQCOR_COEFF_1_SET		AXI_ADC_UPPER16_SET
+#define   AXI_ADC_IQCOR_COEFF_1_GET		AXI_ADC_UPPER16_GET
+#define   AXI_ADC_IQCOR_COEFF_2_MSK		AXI_ADC_LOWER16_MSK
+#define   AXI_ADC_IQCOR_COEFF_2_SET		AXI_ADC_LOWER16_SET
+#define   AXI_ADC_IQCOR_COEFF_2_GET		AXI_ADC_LOWER16_GET
+
+/*  format is 1.1.14 (sign, integer and fractional bits) */
+#define AXI_ADC_IQCOR_INT_1			0x4000UL
+#define AXI_ADC_IQCOR_SIGN_BIT			BIT(15)
+/**
+ * The constant below is (2 x PI x 0x4000),
+ * where 0x4000 is AXI_ADC_IQCOR_INT_1
+ */
+#define AXI_ADC_2_X_PI_X_INT_1			102944ULL
+
+#define AXI_ADC_REG_CHAN_CNTRL_3(c)		(0x0418 + (c) * 0x40)
+#define   AXI_ADC_ADC_PN_SEL_MSK		AXI_ADC_UPPER16_MSK
+#define   AXI_ADC_ADC_PN_SEL_SET		AXI_ADC_UPPER16_SET
+#define   AXI_ADC_ADC_PN_SEL_GET		AXI_ADC_UPPER16_GET
+#define   AXI_ADC_ADC_DATA_SEL_MSK		AXI_ADC_LOWER16_MSK
+#define   AXI_ADC_ADC_DATA_SEL_SET		AXI_ADC_LOWER16_SET
+#define   AXI_ADC_ADC_DATA_SEL_GET		AXI_ADC_LOWER16_GET
+
+#define AXI_ADC_REG_CHAN_USR_CNTRL_2(c)		(0x0424 + (c) * 0x40)
+#define   AXI_ADC_USR_DECIMATION_M_MSK		AXI_ADC_UPPER16_MSK
+#define   AXI_ADC_USR_DECIMATION_M_SET		AXI_ADC_UPPER16_SET
+#define   AXI_ADC_USR_DECIMATION_M_GET		AXI_ADC_UPPER16_GET
+#define   AXI_ADC_USR_DECIMATION_N_MSK		AXI_ADC_LOWER16_MSK
+#define   AXI_ADC_USR_DECIMATION_N_SET		AXI_ADC_LOWER16_SET
+#define   AXI_ADC_USR_DECIMATION_N_GET		AXI_ADC_LOWER16_GET
+
+/* debugfs direct register access */
+#define DEBUGFS_DRA_PCORE_REG_MAGIC		BIT(31)
+
+struct adi_axi_adc_core_info {
+	unsigned int			version;
+};
+
+struct adi_axi_adc_state {
+	struct mutex			lock;
+
+	struct adi_axi_adc_client	*client;
+	void __iomem			*regs;
+};
+
+struct adi_axi_adc_client {
+	struct list_head		entry;
+	struct adi_axi_adc_conv		conv;
+	struct adi_axi_adc_state		*state;
+	struct device			*dev;
+	const struct adi_axi_adc_core_info	*info;
+};
+
+static LIST_HEAD(registered_clients);
+static DEFINE_MUTEX(registered_clients_lock);
+
+static struct adi_axi_adc_client *conv_to_client(struct adi_axi_adc_conv *conv)
+{
+	if (!conv)
+		return NULL;
+	return container_of(conv, struct adi_axi_adc_client, conv);
+}
+
+void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
+{
+	struct adi_axi_adc_client *cl = conv_to_client(conv);
+
+	if (!cl)
+		return NULL;
+
+	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
+}
+EXPORT_SYMBOL_GPL(adi_axi_adc_conv_priv);
+
+static void adi_axi_adc_write(struct adi_axi_adc_state *st,
+			      unsigned int reg,
+			      unsigned int val)
+{
+	iowrite32(val, st->regs + reg);
+}
+
+static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
+				     unsigned int reg)
+{
+	return ioread32(st->regs + reg);
+}
+
+static int adi_axi_adc_config_dma_buffer(struct device *dev,
+					 struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	const char *dma_name;
+
+	if (!device_property_present(dev, "dmas"))
+		return 0;
+
+	if (device_property_read_string(dev, "dma-names", &dma_name))
+		dma_name = "rx";
+
+	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
+						 dma_name);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	return 0;
+}
+
+static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+
+	if (!conv->read_raw)
+		return -ENOSYS;
+
+	return conv->read_raw(conv, chan, val, val2, mask);
+}
+
+static int adi_axi_adc_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+
+	if (!conv->write_raw)
+		return -ENOSYS;
+
+	return conv->write_raw(conv, chan, val, val2, mask);
+}
+
+static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
+					const unsigned long *scan_mask)
+{
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+	unsigned int i, ctrl;
+
+	for (i = 0; i < conv->chip_info->num_channels; i++) {
+		ctrl = adi_axi_adc_read(st, AXI_ADC_REG_CHAN_CNTRL(i));
+
+		if (test_bit(i, scan_mask))
+			ctrl |= AXI_ADC_ENABLE;
+		else
+			ctrl &= ~AXI_ADC_ENABLE;
+
+		adi_axi_adc_write(st, AXI_ADC_REG_CHAN_CNTRL(i), ctrl);
+	}
+
+	return 0;
+}
+
+static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device *dev,
+							  int sizeof_priv)
+{
+	struct adi_axi_adc_client *cl;
+	size_t alloc_size;
+
+	alloc_size = sizeof(struct adi_axi_adc_client);
+	if (sizeof_priv) {
+		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
+		alloc_size += sizeof_priv;
+	}
+	alloc_size += IIO_ALIGN - 1;
+
+	cl = kzalloc(alloc_size, GFP_KERNEL);
+	if (!cl)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&registered_clients_lock);
+
+	get_device(dev);
+	cl->dev = dev;
+
+	list_add_tail(&cl->entry, &registered_clients);
+
+	mutex_unlock(&registered_clients_lock);
+
+	return &cl->conv;
+}
+
+static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
+{
+	struct adi_axi_adc_client *cl = conv_to_client(conv);
+
+	if (!cl)
+		return;
+
+	mutex_lock(&registered_clients_lock);
+
+	put_device(cl->dev);
+	list_del(&cl->entry);
+	kfree(cl);
+
+	mutex_unlock(&registered_clients_lock);
+}
+
+static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
+{
+	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
+}
+
+struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
+							int sizeof_priv)
+{
+	struct adi_axi_adc_conv **ptr, *conv;
+
+	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
+	if (IS_ERR(conv)) {
+		devres_free(ptr);
+		return ERR_CAST(conv);
+	}
+
+	*ptr = conv;
+	devres_add(dev, ptr);
+
+	return conv;
+}
+EXPORT_SYMBOL_GPL(devm_adi_axi_adc_conv_register);
+
+static ssize_t in_voltage_scale_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+	size_t len = 0;
+	int i;
+
+	if (!conv->chip_info->num_scales) {
+		buf[0] = '\n';
+		return 1;
+	}
+
+	for (i = 0; i < conv->chip_info->num_scales; i++) {
+		const unsigned int *s = conv->chip_info->scale_table[i];
+
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%u.%06u ", s[0], s[1]);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
+
+static struct attribute *adi_axi_adc_attributes[] = {
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adi_axi_adc_attribute_group = {
+	.attrs = adi_axi_adc_attributes,
+};
+
+static const struct iio_info adi_axi_adc_info = {
+	.read_raw = &adi_axi_adc_read_raw,
+	.write_raw = &adi_axi_adc_write_raw,
+	.attrs = &adi_axi_adc_attribute_group,
+	.update_scan_mode = &adi_axi_adc_update_scan_mode,
+};
+
+static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id adi_axi_adc_of_match[] = {
+	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
+
+struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
+{
+	const struct of_device_id *id;
+	struct adi_axi_adc_client *cl;
+	struct device_node *cln;
+
+	if (!dev->of_node) {
+		dev_err(dev, "DT node is null\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	id = of_match_node(adi_axi_adc_of_match, dev->of_node);
+	if (!id)
+		return ERR_PTR(-ENODEV);
+
+	cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
+	if (!cln) {
+		dev_err(dev, "No 'adi,adc-dev' node defined\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&registered_clients_lock);
+
+	list_for_each_entry(cl, &registered_clients, entry) {
+		if (!cl->dev)
+			continue;
+		if (cl->dev->of_node == cln) {
+			if (!try_module_get(dev->driver->owner)) {
+				mutex_unlock(&registered_clients_lock);
+				return ERR_PTR(-ENODEV);
+			}
+			get_device(dev);
+			cl->info = id->data;
+			mutex_unlock(&registered_clients_lock);
+			return cl;
+		}
+	}
+
+	mutex_unlock(&registered_clients_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int adi_axi_adc_setup_channels(struct device *dev,
+				      struct adi_axi_adc_state *st)
+{
+	struct adi_axi_adc_conv *conv = conv = &st->client->conv;
+	unsigned int val;
+	int i, ret;
+
+	if (conv->preenable_setup) {
+		ret = conv->preenable_setup(conv);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < conv->chip_info->num_channels; i++) {
+		if (i & 1)
+			val = AXI_ADC_IQCOR_COEFF_2_SET(AXI_ADC_IQCOR_INT_1);
+		else
+			val = AXI_ADC_IQCOR_COEFF_1_SET(AXI_ADC_IQCOR_INT_1);
+		adi_axi_adc_write(st, AXI_ADC_REG_CHAN_CNTRL_2(i), val);
+
+		adi_axi_adc_write(st, AXI_ADC_REG_CHAN_CNTRL(i),
+			AXI_ADC_FORMAT_SIGNEXT | AXI_ADC_FORMAT_ENABLE |
+			AXI_ADC_IQCOR_ENB | AXI_ADC_ENABLE);
+	}
+
+	return 0;
+}
+
+static void adi_axi_adc_cleanup(void *data)
+{
+	struct adi_axi_adc_client *cl = data;
+
+	put_device(cl->dev);
+	module_put(cl->dev->driver->owner);
+}
+
+static int adi_axi_adc_probe(struct platform_device *pdev)
+{
+	struct adi_axi_adc_conv *conv;
+	struct iio_dev *indio_dev;
+	struct adi_axi_adc_client *cl;
+	struct adi_axi_adc_state *st;
+	unsigned int ver;
+	int ret;
+
+	cl = adi_axi_adc_attach_client(&pdev->dev);
+	if (IS_ERR(cl))
+		return PTR_ERR(cl);
+
+	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_adc_cleanup, cl);
+	if (ret)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = cl;
+	cl->state = st;
+	mutex_init(&st->lock);
+
+	st->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(st->regs))
+		return PTR_ERR(st->regs);
+
+	conv = &st->client->conv;
+
+	/* Reset HDL Core */
+	adi_axi_adc_write(st, AXI_ADC_REG_RSTN, 0);
+	mdelay(10);
+	adi_axi_adc_write(st, AXI_ADC_REG_RSTN, AXI_ADC_MMCM_RSTN);
+	mdelay(10);
+	adi_axi_adc_write(st, AXI_ADC_REG_RSTN,
+			  AXI_ADC_RSTN | AXI_ADC_MMCM_RSTN);
+
+	ver = adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
+
+	if (cl->info->version > ver) {
+		dev_err(&pdev->dev,
+			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
+			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
+			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
+			ADI_AXI_PCORE_VER_MAJOR(ver),
+			ADI_AXI_PCORE_VER_MINOR(ver),
+			ADI_AXI_PCORE_VER_PATCH(ver));
+		return -ENODEV;
+	}
+
+	indio_dev->info = &adi_axi_adc_info;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = pdev->dev.of_node->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = conv->chip_info->num_channels;
+	indio_dev->channels = conv->chip_info->channels;
+
+	ret = adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = adi_axi_adc_setup_channels(&pdev->dev, st);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
+		ADI_AXI_PCORE_VER_MAJOR(ver),
+		ADI_AXI_PCORE_VER_MINOR(ver),
+		ADI_AXI_PCORE_VER_PATCH(ver));
+
+	return 0;
+}
+
+static struct platform_driver adi_axi_adc_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = adi_axi_adc_of_match,
+	},
+	.probe = adi_axi_adc_probe,
+};
+module_platform_driver(adi_axi_adc_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices Generic AXI ADC IP core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/adi-axi-adc.h
new file mode 100644
index 000000000000..57974944b30b
--- /dev/null
+++ b/include/linux/iio/adc/adi-axi-adc.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Analog Devices Generic AXI ADC IP core driver/library
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+ *
+ * Copyright 2012-2020 Analog Devices Inc.
+ */
+#ifndef __ADI_AXI_ADC_H__
+#define __ADI_AXI_ADC_H__
+
+struct device;
+struct iio_chan_spec;
+
+/**
+ * struct adi_axi_adc_chip_info - Chip specific information
+ * @name		Chip name
+ * @id			Chip ID (usually product ID)
+ * @channels		Channel specifications of type @struct axi_adc_chan_spec
+ * @num_channels	Number of @channels
+ * @scale_table		Supported scales by the chip; tuples of 2 ints
+ * @num_scales		Number of scales in the table
+ * @max_rate		Maximum sampling rate supported by the device
+ */
+struct adi_axi_adc_chip_info {
+	const char			*name;
+	unsigned int			id;
+
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+
+	const unsigned int		(*scale_table)[2];
+	int				num_scales;
+
+	unsigned long			max_rate;
+};
+
+/**
+ * struct adi_axi_adc_conv - data of the ADC attached to the AXI ADC
+ * @chip_info		chip info details for the client ADC
+ * @preenable_setup	op to run in the client before enabling the AXI ADC
+ * @read_raw		IIO read_raw hook for the client ADC
+ * @write_raw		IIO write_raw hook for the client ADC
+ */
+struct adi_axi_adc_conv {
+	const struct adi_axi_adc_chip_info		*chip_info;
+
+	int (*preenable_setup)(struct adi_axi_adc_conv *conv);
+	int (*reg_access)(struct adi_axi_adc_conv *conv, unsigned int reg,
+			  unsigned int writeval, unsigned int *readval);
+	int (*read_raw)(struct adi_axi_adc_conv *conv,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask);
+	int (*write_raw)(struct adi_axi_adc_conv *conv,
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask);
+};
+
+struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
+							int sizeof_priv);
+
+void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv);
+
+#endif
-- 
2.20.1

