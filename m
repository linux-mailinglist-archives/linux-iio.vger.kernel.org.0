Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD766F46B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGURsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 13:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfGURsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 13:48:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39322085A;
        Sun, 21 Jul 2019 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563731290;
        bh=up6Jtk2OSGVdAcdvzgy8sSG8CuIzcQLrEoP0z/a5CPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GT8HeiyVCiXfUH99++JYK0l+F/Gi/xWW3IGVoj/d4cvN4LVZeGAsfyr0S/DL1T9Ij
         9bQ2+cCwNh8DhPi7OUqj/5FMttqBKMHFXCgGGifIABsILsoSyuGNC0A8uGLZaPVBZX
         YgQVhaIpmW9DoaI6soYhG47gRiJM9Bdx9JxL1a8g=
Date:   Sun, 21 Jul 2019 18:48:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] iio:common:st_sensors: add
 st_sensors_get_settings_index() helper function
Message-ID: <20190721184805.57cd0687@archlinux>
In-Reply-To: <20190718225353.2078-2-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-2-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:43 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> Extract from st_sensors_check_device_support() function the code that
> is used to get the specific settings for a device. This will be used
> as generic extractor by each ST driver.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>  return immediately in st_sensors_settings_index after device name is found
>  remove err initialization inside st_sensors_check_device_support
>  
>  .../iio/common/st_sensors/st_sensors_core.c   | 49 +++++++++++++------
>  include/linux/iio/common/st_sensors.h         |  4 ++
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 8b22dc241482..3610ca9eaa87 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -633,28 +633,47 @@ static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +/*
> + * st_sensors_get_settings_index() - get index of the sensor settings for a
> + *				     specific device from list of settings
> + * @name: device name buffer reference.
> + * @list: sensor settings list.
> + * @list_length: length of sensor settings list.
> + *
> + * Return: non negative number on success (valid index),
> + *	   negative error code otherwise.
> + */
> +int st_sensors_get_settings_index(const char *name,
> +				  const struct st_sensor_settings *list,
> +				  const int list_length)
> +{
> +	int i, n;
> +
> +	for (i = 0; i < list_length; i++) {
> +		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
> +			if (strcmp(name, list[i].sensors_supported[n]) == 0)
> +				return i;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL(st_sensors_get_settings_index);
> +
>  int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  			int num_sensors_list,
>  			const struct st_sensor_settings *sensor_settings)
>  {
> -	int i, n, err = 0;
> -	u8 wai;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	int i, err;
> +	u8 wai;
>  
> -	for (i = 0; i < num_sensors_list; i++) {
> -		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
> -			if (strcmp(indio_dev->name,
> -				sensor_settings[i].sensors_supported[n]) == 0) {
> -				break;
> -			}
> -		}
> -		if (n < ST_SENSORS_MAX_4WAI)
> -			break;
> -	}
> -	if (i == num_sensors_list) {
> +	i = st_sensors_get_settings_index(indio_dev->name,
> +					  sensor_settings, num_sensors_list);
> +	if (i < 0) {
>  		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
> -							indio_dev->name);
> -		return -ENODEV;
> +			indio_dev->name);
> +		return i;
>  	}
>  
>  	err = st_sensors_init_interface_mode(indio_dev, &sensor_settings[i]);
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 2948ac99e2da..17fbf3e9b013 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -334,6 +334,10 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale);
>  int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *ch, int *val);
>  
> +int st_sensors_get_settings_index(const char *name,
> +				  const struct st_sensor_settings *list,
> +				  const int list_length);
> +
>  int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  	int num_sensors_list, const struct st_sensor_settings *sensor_settings);
>  

