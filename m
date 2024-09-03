Return-Path: <linux-iio+bounces-9098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64796A7FD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 22:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC351C23F61
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1017CA1F;
	Tue,  3 Sep 2024 20:04:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD164174C;
	Tue,  3 Sep 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393845; cv=none; b=ZAkTSiFCrvIphl8+agtf/Ff+bfYfHsFulqX4xI7DPbtTIU3t11P39+bRpXA/C3V9sU0FfIVuCkFWF5CXCs8MiRrNXPjZS2TANFz2Jzvm+Fq6p5ba9tHgHWBmy2m6m/954pqPtQ1jz5aIQprjdOgZx0y2OjLJXOQjKaVAfsQOqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393845; c=relaxed/simple;
	bh=hhTUq0BJXUc/2KjuFKcG/BK7I8B7IsKcWEkw8TTiyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvxpmDoHI8DVoZjMfGOSHyZcA03zqA8XiE91TkP/7a73beUg+wNW2PaIHH18Un6/63VrYYz29zgVFxiyU4JgrBDh2iWYIvuy7S03lkNrnWUg3zHiqdqzgB/fu6RE2bAR9w13Cp8nY7PuoWKP5zWu8oKSCs9rcykDD1n9/DpmQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: +iAWB0HPRfCephGGNU06og==
X-CSE-MsgGUID: Ram82HB+Rb6wgraZJe6PEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27775698"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="27775698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:04:03 -0700
X-CSE-ConnectionGUID: MLYEPSgySjCZ9ixW3rekiQ==
X-CSE-MsgGUID: NrjMsH8nSdGPv+RTUFICxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65745599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:04:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1slZjs-00000004pnm-3vh0;
	Tue, 03 Sep 2024 23:02:56 +0300
Date: Tue, 3 Sep 2024 23:02:56 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 10/22] iio: dac: max517: Get platform data via
 dev_get_platdata()
Message-ID: <ZtdrcHQokaHdfXp5@smile.fi.intel.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
 <20240902222824.1145571-11-andy.shevchenko@gmail.com>
 <20240903204737.710e49dd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903204737.710e49dd@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 08:47:37PM +0100, Jonathan Cameron wrote:
> On Tue,  3 Sep 2024 01:16:55 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> >  	 * Reference voltage on MAX518 and default is 5V, else take vref_mv
> > -	 * from platform_data
> > +	 * from platform_data.
> 
> I guess this is accidental?

It can be dropped.

-- 
With Best Regards,
Andy Shevchenko



