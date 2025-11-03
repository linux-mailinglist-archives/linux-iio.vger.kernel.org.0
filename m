Return-Path: <linux-iio+bounces-25831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4BEC2ACF9
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 10:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA6EB4F0E5B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189E2EF66E;
	Mon,  3 Nov 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjwGU3HM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51552EDD51;
	Mon,  3 Nov 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162769; cv=none; b=b4uiCp9t+dO5iXaKwSvfUGdaRUw42/tHYOXekejlHPtEslM0impS9Tc0gtHAp/1uyba6U7fITES5HJjWK4IRP1v5aPy/hQAi+hiUCi6oIZ7NdXj1aMTyFO6hNT6tDi+TpVgByep+UZozgbvwtr4ZtqUM9IJxRe9P3xdx1kDWL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162769; c=relaxed/simple;
	bh=94W3/Tic1Etllii9GDyz3usHILLWn+fF8+MzVD4F3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3NHMYBaC/Kc180PcZvvRpVrGh6IWRXfiPSuWrBeFcAcaLeShQGjmOrH1IALxDJCLLRqHX/JwwdiA3cmyawi1vkRnPaD0wmDGn8S9oB3pamDtFgu+pK2gEk48aMng0EOsd5ZnV+TWQmq5MWa15VbPFwNHyeQj30uEQKPV6PNF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjwGU3HM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762162768; x=1793698768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=94W3/Tic1Etllii9GDyz3usHILLWn+fF8+MzVD4F3kk=;
  b=OjwGU3HMRkGpOqDN3YJLo2fIye7uejmOfFeNio+HfDZcb0H9llzllG13
   IRcK2rNljnXIFrsGQvByXUYY+ap5HTVB1WMuZT+nPkg3IMq3f7vABQj9d
   pdT3y6tWswZz9J5ehU1BUtoXzhfh4mZPDwj2l0Svgei76XyMu5h2y3P4c
   VkAAoVZJaJD0IZttoAVZeFUy8/EHcOU9vKXXVor8dmfLMBUvrzzzkAwpY
   MPDuRR2xA3lEG93KE0gr3Q61kwsJjsmLMrIV6EYWfm7Ko9tkVtOyvmDnj
   Pvdxa9/kzTyDMllj2AkJIGkT0pWEZ2GSOjX6bI08wEe9KUuVVA1F5H0mx
   g==;
X-CSE-ConnectionGUID: LEf+dyP9TQuPLSZutaeyvA==
X-CSE-MsgGUID: Uqj41QqXTXaquk1ho3h0jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86856536"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="86856536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:39:28 -0800
X-CSE-ConnectionGUID: EgIxYilFRGyKGXyF+sgHuw==
X-CSE-MsgGUID: kRqRhsImS4KaW0ddsqR5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186695792"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:39:23 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFr1x-000000056o0-29sI;
	Mon, 03 Nov 2025 11:39:17 +0200
Date: Mon, 3 Nov 2025 11:39:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aQh4RFg2NlUXlyaz@smile.fi.intel.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
 <20251029144644.667561-3-herve.codina@bootlin.com>
 <aQMpHDwCqcrNrnT9@smile.fi.intel.com>
 <20251103094045.73a061ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103094045.73a061ea@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 09:40:45AM +0100, Herve Codina wrote:
> On Thu, 30 Oct 2025 11:00:12 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > +	ret = devm_regulator_get_enable_optional(dev, avdd_name);
> > > +	if (ret < 0) {
> > > +		if (ret != -ENODEV)
> > > +			return dev_err_probe(dev, ret,
> > > +					     "Failed to get '%s' regulator\n",
> > > +					     avdd_name);
> > > +		return 0;
> > > +	}  
> > 
> > 	if (ret == -ENODEV)
> > 		return dev_err_probe(); // takes less LoCs
> > 	if (ret < 0) // do we need ' < 0' part?
> > 		return 0;
> 
> Well, I need to abort on error returned by devm_regulator_get_enable_optional()
> but I need also to filter out the ENODEV error.
> 
> ENODEV, returned by devm_regulator_get_enable_optional(), means that the
> regulator is not present. This should not be seen as an error by the caller.
> Indeed, the regulator is not present and so, the related ADC core will not
> be used. This is not an error from the caller perspective.
> 
> The code you proposed is not correct regarding this point.

Yeah, sorry for that, but I think you got the idea...

The (working) solution should be like this:

	if (ret == -ENODEV)
		return 0;
	if (ret < 0) // do we need ' < 0' part?
		return dev_err_probe(); // takes less LoCs

> Instead of my original code, I can propose the following:
> 	if (ret < 0) {
> 		if (ret == -ENODEV)
> 			return 0;
> 
> 		return dev_err_probe(dev, ret,
> 				     "Failed to get '%s' regulator\n",
> 				     avdd_name);
> 	}
> 
> What do you think about it?

-- 
With Best Regards,
Andy Shevchenko



