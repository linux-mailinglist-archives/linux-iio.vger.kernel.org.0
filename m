Return-Path: <linux-iio+bounces-10438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90299A082
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A601F25AA2
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8B2141CE;
	Fri, 11 Oct 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLkHTrD6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41C20C497;
	Fri, 11 Oct 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640508; cv=none; b=kOvvG0f8Ulqwk7pftbZDf0LU5M5rARwjffv3+oyOlVzaPicbYuHJnRYDt1HV19EBGwbbgIiMPibNV38+fhp+QiCAHmLhimlO2pwulY/9QkkofrHltM2z2Ul09ekrUwLQCNI5SynSurGHS6+F96xUkTdCq6BvWh8Yk5qRHsTFY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640508; c=relaxed/simple;
	bh=4UhPzKAxq1htJyVXoa6Yn6iXVYNDJylwqoGp59Hnk8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9AL47MW7e9xiw2WveW3w+LN8i5bXo8S1V2JG5SDj4b3zlm4Bv+OcdYqc5tq4U/NSI5ZnukR/1Pgrp9LtsxGeCEuI/Cow8ZnLerbDDshFvTBQCVeeO4Pa/wzcvUeo1ILzrdPFElDs8oxEUpM9JbmouEQOGvfjGfOKPcQUt3OWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLkHTrD6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640507; x=1760176507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4UhPzKAxq1htJyVXoa6Yn6iXVYNDJylwqoGp59Hnk8o=;
  b=jLkHTrD6ViI4PmiRTFY166/UJT9fAWyI6WuX2yb0uMlKuVt2GzXrvaDA
   bwInfXl0UOLe3rruXzW0KRaZKihBsbXPPcoRWpHmh0qFy7jN2Mh/p3NMr
   Y5MI30vmxKpXzw6AVSERdk/gvcz6d7/RTarCzOm9t8Fcq9J/1OHBdKi9r
   RNyNegrK6RpvHgmbzIdoLhxw297u+2LCi1NXielu3a4KPJSC+Y4uxUGol
   TsG1dKT6am3oqeAJid0UZPHUID/azw/Py9J0/xUa+UdIWxxNMeL7QFsq+
   tB0HUnALNgi5FwU2YjO9ahVPXFLTvUshXur2hmy3rxCaH8L7AjtaLqODX
   w==;
X-CSE-ConnectionGUID: sD1IUPHxTMuWejysG9JqkQ==
X-CSE-MsgGUID: qUmJVpm9RSmNRgrggo7vJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31736419"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31736419"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:55:07 -0700
X-CSE-ConnectionGUID: NVo8UdIuT1+BB/rfQQu3GQ==
X-CSE-MsgGUID: p8fLXQakTo2LVPCdCw2hsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81686615"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:55:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCMO-00000001qjM-3g4a;
	Fri, 11 Oct 2024 12:55:00 +0300
Date: Fri, 11 Oct 2024 12:55:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/13] iio: chemical: bme680: Fix indentation and
 unnecessary spaces
Message-ID: <Zwj19ONfbDr0f4Fh@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:18PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Fix indentation issues, line breaking and unnecessary spaces
> reported by checkpatch.pl.

Can we move this to be the last (or close to the end) in the series?

-- 
With Best Regards,
Andy Shevchenko



