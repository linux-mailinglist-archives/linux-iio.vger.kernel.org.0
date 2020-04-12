Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79671A5ECD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLNqH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgDLNqH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:46:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E077206E5;
        Sun, 12 Apr 2020 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586699166;
        bh=7AopOZwIzZa2CQ4mMAWvMFT+u7XNL1Oh9NPETruA0rQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zWqfI2wyEVPNwN1iog3lmDMe/qwVbR1+0nUp8YrxIsgZN3h89aK07XSCiYEGIKl/5
         Rh+xjI5826qrWFOgo1HH/4/XwgBB5PM/5m35c9jn50vGZcN0vryQ4tapRh1CV0j9bS
         wap4jMVRhfYKbiJhfS8C7uZL9+p/hmM0SINE5p9w=
Date:   Sun, 12 Apr 2020 14:46:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2 4/4] iio: vcnl4000: Add buffer support for
 VCNL4010/20.
Message-ID: <20200412144602.25e2b810@archlinux>
In-Reply-To: <20200406145356.25883-5-m.othacehe@gmail.com>
References: <20200406145356.25883-1-m.othacehe@gmail.com>
        <20200406145356.25883-5-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Apr 2020 16:53:56 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> The VCNL4010 and VCNL4020 chips are able to raise interrupts on data ready.
> Use it to provide triggered buffer support for proximity data.
> 
> Those two chips also provide ambient light data. However, they are sampled
> at different rate than proximity data. As this is not handled by the IIO
> framework for now, and the sample frequencies of ambient light data are
> very low, do add buffer support for them.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

Hi Mathieu,

One nitpick in here which I can fix whilst applying. The series as
a whole looks good to me.

On a more general note we probably have a merge conflict between this
series and Guido's one adding the near level property to the driver.

Based on a bit of arbitrary timing I'd like to apply Guido's first
then try and take yours on top.  If there are any problems I'll
probably ask you to do the rebase at that point.

Guido's series is waiting for some other reviews to come in so
it may be a week or so.

Thanks,

Jonathan


> ---
>  drivers/iio/light/Kconfig    |   2 +
>  drivers/iio/light/vcnl4000.c | 178 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..0c066b800743 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -485,6 +485,8 @@ config US5182D
>  
>  config VCNL4000
>  	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VCNL4000,
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 899abef137a2..625d1a8114e5 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -5,6 +5,7 @@
>   *
>   * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
>   * Copyright 2019 Pursim SPC
> + * Copyright 2020 Mathieu Othacehe <m.othacehe@gmail.com>
>   *
>   * IIO driver for:
>   *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
> @@ -14,8 +15,7 @@
>   * TODO:
>   *   allow to adjust IR current
>   *   proximity threshold and event handling
> - *   periodic ALS/proximity measurement (VCNL4010/20)
> - *   interrupts (VCNL4010/20/40, VCNL4200)
> + *   interrupts (VCNL4040, VCNL4200)
>   */
>  
>  #include <linux/module.h>
> @@ -24,9 +24,13 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define VCNL4000_DRV_NAME "vcnl4000"
>  #define VCNL4000_PROD_ID	0x01
> @@ -820,7 +824,14 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.event_spec = vcnl4000_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  static IIO_CONST_ATTR(in_illuminance_sampling_frequency_available,
> @@ -938,10 +949,158 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  		mutex_unlock(&data->vcnl4000_lock);
>  	}
>  
> +	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll_chained(indio_dev->trig);
> +
> +end:
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> +	u16 buffer[8] = {0}; /* 1x16-bit + ts */
> +	bool data_read = false;
> +	unsigned long isr;
> +	int val = 0;
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	if (ret < 0)
> +		goto end;
> +
> +	isr = ret;
> +
> +	if (test_bit(0, active_scan_mask)) {
> +		if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
> +			ret = vcnl4000_read_data(data,
> +						 VCNL4000_PS_RESULT_HI,
> +						 &val);
> +			if (ret < 0)
> +				goto end;
> +
> +			buffer[0] = val;
> +			data_read = true;
> +		}
> +	}
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +					isr & VCNL4010_INT_DRDY);
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	if (ret < 0 || !data_read)
> +		goto end;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns(indio_dev));
> +
>  end:
> +	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
>  }
>  
> +static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int cmd;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> +	if (ret < 0)
> +		goto end;
> +
> +	/* Do not enable the buffer if we are already capturing events. */
> +	if ((ret & VCNL4000_SELF_TIMED_EN) > 0) {
> +		ret = -EBUSY;
> +		goto end;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
> +					VCNL4010_INT_PROX_EN);
> +	if (ret < 0)
> +		goto end;
> +
> +	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
> +	if (ret < 0)
> +		goto end;
> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	if (ret < 0)
> +		iio_triggered_buffer_predisable(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret, ret_disable;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	ret_disable = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret == 0)
> +		ret = ret_disable;
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
> +	.postenable = &vcnl4010_buffer_postenable,
> +	.predisable = &vcnl4010_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops vcnl4010_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	struct iio_trigger *trigger;
> +	int ret;
> +
> +	trigger = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +					 indio_dev->name, indio_dev->id);
> +	if (!trigger)
> +		return -ENOMEM;
> +
> +	trigger->dev.parent = &client->dev;
> +	trigger->ops = &vcnl4010_trigger_ops;
> +	iio_trigger_set_drvdata(trigger, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&client->dev, trigger);
> +	if (ret)
> +		return ret;

nitpick: 
return devm_iio_trigger_register
does the same thing.

> +
> +	return 0;
> +}
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -974,6 +1133,16 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (client->irq && data->chip_spec->irq_support) {
> +		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +						      NULL,
> +						      vcnl4010_trigger_handler,
> +						      &vcnl4010_buffer_ops);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"unable to setup iio triggered buffer\n");
> +			return ret;
> +		}
> +
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL, vcnl4010_irq_thread,
>  						IRQF_TRIGGER_FALLING |
> @@ -984,6 +1153,10 @@ static int vcnl4000_probe(struct i2c_client *client,
>  			dev_err(&client->dev, "irq request failed\n");
>  			return ret;
>  		}
> +
> +		ret = vcnl4010_probe_trigger(indio_dev);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
> @@ -1026,5 +1199,6 @@ static struct i2c_driver vcnl4000_driver = {
>  module_i2c_driver(vcnl4000_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
>  MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
>  MODULE_LICENSE("GPL");

