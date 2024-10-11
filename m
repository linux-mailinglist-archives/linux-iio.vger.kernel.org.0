Return-Path: <linux-iio+bounces-10451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BD99A20D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECDB1C23548
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D652141C3;
	Fri, 11 Oct 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGhvySuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114D2141BA;
	Fri, 11 Oct 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644092; cv=none; b=kfvntX61VjyfpN9jNMXG51ALZ9KqaLXWi1hqAfpEdvfPgRJwIXQmLirnA77RK7wGQYDvmKCqksM8soH001hfagbFw+l40wfsZBltLwfYfAYnY1kVpzIuMWb/+URrpu72rQtHFqpqFE9QiwTeOXTglfuW+LXl50Nx/CnjtGYOzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644092; c=relaxed/simple;
	bh=0KOKAhCgsCevJee4BgP8YIJB1hQodgg/8jSRCEcfAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A36Al538h65b4die5PSg5sVoGqLFXTjqtArU+HCJvWaGS5EHq8Q1AH5xdHe7z8Sm08QSBpE88UdGf+5hfrt7ptRmsQBGrKbKUP0Mc2WiAk88zwSt5IvkbVvljFCmqb7GwDtAwdwxrpmi/pyLLeCqC6ofYsDPBeLibMuugEqN45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGhvySuU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644091; x=1760180091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KOKAhCgsCevJee4BgP8YIJB1hQodgg/8jSRCEcfAl4=;
  b=XGhvySuUhQzETLNumjpTmgvXykpwxZab0AfMq+WkyTEbPeL8fYJSF7ZV
   uNV6JWBmMM4u8DDw0Fb4cT3XkYsK4wxkLJBZxKk77r5BNHWKwsbPOob2T
   I5XZ80xYzeIwpMVqLk+UFURKErHImuBkdG7OOVcNZMHGazLrOp9vomLnu
   naU8kzdLSOj/ydF2d8udXiEPpt+Qs7RhY7NxLNhZT8PT+CiMKbZKTC5w3
   Dmn4fRB59j3zoUuwvap5ACPXlPclPp8STy6t5IaLIC4VWX3oarY6os4zw
   sR7QdRT26u7k9MJDRjQdBSU/JGvsG/l1stTNPhN6FfzyH9sGbKx/S3rNg
   A==;
X-CSE-ConnectionGUID: jQeWDQamRXCIw2a9fBHOTg==
X-CSE-MsgGUID: AXuhQ1CBQ3CjyTsBr5GFkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="15662686"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="15662686"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:54:50 -0700
X-CSE-ConnectionGUID: OZIz0QrrRvWccFrx1xCAzg==
X-CSE-MsgGUID: PxQCfAhwRvGI8ldeFJ7V+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81665080"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:54:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDIA-00000001rlO-2Ab0;
	Fri, 11 Oct 2024 13:54:42 +0300
Date: Fri, 11 Oct 2024 13:54:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
	skhan@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] iio: Fix uninitialized variable
Message-ID: <ZwkD8hXNWcL0z4Cr@smile.fi.intel.com>
References: <20241011093752.30685-1-0xff07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011093752.30685-1-0xff07@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 05:37:45PM +0800, Yo-Jung (Leo) Lin wrote:
> clang found that the "offset" in bmp580_trigger_handler doesn't get
> initialized before access. Add proper initialization to this variable.

...

>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret, offset;
> +	int ret, offset = 0;

Can it be done closer to the actual user of it?


-- 
With Best Regards,
Andy Shevchenko



