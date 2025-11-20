Return-Path: <linux-iio+bounces-26339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3FC73046
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 10:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A4454E418E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53B301482;
	Thu, 20 Nov 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2fbRXlI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145826F443;
	Thu, 20 Nov 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629615; cv=none; b=XdhGI/Nv5uJ715r7gmQauXS5TTxUtFm20r+l79EsBlc9/c7Rb99YI3d1UMQ1nQHMAQNGbWRsYmAMD2C/bb4+/1bhfQ04YbL3ApDc4naqxuJwmeVK5mdvWxW/CLZmE4amK8GHKrKpBBOjQRTLPLymFLd3DzAgSUELbYDyknM578w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629615; c=relaxed/simple;
	bh=kqIAHoa9Hmh2aj3qKbSibKx1XNosylveQZT7J61Eceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL1RNPFDw8UZQZaSFOs26anjM1yULQZEV7fKg4UZiYTOa01yg9PWMOXwOnNmwrmxxq47AL/1s0/LVX6EQ72+GPbIaVdbUIPSUKc6GWg4sT9NCqOuzCb+ffsCEu42tXdyriTCh6z092ZNzyO+Ldn31Fe+eT4TisOGSlQl22Crq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2fbRXlI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763629613; x=1795165613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kqIAHoa9Hmh2aj3qKbSibKx1XNosylveQZT7J61Eceg=;
  b=Z2fbRXlIoKvnIsWYfdj9cQGmTQraEwotcw7Tu39okOq76EYL9R66v1J6
   +J6B5nkER9e+1Hr+Ww/yJGVka7frdPyAGeVrJKOrwNtby1pM8XItOfvAv
   UN6wVlv1jS0SoPVVAQVq8KeiWAPxafEXicTo1Ysj+pLEpl1pNISnbncHK
   2cxue7+8qRj4GcsVB9d7WI0NHbPW4RQRrXF/B/x/1A7vv0Puk4VDURBIY
   MrW8nNaOcZ/bfTKJtFN6VCbpV5AdQeJzzw1Jra33MjxEEiolkVK3tZrDc
   yJ7f0NffaCVBEJeIgUEpo2R991PiIVg5MnNdo2Rfy1kC5iCMUGnbcHNp5
   w==;
X-CSE-ConnectionGUID: PCYSde5aSs259p8CWq6zBg==
X-CSE-MsgGUID: 6PMTB0DnS0mGIP8U2sDx0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69560508"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69560508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:06:53 -0800
X-CSE-ConnectionGUID: b4ZD8F9yQIKmsbqDot2zRg==
X-CSE-MsgGUID: hOGi6W2vRq62u1lRMKC95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="196274909"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:06:51 -0800
Date: Thu, 20 Nov 2025 11:06:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] iio: imu: st_lsm6dsx: add event configurability
 on a per axis basis
Message-ID: <aR7aKXbDzTgSmhMe@smile.fi.intel.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-8-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-8-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 09:26:13AM +0100, Francesco Lavra wrote:
> In order to be able to configure event detection on a per axis
> basis (for either setting an event threshold/sensitivity value, or
> enabling/disabling event detection), add new axis-specific fields
> to struct st_lsm6dsx_event_src, and modify the logic that handles
> event configuration to properly handle axis-specific settings when
> supported by a given event source.
> A future commit will add actual event sources with per-axis
> configurability.

...

> +	/*
> +	 * If the set of axes for which the event source is enabled does not
> +	 * change from empty to non-empty or vice versa, there is nothing else
> +	 * to do.
> +	 */
> +	old_enable = hw->enable_event[event];
> +	new_enable = state ? (old_enable | BIT(axis)) :
> +			     (old_enable & ~BIT(axis));
> +	if (!!old_enable == !!new_enable)
> +		return 0;

Oh, seems I forgot to click "send" for the previous reply.
In the old round I proposed better way of doing that (spoiler, no hweight()
needed at all).

-- 
With Best Regards,
Andy Shevchenko



