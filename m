Return-Path: <linux-iio+bounces-15439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FDA32415
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E630188B206
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771D209F3C;
	Wed, 12 Feb 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/X1Adqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D0206F2C;
	Wed, 12 Feb 2025 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357890; cv=none; b=Ba0X+J7rzCr5ZVTt7Iy8sPyecPyLBjpvlWm2/4MvUA9cr08+cTL1PnmG0zvhLHB0gILyVYjtzr0IJvj1XUH5dnKf7wnFCJ3L9XSleE96GAi8r5he7c60H2nrBlvEHFXsOquohiXvWkbsTfts8GeWBSBzAzD/hPT2EYDpbfTh/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357890; c=relaxed/simple;
	bh=+z2XvD2jfED7TixE7ouV+IiMt8A2lUXzW0REOLFZMxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdoCBFt8zEnn7HzR9MLvin2iSZg7bBPJvpuApqNXNriioBK/I9SHFyLyQTEnOQL9Q9A7uW6InxXF8r7/gyS6PXAqEug7XzwZ/3f99KDQWOgtjGTnJM7/Mfevzi2zr61fnMO/ux0FVGEWQGB4+1ULyx6b9snHnahq35RV4G1gp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/X1Adqi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739357889; x=1770893889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+z2XvD2jfED7TixE7ouV+IiMt8A2lUXzW0REOLFZMxM=;
  b=O/X1AdqiymFiEC5aPbAg4zrUdmlPu+XJ7+rAF46m0FzY6LYL32t1WoWi
   OxceSI38PDSnSJ9zl22IMCnDujfntjyHRzni3wA2kJhZHW7IRiWyFxOew
   EiMexYLQazG1Yrl1vvBi4BPYgkYz9DhhasdFTyJ1rqH2vlnvYE4v7xu3D
   nrHtffhVljCIx7YEZhxqh0WbxKw2fNSKs3rg3vfqk7obNYmqu2HKsjMYy
   aelbDqyzr5iFPzJxur+MWblSUtaYTUJdXaJz/5G4OHJ/89TatIO1dG8LT
   yFSNM7TWjIq6ZDwxg+cjOVKMCkujWngHKvcjy1byBAOLbHbrqsSxGyhyj
   A==;
X-CSE-ConnectionGUID: ptNvhZjQQxK5gTOusFjw6Q==
X-CSE-MsgGUID: iKbD3aUXQS6NpoRJZpw1vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39932272"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39932272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:58:09 -0800
X-CSE-ConnectionGUID: ZCIVHWtYRQ+/zz/ylBdfnw==
X-CSE-MsgGUID: vdPeYeeFT7KVQt2EtKQp9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149977759"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:58:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiARN-0000000AoM3-0RBJ;
	Wed, 12 Feb 2025 12:58:01 +0200
Date: Wed, 12 Feb 2025 12:58:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6x-uBWEsoAIV2n-@smile.fi.intel.com>
References: <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
 <Z6uhHssgIvI2DJ4c@smile.fi.intel.com>
 <57swm23ik5kyzcjvnhkizctnemtlqf3duhrd5u3n6yelxkerxt@6akfoqmyqsup>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57swm23ik5kyzcjvnhkizctnemtlqf3duhrd5u3n6yelxkerxt@6akfoqmyqsup>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 09:52:37AM +0100, Uwe Kleine-König wrote:
> On Tue, Feb 11, 2025 at 09:12:30PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-König wrote:
> > > I have no problem here. If the header becomes stale we will most
> > > probably notice that eventually and remove it.
> > 
> > Lol. Look at the header hell we have now. 98% code in the drivers/ just show
> > that the developers either don't care or do not understand C (in terms of
> > what headers are for and why it's important to follow IWYU principle).
> 
> Yeah, there is a problem. The source is that we have a metric ton of
> recursive includes (i.e. headers that include other headers that include
> still more headers). Even if you care, its sometimes hard to know which
> headers you actually need. One idea on my long-term list is to add a
> machine-parsable info to header files about the list of symbols that the
> given file is responsible for. With that in place we could create a
> linter that tells you that this source file doesn't use any symbols from
> <linux/of_irq.h> and it should #include <linux/of.h> directly instead to
> make use of symbols defined there.

There were already few attempts to untangle the dependency hell we have in LK
project, but all seems to fail. The infamous one by Ingo stale, however a few
patches (out of more than 2200!) made upstream.

So, any tooling for that will be warmly accepted!

-- 
With Best Regards,
Andy Shevchenko



