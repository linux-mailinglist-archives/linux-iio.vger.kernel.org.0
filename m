Return-Path: <linux-iio+bounces-18232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4401A925CB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16DE467C41
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A9258CE0;
	Thu, 17 Apr 2025 18:05:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE391EB1BF;
	Thu, 17 Apr 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913150; cv=none; b=hrVzhp1LGHS1r8Y9Cq65XReM6ZcjIVeiyb4dfDIDzGYQ0vlQHPvjlILnqLhBmnjtaicBrmD5IZ0rg0xz6j5em53HgkqLDGvok/wHj9XxqTb5J+D2xVzbqySsoYCFP5Jr2yLq/dMd81JX3QNxOlhMlfpIx4vExD+VfZ4yZ6tAoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913150; c=relaxed/simple;
	bh=WbPXtrJD4e+1MerB5YEGsdmrV13j1pGb7hyI6GVu36Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbETxbiZlTqp32+0NET9PiHL6SQx8b4UYCftmGcNyPWhCIX0RvWJlB47TyzxX3eXCTrybcm/YhFJXAh7yotTC3l+DNuJhgo86Ff2ccWX34Bd6IFSoBJTrsaGS7qhV4fEVTtM9GkR4V/qCYsbXK6TqWUQ6y7ei2j45VhQ7DtTHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: QOFXU/LwQYqJo0FGpik9Lg==
X-CSE-MsgGUID: +CFY9vQ0RTSusHEEDU7YTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46532036"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46532036"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:05:47 -0700
X-CSE-ConnectionGUID: jvbAVVcRTyWpNKwlXETWVg==
X-CSE-MsgGUID: tE0oBpFAQhGv3V7jEkqq3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130658952"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:05:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5TcK-0000000DH8g-0xU8;
	Thu, 17 Apr 2025 21:05:40 +0300
Date: Thu, 17 Apr 2025 21:05:40 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <aAFC9FsTRNya6eDU@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
 <20250417184716.000044bb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417184716.000044bb@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 06:47:16PM +0100, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 20:01:13 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> > On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:

...

> > > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Also no need to sign off on cover letters as they don't end up in git.

It depends if you use `b4 shazam` or not. I like that feature.

-- 
With Best Regards,
Andy Shevchenko



