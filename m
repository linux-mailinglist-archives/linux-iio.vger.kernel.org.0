Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6454F53E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVKav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKav (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:30:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169EA2075E;
        Sat, 22 Jun 2019 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561199450;
        bh=LMOz8pC2VXkblDTvg2BnLGtu8L6rOz2WNRhx5J3+Qps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeRdcDUvpj47nLL1/32ZsEg59v9ITIO+ON7in6HOXvAdAjzLqNSTxH7dZJJMn9qry
         OGhW39Hx1guj6NzMScLktxrNp4rC/azheNGj3COYLUooRwmiJKtjzdHCgO8GJcFKdT
         yGV/7f4zogYvLs5l6e6JIVUfEQ85KvkRS5baHLI8=
Date:   Sat, 22 Jun 2019 11:30:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <lorenzo@kernel.org>
Subject: Re: [PATCH 1/7] iio:common:st_sensors: add
 st_sensors_get_settings_index() helper function
Message-ID: <20190622113046.050ca914@archlinux>
In-Reply-To: <20190617234943.10669-2-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
        <20190617234943.10669-2-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:49:37 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> Extract from st_sensors_check_device_support() function the code that
> is used to get the specific settings for a device. This will be used
> by each driver to configure the multi-read bit at the beginning of the
> probes.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
A few minor suggestions inline.

Jonathan

> ---
>  .../iio/common/st_sensors/st_sensors_core.c   | 45 ++++++++++++++-----
>  include/linux/iio/common/st_sensors.h         |  4 ++
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 8b22dc241482..243b2097c57e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -633,28 +633,49 @@ static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -int st_sensors_check_device_support(struct iio_dev *indio_dev,
> -			int num_sensors_list,
> -			const struct st_sensor_settings *sensor_settings)
> +/*
> + * st_sensors_get_settings_index() - get index of sensor settings
> + *				     for a specific device.
> + * @name: device name buffer reference.
> + * @list: sensor settings list.
> + * @list_length: length of sensor settings list.
> + */
> +int st_sensors_get_settings_index(const char *name,
> +				  const struct st_sensor_settings *list,
> +				  const int list_length)
>  {
> -	int i, n, err = 0;
> -	u8 wai;
> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	int i, n;
>  
> -	for (i = 0; i < num_sensors_list; i++) {
> +	for (i = 0; i < list_length; i++) {
>  		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
> -			if (strcmp(indio_dev->name,
> -				sensor_settings[i].sensors_supported[n]) == 0) {
> +			if (strcmp(name, list[i].sensors_supported[n]) == 0) {
>  				break;
return i; ?

Should give a simpler flow as we only handle errors after this I think.

>  			}
>  		}
>  		if (n < ST_SENSORS_MAX_4WAI)
>  			break;

>  	}
> -	if (i == num_sensors_list) {
> -		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
> -							indio_dev->name);
> +	if (i == list_length)
>  		return -ENODEV;
> +
> +	return i;
> +}
> +EXPORT_SYMBOL(st_sensors_get_settings_index);
> +
> +int st_sensors_check_device_support(struct iio_dev *indio_dev,
> +			int num_sensors_list,
> +			const struct st_sensor_settings *sensor_settings)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	int i, err = 0;

Why init err?

> +	u8 wai;
> +
> +	i = st_sensors_get_settings_index(indio_dev->name,
> +					  sensor_settings, num_sensors_list);
> +	if (i < 0) {
> +		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
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

