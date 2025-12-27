Return-Path: <linux-iio+bounces-27361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69271CDFE1F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97B563002144
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1191E32A2;
	Sat, 27 Dec 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIPWii5V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0677081A;
	Sat, 27 Dec 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766847652; cv=none; b=UDcL2ecyTSyoH8oQoDItgZLpVGYfkha94PD7Np7vZmCKW/SluirwpjVjvrLO1GT/VfYtc1ZrYQdWjfOr0FkaFP9l1HYWIdl+UF2f+FguqXU4xNYeqgtgugBIPhL7w/V33Pwv0WytLWHAhLV0fcP1QT18gKn9kqG46MpJHhN2W68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766847652; c=relaxed/simple;
	bh=A/lvOanHILy96ElVFPO3RgP4CDSTv4zbUtzZZnTZhe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdXHqPh+gt6MfWg4yEd6FMgLz2pnIGJ1xrg2VZ+yOYUnJD8kH+SPmJEwuLl1l4o+qEFDJPT1FZu+Ev2eGZYfCdXCulXgYsa9WQ6TbZFuNiJ54oRBeq/ahHyTAxlw/0m0QZ2O7Goi2q4wI+dZFt2RZyysNaJVTAMqTZZb3fFzzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIPWii5V; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766847651; x=1798383651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/lvOanHILy96ElVFPO3RgP4CDSTv4zbUtzZZnTZhe8=;
  b=ZIPWii5VYnnEUITQYpou6cPX4bUHptmYYLnYNP6asU9CU0utFr+Az4GA
   axcqeLkRBFI5pNl3SFBP4MfQs/FDl6tQM+mit94MtgGrEcUeRtZl9LCQP
   vgVTc5lsMiSfoDhqk0mRJ3ABe0ojQ5x8nPjE4r2kxXEKhjY4qPMUZtR7f
   0BvpjtgPb+Du8xz+BlmHFpqSV6zmIKs5+27roctWTZ5zmqH+4AHlM2dwJ
   UlAgEIYi3x0eM6PCUJtI0YFJTx/8CB0Pi2tcSajsE6bGkhoJ4FrIIzFF8
   cU0fnvHUVsY+fZYiqp4YHDrFSWuflEkry63fKH+3sT5437aVOtWqN41g5
   A==;
X-CSE-ConnectionGUID: oPydexCzRIWS/CJsBtI9ww==
X-CSE-MsgGUID: Nq0hOG/MSC+sJZ2msmX7Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="85965296"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="85965296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:00:50 -0800
X-CSE-ConnectionGUID: cSY+MO+CScSCOmb+IcSDmw==
X-CSE-MsgGUID: YiJpwGflQlGGdSr1L99Wdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="237966995"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:00:48 -0800
Date: Sat, 27 Dec 2025 17:00:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Fix signedness bug in
 gp2ap020a00f_get_thresh_reg()
Message-ID: <aU_0nv6yYjwCsK_Y@smile.fi.intel.com>
References: <20251226154523.89215-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226154523.89215-1-alperyasinak1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 26, 2025 at 06:45:21PM +0300, Alper Ak wrote:
> gp2ap020a00f_get_thresh_reg() returns -EINVAL on error,
> but it was declared as a u8.
> 
> Change the return type to int and update callers to use int type for
> the return value and properly check for negative error codes.

...

>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);

> +

This blank line is redundant.

> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}

And entire code can be rewritten in a shorter way
(in this case the type not needed to be changed):

	err = gp2ap020a00f_get_thresh_reg(chan, dir);
	if (err < 0)
		goto error_unlock;
	thresh_reg_l = err;

but this one is up to maintainers as I know Jonathan likes the clear naming
to be assigned to (however when written as above it clear to me what's the
semantics of the non-negative returns).

...

Ditto for the other function.

-- 
With Best Regards,
Andy Shevchenko



