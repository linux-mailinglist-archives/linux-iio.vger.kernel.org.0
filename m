Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C815890FB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfHKJLn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 05:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfHKJLn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 05:11:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9350A2084D;
        Sun, 11 Aug 2019 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565514701;
        bh=UeK7zci9uKHXfrZYH/fcycr/Yvcpg2tE6NeJTPCdp0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=paMvk4y2HZmuf6GqRZtZrb5T8NaGAPlYqvmHooZbo5W5odMZUlaxG93OtSc+k1ILy
         nuIj28oKqC6e/oviehKiUolkbbvXBY63y8MN7fTfHGlqMozYWfaICgHaQsYkNeIymy
         Mh9ZpknR+adtm9hfudW/nydjvtfoj/VsP+S5IUdg=
Date:   Sun, 11 Aug 2019 10:11:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: iio: Is storing output values to non volatile registers something
 we should do automatically or leave to userspace action.  [was Re: [PATCH]
 iio: potentiometer: max5432: update the non-volatile position]
Message-ID: <20190811101137.5bd495e9@archlinux>
In-Reply-To: <20190809160617.21035-1-martin@kaiser.cx>
References: <20190809160617.21035-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  9 Aug 2019 18:06:17 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Keep track of the wiper position that was set by user space. Store the
> current wiper position in the chip's non-volatile register when the
> system is rebooted. This will be the initial position next time the
> max5432 chip is powered.
> 
> Update the register in the i2c client's shutdown function. Unlike the
> remove function, shutdown is called when the system is rebooted. It's
> safe to send an i2c message in the shutdown function.
> 
> Skip the update if user space never changed the wiper position.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Hi Martin,

The patch is fine, but I'm wondering about whether we need some element
of policy control on this restore to current value.

A few things to take into account.

* Some devices don't have a non volatile store.  So userspace will be
  responsible for doing the restore on reboot.
* This may be one of several related devices, and it may make no sense
  to restore this one if the others aren't going to be in the same
  state as before the reboot.
* Some devices only have non volatile registers for this sort of value
  (or save to non volatile on removal of power). Hence any policy to
  not store the value can't apply to this class of device.

My initial thought is that these probably don't matter that much and
we should apply this, but I would like to seek input from others!

I thought there were some other drivers doing similar store to no
volatile but I can't find one.

Thanks,

Jonathan

> ---
> The patch is against the testing branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> It seems that this branch is not merged into linux-next.
> 
>  drivers/iio/potentiometer/max5432.c | 43 +++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
> index 641b1821fdf6..73449078c89b 100644
> --- a/drivers/iio/potentiometer/max5432.c
> +++ b/drivers/iio/potentiometer/max5432.c
> @@ -16,16 +16,33 @@
>  
>  /* All chip variants have 32 wiper positions. */
>  #define MAX5432_MAX_POS 31
> +/*
> + * Initial value when the wiper position is unknown.
> + * (The chip does not support reading the current position.)
> + */
> +#define MAX5432_INVALID_POS (MAX5432_MAX_POS + 1)
>  
>  #define MAX5432_OHM_50K   (50  * 1000)
>  #define MAX5432_OHM_100K  (100 * 1000)
>  
>  /* Update the volatile (currently active) setting. */
>  #define MAX5432_CMD_VREG  0x11
> +/*
> + * Update the non-volatile setting that's used to initialize the wiper
> + * at startup.
> + */
> +#define MAX5432_CMD_NVREG 0x21
> +
> +/*
> + * Wiper position is in bits D7-D3 of the data byte.
> + * (D2-D0 are don't care bits.)
> + */
> +#define WIPER_POS_DATA(pos) ((pos) << 3)
>  
>  struct max5432_data {
>  	struct i2c_client *client;
>  	unsigned long ohm;
> +	u8 wiper_pos;
>  };
>  
>  static const struct iio_chan_spec max5432_channels[] = {
> @@ -63,7 +80,6 @@ static int max5432_write_raw(struct iio_dev *indio_dev,
>  			int val, int val2, long mask)
>  {
>  	struct max5432_data *data = iio_priv(indio_dev);
> -	u8 data_byte;
>  
>  	if (mask != IIO_CHAN_INFO_RAW)
>  		return -EINVAL;
> @@ -74,10 +90,10 @@ static int max5432_write_raw(struct iio_dev *indio_dev,
>  	if (val2 != 0)
>  		return -EINVAL;
>  
> -	/* Wiper position is in bits D7-D3. (D2-D0 are don't care bits.) */
> -	data_byte = val << 3;
> +	data->wiper_pos = val;
> +
>  	return i2c_smbus_write_byte_data(data->client, chan->address,
> -			data_byte);
> +			WIPER_POS_DATA(data->wiper_pos));
>  }
>  
>  static const struct iio_info max5432_info = {
> @@ -101,6 +117,7 @@ static int max5432_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	data->ohm = (unsigned long)of_device_get_match_data(dev);
> +	data->wiper_pos = MAX5432_INVALID_POS;
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &max5432_info;
> @@ -111,6 +128,23 @@ static int max5432_probe(struct i2c_client *client,
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> +static void max5432_shutdown(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max5432_data *data;
> +
> +	indio_dev = i2c_get_clientdata(client);
> +	if (!indio_dev)
> +		return;
> +
> +	data = iio_priv(indio_dev);
> +	if (data->wiper_pos == MAX5432_INVALID_POS)
> +		return;
> +
> +	i2c_smbus_write_byte_data(client, MAX5432_CMD_NVREG,
> +			WIPER_POS_DATA(data->wiper_pos));
> +}
> +
>  static const struct of_device_id max5432_dt_ids[] = {
>  	{ .compatible = "maxim,max5432", .data = (void *)MAX5432_OHM_50K  },
>  	{ .compatible = "maxim,max5433", .data = (void *)MAX5432_OHM_100K },
> @@ -126,6 +160,7 @@ static struct i2c_driver max5432_driver = {
>  		.of_match_table = of_match_ptr(max5432_dt_ids),
>  	},
>  	.probe = max5432_probe,
> +	.shutdown = max5432_shutdown,
>  };
>  
>  module_i2c_driver(max5432_driver);

