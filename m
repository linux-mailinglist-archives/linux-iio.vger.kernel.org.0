Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA75D6AABFF
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCDTAk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 14:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDTAj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 14:00:39 -0500
Received: from mail-108-mta189.mxroute.com (mail-108-mta189.mxroute.com [136.175.108.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836315557
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 11:00:31 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta189.mxroute.com (ZoneMTA) with ESMTPSA id 186adff39ef000edb4.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sat, 04 Mar 2023 19:00:30 +0000
X-Zone-Loop: 839728164d93a811681014026bfb4894f8809995a265
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mf2banUGtz1KGBc038cdCYaGIqOHTiHOxDw/OK4O/WY=; b=ywCZJ9v2FfXt57AvDeHRAxpkLd
        ylsTA76vgwaDFADXlox8xXkPs/pcKOrNtJgRYK4mgyP6CWFQ/0SmExyD3LJzvyk6Tm61Q+/cF/seq
        y/KLqbsszZr/IKA6XC86JxL5FMZ+e4ezcMxWQNIYRCmQiboTId4tOU/pqwDqhYWAnaOrqJZJ9FW8C
        f8iEdDAYb1CFHHqmLEeIlib0goXl5PZMqBv2OPmWpzequAk+fD5qF5COsw/IfmS6hzGA81ABM8U3a
        yplHsQk/MALSS6F73X5RheyISXKnH/vn6YanO6+w1hlsuy7I/4zZQLBrl67qwVLohQOiDLj0EclYX
        fvqPXiuA==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH v4 2/2] iio: temperature: Add MCP9600 thermocouple EMF converter driver
Date:   Sat,  4 Mar 2023 10:59:54 -0800
Message-Id: <20230304185954.1492-2-andrew.hepp@ahepp.dev>
In-Reply-To: <20230304185954.1492-1-andrew.hepp@ahepp.dev>
References: <20230304185954.1492-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple EMF converter.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
---
Changes for v4:
- none
Changes for v3:
- none
Changes for v2:
- remove unused sysfs include
- remove unused scan fields from channel
- warn rather than fail when probing unknown device
- register device through devm
- clean up style and prints
---
 drivers/iio/temperature/Kconfig   |  10 ++
 drivers/iio/temperature/Makefile  |   1 +
 drivers/iio/temperature/mcp9600.c | 146 ++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/iio/temperature/mcp9600.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index ed384f33e0c7..ea2ce364b2e9 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -158,4 +158,14 @@ config MAX31865
 	  This driver can also be build as a module. If so, the module
 	  will be called max31865.
 
+config MCP9600
+	tristate "MCP9600 thermocouple EMF converter"
+	depends on I2C
+	help
+	  If you say yes here you get support for MCP9600
+	  thermocouple EMF converter connected via I2C.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called mcp9600.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index dfec8c6d3019..9330d4a39598 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MAX30208) += max30208.o
 obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MAX31865) += max31865.o
+obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
new file mode 100644
index 000000000000..d938e09632cf
--- /dev/null
+++ b/drivers/iio/temperature/mcp9600.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mcp9600.c - Support for Microchip MCP9600 thermocouple EMF converter
+ *
+ * Copyright (c) 2022 Andrew Hepp
+ * Author: <andrew.hepp@ahepp.dev>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+/* MCP9600 registers */
+#define MCP9600_HOT_JUNCTION 0x0
+#define MCP9600_COLD_JUNCTION 0x2
+#define MCP9600_DEVICE_ID 0x20
+
+/* MCP9600 device id value */
+#define MCP9600_DEVICE_ID_MCP9600 0x40
+
+static const struct iio_chan_spec mcp9600_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = MCP9600_HOT_JUNCTION,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.address = MCP9600_COLD_JUNCTION,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.modified = 1,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+struct mcp9600_data {
+	struct i2c_client *client;
+	struct mutex read_lock; /* lock to prevent concurrent reads */
+};
+
+static int mcp9600_read(struct mcp9600_data *data,
+			struct iio_chan_spec const *chan, int *val)
+{
+	__be16 buf;
+	int ret;
+
+	mutex_lock(&data->read_lock);
+	ret = i2c_smbus_read_i2c_block_data(data->client, chan->address, 2,
+					    (u8 *)&buf);
+	mutex_unlock(&data->read_lock);
+
+	if (ret < 0)
+		return ret;
+	*val = be16_to_cpu(buf);
+
+	return 0;
+}
+
+static int mcp9600_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mcp9600_read(data, chan, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 62;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcp9600_info = {
+	.read_raw = mcp9600_read_raw,
+};
+
+static int mcp9600_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct mcp9600_data *data;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
+	if (ret < 0)
+		return ret;
+	if (ret != MCP9600_DEVICE_ID_MCP9600)
+		dev_warn(&client->dev, "Expected ID %x, got %x\n",
+				MCP9600_DEVICE_ID_MCP9600, ret);
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->read_lock);
+
+	indio_dev->info = &mcp9600_info;
+	indio_dev->name = "mcp9600";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mcp9600_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id mcp9600_id[] = {
+	{ "mcp9600" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp9600_id);
+
+static const struct of_device_id mcp9600_of_match[] = {
+	{ .compatible = "microchip,mcp9600" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mcp9600_of_match);
+
+static struct i2c_driver mcp9600_driver = {
+	.driver = {
+		.name = "mcp9600",
+		.of_match_table = mcp9600_of_match,
+	},
+	.probe_new = mcp9600_probe,
+	.id_table = mcp9600_id
+};
+module_i2c_driver(mcp9600_driver);
+
+MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
+MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

