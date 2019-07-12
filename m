Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED366BE0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGLLxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 07:53:36 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:57474 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbfGLLxg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 07:53:36 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2E32BC29C5;
        Fri, 12 Jul 2019 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562932415; bh=2+9KBguyPdQ3tQ3958h9WzUSh/G7QD7dsIotfUq1+Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JNsH0Rvlzrnkv1QiHB3h3s5u5j6rk9ZQ+R2352pkLP8YslC3dnw7D9PnMyI8Jyqzd
         Q3VHfjFBtGREc645RzOFSbNbC6fBb6LBYKL7vzhizz0kFzwL1HE1/6qkv3F6wkJPD5
         wuDbGRaNx/QESw7d7T9O3I59SGyoEmrcQvhuePmN2oY7mYFQrM9inn6nYOQs/TSEBv
         X+aofIXhzoTS+r6rtifLIxCcJkYrActIDcUFsJWuTruF7uVSgbslRXxLxVwQcdRei2
         WysnDgocfbZdxMN7rS44PV4igxFHntNHS1G3mvTk4g85hXBltp4BUU6vNkiXsJROqt
         8q+iKA3WHqtGg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4ABD2A005E;
        Fri, 12 Jul 2019 11:53:33 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 228D33E586;
        Fri, 12 Jul 2019 13:53:33 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v4 1/3] regmap: add i3c bus support
Date:   Fri, 12 Jul 2019 13:53:28 +0200
Message-Id: <7deb1300474b68ebb6fc3ecb02577e4f657250a5.1562931742.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562931742.git.vitor.soares@synopsys.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1562931742.git.vitor.soares@synopsys.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add basic support for i3c bus.
This is a simple implementation that only give support
for SDR Read and Write commands.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/base/regmap/Kconfig      |  6 +++-
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/regmap-i3c.c | 60 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           | 20 ++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef4..c8bbf53 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_I3C)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	bool
 
@@ -49,3 +49,7 @@ config REGMAP_SOUNDWIRE
 config REGMAP_SCCB
 	tristate
 	depends on I2C
+
+config REGMAP_I3C
+	tristate
+	depends on I3C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index f5b4e88..ff6c7d8 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
 obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
 obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
+obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
new file mode 100644
index 0000000..1578fb5
--- /dev/null
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+
+#include <linux/regmap.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/module.h>
+
+static int regmap_i3c_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct i3c_device *i3c = dev_to_i3cdev(dev);
+	struct i3c_priv_xfer xfers[] = {
+		{
+			.rnw = false,
+			.len = count,
+			.data.out = data,
+		},
+	};
+
+	return i3c_device_do_priv_xfers(i3c, xfers, 1);
+}
+
+static int regmap_i3c_read(void *context,
+			   const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i3c_device *i3c = dev_to_i3cdev(dev);
+	struct i3c_priv_xfer xfers[2];
+
+	xfers[0].rnw = false;
+	xfers[0].len = reg_size;
+	xfers[0].data.out = reg;
+
+	xfers[1].rnw = true;
+	xfers[1].len = val_size;
+	xfers[1].data.in = val;
+
+	return i3c_device_do_priv_xfers(i3c, xfers, 2);
+}
+
+static struct regmap_bus regmap_i3c = {
+	.write = regmap_i3c_write,
+	.read = regmap_i3c_read,
+};
+
+struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
+{
+	return __devm_regmap_init(&i3c->dev, &regmap_i3c, &i3c->dev, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_i3c);
+
+MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
+MODULE_DESCRIPTION("Regmap I3C Module");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index daeec7d..f65984d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -25,6 +25,7 @@ struct module;
 struct clk;
 struct device;
 struct i2c_client;
+struct i3c_device;
 struct irq_domain;
 struct slim_device;
 struct spi_device;
@@ -624,6 +625,10 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
@@ -982,6 +987,21 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 #define devm_regmap_init_slimbus(slimbus, config)			\
 	__regmap_lockdep_wrapper(__devm_regmap_init_slimbus, #config,	\
 				slimbus, config)
+
+/**
+ * devm_regmap_init_i3c() - Initialise managed register map
+ *
+ * @i3c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_i3c(i3c, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_i3c, #config,	\
+				i3c, config)
+
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.7.4

