Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4911B04B1
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDTInS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDTInJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 04:43:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55CC061A0C;
        Mon, 20 Apr 2020 01:43:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so11018625wrs.9;
        Mon, 20 Apr 2020 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRRIkqL6fbq8TpMuecFXBC2M0LcF4y35GjVFBof8OL4=;
        b=LvrP8zzSE1w42oWbY5ycewQFc6Nu2hLhU9aazl5iaxNiedEQZJgw3BH8Kal7nZS092
         CVSTyf44G1A69gWsO3zKIrMQNafxU3PmEGnWj8Le6sevEtMnjZ2xMgpZhZjypmuGXgM2
         ASrI/tfW1/wIouvoAaPUGQrVeHLqeKP+XM7ySiW4qUfQKUh8Ff2D8tD00cH9AhYVQH+z
         FS/bhBRPg7nz5iCOPgYYeFj636GVnQd6pP21zqpWXdW43hI2SVFc2ptIVMS9uWJ6FMvl
         Kh4amPTzjuO9mo6QgQkSzKYEP3oQhoykQ5p2/qaNd0OjqMRDIXgB/IuE2JEQrsd1W6A/
         s3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRRIkqL6fbq8TpMuecFXBC2M0LcF4y35GjVFBof8OL4=;
        b=uiu0/s2bNrm/XFx/IqNlCBQjooXhlJl+GQHlC/fgbs6iz730ohOx/WVCOMf1FOGnUO
         WLJuJAHJPE0lbXUUi+Ka7Ae9UpUAtcWoZqLsWEOSnzW3h9c1USaexXv8NI46MKoMrbtx
         GJyrglwbwgJNCk55Q0eRmq8uy08rRGLRanBcXb4n/urky8fMyjIRuamxR8nqw3KTomkA
         f35o9b0ZMSeoA2VjpiWd68yu6kMJxZ1hvz/1+5efs2sL+Tx+QtbikMvlLza7g0XS/lf6
         3L/LwaJJ4CBsvQj/kJtrqE4YJOS0CnzVruS9sbYa7ft0/F2Zpjt1/kYpsdsFZII1yz22
         qK1Q==
X-Gm-Message-State: AGi0Pub3BUyIntWbegn1SMtZKtS/zXqBnT9bWWXfSCmfPlHO9eQSJSB6
        z+JIgyiP+blT0qbs5X0K8D8wioifoPU=
X-Google-Smtp-Source: APiQypKiRV4EIzXvp2eVvpsZ7wGh/mmqFvoaEzfv+7V1f6vTzOxoHgNkPGLu+bGYJuriLUAfu7rxUA==
X-Received: by 2002:adf:f342:: with SMTP id e2mr16676885wrp.146.1587372187496;
        Mon, 20 Apr 2020 01:43:07 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:c546:5ea:178b:4074])
        by smtp.gmail.com with ESMTPSA id g74sm403183wme.44.2020.04.20.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:43:06 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 4/4] iio: vcnl4000: Add buffer support for VCNL4010/20.
Date:   Mon, 20 Apr 2020 10:42:10 +0200
Message-Id: <20200420084210.14245-5-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420084210.14245-1-m.othacehe@gmail.com>
References: <20200420084210.14245-1-m.othacehe@gmail.com>
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
 drivers/iio/light/vcnl4000.c | 173 ++++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 2 deletions(-)

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
index 3f9d63858b51..a0b98fc1c7a9 100644
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
@@ -14,8 +15,7 @@
  * TODO:
  *   allow to adjust IR current
  *   proximity threshold and event handling
- *   periodic ALS/proximity measurement (VCNL4010/20)
- *   interrupts (VCNL4010/20/40, VCNL4200)
+ *   interrupts (VCNL4040, VCNL4200)
  */
 
 #include <linux/module.h>
@@ -25,9 +25,13 @@
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
@@ -890,7 +894,14 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
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
 
 static IIO_CONST_ATTR(in_illuminance_sampling_frequency_available,
@@ -1012,10 +1023,153 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 		mutex_unlock(&data->vcnl4000_lock);
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
+	mutex_lock(&data->vcnl4000_lock);
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	mutex_unlock(&data->vcnl4000_lock);
+
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
+	mutex_lock(&data->vcnl4000_lock);
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					isr & VCNL4010_INT_DRDY);
+	mutex_unlock(&data->vcnl4000_lock);
+
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
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
+	if (ret < 0)
+		goto end;
+
+	/* Do not enable the buffer if we are already capturing events. */
+	if ((ret & VCNL4000_SELF_TIMED_EN) > 0) {
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
+	mutex_unlock(&data->vcnl4000_lock);
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
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+	if (ret < 0)
+		goto end;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
+
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
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
@@ -1052,6 +1206,16 @@ static int vcnl4000_probe(struct i2c_client *client,
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
@@ -1062,6 +1226,10 @@ static int vcnl4000_probe(struct i2c_client *client,
 			dev_err(&client->dev, "irq request failed\n");
 			return ret;
 		}
+
+		ret = vcnl4010_probe_trigger(indio_dev);
+		if (ret < 0)
+			return ret;
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
@@ -1157,5 +1325,6 @@ static struct i2c_driver vcnl4000_driver = {
 module_i2c_driver(vcnl4000_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
 MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.26.0

