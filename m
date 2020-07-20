Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339DE225D4B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgGTLX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTLX6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:23:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148C522B4E;
        Mon, 20 Jul 2020 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595244237;
        bh=UF3MdBxPLXBCdD0d8PTdDFiJPJXe+kzFDUqM3S8/8fE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FfnJM33QyCd/wJC1AO7K+AE/IQw/AEjr3JhdIof72g8XnqvxQ+QtLxCeMytXn6ZvF
         m3kBza02CsipuV7Vzg+zkl0U7VORK0rPHBLzFdk02xF7BqK76pq9oIrKWNRhfYRaaK
         Ws2cEj0dQAcjLimwYX2XtVHHRwYCB9rKnvjijMiQ=
Date:   Mon, 20 Jul 2020 12:23:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: accel: bma400: add PM_SLEEP support
Message-ID: <20200720122352.56846215@archlinux>
In-Reply-To: <20200715050226.9751-2-dan@dlrobertson.com>
References: <20200715050226.9751-1-dan@dlrobertson.com>
        <20200715050226.9751-2-dan@dlrobertson.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 01:02:26 -0400
Dan Robertson <dan@dlrobertson.com> wrote:

>  - Add system sleep ops if CONFIG_PM_SLEEP is set.
>  - Add attribute for setting the power mode of the
>    device.

This second part is a problem because power modes tend to be extremely
device specific.  Hence generic userspace is near impossible.

So what we try to do is to map these as much as possible to
things that the driver can figure out for itself, such as switching
parameters of how things are captured (sampling frequency etc) or
runtime pm.

Whilst this may not cover 'all' usecases, it will cover a lot more
than implementing a custom attribute.

As a side note, a custom attribute also need Docs
in Documentation/ABI/testing/sysfs-bus-iio-*

Thanks,

Jonathan


> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  drivers/iio/accel/bma400.h      |   3 +
>  drivers/iio/accel/bma400_core.c | 132 ++++++++++++++++++++++++--------
>  drivers/iio/accel/bma400_i2c.c  |   1 +
>  drivers/iio/accel/bma400_spi.c  |   1 +
>  4 files changed, 107 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 5ad10db9819f..e9dd9e918aac 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -10,6 +10,7 @@
>  #define _BMA400_H_
>  
>  #include <linux/bits.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  /*
> @@ -96,4 +97,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
>  
>  int bma400_remove(struct device *dev);
>  
> +extern const struct dev_pm_ops bma400_pm_ops;
> +
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index cc77f89c048b..5af57b8e1fd7 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -147,36 +147,6 @@ bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
>  	return &data->orientation;
>  }
>  
> -static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
> -	{ }
> -};

It would be helpful to do this reorganizing as a precursor patch where
nothing functional changes.   Then we can see very quickly what is new
in the functional changes.

> -
> -#define BMA400_ACC_CHANNEL(_axis) { \
> -	.type = IIO_ACCEL, \
> -	.modified = 1, \
> -	.channel2 = IIO_MOD_##_axis, \
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> -		BIT(IIO_CHAN_INFO_SCALE) | \
> -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> -	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> -		BIT(IIO_CHAN_INFO_SCALE) | \
> -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> -	.ext_info = bma400_ext_info, \
> -}
> -
> -static const struct iio_chan_spec bma400_channels[] = {
> -	BMA400_ACC_CHANNEL(X),
> -	BMA400_ACC_CHANNEL(Y),
> -	BMA400_ACC_CHANNEL(Z),
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	},
> -};
> -
>  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
>  {
>  	unsigned int raw_temp;
> @@ -542,6 +512,73 @@ static int bma400_set_power_mode(struct bma400_data *data,
>  	return 0;
>  }
>  
> +static const char * const bma400_power_modes[] = {
> +	"sleep",
> +	"low-power",
> +	"normal"
> +};
> +
> +int bma400_power_mode_enum_get(struct iio_dev *dev,
> +			       const struct iio_chan_spec *chan)
> +{
> +	struct bma400_data *data = iio_priv(dev);
> +
> +	return data->power_mode;
> +}
> +
> +int bma400_power_mode_enum_set(struct iio_dev *dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int mode)
> +{
> +	struct bma400_data *data = iio_priv(dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bma400_set_power_mode(data, mode);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_enum bma400_power_mode_enum = {
> +	.items = bma400_power_modes,
> +	.num_items = ARRAY_SIZE(bma400_power_modes),
> +	.get = bma400_power_mode_enum_get,
> +	.set = bma400_power_mode_enum_set,
> +};
> +
> +static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> +	IIO_ENUM("power_mode", true, &bma400_power_mode_enum),
> +	IIO_ENUM_AVAILABLE("power_mode", &bma400_power_mode_enum),
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
> +	{ }
> +};
> +
> +#define BMA400_ACC_CHANNEL(_axis) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_##_axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.ext_info = bma400_ext_info, \
> +}
> +
> +static const struct iio_chan_spec bma400_channels[] = {
> +	BMA400_ACC_CHANNEL(X),
> +	BMA400_ACC_CHANNEL(Y),
> +	BMA400_ACC_CHANNEL(Z),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	},
> +};
> +
>  static void bma400_init_tables(void)
>  {
>  	int raw;
> @@ -848,6 +885,41 @@ int bma400_remove(struct device *dev)
>  }
>  EXPORT_SYMBOL(bma400_remove);
>  
> +#ifdef CONFIG_PM_SLEEP

Ifdef protections around PM functions tend to go wrong so usually
better to just mark them __maybe_unused and rely on the
linker removing them if they aren't.

> +static int bma400_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bma400_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +#endif
> +
> +const struct dev_pm_ops bma400_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	SET_SYSTEM_SLEEP_PM_OPS(bma400_suspend, bma400_resume)
> +#endif
> +};
> +EXPORT_SYMBOL(bma400_pm_ops);
> +
>  MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
>  MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
> index 9dcb7cc9996e..52a779d53629 100644
> --- a/drivers/iio/accel/bma400_i2c.c
> +++ b/drivers/iio/accel/bma400_i2c.c
> @@ -48,6 +48,7 @@ static struct i2c_driver bma400_i2c_driver = {
>  	.driver = {
>  		.name = "bma400",
>  		.of_match_table = bma400_of_i2c_match,
> +		.pm = &bma400_pm_ops
>  	},
>  	.probe    = bma400_i2c_probe,
>  	.remove   = bma400_i2c_remove,
> diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
> index 7c2825904e08..358bd26ac4cd 100644
> --- a/drivers/iio/accel/bma400_spi.c
> +++ b/drivers/iio/accel/bma400_spi.c
> @@ -108,6 +108,7 @@ static struct spi_driver bma400_spi_driver = {
>  	.driver = {
>  		.name = "bma400",
>  		.of_match_table = bma400_of_spi_match,
> +		.pm = &bma400_pm_ops
>  	},
>  	.probe    = bma400_spi_probe,
>  	.remove   = bma400_spi_remove,
> 

