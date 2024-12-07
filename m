Return-Path: <linux-iio+bounces-13199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFF9E8161
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892D280DD9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D25150980;
	Sat,  7 Dec 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2kmN7Mu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2E38FA3;
	Sat,  7 Dec 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593383; cv=none; b=Tk0f1PvGGek6/gAER6UbK/9M1T7xf/m6LGn/vzMhLouDHqIYDtjh+QOX0uic/JBT+DresA1MVeRksrCTmpfZqF0WKAghg4Q/rshNjcFjYsr1BU2W1TtHlCsuGQfkK3hD3heI6NNJajoF3xBDOSQPlgkQT8+mp37+YoVmRPoYkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593383; c=relaxed/simple;
	bh=8TJw42KQIdAyQpZuXszACa6u678T+EY85kcHnFKpwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf8vdRCMwapKsPTj13lyrniNS5WOo5YN+VG7CUC1M05M0R721AVoT3C1SDGqXseL+PLJhpVIiPQdpJhRh3PJVy+T7KzQkV7I7IqVQBrlb6tR7UI1lFBXqhgOkS1+dQY2KJ7K1NCDxBmByzd8QbGhlQEnrh//wDY6/7rdFAR+DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2kmN7Mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D0C4CECD;
	Sat,  7 Dec 2024 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733593382;
	bh=8TJw42KQIdAyQpZuXszACa6u678T+EY85kcHnFKpwKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2kmN7MuHSz8MgDFVhzrvFLXoJlUPG0PAsQkRrFgGQToXp/OR0ZgQ6utb+f9lRCBn
	 4ZnFVTJgY9zIUCORCsJk3EsUgbLNAMwww1lxJ3tGXH2UdAfYzC5w58pbF/WWHYAr7+
	 NFVoVPteXoJbNXDlHqsz701YmhWrtTtVTH9XtgufEH8+ukMwfXqGcycQ4I34BeBcai
	 TN+VNTClvYo6q0/QZnGOOzDnnDDojSBACwePJcMIkwEuwMkP6/TymfBjFOkEgtUIXX
	 gtAMRadoZym2XLChc6chkXCvR06gLWgXm7zBXM0WG4+70lF54kzJRiflCkutlJJeF7
	 5blb+nDO3xnKQ==
Date: Sat, 7 Dec 2024 17:42:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 09/14] iio: adc: rzg2l_adc: Add support for channel 8
Message-ID: <20241207174230.3b64bd2b@jic23-huawei>
In-Reply-To: <0e5bafb1-fbf9-4168-bbe4-1feaaa6f812b@tuxon.dev>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-10-claudiu.beznea.uj@bp.renesas.com>
	<20241203201857.7ccdcf99@jic23-huawei>
	<0e5bafb1-fbf9-4168-bbe4-1feaaa6f812b@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 10:50:03 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Jonathan,
> 
> On 03.12.2024 22:18, Jonathan Cameron wrote:
> > On Tue,  3 Dec 2024 13:13:09 +0200
> > Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >   
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
> >> 8) dedicated to reading temperature values from the Thermal Sensor Unit
> >> (TSU). There is a direct in-SoC connection between the ADC and TSU IPs.
> >>
> >> To read the temperature reported by the TSU, a different sampling rate
> >> (compared to channels 0-7) must be configured in the ADM3 register.
> >>
> >> The rzg2l_adc driver has been updated to support reading the TSU
> >> temperature.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
> >   
> >>  static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> >> @@ -161,7 +173,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
> >>  	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
> >>  }
> >>  
> >> -static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> >> +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch, enum iio_chan_type type)
> >>  {
> >>  	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
> >>  	u32 reg;
> >> @@ -177,6 +189,15 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> >>  	reg |= BIT(ch);
> >>  	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
> >>  
> >> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
> >> +	reg &= ~hw_params->adsmp_mask;
> >> +	/*
> >> +	 * type could be IIO_VOLTAGE = 0 or IIO_TEMP = 9. Divide to 8 to get
> >> +	 * index 0 or 1 depending on the channel type.  
> > 
> > That is not particularly nice and potentially a little fragile if we get other device
> > support in future. Better to match on the type in rzg2l_adc_channels[] possibly wrapped
> > up in a little utility function bool rzg2l_adc_channels_is_temp(); Then use a
> > ? 1 : 0 to get the offset in default_adsmp[]  
> 
> I though about this, too, but considered we should not go beyond 1 as the
> rzg2l_adc_conversion_setup() is currently call in places where the channel
> type is only IIO_VOLTAGE and IIO_TEMP, just saying...
> 
> I'll switch to the approach you propose in the next version.
> 
> > 
> >   
> >> +	 */
> >> +	reg |= hw_params->default_adsmp[type / 8];
> >> +	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> >> +
> >>  	/*
> >>  	 * Setup ADINT
> >>  	 * INTS[31] - Select pulse signal
> >> @@ -192,7 +213,8 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> >>  	return 0;
> >>  }
> >>
> >>  
> >> +	case IIO_CHAN_INFO_PROCESSED:
> >> +		if (chan->type != IIO_TEMP)
> >> +			return -EINVAL;
> >> +
> >> +		mutex_lock(&adc->lock);
> >> +		ret = rzg2l_adc_conversion(indio_dev, chan->type, adc, ch);
> >> +		if (!ret) {
> >> +			/* Convert it to mili Celsius. */
> >> +			*val = adc->last_val[ch] * 1000;  
> > Prefer you provide a scale of 1000 and report this raw.  
> 
> I'll look to this.
> 
> >> +		}  
> > Also strong preference for error conditions out of line.
> > As in that other case, guard() makes that easier as yo ucan do
> > 		{
> > 
> > 			guard(mutex)(&adc->lock);
> > 			ret = rz....
> > 			if (ret)
> > 				return ret;
> > 
> > 			*val = ...
> > 			
> > 			return IIO_VAL_INT;
> > 		}  
> 
> 
> I agree, looks cleaner with guard().
> 
> >   
> >> +		mutex_unlock(&adc->lock);
> >> +
> >> +		return ret ? ret : IIO_VAL_INT;
> >> +
> >>  	default:
> >>  		return -EINVAL;
> >>  	}  
> >   
> >>  static const struct iio_info rzg2l_adc_iio_info = {
> >> @@ -332,11 +368,14 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
> >>  		if (channel >= hw_params->num_channels)
> >>  			return -EINVAL;
> >>  
> >> -		chan_array[i].type = IIO_VOLTAGE;
> >> +		chan_array[i].type = rzg2l_adc_channels[channel].type;
> >>  		chan_array[i].indexed = 1;
> >>  		chan_array[i].channel = channel;
> >> -		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> >> -		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
> >> +		if (rzg2l_adc_channels[channel].type == IIO_VOLTAGE)
> >> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> >> +		else
> >> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);  
> > 
> > Make it raw, but I'm curious we have no _SCALE on this device.  Do we really have no idea
> > of the calibration of these channels?  
> 
> The calibration data is stored on the TSU (Thermal Sensor Unit) hardware
> block. From the TSU driver (not yet published) we read the temperature
> through the ADC channel and apply the calibration data on the value
> returned by ADC (this is how HW manual suggests). This is the current
> (internal) struct thermal_zone_device_ops::get_temp() API of the TSU driver
> (it will be published later, after some clarifications with hardware team
> on SoC specific aspects):
> 
> // ..
> 
> #define TSU_READ_STEPS		8
> #define MCELSIUS(temp)		(temp * MILLIDEGREE_PER_DEGREE)
> 
> // ...
> 
> struct rzg3s_thermal_priv {
> 	void __iomem *base;
> 	struct device *dev;
> 	struct thermal_zone_device *tz;
> 	struct reset_control *rstc;
> 	struct iio_channel *channel;
> 	u16 calib0;
> 	u16 calib1;
> };
> 
> // ...
> 
> static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> {
> 	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
> 	struct device *dev = priv->dev;
> 	u32 ts_code_ave = 0;
> 	int ret, val;
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret)
> 		return ret;
> 
> 	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
> 		ret = iio_read_channel_processed(priv->channel, &val);

I'd switch this to iio_read_channel_raw() given the scale is meaningless
without the calibration done in here and that processed channel is
exposed to userspace as well.  If it were to use raw and scale and
then IIRC iio_read_channel_raw() does the maths for you anyway giving
same result here.

Beyond that, this seems reasonable except (see below)

> 		if (ret < 0)
> 			goto rpm_put;
> 		
> 		ts_code_ave += val;
> 		/*
> 		 * According to HW manual (section 40.4.4 Procedure for
> 		 * Measuring the Temperature) we need to wait here at
> 		 * leat 3us.
> 		 */
> 		usleep_range(5, 10);
> 	}
> 
> 	ret = 0;
> 	ts_code_ave = DIV_ROUND_CLOSEST(ts_code_ave, TSU_READ_STEPS);
> 
> 	/*
> 	 * According to HW manual (section 40.4.4 Procedure for Measuring
> 	 * the Temperature) the formula mentioned in the hardware manual is
> 	 * as follows;
> 	 *
> 	 * Tj = (ts_code_ave - priv->calib0) * (165 / (priv->calib0 -
> 	 * priv->calib1)) - 40
> 	 *
> 	 * As the temperature retrieved from the IIO channel is in
> 	 * milicelsius convert all members of the equation to milicelsius.
> 	 * It has been chose like this to avoid loosing precisions by
> 	 * converting IIO reported temperature to celsius.

I'm confused. How does it have a unit if you are only applying a calibration
here?  Or is this a precision tweak on a roughly right fixed calibration?

Jonathan


> 	 */
> 	*temp = DIV_ROUND_CLOSEST_ULL(((u64)(ts_code_ave -
> 		MCELSIUS(priv->calib1)) * MCELSIUS(165)),
> 		MCELSIUS((priv->calib0 - priv->calib1))) - MCELSIUS(40);
> 
> 	/* Round it up to 0.5 degrees Celsius. */
> 	*temp = roundup(*temp, 500);
> 
> rpm_put:
> 	pm_runtime_mark_last_busy(dev);
> 	pm_runtime_put_autosuspend(dev);
> 
> 	return ret;
> }
> 
> 
> >   
> >> +		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
> >>  		i++;
> >>  	}
> >>  
> >> @@ -386,7 +425,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
> >>  	reg &= ~RZG2L_ADM3_ADCMP_MASK;
> >>  	reg &= ~hw_params->adsmp_mask;
> >>  	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
> >> -	       hw_params->default_adsmp;
> >> +	       hw_params->default_adsmp[0];
> >>  
> >>  	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> >>  
> >> @@ -479,7 +518,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> >>  	.num_channels = 8,
> >>  	.default_adcmp = 0xe,
> >> -	.default_adsmp = 0x578,
> >> +	.default_adsmp = { 0x578 },
> >>  	.adsmp_mask = GENMASK(15, 0),
> >>  	.adint_inten_mask = GENMASK(7, 0),
> >>  	.adivc = true  
> >   


