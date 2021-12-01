Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C498464B50
	for <lists+linux-iio@lfdr.de>; Wed,  1 Dec 2021 11:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhLAKPT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Dec 2021 05:15:19 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57561 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhLAKPT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2021 05:15:19 -0500
Received: (Authenticated sender: foss@0leil.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1B44E1C0015;
        Wed,  1 Dec 2021 10:11:54 +0000 (UTC)
Date:   Wed, 1 Dec 2021 11:11:52 +0100
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] iio:adc:axp20x: add support for NTC thermistor
Message-ID: <20211201101152.fyimgddfd7mpwjg2@fiqs>
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-2-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118141233.247907-2-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Evgeny,

On Thu, Nov 18, 2021 at 05:12:32PM +0300, Evgeny Boger wrote:
> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
> TS pin. When appropriately configured, AXP PMICs will inject fixed
> current (80uA by default) into TS pin and measure the voltage across a
> thermistor. The PMIC itself will by default compare this voltage with
> predefined thresholds  and disable battery charging whenever

They actually are configurable, it's just that we don't have the means
to configure it currently from the kernel.

"In the diagram above, VTH/VTL refers to the high temperature threshold
and low temperature threshold, which is programmable via registers
REG38H/39H/3CH/3DH respectively." in the AXP209 datasheet, section
"Battery temperature detection".

> the battery is too hot or too cold.
> 
> Alternatively, the TS pin can be configured as general-purpose
> ADC input. This mode is not supported by the driver.
> 
> This patch allows reading the voltage on the TS pin. It can be then
> either processed by userspace or used by kernel consumer like hwmon
> ntc thermistor driver.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 45 +++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 3e0c0233b431..12d469a52cea 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
[...]
> +static int axp22x_adc_scale_voltage(int channel, int *val, int *val2)
> +{
> +	switch (channel) {
> +	case AXP22X_BATT_V:
> +		/* 1.1 mV per LSB */
> +		*val = 1;
> +		*val2 = 100000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case AXP22X_TS_IN:
> +		/* 0.8 mV per LSB */
> +		*val = 0;
> +		*val2 = 800000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
[...]
> @@ -378,12 +415,7 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>  {
>  	switch (chan->type) {
>  	case IIO_VOLTAGE:
> -		if (chan->channel != AXP22X_BATT_V)
> -			return -EINVAL;
> -
> -		*val = 1;
> -		*val2 = 100000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		return axp22x_adc_scale_voltage(chan->channel, val, val2);
>  

I would actually have made the move to axp22x_adc_scale_voltage function
for AXP22X_BATT_V channel separate from this commit because I was a bit
confused in the original review why suddenly there was an addition for
AXP22X_BATT_V while this patch is about AXP22X_TS_IN.

If maintainers are ok with this, I don't mind.

I don't have any HW to test this but the changes make sense to me:
Reviewed-by: Quentin Schulz <foss+kernel@0leil.net>

Thanks!
Quentin
