Return-Path: <linux-iio+bounces-27940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388CD3A104
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465E430334C9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A533B6E7;
	Mon, 19 Jan 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnoEfbtb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368E33987B;
	Mon, 19 Jan 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810253; cv=none; b=EZn9uBvp3sV+D9CSr7JmHfzBoP3ylLQJjIWsTT83uQjXM4w1oSe5sebbTorss4YXGswY+U3WpsP3VV4AwAA853t/S3URizVwHedCeVjXqvPdRz1GX3QpatSAWsEcxYlUw24Qjg00ezvj+DZ6mwvHvYnjhVdLL1SrzMKSnvKnvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810253; c=relaxed/simple;
	bh=F1vMlxTxIBvXr4xjJ6rZSlJtQjZ/3UUSEbgXcrztJDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbAFXltHJlVFym8zPP0jFq0w49I2GrCN19MMo0uT72/vbJmShH5XokdrWKxD2fTtWmFpWUxnkikRWVDmDOgsanUlaFCItFl1BeKa6w/L7/c8ssdWTyK3BY9lrhvxxXS8WY051A6WsnRwV4gPtsHenDytGzb5XbqO9p6mSHO8rVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnoEfbtb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768810251; x=1800346251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1vMlxTxIBvXr4xjJ6rZSlJtQjZ/3UUSEbgXcrztJDs=;
  b=QnoEfbtbWL/LncdM47UiS4U1ZEOMO17uxkRdqp0PNh/Ck8nHEvJGrw6C
   78Tw3ZHhfaf8H3LhLax+38F+z5fSHY9KsNKzsDo0UUBzNea9SmTsUb3Dk
   ckyioVW8UUiTVJ8p3QLoweXDq51dFFfiXYRedAyv89fLiveA1z3hmvEWA
   RPisKq45ahvhIEBNZnRI3CL8KfEfo2yTMcCpF0o1LoPIu9VinbMbuNicP
   x2CbEETKEmxN02ahE+zwogeCGXT8Iq8ANI6ts6Riefy0t1GTEaPOTLnOH
   aVdGdXBU2EpvE/3EcXYc69hORP3v0MMc/YoonGzqFWr9KtgQZEtbS3UND
   g==;
X-CSE-ConnectionGUID: XMbofhYvSeipRKepSwsh6A==
X-CSE-MsgGUID: fMg+bk0KQW+DaJ1S3Ur/zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73875205"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="73875205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:10:50 -0800
X-CSE-ConnectionGUID: KbyUq3R5Q8eu61yyoGHQYA==
X-CSE-MsgGUID: kllHhd29TuiifdHExApbGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="206160899"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:10:49 -0800
Date: Mon, 19 Jan 2026 10:10:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: mprls0025pa: remove error message
Message-ID: <aW3nBgx_325IhDEi@smile.fi.intel.com>
References: <20260118-mprl_driver_followup-v1-1-5d5d6b03350b@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-mprl_driver_followup-v1-1-5d5d6b03350b@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 18, 2026 at 01:19:39PM +0200, Petre Rodan wrote:
> Do not print a duplicate error message if devm_request_irq() fails.

> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> A tiny followup to the mprls driver cleanup, as requested by Andy [1]

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



