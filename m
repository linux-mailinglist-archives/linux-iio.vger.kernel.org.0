Return-Path: <linux-iio+bounces-26401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECCC7F833
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5DE534418E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B032F90E0;
	Mon, 24 Nov 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cu7QwQtR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AEE2F7ADA;
	Mon, 24 Nov 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975509; cv=none; b=WDQ+gJ7x4lAtJvSZ0IBCCnaW5YHmshxMhWKKVVOGTIAruIDcUmy2HJwGyasbcDHWDeDGiUl68BdD45vw8Eh1OaUhYDRn7elsYHDxe8ZCgq8Dt6k99Zf2GQ91LyNU4DgRtebw2DBVFilLfIFSEwZof6kTdcdMDRSlym7Qyo7wZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975509; c=relaxed/simple;
	bh=ds/FXB3Sv+gr9hk89pOD61xECL/GN9oYXn1YmpKtXlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHGC3OWtbCiR9HQBAS6rPXxtJlyW4SQGXJNNc5ABxaYXRm9hD28pjMEifh+PWkKi5CaBQi5aION7WyG1scvQGC7dl3cmXtqzgU5Jdf22gAcJ/ifi5c/7B2FaFt9FdrCR/LoluO5Oq/83M20cvgLk3IRIB4bzQXWyvxWf8V0hWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cu7QwQtR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763975508; x=1795511508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ds/FXB3Sv+gr9hk89pOD61xECL/GN9oYXn1YmpKtXlA=;
  b=Cu7QwQtRNE0YaTAe+QZrUHPg1Qt+fsTL0gMOTHlPE9TbrczKm2uRyZNW
   k9gtFVims1FztUgkzV2AIuah34rXtuXiOAPjDoyIDr8oMVRRsdOWFtK96
   swGoAGQw/MoxoU6ZmRgzOsVqVOWuUG9kdsdepV90NcnTvcLXxzGZHPKZm
   NoEmkCdrlNWZAAtV6Y/9urW/WkOX007sSnRAcCEndd3bjeQ5io0SSmway
   1rhM3enAsKw1lYKuK6uqEqheyPQH5Dmvm73DC+PDJcKUWLbsofZC/9xzB
   Htg+0TGL7mtO9rJKT1M/sdn5/NkUh4I8egeVFvdZn5EsBWPALRT67yQS7
   g==;
X-CSE-ConnectionGUID: +Kzbl2juSfm1BhpiX/Pkww==
X-CSE-MsgGUID: AkcOBl20Qx+2iCAZfVqMUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91454666"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91454666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:11:47 -0800
X-CSE-ConnectionGUID: cm0CIinqRt+nJq6aRMh0lQ==
X-CSE-MsgGUID: m2BwaQhQRkCL6H5zZ0zjwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="193061710"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:11:43 -0800
Date: Mon, 24 Nov 2025 11:11:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <aSQhTd5Z7KyvHtbG@smile.fi.intel.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
 <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
 <aSQMjZbc75cQtFqJ@smile.fi.intel.com>
 <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 09:57:26AM +0100, Jorge Marques wrote:
> On Mon, Nov 24, 2025 at 09:43:09AM +0200, Andy Shevchenko wrote:

...

> I will submitted v2 shortly.

I think the "shortly" is not needed, please take your time, this seems missed
v6.19-rc1 anyway.

-- 
With Best Regards,
Andy Shevchenko



