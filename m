Return-Path: <linux-iio+bounces-9543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A997909D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4971C21A78
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2621CEE9C;
	Sat, 14 Sep 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuDz8h7u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0E4C96;
	Sat, 14 Sep 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314336; cv=none; b=hekU4wPUoZUHSEkNiI/8jJTDGG+XUOVVwcFAjsETwGqeZWFeXo0eLwSAw6VaP7wnkYVUVEmwwhG8q97omQrZMxCfGEVk1ID2l1K0pXUf0hfVrCCTs9FZpfXleF1AQHvrzGW+MCDC+9qLHryaPGXhuZ8e6w1DvuQ9WxapPtzoMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314336; c=relaxed/simple;
	bh=ODXDl4HXjM1i5HqPQSsHxa5at5Q97DC+YtL5/21LNXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbkFiqhJRvVV+1DHFVBUvkBfRSv7U2iBoX/S7hWjZIXU3S4SPxwMX/UUTKICmb2yVEXMgnjRiTRHS02r5IIPmEAMXCFZ4K4GoS4NP0RRCg1uFcWq08Z4soCWwbLD1eAqaEfeQQEnP8qQMUKUiwYEGy2oRhM+6j1Zv9zT/rk/JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuDz8h7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9C0C4CEC0;
	Sat, 14 Sep 2024 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726314335;
	bh=ODXDl4HXjM1i5HqPQSsHxa5at5Q97DC+YtL5/21LNXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuDz8h7uiPSbdz+wHcKztYSuBDJCvvvSMA0E6lIvX0jRGqAIPIUarcKcVE1kYwSbD
	 NHYLFddYOF8bjEX8uAwAcGerTfnqewHb1TGt5dXXePPpGCsPu9hzi322r03CI7vGJO
	 Q12oHd+M8jdvqFKkECthdMGjt5KqzkIBY+NKPxIzJZ4MmzYtMACccJXTWJevawqFNc
	 SpEvKPlskrm6u2sMUjqPeam2zOwdk400JAYNWxkUPcUUhYuiDeODdrYDNvHaL6yldf
	 sYTamGspXAD/NDHhvhKzHEWqyFBvAc2dNVBJJ7xKTf7iGn9uABUt0O6K+aQ5XQWB5L
	 kxkC/yiEbIGsw==
Date: Sat, 14 Sep 2024 12:45:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240914124527.1b89a660@jic23-huawei>
In-Reply-To: <DM8PR03MB6213FD30FCD465AA0262E4BB919A2@DM8PR03MB6213.namprd03.prod.outlook.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-3-Mariel.Tinaco@analog.com>
	<e9cbcd85-062c-47ad-861c-229cb2fd6c2c@baylibre.com>
	<DM8PR03MB6213FD30FCD465AA0262E4BB919A2@DM8PR03MB6213.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mariel,

You get to be the person I moan at today (though not the only person
doing it!).

Please crop to only the relevant information for continuing the 
discussion.  It is not necessarily easy to find where you reply if you
keep too much context.


...

> > > +static int ad8460_probe(struct spi_device *spi) {
> > > +	struct ad8460_state *state;
> > > +	struct iio_dev *indio_dev;
> > > +	struct device *dev;
> > > +	u32 tmp[2], temp;
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	state = iio_priv(indio_dev);
> > > +	mutex_init(&state->lock);
> > > +
> > > +	indio_dev->name = "ad8460";
> > > +	indio_dev->info = &ad8460_info;
> > > +
> > > +	state->spi = spi;
> > > +	dev = &spi->dev;
> > > +
> > > +	state->regmap = devm_regmap_init_spi(spi,  
> > &ad8460_regmap_config);  
> > > +	if (IS_ERR(state->regmap))
> > > +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> > > +				     "Failed to initialize regmap");
> > > +
> > > +	state->sync_clk = devm_clk_get_enabled(dev, NULL);
> > > +	if (IS_ERR(state->sync_clk))
> > > +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
> > > +				     "Failed to get sync clk\n");
> > > +
> > > +	state->tmp_adc_channel = devm_iio_channel_get(dev, "ad8460-  
> > tmp");
> > 
> > Should we check for specific errors here? For example what if we get -
> > EPROBE_DEFER? Also, it doesn't like we could ever get NULL, so IS_ERR()
> > should be sufficient.
> >   
> 
> It says in the docs that, the intended channel might return -EPROBE_DEFER
> If the driver associated with that channel depends on resources that are not
> Yet available. For this specific case, should I create a loop that waits for
> That channel to be available before proceeding with the probe function?

Normally I'd say fail the probe with EPROBE_DEFER but in this case
it's awkward because this is far from a 'required' feature and whilst
DT providing the channel would indicate that the board supports using
it, that doesn't mean a given system has the driver for the ADC.

I don't want to suggest we make this a CONFIG_XXX option but I can't
immediately see an alternative that lets people intentionally not build
the driver support for the ADC.

> 
> How would this be implemented?
> 
> Originally, this channel was intended to be optional. If any error results from
> Obtaining it, it will not be included in the channels.
> 
Given IIO drivers will probe in an unknown order this will fail perhaps half the
time.  Normally deferral deals with that, because the consumer isn't useful
without the channel.  Here it is... 

I'm open to other suggestions on this but right now it looks like only way
to definitely handle it is a config option.

Maybe for now we don't provide one and see if anyone cares?  That is
effectively make if required to provide an ADC driver if the DT describes
the channel we are getting. If that driver isn't loaded yet -EPROBE_DEFER and
wait for it to show up.

Jonathan


