Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70CB3FB7B3
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhH3ORP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236916AbhH3ORO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:17:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4719C60F23;
        Mon, 30 Aug 2021 14:16:15 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:19:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 33/40] iio: adc: ti_am335x_adc: Gather the checks on the
 delays
Message-ID: <20210830151926.059db21a@jic23-huawei>
In-Reply-To: <20210825152518.379386-34-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-34-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:11 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Move the checks over the delays provided in the device tree to the
> location where these values are read to clarify where they come from.
> 
> There are no functional changes besides the device structure used to
> display the warnings: let's use the ADC instead of the MFD device.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 47 +++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 00bbf557e86c..4eaf5b031707 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -97,7 +97,6 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
>  static void tiadc_step_config(struct iio_dev *indio_dev)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	struct device *dev = adc_dev->mfd_tscadc->dev;
>  	unsigned int stepconfig;
>  	int i, steps = 0;
>  
> @@ -115,12 +114,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  
>  		chan = adc_dev->channel_line[i];
>  
> -		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
> -			dev_warn(dev, "chan %d step_avg truncating to %d\n",
> -				 chan, STEPCONFIG_AVG_16);
> -			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
> -		}
> -
>  		if (adc_dev->step_avg[i])
>  			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
>  				     STEPCONFIG_FIFO1;
> @@ -135,18 +128,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  			     STEPCONFIG_INM_ADCREFM | STEPCONFIG_RFP_VREFP |
>  			     STEPCONFIG_RFM_VREFN);
>  
> -		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
> -			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
> -				 chan);
> -			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
> -		}
> -
> -		if (adc_dev->sample_delay[i] > 0xFF) {
> -			dev_warn(dev, "chan %d sample delay truncating to 0xFF\n",
> -				 chan);
> -			adc_dev->sample_delay[i] = 0xFF;
> -		}
> -
>  		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
>  			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
>  			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
> @@ -552,6 +533,7 @@ static int tiadc_parse_dt(struct platform_device *pdev,
>  	const __be32 *cur;
>  	int channels = 0;
>  	u32 val;
> +	int i;
>  
>  	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>  		adc_dev->channel_line[channels] = val;
> @@ -564,6 +546,8 @@ static int tiadc_parse_dt(struct platform_device *pdev,
>  		channels++;
>  	}
>  
> +	adc_dev->channels = channels;
> +
>  	of_property_read_u32_array(node, "ti,chan-step-avg",
>  				   adc_dev->step_avg, channels);
>  	of_property_read_u32_array(node, "ti,chan-step-opendelay",
> @@ -571,7 +555,30 @@ static int tiadc_parse_dt(struct platform_device *pdev,
>  	of_property_read_u32_array(node, "ti,chan-step-sampledelay",
>  				   adc_dev->sample_delay, channels);
>  
> -	adc_dev->channels = channels;
> +	for (i = 0; i < adc_dev->channels; i++) {
> +		int chan;
> +
> +		chan = adc_dev->channel_line[i];
> +
> +		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
> +			dev_warn(&pdev->dev, "chan %d step_avg truncating to %d\n",
> +				 chan, STEPCONFIG_AVG_16);
> +			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
> +		}
> +
> +		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
> +			dev_warn(&pdev->dev, "chan %d open delay truncating to 0x3FFFF\n",
> +				 chan);
> +			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
> +		}
> +
> +		if (adc_dev->sample_delay[i] > 0xFF) {
> +			dev_warn(&pdev->dev, "chan %d sample delay truncating to 0xFF\n",
> +				 chan);
> +			adc_dev->sample_delay[i] = 0xFF;
> +		}
> +	}
> +
>  	return 0;
>  }
>  

