Return-Path: <linux-iio+bounces-23680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BAB41D05
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C1166EA5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78652F9C3F;
	Wed,  3 Sep 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFNna0go"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6252D97B8;
	Wed,  3 Sep 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898870; cv=none; b=Te+/CpaBeBmID/ud7hg4vvM3YR8EQcvSG7v0gd4Exo95dcXKg4gtvWpSha+mXTCAkxbWzTyJfdFhaGuztaXYVVs4Y4mr+vm++6Tc85GQa4ADxU7rkAMXMZS6JkXSNk5QVN3Z0+SoQwX8xCoBsXPS5TF5dm3V1wgX1MxETxmJTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898870; c=relaxed/simple;
	bh=rFaDnYQQI/gTWMzlB6UmNaKkKjFMLj1FGoHK1wr8lIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfqxj2/mM3D+KFWLMWTpWV6+dwySkHXASUEq682/se0WslzKcTppD9d1/AwwT2lDQ7/k6X701agAYo/CaCFQ89DJFtUJ/0GquWof07103jFBgaPojpg9ExxnDkxZNHTtGraQcUnfzIbcv1hXm9FUDA7UVcu0EW5rX2+tLFLsYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFNna0go; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756898869; x=1788434869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rFaDnYQQI/gTWMzlB6UmNaKkKjFMLj1FGoHK1wr8lIE=;
  b=GFNna0goQ6NxxCUL7tZCtlhD3plVDZZQYneqr9UKOoIdHlIA/AEb7fsG
   sCaMr11dPEXRrAKR6PUD6U89nrzBave4KoaFUoAOmbEzJZf4YIM2Edo7J
   Hgzsf+rPnzg+2IdH66mcZfCo6yO0LXJXmx/PIa5dbl0CtztIUOHcM+Sfr
   4s+vPP2nz95w58E9QVCHxydkIHQIis0dqhhz9/NrpbDFnmhQ2ksaKLrnq
   EjyUzYVLO4LXLVCnKEcgeS1aeLzCinu1EuNE0jTGuETLn4E3M7LpD4We4
   UVu71J7ySkb8vzKqqmNBSe6GOsHkYv3Pfmasfb7OJiw4iOAg2oEZUixy3
   A==;
X-CSE-ConnectionGUID: WmzqfJVTRNWDYQt66hY5Sw==
X-CSE-MsgGUID: +H6V38EsQ8mgzHQF9nWKXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58238541"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="58238541"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:27:48 -0700
X-CSE-ConnectionGUID: OHlTYT2WRzqeTOUxmDpwVQ==
X-CSE-MsgGUID: d8A/2wzATxSLMC0I44VPyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="172020665"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:27:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utleN-0000000Ay8D-2XRO;
	Wed, 03 Sep 2025 14:27:39 +0300
Date: Wed, 3 Sep 2025 14:27:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <aLgmKxPEAduajodW@smile.fi.intel.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
 <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
 <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
 <908feb42783fd182c8b0f22ae5c147de2f7a60d2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <908feb42783fd182c8b0f22ae5c147de2f7a60d2.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 12:02:56PM +0100, Nuno Sá wrote:
> On Wed, 2025-09-03 at 08:47 +0200, Linus Walleij wrote:
> > On Wed, Sep 3, 2025 at 7:23 AM Matti Vaittinen <mazziesaccount@gmail.com>
> > wrote:

...

> > > Anyways, fast-forward to this day, I don't see it handling valid_mask. I
> > > think it is a must for this device/driver, where pins can be either
> > > GPIOs or ADC inputs.
> > 
> > Why not just add a .init_valid_mask() to
> > struct gpio_regmap_config so it can just pass that
> > down to its gpio_chip?
> 
> Hmm I guess I'll get a similar comment on the series I just sent [1] :)

Right, you have the mask but you don't use gpio-regmap!

> [1]: https://lore.kernel.org/linux-hwmon/20250903-ltc4283-support-v2-0-6bce091510bf@analog.com/

-- 
With Best Regards,
Andy Shevchenko



