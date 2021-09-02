Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7C3FF56D
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbhIBVPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:43 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45861 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346633AbhIBVPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9F7A524000A;
        Thu,  2 Sep 2021 21:14:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 04/16] iio: adc: max1027: Avoid device managed allocators for DMA purposes
Date:   Thu,  2 Sep 2021 23:14:25 +0200
Message-Id: <20210902211437.503623-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My overall understanding [1] is that devm_ allocations will require an
extra 16 bytes at the beginning of the allocated buffer to store
information about the managing device, this shifts a little bit the
buffer which may then not be fully aligned on cache lines, disqualifying
them for being suitable for DMA.

Let's switch to a regular kmalloc based allocator to ensure st->buffer
is DMA-able, as required by the IIO subsystem.

[1] https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-kmalloc-for-dma

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index f27044324141..1167d50c1d67 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -438,9 +438,7 @@ static int max1027_probe(struct spi_device *spi)
 	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->available_scan_masks = st->info->available_scan_masks;
 
-	st->buffer = devm_kmalloc_array(&indio_dev->dev,
-					indio_dev->num_channels, 2,
-					GFP_KERNEL);
+	st->buffer = kmalloc_array(indio_dev->num_channels, 2, GFP_KERNEL);
 	if (!st->buffer)
 		return -ENOMEM;
 
@@ -451,7 +449,7 @@ static int max1027_probe(struct spi_device *spi)
 						      NULL);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
-			return ret;
+			goto free_buffer;
 		}
 
 		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
@@ -460,7 +458,7 @@ static int max1027_probe(struct spi_device *spi)
 			ret = -ENOMEM;
 			dev_err(&indio_dev->dev,
 				"Failed to allocate iio trigger\n");
-			return ret;
+			goto free_buffer;
 		}
 
 		st->trig->ops = &max1027_trigger_ops;
@@ -470,7 +468,7 @@ static int max1027_probe(struct spi_device *spi)
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"Failed to register iio trigger\n");
-			return ret;
+			goto free_buffer;
 		}
 
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
@@ -481,7 +479,7 @@ static int max1027_probe(struct spi_device *spi)
 						st->trig);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
-			return ret;
+			goto free_buffer;
 		}
 	}
 
@@ -490,7 +488,7 @@ static int max1027_probe(struct spi_device *spi)
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to reset the ADC\n");
-		return ret;
+		goto free_buffer;
 	}
 
 	/* Disable averaging */
@@ -498,10 +496,15 @@ static int max1027_probe(struct spi_device *spi)
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to configure averaging register\n");
-		return ret;
+		goto free_buffer;
 	}
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
+
+free_buffer:
+	kfree(st->buffer);
+
+	return ret;
 }
 
 static struct spi_driver max1027_driver = {
-- 
2.27.0

