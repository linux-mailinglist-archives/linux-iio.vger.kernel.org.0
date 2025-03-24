Return-Path: <linux-iio+bounces-17235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 097FEA6D820
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9518B188FB51
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BCA25D909;
	Mon, 24 Mar 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa7nEvF6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A6136E37;
	Mon, 24 Mar 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811319; cv=none; b=OwOUcjYknJges6/6tM8uF2rnNH0RNv/uu466kq68ba3EPrc3g2UPwzFNfnLCbZ+a7+2/5d/jMlOcrzJrqCePeoBYSy+vn1xowTj3XWwqXdlOBxQ0AQD78R/sXitMpe5njWXPQ4EqvDM5a4HK1RghgRiofH0FwICV/kcm+GfUsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811319; c=relaxed/simple;
	bh=ckL2H71VGJcEqW4jJr2q5w5tI/8gthiDoGYY1li3Srk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSnYoYaiYsz7T4ICiD8SKJ5/kEwe8esPvkldnFnygF6ryoIqa+YqCwFOk1BQY0RkV5NT8GJajYpWz5DlCsBRUYJdxUxNeyO6PW59f1Fgc2WYznf84cIAAKazvE2Zi7ICTetmXEEi7a/50z8vKtTLYjOiivfeluJ7vTstRdrN8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa7nEvF6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742811318; x=1774347318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckL2H71VGJcEqW4jJr2q5w5tI/8gthiDoGYY1li3Srk=;
  b=Sa7nEvF6NHOPIlg4gvU18dBDfyyXW/mb5N8yZxBsaRs36AuSTj+EVqlb
   rii8HkrHII+E5kddxAZ6OpfKFrIDtKRP80aSkHZMeMbitGui8aFVM6LtX
   PtpWb2PDgOBAsTXAcIgn+pvwVchMgzxTbEmzBjoFf1RPRz+MuYG9EtNg7
   K747KxSgDmMcGygGllNQT33MjZqylGDNsw6YGeZ+HOzVjUPzJO2UlfOr9
   KOnRSV3hilECUa4MJg+RSCCvbf4kMVkclrkbCOs3By+eIGulD9jBfdO+5
   gs9feyDQ6rTIFQYvSQxYQh9batT/qiOlpjPRAFL3umvFP8y6JCE4Jmn9U
   w==;
X-CSE-ConnectionGUID: sa2Q5AJJR2KIyWLFy+kXDg==
X-CSE-MsgGUID: xjLQ0toCRiKqje0F/3GsRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="61532046"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="61532046"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:15:17 -0700
X-CSE-ConnectionGUID: 9d3orBLpQuS3/6S3NDh1tw==
X-CSE-MsgGUID: GlQDv/8rQ42UHk+SyTtocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="155021334"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:15:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twepo-00000005JFU-24ey;
	Mon, 24 Mar 2025 12:15:08 +0200
Date: Mon, 24 Mar 2025 12:15:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: adi-axi-adc: add set decimation rate
Message-ID: <Z-EwrBRVX4-81X9-@smile.fi.intel.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-3-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324090813.2775011-3-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 11:07:57AM +0200, Pop Ioan Daniel wrote:
> Add support for setting decimation rate.
> 
> Add separate compatible string for the custom AD7405 IP and implement
> the necessary changes.

...

> +static int axi_adc_set_dec_rate(struct iio_backend *back,
> +				unsigned int rate)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_update_bits(st->regmap, (ADI_AXI_ADC_REG_CHAN_USR_CTRL_2),

What' the purpose of the parentheses, please?

> +					      ADI_AXI_ADC_DEC_RATE_MASK,
> +					      FIELD_PREP(ADI_AXI_ADC_DEC_RATE_MASK, rate));
> +}

...

>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
>  	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
>  	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
> +	{ .compatible = "adi,axi-ad7405", .data = &adi_axi_ad7405},

You really need to be as much as possible consistent with the style in the
	current code.

>  	{ /* end of list */ }
>  };

-- 
With Best Regards,
Andy Shevchenko



