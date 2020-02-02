Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F714FDB9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBBPIu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 10:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgBBPIt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 10:08:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E2420658;
        Sun,  2 Feb 2020 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580656129;
        bh=MbwWz+Xr5jeuQXzy+A240cKa0DzeXQJJ8JhIdF1svQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ayZM0OKgdF3t6ycOyPjEznVcwgsVyZODN7LhT66r7PQw1VrGaIXzhnCJ6p7+RdsEX
         lTGIlhxm1BD1yqydXROrD2lfcAQVq6XAWXJr94m0HwbJHlXWaBvhv3qV9BBy7ZJb2M
         Acq4fSHWAUa8vHa46aJlP0uUrNc6hu2hWm/t97Zc=
Date:   Sun, 2 Feb 2020 15:08:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v5] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200202150843.762c6897@archlinux>
In-Reply-To: <BYAPR10MB3479E348502A3E94F293559DA3080@BYAPR10MB3479.namprd10.prod.outlook.com>
References: <20200121210419.13372-1-linus.walleij@linaro.org>
        <20200121210419.13372-2-linus.walleij@linaro.org>
        <BYAPR10MB3479CEEA65545B8422C77091A30E0@BYAPR10MB3479.namprd10.prod.outlook.com>
        <CACRpkdYMxXL6oY0eA+5EYOUTZ_opAtiT-6THfc9dwy_9Ufq8MQ@mail.gmail.com>
        <BYAPR10MB3479E348502A3E94F293559DA3080@BYAPR10MB3479.namprd10.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jan 2020 20:27:22 +0000
Jonathan Bakker <xc-racer2@live.ca> wrote:

> Hi Linus,
> 
> On 2020-01-26 7:16 a.m., Linus Walleij wrote:
> > On Fri, Jan 24, 2020 at 1:47 AM Jonathan Bakker <xc-racer2@live.ca> wrote:
> >   
> >> Thanks for the driver, I've tested it on a first-gen Galaxy S
> >> device with a GP2AP002A00F.  I have a few comments that I've put inline
> >> based on my experiences.  
> > 
> > Thanks a lot!
> >   
> >> Both shortly after probe (when runtime pm timeout occurs?) and after
> >> manually disabling the proximity event, this
> >> irq handler is called.  Since the chip is in low power state, it obviously
> >> fails to read the proximity value and write to the OCON register below, eg
> >>
> >> [    7.215875] gp2ap002 11-0044: error reading proximity
> >> [    8.105878] gp2ap002 11-0044: error setting up VOUT control 1
> >>
> >> Can we do something like disable_irq() in the runtime pm function to prevent
> >> this?  
> > 
> > I added that in v6, I hope this solves your problem.  
> 
> Yep, it appears to.  Thanks.
> 
> >   
> >> The gp2ap002s00f_regmap_i2c_read function works on the gp2ap002a00f as well,
> >> so this can be simplified/dropped.  
> > 
> > Fixed this too in v6.
> >   
> >>> +             if (ch_type != IIO_CURRENT) {
> >>> +                     dev_err(dev,
> >>> +                             "wrong type of IIO channel specified for ALSOUT\n");
> >>> +                     return -EINVAL;
> >>> +             }  
> >>
> >> This enforces a current ADC, while several devices besides mine (eg Galaxy Nexus)
> >> use a resistor and a voltage ADC.  For this case, could we add a device property such as
> >> sharp,adc-adjustment-ratio to convert from the raw ADC values to a "current" that
> >> could be used in the lookup table?  So the "current" would be the raw ADC divided
> >> by that special value.
> >>
> >> Instructions for converting the ADC back to the current can be found eg at
> >> https://android.googlesource.com/device/samsung/crespo/+/2e0ab7265e3039fee787c2216e0c98d92ea0b49e%5E%21/#F0  
> > 
> > I'd like to keep that as a future enhancement unless someone is very eager
> > to get it and has a device they can test it on. Otherwise it will be
> > just dry-coding
> > on my part.  
> 
> Well, I've got such a device and can test :)
> 
> > 
> > I think the property we would add in the device tree in that case should
> > be the resistance value. This is based on the following assumption
> > which is indeed a bit of speculation since there is no proper datasheet
> > for the light sensor part of the component:
> > 
> > - The light sensor part is simply a photodiode
> > - This emits a nonlinear current in relation to how many
> >   photons hit the photodiode in a time interval, the relationship
> >   is described in the curren->lux table we have
> > - Some vendors do not have any current ADC, so they connect
> >   this to a resistor, and measure the voltage over the
> >   resistor because the have a voltage ADC
> > 
> > Since current is linear to the voltage over the resistor, we should
> > include the resistance in the device tree, then using that the
> > corresponding current can be calculated and we use the same
> > look-up table to find the lux. Probably each system may need
> > to also subtract some bias voltage or so.  
> 
> Yes, this is my understanding of it as well (I also have no datasheet).
> 
> Given V = actual voltage in V, Vref = reference voltage of ADC in V, ADC = value
> read from ADC, ADCmax = maximum possible value read from ADC, I = current in amps,
> R = resistor value in ohms, uA = current in microamps
> 
> V / Vref = ADC / ADCmax
> V = (ADC / ADCmax) * Vref
> 
> V = I * R
> I * R = (ADC / ADCmax) * Vref
> I = ADC * Vref / ADCmax / R
> 
> However, because we want the current in uA for the table, (note, your comment says
> that the table is based on mA, but I believe that it should actually be uA)
> 
> uA = ADC * Vref / ADCmax / R * 1000000
> 
> Then, in order to avoid multiplying by a decimal, the uA is the ADC value divided
> by the inverse of
> 
> (1000000 * Vref / ADCmax / R)
> 
> For example, on the first gen Galaxy S series and the Nexus S, the Vref is 3.3V,
> the ADC is 12 bit (2^12 = 4096, so high value is 4095), the resistor is 47000ohms,
> 
> inverse of (1000000 * 3.3 / 4095 / 47000) = 58
> 
> so we need to divide the raw ADC reading by 58 in order to get the uA for the current->lux
> table.
> 
> A quick patch that I used for testing (based off of v5) is
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index a5897959f70d..b98aec337f8b 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -130,6 +130,7 @@
>   * @vdd: regulator controlling VDD
>   * @vio: regulator controlling VIO
>   * @alsout: IIO ADC channel to convert the ALSOUT signal
> + * @adc_adj: conversion factor if voltage ADC used instead of current ADC
>   * @is_gp2ap002s00f: this is the GP2AP002F variant of the chip
>   * @enabled: we cannot read the status of the hardware so we need to
>   * keep track of whether the event is enabled using this state variable
> @@ -143,6 +144,7 @@ struct gp2ap002 {
>  	enum iio_event_direction dir;
>  	u8 hys_far;
>  	u8 hys_close;
> +	u8 adc_adj;
>  	bool is_gp2ap002s00f;
>  	bool enabled;
>  };
> @@ -272,6 +274,9 @@ static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (gp2ap002->adc_adj)
> +		res /= gp2ap002->adc_adj;
> +
>  	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
>  
>  	ill1 = &gp2ap002_illuminance_table[0];
> @@ -588,7 +593,16 @@ static int gp2ap002_probe(struct i2c_client *client,
>  		ret = iio_get_channel_type(gp2ap002->alsout, &ch_type);
>  		if (ret < 0)
>  			return ret;
> -		if (ch_type != IIO_CURRENT) {
> +		if (ch_type == IIO_VOLTAGE) {
> +			ret = device_property_read_u8(dev,
> +				"sharp,adc-adjustment-ratio", &val);
> +			if (ret) {
> +				dev_err(dev,
> +					"failed to obtain adc conversion\n");
> +				return -EINVAL;
> +			}
> +			gp2ap002->adc_adj = val;
> +		} else if (ch_type != IIO_CURRENT) {
>  			dev_err(dev,
>  				"wrong type of IIO channel specified for ALSOUT\n");
>  			return -EINVAL;
> 
> Alternatively, you could collect the resistor value, the ADC precision (this doesn't
> appear to be queryable via the IIO layer), and the reference voltage level - but I'm
> not sure how you'd do the inverse calculation in the kernel.

An alternative to doing this is to represent the resistor circuit explicitly.

You end up with a really small ADC driver that is a consumer of a voltage
and provides a current channel.  That has all the properties of the
circuit via DT.

We do some stuff a bit similar to this in the envelope detector driver.

In general I would prefer we handle this sort of conversion generically
rather than bolting it into a light sensor driver like you are doing here,
even if it comes at the cost of a bit more complexity.

Jonathan

> 
> > 
> > But we definately need something to test on to do this right> 
> > Yours,
> > Linus Walleij
> >   
> 
> Thanks,
> Jonathan Bakker

