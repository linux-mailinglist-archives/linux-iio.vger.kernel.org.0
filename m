Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3783FF578
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347313AbhIBVPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37715 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbhIBVPs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 115BF240012;
        Thu,  2 Sep 2021 21:14:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 12/16] iio: adc: max1027: Separate the IRQ handler from the read logic
Date:   Thu,  2 Sep 2021 23:14:33 +0200
Message-Id: <20210902211437.503623-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create a max1027_read_scan() helper which will make clearer the future IRQ
handler updates (no functional change).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 57f62ea2d7aa..5456432b9404 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -423,22 +423,37 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static irqreturn_t max1027_trigger_handler(int irq, void *private)
+static int max1027_read_scan(struct iio_dev *indio_dev)
 {
-	struct iio_poll_func *pf = private;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int scanned_chans;
+	int ret;
 
 	scanned_chans = fls(*indio_dev->active_scan_mask) - 1;
 	if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
 		scanned_chans++;
 
 	/* fill buffer with all channel */
-	spi_read(st->spi, st->buffer, scanned_chans * 2);
+	ret = spi_read(st->spi, st->buffer, scanned_chans * 2);
+	if (ret < 0)
+		return ret;
 
 	iio_push_to_buffers(indio_dev, st->buffer);
 
+	return 0;
+}
+
+static irqreturn_t max1027_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	int ret;
+
+	ret = max1027_read_scan(indio_dev);
+	if (ret)
+		dev_err(&indio_dev->dev,
+			"Cannot read scanned values (%d)\n", ret);
+
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.27.0

