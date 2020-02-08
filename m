Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C80156589
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBHQlk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 11:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBHQlk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 11:41:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A1222522;
        Sat,  8 Feb 2020 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581180098;
        bh=v8hTWsyeh15Tg1OYCwoWyVL0JcS20WkVBjaJAjrhtNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SCvKApbczw2HEex0MaWfrqJvBLj5Tk2ojHnRjD/TNFWDM2U6f9rt3Ah0hhdT9gsqc
         ac1yKrWvf88+xNQnUvlJ0yL+qMpTmM9WhtrA7XYng6VHuQIwJqYWutMlkDwrGiGKw7
         DW80TEOeh8QTa49XnjrwurGUePXl9xnQuQ03K01c=
Date:   Sat, 8 Feb 2020 16:41:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: chemical: atlas-sensor: add DO-SM module
 support
Message-ID: <20200208164135.3e4f606c@archlinux>
In-Reply-To: <20200206061332.20427-3-matt.ranostay@konsulko.com>
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
        <20200206061332.20427-3-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 22:13:31 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Atlas Scientific DO-SM OEM sensor reads disolved oxygen in
> a solution. This is reported back as mg/L which maps direc
> to ppm and so the IIO_CONCENTRATION channel type can be used.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hi Matt,

This looks good to me. Will pick up once we've resolved the other
bits in the series.

Also want to give time for Rob to take a look a the yaml.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-sensor.c | 64 +++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 2e34c82cb65d..919d408869be 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -48,6 +48,11 @@
>  #define ATLAS_REG_EC_CALIB_STATUS_LOW		BIT(2)
>  #define ATLAS_REG_EC_CALIB_STATUS_HIGH		BIT(3)
>  
> +#define ATLAS_REG_DO_CALIB_STATUS		0x09
> +#define ATLAS_REG_DO_CALIB_STATUS_MASK		0x03
> +#define ATLAS_REG_DO_CALIB_STATUS_PRESSURE	BIT(0)
> +#define ATLAS_REG_DO_CALIB_STATUS_DO		BIT(1)
> +
>  #define ATLAS_REG_PH_TEMP_DATA		0x0e
>  #define ATLAS_REG_PH_DATA		0x16
>  
> @@ -60,14 +65,19 @@
>  #define ATLAS_REG_ORP_CALIB_STATUS	0x0d
>  #define ATLAS_REG_ORP_DATA		0x0e
>  
> +#define ATLAS_REG_DO_TEMP_DATA		0x12
> +#define ATLAS_REG_DO_DATA		0x22
> +
>  #define ATLAS_PH_INT_TIME_IN_MS		450
>  #define ATLAS_EC_INT_TIME_IN_MS		650
>  #define ATLAS_ORP_INT_TIME_IN_MS	450
> +#define ATLAS_DO_INT_TIME_IN_MS		450
>  
>  enum {
>  	ATLAS_PH_SM,
>  	ATLAS_EC_SM,
>  	ATLAS_ORP_SM,
> +	ATLAS_DO_SM,
>  };
>  
>  struct atlas_data {
> @@ -121,7 +131,7 @@ static const struct iio_chan_spec atlas_ph_channels[] = {
>  	},
>  };
>  
> -#define ATLAS_EC_CHANNEL(_idx, _addr) \
> +#define ATLAS_CONCENTRATION_CHANNEL(_idx, _addr) \
>  	{\
>  		.type = IIO_CONCENTRATION, \
>  		.indexed = 1, \
> @@ -152,8 +162,8 @@ static const struct iio_chan_spec atlas_ec_channels[] = {
>  			.endianness = IIO_BE,
>  		},
>  	},
> -	ATLAS_EC_CHANNEL(0, ATLAS_REG_TDS_DATA),
> -	ATLAS_EC_CHANNEL(1, ATLAS_REG_PSS_DATA),
> +	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_TDS_DATA),
> +	ATLAS_CONCENTRATION_CHANNEL(1, ATLAS_REG_PSS_DATA),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  	{
>  		.type = IIO_TEMP,
> @@ -182,6 +192,19 @@ static const struct iio_chan_spec atlas_orp_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
> +static const struct iio_chan_spec atlas_do_channels[] = {
> +	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +	{
> +		.type = IIO_TEMP,
> +		.address = ATLAS_REG_DO_TEMP_DATA,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.output = 1,
> +		.scan_index = -1
> +	},
> +};
> +
>  static int atlas_check_ph_calibration(struct atlas_data *data)
>  {
>  	struct device *dev = &data->client->dev;
> @@ -262,7 +285,31 @@ static int atlas_check_orp_calibration(struct atlas_data *data)
>  		dev_warn(dev, "device has not been calibrated\n");
>  
>  	return 0;
> -};
> +}

Unrelated change so really should have been in a separate patch, but meh
it's trivial so I won't fuss too much about it being here ;)

> +
> +static int atlas_check_do_calibration(struct atlas_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(data->regmap, ATLAS_REG_DO_CALIB_STATUS, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!(val & ATLAS_REG_DO_CALIB_STATUS_MASK)) {
> +		dev_warn(dev, "device has not been calibrated\n");
> +		return 0;
> +	}
> +
> +	if (!(val & ATLAS_REG_DO_CALIB_STATUS_PRESSURE))
> +		dev_warn(dev, "device missing atmospheric pressure calibration\n");
> +
> +	if (!(val & ATLAS_REG_DO_CALIB_STATUS_DO))
> +		dev_warn(dev, "device missing dissolved oxygen calibration\n");
> +
> +	return 0;
> +}
>  
>  struct atlas_device {
>  	const struct iio_chan_spec *channels;
> @@ -295,6 +342,13 @@ static struct atlas_device atlas_devices[] = {
>  				.calibration = &atlas_check_orp_calibration,
>  				.delay = ATLAS_ORP_INT_TIME_IN_MS,
>  	},
> +	[ATLAS_DO_SM] = {
> +				.channels = atlas_do_channels,
> +				.num_channels = 3,
> +				.data_reg = ATLAS_REG_DO_DATA,
> +				.calibration = &atlas_check_do_calibration,
> +				.delay = ATLAS_DO_INT_TIME_IN_MS,
> +	},
>  };
>  
>  static int atlas_set_powermode(struct atlas_data *data, int on)
> @@ -507,6 +561,7 @@ static const struct i2c_device_id atlas_id[] = {
>  	{ "atlas-ph-sm", ATLAS_PH_SM},
>  	{ "atlas-ec-sm", ATLAS_EC_SM},
>  	{ "atlas-orp-sm", ATLAS_ORP_SM},
> +	{ "atlas-do-sm", ATLAS_DO_SM},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> @@ -515,6 +570,7 @@ static const struct of_device_id atlas_dt_ids[] = {
>  	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
>  	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
>  	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
> +	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, atlas_dt_ids);

