Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFC40C8F9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhIOPxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34305 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbhIOPxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:53:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0C77720001D;
        Wed, 15 Sep 2021 15:51:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 12/14] iio: adc: max1027: Introduce an end of conversion helper
Date:   Wed, 15 Sep 2021 17:51:15 +0200
Message-Id: <20210915155117.475962-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155117.475962-1-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For now this helper only waits for the maximum duration of a single
conversion (even though a temperature measurement will take twice this
time, we only care about the temperature which happens first, so we will
still only wait for a single sample).

This helper will soon be improved to properly handle the end of
conversion interrupt as well as a higher number of samples.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index a044f4b598e0..e0175448c899 100644
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
@@ -271,6 +274,15 @@ struct max1027_state {
 	u8				reg ____cacheline_aligned;
 };
 
+static int max1027_wait_eoc(struct iio_dev *indio_dev)
+{
+	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
+
+	usleep_range(conversion_time, conversion_time * 2);
+
+	return 0;
+}
+
 /* Scan from chan 0 to the highest requested channel. Include temperature on demand. */
 static int max1027_configure_chans_and_start(struct iio_dev *indio_dev)
 {
@@ -330,9 +342,11 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
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

