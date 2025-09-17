Return-Path: <linux-iio+bounces-24200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78332B7F180
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A41D189E3BB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E530305E05;
	Wed, 17 Sep 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StGD3ARx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A722A4EA;
	Wed, 17 Sep 2025 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096654; cv=none; b=gQO2K+EK9o57CVVFn73W2YIRSGONv4hnY+cD4dhyAeONYoiEn+IZnW/BABargy2znNZfixzraG6iZwaLF4m91J7HgrA7FOXp9KlDQCUyngHlhKcSq4//vwImAwtao0ABAulIZ2P9Q+EbUrSJT3FfdEqlpTOwcjOCNEMDxS+lGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096654; c=relaxed/simple;
	bh=a2NGnZXyMk2WBG9QLMhqEkm3HJ2+sNYSVMHdCrgUh0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYUBQ33ciBOSy1dkPTNT1fLTwR9g2zTbMEW8FfNVo7oGs73rBcseY0aecw472JCkPLUjFONIQ0r++YzSSFlpUwHLuPCpixUzAxPK2XluohvyAI7xPxA6yWlNRUxY2dvwaliF+G7hh45NUTGRiqGilvcaiChxLkPf9rc9ikk6M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StGD3ARx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758096653; x=1789632653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2NGnZXyMk2WBG9QLMhqEkm3HJ2+sNYSVMHdCrgUh0E=;
  b=StGD3ARxQ0t3B+MfdE2ZejedWUYhkBlgLlWFrUW2XDQGt2phSeCWYLYC
   bceogOscj2XauQ1WRbA0YpLBFduFhIKJ1wW2CEHDxGpadOcC0JG9DA13f
   BjCvEibR5YTJo9YGqwAThiztcpEg0T0y+gYJGqJVCqq5E9O4ADuucPzDy
   QomfWdpD9MRXYZAho3pUO81pWIAGnzMnKXCapgObQQFIKi03VcfTjKkyZ
   Q7+VzAWnM2eX7ctD5/+Ygz2Yl78lp2Fs5uk4+HJL/ePliZ3vsiPrId7cx
   iSdY8FWLUIydeu4bMGMpriwRykWyYpkAUKtYw1AutnsTKqXksDqE2RWjr
   g==;
X-CSE-ConnectionGUID: rSzAGjOUS7qqrSI8EzwlNQ==
X-CSE-MsgGUID: Xkey+w6XT5SjGA4TvBFxRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60452767"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60452767"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:10:50 -0700
X-CSE-ConnectionGUID: /JvmjEfbQ1SQOf+a5IYzwA==
X-CSE-MsgGUID: dTtc8jMtQhWeBa63wngxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="180320252"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:10:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uynFS-00000003kRu-0aYO;
	Wed, 17 Sep 2025 11:10:42 +0300
Date: Wed, 17 Sep 2025 11:10:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
Message-ID: <aMptAUsQaUIYpVNG@smile.fi.intel.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 01:04:41PM -0500, David Lechner wrote:
> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:

...

> > Change I was not able to do:
> > - I could not remove bitrev16 because I am using an SPI controller that
> > does not support SPI_LSB_FIRST. So I suggest keeping bitrev16 and not using
> > the spi-lsb-first devicetree property for now, since this driver currently
> > works for both types of controllers: those that support it and those that
> > do not. I left a TODO comment to address this issue as soon as the SPI
> > kernel code starts handling the bit-reverse operation for controllers that
> > do not have this support. Once I finish my work on this driver, if the SPI
> > code still does not include this handling, I can submit patches to add it.
> 
> I looked more at what it would take to implement this in the SPI core code
> and found that it would actually be quite difficult to do in a generic way
> because there are so many edge/corner/n-dim cases. We can't change tx_buf
> data in-place because it might be const data that is in some memory area
> that can't be modified. And things would get complicated if different
> transfers pointed to the same buffer memory addresses anyway. So we would
> basically have to allocate new memory for all buffers, copy all tx data to
> that new memory, reverse all of the tx bits, and update all the pointers in
> the transfer structs. Then when the message was finished, we would have to
> reverse all of the rx bits, copy all of the rx buffers back to the original
> buffers and put all the buffer pointers back the way they were. But this
> could write over some of the original tx data if tx_buf and rx_buf point to
> the same original buffer, which would break things if a peripheral driver
> expected the tx data to persist.

And what's the problem here? We do the same with bounce-buffers in case
of DMA/IOMMU (okay, without actual data modification, but it's possible
on-the-fly).

> And we can't do this during the SPI optimize
> step because that currently allows the tx_buf data values to be modified after
> optimization.

This I don't know, so perhaps it's indeed a showstopper.

> So perhaps it is best to just handle it in the peripheral driver. It will
> be much more efficent that way anyway.
> 
> However, we still do want to handle SPI_LSB_FIRST now so that people with
> hardware support can be more efficient and we don't want things to break
> if someone puts spi-lsb-first in the devicetree.

...

> > +	if (ret < 0)
> > +		ret = 1250000;
> > +	else
> > +		ext_vrefin = 1;
> > +	st->vref_mV = ret / (MICRO / MILLI);
> 
> Just a style choice here, but in other drivers with similar handling
> we wrote it like this to avoid the extra if statement:

I didn't get this. You move from clear if to not-so-clear ternary. How is
the proposed code better?

> 	if (ret < 0 && ret != -ENODEV)
> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
> 
> 	ext_vrefin = ret != -ENODEV;
> 	st->vref_mV = ext_vrefin ? ret / 1000 : 1250;
> 
> Keeping (MICRO / MILLI) instead of 1000 is fine too. There are varying opinions
> on this.

> Or we could drop ext_vrefin and have:

It goes back and force. Can we keep the code as it's in this version?

> 	if (ret < 0 && ret != -ENODEV)
> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
> 
> 	if (ret != -ENODEV) {
> 		st->vref_mV = ret / 1000;
> 
> 		/* regmap set bits goes here. */
> 		... 
> 	} else {
> 		st->vref_mV = 1250;
> 	}

...

> > +			return dev_err_probe(dev, ret, "Failed to set External REFIN in Configuration Register\n");
> These lines are getting very long. We try to wrap to 80 characters
> as much as we can in the IIO subsystem.

Side note: checkpatch.pl almost never complained (okay, something like 15y+
ago) on long string literals at the end of statements. For the code lines
I fully support the wrapping.

-- 
With Best Regards,
Andy Shevchenko



