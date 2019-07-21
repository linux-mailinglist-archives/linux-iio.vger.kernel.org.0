Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387EE6F47A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGUSBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E52292171F;
        Sun, 21 Jul 2019 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732091;
        bh=nmLedq1YaWa6/0OSLPB9yl8aVT/6ThLpd3cohMlTE+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7Ijn7st/jnu58jRWXIj7HckgcSr64E6QOh5nwjPGgADysO8OYWKRKCB7ZIwBVEiy
         tDpA9kCnUyFkTH+kuydwn6ojGI7+R2eSqM1PT/gxo2EtoyLHKS9bRgU5MbHy7zUrf0
         WyJOP+wiFx9OqhLkJPOlPUxS3lV2bNVKy+2Zqfuk=
Date:   Sun, 21 Jul 2019 18:55:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] iio:gyro: device settings are set immediately
 during probe
Message-ID: <20190721185511.258c3d8d@archlinux>
In-Reply-To: <20190718225353.2078-8-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-8-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:49 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch set gyro settings right after probe start. This is
> done in preparation of regmap that needs different configuration
> based on multiread bit value.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied,

Thanks,

Jonathan

> ---
> Changes in v2:
>  not there in v1.
> 
>  drivers/iio/gyro/st_gyro_i2c.c | 18 ++++++++++++++----
>  drivers/iio/gyro/st_gyro_spi.c | 16 +++++++++++++---
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index f2a8683db7d9..fa71e94b76f4 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -63,19 +63,29 @@ MODULE_DEVICE_TABLE(of, st_gyro_of_match);
>  #endif
>  
>  static int st_gyro_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			     const struct i2c_device_id *id)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *gdata;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> +	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
> +				 client->name, sizeof(client->name));
> +
> +	settings = st_gyro_get_settings(client->name);
> +	if (!settings) {
> +		dev_err(&client->dev, "device name %s not recognized.\n",
> +			client->name);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*gdata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	gdata = iio_priv(indio_dev);
> -	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
> -				 client->name, sizeof(client->name));
> +	gdata->sensor_settings = (struct st_sensor_settings *)settings;
>  
>  	st_sensors_i2c_configure(indio_dev, client, gdata);
>  
> diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> index 93c48248bea6..bb7082055f85 100644
> --- a/drivers/iio/gyro/st_gyro_spi.c
> +++ b/drivers/iio/gyro/st_gyro_spi.c
> @@ -69,18 +69,28 @@ MODULE_DEVICE_TABLE(of, st_gyro_of_match);
>  
>  static int st_gyro_spi_probe(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *gdata;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> +	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
> +
> +	settings = st_gyro_get_settings(spi->modalias);
> +	if (!settings) {
> +		dev_err(&spi->dev, "device name %s not recognized.\n",
> +			spi->modalias);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*gdata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	gdata = iio_priv(indio_dev);
> +	gdata->sensor_settings = (struct st_sensor_settings *)settings;
>  
> -	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
> -				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, gdata);
>  
>  	err = st_gyro_common_probe(indio_dev);

