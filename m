Return-Path: <linux-iio+bounces-23111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDDB2FF67
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889AD17C519
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B925335BC6;
	Thu, 21 Aug 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT7kgDlY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F13277A4;
	Thu, 21 Aug 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791073; cv=none; b=MUfCiTPdodOy7f7Fdr7WhKfMfNljTLGv1ZOfzJ/tlKpZu5dkdNYM7W8MaojIH1Ela7JPvRJHuw+DZZLEwTM+Mi5cV/UOdLYMHTrCINS9ma4VEM4NHH0CsOj4jxrP8J+GpShfW1vP0K7CFmn6CsunE8ALQrqcbJSQztCaylfJIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791073; c=relaxed/simple;
	bh=sV+9DsTJ0Fp/TKXtugaNMSX791BGhITPp66IoPgge20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ1kLCxH0fnjRKY9ZdU0HVbVMsLg9540OyX4sNq4vQUy0Xfz8lIboZ8UaGOZGkKJmRdHT1I4y3fcTl+2O7kRPbdh+S6r284kIDSxGlMJnzzjFlcrCyt3rk3ULvtD1CDpjdanLO90NX0F5P/XvGYHRa7k+nDHEFVhWw/jC/YGG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT7kgDlY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755791072; x=1787327072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sV+9DsTJ0Fp/TKXtugaNMSX791BGhITPp66IoPgge20=;
  b=LT7kgDlY5vjcxJ1oYlJDsugH9JZizU8T58gc81GuF/FmT6H+I3U69yLI
   QuCt8Dy/M84+qeMqytjslG3Vo0prd+gWBnvovkP3egQdsStOMBHWwtNjX
   DOt+bOM7E+gogqJTyBhIpnNLeuNW87LsDhsIk2f57GLHKmEGKQCFRfqji
   e0tbBLOwVkmZfdLXpB7mRgtvcOODjundreZ8Z9rjBrwrpNPv5k1NVX/+U
   fKBVZn0+iXRpvgVdklZYIP9YUSn+wKUd9zd3II3WftWROAwXVmtUVhW6r
   Wjs5iwmtvZ4KQpBoucFhqwYYQNVNHElsr5dTaBknLxJrUi8Nz+t6XZvVz
   A==;
X-CSE-ConnectionGUID: t+y4rVO3RDaQgAsacOJnLg==
X-CSE-MsgGUID: QkqZIxhVSDWpZqyWF3XK5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58183067"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58183067"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:44:31 -0700
X-CSE-ConnectionGUID: YdCsIL4bRcOJDXxhJCHFEQ==
X-CSE-MsgGUID: eNVvE/FxQUOKfy85Xu4V6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168807569"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:44:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up7Sj-00000007H9g-3drd;
	Thu, 21 Aug 2025 18:44:25 +0300
Date: Thu, 21 Aug 2025 18:44:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dimitri.fedrau@liebherr.com
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Message-ID: <aKc-2WHDTtGcXmCJ@smile.fi.intel.com>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
 <20250821-hdc3020-units-fix-v1-1-6ab0bc353c5e@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-hdc3020-units-fix-v1-1-6ab0bc353c5e@liebherr.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 21, 2025 at 05:23:54PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> According to the ABI the units after application of scale and offset are
> milli degrees for temperature measurements and milli percent for relative
> humidity measurements. Change scale factor to fix this issue.

...

>  		if (chan->type == IIO_TEMP)
> -			*val = 175;
> +			*val = 175000;
>  		else
> -			*val = 100;
> +			*val = 100000;

Perhaps  use " * MILL" uin both cases?

-- 
With Best Regards,
Andy Shevchenko



