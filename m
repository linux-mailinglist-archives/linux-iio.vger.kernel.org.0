Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11289387F3C
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351461AbhERSG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 14:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346758AbhERSG6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 14:06:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D395A61073;
        Tue, 18 May 2021 18:05:37 +0000 (UTC)
Date:   Tue, 18 May 2021 19:06:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 5/5 v2] iio: gyro: st_gyro: Support mount matrix
Message-ID: <20210518190655.5b054331@jic23-huawei>
In-Reply-To: <20210517233322.383043-5-linus.walleij@linaro.org>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
        <20210517233322.383043-5-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 01:33:22 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> Add support to read and present the mounting matrix on ST gyroscopes.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

See below for the exciting reason I noticed, but this needs a rebase
on top of Andy's series that added support for the lsm9ds0
as it changed a bunch of stuff in probe / remove.

> ---
> ChangeLog v1->v2:
> - New patch because why not.
> ---
>  drivers/iio/gyro/st_gyro_core.c | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index c8aa051995d3..bf06a531bed3 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -37,19 +37,36 @@
>  #define ST_GYRO_FS_AVL_500DPS			500
>  #define ST_GYRO_FS_AVL_2000DPS			2000
>  
> +static const struct iio_mount_matrix *
> +st_gyro_get_mount_matrix(const struct iio_dev *indio_dev,
> +			 const struct iio_chan_spec *chan)
> +{
> +	struct st_sensor_data *gdata = iio_priv(indio_dev);
> +
> +	return &gdata->mount_matrix;
> +}
> +
> +static const struct iio_chan_spec_ext_info st_gyro_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_gyro_get_mount_matrix),
> +	{ },
> +};
> +
>  static const struct iio_chan_spec st_gyro_16bit_channels[] = {
> -	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
> +	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
> -			ST_GYRO_DEFAULT_OUT_X_L_ADDR),
> -	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
> +			ST_GYRO_DEFAULT_OUT_X_L_ADDR,
> +			st_gyro_mount_matrix_ext_info),
> +	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
> -			ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
> -	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
> +			ST_GYRO_DEFAULT_OUT_Y_L_ADDR,
> +			st_gyro_mount_matrix_ext_info),
> +	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
> -			ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
> +			ST_GYRO_DEFAULT_OUT_Z_L_ADDR,
> +			st_gyro_mount_matrix_ext_info),
>  	IIO_CHAN_SOFT_TIMESTAMP(3)
>  };
>  
> @@ -478,6 +495,11 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->channels = gdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> +	err = iio_read_mount_matrix(gdata->dev, "mount-matrix",
> +				    &gdata->mount_matrix);
> +	if (err)
> +		goto st_gyro_power_off;

That label doesn't exist because Andy reworked the power handling recently.

> +
>  	gdata->current_fullscale = &gdata->sensor_settings->fs.fs_avl[0];
>  	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
>  

