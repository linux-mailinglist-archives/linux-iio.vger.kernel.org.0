Return-Path: <linux-iio+bounces-19834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A4AC27DB
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A59E33D1
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6B296FCE;
	Fri, 23 May 2025 16:47:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F77296D39;
	Fri, 23 May 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018821; cv=none; b=Z/FgnqjsKqwBZw8yUXja4Jg3pauistMO8YHH6zbxUTQiOMJfIE0ZTlny3ScTtnYnozFz/sn/Cb5ip0hDfMOcISa8GirPbiTSjnhFyloc98cFQvqCFhzFTp2AR7utlktlF2GlrkEQe01ClRddO4r2Zj/Fd0x3hQ/hMrZxYqnkfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018821; c=relaxed/simple;
	bh=Uhmtp+Gbg4WtQTjM7S4GtbBUzVeXfN/QJFZGSDsJKgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWfJABgYupI1yD7oJ9m0G2bpEOubcP0tPRRudqNuCKYyvOdgsFD9siKra1/Lr6FAm4QUDQ5ZcYvsD9K+HCdArqVZT3MW4/zsuHOiVaaT27DXkjBq/ucVDlTb6LwxvRMf3E9Nw0hHxi7hi/ULkGOSRayyWSX1CBXJwwlQLtI3Vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: LNGVVzB1Snu3KMt74K/zwQ==
X-CSE-MsgGUID: qlL3TYRtTZWUAXGbTXhHFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49784584"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49784584"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:47:00 -0700
X-CSE-ConnectionGUID: iNaZ7ByXS8GuaxJ4vPV6mQ==
X-CSE-MsgGUID: TmNeov7BSWuSKY3nIRAAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141101049"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:46:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uIVXp-000000006eU-0qpT;
	Fri, 23 May 2025 19:46:53 +0300
Date: Fri, 23 May 2025 19:46:52 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>,
	maudspierings@gocontroll.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Christian Heusel <christian@heusel.eu>,
	Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, dsimic@manjaro.com
Subject: Re: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <aDCmfLwMisBUvBo2@smile.fi.intel.com>
References: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
 <20250522181236.00006dda@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522181236.00006dda@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 22, 2025 at 06:12:36PM +0100, Jonathan Cameron wrote:
> On Thu, 22 May 2025 13:18:55 +0200
> Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org> wrote:

...

> This change is good either way. I'm just on wrong computer to pick it up
> right now.

I have a few nit-picks, please take them into consideration as well.

-- 
With Best Regards,
Andy Shevchenko



