Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AB4AB180
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiBFS5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiBFS5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF486C043185
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD7BB80D88
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156C2C340EF;
        Sun,  6 Feb 2022 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173866;
        bh=nnU3sOvFrTBhehgmQzyAO+/ygdZKV9GRSmJK+47tPKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwgeUkp0LE97UJM22J0A/9RgGFYhpwiXvhWUZnaITWBa30B0/Jx2t4xNy+j/pFafi
         uPus7leB+iTu796UrCzHIhjvpDdM7da1UQwo3V0jTjKTcITohC3rpITxJkeVglnmaQ
         7Na+QnbdqDX+A9Kf5KtKGxpL9DPzjxPdIkTRCnWDcb71lCX44RgWMjMnPrsL78n0tU
         3bMu3rI1cUahlSJ54xzXksbFALyTB4O0jd4gnSS76jsRJ8dAZK5UOr8us+eQsEDutA
         tOLB5LZPKtU/SNf9X64DJHu2AVlqZ+K7vz52XOvwz9Zlpcf0saZ/2mK30s7o9vMgJs
         XzZ95vP9nVqkw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 12/20] staging:iio:ad7280a: Reflect optionality of irq in ABI
Date:   Sun,  6 Feb 2022 19:03:20 +0000
Message-Id: <20220206190328.333093-13-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the irq is optional, let us remove the interfaces related to
events when it is not present.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 48 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d408974c848c..8635a12f5f84 100644
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
 
@@ -935,6 +942,11 @@ static const struct iio_info ad7280_info = {
 	.write_event_value = &ad7280a_write_thresh,
 };
 
+static const struct iio_info ad7280_info_no_irq = {
+	.read_raw = ad7280_read_raw,
+	.write_raw = ad7280_write_raw,
+};
+
 static const struct ad7280_platform_data ad7793_default_pdata = {
 	.acquisition_time = AD7280A_ACQ_TIME_400ns,
 	.thermistor_term_en = true,
@@ -988,18 +1000,12 @@ static int ad7280_probe(struct spi_device *spi)
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
@@ -1023,9 +1029,13 @@ static int ad7280_probe(struct spi_device *spi)
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
2.35.1

