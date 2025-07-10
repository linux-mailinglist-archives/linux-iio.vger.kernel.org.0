Return-Path: <linux-iio+bounces-21520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD60AFFD79
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AF31C85994
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BC22A7E5;
	Thu, 10 Jul 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaIf7yaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C722F3E;
	Thu, 10 Jul 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138214; cv=none; b=XQ6SyLGkQ8Tm+i87yre4rzkpYqPjrLDoC/R3wEe2W/CuTJsQMLoVkIE/KZDPzuhPA/y4DXR3BdMetOJE2vYkQbcPUKjs/ZQuY43cAhHZgJuMA6X+78OsUkdPMfUPgQcmO8mrR13jXQC4NMQ0/t8A81u8DxNML/Voe9kI24H4fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138214; c=relaxed/simple;
	bh=j8Phv+9pRt6mRGClp582kQe91XOLKsvw5FUGQNmKXig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6JJ6wrz7yNVKLDFmfDyFesWX1VJONO9vhFS0qPJs6pNImNt1kPqGD3KkPKyIBmcLvGOgwymnZLj+t5R9O9Bubn1wLO7YwNCSaNBBeNfG7sAXc5DmIht9v/gKBzf8d89SpKc7Qha0axjZzmSxqTce/UvZFJCYaqwX0nOp9Q+6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaIf7yaE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752138213; x=1783674213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j8Phv+9pRt6mRGClp582kQe91XOLKsvw5FUGQNmKXig=;
  b=UaIf7yaESZvioQl6EDfOb8dF0wxMAs8rdhfZNtBiLW9rkYTG7B/GIPc2
   z1++TdzxNNzPu17y2Wva33pmLCRlEoOlzWSaB5kJBPJr//P7h7Z1I4Jho
   CAVUoZ4pcuF54br0URtAZCPAaHD7hNXsfUQbFlSzNbvy54ZQvWl7hMior
   jgSeAIG5U7HKtMJV9KH8K3BuJjN4SD3CfhuCyqmIrMlrS4mPo5HBRj41N
   uxe85y532oBnEJg9Z+EzaOLPHUOUgkXONOY6ZJFEazzYoH23V4ZdnuUDb
   SV1xrau//ZGTG0VAujX5UVWcC5T8WKGwqSSsK/05wRpk+R1a7tF0H4bLH
   g==;
X-CSE-ConnectionGUID: MF7Bw6e4QYGibwCLT7X6aw==
X-CSE-MsgGUID: S7BU2K3TSsONVozTMRWLJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54541932"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54541932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:03:32 -0700
X-CSE-ConnectionGUID: 34O0i2HBRF6xRFM2UmCbRw==
X-CSE-MsgGUID: 1HQ9oNu/Q3iCKwLtTys6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156142383"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:03:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnBe-0000000E9Os-3yNh;
	Thu, 10 Jul 2025 12:03:26 +0300
Date: Thu, 10 Jul 2025 12:03:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: imu: inv_icm42600: Remove redundant error msg
 on regulator_disable()
Message-ID: <aG-B3uv6SsP1Ap0U@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
 <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:35:11PM +0200, Sean Nyekjaer wrote:
> The regulator framework already emits an error message when
> regulator_disable() fails, making the local dev_err() redundant.
> Remove the duplicate message to avoid cluttering the kernel log
> with the same error twice.

To me this sounds like a potential backporting material as it might full
the logs (in case the module probed-removed zillion of time. Hence,
I would put it to be the first patch in the series (yes, it will involve
to fix something that you are removing in the following change, but still).

-- 
With Best Regards,
Andy Shevchenko



