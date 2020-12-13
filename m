Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A982D8F34
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgLMSAS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 13:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLMSAS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 13:00:18 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F8A223C8;
        Sun, 13 Dec 2020 17:59:36 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:59:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     gabriele.mzt@gmail.com, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: acpi_als: Add trigger support
Message-ID: <20201213175932.575ff373@archlinux>
In-Reply-To: <20201210221541.1180448-3-gwendal@chromium.org>
References: <20201210221541.1180448-1-gwendal@chromium.org>
        <20201210221541.1180448-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Dec 2020 14:15:41 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> As some firmware does not notify on illuminance changes, add a
> trigger to be able to query light via software (sysfs-trigger or
> hrtrigger).
> 
> BUG=b:172408337
> TEST=Check iio_info reports the sensor as buffer capable:
> iio:device0: acpi-als (buffer capable)
> Check we can get data on demand on volteer:
> echo 1 > iio_sysfs_trigger/add_trigger
> cat trigger2/name > iio\:device0/trigger/current_trigger
> for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
>   echo 1 > $i
> done
> od -x /dev/iio\:device0&
> echo 1 > trigger2/trigger_now
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Probably need a rebase on top of what Andy picked up on.

thanks,

Jonathan

> ---
>  Changes in v3:
>  -- should not increase buffer pointer before call iio_push_buffer.
> 
>  drivers/iio/light/acpi-als.c | 92 ++++++++++++++++++++++++++----------
>  1 file changed, 67 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index ff0ecec65fae4..d506242eefabe 100644
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
> @@ -60,6 +64,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>  struct acpi_als {
>  	struct acpi_device	*device;
>  	struct mutex		lock;
> +	struct iio_trigger	*trig;
>  
>  	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
>  };
> @@ -103,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
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
> @@ -160,13 +152,46 @@ static const struct iio_info acpi_als_info = {
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
> +	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> +	if (ret < 0)
> +		goto out;
> +	*buffer = val;
> +
> +	/*
> +	 * when coming from own trigger via polls, set timestamp here.
> +	 * Given ACPI notifier is already in a thread and call function directly,
> +	 * there is no need to set the timestamp in the notify function.
> +	 */
> +	if (!pf->timestamp)
> +		pf->timestamp = iio_get_time_ns(indio_dev);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
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
> +	struct device *dev = &device->dev;
> +	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -177,19 +202,36 @@ static int acpi_als_add(struct acpi_device *device)
>  	mutex_init(&als->lock);
>  
>  	indio_dev->name = ACPI_ALS_DEVICE_NAME;
> -	indio_dev->dev.parent = &device->dev;
> +	indio_dev->dev.parent = dev;

This isn't there in my togreg branch any more as the core does it.

>  	indio_dev->info = &acpi_als_info;
> -	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = acpi_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>  
> -	buffer = devm_iio_kfifo_allocate(&device->dev);
> -	if (!buffer)
> +	als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					   indio_dev->name,
> +					   indio_dev->id);
> +	if (!als->trig)
>  		return -ENOMEM;
>  
> -	iio_device_attach_buffer(indio_dev, buffer);
> +	iio_trigger_set_drvdata(als->trig, indio_dev);
> +	ret = devm_iio_trigger_register(dev, als->trig);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Set hardware trigger by default to let events flow when
> +	 * BIOS support notification.
> +	 */
> +	indio_dev->trig = iio_trigger_get(als->trig);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      acpi_als_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
>  
> -	return devm_iio_device_register(&device->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct acpi_device_id acpi_als_device_ids[] = {

