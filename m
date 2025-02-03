Return-Path: <linux-iio+bounces-14891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01895A255CA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8519F3A27DF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4971FF1CC;
	Mon,  3 Feb 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiprw07e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6441D5176;
	Mon,  3 Feb 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574793; cv=none; b=cxFCsS3PSubBYxGjA8kDT5tZfPzM/qVu0+ieWeMbdYIc6jds3Ep7fWxWI/f4c+mHZEn15trXba8kIgjHZ0tlqqHgW3iXjf9TaSAWAYnJC0L/YrFlKdWaFhI499Ge9OhDFkwvfuRYYTZTnbLyDqkDvLy98nFKUzdh86I2IMoRiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574793; c=relaxed/simple;
	bh=lWbhg0d58hHvnjbqc+RnU2QJLblhj1IYghf/LLx0eas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dihK2Jmsj7NLWnFOVPMbIxdeXLu6iXPu8nIs2w/i3FdBvhXuSAhRKcNJhEBCt1W148ebU64P4IaNN6n9f/Xf0XV/ooQKFTtt8yVwK7z0C663K5/jAS0tpcChMEjAQdnDNYb+srGO7epWuwBQeY+rbaoXxEUg+G9KSHSD8+oYS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiprw07e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738574792; x=1770110792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWbhg0d58hHvnjbqc+RnU2QJLblhj1IYghf/LLx0eas=;
  b=jiprw07eMWdpI3a0TK96gfv0YjVE1C1R27ZcrgCXJuTpBaXHT2A0+yLc
   E8GvYj79n/ILrp965zz0KveYi2Mpk92xPhClK6auZKQibkh968ks2Xtpc
   gUafMqDYAExQFmZ0eWL7ORu/PQ2D5YiUY+4Fq4V4j3wGdpH7U4vMY9PpD
   Ajeypc03WBxXuWujrlQ9yq4TgKuYZCSXzocej5QIOqjXqEw20iuEZvH7i
   6Hpwl9s2vE+1D1/KGl3q4wQFeHWWrfkDeOfF2ZqlTXz6mU9zUoBlCR2/v
   5A7jOnAbRpzYP629ZpX35tOiPmubmnYE1PtiMR1YM7QvI1/MuQn01NPhB
   Q==;
X-CSE-ConnectionGUID: OOiHB/i2SIa7dXqrVK1eqg==
X-CSE-MsgGUID: 9+XEzN25TvKLFkeJG98EdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="42810423"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="42810423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:26:31 -0800
X-CSE-ConnectionGUID: t42ZCSeaRJmMha3tkpO8Mw==
X-CSE-MsgGUID: Tk29/M9ZT127P8BKJrxz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="115261751"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:26:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tesip-00000007mfw-2CT5;
	Mon, 03 Feb 2025 11:26:27 +0200
Date: Mon, 3 Feb 2025 11:26:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: si7210: fix magnetic field
 measurement scale
Message-ID: <Z6CLw5h5EwDGanl-@smile.fi.intel.com>
References: <20250202100709.143411-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202100709.143411-1-apokusinski01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 02, 2025 at 11:07:10AM +0100, Antoni Pokusinski wrote:
> Applying the current scale value to the raw magnetic field measurements
> gives the result in mT.
> 
> Fix the scale by increasing it 10 times, so that the final result after
> applying the scale is in Gauss.

No objections against this change, just wondering since these are
the ABI changes (correct?) how should we really handle them in case
some of the user space stuff already relies on 'bad' values?

-- 
With Best Regards,
Andy Shevchenko



