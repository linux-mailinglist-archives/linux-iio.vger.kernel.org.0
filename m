Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFF185C63
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgCOMix (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgCOMiw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:38:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8917420663;
        Sun, 15 Mar 2020 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584275931;
        bh=cqwgLqt5EOmw8nz46J2EWgvah02dAa9uuwJ2IOEsKJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iXQ7LF9A2Jsx0hxSdAL6mIvYM0yQYJhpJAECrLzh10V1q3V0IraxoPuW+DEl5PvDD
         LKTHkDsPDp4auu5/2MxEUpaRikfDmnKh7XWe4Rv6AyGWLJN7oJT5JhPmD+6lFt6Cj7
         03o4khomm2V+z1oRKb7JK91hq9qJ7eCbGcvRNb+k=
Date:   Sun, 15 Mar 2020 12:38:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 3/8] iio: st_sensors: Drop unneeded explicit castings
Message-ID: <20200315123847.177c7a2e@archlinux>
In-Reply-To: <20200313104955.30423-3-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In few places the unnecessary explicit castings are being used.
> Drop them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.  Thanks,

Jonathan

> ---
> v2: more conversions to cast-less approach
>  drivers/iio/accel/st_accel_buffer.c             | 3 +--
>  drivers/iio/accel/st_accel_core.c               | 3 +--
>  drivers/iio/common/st_sensors/st_sensors_core.c | 3 +--
>  drivers/iio/gyro/st_gyro_buffer.c               | 3 +--
>  drivers/iio/gyro/st_gyro_core.c                 | 9 +++++----
>  drivers/iio/magnetometer/st_magn_core.c         | 3 +--
>  drivers/iio/pressure/st_pressure_core.c         | 4 +---
>  7 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index 9f2b40474b8e..b5c814ef1637 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -37,8 +37,7 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		return err;
>  
> -	err = st_sensors_set_axis_enable(indio_dev,
> -					 (u8)indio_dev->active_scan_mask[0]);
> +	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
>  	if (err < 0)
>  		goto st_accel_buffer_predisable;
>  
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 5f7bdb1f55d1..e2ec5d127495 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1203,8 +1203,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  			 "failed to apply ACPI orientation data: %d\n", err);
>  
>  	indio_dev->channels = channels;
> -	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -					&adata->sensor_settings->fs.fs_avl[0];
> +	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
>  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	if (!pdata)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index e051edbc43c1..804a9068e687 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -150,8 +150,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
>  	if (err < 0)
>  		goto st_accel_set_fullscale_error;
>  
> -	sdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -					&sdata->sensor_settings->fs.fs_avl[i];
> +	sdata->current_fullscale = &sdata->sensor_settings->fs.fs_avl[i];
>  	return err;
>  
>  st_accel_set_fullscale_error:
> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> index 7465ad62391c..9c92ff7a82be 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -37,8 +37,7 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		return err;
>  
> -	err = st_sensors_set_axis_enable(indio_dev,
> -					 (u8)indio_dev->active_scan_mask[0]);
> +	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
>  	if (err < 0)
>  		goto st_gyro_buffer_predisable;
>  
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 26c50b24bc08..c8aa051995d3 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -460,6 +460,7 @@ EXPORT_SYMBOL(st_gyro_get_settings);
>  int st_gyro_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);
> +	struct st_sensors_platform_data *pdata;
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -477,12 +478,12 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->channels = gdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> -	gdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -					&gdata->sensor_settings->fs.fs_avl[0];
> +	gdata->current_fullscale = &gdata->sensor_settings->fs.fs_avl[0];
>  	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
>  
> -	err = st_sensors_init_sensor(indio_dev,
> -				(struct st_sensors_platform_data *)&gyro_pdata);
> +	pdata = (struct st_sensors_platform_data *)&gyro_pdata;
> +
> +	err = st_sensors_init_sensor(indio_dev, pdata);
>  	if (err < 0)
>  		goto st_gyro_power_off;
>  
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index e68184a93a6d..79de721e6015 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -506,8 +506,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->channels = mdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> -	mdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -					&mdata->sensor_settings->fs.fs_avl[0];
> +	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
>  	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	err = st_sensors_init_sensor(indio_dev, NULL);
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 8bb47c3b4d6b..789a2928504a 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -707,9 +707,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->channels = press_data->sensor_settings->ch;
>  	indio_dev->num_channels = press_data->sensor_settings->num_ch;
>  
> -	press_data->current_fullscale =
> -		(struct st_sensor_fullscale_avl *)
> -			&press_data->sensor_settings->fs.fs_avl[0];
> +	press_data->current_fullscale = &press_data->sensor_settings->fs.fs_avl[0];
>  
>  	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
>  

