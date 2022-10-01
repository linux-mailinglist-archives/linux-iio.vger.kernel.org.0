Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671EC5F2045
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 00:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJAWN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Oct 2022 18:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJAWN4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2022 18:13:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725985BC1A
        for <linux-iio@vger.kernel.org>; Sat,  1 Oct 2022 15:13:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m15so10103939edb.13
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2022 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3RFFcsnpGs0EiuIVTpq1Vjulzur8ZgEa9iJr7+vP0R0=;
        b=Gm+nOWSlE2+N0c9Glv6CZMuvqi0AiEPMI8rNkpuc4lAsJeUKw9widwj8rdD9rEwBt0
         vbmQjWfz2P6F188yCTAiNUF4mphAZ208qIgH/YJHoYbxfQ5OPXbR6kBZXm/hB4vWX0sC
         BaQafaEI87ZkSE6bjf5DxgDfqP7d0KIUJ6q1J8vBR9BY7NiVOXB1nT7opr54LUSJjExS
         zxDNRMPfEoG8rmLUBC53qOm8NP97Bp5gSYBQgsSs9WrcBBSTTZQFgZTq/aDsoaHe+Obn
         evUMfQ8jrRtSVVFS6VsjkJ85mmioUMc76+HzXvSJeN9D4lhR9HQQ74RuEdCVZzngyGKP
         f69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3RFFcsnpGs0EiuIVTpq1Vjulzur8ZgEa9iJr7+vP0R0=;
        b=GX4ZK97nNAQAnLNgqtcE1patqiS+BCJuj9nOjBEuE77Ku+Qt6eDmpyXYM86h0LBwi8
         LuKw66EQFNHf316jYlSK5wTD2+iKq9S6HJuk1RVbtfF9RbNbLZmtSvgkd3HDzpQ8nc5Z
         CgAu5JdMGOLgyUM+7nstqFxSTEz3IQKHEKp8DdvXVV9GtoF30zaJZcyyrzgZalI5zbDR
         3Y9ssnmBOu/eAXz9nc3iD01JjdDyZ+QBh+EHlUPxiplG6gYQwTBucz9pTyhRIVNz9VzU
         Gds4VdC4jCG3qeq0rCNg+3SyrA0sTKXWMo0szPFRQf9mBQu8aK2+IsJoDvROCOhmetit
         ABfA==
X-Gm-Message-State: ACrzQf3fFYHacEKs3SY8oK6wRq9ntRPQnFRvKtQ9K/wtEl6CQ3sEMzBT
        T0uRkxPhFO5czEmNN21zxSCCVw==
X-Google-Smtp-Source: AMsMyM7NfDa8q7kyiVu8PcRPY/TmnHv3M3UqoDzZQ8MWR4Mn4q6HGfwZpns5ebYpDL8xlnFAN1iJ/Q==
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id w16-20020a056402269000b004523a858b28mr12650262edd.158.1664662431963;
        Sat, 01 Oct 2022 15:13:51 -0700 (PDT)
Received: from localhost.localdomain ([95.236.236.71])
        by smtp.gmail.com with ESMTPSA id m16-20020a50d7d0000000b00457e20cb2e4sm4198307edj.48.2022.10.01.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 15:13:51 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     william.gray@linaro.org
Cc:     linux-iio@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH resend] iio: dac: add support for max5522
Date:   Sun,  2 Oct 2022 00:12:25 +0200
Message-Id: <20221001221225.668378-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial support for dac max5522.

Tested writing DAC A and B with some values,
from 0 to 1023, measured output voltages, driver works properly.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/iio/dac/Kconfig   |  13 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/max5522.c | 246 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 drivers/iio/dac/max5522.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80521bd28d0f..262688b5e39f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -357,6 +357,19 @@ config MAX517
 	  This driver can also be built as a module.  If so, the module
 	  will be called max517.
 
+config MAX5522
+	tristate "Maxim MAX5522 DAC driver"
+	depends on SPI
+	select REGMAP_SPI if SPI_MASTER
+	help
+	  Say Y here if you want to build a driver for the Maxinm MAX5522.
+
+	  MAX5522 is a dual, ultra-low-power, 10-Bit, voltage-output
+	  digital to analog converter (DAC) offering rail-to-rail buffered
+	  voltage outputs.
+
+	  If compiled as a module, it will be called max5522.
+
 config MAX5821
 	tristate "Maxim MAX5821 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index ec3e42713f00..6c74fea21736 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_LTC2632) += ltc2632.o
 obj-$(CONFIG_LTC2688) += ltc2688.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
+obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
new file mode 100644
index 000000000000..aa4098a1d68c
--- /dev/null
+++ b/drivers/iio/dac/max5522.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Maxim MAX5522
+ * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
+ *
+ * Copyright 2022 Timesys Corp.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define MAX5522_MAX_ADDR	15
+#define MAX5522_CTRL_NONE	0
+#define MAX5522_CTRL_LOAD_IN_A	9
+#define MAX5522_CTRL_LOAD_IN_B	10
+
+#define MAX5522_REG_DATA(x)	(x + MAX5522_CTRL_LOAD_IN_A)
+
+struct max5522_chip_info {
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+struct max5522_state {
+	struct regmap *regmap;
+	const struct max5522_chip_info *chip_info;
+	unsigned short dac_cache[2];
+	unsigned int vrefin_mv;
+	struct regulator *vrefin_reg;
+};
+
+#define MAX5522_CHANNEL(chan) {	\
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = chan, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.shift = 2, \
+	} \
+}
+
+const struct iio_chan_spec max5522_channels[] = {
+	MAX5522_CHANNEL(0),
+	MAX5522_CHANNEL(1),
+};
+
+enum max5522_type {
+	ID_MAX5522,
+};
+
+static const struct max5522_chip_info max5522_chip_info_tbl[] = {
+	[ID_MAX5522] = {
+		.channels = max5522_channels,
+		.num_channels = 2,
+	},
+};
+
+static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
+{
+	return MAX5522_REG_DATA(chan->channel);
+}
+
+static int max5522_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+{
+	struct max5522_state *state = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		*val = state->dac_cache[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = state->vrefin_mv;
+		*val2 = 10;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int max5522_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long info)
+{
+	struct max5522_state *state = iio_priv(indio_dev);
+	int rval;
+
+	if (val > 1023 || val < 0)
+		return -EINVAL;
+
+	rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
+				val << chan->scan_type.shift);
+	if (rval < 0)
+		return rval;
+
+	state->dac_cache[chan->channel] = val;
+
+	return 0;
+}
+
+static const struct iio_info max5522_info = {
+	.read_raw = max5522_read_raw,
+	.write_raw = max5522_write_raw,
+};
+
+static void max5522_remove(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	iio_device_unregister(indio_dev);
+	kfree(indio_dev->channels);
+}
+
+static const struct regmap_config max5522_regmap_config = {
+	.reg_bits = 4,
+	.val_bits = 12,
+	.max_register = MAX5522_MAX_ADDR,
+};
+
+static int max5522_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct iio_dev *indio_dev;
+	struct max5522_state *state;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
+	if (indio_dev == NULL) {
+		dev_err(&spi->dev, "failed to allocate iio device\n");
+		return  -ENOMEM;
+	}
+
+	state = iio_priv(indio_dev);
+	state->chip_info = &max5522_chip_info_tbl[id->driver_data];
+
+	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
+	if (IS_ERR(state->vrefin_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
+				     "Vrefin regulator not specified\n");
+
+	ret = regulator_get_voltage(state->vrefin_reg);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to read vrefin regulator: %d\n",
+				ret);
+		goto error_disable_vrefin_reg;
+	}
+	state->vrefin_mv = ret / 1000;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
+
+	if (IS_ERR(state->regmap))
+		return PTR_ERR(state->regmap);
+
+	dev_info(&spi->dev, "iio dac ready");
+
+	indio_dev->info = &max5522_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max5522_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
+	indio_dev->name = id->name;
+
+	return iio_device_register(indio_dev);
+
+error_disable_vrefin_reg:
+	regulator_disable(state->vrefin_reg);
+
+	return ret;
+}
+
+static void max5522_spi_remove(struct spi_device *spi)
+{
+	max5522_remove(&spi->dev);
+}
+
+static const struct spi_device_id max5522_ids[] = {
+	{ "max5522", ID_MAX5522 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5360_ids);
+
+
+static const struct of_device_id max5522_of_match[] = {
+	{ .compatible = "maxim,max5522", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, max5522_of_match);
+
+static struct spi_driver max5522_spi_driver = {
+	.driver = {
+		   .name = "max5522",
+		   .of_match_table = max5522_of_match,
+	},
+	.probe = max5522_spi_probe,
+	.remove = max5522_spi_remove,
+	.id_table = max5522_ids,
+};
+
+static inline int max5522_spi_register_driver(void)
+{
+	return spi_register_driver(&max5522_spi_driver);
+}
+
+static inline void max5522_spi_unregister_driver(void)
+{
+	spi_unregister_driver(&max5522_spi_driver);
+}
+
+static int __init max5522_spi_init(void)
+{
+	int ret;
+
+	ret = max5522_spi_register_driver();
+	if (ret)
+		return ret;
+
+	return 0;
+}
+module_init(max5522_spi_init);
+
+static void __exit max5522_spi_exit(void)
+{
+	max5522_spi_unregister_driver();
+}
+module_exit(max5522_spi_exit);
+
+MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com");
+MODULE_DESCRIPTION("MAX5522 DAC driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

