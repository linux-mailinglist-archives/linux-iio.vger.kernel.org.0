Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF167892A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjAWVFM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjAWVFA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:05:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C836093;
        Mon, 23 Jan 2023 13:04:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FFBBCE177D;
        Mon, 23 Jan 2023 21:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF14EC4339E;
        Mon, 23 Jan 2023 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507884;
        bh=5f/C5c9JIAXP9r2odmuD9frv/a6t3JXMKM+BDL0WCQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDKMkyjl9muAGLuIgDylGmpiRaWSqDwtjliBAKrhlqHcgYc+wCNtdBFqE+qKwobmJ
         OQ7ZVAF/gv6XnBN1io1JPDQz2RCY2wXgTyiT8WGoB7XJilVYU8/SwVqt0aNQorBnpF
         liB3/M7H4JllPYiR1FEaBAtUIoQM3Z13mHNK/PGNK/j06ruDZz9lMHBw6DzrqTUpoP
         mZij+fqZAUVOpo0nt6Nbg+46GngKJOTA5vI/jCHV0TcCUK26yvU5oIqmp+XlWJHd8t
         SLA6tI+MB6TNGXBKB8YcqCafTm5W0bIfqnSpiP2jpCV3vTSv4qNr/zzGkKhXrJf6oh
         0kXj5ES/ILj2w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 11/12] staging: iio: accel: adis16203: Move out of staging
Date:   Mon, 23 Jan 2023 21:17:57 +0000
Message-Id: <20230123211758.563383-12-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123211758.563383-1-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The main blocker of this driver moving previously was non standard
ABI for the 180 degree offset channel. Now support for that channel
has been dropped, this simple driver can move out of staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/Kconfig                   | 12 ++++++++++++
 drivers/iio/accel/Makefile                  |  1 +
 drivers/{staging => }/iio/accel/adis16203.c |  0
 drivers/staging/iio/accel/Kconfig           | 12 ------------
 drivers/staging/iio/accel/Makefile          |  1 -
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b6b45d359f28..88d4b18bd5e8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -18,6 +18,18 @@ config ADIS16201
 	  To compile this driver as a module, say M here: the module will
 	  be called adis16201.
 
+config ADIS16203
+	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16203 Programmable
+	  360 Degrees Inclinometer.
+
+	  To compile this driver as a module, say M here: the module will be
+	  called adis16203.
+
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 311ead9c3ef1..b6f0cee52659 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
+obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL313) += adxl313_core.o
 obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/iio/accel/adis16203.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16203.c
rename to drivers/iio/accel/adis16203.c
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 3318997a7009..3769af8719f3 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -4,18 +4,6 @@
 #
 menu "Accelerometers"
 
-config ADIS16203
-	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16203 Programmable
-	  360 Degrees Inclinometer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16203.
-
 config ADIS16240
 	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 094cc9be35bd..b0beec471814 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -3,5 +3,4 @@
 # Makefile for industrial I/O accelerometer drivers
 #
 
-obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
-- 
2.39.1

