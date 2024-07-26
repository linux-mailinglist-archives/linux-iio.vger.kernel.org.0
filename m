Return-Path: <linux-iio+bounces-7905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75693CE03
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAA71F2269A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416F1741FB;
	Fri, 26 Jul 2024 06:13:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0915666F;
	Fri, 26 Jul 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974412; cv=none; b=I+9zl5hVeetAkX4VMjr25zWTtoKJl7jqEwHF6eDRSHrX+UATlzsI4y4bk9Ve+aZATeshfRCOJPQzDuW0x0GEJ57/c2nrh9HE5/DhYv2YluH0AgNM1uS6czHSidHWVf08gC6GlhDds0JeMETIrnxTJK4dpmd5iZyuOfo5KfOLDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974412; c=relaxed/simple;
	bh=IkfWjluNDETqHODqCuB6ZXHPfalo1qLLtDVHcBqzpQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAYG6Vl5+NqpJKisIMNSTu5QeTq1GoOxx+WNE7Ym58S34VaCcxSQmVWo+/BPxpoT7jFBzU2q/6BRwLxKl0v2h0CbGMp2ZQvjwl4JIMANQgfpZX+/VdFkkpmXwCQMnDptp6pcjPlV+0gLS0Xw69gu0FKRkcXwx8pFh2VnFtdu4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0115541-0.00031932-0.988127;FP=12784380377588843771|6|3|9|0|-1|-1|-1;HT=maildocker-contentspam033023106192;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Ya9xK-3_1721974403;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Ya9xK-3_1721974403)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 14:13:24 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	waqar.hameed@axis.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x proximity sensor
Date: Fri, 26 Jul 2024 06:13:12 +0000
Message-ID: <20240726061312.1371450-3-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240726061312.1371450-1-wangshuaijie@awinic.com>
References: <20240726061312.1371450-1-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

AW9610X is a low power consumption capacitive touch and proximity controller.
Each channel can be independently config as sensor input, shield output.

Channel Information:
  aw96103: 3-channel
  aw96105: 5-channel

Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
---
 drivers/iio/proximity/Kconfig   |  11 +
 drivers/iio/proximity/Makefile  |   1 +
 drivers/iio/proximity/aw9610x.c | 791 ++++++++++++++++++++++++++++++++
 drivers/iio/proximity/aw9610x.h | 140 ++++++
 4 files changed, 943 insertions(+)
 create mode 100644 drivers/iio/proximity/aw9610x.c
 create mode 100644 drivers/iio/proximity/aw9610x.h

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 2ca3b0bc5eba..ca1b8bde2def 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -219,4 +219,15 @@ config VL53L0X_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called vl53l0x-i2c.
 
+config AW9610X
+	tristate "Awinic AW9610X proximity sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here to build a driver for Awinic's AW9610X capacitive
+	  proximity sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called aw9610x.
+
 endmenu
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index f36598380446..483f5bf1ac8b 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
+obj-$(CONFIG_AW9610X)		+= aw9610x.o
 
diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9610x.c
new file mode 100644
index 000000000000..de5be3918e4f
--- /dev/null
+++ b/drivers/iio/proximity/aw9610x.c
@@ -0,0 +1,791 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AWINIC aw9610x proximity sensor driver
+ *
+ * Author: Wang Shuaijie <wangshuaijie@awinic.com>
+ *
+ * Copyright (c) 2024 awinic Technology CO., LTD
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/of_gpio.h>
+#include <linux/power_supply.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "aw9610x.h"
+
+static unsigned int aw9610x_reg_default[] = {
+	0x0000, 0x00003f3f, 0x0004, 0x00000064, 0x0008, 0x0017c11e,
+	0x000c, 0x05000000, 0x0010, 0x00093ffd, 0x0014, 0x19240009,
+	0x0018, 0xd81c0207, 0x001c, 0xff000000, 0x0020, 0x00241900,
+	0x0024, 0x00093ff7, 0x0028, 0x58020009, 0x002c, 0xd81c0207,
+	0x0030, 0xff000000, 0x0034, 0x00025800, 0x0038, 0x00093fdf,
+	0x003c, 0x7d3b0009, 0x0040, 0xd81c0207,	0x0044, 0xff000000,
+	0x0048, 0x003b7d00, 0x004c, 0x00093f7f, 0x0050, 0xe9310009,
+	0x0054, 0xd81c0207, 0x0058, 0xff000000,	0x005c, 0x0031e900,
+	0x0060, 0x00093dff, 0x0064, 0x1a0c0009,	0x0068, 0xd81c0207,
+	0x006c, 0xff000000, 0x0070, 0x000c1a00,	0x0074, 0x80093fff,
+	0x0078, 0x043d0009, 0x007c, 0xd81c0207,	0x0080, 0xff000000,
+	0x0084, 0x003d0400, 0x00a0, 0xe6400000,	0x00a4, 0x00000000,
+	0x00a8, 0x010408d2, 0x00ac, 0x00000000,	0x00b0, 0x00000000,
+	0x00b8, 0x00005fff, 0x00bc, 0x00000000,	0x00c0, 0x00000000,
+	0x00c4, 0x00000000, 0x00c8, 0x00000000,	0x00cc, 0x00000000,
+	0x00d0, 0x00000000, 0x00d4, 0x00000000, 0x00d8, 0x00000000,
+	0x00dc, 0xe6447800, 0x00e0, 0x78000000,	0x00e4, 0x010408d2,
+	0x00e8, 0x00000000, 0x00ec, 0x00000000,	0x00f4, 0x00005fff,
+	0x00f8, 0x00000000, 0x00fc, 0x00000000,	0x0100, 0x00000000,
+	0x0104, 0x00000000, 0x0108, 0x00000000,	0x010c, 0x02000000,
+	0x0110, 0x00000000, 0x0114, 0x00000000,	0x0118, 0xe6447800,
+	0x011c, 0x78000000, 0x0120, 0x010408d2,	0x0124, 0x00000000,
+	0x0128, 0x00000000, 0x0130, 0x00005fff,	0x0134, 0x00000000,
+	0x0138, 0x00000000, 0x013c, 0x00000000,	0x0140, 0x00000000,
+	0x0144, 0x00000000, 0x0148, 0x02000000,	0x014c, 0x00000000,
+	0x0150, 0x00000000, 0x0154, 0xe6447800,	0x0158, 0x78000000,
+	0x015c, 0x010408d2, 0x0160, 0x00000000,	0x0164, 0x00000000,
+	0x016c, 0x00005fff, 0x0170, 0x00000000,	0x0174, 0x00000000,
+	0x0178, 0x00000000, 0x017c, 0x00000000,	0x0180, 0x00000000,
+	0x0184, 0x02000000, 0x0188, 0x00000000,	0x018c, 0x00000000,
+	0x0190, 0xe6447800, 0x0194, 0x78000000,	0x0198, 0x010408d2,
+	0x019c, 0x00000000, 0x01a0, 0x00000000,	0x01a8, 0x00005fff,
+	0x01ac, 0x00000000, 0x01b0, 0x00000000,	0x01b4, 0x00000000,
+	0x01b8, 0x00000000, 0x01bc, 0x00000000,	0x01c0, 0x02000000,
+	0x01c4, 0x00000000, 0x01c8, 0x00000000,	0x01cc, 0xe6407800,
+	0x01d0, 0x78000000, 0x01d4, 0x010408d2,	0x01d8, 0x00000000,
+	0x01dc, 0x00000000, 0x01e4, 0x00005fff,	0x01e8, 0x00000000,
+	0x01ec, 0x00000000, 0x01f0, 0x00000000,	0x01f4, 0x00000000,
+	0x01f8, 0x00000000, 0x01fc, 0x02000000,	0x0200, 0x00000000,
+	0x0204, 0x00000000, 0x0208, 0x00000008,	0x020c, 0x0000000d,
+	0x41fc, 0x00000000, 0x4400, 0x00000000,	0x4410, 0x00000000,
+	0x4420, 0x00000000, 0x4430, 0x00000000,	0x4440, 0x00000000,
+	0x4450, 0x00000000, 0x4460, 0x00000000,	0x4470, 0x00000000,
+	0xf080, 0x00003018, 0xf084, 0x00000fff,	0xf800, 0x00000000,
+	0xf804, 0x00002e00, 0xf8d0, 0x00000001,	0xf8d4, 0x00000000,
+	0xff00, 0x00000301, 0xff0c, 0x01000000,	0xffe0, 0x00000000,
+	0xfff4, 0x00004011, 0x0090, 0x00000000,	0x0094, 0x00000000,
+	0x0098, 0x00000000, 0x009c, 0x3f3f3f3f,
+};
+
+static void aw9610x_parsing_bin_file(struct aw_bin *bin)
+{
+	int i;
+
+	bin->valid_data_addr = AW9610X_BIN_VALID_DATA_OFFSET;
+	bin->valid_data_len =
+		*(unsigned int *)(bin->data + AW9610X_BIN_DATA_LEN_OFFSET) -
+		AW9610X_BIN_DATA_REG_NUM_SIZE;
+	for (i = 0; i < AW9610X_BIN_CHIP_TYPE_SIZE; i++) {
+		bin->chip_type[i] =
+			*(bin->data + AW9610X_BIN_CHIP_TYPE_OFFSET + i);
+	}
+}
+
+static const struct regmap_config aw9610x_regmap_confg = {
+	.reg_bits = 16,
+	.val_bits = 32,
+};
+
+static int aw9610x_i2c_write(struct aw9610x *aw9610x,
+		u16 reg_addr16, u32 reg_data32)
+{
+	return regmap_write(aw9610x->regmap, (unsigned int)reg_addr16,
+			(unsigned int)reg_data32);
+}
+
+static int aw9610x_i2c_read(struct aw9610x *aw9610x,
+		u16 reg_addr16, u32 *reg_data32)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(aw9610x->regmap, (unsigned int)reg_addr16, &data);
+	if (ret == 0)
+		*reg_data32 = data;
+
+	return ret;
+}
+
+static int aw9610x_i2c_write_bits(struct aw9610x *aw9610x,
+		u16 reg_addr16, u32 mask, u32 reg_data32)
+{
+	return regmap_update_bits(aw9610x->regmap, (unsigned int)reg_addr16,
+			(unsigned int)(~mask), (unsigned int)reg_data32);
+}
+
+static const struct iio_event_spec aw_common_events[2] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
+static int aw9610x_get_diff_raw(struct aw9610x *aw9610x,
+		unsigned int chan, int *buf)
+{
+	u32 data;
+	int ret;
+
+	ret = aw9610x_i2c_read(aw9610x, REG_DIFF_CH0 + chan * 4, &data);
+	if (ret)
+		return ret;
+	*buf = (int)data / AW_DATA_PROCESS_FACTOR;
+
+	return ret;
+}
+
+static int aw9610x_read_raw(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan,
+		int *val, int *val2, long mask)
+{
+	struct aw9610x *aw9610x;
+
+	aw9610x = iio_priv(indio_dev);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		aw9610x_get_diff_raw(aw9610x, chan->channel, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+struct iio_info iio_info = {
+	.read_raw = aw9610x_read_raw,
+};
+
+static int aw9610x_iio_init(struct aw9610x *aw9610x)
+{
+	struct iio_chan_spec *aw9610x_channels;
+	unsigned int chan_num = 0, j = 0;
+	unsigned int i;
+
+	aw9610x->channels_arr = devm_kcalloc(aw9610x->dev, AW_CHANNEL_MAX,
+			sizeof(struct aw_channels_info), GFP_KERNEL);
+	if (!aw9610x->channels_arr)
+		return -ENOMEM;
+
+	for (i = 0; i < AW_CHANNEL_MAX; i++) {
+		aw9610x->channels_arr[i].last_channel_info = 0;
+		if ((AW9610X_CHANNEL_USED_MASK >> i) & 0x01) {
+			aw9610x->channels_arr[i].used = true;
+			chan_num++;
+		} else {
+			aw9610x->channels_arr[i].used = false;
+		}
+	}
+
+	aw9610x_channels = devm_kcalloc(aw9610x->dev, chan_num,
+			sizeof(*aw9610x_channels), GFP_KERNEL);
+	if (!aw9610x_channels)
+		return -ENOMEM;
+
+	for (i = 0; i < AW_CHANNEL_MAX; i++) {
+		if (aw9610x->channels_arr[i].used) {
+			aw9610x_channels[j].type = IIO_PROXIMITY;
+			aw9610x_channels[j].info_mask_separate =
+				BIT(IIO_CHAN_INFO_RAW);
+			aw9610x_channels[j].indexed = 1;
+			aw9610x_channels[j].channel = i;
+			aw9610x_channels[j].event_spec = aw_common_events;
+			aw9610x_channels[j].num_event_specs =
+				ARRAY_SIZE(aw_common_events);
+			j++;
+		}
+	}
+
+	aw9610x->aw_iio_dev->modes = INDIO_DIRECT_MODE;
+	aw9610x->aw_iio_dev->num_channels = chan_num;
+	aw9610x->aw_iio_dev->channels = aw9610x_channels;
+	aw9610x->aw_iio_dev->info = &iio_info;
+	aw9610x->aw_iio_dev->name = "aw9610x_sensor";
+	aw9610x->aw_iio_dev->dev.parent = aw9610x->dev;
+
+	return devm_iio_device_register(aw9610x->dev, aw9610x->aw_iio_dev);
+}
+
+static int aw9610x_channel_scan_start(struct aw9610x *aw9610x)
+{
+	int ret;
+
+	ret = aw9610x_i2c_write(aw9610x, REG_CMD, AW9610X_ACTIVE_MODE);
+	if (ret)
+		return ret;
+	ret = aw9610x_i2c_write(aw9610x, REG_IRQEN, aw9610x->hostirqen);
+
+	return ret;
+}
+
+static int aw9610x_reg_version_comp(struct aw9610x *aw9610x,
+		struct aw_bin *aw_bin)
+{
+	u32 blfilt1_data, blfilt1_tmp;
+	unsigned char i;
+	int ret = 0;
+
+	if ((aw9610x->vers == AW9610XA) && (aw_bin->chip_type[7] == '\0')) {
+		for (i = 0; i < 6; i++) {
+			ret = aw9610x_i2c_read(aw9610x,
+					REG_BLFILT_CH0 +
+					(AW9610X_BLFILT_CH_STEP * i),
+					&blfilt1_data);
+			if (ret)
+				return ret;
+			blfilt1_tmp = FIELD_GET(AW9610X_BLERRTRIG_MASK,
+					blfilt1_data);
+			if (blfilt1_tmp == 1) {
+				ret = aw9610x_i2c_write_bits(aw9610x,
+					REG_BLRSTRNG_CH0 +
+					(AW9610X_BLFILT_CH_STEP * i),
+					~(AW9610X_BLRSTRNG_MASK), 1 << i);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static void aw9610x_aot_set(struct aw9610x *aw9610x)
+{
+	aw9610x_i2c_write_bits(aw9610x, REG_SCANCTRL0,
+			~(AW9610X_AOT_MASK << AW9610X_AOT_BIT),
+			(AW9610X_AOT_MASK) << AW9610X_AOT_BIT);
+}
+
+static int aw9610x_bin_valid_loaded(struct aw9610x *aw9610x,
+		struct aw_bin *aw_bin_data_s)
+{
+	unsigned int start_addr = aw_bin_data_s->valid_data_addr;
+	u32 i, reg_data;
+	u16 reg_addr;
+	int ret;
+
+	for (i = 0; i < aw_bin_data_s->valid_data_len;
+			i += 6, start_addr += 6) {
+		reg_addr = *(u16 *)(aw_bin_data_s->data + start_addr);
+		reg_data = *(u32 *)(aw_bin_data_s->data + start_addr + 2);
+		if ((reg_addr == REG_EEDA0) || (reg_addr == REG_EEDA1))
+			continue;
+		if (reg_addr == REG_IRQEN) {
+			aw9610x->hostirqen = reg_data;
+			continue;
+		}
+		ret = aw9610x_i2c_write(aw9610x, reg_addr, reg_data);
+		if (ret < 0)
+			return ret;
+
+	}
+	ret = aw9610x_reg_version_comp(aw9610x, aw_bin_data_s);
+	if (ret)
+		return ret;
+	ret = aw9610x_channel_scan_start(aw9610x);
+
+	return ret;
+}
+
+static int aw9610x_para_loaded(struct aw9610x *aw9610x)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(aw9610x_reg_default); i += 2) {
+		ret = aw9610x_i2c_write(aw9610x,
+				(u16)aw9610x_reg_default[i],
+				(u32)aw9610x_reg_default[i+1]);
+		if (ret)
+			return ret;
+		if (aw9610x_reg_default[i] == REG_IRQEN)
+			aw9610x->hostirqen = aw9610x_reg_default[i+1];
+	}
+	ret = aw9610x_channel_scan_start(aw9610x);
+
+	return ret;
+}
+
+static int aw9610x_cfg_all_loaded(const struct firmware *cont,
+		struct aw9610x *aw9610x)
+{
+	struct aw_bin *aw_bin;
+	int ret;
+
+	if (!cont)
+		return -EINVAL;
+
+	aw_bin = kzalloc(cont->size + sizeof(*aw_bin), GFP_KERNEL);
+	if (!aw_bin)
+		return -ENOMEM;
+
+	aw_bin->len = cont->size;
+	memcpy(aw_bin->data, cont->data, cont->size);
+	aw9610x_parsing_bin_file(aw_bin);
+
+	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",
+			aw_bin->chip_type);
+	ret = aw9610x_bin_valid_loaded(aw9610x, aw_bin);
+	kfree(aw_bin);
+
+	return ret;
+}
+
+static int aw9610x_cfg_update(struct aw9610x *aw9610x)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, "aw9610x_0.bin", aw9610x->dev);
+	if (ret)
+		return ret;
+	ret = aw9610x_cfg_all_loaded(fw, aw9610x);
+	if (ret)
+		ret = aw9610x_para_loaded(aw9610x);
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void aw9610x_cfg_work_routine(struct work_struct *work)
+{
+	struct aw9610x *aw9610x = container_of(work, struct aw9610x,
+			cfg_work.work);
+
+	aw9610x_cfg_update(aw9610x);
+}
+
+static int aw9610x_sar_cfg_init(struct aw9610x *aw9610x)
+{
+	INIT_DELAYED_WORK(&aw9610x->cfg_work, aw9610x_cfg_work_routine);
+	schedule_delayed_work(&aw9610x->cfg_work, msecs_to_jiffies(5000));
+
+	return 0;
+}
+
+static int aw9610x_sw_reset(struct aw9610x *aw9610x)
+{
+	int ret;
+
+	ret = aw9610x_i2c_write(aw9610x, REG_RESET, 0);
+	msleep(20);
+
+	return ret;
+}
+
+static ssize_t update_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct aw9610x *aw9610x = dev_get_drvdata(dev);
+	unsigned int state;
+	ssize_t ret;
+
+	ret = kstrtouint(buf, 10, &state);
+	if (ret)
+		return ret;
+	if (state) {
+		aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);
+		aw9610x_sw_reset(aw9610x);
+		schedule_delayed_work(&aw9610x->cfg_work,
+					msecs_to_jiffies(10));
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(update);
+
+static struct attribute *aw9610x_sar_attributes[] = {
+	&dev_attr_update.attr,
+	NULL
+};
+
+static struct attribute_group aw9610x_sar_attribute_group = {
+	.attrs = aw9610x_sar_attributes
+};
+
+static void aw9610x_irq_handle(struct aw9610x *aw9610x)
+{
+	u32 curr_status_val;
+	u32 curr_status;
+	unsigned char i;
+	int ret;
+
+	ret = aw9610x_i2c_read(aw9610x, REG_STAT0, &curr_status_val);
+	if (ret)
+		return;
+
+	for (i = 0; i < AW_CHANNEL_MAX; i++) {
+		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
+			(((curr_status_val >> (16 + i)) & 0x1) << 1) |
+			(((curr_status_val >> (8 + i)) & 0x1) << 2) |
+			(((curr_status_val >> (i)) & 0x1) << 3);
+
+		if (!aw9610x->channels_arr[i].used ||
+				(aw9610x->channels_arr[i].last_channel_info ==
+				curr_status))
+			continue;
+
+		switch (curr_status) {
+		case FAR:
+			iio_push_event(aw9610x->aw_iio_dev,
+					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_RISING),
+					iio_get_time_ns(aw9610x->aw_iio_dev));
+			break;
+		case TRIGGER_TH0:
+		case TRIGGER_TH1:
+		case TRIGGER_TH2:
+		case TRIGGER_TH3:
+			iio_push_event(aw9610x->aw_iio_dev,
+					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_FALLING),
+					iio_get_time_ns(aw9610x->aw_iio_dev));
+			break;
+		default:
+			return;
+		}
+		aw9610x->channels_arr[i].last_channel_info = curr_status;
+	}
+}
+
+static void aw9610x_interrupt_clear(struct aw9610x *aw9610x)
+{
+	int ret;
+
+	ret = aw9610x_i2c_read(aw9610x, REG_IRQSRC, &aw9610x->irq_status);
+	if (ret)
+		return;
+
+	aw9610x_irq_handle(aw9610x);
+}
+
+static irqreturn_t aw9610x_irq(int irq, void *data)
+{
+	struct aw9610x *aw9610x = data;
+
+	aw9610x_interrupt_clear(aw9610x);
+
+	return IRQ_HANDLED;
+}
+
+static int aw9610x_interrupt_init(struct aw9610x *aw9610x)
+{
+	unsigned int irq_status;
+	int ret;
+
+	ret = aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);
+	ret |= aw9610x_i2c_read(aw9610x, REG_IRQSRC, &irq_status);
+	if (ret)
+		return ret;
+	ret = devm_request_threaded_irq(aw9610x->dev, aw9610x->i2c->irq,
+			NULL, aw9610x_irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"aw9610x_irq", aw9610x);
+	if (ret)
+		return ret;
+	ret = aw9610x_i2c_write(aw9610x, REG_IRQEN, aw9610x->hostirqen);
+
+	return ret;
+}
+
+static int aw9610x_power_enable(struct aw9610x *aw9610x, bool on)
+{
+	int ret;
+
+	if (on) {
+		ret = regulator_enable(aw9610x->vcc);
+		if (ret)
+			return ret;
+		msleep(20);
+	} else {
+		ret = regulator_disable(aw9610x->vcc);
+	}
+
+	return ret;
+}
+
+static int aw9610x_power_init(struct aw9610x *aw9610x)
+{
+	int rc;
+
+	aw9610x->vcc = devm_regulator_get(aw9610x->dev, "vcc");
+	if (!aw9610x->vcc)
+		return 0;
+
+	rc = aw9610x_power_enable(aw9610x, true);
+
+	return rc;
+}
+
+static int aw9610x_wait_chip_init(struct aw9610x *aw9610x)
+{
+	unsigned int cnt = 20;
+	u32 reg_data;
+	int ret;
+
+	while (cnt--) {
+		ret = aw9610x_i2c_read(aw9610x, REG_IRQSRC, &reg_data);
+		if (ret)
+			return ret;
+
+		if ((reg_data & 0x01) == 0x01)
+			return 0;
+		mdelay(1);
+	}
+
+	return -EINVAL;
+}
+
+static int aw9610x_read_chipid(struct aw9610x *aw9610x)
+{
+	unsigned char cnt = 0;
+	u32 reg_val;
+	int ret;
+
+	while (cnt < AW_READ_CHIPID_RETRIES) {
+		ret = aw9610x_i2c_read(aw9610x, REG_CHIPID, &reg_val);
+		if (ret < 0) {
+			cnt++;
+			usleep_range(2000, 3000);
+		} else {
+			reg_val = FIELD_GET(AW9610X_CHIPID_MASK, reg_val);
+			break;
+		}
+	}
+
+	if (reg_val == AW9610X_CHIP_ID)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int aw9610x_version_init(struct aw9610x *aw9610x)
+{
+	u32 fw_ver;
+	int ret;
+
+	ret = aw9610x_i2c_read(aw9610x, REG_FWVER2, &fw_ver);
+	if (ret)
+		return ret;
+	if (fw_ver == AW_CHIP_AW9610XA)
+		aw9610x->vers = AW9610XA;
+	else
+		aw9610x->vers = AW9610X;
+
+	return ret;
+}
+
+static void aw9610x_ps_notify_callback_work(struct work_struct *work)
+{
+	struct aw9610x *aw9610x = container_of(work, struct aw9610x,
+			ps_notify_work);
+
+	aw9610x_aot_set(aw9610x);
+}
+
+static int aw9610x_ps_get_state(struct aw9610x *aw9610x,
+		struct power_supply *psy, bool *present)
+{
+	union power_supply_propval pval = { 0 };
+	int retval;
+
+	retval = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+			&pval);
+	if (retval)
+		return retval;
+	*present = (pval.intval) ? true : false;
+
+	return 0;
+}
+
+static int aw9610x_ps_notify_callback(struct notifier_block *self,
+		unsigned long event, void *p)
+{
+	struct aw9610x *aw9610x = container_of(self, struct aw9610x, ps_notif);
+	struct power_supply *psy = p;
+	bool present;
+	int retval;
+
+	if (event == PSY_EVENT_PROP_CHANGED && psy &&
+			psy->desc->get_property && psy->desc->name &&
+			!strncmp(psy->desc->name, USB_POWER_SUPPLY_NAME,
+				sizeof(USB_POWER_SUPPLY_NAME))) {
+		retval = aw9610x_ps_get_state(aw9610x, psy, &present);
+		if (retval)
+			return retval;
+		if (aw9610x->ps_is_present == present)
+			return 0;
+		aw9610x->ps_is_present = present;
+		schedule_work(&aw9610x->ps_notify_work);
+	}
+
+	return 0;
+}
+
+static int aw9610x_ps_notify_init(struct aw9610x *aw9610x)
+{
+	struct power_supply *psy;
+	int ret;
+
+	INIT_WORK(&aw9610x->ps_notify_work, aw9610x_ps_notify_callback_work);
+	aw9610x->ps_notif.notifier_call = aw9610x_ps_notify_callback;
+	ret = power_supply_reg_notifier(&aw9610x->ps_notif);
+	if (ret)
+		return ret;
+
+	psy = power_supply_get_by_name(USB_POWER_SUPPLY_NAME);
+	if (!psy)
+		goto free_ps_notifier;
+
+	ret = aw9610x_ps_get_state(aw9610x, psy, &aw9610x->ps_is_present);
+	if (ret)
+		goto free_ps_notifier;
+
+	return ret;
+
+free_ps_notifier:
+	power_supply_unreg_notifier(&aw9610x->ps_notif);
+
+	return -EINVAL;
+}
+
+static int aw9610x_i2c_probe(struct i2c_client *i2c)
+{
+	struct iio_dev *aw_iio_dev;
+	struct aw9610x *aw9610x;
+	int ret;
+
+	aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw9610x));
+	if (!aw_iio_dev)
+		return -ENOMEM;
+
+	aw9610x = iio_priv(aw_iio_dev);
+	aw9610x->aw_iio_dev = aw_iio_dev;
+	aw9610x->dev = &i2c->dev;
+	aw9610x->i2c = i2c;
+	i2c_set_clientdata(i2c, aw9610x);
+
+	aw9610x->regmap = devm_regmap_init_i2c(i2c, &aw9610x_regmap_confg);
+	if (IS_ERR(aw9610x->regmap))
+		return PTR_ERR(aw9610x->regmap);
+	ret = aw9610x_power_init(aw9610x);
+	if (ret)
+		return ret;
+
+	ret = aw9610x_read_chipid(aw9610x);
+	if (ret)
+		return ret;
+
+	ret = aw9610x_sw_reset(aw9610x);
+	if (ret)
+		return ret;
+
+	ret = aw9610x_wait_chip_init(aw9610x);
+	if (ret)
+		return ret;
+
+	ret = aw9610x_version_init(aw9610x);
+	if (ret)
+		return ret;
+
+	ret = aw9610x_ps_notify_init(aw9610x);
+	if (ret < 0)
+		goto err_ps_notify;
+
+	ret = aw9610x_iio_init(aw9610x);
+	if (ret)
+		goto err_iio_init;
+
+	ret = aw9610x_sar_cfg_init(aw9610x);
+	if (ret)
+		goto err_iio_init;
+
+	ret = sysfs_create_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);
+	if (ret)
+		goto err_iio_init;
+
+	ret = aw9610x_interrupt_init(aw9610x);
+	if (ret)
+		goto err_interrupt_init;
+
+	return ret;
+
+err_interrupt_init:
+	sysfs_remove_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);
+err_iio_init:
+	power_supply_unreg_notifier(&aw9610x->ps_notif);
+err_ps_notify:
+	if (aw9610x->vcc)
+		aw9610x_power_enable(aw9610x, false);
+
+	return ret;
+}
+
+static void aw9610x_i2c_remove(struct i2c_client *i2c)
+{
+	struct aw9610x *aw9610x = i2c_get_clientdata(i2c);
+
+	if (aw9610x->vcc)
+		aw9610x_power_enable(aw9610x, false);
+	power_supply_unreg_notifier(&aw9610x->ps_notif);
+	sysfs_remove_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);
+}
+
+static void aw9610x_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct aw9610x *aw9610x = i2c_get_clientdata(i2c);
+	u32 irq_status_temp;
+
+	aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);
+	aw9610x_i2c_read(aw9610x, REG_IRQSRC, &irq_status_temp);
+	aw9610x_i2c_write(aw9610x, REG_CMD, AW9610X_SLEEP_MODE);
+}
+
+static const struct of_device_id aw9610x_dt_match[] = {
+	{ .compatible = "awinic,aw96103" },
+	{ .compatible = "awinic,aw96105" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aw9610x_dt_match);
+
+static const struct i2c_device_id aw9610x_i2c_id[] = {
+	{ "aw96103", 0 },
+	{ "aw96105", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, aw9610x_i2c_id);
+
+static struct i2c_driver aw9610x_i2c_driver = {
+	.driver = {
+		.name = "aw9610x_sensor",
+		.of_match_table = aw9610x_dt_match,
+	},
+	.probe = aw9610x_i2c_probe,
+	.remove = aw9610x_i2c_remove,
+	.shutdown = aw9610x_i2c_shutdown,
+	.id_table = aw9610x_i2c_id,
+};
+module_i2c_driver(aw9610x_i2c_driver);
+
+MODULE_AUTHOR("Wang Shuaijie <wangshuaijie@awinic.com>");
+MODULE_DESCRIPTION("Driver for Awinic AW9610X proximity sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/proximity/aw9610x.h b/drivers/iio/proximity/aw9610x.h
new file mode 100644
index 000000000000..38b3f36ebb7a
--- /dev/null
+++ b/drivers/iio/proximity/aw9610x.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _AW9610X_H_
+#define _AW9610X_H_
+
+#define AW9610X_CHANNEL_USED_MASK		0x1F
+#define AW_VCC_MIN_UV				1700000
+#define AW_VCC_MAX_UV				3600000
+#define AW_DATA_PROCESS_FACTOR			1024
+#define AW9610X_CPU_WORK_MASK			1
+#define AW9610X_CHIP_MIN_VOLTAGE		1600000
+#define AW_CHIP_AW9610XA			0x03000b00
+#define AW_READ_CHIPID_RETRIES			3
+#define AW_I2C_RETRIES				5
+#define USB_POWER_SUPPLY_NAME			"charger"
+#define AW9610X_AOT_MASK			0x3f
+#define AW9610X_AOT_BIT				8
+#define AW9610X_CHIP_ID				0xa961
+#define AW_CHIP_AW9610XA			0x03000b00
+#define AW9610X_CPU_WORK_MASK			1
+#define AW9610X_AOT_MASK			0x3f
+#define AW9610X_AOT_BIT				8
+#define REG_EEDA0				0x0408
+#define REG_EEDA1				0x040C
+#define AW9610X_BIN_VALID_DATA_OFFSET		64
+#define AW9610X_BIN_DATA_LEN_OFFSET		16
+#define AW9610X_BIN_DATA_REG_NUM_SIZE		4
+#define AW9610X_BIN_CHIP_TYPE_SIZE		8
+#define AW9610X_BIN_CHIP_TYPE_OFFSET		24
+#define AW9610X_BLFILT_CH_STEP			0x3C
+#define AW9610X_BLRSTRNG_MASK			0x3F
+#define AW9610X_CHIPID_MASK			GENMASK(31, 16)
+#define AW9610X_BLERRTRIG_MASK			BIT(25)
+
+#define AFE_BASE_ADDR				0x0000
+#define DSP_BASE_ADDR				0x0000
+#define STAT_BASE_ADDR				0x0000
+#define SFR_BASE_ADDR				0x0000
+#define DATA_BASE_ADDR				0x0000
+#define REG_SCANCTRL0				(0x0000 + AFE_BASE_ADDR)
+#define REG_AFECFG1_CH0				(0x0014 + AFE_BASE_ADDR)
+#define REG_FWVER				(0x0088 + STAT_BASE_ADDR)
+#define REG_WST					(0x008C + STAT_BASE_ADDR)
+#define REG_STAT0				(0x0090 + STAT_BASE_ADDR)
+#define REG_STAT1				(0x0094 + STAT_BASE_ADDR)
+#define REG_CHINTEN				(0x009C + STAT_BASE_ADDR)
+#define REG_BLFILT_CH0				(0x00A8 + DSP_BASE_ADDR)
+#define REG_BLRSTRNG_CH0			(0x00B4 + DSP_BASE_ADDR)
+#define REG_BLFILT_CH1				(0x00E4 + DSP_BASE_ADDR)
+#define REG_COMP_CH0				(0x0210 + DATA_BASE_ADDR)
+#define REG_BASELINE_CH0			(0x0228 + DATA_BASE_ADDR)
+#define REG_DIFF_CH0				(0x0240 + DATA_BASE_ADDR)
+#define REG_FWVER2				(0x0410 + DATA_BASE_ADDR)
+#define REG_CMD					(0xF008 + SFR_BASE_ADDR)
+#define REG_IRQSRC				(0xF080 + SFR_BASE_ADDR)
+#define REG_IRQEN				(0xF084 + SFR_BASE_ADDR)
+#define REG_OSCEN				(0xFF00 + SFR_BASE_ADDR)
+#define REG_RESET				(0xFF0C + SFR_BASE_ADDR)
+#define REG_CHIPID				(0xFF10 + SFR_BASE_ADDR)
+
+#define REG_NONE_ACCESS				0
+#define REG_RD_ACCESS				(1 << 0)
+#define REG_WR_ACCESS				(1 << 1)
+struct aw_reg_data {
+	unsigned char rw;
+	unsigned short reg;
+};
+
+/**
+ * struct aw_bin -
+ * @chip_type: Frame header information-chip type
+ * @valid_data_len: Length of valid data obtained after parsing
+ * @valid_data_addr: The offset address of the valid data obtained
+ *		after parsing relative to info
+ * @len: The size of the bin file obtained from the firmware
+ * @data: Store the bin file obtained from the firmware
+ */
+struct aw_bin {
+	unsigned char chip_type[8];
+	unsigned int valid_data_len;
+	unsigned int valid_data_addr;
+	unsigned int len;
+	unsigned char data[];
+};
+
+enum aw9610x_sar_vers {
+	AW9610X = 2,
+	AW9610XA = 6,
+	AW9610XB = 0xa,
+};
+
+enum aw9610x_operation_mode {
+	AW9610X_ACTIVE_MODE = 1,
+	AW9610X_SLEEP_MODE,
+	AW9610X_DEEPSLEEP_MODE,
+	AW9610XB_DEEPSLEEP_MODE,
+};
+
+enum aw9610x_channel {
+	AW_CHANNEL0,
+	AW_CHANNEL1,
+	AW_CHANNEL2,
+	AW_CHANNEL3,
+	AW_CHANNEL4,
+	AW_CHANNEL5,
+	AW_CHANNEL_MAX,
+};
+
+enum aw9610x_irq_trigger_position {
+	FAR,
+	TRIGGER_TH0,
+	TRIGGER_TH1 = 0x03,
+	TRIGGER_TH2 = 0x07,
+	TRIGGER_TH3 = 0x0f,
+};
+
+struct aw_channels_info {
+	bool used;
+	unsigned int last_channel_info;
+};
+
+struct aw9610x {
+	struct iio_dev *aw_iio_dev;
+	unsigned char vers;
+	unsigned int irq_status;
+	unsigned int hostirqen;
+	struct work_struct ps_notify_work;
+	struct notifier_block ps_notif;
+	bool ps_is_present;
+	struct delayed_work cfg_work;
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	struct device *dev;
+	struct aw_bin *aw_bin;
+	struct regulator *vcc;
+	struct aw_channels_info *channels_arr;
+	unsigned char chip_type[9];
+};
+
+#endif
+
-- 
2.45.1


