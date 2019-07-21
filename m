Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E766F479
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGUSBb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2D02147A;
        Sun, 21 Jul 2019 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732089;
        bh=l4+/ZvRam9BLJ+FwXDrTUumCw+dmgAhvsIrG8Dwc3SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bXLTMtrxDD2KFvIj9cGsL7moWNcFs3nWokOCYS4cl6eeOxJkZxj5vS2hJXWfP5v9V
         Y6J/FVD5dM1wJlqE9eV8sG8GJ3M0icfOVnpVVGfT28q+P6vU7pHhUKXitWMztFoIHU
         GsNScDOF+dJl6yFhaOdfx8t0KGvedFtOIDnj89Jk=
Date:   Sun, 21 Jul 2019 18:56:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] iio:magn: device settings are set immediately
 during probe
Message-ID: <20190721185611.1abe36fb@archlinux>
In-Reply-To: <20190718225353.2078-9-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-9-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:50 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch set magn settings right after probe start. This is
> done in preparation of regmap that needs different configuration
> based on multiread bit value.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied,

Thanks,

> ---
> Changes in v2:
>  not there in v1.
> 
>  drivers/iio/magnetometer/st_magn_i2c.c | 18 ++++++++++++++----
>  drivers/iio/magnetometer/st_magn_spi.c | 16 +++++++++++++---
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 4d014fd1aeb0..d5d565639bed 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -55,19 +55,29 @@ MODULE_DEVICE_TABLE(of, st_magn_of_match);
>  #endif
>  
>  static int st_magn_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			     const struct i2c_device_id *id)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *mdata;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> +	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
> +				 client->name, sizeof(client->name));
> +
> +	settings = st_magn_get_settings(client->name);
> +	if (!settings) {
> +		dev_err(&client->dev, "device name %s not recognized.\n",
> +			client->name);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mdata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	mdata = iio_priv(indio_dev);
> -	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
> -				 client->name, sizeof(client->name));
> +	mdata->sensor_settings = (struct st_sensor_settings *)settings;
>  
>  	st_sensors_i2c_configure(indio_dev, client, mdata);
>  
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 0d47070611b1..a3045afc6b53 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -51,18 +51,28 @@ MODULE_DEVICE_TABLE(of, st_magn_of_match);
>  
>  static int st_magn_spi_probe(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *mdata;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> +	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
> +
> +	settings = st_magn_get_settings(spi->modalias);
> +	if (!settings) {
> +		dev_err(&spi->dev, "device name %s not recognized.\n",
> +			spi->modalias);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*mdata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	mdata = iio_priv(indio_dev);
> +	mdata->sensor_settings = (struct st_sensor_settings *)settings;
>  
> -	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
> -				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, mdata);
>  
>  	err = st_magn_common_probe(indio_dev);

