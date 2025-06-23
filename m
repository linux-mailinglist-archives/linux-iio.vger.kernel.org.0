Return-Path: <linux-iio+bounces-20886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA51AE3635
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCAC189286B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473F1EB5DB;
	Mon, 23 Jun 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRBcgby0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CF45948;
	Mon, 23 Jun 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661428; cv=none; b=Kc/Gbju/jROYO84a36gJ9YvMCTbr+sXMtL/Mp3/Ind72Eu1hx7bQcBjQrbZmLf5vk2QLIJKAjhPU2rZ97SegmB5RZZ7E7a4oUCAgQeRzSeKeJi7w7Tj2jo8jdZPhUe65SjENrpFFOOZmjpkkUqT6qW6zUaE7/8RYFMyYM5F/Me0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661428; c=relaxed/simple;
	bh=UbcP0cmmfsC3C6N2WW8XNuMzgOKu5ngUqMV28HejEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK7EW264agStuP6sSyHhhJFAnJnXUJXE+E7NWuxIHckOc+rqPrt6XD4C1KcFbppL7hw4uedePxsMzzXLtG3HIzimyu94G8H1Y8mPXqHGPzFBCIi+D6/YzcbX80Xk8uTsWODUu/lh+ZRw9zMSrV2+DkLAOhRuA/k+2hLzFt/2hQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRBcgby0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750661426; x=1782197426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UbcP0cmmfsC3C6N2WW8XNuMzgOKu5ngUqMV28HejEJk=;
  b=fRBcgby0VJ9kCNF4E7VF/S9gqoqnF37Fvi/gaNcl9akfW+C38dreBf6J
   Rgw4ZXgdeX3E0futE6H/zZDCJEQ0ChVKi0+/KZ9vwQ1P7F/0h5232ke6A
   /cNOga++I4Y10FTnF7uiWLnUt+0gC5WV1PwrOUoSf9sJwsz1G3W3L3rO9
   k+pK9iKTTl0vTMyusa9JlVNyNJpGwIR3P4LKudmGVEFoCiBcAkUdA5lWu
   obJAPxLdmsPN95FLqLzg2+dYL6jPN4Rx71YjravAnnyjRnm1sA4LPrltc
   NvFCbO4pjKOdjhH+3Le+NKzbTMpNdF3PLVRQgHLjJ04+Agr/d31a3tOQ6
   g==;
X-CSE-ConnectionGUID: 6R1DUhXqRf6DQircYCGXwg==
X-CSE-MsgGUID: jAoEyVr5TYe3tpVzpah2oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52991935"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52991935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:50:25 -0700
X-CSE-ConnectionGUID: +re5Y0YfToC1nTqiNs4yHw==
X-CSE-MsgGUID: zZMCEPxSQBq65qOLm1B5ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="150983125"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:50:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTb0V-000000095Ss-25lZ;
	Mon, 23 Jun 2025 09:50:19 +0300
Date: Mon, 23 Jun 2025 09:50:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: adc: ad_sigma_delta: sort includes
Message-ID: <aFj5K2iBOt3cGPDv@smile.fi.intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-1-0766f6297430@baylibre.com>
 <20250622153733.44eca388@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622153733.44eca388@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:37:33PM +0100, Jonathan Cameron wrote:
> On Fri, 20 Jun 2025 17:20:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

> >  #include <linux/kernel.h>
> Andy normally points this out (and may well do here) but in
> general if we are tidying up headers we should try to drop includes
> of kernel.h if favour of more specific headers.
> 
> Doesn't need to be in same patch as this one though!
> 
> This is trivial and correct as it stands and would want to be
> done as a precursor to any actual changes anyway.

Yeah, kernel.h in the (leaf) drivers is a red flag to me.
But replacing it is out of scope of this patch and may be
done separately. My only point that please do it rather
sooner.

-- 
With Best Regards,
Andy Shevchenko



