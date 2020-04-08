Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98C91A1D43
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDHIPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 04:15:52 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:41316 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHIPw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 04:15:52 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 04:15:50 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 73A3E200C81B;
        Wed,  8 Apr 2020 16:09:45 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TKxPGT4tbOR3; Wed,  8 Apr 2020 16:09:45 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 4DD4D200C7FA;
        Wed,  8 Apr 2020 16:09:45 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 415F4C01F8A;
        Wed,  8 Apr 2020 16:09:45 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 1658F201602; Wed,  8 Apr 2020 16:09:45 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: DAC extension for ltc2634-12/10/8
Date:   Wed,  8 Apr 2020 16:03:29 +0800
Message-Id: <20200408080338.11080-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add support for Analog Devices (Linear Technology)
LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
The SPI functionality based on them from LTC2632 therefor
add the definitions only and update the Kconfig.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/iio/dac/Kconfig   |  6 ++--
 drivers/iio/dac/ltc2632.c | 61 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 93744011b63f..e14c9b14c4de 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -279,12 +279,12 @@ config LTC1660
 	  module will be called ltc1660.
 
 config LTC2632
-	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
+	tristate "Linear Technology LTC2632,LTC2634,LTC2636-12/10/8 DAC spi driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Linear Technology
-	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
-	  LTC2636-8 converters (DAC).
+	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
+	  low 0-2.5V and high 0-4,096V range converters.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ltc2632.
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 7adc91056aa1..e939d7f81014 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -24,6 +24,7 @@
 /**
  * struct ltc2632_chip_info - chip specific information
  * @channels:		channel spec for the DAC
+ * @num_channels:	DAC channel count of the chip
  * @vref_mv:		internal reference voltage
  */
 struct ltc2632_chip_info {
@@ -53,6 +54,12 @@ enum ltc2632_supported_device_ids {
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
@@ -235,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
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
@@ -356,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
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
@@ -385,6 +428,24 @@ static const struct of_device_id ltc2632_of_match[] = {
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

