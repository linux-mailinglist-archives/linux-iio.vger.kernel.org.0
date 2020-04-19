Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7211AF8EA
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDSJSY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 05:18:24 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:54996 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgDSJSY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 05:18:24 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 85712E0382; Sun, 19 Apr 2020 11:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587287902; bh=3Iop49+Kd70/V/t7/icODBUVrlD5KvUC9Qdspj2V4cQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Wbg0fl5WLGoSQaQ/7iHWDtgI7CtF+I6MB9LagMP9yT0U5Zjb7AARxSCOMG73LPCHk
         iwQPi+WTe8+xQuio7J5Ukw7w4d02PbRfRipH7jGy3dEyFgtgqOOo/vSpWQhQCSoSi5
         ASH5q65ZBANXILCU+tYttcBdEIpK+iUEiNcBs0x0=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 5DEBCE01CB;
        Sun, 19 Apr 2020 11:18:22 +0200 (CEST)
Date:   Sun, 19 Apr 2020 11:18:22 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: atlas-sensor: add RTD-SM module
 support
In-Reply-To: <20200419060555.14433-3-matt.ranostay@konsulko.com>
Message-ID: <alpine.DEB.2.21.2004191115080.12852@vps.pmeerw.net>
References: <20200419060555.14433-1-matt.ranostay@konsulko.com> <20200419060555.14433-3-matt.ranostay@konsulko.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Apr 2020, Matt Ranostay wrote:

> Atlas Scientific RTD-SM OEM sensor reads temperate using

reads temperature?

> resistance temperature detector technology.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 82d470561ad3..c7ed9004cf82 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -68,16 +68,20 @@
>  #define ATLAS_REG_DO_TEMP_DATA		0x12
>  #define ATLAS_REG_DO_DATA		0x22
>  
> +#define ATLAS_REG_RTD_DATA		0x0e

maybe keep registers in ascending order

> +
>  #define ATLAS_PH_INT_TIME_IN_MS		450
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
> +			.sign = 'u',

so this thing can't read negative temperature?

> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,

_PROCESSED, but still stored as big endian? hm

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
> @@ -566,6 +592,7 @@ static const struct i2c_device_id atlas_id[] = {
>  	{ "atlas-ec-sm", ATLAS_EC_SM},
>  	{ "atlas-orp-sm", ATLAS_ORP_SM},
>  	{ "atlas-do-sm", ATLAS_DO_SM},
> +	{ "atlas-rtd-sm", ATLAS_RTD_SM},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> @@ -575,6 +602,7 @@ static const struct of_device_id atlas_dt_ids[] = {
>  	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
>  	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
>  	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> +	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, atlas_dt_ids);
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
