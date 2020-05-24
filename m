Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF381DFF93
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEXO7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 10:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXO7s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:59:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3972B2075F;
        Sun, 24 May 2020 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590332387;
        bh=hUbItBAgSGlZqPVkWSi/SVUPdWhuXVn6bSIioJV3Lec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AF0H6dEnz5YsRDR1eB8CvYkEYnSvfX7HURkAxa+sCy2wVa3qfWsmDJYl2smasFBF3
         A1X0/IHAdaNmFYuxk+JdT/ocLEk7aRBC74TTKt5FoeuFfEIU+0qvIOYFpeDvgXOrSI
         c+sQab5ug0ToLnFdZYNPj8WWUePPf3k+epq4hVlM=
Date:   Sun, 24 May 2020 15:59:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 4/4] iio: magnetometer: ak8975: Add gpio reset
 support
Message-ID: <20200524155942.6efddf1f@archlinux>
In-Reply-To: <20200520163417.27805-5-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
        <20200520163417.27805-5-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 18:34:09 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> According to AK09911 datasheet, if reset gpio is provided then
> deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().
> 
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheet says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Looks good to me.  Just the minor stuff with the binding plus
giving time for a binding review to go.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index fd368455cd7b..a23422aad97d 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -358,6 +358,7 @@ struct ak8975_data {
>  	u8			asa[3];
>  	long			raw_to_gauss[3];
>  	struct gpio_desc	*eoc_gpiod;
> +	struct gpio_desc	*reset_gpiod;
>  	int			eoc_irq;
>  	wait_queue_head_t	data_ready_queue;
>  	unsigned long		flags;
> @@ -384,6 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  			 "Failed to enable specified Vid supply\n");
>  		return ret;
>  	}
> +
> +	gpiod_set_value_cansleep(data->reset_gpiod, 0);
> +
>  	/*
>  	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> @@ -396,6 +400,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  /* Disable attached power regulator if any. */
>  static void ak8975_power_off(const struct ak8975_data *data)
>  {
> +	gpiod_set_value_cansleep(data->reset_gpiod, 1);
> +
>  	regulator_disable(data->vid);
>  	regulator_disable(data->vdd);
>  }
> @@ -839,6 +845,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	struct ak8975_data *data;
>  	struct iio_dev *indio_dev;
>  	struct gpio_desc *eoc_gpiod;
> +	struct gpio_desc *reset_gpiod;
>  	const void *match;
>  	unsigned int i;
>  	int err;
> @@ -856,6 +863,16 @@ static int ak8975_probe(struct i2c_client *client,
>  	if (eoc_gpiod)
>  		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
>  
> +	/*
> +	 * According to AK09911 datasheet, if reset GPIO is provided then
> +	 * deassert reset on ak8975_power_on() and assert reset on
> +	 * ak8975_power_off().
> +	 */
> +	reset_gpiod = devm_gpiod_get_optional(&client->dev,
> +					      "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpiod))
> +		return PTR_ERR(reset_gpiod);
> +
>  	/* Register with IIO */
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (indio_dev == NULL)
> @@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
>  
>  	data->client = client;
>  	data->eoc_gpiod = eoc_gpiod;
> +	data->reset_gpiod = reset_gpiod;
>  	data->eoc_irq = 0;
>  
>  	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);

