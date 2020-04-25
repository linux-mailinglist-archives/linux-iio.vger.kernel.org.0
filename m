Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474681B891E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDYTrJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgDYTrJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:47:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2474C2072B;
        Sat, 25 Apr 2020 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587844028;
        bh=2PXwPvoTzGameVsSPprQQ05E3/iCADOfkMqcsSzvFiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wzf8B5cV5QYUoea4OeeTHQ6Trmp9l6ABGbnweap3hKQs6rmS4/ADG4Tlj2ULZUI94
         xzAELRWpMAcPhMGO3v9bnr8ZXY+sFPW2r9YTEaeuGQvXZL7i7rofutOzWVbJBnUupn
         REv92SyBE0occ3wNjEJASrIvSxPHrFOwrFWI3J1k=
Date:   Sat, 25 Apr 2020 20:47:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: vcnl4000: Add event support for
 VCNL4010/20.
Message-ID: <20200425204704.2c4dd1ab@archlinux>
In-Reply-To: <20200421075532.19192-3-m.othacehe@gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-3-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 09:55:30 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> The VCNL4010 and VCNL4020 chips are able to raise interrupts on proximity
> threshold events. Add support for threshold rising and falling events for
> those two chips.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
...
> +
> +static const struct iio_chan_spec vcnl4010_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.scan_index = -1,

Why introduce scan index here?  That's only used for buffers.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.scan_index = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = vcnl4000_event_spec,
> +		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
> +		.ext_info = vcnl4000_ext_info,
> +	},
> +};
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
>  };
>  
> +static const struct iio_info vcnl4010_info = {
> +	.read_raw = vcnl4010_read_raw,
> +	.read_event_value = vcnl4010_read_event,
> +	.write_event_value = vcnl4010_write_event,
> +	.read_event_config = vcnl4010_read_event_config,
> +	.write_event_config = vcnl4010_write_event_config,
> +};
> +
> +static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> +	[VCNL4000] = {
> +		.prod = "VCNL4000",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4010] = {
> +		.prod = "VCNL4010/4020",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
> +		.channels = vcnl4010_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4010_channels),
> +		.info = &vcnl4010_info,
> +		.irq_support = true,
> +	},
> +	[VCNL4040] = {
> +		.prod = "VCNL4040",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4200] = {
> +		.prod = "VCNL4200",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +};
> +
> +static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	unsigned long isr;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +	if (ret < 0)
> +		goto end;
> +
> +	isr = ret;
> +
> +	if (isr & VCNL4010_INT_THR) {
> +		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       1,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       1,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_RISING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +					  isr & VCNL4010_INT_THR);
> +	}
> +
> +end:
> +	return IRQ_HANDLED;
> +}
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -486,12 +805,25 @@ static int vcnl4000_probe(struct i2c_client *client,
>  		data->near_level = 0;
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &vcnl4000_info;
> -	indio_dev->channels = vcnl4000_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
> +	indio_dev->info = data->chip_spec->info;
> +	indio_dev->channels = data->chip_spec->channels;
> +	indio_dev->num_channels = data->chip_spec->num_channels;
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (client->irq && data->chip_spec->irq_support) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, vcnl4010_irq_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"vcnl4010_irq",
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "irq request failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0)
>  		goto fail_poweroff;

