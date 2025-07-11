Return-Path: <linux-iio+bounces-21584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C121BB02328
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C7A1C48306
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F62F1FEA;
	Fri, 11 Jul 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kg564W8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CD2F19B1;
	Fri, 11 Jul 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256244; cv=none; b=R75vcLJAeDcIfnkFvFxpsFPuDRAwr9N9KTVVBuJ16wfO7vwRQcGXsHoG6SHn92zvcpU5lnlrtsaiOYVTVN3McLuY5HPxWHQQy3SqD9G8pBjwlGt53U5ynbg6bHCNbFhzv0l84+ioT3LFQNjGmxnsLYQvIEyeezYyxgzVsIX2CIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256244; c=relaxed/simple;
	bh=Ow7+dJl5BOWIAcl6ZddxYXqpvKdRi4I+iAe7RRS0F7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1hjBGdm3OnN3yKF6HfjAjT13wCwPJX6kf7fXDZ/MbOlytSb6CM5KouU29JXf15NsyDwmpwompOOVribUcu8SG8tt1wk7FL3El2pQfVql8+0qG+Lhe8T33VJomgL/u4fGHzw/gPH2yOd/FoL/7aAbt21Zng0wEeP9/JJLobV5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kg564W8M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752256243; x=1783792243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ow7+dJl5BOWIAcl6ZddxYXqpvKdRi4I+iAe7RRS0F7c=;
  b=Kg564W8M4jRJFiO1LYvSsDRdkRQyp1m4yJgIqkGyIz+5Oemx9WwZxiaf
   klVPvXyW/ozvqQLknnhTVY1Ntf9XZWNz44kqSh8I6cvqHA1EnxTJA+FTg
   0m8WWg8ZF4SwbTVyr9ekWOTXrKzJKCgjwXgj1DHbZrguH3BzvzOeowRXC
   Bm7gUKH/TAUrOGGx1RFh3wvU4Z5WbpgFJke8BeNc/YT1a+JrvyTfmV9EZ
   GHWWAP1fbtRKoJATEjiqDdXMw9vcbgo8poy5oerSvvdDB3rCx5T6T/HMN
   VW3lc4DF4SeLXWwC94kvhmvaMIcdCvuiww3XYw7yBYYJ5XnIP2g2om9Vh
   w==;
X-CSE-ConnectionGUID: XLqKiaHQSs6cBxBJVtWlOA==
X-CSE-MsgGUID: aCdXAzk9TIi593q3kp6cbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58367315"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58367315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:50:41 -0700
X-CSE-ConnectionGUID: cAoG6kzpQYi/Kjp2yNPBTg==
X-CSE-MsgGUID: laUmLHEbQIGF/O3nKTTazQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="187401739"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:50:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaHtM-0000000EbLM-43Yy;
	Fri, 11 Jul 2025 20:50:36 +0300
Date: Fri, 11 Jul 2025 20:50:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Message-ID: <aHFO7LhWXOuglaoz@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:
> On 7/11/25 11:41 AM, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:

...

> >> +#include <asm/byteorder.h>
> > 
> > Hmm... I see nothing about this change in the commit message.
> 
> It is for __be16. I kind of assumed that would be obvious, but sure,
> better to be explicit about it.

Isn't it in types.h?

-- 
With Best Regards,
Andy Shevchenko



