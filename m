Return-Path: <linux-iio+bounces-20553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85903AD712F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D9C189A563
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902723E331;
	Thu, 12 Jun 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0cmMQea"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920E23E226;
	Thu, 12 Jun 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733628; cv=none; b=usbbdo71qCnnxn4HfCwMLsw2vvSzC7a/ZK/qdNzEchU1355781Aa990wizW2dn92Pxb+iEbRFGUoCk/f1A1OLOW3uDoE7e4tdeYvJiYgPye0LgjInuyF1C4B0/5prSFgcXASh34JsuTvK1P0bwQ1HCtvqBSw3F5nSbwxknMeRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733628; c=relaxed/simple;
	bh=b2uoJenuIadRdUzklRixfpgQJpTouQdg8CrCSmXvppw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFQwbHTf1w8YlEx2DnMSn7RmKY1jO+CsAZ9OkliV8TFvrIKPGI1McyRD9oTguBiJ9s4I3l73xMhMebBPn2d/GIrp2Wjas9mCoO7ldHKo6s+1c5WtB4vUY8v1Qew7u319uwEy0E3iFcr2bG8RNnf3TXUx8hX+kQIsi3aP1zmkoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0cmMQea; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749733626; x=1781269626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2uoJenuIadRdUzklRixfpgQJpTouQdg8CrCSmXvppw=;
  b=S0cmMQeaZBgSwMD0qSgLP4LykQWKynlRj0HrPOKyBUXsNO7H0AkSuOhj
   gimzAkkYlGCF5cc3aQRd0NPHtpNKVLx8extGGtxlEhU6/3nKDf/HqwZcw
   TYOUeANDKxWp8FsdvGg3gfLit5rNU6e00Sbb8S/uQ1Pc0FYXEzPfaXEw9
   CP5uGq06Ot2LEciXFpcvZiaAcSVbJIA5AUIAjRMmqGsWqIJXoV31hIc3/
   AuUEwARoPwAO3fkyEX6SfDa/BohUyuEJlk5vONGIisZN7j5udwqhAUqaS
   THZOfkaXlicIEVcYlEo8pDzbKSq0RW9c9RSdYC6LdDh6QXpZD0/pemT97
   A==;
X-CSE-ConnectionGUID: q8CZhLcnQKKkARgxFGCwhQ==
X-CSE-MsgGUID: Bj3pM2WJRHC0fAxj0dJMog==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51018324"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51018324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:07:05 -0700
X-CSE-ConnectionGUID: KfL2ht6WREiV8ATuC4ZI6A==
X-CSE-MsgGUID: jbgVJTdZR2i+1UCJQ5fcSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="178490486"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:07:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPhe0-00000005xKY-0zo5;
	Thu, 12 Jun 2025 16:07:00 +0300
Date: Thu, 12 Jun 2025 16:07:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: amplifiers: ada4250: various cleanups
Message-ID: <aErQ9AM_aZRTr8eH@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:33:00PM -0500, David Lechner wrote:
> While investigating some potential bugs, we noticed quite a few
> opportunities for small improvements in the ada4250 driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for non-commented patches. Otherwise, feel free to add it there
if my suggestion / assumptions are wrong.

-- 
With Best Regards,
Andy Shevchenko



