Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2E39D2C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFHLXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfFHLXc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:23:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDFD2146E;
        Sat,  8 Jun 2019 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993010;
        bh=6CTSTufkvionRt3c5R+LNs00e91X4cgfxmxmgF+pKhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rN5u7arwjYEf4bjASDpdIRBgM/kAhADDv5jVFhSQLcEGIG9DvV2lno3WxX5k63ljM
         12tZayWm4d0vmN6N+7hMlJ2CpV0wlN9rPIljTPq6nZIKPDUt6T4yN+zd/cHTiflmKg
         q/y8W1Uwo/SPP1g1J/kkciuxk8B/8FiRIxZuywls=
Date:   Sat, 8 Jun 2019 12:23:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7606: Move oversampling and scale
 options to chip info
Message-ID: <20190608122325.6aeb7fdf@archlinux>
In-Reply-To: <20190527125650.2405-1-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 May 2019 15:56:47 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The device dependent options which are going to be different for devices
> which will be supported  in the future by this driver,
> were moved in chip info for a more generic driver. This patch allows
> supporting more devices by the driver. Also, it is an intermediate
> step of adding support for ad7616 in software mode.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c | 61 +++++++++++++++++++++++++++++-----------
>  drivers/iio/adc/ad7606.h | 15 +++++++++-
>  2 files changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 24c70c3cefb4..c66ff22f32d2 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -158,7 +158,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> -		*val2 = st->scale_avail[st->range];
> +		*val2 = st->scale_avail[st->range[0]];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->oversampling;
> @@ -194,6 +194,32 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
>  
>  static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
>  
> +static int ad7606_write_scale_hw(struct iio_dev *indio_dev, int ch, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	gpiod_set_value(st->gpio_range, val);
> +
> +	return 0;
> +}
> +
> +static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	DECLARE_BITMAP(values, 3);
> +
> +	values[0] = val;
> +
> +	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> +			      st->gpio_os->info, values);
> +
> +	/* AD7616 requires a reset to update value */
> +	if (st->chip_info->os_req_reset)
> +		ad7606_reset(st);
> +
> +	return 0;
> +}
> +
>  static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val,
> @@ -201,15 +227,18 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	DECLARE_BITMAP(values, 3);
> -	int i;
> +	int i, ret, ch = 0;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		mutex_lock(&st->lock);
>  		i = find_closest(val2, st->scale_avail, st->num_scales);
> -		gpiod_set_value(st->gpio_range, i);
> -		st->range = i;
> +		ret = st->write_scale(indio_dev, chan->address, i);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +		st->range[ch] = i;
>  		mutex_unlock(&st->lock);
>  
>  		return 0;
> @@ -218,17 +247,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		i = find_closest(val, st->oversampling_avail,
>  				 st->num_os_ratios);
> -
> -		values[0] = i;
> -
>  		mutex_lock(&st->lock);
> -		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> -				      st->gpio_os->info, values);
> -
> -		/* AD7616 requires a reset to update value */
> -		if (st->chip_info->os_req_reset)
> -			ad7606_reset(st);
> -
> +		ret = st->write_os(indio_dev, i);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
>  		st->oversampling = st->oversampling_avail[i];
>  		mutex_unlock(&st->lock);
>  
> @@ -536,7 +560,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st->bops = bops;
>  	st->base_address = base_address;
>  	/* tied to logic low, analog input range is +/- 5V */
> -	st->range = 0;
> +	st->range[0] = 0;
>  	st->oversampling = 1;
>  	st->scale_avail = ad7606_scale_avail;
>  	st->num_scales = ARRAY_SIZE(ad7606_scale_avail);
> @@ -589,6 +613,9 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> +	st->write_scale = ad7606_write_scale_hw;
> +	st->write_os = ad7606_write_os_hw;
> +
>  	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>  					  indio_dev->name, indio_dev->id);
>  	if (!st->trig)
> @@ -643,7 +670,7 @@ static int ad7606_resume(struct device *dev)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	if (st->gpio_standby) {
> -		gpiod_set_value(st->gpio_range, st->range);
> +		gpiod_set_value(st->gpio_range, st->range[0]);
>  		gpiod_set_value(st->gpio_standby, 1);
>  		ad7606_reset(st);
>  	}
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index f9ef52131e74..143c30163df9 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -16,6 +16,12 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail array
>   * @os_req_reset	some devices require a reset to update oversampling
> + * @write_scale_sw	pointer to the function which writes the scale via spi
> +			in software mode
> + * @write_os_sw		pointer to the function which writes the os via spi
> +			in software mode
> + * @sw_mode_config:	pointer to a function which configured the device
> + *			for software mode
>   */
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
> @@ -23,6 +29,9 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> +	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
> +	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
> +	int (*sw_mode_config)(struct iio_dev *indio_dev);
>  };
>  
>  /**
> @@ -39,6 +48,8 @@ struct ad7606_chip_info {
>   * @oversampling_avail	pointer to the array which stores the available
>   *			oversampling ratios.
>   * @num_os_ratios	number of elements stored in oversampling_avail array
> + * @write_scale		pointer to the function which writes the scale
> + * @write_os		pointer to the function which writes the os
>   * @lock		protect sensor state from concurrent accesses to GPIOs
>   * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
>   * @gpio_reset		GPIO descriptor for device hard-reset
> @@ -57,13 +68,15 @@ struct ad7606_state {
>  	const struct ad7606_chip_info	*chip_info;
>  	struct regulator		*reg;
>  	const struct ad7606_bus_ops	*bops;
> -	unsigned int			range;
> +	unsigned int			range[16];
>  	unsigned int			oversampling;
>  	void __iomem			*base_address;
>  	const unsigned int		*scale_avail;
>  	unsigned int			num_scales;
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			num_os_ratios;
> +	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
> +	int (*write_os)(struct iio_dev *indio_dev, int val);
>  
>  	struct mutex			lock; /* protect sensor state */
>  	struct gpio_desc		*gpio_convst;

