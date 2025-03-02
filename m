Return-Path: <linux-iio+bounces-16226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6155A4AF1F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 04:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BB17A7ED4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47A154457;
	Sun,  2 Mar 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LICkLh9E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E523F383;
	Sun,  2 Mar 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740886867; cv=none; b=tvm4ZOs3UeZMD9U+Bvnt2B+1dN0rQMh9r4y/i7QcFX2wO3T3wR1BiZxMolZEmU2SYcUEaYkps5g1bIgWbseaB5TiguFVst4VfeSRU0tVRKIZEYu+maiiO1AHHMP5qUoVxlF8SKx1sXQnZDM0xvpDUFHdhLIsM280YdVYGRB2jiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740886867; c=relaxed/simple;
	bh=g2PKSkh0Ix0P5C8ybr4GhP9l94eYbu1/YakbGSz2CUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie4N2toYlaLYV4xhaQlxORQIX3mVft6Wo51bR36zQ+3k44ifn3Q7vMZ0aNPZ29/Nx309zikG8Jc3a0bUKunJNzymeBMAPr2o5aEV3Qt4z7Qe3Lixj5/EAQbbGHyRBPrriQeqWJlO5V5FRBEtef8NoicE+uoXULtNwkDY/S9jjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LICkLh9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7A0C4CEE2;
	Sun,  2 Mar 2025 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740886865;
	bh=g2PKSkh0Ix0P5C8ybr4GhP9l94eYbu1/YakbGSz2CUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LICkLh9EUFCAkx8Xzb2DvtqLTZzOV2Js5TE8phQQXE5TTV1ytkJScVTvG4u0esVWU
	 c+1ZvtBLpkYZzjk3CLyu6iSUTbSMZn28vTJ5Yu8UGm4IEz7KgG/iulAsskm0G4W4On
	 91HBeA5AWKAT7rXrabfCudFMh2pEFEwJtR8cUsf+Xg3BH4Mj8vx/uQmuy23h9VRvwC
	 gfNJvugmRWyOVYhl5QA0b/c6vhidbGh3Gq9GvBcvdHYm+JjhS1R1ddQ82PYSa1mxQf
	 86ZQ4PITZ8Z1syVR4QRdhhvsTJ7+wnv47xshTZXRmrRsauWwhcS+nZl3/b7BXJnDkJ
	 5P/vy6EVTClXA==
Date: Sun, 2 Mar 2025 03:40:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <20250302034042.59d83f53@jic23-huawei>
In-Reply-To: <5658fbdd886cc7ada278a42c63a140bc14d1277d.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<5658fbdd886cc7ada278a42c63a140bc14d1277d.1740421248.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 20:33:29 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
> drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg",
> "diff-channels", "single-channel" and the "common-mode-channel" to
> channel identification numbers used in the struct iio_chan_spec.

Needs an update to reflecting naming and functionality simplifications.

> Furthermore, the helper checks the ID is in range of 0 ... num-channels.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> othervice. Also, same grep shows all the .dts seem to have channel IDs
otherwise

(othervice does sound cool though ;)

> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v3 => v4:
>  - Adapt to 'drop diff-channel support' changes to ADC-helpers
>  - select ADC helpers in the Kconfig
>  - Rebased to 6.14-rc3 => channel type can no longer come from the
>    template.
> 
> v2 => v3:
>  - New patch
> 
> I picked the rzg2l_adc in this series because it has a straightforward
> approach for populating the struct iio_chan_spec. Only other member
> in the stuct besides the .channel, which can't use a 'template' -data,
> is the .datasheet_name. This makes the rzg2l_adc well suited for example
> user of this new helper. I hope this patch helps to evaluate whether these
> helpers are worth the hassle.
This doesn't seem to match driver. It is messing with channel type.

> 
> The change is compile tested only!! Testing before applying is highly
> appreciated (as always!).
> ---
>  drivers/iio/adc/Kconfig     |  1 +
>  drivers/iio/adc/rzg2l_adc.c | 38 +++++++++++++++++--------------------
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 37b70a65da6f..e4933de0c366 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1222,6 +1222,7 @@ config RICHTEK_RTQ6056
>  config RZG2L_ADC
>  	tristate "Renesas RZ/G2L ADC driver"
>  	depends on ARCH_RZG2L || COMPILE_TEST
> +	select IIO_ADC_HELPER
>  	help
>  	  Say yes here to build support for the ADC found in Renesas
>  	  RZ/G2L family.
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 883c167c0670..51c87b1bdc98 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -11,6 +11,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/iio/adc-helpers.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -324,21 +325,30 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct iio_chan_spec rzg2l_adc_chan_template = {
> +	.indexed = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +};
> +
>  static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
>  {
>  	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
>  	struct iio_chan_spec *chan_array;
>  	struct rzg2l_adc_data *data;
> -	unsigned int channel;
>  	int num_channels;
> -	int ret;
>  	u8 i;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	num_channels = device_get_child_node_count(&pdev->dev);
> +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(&pdev->dev,
> +						&rzg2l_adc_chan_template,
> +						hw_params->num_channels - 1,
> +						&chan_array);
> +	if (num_channels < 0)
> +		return num_channels;
> +
>  	if (!num_channels)
>  		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
>  
> @@ -346,26 +356,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>  		return dev_err_probe(&pdev->dev, -EINVAL,
>  				     "num of channel children out of range\n");
>  
> -	chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
> -				  GFP_KERNEL);
> -	if (!chan_array)
> -		return -ENOMEM;
> -
> -	i = 0;
> -	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
> -		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> -		if (ret)
> -			return ret;
> -
> -		if (channel >= hw_params->num_channels)
> -			return -EINVAL;
> +	for (i = 0; i < num_channels; i++) {
> +		int channel = chan_array[i].channel;
>  
> -		chan_array[i].type = rzg2l_adc_channels[channel].type;
> -		chan_array[i].indexed = 1;
> -		chan_array[i].channel = channel;
> -		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>  		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
> -		i++;
> +		chan_array[i].type = rzg2l_adc_channels[channel].type;
>  	}
>  
>  	data->num_channels = num_channels;
> @@ -626,3 +621,4 @@ module_platform_driver(rzg2l_adc_driver);
>  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
>  MODULE_DESCRIPTION("Renesas RZ/G2L ADC driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("IIO_DRIVER");


