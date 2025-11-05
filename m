Return-Path: <linux-iio+bounces-25917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B86C36359
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C3D188B914
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105F32E756;
	Wed,  5 Nov 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ir5jVHDN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC623314B8E;
	Wed,  5 Nov 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355095; cv=none; b=JXJHyZEKgKWkPVgC7GczRfqxuvnnY1ZqoKRRq0hVjmBOeZr14DFEuXwCDzlF7YNM0NahmWdoWmaN/T0EZicBGQEeVE9TEdbVB1Sl15rSj16vUFQ8zFVdHSdEMKoPUDiz4OgMROwlpFKRzRBvyNztRPbZv/3zmjfT+nzF50N7GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355095; c=relaxed/simple;
	bh=E6z5Nc1ezh/OdyRJ8gbtV68Q6zNCbloIF2sx0XTu5sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7hsSIaGLqhdIInEZRl+gY537l2i6VvsvSicia/si3x8v7o17NYCwvB5QuWp0aVNV1mN+V+3BjzunZeiRnYmdLPRBerhmFY+kN8S0JgKp0PATvjgKOMfPU91oW+7/GcmXZw7X8MlPEpHzxlWjFKogZJVABvg9mNPd+n3ySJld24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ir5jVHDN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762355094; x=1793891094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6z5Nc1ezh/OdyRJ8gbtV68Q6zNCbloIF2sx0XTu5sA=;
  b=Ir5jVHDNYqT6lYjWJis14I25+20/HbGavIgW90/huQ8dDzW/2ghf0Ir0
   aH8/2nwrgxWv8IHAENZGncqhWvlJ3BsYqGPiKlM2Dvm0Jx6W4UMltRoKg
   cqrekBvwNbUE1Sj16G7ecSajvktsdP8g+Jjs6W5DvHnjGdo098WHNuJSe
   ukVVsKopxBktmwDmvDh0EsDtgxs8BHc9GcKTTthgVw0oVkUdomIrlarUJ
   D0iQd5ttCtsBy6tS3rP8XYs46op46XuEoD5D8V1g9WInidACmjcuCr1cl
   dNVhJYxPMEkjeFKFfCbkcBoMRelkx7ohl0oNG3qw4f0Wsccbq4XRb4lcU
   A==;
X-CSE-ConnectionGUID: SJ9P5oQsTqmyvK6Y7bvDSA==
X-CSE-MsgGUID: R9ZKynswTKqZkQcDwCskdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64505262"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64505262"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:04:40 -0800
X-CSE-ConnectionGUID: w425S8vVSC+co88XflheEA==
X-CSE-MsgGUID: 51RPs0JpQ/++FXmpe2yhUA==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:04:38 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGf3o-00000005osw-3GAL;
	Wed, 05 Nov 2025 17:04:32 +0200
Date: Wed, 5 Nov 2025 17:04:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, error27@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <aQtnfzUKHc0fY52_@smile.fi.intel.com>
References: <20251105094714.28117-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105094714.28117-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 05:47:14PM +0800, Ma Ke wrote:
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
> 
> Replace kfree(trig) with put_device(&trig->dev) in error paths to
> ensure proper cleanup through the device's release callback.

Now when irq_alloc_descs() fails, trig->subirq_base becomes negative and
in the release callback it will pass the

        if (trig->subirq_base) {

Is it a problem?

The release function also misses mutex_destroy().

-- 
With Best Regards,
Andy Shevchenko



