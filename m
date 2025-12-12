Return-Path: <linux-iio+bounces-27058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C9CB9901
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70ED4300D029
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794613002A8;
	Fri, 12 Dec 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jeu15aaB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710630217D;
	Fri, 12 Dec 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564036; cv=none; b=UGOuZlARgCZ7kSQ/NiUQpJonXmi/LA9U5ZD0lJ+WIDiAue/smLnG02k7ewY3dTWEifRMMfub/J8A/e41XRzBlSXKcvSMoU90+29KAcLJu0ydfh5lXylWFqBdKDoK92QWc8aCy3VPCFgnrBrZIsrxYpkD4dVE45jTYPsoTGxhPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564036; c=relaxed/simple;
	bh=BnmxK/gHlfgVlrkPliVviBYlifCofWtiW/GWzSlgkfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKoq96xUdQv4XB3JcivXxHlYUCQmK9CsTqCGmKiQpQIljvMgprMGGV4WS4My9RypPvAe2u7aAZdm30x+4QXC9scYchkAffnDpG/mL1pN2t7A0jhr6Rj1A0SP44fxmFMWmIoxGeDrMImS/vLxuQAL8qNG/E8Ko6hIvhi1jKGaLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jeu15aaB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765564035; x=1797100035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BnmxK/gHlfgVlrkPliVviBYlifCofWtiW/GWzSlgkfM=;
  b=Jeu15aaBoRMYU/3Hru0Lz7czXjr/lyyiHkSbjbicMz0uQyj3UXCQh1ui
   H7k1ACFjHLA8gDCmaMoGT1lS1faPQrBWdUvlfwYBEZzEEnU6nXugwYlUm
   02G0aS8w1VyViYPHIbrkZN4YWK4XT6t/gO7/BiBoQn5wTwGMdYZzY2G18
   MnEaMoQlqMPuWGNl7D/G69qb+vvfm9VZPeSYLnrIwWpwnvpbL8nDIWJo3
   Of+z0T3UkvaMWpSxVMsaNY7LPjVIzg+LKB2UY4Fut4NQgkU/rgsJgu4Xz
   JFoOKhBBCLZgFluE9V+/LdXXHwYRFIa9XYsG3Fe2LO8QBwXukOP9SNasQ
   w==;
X-CSE-ConnectionGUID: ve/C4FiFQMig89xFqK77YA==
X-CSE-MsgGUID: bA5O7D0rSK2Xd3A0Hi09tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71200587"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="71200587"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:27:14 -0800
X-CSE-ConnectionGUID: gtWWtGVJRjm5ByqyIT+plw==
X-CSE-MsgGUID: oVbz2Yc+SPqhIF8D9n1F/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="197420834"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:27:10 -0800
Date: Fri, 12 Dec 2025 20:27:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
Message-ID: <aTxeexretB6w_01B@smile.fi.intel.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 09:45:21PM -0500, Kurt Borja wrote:
> Implement iio_device_claim_buffer_mode() fully inline with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.
> 
> To completely match iio_device_claim_direct() semantics, we need to
> also change iio_device_claim_buffer_mode() return semantics to usual
> true/false conditional lock semantics.

...

> -		if (iio_device_claim_buffer_mode(indio_dev)) {
> +		if (!iio_device_claim_buffer_mode(indio_dev)) {
>  			/*
>  			 * Replacing -EBUSY or other error code
>  			 * returned by iio_device_claim_buffer_mode()

In one of the previous files you removed a comment, and here it's still present.

...

> -		if (iio_device_claim_buffer_mode(indio_dev)) {
> +		if (!iio_device_claim_buffer_mode(indio_dev)) {
>  			/*
>  			 * This one is a *bit* hacky. If we cannot claim buffer
>  			 * mode, then try direct mode so that we make sure

Also check if this comment needs to be amended.

-- 
With Best Regards,
Andy Shevchenko



