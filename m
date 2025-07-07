Return-Path: <linux-iio+bounces-21440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E01AFBBF0
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484451AA8321
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E018266EEA;
	Mon,  7 Jul 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvBTrtLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA972E3716
	for <linux-iio@vger.kernel.org>; Mon,  7 Jul 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918031; cv=none; b=Qkg5khfUaMOy14As4p+mTdb8iAx+DCQbf3y5f7+bRtXW9+KmqFavrCBX7r38wjelne+nAt/pN54IFkR3Jf8rvHRjWV9zBlL92485qwxKJQacPFp7fSoraRmE7jPozHqLdhE0SoC8mE35F+y/W/ZrnAQcVGEGagzXAr1iMUCKapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918031; c=relaxed/simple;
	bh=8u/JoGPFZbQv1YeDJomOEqQyVO4pzI8xl321AwZORd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTwrmR79gd2L+LEZRVwUoiLlv5+FcXrHZwgJQ1EECpL48ByxqZG5v1iAvo7C+56ilcvvHsqh9Y6C8u7XgGnswL2CIzY9Qctyx6NNmNLEuWonnfc+0UQMmiOFsU1H/A2+Y+e0ixZ9W+ngRqMO9mgPK/qqc7owNmv/OfSeB7Gpe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvBTrtLl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751918029; x=1783454029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8u/JoGPFZbQv1YeDJomOEqQyVO4pzI8xl321AwZORd8=;
  b=hvBTrtLlDBAxpFrr+DSGsRPkkSLN4BLvb18Y0+EoWmILjvzPPN0LpXUP
   LxteAlveWuiEVKK3sBZnk9nQ1SppzhmlX+OyOcxKlQtXy3toOrRg2sbEx
   g8nfNmBX+k7TmXkBn1AljfXequ41T2lrmA3v7EAkEOVLLsYaq1cDInayO
   jurJYCwT8x4HMI91TXVQZcznpDKBe2UEPwD/1JK745U41WjWfcIOOMMhg
   Qc0E5hYOP0r58Fmfe3ajcgrMoXp5On9+FmP1oeEIRFV7UyX+HvsrHGbUv
   RdIekMkN0i82BB0i5FZYxnXXP5sCMyNpbu07xE347JrMPyURi53j/H9U/
   A==;
X-CSE-ConnectionGUID: llTvZRGIRJiQBwoW5kbiYA==
X-CSE-MsgGUID: LfFCl17USSivEIDDsyy2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79578982"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="79578982"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:53:49 -0700
X-CSE-ConnectionGUID: oU4stBTKRJKLwkmgO2kimA==
X-CSE-MsgGUID: FhoVVXxES0CsPDMY4D7P5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159578513"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:53:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uYruK-0000000DNsl-0cuw;
	Mon, 07 Jul 2025 22:53:44 +0300
Date: Mon, 7 Jul 2025 22:53:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <aGwlxyxRSm2WLXor@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629183649.184479-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 29, 2025 at 07:36:49PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Motivated by the W=1 warning about export.h that was introduced this cycle
> this is an attempt to apply an approximation of the principles of including
> whatever is used in the file directly.
> 
> Helped by the include-what-you-use tool.
> 
> Reasoning:
> - Drop linux/moduleparam.h as completely unused.
> - linux/array_size.h for ARRAY_SIZE()
> - linux/bitmap.h for for_each_set_bit
> - linux/errno.h for error codes.
> - linux/export.h for EXPORT_SYMBOL*()
> - linux/math64.h for do_div - alternative would be asm/div64.h
> - linux/minmax.h for min()
> - linux/sysfs.h for sysfs_emit()
> - linux/time64.h for USEC_PER_MSEC
> - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> - asm/byteorder.h for le16_to_cpu()

Change LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



