Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4A382033
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEPR1k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhEPR1j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B47A6113C;
        Sun, 16 May 2021 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185984;
        bh=WgsdGjl7K3U06WP6xQkfrnSCbQdo5kcQBcD9QNnUFCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLfLyFUatNyvpx26wFHtJ03fJWYl0rpx0/tCZK176jKnjtox5MVuaISJfN2kvqDWN
         fOISBv/ignAIb1tBQZllnViuB1JFUGjqPa/pHSCbLpcS8Ylu6LgGd9IeDUX0aBiOl3
         NSmPrYiJYbV8R+E4+IZyJmAfw7G/qRjWwvKPN/5KezJfDPKxVthHiZwSksMWVMn6zw
         oZi8Hk6PQ47ns9VQd6fYsONMP0SFJ62+lfbiEPnRu00IWULHXhi+2SfVqKto1H69Cj
         RnkbdGJfzNytreBxPm//rMIAts8drylDw4KVWCYyco1iXTiGJukbAJtOtChI0Lbj+6
         7Udj7Tis+4WBA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: adc: max1118: Avoid jumping back and forth between spi and iio structures
Date:   Sun, 16 May 2021 18:25:16 +0100
Message-Id: <20210516172520.1398835-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changing from passing the spi structure into various functions to
passing struct iio_dev avoids use of spi_get_drvdata and lets us
stop setting that at all.  Previous code was unnecessarily complex.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1118.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 4dfbed63ad7f..8cec9d949083 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -66,9 +66,8 @@ static const struct iio_chan_spec max1118_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
-static int max1118_read(struct spi_device *spi, int channel)
+static int max1118_read(struct iio_dev *indio_dev, int channel)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct max1118 *adc = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		/*
@@ -103,9 +102,9 @@ static int max1118_read(struct spi_device *spi, int channel)
 	int ret;
 
 	if (channel == 0)
-		ret = spi_sync_transfer(spi, xfers + 1, 2);
+		ret = spi_sync_transfer(adc->spi, xfers + 1, 2);
 	else
-		ret = spi_sync_transfer(spi, xfers, 3);
+		ret = spi_sync_transfer(adc->spi, xfers, 3);
 
 	if (ret)
 		return ret;
@@ -113,11 +112,10 @@ static int max1118_read(struct spi_device *spi, int channel)
 	return adc->data;
 }
 
-static int max1118_get_vref_mV(struct spi_device *spi)
+static int max1118_get_vref_mV(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct max1118 *adc = iio_priv(indio_dev);
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct spi_device_id *id = spi_get_device_id(adc->spi);
 	int vref_uV;
 
 	switch (id->driver_data) {
@@ -144,14 +142,14 @@ static int max1118_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&adc->lock);
-		*val = max1118_read(adc->spi, chan->channel);
+		*val = max1118_read(indio_dev, chan->channel);
 		mutex_unlock(&adc->lock);
 		if (*val < 0)
 			return *val;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = max1118_get_vref_mV(adc->spi);
+		*val = max1118_get_vref_mV(indio_dev);
 		if (*val < 0)
 			return *val;
 		*val2 = 8;
@@ -180,7 +178,7 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
 			indio_dev->masklength) {
 		const struct iio_chan_spec *scan_chan =
 				&indio_dev->channels[scan_index];
-		int ret = max1118_read(adc->spi, scan_chan->channel);
+		int ret = max1118_read(indio_dev, scan_chan->channel);
 
 		if (ret < 0) {
 			dev_warn(&adc->spi->dev,
@@ -238,8 +236,6 @@ static int max1118_probe(struct spi_device *spi)
 
 	}
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1118_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -252,7 +248,7 @@ static int max1118_probe(struct spi_device *spi)
 	 * a conversion has been completed, the MAX1117/MAX1118/MAX1119 will go
 	 * into AutoShutdown mode until the next conversion is initiated.
 	 */
-	max1118_read(spi, 0);
+	max1118_read(indio_dev, 0);
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      max1118_trigger_handler, NULL);
-- 
2.31.1

