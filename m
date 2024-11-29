Return-Path: <linux-iio+bounces-12816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F079DE907
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366BEB22B6D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8B54728;
	Fri, 29 Nov 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euWGYCNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44428EC;
	Fri, 29 Nov 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892477; cv=none; b=TGJjeNNoQX8+ZoX0eOachHjhAI7Nv1E88Tct+acSzEQNChSBPc4H8cSaXFrczNayqZ2YqzVFUSmbfApT+2jMlCuXyp4F9C5r0ypGk3+pEbtARHf4En/g9KWBrowa7GO4F1yEb7mX0ZcrzMk2eXAeFrQS7c4FczbsGsU9fYrHz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892477; c=relaxed/simple;
	bh=IWMCJ9cFS5vQM9imek4Mdfh/zD2u9uGJYoWhBg35qGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToMcZdp2W8612B/lbln5bI5ZFLq9B/ikUL6Wc24Ey5OylnuvDhCmPqaOq92SnxgTg33ouEuSuL6hC7MtIXDkmVoN3+48w36j9pgcvVlJWhytxAWHHeK4tLydqJBRKXG/GflZmCYlMU1Tkl7LPwIIPTRdYsarYqNRkP7B+eJImPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euWGYCNF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732892476; x=1764428476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IWMCJ9cFS5vQM9imek4Mdfh/zD2u9uGJYoWhBg35qGQ=;
  b=euWGYCNF2xsLgQwoxeuvMcx3ITuLxliG/fnCOiTJxOSQhXsdp9IzYV1k
   wyOOx33oDaNYgpZgg/hlLC7tyXgYTCSAb6/R49tY61W4+xWFfCiHikSCG
   rSCwVWaATqmyUdYS1viI9ZoBFNfzn1p80ICUJWbxCa/yPUa02H4cI6CHE
   mHNZJJ4GPZiefH8pncDahlzV887YhKoFopCzoX5MeEyvifcGHVWLvg0cd
   Asw6mXXQgK+g/n7RaT2658yBKxW0LJ2mfXW5KbhtkM46CswSRsd9ukUae
   qJpS7BmDfBJvpx9+r15Mb072RsB4GOZLCrzuWJxVN/GZMHQR6m1cQABLm
   A==;
X-CSE-ConnectionGUID: VW+K9+lXRuCZ/kjrd4tgFg==
X-CSE-MsgGUID: s4YyFgqrRNKc7EG7XPI0gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="50651578"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="50651578"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:01:15 -0800
X-CSE-ConnectionGUID: 6kAwp9XISyOBjhjpNE1+Fg==
X-CSE-MsgGUID: 7jJPbhzHQPaeGsYz9MKNBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="93349279"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:01:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH2UX-00000002GsU-35zZ;
	Fri, 29 Nov 2024 17:01:09 +0200
Date: Fri, 29 Nov 2024 17:01:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iio: pressure: bmp280: Make time vars intuitive
 and move to fsleep
Message-ID: <Z0nXNW4751P6hDtC@smile.fi.intel.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241128232450.313862-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128232450.313862-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 29, 2024 at 12:24:50AM +0100, Vasileios Amoiridis wrote:
> Add time unit abbreviation in the end of the variables to make the names
> more intuitive. While at it, move to new fsleep().

Seems to me the commit message's primary and secondary purposes should be
swapped, i.e. you do --> fsleep() conversions and while at it, rename variable.

-- 
With Best Regards,
Andy Shevchenko



