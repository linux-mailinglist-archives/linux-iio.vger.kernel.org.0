Return-Path: <linux-iio+bounces-21228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2253AF0D7F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11D51C22DAD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 08:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A45234977;
	Wed,  2 Jul 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWCnhzsb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CD10F2;
	Wed,  2 Jul 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443775; cv=none; b=BYe509nvQTimzcdOAgHhBw4hcGqOCt7DGh3bVYRRZFXfXqHZ7yPoyit4jIosrD9TNJVpqXgzp2IUHig8h+eiOdbvdo7cuRGp8+NZV8N4AGEehfwQsTIwNo2akAb/6RXktZO9uEGaPZEWarbVWLAduBaHT9vT+BD6WJ6t8qMbdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443775; c=relaxed/simple;
	bh=W3WtiGVMoej2dClcyycFXyvtl2tDGQxDlRcj/pqxQCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMtVT8/8VLRLmyCUzsS2tX8MAN4YN5HbReYbmn4wvpwC4q4C6tu7WRWPl62TEInFR0KSXBxdC4JZv1TvsR7lOMhVbiKS7AA2M/zbi8AgJ6tPbxU3JbDP9TZ407bjBWfBLyFELjXu5hbJ8CoV8xPIH2Z/hcHjuEVUHz2ZlNTPyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWCnhzsb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751443774; x=1782979774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3WtiGVMoej2dClcyycFXyvtl2tDGQxDlRcj/pqxQCM=;
  b=cWCnhzsboAGbFbcfqej5Bz/6qkD7ZIiuliBRDZUMu+PrvN+vlyXPOtwf
   p9CLkTwtl63kB0bKQaFYSuq06hKhfwxPr/+/NU7aaikSGxyzI1UccQlWC
   RjKRVKC2c8hT0BNp3n6j/Ti//BwMUIZVTCv18xO3jA/XfsB+6T9fjnVmN
   UIN/RiH2pMlyaKuV3oC1m++Sv6306loNT63aJ+MaIIBFieg9ImUWtRWxp
   sl539AP1WcmQxfxrQ2ML8UxMbtodBp26OgLix6VxAUeMBocl6EkIZgrk+
   2Es/HJ0BsVTiXAZZHR+5JPwIqcHkyUaqviDO6xLM7cAwoVunaoQptvKr+
   w==;
X-CSE-ConnectionGUID: kWx/J+nrRQ6QhM4LbfAiEQ==
X-CSE-MsgGUID: wi/ehwPdTJqB3PXJv/iSUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64327646"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64327646"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:09:33 -0700
X-CSE-ConnectionGUID: WDR9/GeDTqqoty7c+Q5vHg==
X-CSE-MsgGUID: qyIzbNiJQD2hCMlHTpOzZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153409030"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:09:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWsWy-0000000BrQP-2kwL;
	Wed, 02 Jul 2025 11:09:24 +0300
Date: Wed, 2 Jul 2025 11:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
	lgirdwood@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Message-ID: <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:
> Hello,
> 
> AD4170 support v7 comes after testing the driver with even more variations of
> channel setups. Signal offset and amplification can be tricky to grasp at times.
> 
> Thank you to all reviewers of previous versions. This intends to comply with all
> comments and suggestions to v6.
> 
> Same amount of patches than v6.

...

>  6 files changed, 3601 insertions(+)

This is weird. At least patches 11 & 12 have '-' lines...

-- 
With Best Regards,
Andy Shevchenko



