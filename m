Return-Path: <linux-iio+bounces-21183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C1AEFB15
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F0B18854A5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A461274FF5;
	Tue,  1 Jul 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN0VgB6a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB3242D82;
	Tue,  1 Jul 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377632; cv=none; b=eQzEfU+htvAdxobS2znlYT5EduGuoX97hS6UAcpo9Cld/0Ya2SM/dR9Lu5Z15T3obh6ITjx+LWVvEse0cswMaX7SZslFaBE6ZDKt3EIsyFa/92prEXVuKDYGRF1PetaU1SoelPbTXB1lD/fuv15/D0UJwkKCisuQLJpJNVxUaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377632; c=relaxed/simple;
	bh=D350Vrkg9Xz85cha9EvWh4Z+W59/p/0wsVvj8UJJp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4BvZC5Z84wtkdh9qqvI8JekGMiyUnmQZM1hRBD2kp6gwZ1TKkWQz9SIf9IMQh9/IFtMVQ9ngRuWLLSa2ygXPi6EMXa21LRpYDCzyXadfw65f7HvvvLCnzV9d8RokPThNIBtJZIBd/9jGrR5Ysi1sNAFwOTsmhCl8ZZGTGLCyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN0VgB6a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751377630; x=1782913630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D350Vrkg9Xz85cha9EvWh4Z+W59/p/0wsVvj8UJJp0s=;
  b=gN0VgB6aLOFlkUvT06CHEVZEd9LFyCJZZmnzw/xazLxu9wwiqBo9ed2x
   nVnQWZNmtKHtM9GFWLSb+q0cnwwKf+eJJkaekfdODoX/Rk0nBsF8gJXfV
   FWsT8WBGapIF56Izl1phkZzU3yNbD9x6APoMEbasQFMAvBN5Znt1obzZw
   dIcGvrRi61+0FSL89uFiR+1TVKSs6KgBrkY69RQRn/gP8276xuWyixXNi
   RzVszu29jAzIejiuayrVH/CERcgjxqOUgCXsyYZNrdrlg/F2d6s8htnjR
   3cpWsedl23a28CSa5Alvt8vFKyJR+yCLoS/kJcdKcSOoxDIrgLF5nxDVV
   Q==;
X-CSE-ConnectionGUID: liGqwe/ERQKHS44djYiDfA==
X-CSE-MsgGUID: ICtE89LMRmCwXz7LI8dgeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53579799"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53579799"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:47:09 -0700
X-CSE-ConnectionGUID: Eil3r6hVScSaN7+88oPlvQ==
X-CSE-MsgGUID: tXLznhzSSCCzlBNPmkzz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153187029"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:47:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWbKA-0000000BbvL-3nHQ;
	Tue, 01 Jul 2025 16:47:02 +0300
Date: Tue, 1 Jul 2025 16:47:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Message-ID: <aGPm1td5sEqp5R9H@smile.fi.intel.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
 <20250628155643.7c18e023@jic23-huawei>
 <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
 <e4c7296d-6afe-4edb-b26f-44218e660a80@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c7296d-6afe-4edb-b26f-44218e660a80@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 08:33:59AM -0500, David Lechner wrote:
> On 6/30/25 3:59 AM, Andy Shevchenko wrote:
> > On Sat, Jun 28, 2025 at 03:56:43PM +0100, Jonathan Cameron wrote:
> >> On Fri, 27 Jun 2025 18:40:00 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:

...

> >>> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
> >>> +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
> >>
> >> Ah. You do it here. Fair enough and no problem wrt to patch 1 then.
> > 
> > Hmm... Should the second 8 be something like sizeof(unsigned long lone) for
> > semantic distinguishing with 8-bit bytes?
> 
> Yeah, I considered to use sizeof(s64) to match the next line, but it
> it seems like a separate change, so in the end I decided against doing
> it in this patch and it seems too small of a thing for a separate patch.

The problem in not the size of the change, the problem is that semantically
those 8:s are _different_ and code readability will be much better if we make
them so explicitly.

-- 
With Best Regards,
Andy Shevchenko



