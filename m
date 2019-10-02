Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91174C888A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJBMag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 08:30:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfJBMaf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:30:35 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5F166E0008;
        Wed,  2 Oct 2019 12:30:32 +0000 (UTC)
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
Subject: [PATCH 4/7] iio: adc: max1027: Prepare the introduction of different resolutions
Date:   Wed,  2 Oct 2019 14:30:22 +0200
Message-Id: <20191002123025.21413-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002123025.21413-1-miquel.raynal@bootlin.com>
References: <20191002123025.21413-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Maxim's max1027/29/31 series returns the measured voltages with a
resolution of 10 bits. There is a very similar series, max1227/29/31
which works very similarly but uses a resolution of 12 bits. Prepare
the support for these chips by turning the 'depth' into a macro
parameter instead of hardcoding it everywhere. Also reorganize just a
bit the macros at the top to avoid repeating tens of lines when adding
support for a new chip.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 81 +++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index f9b473ee6711..fc75764a6fd7 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -78,12 +78,15 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
 	{ .compatible = "maxim,max1027" },
 	{ .compatible = "maxim,max1029" },
 	{ .compatible = "maxim,max1031" },
+	{ .compatible = "maxim,max1227" },
+	{ .compatible = "maxim,max1229" },
+	{ .compatible = "maxim,max1231" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 #endif
 
-#define MAX1027_V_CHAN(index)						\
+#define MAX1027_V_CHAN(index, depth)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -93,7 +96,7 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 		.scan_index = index + 1,				\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 10,					\
+			.realbits = depth,				\
 			.storagebits = 16,				\
 			.shift = 2,					\
 			.endianness = IIO_BE,				\
@@ -115,52 +118,42 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 		},							\
 	}
 
+#define MAX1X27_CHANNELS(depth)			\
+	MAX1027_T_CHAN,				\
+	MAX1027_V_CHAN(0, depth),		\
+	MAX1027_V_CHAN(1, depth),		\
+	MAX1027_V_CHAN(2, depth),		\
+	MAX1027_V_CHAN(3, depth),		\
+	MAX1027_V_CHAN(4, depth),		\
+	MAX1027_V_CHAN(5, depth),		\
+	MAX1027_V_CHAN(6, depth),		\
+	MAX1027_V_CHAN(7, depth)
+
+#define MAX1X29_CHANNELS(depth)			\
+	MAX1027_V_CHAN(8, depth),		\
+	MAX1027_V_CHAN(9, depth),		\
+	MAX1027_V_CHAN(10, depth),		\
+	MAX1027_V_CHAN(11, depth)
+
+#define MAX1X31_CHANNELS(depth)			\
+	MAX1027_V_CHAN(12, depth),		\
+	MAX1027_V_CHAN(13, depth),		\
+	MAX1027_V_CHAN(14, depth),		\
+	MAX1027_V_CHAN(15, depth)
+
 static const struct iio_chan_spec max1027_channels[] = {
-	MAX1027_T_CHAN,
-	MAX1027_V_CHAN(0),
-	MAX1027_V_CHAN(1),
-	MAX1027_V_CHAN(2),
-	MAX1027_V_CHAN(3),
-	MAX1027_V_CHAN(4),
-	MAX1027_V_CHAN(5),
-	MAX1027_V_CHAN(6),
-	MAX1027_V_CHAN(7)
+	MAX1X27_CHANNELS(10)
 };
 
 static const struct iio_chan_spec max1029_channels[] = {
-	MAX1027_T_CHAN,
-	MAX1027_V_CHAN(0),
-	MAX1027_V_CHAN(1),
-	MAX1027_V_CHAN(2),
-	MAX1027_V_CHAN(3),
-	MAX1027_V_CHAN(4),
-	MAX1027_V_CHAN(5),
-	MAX1027_V_CHAN(6),
-	MAX1027_V_CHAN(7),
-	MAX1027_V_CHAN(8),
-	MAX1027_V_CHAN(9),
-	MAX1027_V_CHAN(10),
-	MAX1027_V_CHAN(11)
+	MAX1X27_CHANNELS(10),
+	MAX1X29_CHANNELS(10)
 };
 
 static const struct iio_chan_spec max1031_channels[] = {
-	MAX1027_T_CHAN,
-	MAX1027_V_CHAN(0),
-	MAX1027_V_CHAN(1),
-	MAX1027_V_CHAN(2),
-	MAX1027_V_CHAN(3),
-	MAX1027_V_CHAN(4),
-	MAX1027_V_CHAN(5),
-	MAX1027_V_CHAN(6),
-	MAX1027_V_CHAN(7),
-	MAX1027_V_CHAN(8),
-	MAX1027_V_CHAN(9),
-	MAX1027_V_CHAN(10),
-	MAX1027_V_CHAN(11),
-	MAX1027_V_CHAN(12),
-	MAX1027_V_CHAN(13),
-	MAX1027_V_CHAN(14),
-	MAX1027_V_CHAN(15)
+	MAX1X27_CHANNELS(10),
+	MAX1X29_CHANNELS(10),
+	MAX1X31_CHANNELS(10)
 };
 
 static const unsigned long max1027_available_scan_masks[] = {
@@ -181,6 +174,7 @@ static const unsigned long max1031_available_scan_masks[] = {
 struct max1027_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	unsigned int depth;
 	const unsigned long *available_scan_masks;
 };
 
@@ -188,16 +182,19 @@ static const struct max1027_chip_info max1027_chip_info_tbl[] = {
 	[max1027] = {
 		.channels = max1027_channels,
 		.num_channels = ARRAY_SIZE(max1027_channels),
+		.depth = 10,
 		.available_scan_masks = max1027_available_scan_masks,
 	},
 	[max1029] = {
 		.channels = max1029_channels,
 		.num_channels = ARRAY_SIZE(max1029_channels),
+		.depth = 10,
 		.available_scan_masks = max1029_available_scan_masks,
 	},
 	[max1031] = {
 		.channels = max1031_channels,
 		.num_channels = ARRAY_SIZE(max1031_channels),
+		.depth = 10,
 		.available_scan_masks = max1031_available_scan_masks,
 	},
 };
@@ -284,7 +281,7 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_VOLTAGE:
 			*val = 2500;
-			*val2 = 10;
+			*val2 = st->info->depth;
 			ret = IIO_VAL_FRACTIONAL_LOG2;
 			break;
 		default:
-- 
2.20.1

