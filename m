Return-Path: <linux-iio+bounces-9073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A55F96A019
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519F7282F7F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5CE3C092;
	Tue,  3 Sep 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO3HjH9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CC1CA6B5
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372789; cv=none; b=bVk9CiUUEWs3BaXvoBMXIdlFTnGLtbqE18+0K0hnvPyxH93a2qpKqpJ3ewS07LwIsg3XOo1swntvqNSKymWrqlqlL4HjIfkX5y039+IeULd4MpXP2f0g18ePSzK6Zu8OJIr3VqTiEA7YckFp8dpnXgWBb4yldv32+Srh3bDys+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372789; c=relaxed/simple;
	bh=VUwENGPh7Q58u75DzFzjoEHYT9himvu8deJhGSCuWEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htrUcirCbERTVNAlgGZvl80PK4FWXzw9H4eIJvfIFUJ6rQftFr8E9jl56sC4zW0dSpDTiO2O0BJsaM994inVCsZZT/s29f0EO2/iDRWI0D0q+nr98zkzdDP41eJiUZtAJhT2sLMIgZAjdHeFMEbXna7PzYDHteMR2ebPC/ZRhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lO3HjH9U; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725372787; x=1756908787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUwENGPh7Q58u75DzFzjoEHYT9himvu8deJhGSCuWEo=;
  b=lO3HjH9Uwgtvwnyi7DmfXgvmGbRvUc1VKv+LanaejMzlFGGmf5AdxbhK
   hN8c94g3UjHw4LEX25ZpJO3E55nHxvNB7zsbyKv06hunpDXg7TQPCLvih
   HL30V+ZSubp7gzDAzC3I/dz3zQoy+fLFzUPbFg3lwWeIwJ1LIHZqvxWy0
   Bxa6tpyi1fGTtF2uACvt3Jy5zRkkxgKeskA19D1iVrjBpWoNBsGb6NCXQ
   CY930jLV0wO/NuwxAXdI79n1zGEeVvm/sdKyxerUgXM4luPBZp+8MltWC
   c2VuqtlaFyMv7vNlh+ItHQKUTrRM4IC8+nVwrckypxxhR3So2bepUXlX/
   A==;
X-CSE-ConnectionGUID: vWs9CHo4QwWHvwQnsLljJw==
X-CSE-MsgGUID: fTUsgDqMSkWaZUE73NIgxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27765491"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="27765491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:12:58 -0700
X-CSE-ConnectionGUID: rGtTw102SA278VbbNAoceQ==
X-CSE-MsgGUID: 8xkk6bC+Q/yPvwlHRfUR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64602809"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:12:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUH5-00000004jN8-11zn;
	Tue, 03 Sep 2024 17:12:51 +0300
Date: Tue, 3 Sep 2024 17:12:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/15] iio: light: st_uvis25: use irq_get_trigger_type()
Message-ID: <ZtcZYr3M2Z7QVHbk@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-14-jic23@kernel.org>
 <ZtWl7zdWGwDHJfL3@smile.fi.intel.com>
 <20240902191926.3df37a68@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902191926.3df37a68@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 07:19:26PM +0100, Jonathan Cameron wrote:
> On Mon, 2 Sep 2024 14:47:59 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Sep 01, 2024 at 02:59:48PM +0100, Jonathan Cameron wrote:

...

> > > -	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> > > +	irq_type = irq_get_trigger_type(hw->irq);  
> > 
> > >    
> > 
> > No blank line?

> Might was well roll it into the switch now you mention it!

I think it's discussable (from the readability perspective), but FWIW, I'm fine
with any of your choices here.

> > >  	switch (irq_type) {
> > >  	case IRQF_TRIGGER_HIGH:  

-- 
With Best Regards,
Andy Shevchenko



