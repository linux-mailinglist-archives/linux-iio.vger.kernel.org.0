Return-Path: <linux-iio+bounces-24034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6048B555E9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C1E5C68AF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C032A818;
	Fri, 12 Sep 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbYkJxVM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068F302CB2;
	Fri, 12 Sep 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700786; cv=none; b=lS+AgaWKaR3bCpZ9AwbxXFYn2M50VVTW2kpF1LXdFWgB36g55CcC6d8mezmPn6k6SOGqqaRLrfXxXzJ0HsJSQYXbE9feQxDVLMQLyF12rT+neKtvpBtWuyEI6mWtt6RH069GS1KqO7vEyqABQO7KRox/4cdK4MiEhx35jAy5My4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700786; c=relaxed/simple;
	bh=KzBalHut2NdaXieLtPuChsiLMyNBMoYrgZaoPy/g4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC9GrohqvvE2KB9M7MbX9eCI8XYTyVTGXFgLNqQ0BJ9tCGzynvzPKo8nzvIwkAVjSmEixTK/SaNT5zWe8+xYl5iguh/HrVP34fYslH/hBnM2bHo8UzAD1KAHrrTBs2FI68TYW5olLnuyUlEM5SrJlL46DG1ybmePufLZTLuTdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbYkJxVM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700785; x=1789236785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KzBalHut2NdaXieLtPuChsiLMyNBMoYrgZaoPy/g4G0=;
  b=nbYkJxVM7I7wj9lYF/jGDSg6SDCoqI3aUzylaoDkZg4zoDdRjacSCm+Y
   RkrfVU7DF7TTrGwMfxkwLWLQvEKC17EeNGAvrddNm5K6dn0d1Ms+Z3vT7
   NHs5VS1UXluKclR1Z+LS4BK7g8d4P5ZIZJIA3VG3smFPQyBD8RUxgCwCk
   Ei/4BFGVrjLMYGZe1O1K25mHQshcMvntO8L60Yuo5ZmhB7ggTAOUjpiLl
   g/sDqZOh/7qep44VIJVXwyTjs+m8Fih0dJeqsDM2nY23CTRhw8shK5lL4
   h9e+n0e7imRQP3vQqlWLb+h9ZUZoER60w8D5YpREX9M9BnP0jlv1eKRSh
   A==;
X-CSE-ConnectionGUID: GQcl75fOTumi5xvmFotSRg==
X-CSE-MsgGUID: FwWXtPvwQb6kJevoKHRnQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="63872890"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="63872890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:13:03 -0700
X-CSE-ConnectionGUID: /SHynvcgRLCgtsFra/ALfg==
X-CSE-MsgGUID: 1RKQ/UDbQ7mUs0pTA58JaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174805124"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:13:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ux8GY-00000002T4E-2TOb;
	Fri, 12 Sep 2025 21:12:58 +0300
Date: Fri, 12 Sep 2025 21:12:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/7] iio: buffer: document
 iio_push_to_buffers_with_ts_unaligned() may sleep
Message-ID: <aMRiqu0pEqX5SBHc@smile.fi.intel.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
 <20250912-iio-doc-push-to-buffers-context-v1-1-c4aad013d96e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-1-c4aad013d96e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 12, 2025 at 11:05:52AM -0500, David Lechner wrote:
> Add Context: documentation comment that
> iio_push_to_buffers_with_ts_unaligned() may sleep because it calls
> devm_krealloc().
> 
> Also document Return: value while here.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko



