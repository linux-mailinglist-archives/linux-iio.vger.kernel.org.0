Return-Path: <linux-iio+bounces-23678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A3B41CF9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DE83B2D48
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B967F2F745E;
	Wed,  3 Sep 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itYLzom9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69333199E94;
	Wed,  3 Sep 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898610; cv=none; b=BkWhHg+TSXji4yY4cA/xGlZMrMxThuSAACxmBkytC/hdsDXWzAd1zpX2w8PcV2Kae6rjtkeoZWFlUA3gefdtEqYzLC5jSG4lMUhvTtWrp3CBWD6ApAIhqlZs/VLnr5QnV/fOywv1pNS9LleLv6vqiPliVktOqKMMtuGunsnbiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898610; c=relaxed/simple;
	bh=gN5j7yXabRvfgzfHwIgUbCwblwAIb7p4QQUmtPPax6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0RR4sV0ZLNuAH0E4CK43uyquSa1205rqhDP4RUurbjnvkN61qwe4JXw4e3weXku+m38f+H47+/UCPX7GH0FmIe9GJcRQwmyqbWSjrzDBrRDPqoFnUILVZ5QaMTpQEM6xrmpFmC+ECTjbcwlipXiLusco6AJeACP+R1BQPmi/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itYLzom9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756898609; x=1788434609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gN5j7yXabRvfgzfHwIgUbCwblwAIb7p4QQUmtPPax6U=;
  b=itYLzom9FsyqqtuEzbdVOQgRtGvFNpnHU0kfASNrRgOXj2jhY+bbH1Gj
   kS5zTHUPbHO83zHMmF0mqp91eS1TCjZ+6R1chBkelap2qj9kqwFW1PboC
   6yb3KO7BOnGkBJ1lg/TsbSrCMaMCJRR7X5d3VUR04zPOzvHHMUPhIwxoK
   E6zn4hX3xO3yqCNLqaPBNdV9BTIfl+GDCPaXxd9C6tbjKsVknK3r3qx5E
   wh4Loqa0Bay+TpqDXZB4PcyBBBqnYa5eBmj7iHgSws8aeTaYfje8V1XbU
   hV6v7jaGG/Mu9OcFf/CBvjAOjg1xUa0k/wyYW3Tv65vqoJs0EZmlYlX+k
   g==;
X-CSE-ConnectionGUID: 3CRKoSWuQIW98x+UdejS+A==
X-CSE-MsgGUID: QVyhqVksSW+wt47J6GiB1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63041689"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63041689"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:23:28 -0700
X-CSE-ConnectionGUID: KihWZ6BsS7qB6OaNVF14fA==
X-CSE-MsgGUID: 5oVCmmnNQU2E9u8NZb9WJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="175709395"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:23:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utlaA-0000000Ay3Z-3f9W;
	Wed, 03 Sep 2025 14:23:18 +0300
Date: Wed, 3 Sep 2025 14:23:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <aLglJoqBDap_eMIj@smile.fi.intel.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com>
 <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 09:52:02AM +0300, Matti Vaittinen wrote:
> On 02/09/2025 17:15, Andy Shevchenko wrote:
> > On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:

...

> > > +	unsigned int vref_mv;
> > 
> > Perhaps _mV to follow the actual unit spelling?
> > (and yes, I know that both variants are present in the kernel)
> 
> The 'mv' is a deliberate choise. I still remember our previous discussion
> about this same topic [1].

Rings a bell. And I still think the proper spelling is more important when
we talk about physics.

...

> TLDR; I can combine the conditions in one if (), thanks.

Works for me.

...

> > > +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int offset,
> > > +				int dir)
> > > +{
> > > +	unsigned int set_reg, clear_reg, bit;
> > > +	int ret;
> > > +
> > > +	bit = GET_GPIO_BIT(offset);
> > > +
> > > +	if (dir == GPIO_LINE_DIRECTION_IN) {
> > > +		set_reg = GET_GPI_EN_REG(offset);
> > > +		clear_reg = GET_GPO_EN_REG(offset);
> > > +	} else {
> > > +		set_reg = GET_GPO_EN_REG(offset);
> > > +		clear_reg = GET_GPI_EN_REG(offset);
> > > +	}
> > 
> > > +	ret = regmap_set_bits(data->map, set_reg, bit);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_clear_bits(data->map, clear_reg, bit);
> > 
> > I believe the order depends on the out-in or in-out switch.
> > Otherwise it might be potential glitches on input (hw) buffer.
> > Right now when it's not an interrupt it may be okay to don't
> > bother, but in general I see a potential issues with that.
> 
> Can you please explain what you mean. I am not sure I can follow you here.

If we set out first with enabled input, input can get a value from the output.
If the value before was different, it will be an event condition (of course
it all depends on the HW and I haven't read datasheet for this one). So when

1) turn out on
2) ...possible event condition... (if external bias, or similar)
3) turn in off

Compare to

1) turn in off
2) ...possible glitch on the wire... (if no external bias, or similar)
3) turn out on

> > > +}

...

> > > +static int bd79112_probe(struct spi_device *spi)
> > > +{
> > > +	/* ADC channels as named in the data-sheet */
> > > +	static const char * const chan_names[] = {
> > > +		"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A",
> > > +		"AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",
> > > +		"AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
> > > +		"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B",
> > > +		"AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",
> > > +		"AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",
> > 
> > Can you make all of the lines to be the same in terms of amount of entries?
> 
> Maybe :) I would like to know why? As you know, I prefer to keep lines short
> to fit multiple terminals in parallel, so this will probably make the entry
> to consume more rows. Thus, I would like to have a solid reason.

Sure, the array above is unindexed. It's prone to errors and typos.
Moreover, it's really hard to follow in case one needs to debug such
a typo and see which value needs to be fixed (imagine you typed twice
the same name).

Recommended way is to use power-of-two per line (and even add a comment
at the end), like

static const char * const chan_names[] = {
	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A",		/*  0 -  3 */
	"AGIO4A", "AGIO5A", "AGIO6A", "AGIO7A",		/*  4 -  7 */
	"AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",	/*  8 - 11 */
	...

(or hexadecimal offsets, whatever is better and more in accordance with
 the SW / data sheet).

> > > +	};

...

> > > +	data->vref_mv = ret / 1000;
> > 
> > (MICRO / MILLI)
> 
> I find this much more confusing than plain 1000. (I know we had this type of
> discussion before. See [1] again).

Rings a bell, but that's what IIO reviewers suggest to do nowadays as a
compromise between creating a new bunch of unit (V) related definitions.

> > > +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
> > > +		BD79112_MAX_NUM_CHANNELS - 1, &cs);
> > 
> > Hmm... Indentation can be amended.
> 
> Sorry but I am not sure I understand what you mean by amended? Can you
> please go an extra mile and explain :)

	ret = devm_iio_adc_device_alloc_chaninfo_se(dev,
						    &bd79112_chan_template,
						    BD79112_MAX_NUM_CHANNELS - 1,
						    &cs);

...

> > > +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > > +					  iio_dev->num_channels);
> > 
> > > +
> > 
> > Instead of leaving this rather unneeded blank line I would move above...
> > 
> > > +	/* We're done if all channels are reserved for ADC. */
> > 
> > ...to be here
> > 
> > 	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > 					  iio_dev->num_channels);
> 
> I suppose you mean something like:
> 
> register_gpios:
> 	/* We're done if all channels are reserved for ADC. */
> 	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>                                           iio_dev->num_channels);
> 	if (!gpio_pins)
> 		return 0;
> 
> right?

Yes.

> I don't like this because now the comment suggests we do call
> bd79112_get_gpio_pins() only to see if all channels were for ADCs. This,
> however, is not THE reason for this call, only an optimization. I think:
> having:
> 
>         /* We're done if all channels are reserved for ADC. */

Then you can amend the comment

         /* If all channels are reserved for ADC, we are done. */

>         if (!gpio_pins)
>                 return 0;
> 
> is clearer.

Which makes my approach sustainable.

-- 
With Best Regards,
Andy Shevchenko



