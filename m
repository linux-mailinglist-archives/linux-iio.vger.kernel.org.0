Return-Path: <linux-iio+bounces-25683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB2C206CD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D2E403283
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1D226CF0;
	Thu, 30 Oct 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMl6jC/A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0311EF39E;
	Thu, 30 Oct 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832577; cv=none; b=sKp4Z9H1REZ4onEdTl+EAee2JjyB+dmM3Yq/r7xADdPX/NcmjyjKpuwyC4hKtUkzaqyuKjBr+MGpxxR3fbBSoS6XK2XbMcGTc44X6Aeal2Jmaelgke/7Hs4fgDCUvmxDkiBv2n/VXzGTG+yFlqMChmdiL5ATRocT5tIcOrAvpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832577; c=relaxed/simple;
	bh=JxiAItqGkjd++MYOaOMi3nNa/YOuw3UezW8CeaQ1LpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d72+jYP3FO1gIbzGknxs3rXHgM34zWDXzOAu6XhGXZy1uI3x8nurW8Sw++RznsyHV6xO2sbb3XG7hZsRkUsS+X7BA//V5I2uFONyL1LsbEAUgoVJXrTd+nIqtysgFvarG1NDAZxW97BsoG/0Yd68xkFR4HKJQCoZnjvjAPyTqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMl6jC/A; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761832577; x=1793368577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JxiAItqGkjd++MYOaOMi3nNa/YOuw3UezW8CeaQ1LpU=;
  b=UMl6jC/AO6DXSg/pOPGPKqIp4TpaRglL7mfKnWXK+jatSpJFYujVt3ix
   wRQT5pxPia0EC73E3scPRq0YX5UadS3Eml1PnjCfN7l+LZndz8aAbEOSf
   /TFEOsb7oqTDnd1n8vto5DiCVHSB6yZkmSFuWjRL8zqVHVeyTtNZ5l4Uj
   Z1CIwrQiNTsDGqHt70aJ3fcdocxQbRN0KJ0kYcYAAQG5nYbM9BVGobMmf
   ECHqUfg7Yg0cC3G8H71BKf7HQvsTqWEu9wMtbodPy1qFqGMAX+h6bF7G1
   IrjIA7WFTjOPaRYIPqtLwp+wG4UFA/5awNQim3LGxlcJe32IatYTFI4ci
   g==;
X-CSE-ConnectionGUID: qcjQq77ZQeOkPwEZC8ZXhA==
X-CSE-MsgGUID: xR4tsuHkRlGN/PtW0VgepQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64006064"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64006064"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:56:15 -0700
X-CSE-ConnectionGUID: 2UqlAQ35TquFj8rcUW6PuQ==
X-CSE-MsgGUID: TeUppLPcQ6CKxbmnS9HyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185619224"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:56:13 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vET8M-00000003vgI-01m9;
	Thu, 30 Oct 2025 15:56:10 +0200
Date: Thu, 30 Oct 2025 15:56:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aQNueWesrf_vXO06@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-9-flavra@baylibre.com>
 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:

...

> > > +       old_enable = hw->enable_event[event];
> > > +       new_enable = state ? (old_enable | BIT(axis)) : (old_enable &
> > > ~BIT(axis));
> > > +       if (!!old_enable == !!new_enable)
> > 
> > This is an interesting check. So, old_enable and new_enable are _not_
> > booleans, right?
> > So, this means the check test if _any_ of the bit was set and kept set or
> > none were set
> > and non is going to be set. Correct? I think a short comment would be
> > good to have.
> 
> old_enable and new_enable are bit masks, but we are only interested in
> whether any bit is set, to catch the cases where the bit mask goes from
> zero to non-zero and vice versa. Will add a comment.

If it's a true bitmask (assuming unsigned long type) then all this can be done
via bitmap API calls. Otherwise you can also compare a Hamming weights of them
(probably that gives even the same size of the object file, but !! instructions
 will be changed to hweight() calls (still a single assembly instr on modern
 architectures).

-- 
With Best Regards,
Andy Shevchenko



