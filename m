Return-Path: <linux-iio+bounces-26111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5DC44638
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA923ADE9B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245CB221DB9;
	Sun,  9 Nov 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eobL3wJ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC22DF59;
	Sun,  9 Nov 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716762; cv=none; b=qrwuJOx4OIHbD/ASoHgeYPGRPNQBTYrY9EVPwL8935Q9vaPBpclXEw8X4y9op7tdY+DgCmJfNOSSzSDXYM8SWf3zLPVM5htRMLJ2wgCFv/QyNYng2j2xcENJL/38kFs+UTthyq90DRLEEP06GPwQ1RxkcNMBN8gG3Wvx9/nni0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716762; c=relaxed/simple;
	bh=sJzgtPFvQjRpLpM0+Gqo9kuddUb8FrK943SF6ziRE80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtJflYFo4E+mNxcDg0t8fOv+UbikkxbQZoJlVFLDoXD+yyeY8onOpJDRHqUc3vBz7QQ+HPGlkJhdDIy6FslTQQ9j3kdAWavQAxKGazVBMrzCrS+de+DRLOGZFLZp/u2OftUb5/D9HfkTeZXWZO+nDc69DvF5saoFY5GeW7m9ZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eobL3wJ6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762716762; x=1794252762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sJzgtPFvQjRpLpM0+Gqo9kuddUb8FrK943SF6ziRE80=;
  b=eobL3wJ6Goq4Iv/ifeup7eBAUjUGpGogBfmWXB4rEdiLJFSjg/bHY0nA
   dqA1Sn5YVwRqHcKk/QDaWFdMeW+th/04ZQG8leM0gN7ntGaEsdx1pR1zD
   PymNTBs3YiQLIymBneAyHRQ/gPNbl0Zs2oELwqibl11CvS39lCb0BubXU
   tnJI+52+xd9V0hFx0XCaoQMBeixlr9+I3YTzde5VbQqqHcz2Vzy0Pkf/q
   UH4rtJ16IYozUkL4RZsYJHCqDuCYaQTo5qgO/bxt2QCmx8r1E087YDW2p
   MDW+IrymExbyJgDn81scOowrTI7t+ESLCrnxhnqv5JXnE5vFisFz4FxW7
   Q==;
X-CSE-ConnectionGUID: ebk9vL/HSqW1VUTV46rMPQ==
X-CSE-MsgGUID: kg1dSI/QRcW4aCJiXVXOpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75074618"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75074618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:32:41 -0800
X-CSE-ConnectionGUID: rW+hxrOIRy2epnbSL9gzxw==
X-CSE-MsgGUID: g3WUbtTwSmSbU6wSjUcXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="187804207"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:32:38 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIB9P-000000076dC-2Eh9;
	Sun, 09 Nov 2025 21:32:35 +0200
Date: Sun, 9 Nov 2025 21:32:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 10/12] iio: dac: ad5446: Refactor header inclusion
Message-ID: <aRDsU-Zy49vm7N0R@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
 <aQpE0_-YVeHmfL2v@smile.fi.intel.com>
 <20251109163030.66ad74fa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109163030.66ad74fa@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 04:30:30PM +0000, Jonathan Cameron wrote:
> On Tue, 4 Nov 2025 20:24:19 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Nov 04, 2025 at 03:35:15PM +0000, Nuno Sá via B4 Relay wrote:

...

> > > +#include <linux/export.h>
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/kstrtox.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/sysfs.h>  
> > 
> > Most likely the types.h is missing and maybe more...
> 
> Looks like types.h belongs only in the header.

Hmm... IIRC my suggestion was based on seeing one of uXX/sXX in the code,
but now I lost the context and maybe I memorised that wrongly.

> FWIW I ran iwyu against this with my usual iio.imp file
> (shared previously on list)
> 
> drivers/iio/dac/ad5446.h should add these lines:
> #include <linux/compiler.h>  // for __aligned
> #include <linux/minmax.h>    // for __cmp_op_max
> #include <linux/stddef.h>    // for NULL
> 
> drivers/iio/dac/ad5446.h should remove these lines:
> 
> The full include-list for drivers/iio/dac/ad5446.h:
> #include <linux/bits.h>      // for BIT
> #include <linux/compiler.h>  // for __aligned
> #include <linux/iio/iio.h>   // for IIO_DMA_MINALIGN, iio_chan_spec
> #include <linux/minmax.h>    // for __cmp_op_max
> #include <linux/mutex.h>     // for mutex
> #include <linux/stddef.h>    // for NULL
> #include <linux/types.h>     // for __be16, u16, u8
> struct device;  // lines 10-10
> ---
> 
> So maybe those 3 extra in the header  but seem not much needed in the c file.
> 
> Hence applied with the compiler.h one added to the header.
> Whereever that minmax is coming from is burried deep in macro
> so probably isn't appropriate anyway

If we use min()/max() or something from there it relies on the __cmp_op_max(),
so probably it's needed.

> and including stddef for NULL seems over the top.

-- 
With Best Regards,
Andy Shevchenko



