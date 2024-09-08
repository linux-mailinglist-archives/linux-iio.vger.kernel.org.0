Return-Path: <linux-iio+bounces-9316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC69706AD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DC5282315
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99114D2AC;
	Sun,  8 Sep 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5urJxPM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182934B5AE;
	Sun,  8 Sep 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792356; cv=none; b=dYjuh+9hpSIwniLHGGe/1MQ9ZrG+CWw+G+nqTEUZZf2cz+wf+Md9mb1UerVucoeU77CESB3SuchcYk9p7AV7yqp+1+9u3Zv4d872XDbX9zIV+PcmM36s896MdV5WU2PMVVTQG6uKGZYiJJTg1x38addugYhWbw7rVQ0EoQ2lfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792356; c=relaxed/simple;
	bh=ZdeVMQP7WAahXBNn+vvwYUubRgDDxbd+EsqMfmvHIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRjg9Cf3PSUPjOxZvL1K1zwaBT6BQZcLxqtgK8Rd3Z1WS67aQix/P9kU8rUheAsoA5/CaVY6OGGof0l4mm+qXQALmQBGuifKJi5RYIfiEBq/W4pjvzbekJNj7PAR+VNpBWr4EgrhjXUY19eS321vRlgh+RWwz9Ssn6J5LRnsWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5urJxPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3165FC4CEC3;
	Sun,  8 Sep 2024 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725792355;
	bh=ZdeVMQP7WAahXBNn+vvwYUubRgDDxbd+EsqMfmvHIpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5urJxPM1tNX/Uafnq1rDHqOLUdNjqSPIt8c0J51WOTUS8gYSVMVEd15bc2IAifwn
	 TpJPWGYSxzV2YOyD5/i7ETwGPVcwf7GT/RdeJgx/mZjEw4r1twCYjWoxGqeclKFAfH
	 0jcEU1oYaeZZlnVTDnL9ZPQKx72unCi4PXSRp2NUz63tAqWFX52ga441+xGE/+tVh7
	 YawON4m9+tB9zNcTf7wRv1XFl5HEtsKkkHoCHoFeQYvTdhDYGBYPmVDkTELMF7cRvD
	 msNGyTzNfqBsHPuz+h0+kunQ2j2aNfTOAD5LeqCc9YId4tqVLPrvaMD6YLfeGyQMOc
	 4TQ+6q0T3RWXg==
Date: Sun, 8 Sep 2024 11:45:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, Hans
 de Goede <hdegoede@redhat.com>, Support Opensource
 <support.opensource@diasemi.com>, Saravanan Sekar <sravanhome@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] iio: adc: Constify struct iio_map
Message-ID: <20240908114546.395661ef@jic23-huawei>
In-Reply-To: <5729dc3cc3892ecf0d8ea28c5f7307b34e27493e.1725729801.git.christophe.jaillet@wanadoo.fr>
References: <5729dc3cc3892ecf0d8ea28c5f7307b34e27493e.1725729801.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 19:24:46 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct iio_map' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> In order to do it, the prototype of iio_map_array_register() and
> devm_iio_map_array_register(), and a few structures that hold a
> "struct iio_map *" need to be adjusted.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   21086	    760	      0	  21846	   5556	drivers/iio/adc/axp20x_adc.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   21470	    360	      0	  21830	   5546	drivers/iio/adc/axp20x_adc.o
>   33842	   1697	    384	  35923	   8c53	drivers/iio/addac/ad74413r.o
Cropping was a bit random, given before and after have different files.

Anyhow, doesn't matter much, so applied as is.
Note this is 6.13 material now.

Thanks,

Jonathan
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> --
> Compile tested only
> ---
>  drivers/iio/adc/axp20x_adc.c      | 6 +++---
>  drivers/iio/adc/axp288_adc.c      | 2 +-
>  drivers/iio/adc/da9150-gpadc.c    | 2 +-
>  drivers/iio/adc/intel_mrfld_adc.c | 2 +-
>  drivers/iio/adc/lp8788_adc.c      | 6 +++---
>  drivers/iio/adc/mp2629_adc.c      | 2 +-
>  drivers/iio/adc/rn5t618-adc.c     | 2 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-
>  drivers/iio/inkern.c              | 7 ++++---
>  include/linux/iio/driver.h        | 5 +++--
>  10 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index b487e577befb..cac3bacf2589 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -131,7 +131,7 @@ enum axp813_adc_channel_v {
>  	AXP813_BATT_V,
>  };
>  
> -static struct iio_map axp20x_maps[] = {
> +static const struct iio_map axp20x_maps[] = {
>  	{
>  		.consumer_dev_name = "axp20x-usb-power-supply",
>  		.consumer_channel = "vbus_v",
> @@ -163,7 +163,7 @@ static struct iio_map axp20x_maps[] = {
>  	}, { /* sentinel */ }
>  };
>  
> -static struct iio_map axp22x_maps[] = {
> +static const struct iio_map axp22x_maps[] = {
>  	{
>  		.consumer_dev_name = "axp20x-battery-power-supply",
>  		.consumer_channel = "batt_v",
> @@ -893,7 +893,7 @@ struct axp_data {
>  	unsigned long			adc_en2_mask;
>  	int				(*adc_rate)(struct axp20x_adc_iio *info,
>  						    int rate);
> -	struct iio_map			*maps;
> +	const struct iio_map		*maps;
>  };
>  
>  static const struct axp_data axp192_data = {
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index f135cf2362df..a9f84253d4b1 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -103,7 +103,7 @@ static const struct iio_chan_spec axp288_adc_channels[] = {
>  };
>  
>  /* for consumer drivers */
> -static struct iio_map axp288_adc_default_maps[] = {
> +static const struct iio_map axp288_adc_default_maps[] = {
>  	IIO_MAP("TS_PIN", "axp288-batt", "axp288-batt-temp"),
>  	IIO_MAP("PMIC_TEMP", "axp288-pmic", "axp288-pmic-temp"),
>  	IIO_MAP("GPADC", "axp288-gpadc", "axp288-system-temp"),
> diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
> index 8f0d3fb63b67..82628746ba8e 100644
> --- a/drivers/iio/adc/da9150-gpadc.c
> +++ b/drivers/iio/adc/da9150-gpadc.c
> @@ -291,7 +291,7 @@ static const struct iio_chan_spec da9150_gpadc_channels[] = {
>  };
>  
>  /* Default maps used by da9150-charger */
> -static struct iio_map da9150_gpadc_default_maps[] = {
> +static const struct iio_map da9150_gpadc_default_maps[] = {
>  	{
>  		.consumer_dev_name = "da9150-charger",
>  		.consumer_channel = "CHAN_IBUS",
> diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> index 0590a126f321..30c8c09e3716 100644
> --- a/drivers/iio/adc/intel_mrfld_adc.c
> +++ b/drivers/iio/adc/intel_mrfld_adc.c
> @@ -164,7 +164,7 @@ static const struct iio_chan_spec mrfld_adc_channels[] = {
>  	BCOVE_ADC_CHANNEL(IIO_TEMP,       8, "CH8", 0xC6),
>  };
>  
> -static struct iio_map iio_maps[] = {
> +static const struct iio_map iio_maps[] = {
>  	IIO_MAP("CH0", "bcove-battery", "VBATRSLT"),
>  	IIO_MAP("CH1", "bcove-battery", "BATTID"),
>  	IIO_MAP("CH2", "bcove-battery", "IBATRSLT"),
> diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
> index 6d9b354bc705..0d49be0061a2 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -26,7 +26,7 @@
>  
>  struct lp8788_adc {
>  	struct lp8788 *lp;
> -	struct iio_map *map;
> +	const struct iio_map *map;
>  	struct mutex lock;
>  };
>  
> @@ -149,7 +149,7 @@ static const struct iio_chan_spec lp8788_adc_channels[] = {
>  };
>  
>  /* default maps used by iio consumer (lp8788-charger driver) */
> -static struct iio_map lp8788_default_iio_maps[] = {
> +static const struct iio_map lp8788_default_iio_maps[] = {
>  	{
>  		.consumer_dev_name = "lp8788-charger",
>  		.consumer_channel = "lp8788_vbatt_5p0",
> @@ -168,7 +168,7 @@ static int lp8788_iio_map_register(struct device *dev,
>  				struct lp8788_platform_data *pdata,
>  				struct lp8788_adc *adc)
>  {
> -	struct iio_map *map;
> +	const struct iio_map *map;
>  	int ret;
>  
>  	map = (!pdata || !pdata->adc_pdata) ?
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index 5f672765d4a2..f114817601f2 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -52,7 +52,7 @@ static struct iio_chan_spec mp2629_channels[] = {
>  	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
>  };
>  
> -static struct iio_map mp2629_adc_maps[] = {
> +static const struct iio_map mp2629_adc_maps[] = {
>  	MP2629_MAP(BATT_VOLT, "batt-volt"),
>  	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
>  	MP2629_MAP(INPUT_VOLT, "input-volt"),
> diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
> index ce5f3011fe00..b33536157adc 100644
> --- a/drivers/iio/adc/rn5t618-adc.c
> +++ b/drivers/iio/adc/rn5t618-adc.c
> @@ -185,7 +185,7 @@ static const struct iio_chan_spec rn5t618_adc_iio_channels[] = {
>  	RN5T618_ADC_CHANNEL(AIN0, IIO_VOLTAGE, "AIN0")
>  };
>  
> -static struct iio_map rn5t618_maps[] = {
> +static const struct iio_map rn5t618_maps[] = {
>  	IIO_MAP("VADP", "rn5t618-power", "vadp"),
>  	IIO_MAP("VUSB", "rn5t618-power", "vusb"),
>  	{ /* sentinel */ }
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 100ecced5fc1..5d459f050634 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -114,7 +114,7 @@ struct sun4i_gpadc_iio {
>  	.datasheet_name = _name,				\
>  }
>  
> -static struct iio_map sun4i_gpadc_hwmon_maps[] = {
> +static const struct iio_map sun4i_gpadc_hwmon_maps[] = {
>  	{
>  		.adc_channel_label = "temp_adc",
>  		.consumer_dev_name = "iio_hwmon.0",
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 151099be2863..7f325b3ed08f 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -20,7 +20,7 @@
>  
>  struct iio_map_internal {
>  	struct iio_dev *indio_dev;
> -	struct iio_map *map;
> +	const struct iio_map *map;
>  	struct list_head l;
>  };
>  
> @@ -42,7 +42,7 @@ static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
> +int iio_map_array_register(struct iio_dev *indio_dev, const struct iio_map *maps)
>  {
>  	struct iio_map_internal *mapi;
>  	int i = 0;
> @@ -86,7 +86,8 @@ static void iio_map_array_unregister_cb(void *indio_dev)
>  	iio_map_array_unregister(indio_dev);
>  }
>  
> -int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev, struct iio_map *maps)
> +int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev,
> +				const struct iio_map *maps)
>  {
>  	int ret;
>  
> diff --git a/include/linux/iio/driver.h b/include/linux/iio/driver.h
> index 7a157ed218f6..7f8b55551ed0 100644
> --- a/include/linux/iio/driver.h
> +++ b/include/linux/iio/driver.h
> @@ -18,7 +18,7 @@ struct iio_map;
>   * @map:	array of mappings specifying association of channel with client
>   */
>  int iio_map_array_register(struct iio_dev *indio_dev,
> -			   struct iio_map *map);
> +			   const struct iio_map *map);
>  
>  /**
>   * iio_map_array_unregister() - tell the core to remove consumer mappings for
> @@ -38,6 +38,7 @@ int iio_map_array_unregister(struct iio_dev *indio_dev);
>   * handle de-registration of the IIO map object when the device's refcount goes to
>   * zero.
>   */
> -int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev, struct iio_map *maps);
> +int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev,
> +				const struct iio_map *maps);
>  
>  #endif


