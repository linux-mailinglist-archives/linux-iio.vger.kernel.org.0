Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAED1A8F61
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 01:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgDNX4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 19:56:47 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51118 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2634489AbgDNX4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 19:56:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 84AA7200D9F0;
        Wed, 15 Apr 2020 07:56:40 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id crTPwlyphtoU; Wed, 15 Apr 2020 07:56:40 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 6B452200D9EE;
        Wed, 15 Apr 2020 07:56:40 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 6666AC019EC;
        Wed, 15 Apr 2020 07:56:40 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 60636201602; Wed, 15 Apr 2020 07:56:40 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     chris.ruehl@gtsys.com.hk
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: DAC extension for ltc2634-12/10/8
Date:   Wed, 15 Apr 2020 07:56:03 +0800
Message-Id: <20200414235609.20125-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
References: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add support for Analog Devices (Linear Technology)
LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
The SPI functionality based on them from LTC2632 therefor
add the definitions only and update the Kconfig.

V2:
Send the documentation fix in a extra patch
Kconfig simplify the driver description, details to the help text
ltc2632.txt add to this patch-set (prepare to convert to yaml)

V3:
Consistens decimal separator in help text

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 .../devicetree/bindings/iio/dac/ltc2632.txt   |  8 ++-
 drivers/iio/dac/Kconfig                       |  6 +-
 drivers/iio/dac/ltc2632.c                     | 60 +++++++++++++++++++
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
index 338c3220f01a..1ab9570cf219 100644
--- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
@@ -1,4 +1,4 @@
-Linear Technology LTC2632/2636 DAC
+Linear Technology LTC2632/2634/2636 DAC
 
 Required properties:
  - compatible: Has to contain one of the following:
@@ -8,6 +8,12 @@ Required properties:
 	lltc,ltc2632-h12
 	lltc,ltc2632-h10
 	lltc,ltc2632-h8
+	lltc,ltc2634-l12
+	lltc,ltc2634-l10
+	lltc,ltc2634-l8
+	lltc,ltc2634-h12
+	lltc,ltc2634-h10
+	lltc,ltc2634-h8
 	lltc,ltc2636-l12
 	lltc,ltc2636-l10
 	lltc,ltc2636-l8
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 93744011b63f..aee13ced6ddf 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -279,12 +279,12 @@ config LTC1660
 	  module will be called ltc1660.
 
 config LTC2632
-	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
+	tristate "Linear Technology LTC2632-12/10/8 and similar DAC spi driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Linear Technology
-	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
-	  LTC2636-8 converters (DAC).
+	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
+	  low 0-2.5V and high 0-4.096V range converters.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ltc2632.
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 2a84ea654645..e939d7f81014 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -54,6 +54,12 @@ enum ltc2632_supported_device_ids {
 	ID_LTC2632H12,
 	ID_LTC2632H10,
 	ID_LTC2632H8,
+	ID_LTC2634L12,
+	ID_LTC2634L10,
+	ID_LTC2634L8,
+	ID_LTC2634H12,
+	ID_LTC2634H10,
+	ID_LTC2634H8,
 	ID_LTC2636L12,
 	ID_LTC2636L10,
 	ID_LTC2636L8,
@@ -236,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
 		.num_channels	= 2,
 		.vref_mv	= 4096,
 	},
+	[ID_LTC2634L12] = {
+		.channels	= ltc2632x12_channels,
+		.num_channels	= 4,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2634L10] = {
+		.channels	= ltc2632x10_channels,
+		.num_channels	= 4,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2634L8] =  {
+		.channels	= ltc2632x8_channels,
+		.num_channels	= 4,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2634H12] = {
+		.channels	= ltc2632x12_channels,
+		.num_channels	= 4,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2634H10] = {
+		.channels	= ltc2632x10_channels,
+		.num_channels	= 4,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2634H8] =  {
+		.channels	= ltc2632x8_channels,
+		.num_channels	= 4,
+		.vref_mv	= 4096,
+	},
 	[ID_LTC2636L12] = {
 		.channels	= ltc2632x12_channels,
 		.num_channels	= 8,
@@ -357,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
 	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
 	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
 	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
+	{ "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L12] },
+	{ "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L10] },
+	{ "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8] },
+	{ "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H12] },
+	{ "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H10] },
+	{ "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8] },
 	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
 	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
 	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },
@@ -386,6 +428,24 @@ static const struct of_device_id ltc2632_of_match[] = {
 	}, {
 		.compatible = "lltc,ltc2632-h8",
 		.data = &ltc2632_chip_info_tbl[ID_LTC2632H8]
+	}, {
+		.compatible = "lltc,ltc2634-l12",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634L12]
+	}, {
+		.compatible = "lltc,ltc2634-l10",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634L10]
+	}, {
+		.compatible = "lltc,ltc2634-l8",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634L8]
+	}, {
+		.compatible = "lltc,ltc2634-h12",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634H12]
+	}, {
+		.compatible = "lltc,ltc2634-h10",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634H10]
+	}, {
+		.compatible = "lltc,ltc2634-h8",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2634H8]
 	}, {
 		.compatible = "lltc,ltc2636-l12",
 		.data = &ltc2632_chip_info_tbl[ID_LTC2636L12]
-- 
2.20.1

