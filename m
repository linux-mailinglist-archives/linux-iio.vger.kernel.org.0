Return-Path: <linux-iio+bounces-23576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1894B3E370
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D333B4429
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193631DD9A;
	Mon,  1 Sep 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPc8FlCu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213A2586FE;
	Mon,  1 Sep 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730422; cv=none; b=WQL9WI2rFybxMNbSqpHX124fVKGviVMscuOGxNUMz+T1nf2Qz3uzSmJAYyMvpmWZ+Ba6EHvubC8QWls/BKEO/v5hySO6y0guBbzVIXjVjfj7ST815RR6f+jN/rqyAwaVFBr+kSo0vt8kEqSj2+QtcuqBvDIwGosAtXbNrDIzge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730422; c=relaxed/simple;
	bh=iHVwYYDGvjOtI0TQC7+2tMUE3vkDRGUDM0rFnrg98KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkz1sImslogPN6DPtQ9s06F5WKpCMtA2LyiVxY4Y5NWW/64/Eh2mO9+xAyzuKRMCZdR638MTtqyeZJ+tJ6Jv+YZ3JhZ33pZXKdnWGiw4r6r/JdgYYQX12DX61y0UMwgpWAoSxBL9I7hm/sF4QHfGdO9RcdYg1TroBT+v87KEFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPc8FlCu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756730422; x=1788266422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iHVwYYDGvjOtI0TQC7+2tMUE3vkDRGUDM0rFnrg98KU=;
  b=HPc8FlCuOqo+f2KMUC31VD4STyczxGc+FCJfbhORocjnBeveV9pcSgFR
   g3cYn9wAZTBs5b2vuAek32S4ZGpJfIEASkr9JKjFeD99xDX6Qw9z9qAvg
   tSy5NEa2EiwnIEMxHgM4oq7WGX6Bs03SXlygZYvdYyhznPGJ+LLEZH2nb
   0DKIz9PtnwcSdQqsFnRu0dvg75pR7C+o1m2uUdYTonWrxolUipV1jU7dK
   GAkAYJkCtFp1KMqD+pYgjWJ8MOorALw/tuBOpBINfbRQHbb4SduG9idqC
   AQw+a/S/PZ4SA/TPCqxz1D9r/3pxj2mVBSO6YoDlG1VdceWF6kkmmIsFM
   A==;
X-CSE-ConnectionGUID: Vxk8G3yNSb2QvvOc8N7Y+g==
X-CSE-MsgGUID: icEhCTHhQqepziAwoBrfTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59053434"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59053434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:40:21 -0700
X-CSE-ConnectionGUID: jwgKaUbIT2Wk1SrJkXlkUA==
X-CSE-MsgGUID: +Rn7N2NaRya37zlyjY8TKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170566630"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:40:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut3pW-0000000APgo-1Cv6;
	Mon, 01 Sep 2025 15:40:14 +0300
Date: Mon, 1 Sep 2025 15:40:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLWULUIcYEz3N-Rx@smile.fi.intel.com>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
 <aLV0LBxD0KIHPSmo@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLV0LBxD0KIHPSmo@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 01:23:40PM +0300, Dan Carpenter wrote:
> On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> > From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> > 
> > The ad7816 driver was accessing SPI and GPIO lines without
> > synchronization, which could lead to race conditions when accessed
> > concurrently from multiple contexts. This might result in corrupted
> > readings or inconsistent GPIO states.
> > 
> > Introduce an io_lock mutex in the driver structure to serialize:
> > - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> > - GPIO pin toggling sequences
> > - Updates to device state via sysfs store functions (mode, channel, oti)
> > 
> > The mutex ensures proper mutual exclusion and prevents race
> > conditions under concurrent access.

...

> > +	mutex_lock(&chip->io_lock);
> >  	chip->channel_id = data;
> > +	mutex_unlock(&chip->io_lock);

> > +	mutex_lock(&chip->io_lock);
> >  	chip->oti_data[chip->channel_id] = data;
> > +	mutex_unlock(&chip->io_lock);

> I'm not really knowledgeable to review the others, if they are
> required or how the locking is supposed to work.  But these aren't
> correct because we're only locking around the writers and not the
> readers so it could still race.

Readers are in spi_write(), or what do you imply by this comment?
I.o.w. I do not see the issue with the idea of locking and how it's
done (I haven't checked all of the details, though).

-- 
With Best Regards,
Andy Shevchenko



