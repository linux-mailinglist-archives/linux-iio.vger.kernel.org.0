Return-Path: <linux-iio+bounces-23648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDFB40693
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2D4E6FED
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56E307AF0;
	Tue,  2 Sep 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgbO1pKT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBD307ADD;
	Tue,  2 Sep 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822945; cv=none; b=htuJMUMT96o9tZgyizBEeDQtpXB/HXaUzaN4A8U4cVyJaBd7QHGgzFzJHjY1bSSdSImKARLv5WUNlRscNTsI7pTpwveOkRkl2PrqqQPjJqPi2B3gUZFFlPIbwOhu/EcWrcZhY+MK7jL3b6iO/jG9I8mKepY/U82Osf5HDax+YqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822945; c=relaxed/simple;
	bh=7vPtWCYBihfuIcyr+VnOlDRJLOdaMo4FCXxk1kuZ4pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyj7jHOzG17GN7VjvQQezNbLRq9/u2K3O0VLz7JVaEXz/sYPgdb4U3hxwSjx/Liv2bvT2k1d+tdqPVWt5xlsr177A0/rrNfmO/L+UNFqscSpVvMzU6o/0MGGHVz3jQp4kRpsEaKvpq7yQNoQIinuWl4aju0SQjxKcS32Aa90i7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgbO1pKT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756822943; x=1788358943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7vPtWCYBihfuIcyr+VnOlDRJLOdaMo4FCXxk1kuZ4pM=;
  b=UgbO1pKTQD4GCqUoukIhUxxmqeXICC10dH1InbCZ3GUj9suj5uwTl+EJ
   sq6RV+dwVDwpJ2emvXnutCacqhDEa5PbLK0K+10mZx9dHiZyBB4JOxeIA
   vcRfwf59MNHwxndM34mq7x+vEyh6xq/NPpIIJRS3qQ0aOh6SMbVohF+6Q
   VlTboM+JgC4iQc/b9wOO0OyG3WCjURneAu2Ue7l15MaC/tN4bqOdxkr5x
   Z6ef744osK49h1N5zcT17wQqCgc9qHvFE2UPdILP364S0TIchvf1u6Tzi
   fl8slSqEt/3XAMEg8pd6x5Fp7PIMYCsb53879eOMiA7PORuzQClKtq3Mt
   w==;
X-CSE-ConnectionGUID: PaOCY/qLQxaUN40FNM59wQ==
X-CSE-MsgGUID: wCl2dNWPSSuBKn/zSlvD7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59210785"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59210785"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:22:18 -0700
X-CSE-ConnectionGUID: IJM4YOD1QaCKr9bXeVH8qw==
X-CSE-MsgGUID: Ik+RFGegSs6RrXqQtW+0aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171668838"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:22:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utRtl-0000000AiMd-09Mg;
	Tue, 02 Sep 2025 17:22:13 +0300
Date: Tue, 2 Sep 2025 17:22:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH v2 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Message-ID: <aLb9lDzilIvkF-oZ@smile.fi.intel.com>
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
 <aLbneKXFd7Nc711T@smile.fi.intel.com>
 <20250902135404.GA145952@legfed1>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902135404.GA145952@legfed1>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 03:54:04PM +0200, Dimitri Fedrau wrote:
> Am Tue, Sep 02, 2025 at 03:47:52PM +0300 schrieb Andy Shevchenko:
> > On Mon, Sep 01, 2025 at 07:51:59PM +0200, Dimitri Fedrau via B4 Relay wrote:

...

> The explicit formula in the datasheet:
> 
> T(degree celsius) = -45 + (175 * temp) / 65535
> 
> The formula before the patch:
> 
> T(degree celsius) * 65525 = -2949075 + (175 * temp)

Then embed it into the comment.

> Adding the PRE_SCALE into the formula doesn't improve readability from
> my perspective. I would prefer to just scale the result as it has been
> done before.

Up to you, it was just an idea. But in any case that 5 should be explicit (and
not hidden in the precalculated values).

-- 
With Best Regards,
Andy Shevchenko



