Return-Path: <linux-iio+bounces-23575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78132B3E258
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330913B97DC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CA247289;
	Mon,  1 Sep 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2WsIwII"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F02226D17;
	Mon,  1 Sep 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728693; cv=none; b=KnDOjKPm0YoJW7+dwC/i2Nera8Yh6oyE1YEKa1u4jOVq7PuiQ6liv/ExNCufW7J2XK+pdeK5dwq8tnMgc9NnlFFZEgs9UhPU3Jj9x4gsT0/T0n27Co4+HE6M2H4VrEtzRGbjMfbg7UmKfM2x6AMHoWWsP5SUGNXoMwFCP+KS1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728693; c=relaxed/simple;
	bh=/C/aW5THE62pm00uxDi72V+HNmlVGDqPZz9wwAE3x40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+VWERShbtDYUejIdtBqO3w6uyeKZUs1OCoV1unijj0GUyg0v7g+3dQG2HKy/hPMt3SM0BF7AZO8NpwkyzKzLjlvC7Rk0EGzTnrMdCI5uyJBFR+cPR4CcnHojPjAMauOeqFFzhdJRWPKWNOm0X+3MeWC02iUJWSSZYGffDb2EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2WsIwII; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756728692; x=1788264692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/C/aW5THE62pm00uxDi72V+HNmlVGDqPZz9wwAE3x40=;
  b=D2WsIwIIX+FqqnurxrfVK1PB6NgB9omrIrCgRzBwy2Ml3Ucl2LjfDCax
   RbAoN0CSTE/nvAB3Pzse3GuVamrDTYAULKGGtcqe8RTOrx0ZJMzSfYJMJ
   O/q6seEHw8werFp6F17d6aognDpcyaL+PgmNLUD9LrIxFC5EcOpT4fe1M
   4mr/nICe6NCq/Io1e4dWmKZp2rkOVmfxGmsL/M/bSgmKaPGiyytNHsZ8C
   mnqedgpw98L1u3/vNVUf8r/RRN9c5ne46LGKZv+c+y8ApKgOqRvcvngJn
   kB6715+YUN/Ogxkp/J7QEGtNmCpfL+/Aw/HlQMWn42WJSIx8gVSr8oZvx
   g==;
X-CSE-ConnectionGUID: veExn+yaSfGbB64SBJ4OlA==
X-CSE-MsgGUID: kLHW+s99QzCeGQtkNdgurA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58013962"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58013962"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:11:32 -0700
X-CSE-ConnectionGUID: tnqWfgWNTUqOPqBMfU6fmA==
X-CSE-MsgGUID: DDOyonw9RPu7n9l/LqTk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="176248340"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:11:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut3Ne-0000000APLS-2b0Q;
	Mon, 01 Sep 2025 15:11:26 +0300
Date: Mon, 1 Sep 2025 15:11:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLWNbm5rNf8GRxwt@smile.fi.intel.com>
References: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 11:07:50AM +0330, Mohammad Amin Hosseini wrote:
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.

Why not using cleanup.h and guard()() / scoped_guard()?

-- 
With Best Regards,
Andy Shevchenko



