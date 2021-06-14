Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF73A65B9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhFNLmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhFNLh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D566134F;
        Mon, 14 Jun 2021 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670429;
        bh=F7XmoMcwJPPcXxw0bTIa6C1AAdnqrRXSH7Ps7AlrnWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpktRzJcqNTTAprJpDC33fEaGbIl+ih5rIRvpeksqSY1VUjM3CdfuUoWAzTshg5Z2
         eNq8Mg4F9LYf5gh4Di5L/OIGQDo6gqgpK60MicoMSf896oyus4bD8ABL9OA7kuoR5S
         +lvtXmeSGSE6Em+m5NewFH/qYoC2pSHR/O6/E7Q8oN+mO49OAYDHYNBg98FlyS+JGk
         9LPSpD4cyKIBh2vQAcevYdTjGv6sMVzvybeohYOjxfueFuashvu0vrKcCCYEcqzp+y
         7t3QSFsfjDfvTjIGBNv0aJ7IVUaNcWspoJ+TE3W5NElYvEP0ENktMXxMOQuRaoCrTz
         Ya0bnfmMMr+dw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/17] staging:iio:ad7280a: Reflect optionality of irq in ABI
Date:   Mon, 14 Jun 2021 12:35:02 +0100
Message-Id: <20210614113507.897732-13-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the irq is optional, let us remove the interfaces related to
events when it is not present.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 48 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 7f9e2276e41a..b4ba6da07af9 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -579,23 +579,29 @@ static const struct iio_event_spec ad7280_events[] = {
 	},
 };
 
-static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
+static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i,
+					bool irq_present)
 {
 	chan->type = IIO_VOLTAGE;
 	chan->differential = 1;
 	chan->channel = i;
 	chan->channel2 = chan->channel + 1;
-	chan->event_spec = ad7280_events;
-	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
+	if (irq_present) {
+		chan->event_spec = ad7280_events;
+		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
+	}
 	chan->ext_info = ad7280_cell_ext_info;
 }
 
-static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
+static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i,
+				     bool irq_present)
 {
 	chan->type = IIO_TEMP;
 	chan->channel = i;
-	chan->event_spec = ad7280_events;
-	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
+	if (irq_present) {
+		chan->event_spec = ad7280_events;
+		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
+	}
 }
 
 static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
@@ -629,7 +635,8 @@ static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
 	chan->scan_type.storagebits = 32;
 }
 
-static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
+static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt,
+				     bool irq_present)
 {
 	int addr, ch, i;
 	struct iio_chan_spec *chan;
@@ -639,10 +646,10 @@ static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
 
 		if (ch < AD7280A_AUX_ADC_1_REG) {
 			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
-			ad7280_voltage_channel_init(chan, i);
+			ad7280_voltage_channel_init(chan, i, irq_present);
 		} else {
 			i = AD7280A_CALC_TEMP_CHAN_NUM(dev, ch);
-			ad7280_temp_channel_init(chan, i);
+			ad7280_temp_channel_init(chan, i, irq_present);
 		}
 
 		addr = ad7280a_devaddr(dev) << 8 | ch;
@@ -652,7 +659,7 @@ static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
 	}
 }
 
-static int ad7280_channel_init(struct ad7280_state *st)
+static int ad7280_channel_init(struct ad7280_state *st, bool irq_present)
 {
 	int dev, cnt = 0;
 
@@ -662,7 +669,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 		return -ENOMEM;
 
 	for (dev = 0; dev <= st->slave_num; dev++)
-		ad7280_init_dev_channels(st, dev, &cnt);
+		ad7280_init_dev_channels(st, dev, &cnt, irq_present);
 
 	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
 
@@ -920,6 +927,11 @@ static const struct iio_info ad7280_info = {
 	.write_event_value = &ad7280a_write_thresh,
 };
 
+static const struct iio_info ad7280_info_no_irq = {
+	.read_event_value = &ad7280a_read_thresh,
+	.write_event_value = &ad7280a_write_thresh,
+};
+
 static const struct ad7280_platform_data ad7793_default_pdata = {
 	.acquisition_time = AD7280A_ACQ_TIME_400ns,
 	.thermistor_term_en = true,
@@ -973,18 +985,12 @@ static int ad7280_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad7280_channel_init(st);
+	ret = ad7280_channel_init(st, spi->irq > 0);
 	if (ret < 0)
 		return ret;
 
 	indio_dev->num_channels = ret;
 	indio_dev->channels = st->channels;
-	indio_dev->info = &ad7280_info;
-
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
 	if (spi->irq > 0) {
 		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
 				   AD7280A_ALERT_REG, 1,
@@ -1008,9 +1014,13 @@ static int ad7280_probe(struct spi_device *spi)
 						indio_dev);
 		if (ret)
 			return ret;
+
+		indio_dev->info = &ad7280_info;
+	} else {
+		indio_dev->info = &ad7280_info_no_irq;
 	}
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7280_id[] = {
-- 
2.32.0

