Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E231C2AC6
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgECI47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 04:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgECI46 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 04:56:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD47F20757;
        Sun,  3 May 2020 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588496217;
        bh=RC7kkvhgnmnj3j6naxj4iLFAMtP7lr3RBoxjrDDPsRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtVriv5TyCXllnFxiTxQMqUusx0wWBEd1/+rJxweU9qZq6QuJjOhSvE7+/64oeFNM
         ha1BXglLBM0/1fe7QlW8ehnfK4GzqGeCfwe6G5dm+0HVm9gaQb/MoBSa/oqfo+CcoB
         iJCksepGrkbDy/+7Z7bNEDV43DycDsBfBMSVpokU=
Date:   Sun, 3 May 2020 09:56:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: vcnl4000: Add buffer support for
 VCNL4010/20.
Message-ID: <20200503095653.06ef5c93@archlinux>
In-Reply-To: <20200427095559.16131-6-m.othacehe@gmail.com>
References: <20200427095559.16131-1-m.othacehe@gmail.com>
        <20200427095559.16131-6-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 11:55:59 +0200
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

One odd bit of code structure. If you didn't need to respin to fix
patch 1's missing sign off I'd just fix it, but pleased tidy it up for v7.

Thanks,


Jonathan

> ---
>  drivers/iio/light/Kconfig    |   2 +
>  drivers/iio/light/vcnl4000.c | 161 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 161 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 74970f18a93b..05f61b1e223a 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -506,6 +506,8 @@ config US5182D
>  
>  config VCNL4000
>  	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VCNL4000,
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 65c0cf2b5037..5f3cc422c371 100644
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
> @@ -13,8 +14,7 @@
>   *
>   * TODO:
>   *   allow to adjust IR current
> - *   periodic ALS/proximity measurement (VCNL4010/20)
> - *   interrupts (VCNL4010/20/40, VCNL4200)
> + *   interrupts (VCNL4040, VCNL4200)
>   */
>  
>  #include <linux/module.h>
> @@ -24,9 +24,13 @@
>  #include <linux/pm_runtime.h>
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
> @@ -771,17 +775,26 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>  static const struct iio_chan_spec vcnl4010_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> +		.scan_index = -1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  	}, {
>  		.type = IIO_PROXIMITY,
> +		.scan_index = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.event_spec = vcnl4000_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
>  		.ext_info = vcnl4000_ext_info,
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
>  static const struct iio_info vcnl4000_info = {
> @@ -883,10 +896,139 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  					  isr & VCNL4010_INT_THR);
>  	}
>  
> +	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll_chained(indio_dev->trig);
> +
>  end:
>  	return IRQ_HANDLED;
>  }
>  
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
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
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
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +					isr & VCNL4010_INT_DRDY);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (!data_read)
> +		goto end;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns(indio_dev));
> +
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
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
> +	/* Do not enable the buffer if we are already capturing events. */
> +	if (vcnl4010_is_in_periodic_mode(data)) {
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

This function has a rather odd structure.

Add a return 0; here

> +
> +end:
> +	if (ret < 0)

and drop this if (ret < 0) as won't be able to get here otherwise.

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
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> +
> +end:
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
> +	return devm_iio_trigger_register(&client->dev, trigger);
> +}
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -923,6 +1065,16 @@ static int vcnl4000_probe(struct i2c_client *client,
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
> @@ -933,6 +1085,10 @@ static int vcnl4000_probe(struct i2c_client *client,
>  			dev_err(&client->dev, "irq request failed\n");
>  			return ret;
>  		}
> +
> +		ret = vcnl4010_probe_trigger(indio_dev);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	ret = pm_runtime_set_active(&client->dev);
> @@ -1028,5 +1184,6 @@ static struct i2c_driver vcnl4000_driver = {
>  module_i2c_driver(vcnl4000_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
>  MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
>  MODULE_LICENSE("GPL");

