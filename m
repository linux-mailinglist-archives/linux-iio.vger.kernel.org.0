Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4718381DB3
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhEPJsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 05:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhEPJsN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:48:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E434961004;
        Sun, 16 May 2021 09:46:56 +0000 (UTC)
Date:   Sun, 16 May 2021 10:48:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
Message-ID: <20210516104808.49a5d3e5@jic23-huawei>
In-Reply-To: <20210515000058.204601-1-linus.walleij@linaro.org>
References: <20210515000058.204601-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 May 2021 02:00:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The ST accelerators support a special type of quirky
> mounting matrix found in ACPI systems, but not a generic
> mounting matrix such as from the device tree.
> 
> Augment the ACPI hack to be a bit more generic and
> accept a mounting matrix from device properties.
> 
> This makes it possible to fix orientation on the Ux500
> HREF device.
Hi Linus,

Why wrap at 58ish columns?  75 please as it looks nicer :)

What you have here is fine, but I think there is room to tidy
up a little more given we now always have the mount matrix.

Thanks,

Jonathan

> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/st_accel_core.c | 51 ++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 43c50167d220..cfbcf740e3cb 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1069,26 +1069,25 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> -#ifdef CONFIG_ACPI
>  static const struct iio_mount_matrix *
> -get_mount_matrix(const struct iio_dev *indio_dev,
> -		 const struct iio_chan_spec *chan)
> +st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
>  	return adata->mount_matrix;
>  }
>  
> -static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
> +static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
>  	{ },
>  };
>  
> +#ifdef CONFIG_ACPI
>  /* Read ST-specific _ONT orientation data from ACPI and generate an
>   * appropriate mount matrix.
>   */
> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> -				  struct iio_chan_spec *channels)
> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -1207,22 +1206,20 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> -	/* Expose the mount matrix via ext_info */
> -	for (i = 0; i < indio_dev->num_channels; i++)
> -		channels[i].ext_info = mount_matrix_ext_info;
> -
>  	ret = 0;
>  	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
>  
>  out:
>  	kfree(buffer.pointer);
> +	dev_warn(&indio_dev->dev,
> +		 "failed to apply ACPI orientation data: %d\n", ret);
> +

As it would be valid to have a new ACPI table that uses a mount_matrix property
rather than the ONT mess, perhaps we should demote the warnings to debug?

>  	return ret;
>  }
>  #else /* !CONFIG_ACPI */
> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> -				  struct iio_chan_spec *channels)
> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  {
> -	return 0;
> +	return -EINVAL;
>  }
>  #endif
>  
> @@ -1251,6 +1248,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	struct iio_chan_spec *channels;
>  	size_t channels_size;
>  	int err;
> +	int i;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &accel_info;
> @@ -1275,9 +1273,28 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  		goto st_accel_power_off;
>  	}
>  
> -	if (apply_acpi_orientation(indio_dev, channels))
> -		dev_warn(&indio_dev->dev,
> -			 "failed to apply ACPI orientation data: %d\n", err);
> +	/* First try ACPI orientation then try the generic function */
> +	err = apply_acpi_orientation(indio_dev);
> +	if (err) {
> +		adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
> +						   sizeof(*adata->mount_matrix),
> +						   GFP_KERNEL);
> +		if (!adata->mount_matrix) {
> +			err = -ENOMEM;
> +			goto st_accel_power_off;
> +		}
> +
> +		err = iio_read_mount_matrix(adata->dev, "mount-matrix",
> +					    adata->mount_matrix);
> +		if (err)
> +			goto st_accel_power_off;
> +	}
> +	/*
> +	 * We have at least an identity matrix, so expose the mount
> +	 * matrix via ext_info
> +	 */
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		channels[i].ext_info = st_accel_mount_matrix_ext_info;

The current handling of this is odd.  As the comment points out we are providing
an orientation matrix whatever happens.

As such I'm fairly sure we can rip out the duplication of the channels and just
use the static ones, but with ext_info always set.

Having done that you could also embed the mount_matrix in the private data and
avoid the need to for a separate allocation.  I guess that might add some small
overhead to those sensors where orientation doesn't make sense, but I think the
simplification is probably worth it.


>  
>  	indio_dev->channels = channels;
>  	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];

