Return-Path: <linux-iio+bounces-21627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9612B03210
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1604E3BB7D8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0E27FB2A;
	Sun, 13 Jul 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDH6iUJa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083797D07D;
	Sun, 13 Jul 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423618; cv=none; b=HUrrBYKQ+gXT7mNDJm+i0Eb9C25YePaWo6K8uQ33YY9AnesgG03vYqiibi73NK47WlghT59tsmlJZBePDR2RuF0TIMq2NZYs6pdx1lYirYIIFe38M9mJ6OpEa/J4Rc9K8YolQnnxnEMRZtCKnRk1G3fwEOr7qmrxCjNG9REyZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423618; c=relaxed/simple;
	bh=LpZKAXf6O7X0TWxog3n0y857Mu44czoqsub047lX3CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZ8ERwWe/6MCGiHzxPRJjYuBDEo6cC29DbYDmtuuIJipbWwQL79qWkgPJO7i402jBsKvOZgozoq9mr87g6qeuCKtEljp1H5Yeys0weZtIhCra0B4lYKtpN3C0XFhCaLItJmPqE+I5a0D1RU1Koyf6hrX9Z04gZJZVPTQyaB3Ey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDH6iUJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7BC4CEE3;
	Sun, 13 Jul 2025 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752423617;
	bh=LpZKAXf6O7X0TWxog3n0y857Mu44czoqsub047lX3CI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LDH6iUJajU74v1USk6bK6beSAsFS1v9DaYI3N+8qMV4KMLzVU8BsDUuFqVdvBTgNh
	 O1OvZmE1+36legPX9n6PzC7BaORxcMBf9tvlZkc1VD0ArPwYV+MYF1K4ixVy/sozq/
	 3UhfDQDBlg7JhWAi2PvAvGtiLl/1lum0Ih0aPyY5wfcSpPWY9/6rZnTwgk1uQ9ULb9
	 yv1owXUeG+nywZO6iscH/kdMg2nUcLXYXnnD3cLmrqx3nsURnl4V5Bch1CPkteVcVW
	 mIgh+KNzVy2gQsho7oFAC1ksWgoTHmoRTQoiGwfo+n3vzW/03XVjwiFiQ7yolcl3gU
	 h1a7NGrNiuvzw==
Date: Sun, 13 Jul 2025 17:20:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250713171925.6a563020@jic23-huawei>
In-Reply-To: <pnd7c0ks81a.fsf@axis.com>
References: <cover.1751636734.git.waqar.hameed@axis.com>
	<29f84da1431f4a3f17fdeef27297a4ab14455404.1751636734.git.waqar.hameed@axis.com>
	<20250706121117.75665bb0@jic23-huawei>
	<pnd7c0ks81a.fsf@axis.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 10:46:09 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, Jul 06, 2025 at 12:11 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> [...]
> 
> > One suggestion inline on providing more information on the 'why' behind
> > the regulator handling.
> >
> > I want to leave this on list anyway to give more time for other reviews,
> > but if nothing else comes up and you are happy with my description I can
> > tweak this whilst applying.  
> 
> Sure, we can let it breathe for a bit. I'm fine with you editing it
> while applying it (maybe also the minor format comment in the
> dt-bindings patch then?). Either way, if there is anything else you want
> me to do do, just tell! Thanks again Jonathan!
> 
I decided to be lazy and only tidied up the comment. The slightly odd formatting
in the dt binding can stay.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to look at them.

J
> >
> > Jonathan
> >  
> >> ---
> >>  drivers/iio/proximity/Kconfig   |   9 +
> >>  drivers/iio/proximity/Makefile  |   1 +
> >>  drivers/iio/proximity/d3323aa.c | 814 ++++++++++++++++++++++++++++++++
> >>  3 files changed, 824 insertions(+)
> >>  create mode 100644 drivers/iio/proximity/d3323aa.c
> >> 
> >> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> >> index a562a78b7d0d..6070974c2c85 100644
> >> --- a/drivers/iio/proximity/Kconfig
> >> +++ b/drivers/iio/proximity/Kconfig
> >> @@ -32,6 +32,15 @@ config CROS_EC_MKBP_PROXIMITY
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called cros_ec_mkbp_proximity.
> >>  
> >> +config D3323AA
> >> +	tristate "Nicera (Nippon Ceramic Co.) D3-323-AA PIR sensor"
> >> +	depends on GPIOLIB
> >> +	help
> >> +	  Say Y here to build a driver for the Nicera D3-323-AA PIR sensor.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module will be
> >> +	  called d3323aa.
> >> +
> >>  config HX9023S
> >>  	tristate "TYHX HX9023S SAR sensor"
> >>  	select IIO_BUFFER
> >> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> >> index c5e76995764a..152034d38c49 100644
> >> --- a/drivers/iio/proximity/Makefile
> >> +++ b/drivers/iio/proximity/Makefile
> >> @@ -6,6 +6,7 @@
> >>  # When adding new entries keep the list in alphabetical order
> >>  obj-$(CONFIG_AS3935)		+= as3935.o
> >>  obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
> >> +obj-$(CONFIG_D3323AA)		+= d3323aa.o
> >>  obj-$(CONFIG_HX9023S)		+= hx9023s.o
> >>  obj-$(CONFIG_IRSD200)		+= irsd200.o
> >>  obj-$(CONFIG_ISL29501)		+= isl29501.o
> >> diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
> >> new file mode 100644
> >> index 000000000000..b1bc3204c0c0
> >> --- /dev/null
> >> +++ b/drivers/iio/proximity/d3323aa.c
> >> @@ -0,0 +1,814 @@  
> >
> >  
> >> +static void d3323aa_disable_regulator(void *indata)
> >> +{
> >> +	struct d3323aa_data *data = indata;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * During probe() the regulator may be disabled. It is enabled during
> >> +	 * device setup (in d3323aa_reset(), where it is also briefly disabled).
> >> +	 * The check is therefore needed in order to have balanced
> >> +	 * regulator_enable/disable() calls.
> >> +	 */
> >> +	if (!regulator_is_enabled(data->regulator_vdd))
> >> +		return;
> >> +
> >> +	ret = regulator_disable(data->regulator_vdd);
> >> +	if (ret)
> >> +		dev_err(data->dev, "Could not disable regulator (%d)\n", ret);
> >> +}
> >> +
> >> +static int d3323aa_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct d3323aa_data *data;
> >> +	struct iio_dev *indio_dev;
> >> +	int ret;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return dev_err_probe(dev, -ENOMEM,
> >> +				     "Could not allocate iio device\n");
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +	data->dev = dev;
> >> +
> >> +	init_completion(&data->reset_completion);
> >> +
> >> +	ret = devm_mutex_init(dev, &data->statevar_lock);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Could not initialize mutex\n");
> >> +
> >> +	data->regulator_vdd = devm_regulator_get_exclusive(dev, "vdd");
> >> +	if (IS_ERR(data->regulator_vdd))
> >> +		return dev_err_probe(dev, PTR_ERR(data->regulator_vdd),
> >> +				     "Could not get regulator\n");
> >> +
> >> +	/*
> >> +	 * The regulator will be enabled during the device setup below (in
> >> +	 * d3323aa_reset()). Note that d3323aa_disable_regulator() also checks
> >> +	 * for the regulator state.  
> >
> > This comment doesn't explain why you do this here as opposed to after
> > reset.  Key is that there are complex paths in which the regulator is disabled
> > that are unrelated to probe()/remove()  Talk about those rather than why
> > this 'works'.  It's the why that matters in a comment more than the how.
> >
> > If nothing else comes up in review, I can chagne this to something like
> >
> > 	* The regulator will be enabled for the first time during the
> > 	* device setup below (in d3323aa_reset()). However parameter changes
> > 	* from userspace can require a temporary disable of the regulator.
> > 	* To avoid complex handling of state, use a callback that will disable
> > 	* the regulator if it happens to be enabled at time of devm unwind.
> > 	*/  
> 
> Ah, I see that I misunderstood you the first time! The comment looks
> fine to me.
> 
> >  
> >> +	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
> >> +			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
> >> +			    D3323AA_THRESH_DEFAULT_VAL);
> >> +	if (ret)
> >> +		return ret;  


