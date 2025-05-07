Return-Path: <linux-iio+bounces-19246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC563AAE37D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7CD17ABFE
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D270289829;
	Wed,  7 May 2025 14:46:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEA194A60;
	Wed,  7 May 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629196; cv=none; b=NHPplgBNrPGWqTHBW6mYj3R507aeCrKtBRTa/ep68Qm1p4cCgYbfXZi6zqxANBf7mHvxDJgRUYjsehdrS9PTp9nOS7x4QLahnT2mZl97s8Bknc4tReZF/19OsySBdM5Wpzjj2foYIXvcd85rpXULP3lzINCnaKCtWEX0SiQIiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629196; c=relaxed/simple;
	bh=tlwe1hAT+DkgaxCISLkHWzTguprow1sSYXVWfsQQEeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWUh43gWH8lmE9HoCetLW9ndDhL/IPfxU2HCw0rmWdxp831XVH/YpwZJ3vMHHxOILXLujxyqbOEr6XJ6J0ztRuu3ml2bAWR8Dxg/Sw0Djtxpce/g59oB8klEr45EWMVo+XZXfkywbsu1cyqrEy/4jgcFqpKkReh0A8PGhSOSo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xQ7PNeipRrW2IMieTkPp5w==
X-CSE-MsgGUID: eR2dsZOjRbmy6FNQ4FcZqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48444897"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48444897"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:46:34 -0700
X-CSE-ConnectionGUID: GaebrgmaS0imW9q4eSDatQ==
X-CSE-MsgGUID: HlikU8OYTcO8/enNxOvH3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135847133"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:46:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uCg2W-00000003lA8-2ZY3;
	Wed, 07 May 2025 17:46:28 +0300
Date: Wed, 7 May 2025 17:46:28 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <aBtyRHFW-OhhwXsE@smile.fi.intel.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
 <aBTLBvw_88hQBbns@smile.fi.intel.com>
 <wvflf3rmqaonm6gt45gqtxndprkqbhgvce5z7c4z7c7jgdg4tm@kofkvcbvnaav>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvflf3rmqaonm6gt45gqtxndprkqbhgvce5z7c4z7c7jgdg4tm@kofkvcbvnaav>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 06, 2025 at 04:46:35PM +0200, Angelo Dureghello wrote:
> On 02.05.2025 16:39, Andy Shevchenko wrote:
> > On Fri, May 02, 2025 at 03:27:00PM +0200, Angelo Dureghello wrote:

...

> > > +	*val = st->chip_info->calib_offset_avail[0] +
> > > +		ret * st->chip_info->calib_offset_avail[1];
> > 
> > Something wrong with the indentation.
> 
> Can eventually adjust to:
> 
> 	*val = st->chip_info->calib_offset_avail[0] + ret *
> 		st->chip_info->calib_offset_avail[1];
> 
> this is genrelly ok.

This will be illogical split. The idea is to replace second TAB with 7 spaces
(instead of 8).

-- 
With Best Regards,
Andy Shevchenko



