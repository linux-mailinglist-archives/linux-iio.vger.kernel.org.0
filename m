Return-Path: <linux-iio+bounces-25724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272E0C23D7A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4008188F412
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B32E9EA1;
	Fri, 31 Oct 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efo3Ys7M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E8DF59;
	Fri, 31 Oct 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899841; cv=none; b=gICILMiB5kCX1h1wOrCvh5uaFZ2w8hwFEuPg9EbzT+WY/eZKSyg7c+gj8pzLfHOgQk64ioVy5s18iIwJ5xvWfZf8z2MKawoNRFRs1DNk5Tigm29lPqpMHgXBfkdTumbMr5VeUQzZ7pNd+rbIfukY2v3EJHzRzPYzyNrVLbsynxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899841; c=relaxed/simple;
	bh=u2rSV+xALNV5Gy6zzb2fmDcmbew8tyHsmquJzh1ljDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrOxoUxjQidLwHbQOlTzdBKu5GHUZ/7mpi4mpIL4EU8oBzKFqvvCp2vuOT4B7VuTk1YDSOrBHrPeeSk3lZ1xdexKNmppMLD8O+nb5KdAya1+qOZI166fnhFTIiMRDd8fpwZzbFZQ2Ubh7QjH1qGrv4AhCq6luewZ4hpUqU5melM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efo3Ys7M; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899840; x=1793435840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2rSV+xALNV5Gy6zzb2fmDcmbew8tyHsmquJzh1ljDU=;
  b=efo3Ys7MrIiHhtcgo9jRY6j3uzl8uuaD/xQ7LVb/b9xPWUZrTmjzxOOH
   Nq4VojAfXt8Z6vqDDeI1TkxRVPMCLSczSARsAEW+ewmZdaD0lvP6czx3e
   XHUj/FsgbN4WEW/JlEjCIaZoFjKZ8BchgKtQaf196QX9MwQyyl+xuO342
   yCbitgcb6eiKSAlan2g7a71ND9w8eaBbp3M5elQr2m872ad+8QrsrEXJ0
   xpqRoBsev0Zl/jq/gICUEhD45Apym09Qab/IRi96fWuR8R5p2DPA5CWpq
   zwy9wL1ksBcehjnW2P2rI/YFGBBuEuozdn90Fh5PzyKN0mpO1Z4ZRPb1g
   g==;
X-CSE-ConnectionGUID: P98n0r4jS2uMtLkDSAwh8g==
X-CSE-MsgGUID: DMCUfO4PTj6XtJtn6cNJOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74347088"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="74347088"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:37:20 -0700
X-CSE-ConnectionGUID: 2UlwxA0iTvCXwGFLJGWuNg==
X-CSE-MsgGUID: r/qe0u3cRXyz5xSqmlUsVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185867159"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:37:17 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEkdE-00000004D6i-1UeL;
	Fri, 31 Oct 2025 10:37:12 +0200
Date: Fri, 31 Oct 2025 10:37:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
Message-ID: <aQR1N__AwvPm21tm@smile.fi.intel.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 10:04:08PM +0530, Ajith Anandhan wrote:
> This RFC patch series adds support for the Texas Instruments ADS1120,
> a precision 16-bit delta-sigma ADC with SPI interface.
> 
> The driver provides:
> - 4 single-ended voltage input channels
> - Programmable gain amplifier (1 to 128)
> - Configurable data rates (20 to 1000 SPS)
> - Single-shot conversion mode
> 
> I'm looking for feedback on:
> 1. The implementation approach for single-shot conversions
> 2. Any other suggestions for improvement
> 
> Datasheet: https://www.ti.com/lit/gpn/ads1120

The cover letter missed to answer the Q: Why a new driver? Have you checked the
existing drivers? Do we have a similar enough one that may be extended to
support this chip?

-- 
With Best Regards,
Andy Shevchenko



