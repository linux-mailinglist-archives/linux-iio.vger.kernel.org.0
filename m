Return-Path: <linux-iio+bounces-17167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A09A6BA49
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696533B5FE2
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59979223321;
	Fri, 21 Mar 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLB5k+if"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0433F6;
	Fri, 21 Mar 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558806; cv=none; b=sRR/XvJyJLwW7omEGVNR46iHWC0HLrZiQUMb2w0WYhv6taNQ282v7owQSIbwhUe0VUF3emc2xSbbGRhgPE6SKahKAYFLPpUhvbn512My3GocNQJKclg3rtuxQwfUpI9zXNan2GWll5a73FEgJC0XdZBtlCgn+L2ZghCt4w1WSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558806; c=relaxed/simple;
	bh=gh20v8vTVcSrM01YWowDc/Z0YrC4r9Dnb9qXCIOThtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su1LiG2SDJbwzKj0T2sE6q1XCIYgBkhv93a6QAg/wFz+JvPG9DOk1rDp2aEYMgOK3FkMj4nROlTFbxSAWgoJGKk5OSpe/2hQDEoB2PMOLAjPN8KwDyyJLB7yYOiWRIvjS0i+ATlUstG/hVYTJUXjT8cFgaluzBngnv0F7hn3HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLB5k+if; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742558805; x=1774094805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gh20v8vTVcSrM01YWowDc/Z0YrC4r9Dnb9qXCIOThtU=;
  b=KLB5k+if8vqbtcg3OflAEsdXDToaUlTpofMNoj6bZqTQLbDqv0/16idR
   E940CH9J9qfI1T8h/qADv3XJUqtOUJFO91diaqihCe7UYVXzR63sLRMoQ
   zCjaC2iVgHx8Rdcwn/aZyPtOqW79DyXLn9L7hxzZMLQVkmGvBVSVHRg2z
   AmVEYeQaBXVcOtRmjY+7EnmamQ5Fdj77PCsSSfXC3VKjnZvZFFZRAYn9o
   M4hqdUbFPBM3sA4uDgUlOL0BgbKVtDr8FErPrKnJfRV+xf9nvT5ONXVwZ
   C0Rp8vOutf6Sqsre1csSONfJJ5dKBvpRT1d/32fTbIz+am/UYO5yge2SS
   Q==;
X-CSE-ConnectionGUID: b3UiWn3JRC+M0LUCiwF4JQ==
X-CSE-MsgGUID: KYhobKRXRPWS886dxMxrcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54456257"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54456257"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:06:44 -0700
X-CSE-ConnectionGUID: xIftZmdnS0ejL06UuL1LXg==
X-CSE-MsgGUID: U/wAjmTLQGu/Zvqnuqjq2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123366528"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:06:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvb91-00000004VS3-3k8I;
	Fri, 21 Mar 2025 14:06:35 +0200
Date: Fri, 21 Mar 2025 14:06:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
> On 20/03/2025 15:16, Andy Shevchenko wrote:
> > On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:


...

> > > +struct bd79124_raw {
> > > +	u8 val_bit0_3; /* Is set in high bits of the byte */
> > > +	u8 val_bit4_11;
> > > +};
> > 
> > Again, this is confusing.
> > 
> > Just put a bit order map in the comment as I suggested previously.
> > When I see variable name containing bit range like above I think
> > about the same bit order, i.e. with your comment it makes like this
> > 
> > bit number	7 6 5 4 3 2 1 0
> > data bit	0 1 2 3 x x x x
> 
> Gah. I think I now understand what you're after. And, I agree, I haven't
> been as clear as I could've been.
> 
> The pit numbers in the struct members:
> 	u8 val_bit0_3; and u8 val_bit4_11;
> 
> are _not_ intended to represent the bit ordering - only the bit positions.
> Like, bits from bit 0 to bit 3 are stored in high bits of this u8 - where
> the "0 to 3" was just picked as order based on it being from the smaller to
> greater (which I believe is grammatically typical) - not based on how the
> bits are ordered in the register. If the order of the bits was indeed
> reverted, then we should see much more complex conversions than what is
> presented in these macros.
> 
> I will update the variable names to:
> 
> val_bit3_0; and val_bit11_4; I think it should sort out the confusion. I
> won't go to bit level representation of the full registers:
> 
> > bit number	7 6 5 4 3 2 1 0
> > data bit	3 2 1 0 x x x x
> 
> and
> 
> > bit number	7 6 5 4 3 2 1 0
> > data bit	b a 9 8 7 6 5 4
> 
> because it suggests there is something very strange in the registers (which
> is not the case) - and it is hard to spot if some bits have indeed changed
> the place.

You can get rid of all of these by simply using __le16. I do not understand why
it's not used so far. I thought that bits are mirrored, that may explain the
case, but now I do not see any problem to use __le16 directly.

-- 
With Best Regards,
Andy Shevchenko



