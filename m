Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8D6F47B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGUSBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821B320828;
        Sun, 21 Jul 2019 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732093;
        bh=jLqzHIyNFmOn14m8JQlwIySpAiqSASeeMfAR4wQ3qWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JN9+VR04RULz4Hg3k4pPZ0CYyqGdMxCL9GrdC9Bx7Ea5BiB/eKCtGxtbxh25pjSY1
         R75KqeuJ7LsfVmK6iVt1vXCn4RfepUiNYF2woCyAgk2jxUDkvJd2Qd0i5WDnaUFzWT
         x9ZMIKsL/wsNrcjbS88/IP+PDKCYYOsb62wz02OM=
Date:   Sun, 21 Jul 2019 18:54:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] iio:accel: device settings are set immediately
 during probe
Message-ID: <20190721185416.4bf644de@archlinux>
In-Reply-To: <20190718225353.2078-7-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-7-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:48 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch set accel settings right after probe start. This is
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
>  drivers/iio/accel/st_accel_i2c.c | 19 ++++++++++++++-----
>  drivers/iio/accel/st_accel_spi.c | 16 +++++++++++++---
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c3c8f2e73c2a..a92cf776031e 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -150,20 +150,29 @@ MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>  
>  static int st_accel_i2c_probe(struct i2c_client *client)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *adata;
> +	struct iio_dev *indio_dev;
>  	const char *match;
>  	int ret;
>  
> +	match = device_get_match_data(&client->dev);
> +	if (match)
> +		strlcpy(client->name, match, sizeof(client->name));
> +
> +	settings = st_accel_get_settings(client->name);
> +	if (!settings) {
> +		dev_err(&client->dev, "device name %s not recognized.\n",
> +			client->name);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	adata = iio_priv(indio_dev);
> -
> -	match = device_get_match_data(&client->dev);
> -	if (match)
> -		strlcpy(client->name, match, sizeof(client->name));
> +	adata->sensor_settings = (struct st_sensor_settings *)settings;
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 474742e35d92..c0556db9d60a 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -102,18 +102,28 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>  
>  static int st_accel_spi_probe(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev;
> +	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *adata;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> +	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
> +
> +	settings = st_accel_get_settings(spi->modalias);
> +	if (!settings) {
> +		dev_err(&spi->dev, "device name %s not recognized.\n",
> +			spi->modalias);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adata));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	adata = iio_priv(indio_dev);
> +	adata->sensor_settings = (struct st_sensor_settings *)settings;
>  
> -	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
> -				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, adata);
>  
>  	err = st_accel_common_probe(indio_dev);

