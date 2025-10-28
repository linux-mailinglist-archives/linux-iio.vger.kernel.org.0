Return-Path: <linux-iio+bounces-25567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E5C13F68
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D76A6506E61
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373B3002AA;
	Tue, 28 Oct 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etcUPv/m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B232EE617;
	Tue, 28 Oct 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645324; cv=none; b=m335W9zczbgls2DPHqFZLEvsklbYdSQe6ol61pvXa4DTj+U2zEsXk4u086o8urtXiyL4ZNPLGhhzDgAIytg5mHsOqrKnYvC6S9PMX/mUeVXMqSRpK2DAa5/XNBmCJ9LS7g3CQXFJuOxlQuenBtnAy4UeQGzDj5jy31IyzVmLN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645324; c=relaxed/simple;
	bh=7rREO7SY4FHdOjsvO+HvrxL/9K58eTUD3dN7qUFKvrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arlcvi0xxvmOG2+FW2L/yEpIfcp4SGWbJfA7Zbb0h89xW6W9Kmdm6UKgnDovznitXoZZ8uRAx+YCqF29QzItDrsdxAYYd3H8scZoXhxFd5F+cYAwkG6+GfMFUkTTdvyGvCj8qI9WUoKEFb316lksCG2y/+oXJa9jLZ6i7v4t/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etcUPv/m; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761645323; x=1793181323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7rREO7SY4FHdOjsvO+HvrxL/9K58eTUD3dN7qUFKvrw=;
  b=etcUPv/mQ/16VLo/jb6hEyJ3iZNJ72T20X6KhM71wMO9pMpmYfEybRT3
   v4bnfbr4zSt94FRsNriheeMMSsOMkZt0Y1MZu6KAfMWR7XP9A5sjRQUDh
   r4koTNtkJvTsi8xKgpVq7/duK2ku98onq04wIIlMii3W2YWPbgAGn85RP
   Yiyz60lCwGFTna5BbX0OgigoFpp5qTu7ayyZA+P0Defr32iALuX0yr//a
   EJKY5Pe6hQg1pmNarGAhhs9fYzQfOb2Yjcvy3UY1VbenDAifHumroUx/1
   BOnVhC22augOktDik8UaBINw6kB6EI4WKdr/jKx9qY+IAiDasy5+wi26G
   g==;
X-CSE-ConnectionGUID: NDnhOsaqR9iQUHQtZveTPA==
X-CSE-MsgGUID: 6G8xTzBpSSmKB3ZZ8ryfpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67578056"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67578056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:55:21 -0700
X-CSE-ConnectionGUID: vvDskjjkTuqkb7gtMagaig==
X-CSE-MsgGUID: +pylhT5iSNuCG4pcMryHQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185195695"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:55:19 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDgQ8-00000003H4T-1hZz;
	Tue, 28 Oct 2025 11:55:16 +0200
Date: Tue, 28 Oct 2025 11:55:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: qcom-pm8xxx-xoadc: add support for reading
 channel labels
Message-ID: <aQCTBHZ2pQ1pTAnA@smile.fi.intel.com>
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-1-b000e1036e41@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pm8xxx-xoadc-fix-v1-1-b000e1036e41@smankusors.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 05:29:16PM +0000, Antony Kurniawan Soemardi wrote:
> This allows user-space tools to identify ADC channels by name through
> the IIO sysfs interface.

...

> +static int pm8xxx_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	return sysfs_emit(label, "%s\n", chan->datasheet_name);
> +}

Hmm... In another thread there is a discussion on label vs. datasheet_name.
So, why datasheet name and not something that it's more reliable as a platform
description? As far as I understand there many mysterious ways of HW
engineering and how to connect available pins to something interesting. Even
datasheet names may be quite mislead on a certain platform (due to above).
I would expect this to come from DT or another platform description and user
space should rely on the information from _there_.

-- 
With Best Regards,
Andy Shevchenko



