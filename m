Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C962CFD77
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgLESec (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgLESe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 13:34:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2499023138;
        Sat,  5 Dec 2020 18:27:02 +0000 (UTC)
Date:   Sat, 5 Dec 2020 18:26:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     gabriele.mzt@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: acpi_als: Add trigger support
Message-ID: <20201205182659.7cd23d5b@archlinux>
In-Reply-To: <20201204203755.818932-1-gwendal@chromium.org>
References: <20201204203755.818932-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  4 Dec 2020 12:37:55 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add timestamp channel: use standard procedure to collect timestamp.
> As some firmware do not notify on illuminance changes, add a
> trigger to periodically query light.
> We can either use the device trigger, or a software trigger like sysfs
> or hrtimer.
> 
> This change is not backward compatible. To get samples from bios that
> supports notification, we need to register the hardware trigger first:
> 
> echo acpi-als-dev${X} > iio\:device${X}/trigger/current_trigger

That's a problem as we can't break backwards compatibility.
Note that you can set a default trigger for a device with

indio_dev->trig = iio_trigger_get(trig);
If we do that then it can still be overridden but at least
we don't break backwards compatibility.
We also have an immutable variant if we really don't want
it to be changed later but I don't think that is true here.

> 
> Check iio_info reports the sensor as buffer capable:
> iio:device0: acpi-als (buffer capable)
> Check we can get data on demand:
> echo 1 > iio_sysfs_trigger/add_trigger
> cat trigger2/name > iio\:device0/trigger/current_trigger
> for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
>   echo 1 > $i
> done
> od -x /dev/iio\:device0&
> echo 1 > trigger2/trigger_now
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/light/acpi-als.c | 86 +++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 1eafd0b24e182..2619e4b073a59 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -16,11 +16,15 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/err.h>
> +#include <linux/irq.h>
>  #include <linux/mutex.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #define ACPI_ALS_CLASS			"als"
>  #define ACPI_ALS_DEVICE_NAME		"acpi-als"
> @@ -45,22 +49,22 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>  		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
>  					  BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  /*
>   * The event buffer contains timestamp and all the data from
>   * the ACPI0008 block. There are multiple, but so far we only
> - * support _ALI (illuminance). Once someone adds new channels
> - * to acpi_als_channels[], the evt_buffer below will grow
> - * automatically.
> + * support _ALI (illuminance):
> + * One channel, paddind and timestamp.
>   */
> -#define ACPI_ALS_EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
>  #define ACPI_ALS_EVT_BUFFER_SIZE		\
> -	(sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
> +	(sizeof(s32) + sizeof(s32) + sizeof(s64))
>  
>  struct acpi_als {
>  	struct acpi_device	*device;
>  	struct mutex		lock;
> +	struct iio_trigger	*trig;
>  
>  	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
This gets used in iio_push_to_buffers_with_timestamp and that
has a few not well documented quirks (on list to fix)
In particular it relies on being able to put the timestamp in
the right place and side effect of that is that the buffer
passed to that function must be 8 byte aligned.
Note I've been working through fixing drivers for this but clearly
still some to go.

You can probably do that here with __aligned(8)

As a side note, isn't the buffer way too big?  I think should be
ACPI_ALS_EVT_BUFFER_SIZE / sizeof(u32)

>  };
> @@ -104,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>  {
>  	struct iio_dev *indio_dev = acpi_driver_data(device);
>  	struct acpi_als *als = iio_priv(indio_dev);
> -	s32 *buffer = als->evt_buffer;
> -	s64 time_ns = iio_get_time_ns(indio_dev);
> -	s32 val;
> -	int ret;
> -
> -	mutex_lock(&als->lock);
>  
> -	memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
> +	if (!iio_buffer_enabled(indio_dev) ||
> +	    !iio_trigger_using_own(indio_dev))
> +		return;
>  
>  	switch (event) {
>  	case ACPI_ALS_NOTIFY_ILLUMINANCE:
> -		ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> -		if (ret < 0)
> -			goto out;
> -		*buffer++ = val;
> +		iio_trigger_poll_chained(als->trig);

One issue with this path is it won't have set the poll function timestamp.
It's a long term problem that there is no way for a device to know with
certainty if the top half of it's trigger handler was ever called.

I have been thinking about adding accessors to pf->timestamp to set
and clear it which could also set a flag to say it had been set.
Hence the get would return an error if not and we could grab a local
timestamp if that happens as it would be the best available.

Anyhow, I would assume you will get all 0 timestamps currently.

>  		break;
>  	default:
>  		/* Unhandled event */
>  		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
>  			event);
> -		goto out;
>  	}
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
> -
> -out:
> -	mutex_unlock(&als->lock);
>  }
>  
>  static int acpi_als_read_raw(struct iio_dev *indio_dev,
> @@ -161,11 +152,37 @@ static const struct iio_info acpi_als_info = {
>  	.read_raw		= acpi_als_read_raw,
>  };
>  
> +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct acpi_als *als = iio_priv(indio_dev);
> +	s32 *buffer = als->evt_buffer;
> +	s32 val;
> +	int ret;
> +
> +	mutex_lock(&als->lock);
> +
> +	memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);

This shouldn't be needed. The buffer was originally kzalloc'd
I believe and we write all the values that might contain stale
data.

> +	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> +	if (ret < 0)
> +		goto out;
> +	*buffer++ = val;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer,
> +					   pf->timestamp);

Use buffer for evt_buffer here for consistency.

> +out:
> +	mutex_unlock(&als->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int acpi_als_add(struct acpi_device *device)
>  {
>  	struct acpi_als *als;
>  	struct iio_dev *indio_dev;
> -	struct iio_buffer *buffer;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>  	if (!indio_dev)
> @@ -180,15 +197,30 @@ static int acpi_als_add(struct acpi_device *device)
>  	indio_dev->name = ACPI_ALS_DEVICE_NAME;
>  	indio_dev->dev.parent = &device->dev;
>  	indio_dev->info = &acpi_als_info;
> -	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = acpi_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>  
> -	buffer = devm_iio_kfifo_allocate(&device->dev);
> -	if (!buffer)
> +	als->trig = devm_iio_trigger_alloc(&device->dev,
> +					   "%s-dev%d",
> +					   indio_dev->name,
> +					   indio_dev->id);
> +	if (!als->trig)
>  		return -ENOMEM;
>  
> -	iio_device_attach_buffer(indio_dev, buffer);
> +	als->trig->dev.parent = &device->dev;

Hmm. we should probably push this boilerplate into
devm_iio_trigger_alloc() like we have done for iio devices.

> +	iio_trigger_set_drvdata(als->trig, indio_dev);
> +	ret = iio_trigger_register(als->trig);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(&device->dev,
> +					      indio_dev,
> +					      iio_pollfunc_store_time,
> +					      acpi_als_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
>  
>  	return devm_iio_device_register(&device->dev, indio_dev);
>  }

