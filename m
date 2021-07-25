Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713253D4F10
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGYQmL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 12:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhGYQmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 12:42:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C54D560F11;
        Sun, 25 Jul 2021 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627233761;
        bh=+/+JajD0nSgC22Q1yPGXN6NloVUXraF/XWs0Zzp6ZfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s767uUtKzwwasysbNVDDOjyyzGTRuSKxTF4MBRnA+bpjcIN5gCZSHsA/waPO8uxH5
         TJfYVgTNC2gFaZ89ke6fuRjrJSWQTI+Ox/7gQm/mgRbfmWgoQDKjQA2itPmQTT7IMV
         Gb0EaFt9C1qpQFBnhXKzSZBlxZ5X4sUxAj/g1DZkSS4ggvoMYX3+jJ5dG9mX77d68K
         RYNVJ8nKgWITtmKFhtGxn+2dDcbOmRNV3S/v1H7NMb4e/pQvxSBOYepGXPdOrrgQTd
         mweQ0cQUiCLCQEda3Onp1gHXm2Vw1dQTv3XrXcNhGoLsFrf4t7OxF9BPiZyaAczX66
         CLb5JWOoDLUng==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio:adc:ad7124: Convert to fwnode handling of child node parsing.
Date:   Sun, 25 Jul 2021 18:24:58 +0100
Message-Id: <20210725172458.487343-3-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210725172458.487343-1-jic23@kernel.org>
References: <20210725172458.487343-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also use device_get_match_data() rather than of specific variant.
These changes enable use of this binding on ACPI platforms via PRP0001.
Whilst it's possible no one will ever do so, this is part of a general
effort to clear out examples from IIO that might be copied into new
drivers.

It may appear that this change drops the check for status = disabled,
but in reality it does not because the of property code uses
of_get_next_available_child().  This driver may well fail to probe
if disabled is ever actually set though due to the need for
complete concurrent child nodes.  A future series might resolve
that restriction.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b2e49386d7dc..bbb9830e13c2 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -733,18 +733,20 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
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
+	struct fwnode_handle *child;
 	struct iio_chan_spec *chan;
 	unsigned int ain[2], channel = 0, tmp;
 	int ret;
 
-	st->num_channels = of_get_available_child_count(np);
+	device_for_each_child_node(dev, child)
+		st->num_channels++;
+
 	if (!st->num_channels) {
 		dev_err(indio_dev->dev.parent, "no channel children\n");
 		return -ENODEV;
@@ -764,9 +766,8 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->num_channels;
 	st->channels = channels;
 
-	for_each_available_child_of_node(np, child) {
-
-		ret = of_property_read_u32(child, "reg", &channel);
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			goto err;
 
@@ -779,8 +780,8 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 
 		cfg = &st->channels[channel].cfg;
 
-		ret = of_property_read_u32_array(child, "diff-channels",
-						 ain, 2);
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, 2);
 		if (ret)
 			goto err;
 
@@ -788,16 +789,16 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
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
+		cfg->buf_positive = fwnode_property_read_bool(child, "adi,buffered-positive");
+		cfg->buf_negative = fwnode_property_read_bool(child, "adi,buffered-negative");
 
 		chan[channel] = ad7124_channel_template;
 		chan[channel].address = channel;
@@ -808,7 +809,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 
 	return 0;
 err:
-	of_node_put(child);
+	fwnode_handle_put(child);
 
 	return ret;
 }
@@ -875,7 +876,7 @@ static int ad7124_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int i, ret;
 
-	info = of_device_get_match_data(&spi->dev);
+	info = device_get_match_data(&spi->dev);
 	if (!info)
 		return -ENODEV;
 
@@ -893,7 +894,7 @@ static int ad7124_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
 
-	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
+	ret = ad7124_parse_channel_config(indio_dev, &spi->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.32.0

