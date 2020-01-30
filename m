Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45514DB62
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgA3NQG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 08:16:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3NQG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 08:16:06 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fp-0000Wb-TJ; Thu, 30 Jan 2020 14:15:57 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fo-0000Lo-An; Thu, 30 Jan 2020 14:15:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: [PATCH 3/3] iio: dac: ltc2632: add support for LTC2636 family
Date:   Thu, 30 Jan 2020 14:15:49 +0100
Message-Id: <20200130131549.1170-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only difference between LTC2632 and LTC2636 is that the former has
two DAC channels while the latter has eight.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/dac/Kconfig   |  5 ++-
 drivers/iio/dac/ltc2632.c | 77 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cc42219a64f7..33a35ebe4fed 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -132,11 +132,12 @@ config LTC1660
 	  module will be called ltc1660.
 
 config LTC2632
-	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
+	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Linear Technology
-	  LTC2632-12, LTC2632-10, LTC2632-8 converters (DAC).
+	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
+	  LTC2636-8 converters (DAC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ltc2632.
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 7ab92e178496..1e7ffa0f6071 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -12,8 +12,6 @@
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
-#define LTC2632_DAC_CHANNELS                    2
-
 #define LTC2632_ADDR_DAC0                       0x0
 #define LTC2632_ADDR_DAC1                       0x1
 
@@ -33,6 +31,7 @@
  */
 struct ltc2632_chip_info {
 	const struct iio_chan_spec *channels;
+	const size_t num_channels;
 	const int vref_mv;
 };
 
@@ -57,6 +56,12 @@ enum ltc2632_supported_device_ids {
 	ID_LTC2632H12,
 	ID_LTC2632H10,
 	ID_LTC2632H8,
+	ID_LTC2636L12,
+	ID_LTC2636L10,
+	ID_LTC2636L8,
+	ID_LTC2636H12,
+	ID_LTC2636H10,
+	ID_LTC2636H8,
 };
 
 static int ltc2632_spi_write(struct spi_device *spi,
@@ -190,6 +195,12 @@ static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
 	const struct iio_chan_spec _name ## _channels[] = { \
 		LTC2632_CHANNEL(0, _bits), \
 		LTC2632_CHANNEL(1, _bits), \
+		LTC2632_CHANNEL(2, _bits), \
+		LTC2632_CHANNEL(3, _bits), \
+		LTC2632_CHANNEL(4, _bits), \
+		LTC2632_CHANNEL(5, _bits), \
+		LTC2632_CHANNEL(6, _bits), \
+		LTC2632_CHANNEL(7, _bits), \
 	}
 
 static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
@@ -199,26 +210,62 @@ static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
 static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
 	[ID_LTC2632L12] = {
 		.channels	= ltc2632x12_channels,
+		.num_channels	= 2,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632L10] = {
 		.channels	= ltc2632x10_channels,
+		.num_channels	= 2,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632L8] =  {
 		.channels	= ltc2632x8_channels,
+		.num_channels	= 2,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632H12] = {
 		.channels	= ltc2632x12_channels,
+		.num_channels	= 2,
 		.vref_mv	= 4096,
 	},
 	[ID_LTC2632H10] = {
 		.channels	= ltc2632x10_channels,
+		.num_channels	= 2,
 		.vref_mv	= 4096,
 	},
 	[ID_LTC2632H8] =  {
 		.channels	= ltc2632x8_channels,
+		.num_channels	= 2,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2636L12] = {
+		.channels	= ltc2632x12_channels,
+		.num_channels	= 8,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2636L10] = {
+		.channels	= ltc2632x10_channels,
+		.num_channels	= 8,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2636L8] =  {
+		.channels	= ltc2632x8_channels,
+		.num_channels	= 8,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2636H12] = {
+		.channels	= ltc2632x12_channels,
+		.num_channels	= 8,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2636H10] = {
+		.channels	= ltc2632x10_channels,
+		.num_channels	= 8,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2636H8] =  {
+		.channels	= ltc2632x8_channels,
+		.num_channels	= 8,
 		.vref_mv	= 4096,
 	},
 };
@@ -287,7 +334,7 @@ static int ltc2632_probe(struct spi_device *spi)
 	indio_dev->info = &ltc2632_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = chip_info->channels;
-	indio_dev->num_channels = LTC2632_DAC_CHANNELS;
+	indio_dev->num_channels = chip_info->num_channels;
 
 	return iio_device_register(indio_dev);
 }
@@ -312,6 +359,12 @@ static const struct spi_device_id ltc2632_id[] = {
 	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
 	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
 	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
+	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
+	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
+	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },
+	{ "ltc2636-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12] },
+	{ "ltc2636-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10] },
+	{ "ltc2636-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8] },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
@@ -335,6 +388,24 @@ static const struct of_device_id ltc2632_of_match[] = {
 	}, {
 		.compatible = "lltc,ltc2632-h8",
 		.data = &ltc2632_chip_info_tbl[ID_LTC2632H8]
+	}, {
+		.compatible = "lltc,ltc2636-l12",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636L12]
+	}, {
+		.compatible = "lltc,ltc2636-l10",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636L10]
+	}, {
+		.compatible = "lltc,ltc2636-l8",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636L8]
+	}, {
+		.compatible = "lltc,ltc2636-h12",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636H12]
+	}, {
+		.compatible = "lltc,ltc2636-h10",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636H10]
+	}, {
+		.compatible = "lltc,ltc2636-h8",
+		.data = &ltc2632_chip_info_tbl[ID_LTC2636H8]
 	},
 	{}
 };
-- 
2.25.0

