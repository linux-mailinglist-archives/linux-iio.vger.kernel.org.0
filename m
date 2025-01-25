Return-Path: <linux-iio+bounces-14576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB31A1C3B9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FED918898BF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27C1CF96;
	Sat, 25 Jan 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEBpDpIW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5911EB5B;
	Sat, 25 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737814851; cv=none; b=sLdaKiPxArOOSAa5/KH2S3+gwsmD3NKqrnre5M6rR5MkDckqm2I526P/1Dr307K/XblieFxZAytOGZ2OjUROVpn3QaaW+rZVdr8VzMR/LsxO5BFMDLmEiL6z7BYgkgYpq1CUhSIJ79VSxezp1jsMPUT39t18jAdBVKhXyXhjmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737814851; c=relaxed/simple;
	bh=gRkPCy6rRZT0kv6LpId7ihiyPgtJzG4AEo31nddyytU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzyzXDJVvZmEhf58mnxagKx3f/IjfycyigTCTOmJjnPnSPbBmiSFQenFsYlPk3IX/ekImyWuviCi4Pr+A2oVfLXE+BdF7slC8HQKz3lhSzzyTcKn9W4/CS3LmOFvqDr2Nitks0gmdJY9Dy5EdPhB2mumbMK0JKQiVbK/hlPIzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEBpDpIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B86C4CED6;
	Sat, 25 Jan 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737814851;
	bh=gRkPCy6rRZT0kv6LpId7ihiyPgtJzG4AEo31nddyytU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEBpDpIWVyZx3j/iXU0t8mzTVyXh5FsqOZcjYSThSfD4SLam/55frp6lSip+dH5Vi
	 7iwnnXPHKMGAvbkOtmakXvHfNwjVNDuV/MZ1kGku9jvi1GAHUMPXDR8GgXLpV+G5/h
	 kfRmmJ/p9U4fUn1Eh5pLZ1lSynC8y97qCB1fVolr5gxvbBnhMngXHoOQ54kH2kM4pH
	 6Ug2tkCa6HVR4GTc3qlu2r5i73+yNHUTP0TrL4Z5qXCTnRxvb8MfPmHeP/l46W4wYq
	 2puQI/uRToGITwClVqBxCkgGGBQmwagmQEXOUK+lnEgqsheyuxaMfYE+6BlD4K0BEO
	 BIHrPnSn33UUw==
Date: Sat, 25 Jan 2025 14:20:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20250125142040.273f9cd6@jic23-huawei>
In-Reply-To: <20250122-apds9160-driver-v5-2-5393be10279a@dimonoff.com>
References: <20250122-apds9160-driver-v5-0-5393be10279a@dimonoff.com>
	<20250122-apds9160-driver-v5-2-5393be10279a@dimonoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 17:59:34 -0500
Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:

> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
> APDS9160 is a combination of ALS and proximity sensors.
> 
> This patch add supports for:
>     - Intensity clear data and illuminance data
>     - Proximity data
>     - Gain control, rate control
>     - Event thresholds
> 
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Hi Mikael,

Some minor things inline. I tidied up whilst applying.

Applied to the togreg branch of iio.git; initially pushed out as testing
as I'll be rebasing on rc1 once available.

thanks,

Jonathan




> ---
>  MAINTAINERS                  |    7 +
>  drivers/iio/light/Kconfig    |   11 +
>  drivers/iio/light/Makefile   |    1 +
>  drivers/iio/light/apds9160.c | 1597 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1616 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e69d1632c382fe0e366f7bb20e72ee0c9e91e30b..23d9fcbf71a311940ff86d8dc4cabd5be77925aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4340,6 +4340,13 @@ F:	kernel/bpf/stackmap.c
>  F:	kernel/trace/bpf_trace.c
>  F:	lib/buildid.c
>  
> +BROADCOM APDS9160 AMBIENT LIGHT SENSOR AND PROXIMITY DRIVER
> +M:	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> +F:	drivers/iio/light/apds9160.c
> +
>  BROADCOM ASP 2.0 ETHERNET DRIVER
>  M:	Justin Chen <justin.chen@broadcom.com>
>  M:	Florian Fainelli <florian.fainelli@broadcom.com>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 29ffa84919273d64b8464ab8bbf59661b0102f97..419360661d53973eda71d7d986ff7fd481c7aa2c 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -63,6 +63,17 @@ config AL3320A
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called al3320a.
>  
> +config APDS9160
> +	tristate "APDS9160 combined als and proximity sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	   Say Y here if you want to build support for a Broadcom APDS9160
> +		combined ambient light and proximity sensor.

Strange indent.

> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called apds9160.
> +

> diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e98006de473790da66b92734a0527359e9cd1f40
> --- /dev/null
> +++ b/drivers/iio/light/apds9160.c

> +/*
> + * This parameter works in conjunction with the cancellation pulse duration
> + * The value determines the current used for crosstalk cancellation
> + * Coarse value is in steps of 60 nA
> + * Fine value is in steps of 2.4 nA
> + */
> +static int apds9160_set_ps_cancellation_current(struct apds9160_chip *data,
> +						int coarse_val,
> +						int fine_val)
> +{
> +	int ret, val;
> +
> +	if (coarse_val < 0 || coarse_val > 4)
> +		return -EINVAL;
> +
> +	if (fine_val < 0 || fine_val > 15)
> +		return -EINVAL;
> +
> +	/* Coarse value at B4:B5 and fine value at B0:B3 */
> +	val = (coarse_val << 4) | fine_val;
> +
> +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT,
> +			   val);
> +
> +	return ret;
return regmap_write()

> +}
> +
> +static int apds9160_ps_init_analog_cancellation(struct device *dev,
> +						struct apds9160_chip *data)
> +{
> +	int ret, duration, picoamp, idx, coarse, fine;
> +
> +	ret = device_property_read_u32(dev,
> +			"ps-cancellation-duration", &duration);
> +
Good to keep call + return together so no blank line here.
> +	if (ret || duration == 0)

Given the comment is in the block, I think this wants {} for readability
reasons (not correctness).

> +		/* Don't fail since this is not required */
> +		return 0;
> +
> +	ret = device_property_read_u32(dev,
> +			"ps-cancellation-current-picoamp", &picoamp);
> +
Odd line break here.

> +	if (ret)
> +		return ret;
> +
> +	if (picoamp < 60000 || picoamp > 276000 || picoamp % 2400 != 0)
> +		return dev_err_probe(dev, -EINVAL,
> +					"Invalid cancellation current\n");
> +
> +	/* Compute required coarse and fine value from requested current */
> +	fine = 0;
> +	coarse = 0;
> +	for (idx = 60000; idx < picoamp; idx += 2400) {
> +		if (fine == 15) {
> +			fine = 0;
> +			coarse++;
> +			idx += 21600;
> +		} else {
> +			fine++;
> +		}
> +	}
> +
> +	if (picoamp != idx)
> +		dev_warn(dev,
> +			"Invalid cancellation current %i, rounding to %i\n",
> +			picoamp, idx);
> +
> +	ret = apds9160_set_ps_analog_cancellation(data, duration);
> +	if (ret)
> +		return ret;
> +
> +	return apds9160_set_ps_cancellation_current(data, coarse, fine);
> +}

> +
> +/*
> + *	Setting the integration time ajusts resolution, rate, scale and gain

Odd indent of the comment.

> + */
> +static int apds9160_set_als_int_time(struct apds9160_chip *data, int val)

> +static int apds9160_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			*length = ARRAY_SIZE(apds9160_als_rate_avail);
> +			*vals = (const int *)apds9160_als_rate_avail;
> +			*type = IIO_VAL_INT;
> +
> +			return IIO_AVAIL_LIST;
> +		case IIO_PROXIMITY:
> +			*length = ARRAY_SIZE(apds9160_ps_rate_avail);
> +			*vals = (const int *)apds9160_ps_rate_avail;
> +			*type = IIO_VAL_INT;
> +
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*length = ARRAY_SIZE(apds9160_ps_gain_avail);
> +			*vals = (const int *)apds9160_ps_gain_avail;
> +			*type = IIO_VAL_INT;
> +
> +			return IIO_AVAIL_LIST;
> +		case IIO_LIGHT:
> +			/* The available scales changes depending on itime */
> +			switch (data->als_itime) {
> +			case 25:
> +				*length = ARRAY_SIZE(apds9160_25ms_avail) * 2;
> +				*vals = (const int *) apds9160_25ms_avail;
> +				*type = IIO_VAL_INT_PLUS_MICRO;
> +
> +				return IIO_AVAIL_LIST;
> +			case 50:
> +				*length = ARRAY_SIZE(apds9160_50ms_avail) * 2;
> +				*vals = (const int *) apds9160_50ms_avail;
> +				*type = IIO_VAL_INT_PLUS_MICRO;
> +
> +				return IIO_AVAIL_LIST;
> +			case 100:
> +				*length = ARRAY_SIZE(apds9160_100ms_avail) * 2;
> +				*vals = (const int *) apds9160_100ms_avail;
> +				*type = IIO_VAL_INT_PLUS_MICRO;
> +
> +				return IIO_AVAIL_LIST;
> +			case 200:
> +				*length = ARRAY_SIZE(apds9160_200ms_avail) * 2;
> +				*vals = (const int *) apds9160_200ms_avail;
Completely trivial but the spacing here after) isn't consistent with some cases above.

> +				*type = IIO_VAL_INT_PLUS_MICRO;

