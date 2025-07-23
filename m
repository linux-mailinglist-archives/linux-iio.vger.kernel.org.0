Return-Path: <linux-iio+bounces-21905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF3B0F502
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC781888B7B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE652D948B;
	Wed, 23 Jul 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql4MVv8d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E81FC3;
	Wed, 23 Jul 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280024; cv=none; b=htnxtVw1IJuQBBwUPdZ9xJaP3mRzwOxzVjD0mxkUSkbjlI75hzgqYjg839ix2lhzOB/jFh2VaHspq5eT2GLYlV7KXhRVrvINgVozPYiolYzmd9CBllbPYcRh7EO9szAv9KKZAoWnDHYEdmcGWpK5U6VCHGfHWSw9OfQ1Wb/JhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280024; c=relaxed/simple;
	bh=ZVUk/VpfWAG9sWna1cr3CUOKZxgGMG2dxSear7Keiow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVWjkjLklmsKf9TudIY8Hb75A8zw+tnlLK7eCwpPDRJUCRpPSNYSC1wyG6GJF5bznyOQ71K9cXoTfNKEqnhz4vOwaW0dLYwijcZ9oVxOKJv58E1kEoNyU58Vdyh0fbmIkYDTT1E3OGbk9nYK+kuXkbt4x7H54mvuyXYZCehnXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ql4MVv8d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753280024; x=1784816024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVUk/VpfWAG9sWna1cr3CUOKZxgGMG2dxSear7Keiow=;
  b=Ql4MVv8dD6rsc+d6ltvuKwVFIdi5zTFPW+CaerVTfqpjbw7Xhc2gz/HD
   hLzrKCRHrID6y2B1a2+nS7/R5FtnovGjh9YJgO0Gk+nstiE+/POM7rhFK
   Ke2fdpXqmApaKt0cQK2XRngKTBsfZ1HeWj/mGOMvop6RrzZkbw6gGBgq4
   oNEYraGZlXyUEj4A1KJEN7yR7eljkuGmkVu6IHuf8vmlgsZjzLanTLklC
   f8kPUDvrA1qr9jl0G3y1A3G7aBV0myLCauwJyRQzQDimGUd7RurfFcc0E
   hRw8nrIdxtGECu5zgcIDILWhie/pBB2d6a3K6ZX9XnJeTtS5PoqOOszxF
   Q==;
X-CSE-ConnectionGUID: BgsmCRiPQbKdvoq/nA9+RA==
X-CSE-MsgGUID: fmGwJcfORxiPNDYHXJZZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59221539"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59221539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:13:43 -0700
X-CSE-ConnectionGUID: Az+SUBGkTmygDAf/64dl8w==
X-CSE-MsgGUID: s+w0q+SYSq+pBmBnP3OwcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190534620"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:13:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueaDx-00000000JGY-3x6z;
	Wed, 23 Jul 2025 17:13:37 +0300
Date: Wed, 23 Jul 2025 17:13:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
Message-ID: <aIDuEcHhaGtz2klP@smile.fi.intel.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
> On 7/22/25 6:07 PM, David Lechner wrote:
> > Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> > the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> > the data before pushing it to the IIO buffer.

> It is odd to have data already in CPU-endian and convert it to LE
> before pushing to buffers. So I'm a bit tempted to do this instead
> since it probably isn't likely anyone is using this on a big-endian
> system:

I can say that first of all, we need to consult with the datasheet for the
actual HW endianess. And second, I do not believe that CPU endianess may be
used, I can't imagine when this (discrete?) component can be integrated in such
a way. That said, I think your second approach even worse.

-- 
With Best Regards,
Andy Shevchenko



