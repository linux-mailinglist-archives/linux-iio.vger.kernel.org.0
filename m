Return-Path: <linux-iio+bounces-10440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8E999A09F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42645284077
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A720CCC7;
	Fri, 11 Oct 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OytAKNR5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357BB20A5E2;
	Fri, 11 Oct 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640841; cv=none; b=UxZ+XSoYL1ObZ3PHiMdYnpIGQek6Pu5+ApC7zmbno5fyNasCtLm3h31Ve3/2tNNRX2YEdG0nccUBDFyqgUjHVVLJi+/dTTz6Z8O1lVuBAiJkpfkvCeuhrqnK5BiUfORzzVpUwNCkVlGyWjjm249X3JP5xs6JcSaGXB2TiI4+f1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640841; c=relaxed/simple;
	bh=28WlqzpCpZulvXzTrsGj25L0PmmOf+eWAFDkJUIM0+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXxRtBRt66GMsa5TH4sEsduBuyZUA4nWpUrdQ89rX6/J5xk6cpqx2LB7mdeyW26WDrKS1wKWjPqk9gB70LrLld2UUC+dMtrqMDwVjK8/wxL8BZZFneGv8Q+ZO1bs82zBJG7nAmfkBzY2Pa+yx/ktqnEFHofyMCCYUrogiq8amEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OytAKNR5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640840; x=1760176840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28WlqzpCpZulvXzTrsGj25L0PmmOf+eWAFDkJUIM0+Q=;
  b=OytAKNR5+G/7jhbgAMpqNderyY/6fC2MspdK71YuxxaIwA14p2rn3hRt
   AzXtno5yDwsj+6UdNWl3pYKbd9uwWR8Ro1z/I/x9Iz0AIWBviGfN1fVej
   dMIHW+ur/1RO5Jy+6cRHuGdFaAmgDFw9sLyaCpKnixlbf60HKLmPy8Mas
   WE9+jCZrT2slm7PkvC7u9jtch5mBB+u8+y6sGyA4yXbPezt+PdPJSDTU8
   khdLsvxaKz0HEqjREzfY7kKx4lq0nbZ3NmKC4hufxj75M0ooTc5PjuVe1
   vqAndzcW88oJhGbLSLAKJ/Mury0x/KwDt3PGryQBJe3TqL5MWQFapCW5a
   A==;
X-CSE-ConnectionGUID: ySvjidEwTcWfYSQfTrzZaQ==
X-CSE-MsgGUID: vRAQ4yawTfOvrmHIYgOWbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="45546884"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="45546884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:00:39 -0700
X-CSE-ConnectionGUID: DZyD5RdDScyxl0D1+h6nDg==
X-CSE-MsgGUID: u0BzR6ISQl2q5NWZrxmncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76770782"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:00:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCRm-00000001qoC-0Pjl;
	Fri, 11 Oct 2024 13:00:34 +0300
Date: Fri, 11 Oct 2024 13:00:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/13] iio: chemical: bme680: avoid using camel case
Message-ID: <Zwj3QZE30juE53Vy@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:19PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Rename camel case variable, as checkpatch.pl complains.

With given reply to the first patch...

...

>  	/* Look up table for the possible gas range values */
> -	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
> +	static const u32 lookup_table[16] = {2147483647u, 2147483647u,
>  				2147483647u, 2147483647u, 2147483647u,
>  				2126008810u, 2147483647u, 2130303777u,
>  				2147483647u, 2147483647u, 2143188679u,

...here is the opportunity to fix indentation while at fixing the code.
I.o.w. I would reformat the entire table to be

	static const u32 lookup_table[16] = {
		2147483647u, 2147483647u, 2147483647u, 2147483647u,
		2147483647u, 2126008810u, 2147483647u, 2130303777u,
		2147483647u, 2147483647u, 2143188679u, ...

(also note power-of-2 number of items per line which much easier to read and
 find one you need).

...

>  	var1 = ((1340 + (5 * (s64)calib->range_sw_err)) *
> -			((s64)lookupTable[gas_range])) >> 16;
> +			((s64)lookup_table[gas_range])) >> 16;

Also an opportunity to make this neater like

	var1 = (1340 + (5 * (s64)calib->range_sw_err)) * (s64)lookup_table[gas_range]);
	var1 >>= 16;

So, at bare minumym there are redundant parentheses. And looking at the table
and the first argument of multiplication I'm puzzled why casting is needed for
the second? Shouldn't s64 already be implied by the first one?

-- 
With Best Regards,
Andy Shevchenko



