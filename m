Return-Path: <linux-iio+bounces-21659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B40B053A0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C284E10D1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3B2727E3;
	Tue, 15 Jul 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiDzA92f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D942747B;
	Tue, 15 Jul 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565773; cv=none; b=OImrh4pqDWmTroUhsWDbX7hWCA7Bdcj8rxAnogdeqY3LaPQEfG2/45cn56hoeagMH2qC6qBMaFyh1M1IxeC/8xGK+qbxomX7dIRow3TvRiG8+MLaYRGy2aAIJFQmG9WiI24Kyfpf8Sij4wbsbAVJEtqQxsUD+uYH33+kmmItRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565773; c=relaxed/simple;
	bh=oBZ07qfMVSMe01x171T8SZ0u9bBNjip7CkgUBqbpGF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q83aD2VxjUmx2eVOcvEwGPDINlO+EeaIv+Mdn5ccwmBgb1GdtBsiS4k2JllPQ6RQ6LK0iDHw0+94OoAEb8cKDHSZ9cE+aOWw5gc7b+m13D4ENrwJnAoKL6xEqv0C0mFWSjYM+9JuZWw4JIJONMMaM9YWzTrIobP5Q6Et5nSYi2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiDzA92f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752565772; x=1784101772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oBZ07qfMVSMe01x171T8SZ0u9bBNjip7CkgUBqbpGF4=;
  b=TiDzA92f3zWmYgRr/MRmwCc0XQ2HaQq1IFwuWtKed27Rs8k1wFJJvF1M
   O7Cl6cG1VEMoJLVXiBNIM78fnrXUzlsAixxyxabev7TTFFCAmu1zlwdSx
   GRfhYi/KOJbERghhAonleG1ZE0pPslzCGxKMKZXskVLZeqyZ01MlrSG0I
   5Jt+XjwqyF4CDYmKH9tj02lF6TUU7QxOoGI8fXzfArWd0dbZ6sTKJ/hja
   GpufnO9dvYWE1Xe6v7//T1mRjNtRnlFSGo09FO3PXtlj5xo+e7TkIeSei
   oqCoHgtltq36UNxmlL790TqM2ySYXBvGi3dLMT+kx2rrDLmG/1xDj23aO
   g==;
X-CSE-ConnectionGUID: uQzLtWv8SKK1XzXqfXGQdw==
X-CSE-MsgGUID: F0l+2PTySleGtpEn/IwUag==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72225384"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="72225384"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:49:32 -0700
X-CSE-ConnectionGUID: saQUtYl/SMybI6jlBTPMrw==
X-CSE-MsgGUID: 7i37yP5WSzSCTHalMQ0TgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157689413"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:49:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubaPm-0000000FaVa-0NDs;
	Tue, 15 Jul 2025 10:49:26 +0300
Date: Tue, 15 Jul 2025 10:49:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <aHYIBReTFqJMtiXW@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:

...

> > +/* 9.81 * 1000000 m/s^2 */
> > +#define BMI270_G_MEGA_M_S_2				9810000
> 
> I thought this is MICRO...

Btw, what if we use the device on poles and on equator (or even on orbital
station)? I'm wondering if this constant should be defined in units.h or
even in uAPI that user space may add a correction if needed.


-- 
With Best Regards,
Andy Shevchenko



