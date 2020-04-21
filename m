Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEA1B207C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgDUHzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgDUHzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 03:55:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD7C061A41;
        Tue, 21 Apr 2020 00:55:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so2510757wmc.5;
        Tue, 21 Apr 2020 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOw2KnamzoPXkRdHYaDY/Ym3nB85KNAfk57edZKX0M8=;
        b=nc1Egy0KIBtHeAbIGWNwGy1H1cxK8tm3bAz2Uk/qn5fhY6unzDoZSwLJdnqLZuyGom
         WDJy04wqZLoSNPMb1drxm/SiMr9gnSkMDyF5qy2B9UrLmt8961W0+26sj9XacDSTYwPa
         FCldVnBl6qh/cqcb/dgquDCOrAGF1oOf/81aZwpxw8WZoy/CM2ZwJR/cBbvHdwiOUjLd
         6NAh9NYMuwa3cXPlAGewSt7XHnEysyOrHh12nxu0CUOu0tSr9hI6VJ2cliCXZR6HMGyh
         MuiyAWB02zKZu7W6OEaT1qK8dg/fykRTZMh04AP0LYiQUP/v6kAySDipAnL8s/zE59H4
         L+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOw2KnamzoPXkRdHYaDY/Ym3nB85KNAfk57edZKX0M8=;
        b=QdGbLGmYC63d6Pne691e3XccZ1MHsKw2taWILzL1Hheo6iavABsZGNxSmVNcw0AZSR
         x0HnpaU+Y+uKNHhAhbsXHaUaSk+ShsjkmcmJWbxC9ua9iGW/y6EhM2S/mpkpfvetnVah
         TTeMjjbGQcBsxpZ/WCIUz9B7d0OIpc5rej/FqI1ESK1xrr5rJdQh3VhZSboGzzYqSzfk
         8DLK4ipiexs+CR0FaoHTxFzIYjTuHGCcENwAghH/CU4uq9mymaRfJflFwTPMZl+6E402
         oX6MtsbbRxunPkdWu6dQBZz04JCYaOEiE7l6XEGickNbim6rLs25i7lK1BLcKy58UnRa
         VspA==
X-Gm-Message-State: AGi0PubD576dnAZ4M8SsJMhKgToETB9wogGQLfT8aaxMFEVXXRwHbkKb
        dhfeUKhf27OJP5l7a6vbo60=
X-Google-Smtp-Source: APiQypLgS5nndIJDSUMGudwbGg1apgl/8Y8HFXWG2BrkaXn7djn+450FV+gejSkO1IP0rxgkqeMlNg==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr3449738wmo.73.1587455743311;
        Tue, 21 Apr 2020 00:55:43 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:f9a2:4:b043:a3fb])
        by smtp.gmail.com with ESMTPSA id c190sm2514510wme.10.2020.04.21.00.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:55:42 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v4 4/4] iio: vcnl4000: Add buffer support for VCNL4010/20.
Date:   Tue, 21 Apr 2020 09:55:32 +0200
Message-Id: <20200421075532.19192-5-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200421075532.19192-1-m.othacehe@gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The VCNL4010 and VCNL4020 chips are able to raise interrupts on data ready.
Use it to provide triggered buffer support for proximity data.

Those two chips also provide ambient light data. However, they are sampled
at different rate than proximity data. As this is not handled by the IIO
framework for now, and the sample frequencies of ambient light data are
very low, do add buffer support for them.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 156 ++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 74970f18a93b..05f61b1e223a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -506,6 +506,8 @@ config US5182D
 
 config VCNL4000
 	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VCNL4000,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 1e00a9666534..094ba931d460 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -5,6 +5,7 @@
  *
  * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
  * Copyright 2019 Pursim SPC
+ * Copyright 2020 Mathieu Othacehe <m.othacehe@gmail.com>
  *
  * IIO driver for:
  *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
@@ -13,8 +14,7 @@
  *
  * TODO:
  *   allow to adjust IR current
- *   periodic ALS/proximity measurement (VCNL4010/20)
- *   interrupts (VCNL4010/20/40, VCNL4200)
+ *   interrupts (VCNL4040, VCNL4200)
  */
 
 #include <linux/module.h>
@@ -24,9 +24,13 @@
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define VCNL4000_DRV_NAME "vcnl4000"
 #define VCNL4000_PROD_ID	0x01
@@ -768,7 +772,14 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
 		.event_spec = vcnl4000_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
 		.ext_info = vcnl4000_ext_info,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
 static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
@@ -882,10 +893,136 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 					  isr & VCNL4010_INT_THR);
 	}
 
+	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_chained(indio_dev->trig);
+
+end:
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
+	u16 buffer[8] = {0}; /* 1x16-bit + ts */
+	bool data_read = false;
+	unsigned long isr;
+	int val = 0;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	if (ret < 0)
+		goto end;
+
+	isr = ret;
+
+	if (test_bit(0, active_scan_mask)) {
+		if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
+			ret = vcnl4000_read_data(data,
+						 VCNL4000_PS_RESULT_HI,
+						 &val);
+			if (ret < 0)
+				goto end;
+
+			buffer[0] = val;
+			data_read = true;
+		}
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					isr & VCNL4010_INT_DRDY);
+	if (ret < 0 || !data_read)
+		goto end;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+					   iio_get_time_ns(indio_dev));
+
 end:
+	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
 
+static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+	int cmd;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Do not enable the buffer if we are already capturing events. */
+	if (vcnl4010_in_periodic_mode(data)) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
+					VCNL4010_INT_PROX_EN);
+	if (ret < 0)
+		goto end;
+
+	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
+	if (ret < 0)
+		goto end;
+
+end:
+	if (ret < 0)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
+}
+
+static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret, ret_disable;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+	if (ret < 0)
+		goto end;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
+
+end:
+	ret_disable = iio_triggered_buffer_predisable(indio_dev);
+	if (ret == 0)
+		ret = ret_disable;
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
+	.postenable = &vcnl4010_buffer_postenable,
+	.predisable = &vcnl4010_buffer_predisable,
+};
+
+static const struct iio_trigger_ops vcnl4010_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	struct iio_trigger *trigger;
+
+	trigger = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+					 indio_dev->name, indio_dev->id);
+	if (!trigger)
+		return -ENOMEM;
+
+	trigger->dev.parent = &client->dev;
+	trigger->ops = &vcnl4010_trigger_ops;
+	iio_trigger_set_drvdata(trigger, indio_dev);
+
+	return devm_iio_trigger_register(&client->dev, trigger);
+}
+
 static int vcnl4000_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -922,6 +1059,16 @@ static int vcnl4000_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq && data->chip_spec->irq_support) {
+		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+						      NULL,
+						      vcnl4010_trigger_handler,
+						      &vcnl4010_buffer_ops);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"unable to setup iio triggered buffer\n");
+			return ret;
+		}
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, vcnl4010_irq_thread,
 						IRQF_TRIGGER_FALLING |
@@ -932,6 +1079,10 @@ static int vcnl4000_probe(struct i2c_client *client,
 			dev_err(&client->dev, "irq request failed\n");
 			return ret;
 		}
+
+		ret = vcnl4010_probe_trigger(indio_dev);
+		if (ret < 0)
+			return ret;
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
@@ -1027,5 +1178,6 @@ static struct i2c_driver vcnl4000_driver = {
 module_i2c_driver(vcnl4000_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
 MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.26.0

