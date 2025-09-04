Return-Path: <linux-iio+bounces-23709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E05B43C7A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6651895636
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8E2FF177;
	Thu,  4 Sep 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDrr0wXA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966D2FDC28;
	Thu,  4 Sep 2025 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991081; cv=none; b=eHREFQmj+VDZWYc8pT7EN1sves8OsgqifhFxr28g2LUFwFmfTbGXRIhKq54QxFOkgjJQAqg7n3NGH1mnSDoW6k/p/LDg7EM8x7+hsxU5KpTxcy9ZAjli9cTQQlBB/t56qktr/USFiiT6jGVs30rrtL5FcVvrJt+umgBOYxxHCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991081; c=relaxed/simple;
	bh=UDIZnclyMgk6mq7yGflC4fULp9pmEgo18qUYO+/ashU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewPWHcV2KVXKNS3VvDZ0OYELOk1rVME3WSAADipQbyeNULgduExHLriTBAtuGkP4+AL+oTnuNrTOU97W3KdBKmop8lZMQc3CW9kmGrrWWjHhlnEY2YbkWA03KkxhrEQLLbQ718yXTq6Kpu0WT6VdGW5xc9z7W6RVfYXX+dg+bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDrr0wXA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756991080; x=1788527080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UDIZnclyMgk6mq7yGflC4fULp9pmEgo18qUYO+/ashU=;
  b=HDrr0wXAIwTZ+VPD00GBVSjedDDDeDVZo3RaU645Qt9cUqtD/LmNZmj/
   ItYWbY6EsT8HB0IWntwAMV7p4ZW/0Sjp6yjH8c9nSxqbOMkE9Y5SBzJvc
   nUZLdtN8+Bnc6+/+1jSt/8UNHBM7GNzJyQmfqYtFqiBOEVjKuQ2P/xLZq
   BvOqLXYwtxAmnO4nqnFtwZEc/oMXj6AJ1H+qO0RIpXvUofZpUZ4O+HahJ
   4Nm6j6uBY4eLJMezDS27Q3PJQtVnKieR1NkCGc9l5s+BxFTKr253MJJii
   ZtgOQL8YSnUWYNYLzOdqm3EBKcG8uWi8DdwKaZymv5wa/KzhtplkBtgJ5
   g==;
X-CSE-ConnectionGUID: EPLiZUNmTnqieG/bzCQrwQ==
X-CSE-MsgGUID: qr1whVLSRamsFDkp7mV8RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="69943082"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="69943082"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:04:39 -0700
X-CSE-ConnectionGUID: 2S4+ZtsRR8aSbK7GKaPtfA==
X-CSE-MsgGUID: t7KJxasoQVqtWk1dFi/icw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="177152150"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:04:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uu9dd-0000000BH0N-1vDs;
	Thu, 04 Sep 2025 16:04:29 +0300
Date: Thu, 4 Sep 2025 16:04:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
Message-ID: <aLmOXTcUjw7cj9OK@smile.fi.intel.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com>
 <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
 <aLglJoqBDap_eMIj@smile.fi.intel.com>
 <10c6b0c4-d75f-494c-bb3c-883c06cf3bc2@gmail.com>
 <CAHp75Ve4vgU5kK3z3bZyGqDOPVkMbW7RUd6_EA3jjZSeruWs=Q@mail.gmail.com>
 <43141a95-2267-44de-bd7e-11eb8c80090e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43141a95-2267-44de-bd7e-11eb8c80090e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 03:35:36PM +0300, Matti Vaittinen wrote:
> On 03/09/2025 16:29, Andy Shevchenko wrote:
> > On Wed, Sep 3, 2025 at 3:14 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > On 03/09/2025 14:23, Andy Shevchenko wrote:
> > > > On Wed, Sep 03, 2025 at 09:52:02AM +0300, Matti Vaittinen wrote:
> > > > > On 02/09/2025 17:15, Andy Shevchenko wrote:
> > > > > > On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:

...

> > > > > > > +  data->vref_mv = ret / 1000;
> > > > > > 
> > > > > > (MICRO / MILLI)
> > > > > 
> > > > > I find this much more confusing than plain 1000. (I know we had this type of
> > > > > discussion before. See [1] again).
> > > > 
> > > > Rings a bell, but that's what IIO reviewers suggest to do nowadays as a
> > > > compromise between creating a new bunch of unit (V) related definitions.
> > > 
> > > I am sorry, but this just seems stupid to me. I'd say that it is very
> > > obvious for most of the readers dividing microvolts by 1000 results
> > > millivolts. And if it is not, then having this MICRO / MILLI is likely
> > > to just cause more confusion.
> > 
> > No, it tells that we have a value in microSOMETHING that is converted
> > to MILLIsomething.
> 
> No. I disagree. This tells that 'ret' from the regulator API is divided by
> some unknown value, which is a result of division of two odd defines.
> Especially odd because one would intuitively think MICRO is smaller than
> MILLI. You need to look up the definitions to understand WTF is really going
> on. I think this is plain terrible.
> 
> The fact that we store value in vref_mv should be enough of hint that idea
> is to have value in millivolts. Dividing by 1000 before assigning makes it
> 100% clear the ret is in microvolts even if you didn't know the regulator
> API to return micro volts.

"Dividing by 1000... makes 100% clear...". I disagree on this. It's not clear
and 1000 needs to be counted (it's harder to read, than reader needs to think
what mv and not mV (!) means) and so on. For bare minimum make it mV to
understand the semantics.

So, since it's one of the principal disagreements between us on this particular
issue, I leave it other reviewers and maintainers.

> > > I _really_ dislike these defines. Why is MILLI 1000? Why it isn't 0.001?
> > 
> > You know exactly a few reasons why it's not.
> > 
> > > It makes no sense that KILO and MILLI are the same. Especially not when
> > > we are dealing with physics.
> > 
> > Yes, this is the limitation of computers and particularly of _a_ kernel.
> 
> No. In my opinion, this is an example of, hopefully unintentional,
> obfuscation where blindly following some paradigm like 'avoid plain numbers
> and always use named defines' just results things getting worse. That
> combined with bad naming. If KILO is 1000, then MILLI can't be 1000. That's
> 1 per milli.

You have a point, send a patch!

> And still, the original "mv = uv / 1000" is superior in clarity. Using
> (MICRO / MILLI) there to avoid plain number is just a sign of blindly and
> religiously following some 'golden rule', even when it results worse code.

No, it's not.

> > > This is just an obfuscation compared to using plain 1000. (I kind of
> > > understand having a define for a value like 100000 - where counting the
> > > zeros gets cumbersome, although 100 * 1000 would be equally clear. But
> > > 1000 _is_ really 100% clear, whereas MICRO / MILLI is not).
> > 
> > See above why this way.
> 
> I see no real justification to degrade this - other than "because I say so".

You may (mis)interpret this, up to you.

> Sorry but that's not really a good reason to me.

OK.

...

> > > > > > > +  gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > > > > > > +                                    iio_dev->num_channels);
> > > > > > 
> > > > > > > +
> > > > > > 
> > > > > > Instead of leaving this rather unneeded blank line I would move above...
> > > > > > 
> > > > > > > +  /* We're done if all channels are reserved for ADC. */
> > > > > > 
> > > > > > ...to be here
> > > > > > 
> > > > > >      gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > > > > >                                        iio_dev->num_channels);
> > > > > 
> > > > > I suppose you mean something like:
> > > > > 
> > > > > register_gpios:
> > > > >       /* We're done if all channels are reserved for ADC. */
> > > > >       gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > > > >                                             iio_dev->num_channels);
> > > > >       if (!gpio_pins)
> > > > >               return 0;
> > > > > 
> > > > > right?
> > > > 
> > > > Yes.
> > > > 
> > > > > I don't like this because now the comment suggests we do call
> > > > > bd79112_get_gpio_pins() only to see if all channels were for ADCs. This,
> > > > > however, is not THE reason for this call, only an optimization. I think:
> > > > > having:
> > > > > 
> > > > >           /* We're done if all channels are reserved for ADC. */
> > > > 
> > > > Then you can amend the comment
> > > > 
> > > >            /* If all channels are reserved for ADC, we are done. */
> > > > 
> > > > >           if (!gpio_pins)
> > > > >                   return 0;
> > > > > 
> > > > > is clearer.
> > > > 
> > > > Which makes my approach sustainable.
> > > 
> > > I like your wording better, but placing this comment before the call to
> > > bd79112_get_gpio_pins() is still more confusing that placing it before
> > > the actual check:
> > >          if (!gpio_pins)
> > > is still misleading. Comment applies to the check, not the retrieval.
> > 
> > The variable assignment, or i.o.w. the source of the value we are
> > testing is also part of the equation.
> 
> The comment explains why the check, not why the value is obtained.

Yes, but value is not taken from out-of-nowhere. It belongs to that check.

-- 
With Best Regards,
Andy Shevchenko



