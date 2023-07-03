Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E795745A72
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jul 2023 12:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGCKjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jul 2023 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCKjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2023 06:39:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD6492
        for <linux-iio@vger.kernel.org>; Mon,  3 Jul 2023 03:39:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1qGGyA-0007es-JH; Mon, 03 Jul 2023 12:39:46 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1qGGy9-00BmVe-MT; Mon, 03 Jul 2023 12:39:45 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1qGGy8-000Nz6-Ea; Mon, 03 Jul 2023 12:39:44 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: add buffering support to the TI LMP92064 ADC driver
Date:   Mon,  3 Jul 2023 12:39:07 +0200
Message-Id: <20230703103908.27691-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable buffered reading of samples from the LMP92064 ADC.
The main benefit of this change is being able to read out current and
voltage measurements in a single transfer, allowing instantaneous power
measurements.

Reads into the buffer can be triggered by any software triggers, e.g.
the iio-trig-hrtimer:

    $ mkdir /sys/kernel/config/iio/triggers/hrtimer/my-trigger
    $ cat /sys/bus/iio/devices/iio\:device3/name
    lmp92064
    $ iio_readdev -t my-trigger -b 16 iio:device3 | hexdump
    WARNING: High-speed mode not enabled
    0000000 0000 0176 0101 0001 5507 abd5 7645 1768
    0000010 0000 016d 0101 0001 ee1e ac6b 7645 1768
    ...

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
Changes v1->v2:

  - Remove superfluous .shift = 0 initialization in scan_type.
  - Replace kmalloc buffer allocation for every read with a stack
    allocated structure.
    A struct is used to ensure correct alignment of the timestamp field.
    See e.g. adc/rockchip_saradc.c for other users of the same pattern.
  - Use available_scan_masks and always push both voltage and current
    measurements to the buffer.

Changes v2->v3:

  - Handle errors returned by lmp92064_read_meas() out-of-line via
    a goto err;

---
 drivers/iio/adc/ti-lmp92064.c | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index c30ed824924f3..73504a27a8e22 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -16,7 +16,10 @@
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define TI_LMP92064_REG_CONFIG_A 0x0000
 #define TI_LMP92064_REG_CONFIG_B 0x0001
@@ -91,6 +94,12 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
 		.address = TI_LMP92064_CHAN_INC,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = TI_LMP92064_CHAN_INC,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
 		.datasheet_name = "INC",
 	},
 	{
@@ -98,8 +107,20 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
 		.address = TI_LMP92064_CHAN_INV,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = TI_LMP92064_CHAN_INV,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
 		.datasheet_name = "INV",
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static const unsigned long lmp92064_scan_masks[] = {
+	BIT(TI_LMP92064_CHAN_INC) | BIT(TI_LMP92064_CHAN_INV),
+	0
 };
 
 static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
@@ -171,6 +192,30 @@ static int lmp92064_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
+	struct {
+		u16 values[2];
+		int64_t timestamp;
+	} data;
+	int ret;
+
+	ret = lmp92064_read_meas(priv, data.values);
+	if (ret)
+		goto err;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data,
+					   iio_get_time_ns(indio_dev));
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int lmp92064_reset(struct lmp92064_adc_priv *priv,
 			  struct gpio_desc *gpio_reset)
 {
@@ -301,6 +346,12 @@ static int lmp92064_adc_probe(struct spi_device *spi)
 	indio_dev->channels = lmp92064_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lmp92064_adc_channels);
 	indio_dev->info = &lmp92064_adc_info;
+	indio_dev->available_scan_masks = lmp92064_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      lmp92064_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup buffered read\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }

base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.39.2

