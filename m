Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662EB410794
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhIRQUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 12:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhIRQU3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 12:20:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40372610A3;
        Sat, 18 Sep 2021 16:19:00 +0000 (UTC)
Date:   Sat, 18 Sep 2021 17:22:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v3 27/47] mfd: ti_am335x_tscadc: Clarify the maximum
 values for DT entries
Message-ID: <20210918172240.647dbb1e@jic23-huawei>
In-Reply-To: <20210915155908.476767-28-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-28-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021 17:58:48 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Clearly define the maximum open delay and sample delay. Use these
> definitions in place of a mask (which works because this is the first
> field in the register) and an open-coded value. While at it reword a
> little bit the error messages to make them look clearer and similar.

I wouldn't bother explaining why the old method of using the mask happened
to work.  It confused me when reading this description :)

Otherwise, lgtm
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 18 +++++++++---------
>  include/linux/mfd/ti_am335x_tscadc.h |  2 ++
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 3dec115e68ee..a241e6fa3564 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -126,7 +126,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  		chan = adc_dev->channel_line[i];
>  
>  		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
> -			dev_warn(dev, "chan %d step_avg truncating to %ld\n",
> +			dev_warn(dev, "chan %d: wrong step avg, truncated to %ld\n",
>  				 chan, STEPCONFIG_AVG_16);
>  			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
>  		}
> @@ -147,16 +147,16 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  				STEPCONFIG_RFP_VREFP |
>  				STEPCONFIG_RFM_VREFN);
>  
> -		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
> -			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
> -				 chan);
> -			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
> +		if (adc_dev->open_delay[i] > STEPCONFIG_MAX_OPENDLY) {
> +			dev_warn(dev, "chan %d: wrong open delay, truncated to 0x%lX\n",
> +				 chan, STEPCONFIG_MAX_OPENDLY);
> +			adc_dev->open_delay[i] = STEPCONFIG_MAX_OPENDLY;
>  		}
>  
> -		if (adc_dev->sample_delay[i] > 0xFF) {
> -			dev_warn(dev, "chan %d sample delay truncating to 0xFF\n",
> -				 chan);
> -			adc_dev->sample_delay[i] = 0xFF;
> +		if (adc_dev->sample_delay[i] > STEPCONFIG_MAX_SAMPLE) {
> +			dev_warn(dev, "chan %d: wrong sample delay, truncated to 0x%lX\n",
> +				 chan, STEPCONFIG_MAX_SAMPLE);
> +			adc_dev->sample_delay[i] = STEPCONFIG_MAX_SAMPLE;
>  		}
>  
>  		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index e6fe623bb1aa..babc2e36c5d0 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -91,7 +91,9 @@
>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>  #define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
>  #define STEPDELAY_SAMPLE(val)	FIELD_PREP(STEPDELAY_SAMPLE_MASK, (val))
> +#define STEPCONFIG_MAX_OPENDLY	GENMASK(17, 0)
>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
> +#define STEPCONFIG_MAX_SAMPLE	GENMASK(7, 0)
>  
>  /* Charge Config */
>  #define STEPCHARGE_RFP_MASK	GENMASK(14, 12)

