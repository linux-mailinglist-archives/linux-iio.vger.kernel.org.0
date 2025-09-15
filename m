Return-Path: <linux-iio+bounces-24106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCBBB57117
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A904A17A231
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79092D47EB;
	Mon, 15 Sep 2025 07:20:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0332C0286;
	Mon, 15 Sep 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920802; cv=none; b=aVhH25Y6of4J9UqK42xX9oVEw03X1YzpeR3NJBYkP3VUM+GvNmPFDFM7QbHg6DDqWDrdBNHRL5AZmvyjlRXXeeOsP+dQiNtg48IbJR8/yKN8wiIptME3U7CN0dNIiSF6B0QhWpH1IjyCoDMQvPY8sGMUdnFkfIGmnwuZmb+1TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920802; c=relaxed/simple;
	bh=UCUMJr48util4S1attl/bJBZDiZ2nJ4AJybhOIN5FW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cugmg2+QRGBGluTjx1rKXUf1zvyRvawRp8R/C619lEppPJ5ijX0A6ozxiXhHTvi6kjIqG+IHrm30QCSozoXvap1kmlrCDg8kqj0yWLyvQ97Uce/Poluq908Q4OX8udIb7s1F76t3H8ua59NSnQ3o+ZCtpUdFx3floqUNLn4lZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3E88200DD5;
	Mon, 15 Sep 2025 09:14:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A4F9200DD1;
	Mon, 15 Sep 2025 09:14:20 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 33D8E180007D;
	Mon, 15 Sep 2025 15:14:19 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: wbg@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP PCF85263/PCF85363 stopwatch
Date: Mon, 15 Sep 2025 12:44:15 +0530
Message-Id: <20250915071415.1956219-2-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915071415.1956219-1-lakshay.piplani@nxp.com>
References: <20250915071415.1956219-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add driver for the NXP PCF85263/PCF85363 devices when configured
in stopwatch mode.

In this mode, the device provides a dedicated stopwatch function
that counts in centiseconds (1/100th of a second) and supports a
range up to 999,999 hours.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
 drivers/counter/Kconfig                  |  12 +
 drivers/counter/Makefile                 |   1 +
 drivers/counter/nxp-pcf85363-stopwatch.c | 395 +++++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 drivers/counter/nxp-pcf85363-stopwatch.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe577..1d62893ffd5c 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -147,4 +147,16 @@ config TI_EQEP
 	  To compile this driver as a module, choose M here: the module will be
 	  called ti-eqep.
 
+config NXP_PCF85363_STOPWATCH
+	tristate "NXP PCF85263/PCF85363 stopwatch"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the NXP PCF85263ATL/PCF85363ATL when operated
+	  in stopwatch (counter) mode. This device exposes a counter over I2C with
+	  centisecond (1/100th of a second) granularity, counting up to 999,999 hours.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nxp-pcf85363-stopwatch.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index fa3c1d08f706..298e14f113f2 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
 obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
+obj-$(CONFIG_NXP_PCF85363_STOPWATCH)     += nxp-pcf85363-stopwatch.o
diff --git a/drivers/counter/nxp-pcf85363-stopwatch.c b/drivers/counter/nxp-pcf85363-stopwatch.c
new file mode 100644
index 000000000000..ee920634282c
--- /dev/null
+++ b/drivers/counter/nxp-pcf85363-stopwatch.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP PCF85263/PCF85363 Stopwatch
+ *
+ * Copyright (C) 2025 NXP
+ */
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/bcd.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/counter.h>
+#include <linux/cleanup.h>
+#include <linux/bitfield.h>
+#include <linux/nvmem-provider.h>
+
+#define SW_100THS	0x00
+#define SW_SECS		0x01
+#define SW_MINUTES	0x02
+#define SW_HOURS_XX_XX_00	0x03
+#define SW_HOURS_XX_00_XX	0x04
+#define SW_HOURS_00_XX_XX	0x05
+
+#define CTRL_OFFSET	0x24
+#define CTRL_OSCILLATOR	0x25
+#define CTRL_BATTERY	0x26
+#define CTRL_PIN_IO	0x27
+#define CTRL_FUNCTION	0x28
+#define CTRL_INTA_EN	0x29
+#define CTRL_INTB_EN	0x2a
+#define CTRL_FLAGS	0x2b
+#define CTRL_RAMBYTE	0x2c
+#define CTRL_WDOG	0x2d
+#define CTRL_STOP_EN	0x2e
+#define CTRL_RESETS	0x2f
+#define CTRL_RAM	0x40
+
+#define OSC_CAP_SEL	GENMASK(1, 0)
+#define OSC_CAP_6000	0x01
+#define OSC_CAP_12500	0x02
+
+#define STOP_EN_STOP	BIT(0)
+#define RTCM_BIT	BIT(4)
+#define MODE_100TH_S	BIT(7)
+#define SW_BCD7_MASK	GENMASK(6, 0)
+
+#define RESET_CPR	0xa4
+
+#define NVRAM_SIZE	0x40
+
+#define SW_MAX_100THS 359999999999ULL /* Maximum representable value in centiseconds (10ms)*/
+
+#define SW_TIME_REGS	6
+
+struct pcf85363 {
+	struct regmap *regmap;
+	struct counter_device *counter;
+	struct mutex lock; /* Protects access to stopwatch registers */
+};
+
+struct pcf85x63_config {
+	const struct regmap_config regmap;
+	unsigned int num_nvram;
+};
+
+static int pcf85363_load_capacitance(struct pcf85363 *pcf85363)
+{
+	struct device *dev = pcf85363->counter->parent;
+	u32 load = 7000;
+	u8 value = 0;
+
+	device_property_read_u32(dev, "quartz-load-femtofarads", &load);
+
+	switch (load) {
+	default:
+		dev_warn(pcf85363->counter->parent, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+			 load);
+		fallthrough;
+	case 7000:
+		break;
+	case 6000:
+		value = OSC_CAP_6000;
+		break;
+	case 12500:
+		value = OSC_CAP_12500;
+		break;
+	}
+
+	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
+				  OSC_CAP_SEL, value);
+}
+
+/* Reads stopwatch value in 1/100 seconds (centiseconds), the device stores
+ * six BCD fields: CC(0..99), SS(0..59), MM(0..59), HH0/HH1/HH2 (each 0..99)
+ * Seconds and minutes contain OS/EMON flag bits; mask them as per datasheet
+ * before bcd2bin().
+ */
+static int pcf85363_counter_read(struct counter_device *counter,
+				 struct counter_count *count, u64 *val)
+{
+	struct pcf85363 *pcf85363 = counter_priv(counter);
+	u8 raw[SW_TIME_REGS];
+	u64 hours;
+	int ret;
+
+	guard(mutex)(&pcf85363->lock);
+	ret = regmap_bulk_read(pcf85363->regmap, SW_100THS, raw, ARRAY_SIZE(raw));
+	if (ret)
+		return ret;
+
+	/* Mask OS/EMON flag bits in seconds/minutes */
+	raw[1] = FIELD_GET(SW_BCD7_MASK, raw[1]);
+	raw[2] = FIELD_GET(SW_BCD7_MASK, raw[2]);
+
+	hours = (u64)bcd2bin(raw[3]);
+	hours += (u64)bcd2bin(raw[4]) * 100ULL;
+	hours += (u64)bcd2bin(raw[5]) * 10000ULL;
+
+	*val = (u64)bcd2bin(raw[0]);
+	*val += (u64)bcd2bin(raw[1]) * 100ULL;
+	*val += (u64)bcd2bin(raw[2]) * 60ULL * 100ULL;
+	*val += hours * 60ULL * 60ULL * 100ULL;
+
+	/* Defensive clamp in case of transient read while rolling over */
+	if (*val > SW_MAX_100THS) {
+		dev_warn(counter->parent, "stopwatch value exceeds max, clamping\n");
+		*val = SW_MAX_100THS;
+	}
+
+	return 0;
+}
+
+/* Set stopwatch value in centiseconds. It requires a stop-load-start sequence.
+ * set STOP_EN, write all six BCD fields then clear STOP_EN.
+ */
+static int pcf85363_counter_write(struct counter_device *counter,
+				  struct counter_count *count, const u64 val)
+{
+	struct pcf85363 *pcf85363 = counter_priv(counter);
+	u64 rem = val;
+	u8 buf[SW_TIME_REGS];
+	int ret;
+
+	if (val > SW_MAX_100THS)
+		return -ERANGE;
+
+	buf[0] = bin2bcd(rem % 100); rem /= 100;
+	buf[1] = bin2bcd(rem % 60); rem /= 60;
+	buf[2] = bin2bcd(rem % 60); rem /= 60;
+	buf[3] = bin2bcd(rem % 100); rem /= 100;
+	buf[4] = bin2bcd(rem % 100); rem /= 100;
+	buf[5] = bin2bcd(rem % 100);
+
+	guard(mutex)(&pcf85363->lock);
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN, STOP_EN_STOP,
+				 FIELD_PREP(STOP_EN_STOP, 1));
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(pcf85363->regmap, SW_100THS, buf, ARRAY_SIZE(buf));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN, STOP_EN_STOP,
+				 FIELD_PREP(STOP_EN_STOP, 0));
+
+	return ret;
+}
+
+static int pcf85363_counter_is_enabled(struct counter_device *counter,
+					struct counter_count *count, u8 *enable)
+{
+	struct pcf85363 *pcf85363 = counter_priv(counter);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&pcf85363->lock);
+	ret = regmap_read(pcf85363->regmap, CTRL_STOP_EN, &val);
+	if (ret)
+		return ret;
+
+	*enable = !FIELD_GET(STOP_EN_STOP, val);
+
+	return 0;
+}
+
+static int pcf85363_counter_set_enable(struct counter_device *counter,
+					 struct counter_count *count, u8 enable)
+{
+	struct pcf85363 *pcf85363 = counter_priv(counter);
+
+	guard(mutex)(&pcf85363->lock);
+
+	return regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN,
+				  STOP_EN_STOP, FIELD_PREP(STOP_EN_STOP, enable ? 0 : 1));
+}
+
+static const struct counter_ops pcf85363_counter_ops = {
+	.count_read = pcf85363_counter_read,
+	.count_write = pcf85363_counter_write,
+};
+
+static struct counter_comp pcf85363_counter_ext[] = {
+	COUNTER_COMP_ENABLE(pcf85363_counter_is_enabled,
+			    pcf85363_counter_set_enable),
+};
+
+static struct counter_count pcf85363_counts[] = {
+	{
+		.id = 0,
+		.name = "pcf85363-stopwatch",
+		.functions_list = (const enum counter_function[]){
+		COUNTER_FUNCTION_INCREASE },
+		.num_functions = 1,
+		.ext = pcf85363_counter_ext,
+		.num_ext = ARRAY_SIZE(pcf85363_counter_ext),
+	}
+};
+
+static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	guard(mutex)(&pcf85363->lock);
+
+	return regmap_bulk_read(pcf85363->regmap, CTRL_RAM + offset,
+				val, bytes);
+}
+
+static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	guard(mutex)(&pcf85363->lock);
+
+	return regmap_bulk_write(pcf85363->regmap, CTRL_RAM + offset,
+				 val, bytes);
+}
+
+static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+	unsigned int tmp_val;
+	int ret;
+
+	guard(mutex)(&pcf85363->lock);
+
+	ret = regmap_read(pcf85363->regmap, CTRL_RAMBYTE, &tmp_val);
+	(*(unsigned char *)val) = (unsigned char)tmp_val;
+
+	return ret;
+}
+
+static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+	unsigned char tmp_val;
+
+	guard(mutex)(&pcf85363->lock);
+
+	tmp_val = *((unsigned char *)val);
+	return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
+				(unsigned int)tmp_val);
+}
+
+static const struct pcf85x63_config pcf_85263_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x2f,
+	},
+	.num_nvram = 1
+};
+
+static const struct pcf85x63_config pcf_85363_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x7f,
+	},
+	.num_nvram = 2
+};
+
+static const struct nvmem_config nvmem_cfgs[] = {
+	{
+		.name = "pcf85x63-",
+		.word_size = 1,
+		.stride = 1,
+		.size = 1,
+		.reg_read = pcf85x63_nvram_read,
+		.reg_write = pcf85x63_nvram_write,
+	}, {
+		.name = "pcf85363-",
+		.word_size = 1,
+		.stride = 1,
+		.size = NVRAM_SIZE,
+		.reg_read = pcf85363_nvram_read,
+		.reg_write = pcf85363_nvram_write,
+	},
+};
+
+static int pcf85363_stopwatch_probe(struct i2c_client *client)
+{
+	struct pcf85363 *pcf85363;
+	const struct pcf85x63_config *config = &pcf_85363_config;
+	const void *data = of_device_get_match_data(&client->dev);
+	struct device *dev = &client->dev;
+	struct nvmem_device *nvmem;
+	int ret, i, err;
+
+	if (data)
+		config = data;
+
+	struct counter_device *counter = devm_counter_alloc(dev, sizeof(struct pcf85363));
+
+	if (!counter)
+		return -ENOMEM;
+
+	pcf85363 = counter_priv(counter);
+
+	mutex_init(&pcf85363->lock);
+
+	pcf85363->regmap = devm_regmap_init_i2c(client, &config->regmap);
+	if (IS_ERR(pcf85363->regmap))
+		return dev_err_probe(dev, PTR_ERR(pcf85363->regmap), "regmap init failed\n");
+
+	/* Stopwatch Mode set and centiseconds granularity enabled */
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_FUNCTION,
+				 RTCM_BIT | MODE_100TH_S, RTCM_BIT | MODE_100TH_S);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set RTCM bit\n");
+
+	ret = regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to clear flags\n");
+
+	counter->name = "pcf85363-stopwatch";
+	counter->parent = dev;
+	counter->ops = &pcf85363_counter_ops;
+	counter->counts = pcf85363_counts;
+	counter->num_counts = ARRAY_SIZE(pcf85363_counts);
+	pcf85363->counter = counter;
+
+	ret = devm_counter_add(dev, counter);
+	if (ret)
+		return dev_err_probe(dev, ret, "Counter registration failed\n");
+
+	dev_dbg(dev, "pcf85363 registered in stopwatch mode\n");
+
+	err = pcf85363_load_capacitance(pcf85363);
+	if (err < 0)
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d", err);
+
+	for (i = 0; i < config->num_nvram; i++) {
+		struct nvmem_config cfg = nvmem_cfgs[i];
+
+		cfg.priv = pcf85363;
+		cfg.dev = dev;
+		cfg.id = i;
+		nvmem = devm_nvmem_register(dev, &cfg);
+		if (IS_ERR(nvmem))
+			return dev_err_probe(dev, PTR_ERR(nvmem), "nvmem reg %d failed\n", i);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id dev_ids[] = {
+	{ .compatible = "nxp,pcf85263atl", .data = &pcf_85263_config },
+	{ .compatible = "nxp,pcf85363atl", .data = &pcf_85363_config },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dev_ids);
+
+static struct i2c_driver pcf85363_sw_driver = {
+	.driver	= {
+		.name	= "pcf85363-stopwatch",
+		.of_match_table = of_match_ptr(dev_ids),
+	},
+	.probe = pcf85363_stopwatch_probe,
+};
+
+module_i2c_driver(pcf85363_sw_driver);
+
+MODULE_AUTHOR("Lakshay Piplani");
+MODULE_DESCRIPTION("pcf85263/pcf85363 stopwatch driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("COUNTER");
-- 
2.25.1


