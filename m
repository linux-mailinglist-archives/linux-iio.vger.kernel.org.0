Return-Path: <linux-iio+bounces-25575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6011C14695
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 12:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BB883526B7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C513081BE;
	Tue, 28 Oct 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDZWADUh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56031303A38;
	Tue, 28 Oct 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651649; cv=none; b=PPxw8iVTHpk3Ti5P1cI0DJL6XYJW/sRyo4YjZHhJuulrYd7XfYcc0zDQFp8ytvbHkrYmfEO8HutERNIebbD/enLEj4sboMsU4iOWgExtWUn8wY7YiVfaChRfsXOnHaS7E2oz64gvvGx9GTc3ZEfwqHB99jHu1khvlHATrrWOelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651649; c=relaxed/simple;
	bh=Zm+ETHfHQTaVVdtsPF1GJ121hJhiaTf4ApL7QLbkG78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfKuKPDF4YimChJI5UtbDwlb01nCOQCY6mGeydDJOU56nLxcfooQeFsMRfVcHEJHdVHx2l1KUSq5qLOmGgTYcBDJE6CqHttvtdLZEcVLRqJyN/MiJNoiUK0OVv/x84iowjVqa2z94YX1QITMzyJU5JlKAbGap+6Yr4sy+jCHK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDZWADUh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761651647; x=1793187647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zm+ETHfHQTaVVdtsPF1GJ121hJhiaTf4ApL7QLbkG78=;
  b=XDZWADUhEfXnkda/C/PomLUW6YV7oKDb4KDmQhS8aZRdSRrEoSVDcS8M
   M8Tcjku/wXS7JjOzIX0cae1L5YONThvzavSJACVTCw601fRhuyHyNzdzx
   3izIyWxB66Zpg927Yv5a/cCgMPCM104BBsclyaRYgiTSpkQk5IZaP3gMk
   DIJCKBD5GNWocKb0P+3aKDOjEnWnKm1I4eHN9AGwQYDZKs7hvMkZY3eSu
   PtjrNr7Y2mvnbyhjytpEk3FteS6ywlpLOT2EBeJwspCZEZMQIOqrF3Vlk
   jfe+AQ0zpLzuiQEKghgTFIhVxOLBgCoCEO6/WTV+2LP34wCGujctuUVBS
   g==;
X-CSE-ConnectionGUID: 8kDi/7gDSVusayX+TWQurQ==
X-CSE-MsgGUID: NeNjj0acTLSHXtNjF4+yUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63784833"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63784833"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:40:47 -0700
X-CSE-ConnectionGUID: K3LoQzDVTaaqlrUpRPVskw==
X-CSE-MsgGUID: 9hahvjJkTBSqd3lLPuLjog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222533468"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:40:44 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDi49-00000003IcZ-110I;
	Tue, 28 Oct 2025 13:40:41 +0200
Date: Tue, 28 Oct 2025 13:40:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <aQCruaNsGD24PFEk@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
> 
> Add a check for the count and use the return value as the index.

...

> +	if (count >= sizeof(buf))
> +		return -ENOSPC;

This is already done below.

>  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>  				     count);
>  	if (ret < 0)
>  		return ret;

...

> -	buf[count] = '\0';
> +	buf[ret] = '\0';

Do we have an actual issue right now? Can you model it and show a real
traceback?

-- 
With Best Regards,
Andy Shevchenko



