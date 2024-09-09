Return-Path: <linux-iio+bounces-9372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41F97135A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB597B214FC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F31B3F1B;
	Mon,  9 Sep 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgygRLrj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178511B29DB;
	Mon,  9 Sep 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873669; cv=none; b=Jn/hiPtTtv1loIQNhwCb8PX1WY0Q9YOx2tkoUmd9IVfAqCKBNqW9aur3HcHEXMRanS6dsnUKXbkrp+GU+r6mwDh9PkUtX33pF//buRvFvDglH9f5jejHPKXbQa3AXQ1GDoMaRzjCEJ8JHgPnQBVT9Ffydqh+m92ZNFDsJG4J8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873669; c=relaxed/simple;
	bh=s3jEWZOYuHfV2vzlOWQfX/1t9M56mpfKiOXIJ/6aPU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOtSMlg6DjNDszVH3o39qtON1RCYrpuwlXA6FGDel3e/DKQ5ZiYQHbXOaoGXK3LnqufJdoJgqMuJuZsbWc7n3NyktK/FSxp0C78E2g1cnphrQe8YWGRJpVN6zARv3sT3YG6gznjuCMGpDRg894tu78Rf9Xu47dUmZUfn+b7D/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgygRLrj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725873668; x=1757409668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3jEWZOYuHfV2vzlOWQfX/1t9M56mpfKiOXIJ/6aPU8=;
  b=dgygRLrjqIoVS3iICAO8KJ+SH8HA2J5SPLGrFKKdqj3nlAH57ufPdS3h
   yrYRyxcuVJNP3XqW7qjzXKKwqMSQzoEVWUA6FCm4HzPG9uKeyvKomkuoa
   tIjB8DwG4I7CuR1tgzoC9kVBnPRNlny9EuTjhUvwUFybEp8UGlqCBol3S
   +0cfru8om51u0dL0OK4GUtddZd/2244+Ku+VewgHsGJwPCBfKnJDLnISG
   pY+5cXQ/ATqNZ2mummvAYy2FLQM3rNxM/KIAoaa71zEtjuwp69CCW+QS3
   HsJKTCFi12jU+XRuAbF65FgylOoUzpTpaBw964KV2JO9RYnUJT/4PW+CT
   A==;
X-CSE-ConnectionGUID: VqIwUw0hRfGkTrfF6fkjAQ==
X-CSE-MsgGUID: VR1Ge6IgTSi46S0O7DQFog==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="49969766"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="49969766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:21:07 -0700
X-CSE-ConnectionGUID: rxdG1d98TyWK37HO4LS19w==
X-CSE-MsgGUID: IIakrLkKQ3CUxMVwm3fJlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66597896"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:21:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snaa0-00000006jPn-0GNp;
	Mon, 09 Sep 2024 12:21:04 +0300
Date: Mon, 9 Sep 2024 12:21:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/3] iio: reduce acpi.h usage
Message-ID: <Zt69_53mKFrgYYwi@smile.fi.intel.com>
References: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
 <20240907162428.6798ade0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907162428.6798ade0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 07, 2024 at 04:24:28PM +0100, Jonathan Cameron wrote:
> On Wed,  4 Sep 2024 00:28:19 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Reduce acpi.h usage (partially, more will come).
> LGTM
> Applied to the togreg branch of iio.git and pushed out as testing.
> Probably next cycle material though given timing,

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



