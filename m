Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75971B8701
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgDYO0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 10:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYO0r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:26:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9BA206B9;
        Sat, 25 Apr 2020 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587824807;
        bh=1xR0CATvTKiqMZW4NlEw+48v1WeW1Usvj8bRqkYPgeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctXc9gbcHTMLz7IkwPC/z0WuV5msD2D/Jl9XFjTAHL+QUQFazTTuGd2qzbfgpqsH/
         a+HThean7oQWjacgWW9bHkl5dTlkGCa5xrmFxrk/LVdkqrs98p9i6x4Lzu91+mJx71
         VWX+aLgQ3XungwVCOvvzdloacSvLcTwo2u9/Hpic=
Date:   Sat, 25 Apr 2020 15:26:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: chemical: atlas-sensor: add RTD-SM module
 support
Message-ID: <20200425152644.60905959@archlinux>
In-Reply-To: <20200425072520.27776-3-matt.ranostay@konsulko.com>
References: <20200425072520.27776-1-matt.ranostay@konsulko.com>
        <20200425072520.27776-3-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 10:25:20 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Atlas Scientific RTD-SM OEM sensor reads temperaturee using
temperature


> resistance temperature detector technology.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Other than the above looks good to me and as you've addressed Peter's
comment I'll assume he is fine with it and apply to the togreg branch of iio.git
Still time for people to comment though as I'll push that as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-sensor.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 82d470561ad3..4688cbe83d86 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -53,6 +53,8 @@
>  #define ATLAS_REG_DO_CALIB_STATUS_PRESSURE	BIT(0)
>  #define ATLAS_REG_DO_CALIB_STATUS_DO		BIT(1)
>  
> +#define ATLAS_REG_RTD_DATA		0x0e
> +
>  #define ATLAS_REG_PH_TEMP_DATA		0x0e
>  #define ATLAS_REG_PH_DATA		0x16
>  
> @@ -72,12 +74,14 @@
>  #define ATLAS_EC_INT_TIME_IN_MS		650
>  #define ATLAS_ORP_INT_TIME_IN_MS	450
>  #define ATLAS_DO_INT_TIME_IN_MS		450
> +#define ATLAS_RTD_INT_TIME_IN_MS	450
>  
>  enum {
>  	ATLAS_PH_SM,
>  	ATLAS_EC_SM,
>  	ATLAS_ORP_SM,
>  	ATLAS_DO_SM,
> +	ATLAS_RTD_SM,
>  };
>  
>  struct atlas_data {
> @@ -206,6 +210,22 @@ static const struct iio_chan_spec atlas_do_channels[] = {
>  	},
>  };
>  
> +static const struct iio_chan_spec atlas_rtd_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = ATLAS_REG_RTD_DATA,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
>  static int atlas_check_ph_calibration(struct atlas_data *data)
>  {
>  	struct device *dev = &data->client->dev;
> @@ -350,6 +370,12 @@ static struct atlas_device atlas_devices[] = {
>  				.calibration = &atlas_check_do_calibration,
>  				.delay = ATLAS_DO_INT_TIME_IN_MS,
>  	},
> +	[ATLAS_RTD_SM] = {
> +				.channels = atlas_rtd_channels,
> +				.num_channels = 2,
> +				.data_reg = ATLAS_REG_RTD_DATA,
> +				.delay = ATLAS_RTD_INT_TIME_IN_MS,
> +	},
>  };
>  
>  static int atlas_set_powermode(struct atlas_data *data, int on)
> @@ -478,6 +504,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>  	struct atlas_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
>  	case IIO_CHAN_INFO_RAW: {
>  		int ret;
>  		__be32 reg;
> @@ -566,6 +593,7 @@ static const struct i2c_device_id atlas_id[] = {
>  	{ "atlas-ec-sm", ATLAS_EC_SM},
>  	{ "atlas-orp-sm", ATLAS_ORP_SM},
>  	{ "atlas-do-sm", ATLAS_DO_SM},
> +	{ "atlas-rtd-sm", ATLAS_RTD_SM},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> @@ -575,6 +603,7 @@ static const struct of_device_id atlas_dt_ids[] = {
>  	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
>  	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
>  	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> +	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, atlas_dt_ids);

