Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79BF40C8F8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbhIOPxU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42853 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbhIOPxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:53:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 79334200021;
        Wed, 15 Sep 2021 15:51:28 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 14/14] iio: adc: max1027: Don't reject external triggers when there is no IRQ
Date:   Wed, 15 Sep 2021 17:51:17 +0200
Message-Id: <20210915155117.475962-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155117.475962-1-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

External triggers do not necessarily need the EOC interrupt to be
populated to work properly. The end of conversion status may either come
from an interrupt or from a sufficient enough extra delay. IRQs are not
mandatory so move the triggered buffer setup out of the IRQ condition
and add the logic to wait enough time for all the requested conversions
to be in the device's FIFO.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 9bf1c563042f..42b76ac0e584 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -288,6 +288,9 @@ static int max1027_wait_eoc(struct iio_dev *indio_dev)
 		if (!ret)
 			return ret;
 	} else {
+		if (indio_dev->active_scan_mask)
+			conversion_time *= hweight32(*indio_dev->active_scan_mask);
+
 		usleep_range(conversion_time, conversion_time * 2);
 	}
 
@@ -585,16 +588,18 @@ static int max1027_probe(struct spi_device *spi)
 	if (!st->buffer)
 		return -ENOMEM;
 
+	/* Enable triggered buffers */
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &max1027_ext_trigger_handler,
+					      NULL);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
+		return ret;
+	}
+
+	/* If there is an EOC interrupt, register the hardware trigger (cnvst) */
 	if (spi->irq) {
-		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-						      &iio_pollfunc_store_time,
-						      &max1027_ext_trigger_handler,
-						      NULL);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
-			return ret;
-		}
-
 		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
 						  indio_dev->name);
 		if (!st->trig) {
-- 
2.27.0

