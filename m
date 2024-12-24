Return-Path: <linux-iio+bounces-13785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A199FBF93
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040831885739
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C811B5ECB;
	Tue, 24 Dec 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4e9tpYr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5313208;
	Tue, 24 Dec 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735053734; cv=none; b=LRfWi6g0OfAvlpAcxJMBk8zrvEm0rFK1pDM5NQuwRYE+eH2ALEk1zishNvcUFD9WNcns2R6lJJyYhGMVIMLggCUYHNp6S7PZxk75halS1aAyy3WHsS68Gv9nR3KMqhDtId7e/1rzYgMx+R+wI7hIvSzLRHjt4/uAAhYY9r9Lq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735053734; c=relaxed/simple;
	bh=kInAP6eB2cmf2h6IrO3Qoaz2KGFuIg5MrarcQk+wtVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDEfNuEEAUzjygh/vVz2cETTM0oAB/55NyXWyKaPsQnXxKRDj2iiSpXR3psr3ffsonQ00NChMAgVPlQU2OGENtOz+N6eY45+57VLu/+/uISfU4p3nzrtACgd+6qA7WAoxYVhjQdnP7ZzldkjZ3RHeOX2F+ig4Gvwszgb3Qucg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4e9tpYr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735053733; x=1766589733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kInAP6eB2cmf2h6IrO3Qoaz2KGFuIg5MrarcQk+wtVY=;
  b=P4e9tpYrBhIOf3Efjcnnt93bA38mZuwTtWIWmxzw0RvUdY/8I4YwLSvs
   zbLEI2B5SVqBWeuAJhV7k68kWP6MjRlP4GalFaa1+00XYTCDePsSjKe9i
   RiAlLSOzNsgzwoPn2lCm/Htuwbk16T+9Ya73LOrQqQbfy6iZJI7ZfPCeB
   58ZOuWADkH58nT44OW1YwOKdMF0U3fzCa/MomfXMN+N7DpwyW5DswH3RW
   zn54xtIw6NOfVJjA3UP6KoR1ZYR5zg/ByHmQANWPfkDDGM38dWdWahxO+
   VeuKCLJJgRCT1kX6DSXfLOo1891cKomaXUaTNVVmEas0NOnSlI5KMOtuG
   Q==;
X-CSE-ConnectionGUID: foX/WwUPT9yJ3f2W6Qw2rA==
X-CSE-MsgGUID: cFg1onbkTtGAgReoRBFoaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39204548"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39204548"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 07:22:12 -0800
X-CSE-ConnectionGUID: Bw8Bmh50SjSH5rTXICFWYw==
X-CSE-MsgGUID: hjCSXx8jRy+ja4rl/7jugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122784396"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 07:22:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tQ6jV-0000000BkhG-0fSN;
	Tue, 24 Dec 2024 17:22:05 +0200
Date: Tue, 24 Dec 2024 17:22:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Message-ID: <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
 <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:
> Add Support for OPT3004 Digital ambient light sensor (ALS) with
> increased angular IR rejection

Missing period here.

> The OPT3004 sensor shares the same functionality and scale range as
> the OPT3001. This Adds the compatible string for OPT3004, enabling
> the driver to support it without any functional changes.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt3004

> 

This blank line is not needed.

> Tested-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

This tag is superfluous, it's assumed that author testing their code.

> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

...

>  	help
>  	  If you say Y or M here, you get support for Texas Instruments
> -	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.
> +	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor,
> +	  OPT3004 Digital ambient light sensor.

Can you rather convert this to a list (one item per line)?

	  - OPT3001 Ambient Light Sensor
	  - OPT3002 Light-to-Digital Sensor
	  - OPT3004 Digital ambient light sensor

...

>  static const struct of_device_id opt3001_of_match[] = {
>  	{ .compatible = "ti,opt3001", .data = &opt3001_chip_information },
>  	{ .compatible = "ti,opt3002", .data = &opt3002_chip_information },
> +	{ .compatible = "ti,opt3004", .data = &opt3001_chip_information },
>  	{ }
>  };

I'm always puzzled why do we need a new compatible for the existing driver
data? Is this hardware has an additional feature that driver does not (yet)
implement?

-- 
With Best Regards,
Andy Shevchenko



