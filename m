Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0BCE37D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJGN1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:27:06 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51433 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJGN1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:27:05 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9D4161C0015;
        Mon,  7 Oct 2019 13:27:02 +0000 (UTC)
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
Subject: [PATCH v3 4/8] iio: adc: max1027: Prepare the introduction of different resolutions
Date:   Mon,  7 Oct 2019 15:26:53 +0200
Message-Id: <20191007132657.4190-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007132657.4190-1-miquel.raynal@bootlin.com>
References: <20191007132657.4190-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Maxim's max1027/29/31 series returns the measured voltages with a
resolution of 10 bits. There is a very similar series, max1227/29/31
which works identically but uses a resolution of 12 bits. Prepare the
support for these chips by turning the 'depth' into a macro parameter
instead of hardcoding it everywhere. Also reorganize just a bit the
macros at the top to avoid repeating tens of lines when adding support
for a new chip.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 74 +++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index f9b473ee6711..8b449044bef5 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -83,7 +83,7 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 #endif
 
-#define MAX1027_V_CHAN(index)						\
+#define MAX1027_V_CHAN(index, depth)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 		.scan_index = index + 1,				\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 10,					\
+			.realbits = depth,				\
 			.storagebits = 16,				\
 			.shift = 2,					\
 			.endianness = IIO_BE,				\
@@ -115,52 +115,42 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
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
+	MAX1X27_CHANNELS(depth),		\
+	MAX1027_V_CHAN(8, depth),		\
+	MAX1027_V_CHAN(9, depth),		\
+	MAX1027_V_CHAN(10, depth),		\
+	MAX1027_V_CHAN(11, depth)
+
+#define MAX1X31_CHANNELS(depth)			\
+	MAX1X27_CHANNELS(depth),		\
+	MAX1X29_CHANNELS(depth),		\
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
+	MAX1X27_CHANNELS(10),
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
+	MAX1X29_CHANNELS(10),
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
+	MAX1X31_CHANNELS(10),
 };
 
 static const unsigned long max1027_available_scan_masks[] = {
@@ -284,7 +274,7 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_VOLTAGE:
 			*val = 2500;
-			*val2 = 10;
+			*val2 = chan->scan_type.realbits;
 			ret = IIO_VAL_FRACTIONAL_LOG2;
 			break;
 		default:
-- 
2.20.1

