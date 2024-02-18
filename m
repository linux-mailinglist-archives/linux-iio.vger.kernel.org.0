Return-Path: <linux-iio+bounces-2730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C2859825
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB71F21227
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B951E86B;
	Sun, 18 Feb 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbgsDF5M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E6E57E
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277274; cv=none; b=HKpz8ZI9r8k6UIq0PA51E/LOXmxs59J+4PWf+9LV716CjRdvzEYeAAFQojV7pK/IY0IQ43vrHCMPiyPiNkNgtI4h/1PtKBlIpzi1JNDS/G4nXLTvjBbLdf+HS/ZovUG2+pbROCMtPRYEdLHBIHqhnUc2cJ3qxVH9IGPXTffSUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277274; c=relaxed/simple;
	bh=08pF1DNnMmRM/lqhXL1nTS7E8jqHMzKmhzuGlQfUP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg4XDgntVrZPqYa3l092juKWgSAOQ7rthFliI7h0X8HJojB8CNC9GyKljrvUYFJZO7y4bBvMHdGxoG9qvOquKFEituGLuz+kwgT7T+jppSCNqXG/mCZu0L+ciHjojy2Wd35I3OtVhAexRiTighhYQW9uGLKjyiPAPpaXrHphMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbgsDF5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8FDC433C7;
	Sun, 18 Feb 2024 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277273;
	bh=08pF1DNnMmRM/lqhXL1nTS7E8jqHMzKmhzuGlQfUP/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbgsDF5Mo7DtpIq5i3Y+FHzCAjuEwqeHqfo5OjYb9DQ330zuZnVJ2GqvTRjDfyuKg
	 bsnH9QfjDOJy/s87WvuQarkZoNraUH4PU3Gg73sKAgCRsDZCBe2BRFKpje9E9KzXUR
	 TmXZmXuOk/UFXigi/IUNU2s6Qqvwk7ANbVwxszKNHH6GPnlN7AV8pzUcbVPzD5DQcc
	 sHdXnTzLEkAKG6ayKzxblEiT2X8ZnbqZz1Ji3TIEwoknIikwMf5MVtwuBJVbDPCx1L
	 gG40XX7I1TTj6F/JAf5X1EdQoGF4d4q0tYZHeqO9Fjnfk8DEYyS3Mo6f+6KCzaQj4a
	 t372shoMQySbA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] iio: adc: ad7124: Switch from of specific to fwnode based property handling
Date: Sun, 18 Feb 2024 17:27:26 +0000
Message-ID: <20240218172731.1023367-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using the generic firmware data access functions from property.h
provides a number of advantages:
 1) Works with different firmware types.
 2) Doesn't provide a 'bad' example for new IIO drivers.
 3) Lets us use the new _scoped() loops with automatic reference count
    cleanup for fwnode_handle

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 55 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b9b206fcd748..e7b1d517d3de 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -14,7 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -807,22 +808,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
-static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
-					  struct device_node *np)
+static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
+				       struct device *dev)
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 	struct ad7124_channel_config *cfg;
 	struct ad7124_channel *channels;
-	struct device_node *child;
 	struct iio_chan_spec *chan;
 	unsigned int ain[2], channel = 0, tmp;
 	int ret;
 
-	st->num_channels = of_get_available_child_count(np);
-	if (!st->num_channels) {
-		dev_err(indio_dev->dev.parent, "no channel children\n");
-		return -ENODEV;
-	}
+	st->num_channels = device_get_child_node_count(dev);
+	if (!st->num_channels)
+		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
@@ -838,39 +836,38 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->num_channels;
 	st->channels = channels;
 
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		cfg = &st->channels[channel].cfg;
 
-		ret = of_property_read_u32(child, "reg", &channel);
+		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
-			goto err;
+			return ret;
 
-		if (channel >= indio_dev->num_channels) {
-			dev_err(indio_dev->dev.parent,
+		if (channel >= indio_dev->num_channels)
+			return dev_err_probe(dev, -EINVAL,
 				"Channel index >= number of channels\n");
-			ret = -EINVAL;
-			goto err;
-		}
 
-		ret = of_property_read_u32_array(child, "diff-channels",
-						 ain, 2);
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, 2);
 		if (ret)
-			goto err;
+			return ret;
 
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
-		cfg->bipolar = of_property_read_bool(child, "bipolar");
+		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
-		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
+		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);
 		if (ret)
 			cfg->refsel = AD7124_INT_REF;
 		else
 			cfg->refsel = tmp;
 
-		cfg->buf_positive = of_property_read_bool(child, "adi,buffered-positive");
-		cfg->buf_negative = of_property_read_bool(child, "adi,buffered-negative");
+		cfg->buf_positive =
+			fwnode_property_read_bool(child, "adi,buffered-positive");
+		cfg->buf_negative =
+			fwnode_property_read_bool(child, "adi,buffered-negative");
 
 		chan[channel] = ad7124_channel_template;
 		chan[channel].address = channel;
@@ -880,10 +877,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	}
 
 	return 0;
-err:
-	of_node_put(child);
-
-	return ret;
 }
 
 static int ad7124_setup(struct ad7124_state *st)
@@ -943,9 +936,7 @@ static int ad7124_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int i, ret;
 
-	info = of_device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info)
 		return -ENODEV;
 
@@ -965,7 +956,7 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
+	ret = ad7124_parse_channel_config(indio_dev, &spi->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.2


