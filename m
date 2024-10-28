Return-Path: <linux-iio+bounces-11444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6D9B2BE0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017CC1C21F71
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24F1D0BA3;
	Mon, 28 Oct 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK4r5ISb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CA1922F2;
	Mon, 28 Oct 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109021; cv=none; b=LNUDIooxsypW6U+v4u/altXCNbqxNxr6Nhi7qmbmsoqvFn2U9Vh3DJ9jpoxT1xP0GsLdxwkYDAGLl8z9ErGZgefACoQsmjDJiNBR0JYCmiYf8Oxx4D68fMiLUiuKoaBLnawuadR6OFn9NRoP5AKFbi3Q/gF4So5CmDo4cywSjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109021; c=relaxed/simple;
	bh=D06NwUNc0DMMBCAufbwY2mpC5obADrVDATMmNT/46Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEvFGfszDR+BxsMxWM8Yc9ls29TE+ujqSZNAUoFN5+sudszLUB6BG5IyQ1T0WJrUV+X6FtYo/+ldzOpQBHX6T+QhMVmiV+K5lBDkLKplKfN6B/3TLG6wtylgqBx+mpZLvGvenzV3bVsXpbgBndFwYqvKwwY2wTs0xuacu9DqR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK4r5ISb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109020; x=1761645020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D06NwUNc0DMMBCAufbwY2mpC5obADrVDATMmNT/46Fo=;
  b=FK4r5ISbe9QjsDsLVUscUGHZgfPh7ma7K3EV3uxMS0jWanJWCX4UZrWz
   At0ftyCJ98itWam3og0tvLGqINvn5shC5HYe/3Zuw3U0nf2qM/U2xoVeh
   +vNDn0ujJW93KBkXLzHlQuoF7tA4NH4urI3f/Vnz60GB9abG4GHpW9yxy
   Cg0IWU3PAUs+vPyfuDsfp0rwjagfroY9hRmcjdDBT7AKpgccZZ8aabPFx
   h6jJIdeoCPn1v5n50dRG0X9Xa3/MF/a2zxmz7b0rz/b35jKggcMcOzzZv
   +66eEufAt9E3FvMOmZ/BcUvDs1STTUJ635d++LmSuSxMkUmf+7/Q5uhrL
   Q==;
X-CSE-ConnectionGUID: lNByK6zQTN26GkAlLwt+3Q==
X-CSE-MsgGUID: UvbZO8zLS5uUjkxL9BBiYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33395358"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33395358"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:50:19 -0700
X-CSE-ConnectionGUID: ywQn8RbZQQqAc87PUiZvpg==
X-CSE-MsgGUID: 3H2Q3DIsS+uh9/NWRbyV5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="85525093"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:50:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5MO6-00000007tm1-09nP;
	Mon, 28 Oct 2024 11:50:14 +0200
Date: Mon, 28 Oct 2024 11:50:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 14/24] iio: accel: kxcjk-1013: Get rid of enum
 kx_chipset
Message-ID: <Zx9eVcituFow8PTo@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-15-andriy.shevchenko@linux.intel.com>
 <20241026123736.5714fadd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026123736.5714fadd@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 12:37:36PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 22:05:03 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Instead of using enum, out of which only a couple of values
> > are being actully used, make a comparisons against pointer
> > to the respective chip_info structures.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Hmm. Maybe worth a revisit longer term to use callbacks for the
> decisions instead of matching at all as this stuff tends not to end
> up being specific to one version of a chip as more parts are added.

As already mentioned in another reply, yes, the callbacks is the future.

-- 
With Best Regards,
Andy Shevchenko



