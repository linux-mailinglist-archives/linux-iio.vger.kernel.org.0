Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C943DEAA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJ1KVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhJ1KV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000FC061348;
        Thu, 28 Oct 2021 03:19:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f8so1065806edy.4;
        Thu, 28 Oct 2021 03:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IYMJ1SQ6lQ2KjlKECGxmF550jn3k3LZot5Yu269+eIE=;
        b=mYF5eSnNAmgjPPLmAoSdkkqCtsVQrQz1pC53sT5kI6IyuGQsLRa2Y48HFnv5VEhRx9
         E4iZSvajO7dEmKRhGZIaY6zuuWRh+SNK5wEr/DwBOUdf3/c3LRutxLotpX/J0b7ghmJz
         Ed4rtORX8AV/YHa8m3GD2t1cTMtiVvtS4sRcNI9n/9pH0cZVr/5G46tes/8JvvQkG8vU
         DrRHPTXePUSTTliKYUoHWKTrr1uuo+x/aCRiU0KVzTlGn3w744C8e5w4pE5xcBB3MTLH
         yUuVTeGmM7x26QRfq1cdwYN6dGPkOY/bP18MGzP91ULoz56jvaI+o9bRrOLGRNWljxkC
         VRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IYMJ1SQ6lQ2KjlKECGxmF550jn3k3LZot5Yu269+eIE=;
        b=r4YTMB/iQmMc+V+cWSvqikZeOGqZh9+syaUH5hz7X/ySUJjdyNihWlq8hzBXoKuQUA
         LktyGXeLvVKawvQN/o72lFgXkSlO6CaTWygYxbkSAKcbA5lebtCXHaKt8IAlY82WKdNn
         la4NMuJuJ4cKXG8VwZLlDc7KdDqJpqKFQu3gdERnXpesv8xbgCDr00jO3HZ/dkzyXMZn
         BijmVQz0d3+wFyKoXSJhWXGTUiAUAxZ1IrbiU3XrQwQHmwxLoRJtizVQDbdcT+rFBCcu
         VRy9VAQH7hcwPMVV4UoHnruvP2On1RSeMkH538FuaZmMMHwe0aTlZDNKeR4jynqgreUv
         9w7A==
X-Gm-Message-State: AOAM533m2EGFFAo4jv+G31MBqM9683PNU3JsDQcAw0UYon+tLA5gVtD+
        hTHv2GB5ZOCJhmfnVdmPapI=
X-Google-Smtp-Source: ABdhPJxTBGUkKJxxYEJLEI/FuwF4nr1/VUJLtN9+4uYdGeitlhI5Hx2avR/Hy5jx4/XPzt6+rM0Nuw==
X-Received: by 2002:a17:906:6952:: with SMTP id c18mr4270935ejs.31.1635416338808;
        Thu, 28 Oct 2021 03:18:58 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:58 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 10/10] iio: imu: add BNO055 I2C driver
Date:   Thu, 28 Oct 2021 12:18:40 +0200
Message-Id: <20211028101840.24632-11-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
and it enables the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig      |  6 ++++
 drivers/iio/imu/bno055/Makefile     |  1 +
 drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index 941e43f0368d..87200787d548 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
 	tristate "Bosh BNO055 attached via serial bus"
 	depends on SERIAL_DEV_BUS
 	select BOSH_BNO055_IIO
+
+config BOSH_BNO055_I2C
+	tristate "Bosh BNO055 attached via I2C bus"
+	depends on I2C
+	select REGMAP_I2C
+	select BOSH_BNO055_IIO
diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
index 7285ade2f4b9..eaf24018cb28 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_BOSH_BNO055_IIO) += bno055.o
 obj-$(CONFIG_BOSH_BNO055_SERIAL) += bno055_sl.o
+obj-$(CONFIG_BOSH_BNO055_I2C) += bno055_i2c.o
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
new file mode 100644
index 000000000000..eea0daa6a61d
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C interface for Bosh BNO055 IMU.
+ * This file implements I2C communication up to the register read/write
+ * level.
+ *
+ * Copyright (C) 2021 Istituto Italiano di Tecnologia
+ * Electronic Design Laboratory
+ * Written by Andrea Merello <andrea.merello@iit.it>
+ */
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+
+#include "bno055.h"
+
+#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
+
+static int bno055_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap =
+		devm_regmap_init_i2c(client, &bno055_regmap_config);
+
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Unable to init register map");
+		return PTR_ERR(regmap);
+	}
+
+	return bno055_probe(&client->dev, regmap,
+			    BNO055_I2C_XFER_BURST_BREAK_THRESHOLD);
+
+	return 0;
+}
+
+static const struct i2c_device_id bno055_i2c_id[] = {
+	{"bno055", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
+
+static struct i2c_driver bno055_driver = {
+	.driver = {
+		.name = "bno055-i2c",
+	},
+	.probe = bno055_i2c_probe,
+	.id_table = bno055_i2c_id
+};
+module_i2c_driver(bno055_driver);
+
+MODULE_AUTHOR("Andrea Merello");
+MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

