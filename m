Return-Path: <linux-iio+bounces-17172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB4A6BC30
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC03A3B89D0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B278F32;
	Fri, 21 Mar 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckgdUaLg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6938FB9;
	Fri, 21 Mar 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565396; cv=none; b=AW+ROWMZ35Jjfy5v+fMf0S1ygP7jhv93wcn/QfrEInAmXKiOQMqzUwyOZfW71GOuGGj4zyP70Ylm+bMs3Qxp5X+c9dgRF9oHVCi2G1YVxhFGcP2YLgDRhxMObpSIyZkogdQEQz+BMgodOYfhDYfL3BBYN4Kh4eSGUKeuT0FYrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565396; c=relaxed/simple;
	bh=/6hOolry5YjNjLNy/ShHrZBxdxC0Ma01QDEqsiQ085w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWLPZSpFe7sNL6Y4KTdOxmsbE6FAiZF9gIy6YKDcY+xUVFvL5fxSTb9TcRVHHdotwGVIboG0Jd9yi/DihpW1RWXnWVSM4/GyaDJV7Ir+5WyLRbyqsAccurqS96WTkZxKJktkTOzjnMJWVu+v5QWeRXXFwiraSeU3H9j8BCh/rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckgdUaLg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742565395; x=1774101395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/6hOolry5YjNjLNy/ShHrZBxdxC0Ma01QDEqsiQ085w=;
  b=ckgdUaLgawgkJ0Owxwa1DQQ7oM6x3k/613/3+hDU0/TtGtVpQW0fkxfF
   Tlf3fQDuxtXkQMi4hHiPWXCWqTTvqScLK3dC9m1CHRQd53xvXipOA61wo
   hg+Q2r6Vt5lvq309DtmMoyBNghb63hxEmnkYuZHmE9EpOoXaPfE3dTWq/
   UMsqfXc1TxwzSRRG6RZwTht07RTCN4beXVsFKnvq1iTBvqi3KVR2HdAlY
   SaFf7xJKVnF+TELbPjqrFFElGLku9XnZUtOnBn4iSkGCbU/QcT+gNJBH1
   r7RyqFd7C+Rk/QbRm+1LWeY8TLmGRBHiZomJLL2UWYAeyXbMpJGj0srEK
   Q==;
X-CSE-ConnectionGUID: 3XJD84D2ReCXDc2GTn6AMg==
X-CSE-MsgGUID: oSsSBjdvSqqU+Z1uh7leow==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54825447"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54825447"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:56:35 -0700
X-CSE-ConnectionGUID: ka4S3z+hT9WJv3VoUMY3Yw==
X-CSE-MsgGUID: nRylWAXSRxK2srXku9UY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123386586"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:56:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvcrL-00000004Wyz-0nhD;
	Fri, 21 Mar 2025 15:56:27 +0200
Date: Fri, 21 Mar 2025 15:56:26 +0200
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
Message-ID: <Z91wCjTb14wCbKmj@smile.fi.intel.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
 <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
 <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
 <Z91mnHP9V0yRZ2js@smile.fi.intel.com>
 <ed5bc103-1ce2-46ec-9649-03b11ae591a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5bc103-1ce2-46ec-9649-03b11ae591a7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 03:41:18PM +0200, Matti Vaittinen wrote:
> On 21/03/2025 15:16, Andy Shevchenko wrote:
> > On Fri, Mar 21, 2025 at 02:17:16PM +0200, Matti Vaittinen wrote:
> > > On 21/03/2025 14:06, Andy Shevchenko wrote:
> > > > On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
> > > > > On 20/03/2025 15:16, Andy Shevchenko wrote:
> > > > > > On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
> > > > 
> > > > You can get rid of all of these by simply using __le16. I do not understand why
> > > > it's not used so far. I thought that bits are mirrored, that may explain the
> > > > case, but now I do not see any problem to use __le16 directly.
> > > 
> > > This discussion is going in circles now. That was discussed in the RFC
> > > review with Jonathan, which I did also tell to you during the v7 review:
> > 
> > Yes, because I think we all were confused by the bits representations,
> > but now I see it clearly and I do not understand why should we go the way
> > you suggested as it makes things a bit tangled in my opinion.
> > 
> > Jonathan, do you still think the two separate bytes are better than __le16?
> > If so, what are the pros of this solution?
> 
> I don't think Jonathan thought this is better. I'm not sure if you read the
> RFC conversation.
> 
> I told this is easier for me to understand. Jonathan merely told he can live
> with that. For this particular driver it matters because I'm expecting to be
> maintaining it. It's easier to maintain code which one can understand, and
> if subsystem maintainer can live with it, then I suppose it's the pro you
> are looking for.

What if the maintainer will be hit by a bus? The point is we should also think
for unfamiliar possible maintainers and strange readers.

But sure, not my call right now.

-- 
With Best Regards,
Andy Shevchenko



