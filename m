Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55659C8896
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfJBMah (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 08:30:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38115 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:30:37 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B0A44E001B;
        Wed,  2 Oct 2019 12:30:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5/7] iio: adc: max1027: Introduce 12-bit devices support
Date:   Wed,  2 Oct 2019 14:30:23 +0200
Message-Id: <20191002123025.21413-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002123025.21413-1-miquel.raynal@bootlin.com>
References: <20191002123025.21413-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Maxim's max12xx series is very similar to the max10xx series, with the
difference of the measurements depth which is upgraded from 10 to 12
bits per channel. Everything else looks the same.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/Kconfig   |  4 ++--
 drivers/iio/adc/max1027.c | 41 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f0af3a42f53c..6ac16d738822 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -508,8 +508,8 @@ config MAX1027
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for Maxim SPI ADC models
-	  max1027, max1029 and max1031.
+	  Say yes here to build support for Maxim SPI {10,12}-bit ADC models:
+	  max1027, max1029, max1031, max1227, max1229 and max1231.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1027.
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index fc75764a6fd7..0d7116e9a63b 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -63,12 +63,18 @@ enum max1027_id {
 	max1027,
 	max1029,
 	max1031,
+	max1227,
+	max1229,
+	max1231,
 };
 
 static const struct spi_device_id max1027_id[] = {
 	{"max1027", max1027},
 	{"max1029", max1029},
 	{"max1031", max1031},
+	{"max1227", max1227},
+	{"max1229", max1229},
+	{"max1231", max1231},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, max1027_id);
@@ -156,6 +162,21 @@ static const struct iio_chan_spec max1031_channels[] = {
 	MAX1X31_CHANNELS(10)
 };
 
+static const struct iio_chan_spec max1227_channels[] = {
+	MAX1X27_CHANNELS(12)
+};
+
+static const struct iio_chan_spec max1229_channels[] = {
+	MAX1X27_CHANNELS(12),
+	MAX1X29_CHANNELS(12)
+};
+
+static const struct iio_chan_spec max1231_channels[] = {
+	MAX1X27_CHANNELS(12),
+	MAX1X29_CHANNELS(12),
+	MAX1X31_CHANNELS(12)
+};
+
 static const unsigned long max1027_available_scan_masks[] = {
 	0x000001ff,
 	0x00000000,
@@ -197,6 +218,24 @@ static const struct max1027_chip_info max1027_chip_info_tbl[] = {
 		.depth = 10,
 		.available_scan_masks = max1031_available_scan_masks,
 	},
+	[max1227] = {
+		.channels = max1227_channels,
+		.num_channels = ARRAY_SIZE(max1227_channels),
+		.depth = 12,
+		.available_scan_masks = max1027_available_scan_masks,
+	},
+	[max1229] = {
+		.channels = max1229_channels,
+		.num_channels = ARRAY_SIZE(max1229_channels),
+		.depth = 12,
+		.available_scan_masks = max1029_available_scan_masks,
+	},
+	[max1231] = {
+		.channels = max1231_channels,
+		.num_channels = ARRAY_SIZE(max1231_channels),
+		.depth = 12,
+		.available_scan_masks = max1031_available_scan_masks,
+	},
 };
 
 struct max1027_state {
@@ -493,5 +532,5 @@ static struct spi_driver max1027_driver = {
 module_spi_driver(max1027_driver);
 
 MODULE_AUTHOR("Philippe Reynes <tremyfr@yahoo.fr>");
-MODULE_DESCRIPTION("MAX1027/MAX1029/MAX1031 ADC");
+MODULE_DESCRIPTION("MAX1X27/MAX1X29/MAX1X31 ADC");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

