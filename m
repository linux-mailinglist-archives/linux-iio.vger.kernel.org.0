Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A073F0261
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhHRLMp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60351 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhHRLMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0CE8260012;
        Wed, 18 Aug 2021 11:11:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 12/16] iio: adc: max1027: Introduce an end of conversion helper
Date:   Wed, 18 Aug 2021 13:11:35 +0200
Message-Id: <20210818111139.330636-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For now this helper only waits for the maximum duration of a conversion,
but it will soon be improved to properly handle the end of conversion
interrupt.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index afc3ce69f7ea..2d6485591761 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -60,6 +60,9 @@
 #define MAX1027_NAVG_32   (0x03 << 2)
 #define MAX1027_AVG_EN    BIT(4)
 
+/* Device can achieve 300ksps so we assume a 3.33us conversion delay */
+#define MAX1027_CONVERSION_UDELAY 4
+
 enum max1027_id {
 	max1027,
 	max1029,
@@ -236,6 +239,20 @@ struct max1027_state {
 	u8				reg ____cacheline_aligned;
 };
 
+static DECLARE_WAIT_QUEUE_HEAD(max1027_queue);
+
+static int max1027_wait_eoc(struct iio_dev *indio_dev)
+{
+	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
+
+	if (indio_dev->active_scan_mask)
+		conversion_time *= hweight32(*indio_dev->active_scan_mask);
+
+	usleep_range(conversion_time, conversion_time * 2);
+
+	return 0;
+}
+
 /* Scan from 0 to the highest requested channel */
 static int max1027_configure_chans_to_scan(struct iio_dev *indio_dev)
 {
@@ -310,9 +327,11 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	/*
 	 * For an unknown reason, when we use the mode "10" (write
 	 * conversion register), the interrupt doesn't occur every time.
-	 * So we just wait 1 ms.
+	 * So we just wait the maximum conversion time and deliver the value.
 	 */
-	mdelay(1);
+	ret = max1027_wait_eoc(indio_dev);
+	if (ret)
+		return ret;
 
 	/* Read result */
 	ret = spi_read(st->spi, st->buffer, (chan->type == IIO_TEMP) ? 4 : 2);
-- 
2.27.0

