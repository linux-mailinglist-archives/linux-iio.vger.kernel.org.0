Return-Path: <linux-iio+bounces-9082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832696A5FB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565161C2148D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEE18FDAB;
	Tue,  3 Sep 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiOMveeh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676918E022;
	Tue,  3 Sep 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386256; cv=none; b=JYF8sZoyNGSv2LdRlub9/a+Rnvo9eN8LdQzBHqVXYdgouaYYmZ5vStsRRoHZLZdERtMOQFAPVtfpXqMV5MpmAD9RyQO2Vm8KvFRzfZIyhbCgzdGRhUuXRIYFFgwanVCgIAJqY/Q3rdB3UC1R2CdCiEZjIJFusZg6w0g7rCy3t+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386256; c=relaxed/simple;
	bh=EXM6g49SzTFN4g5RSuFkh8aFGvkVKWw6W6cmvo7DtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNDMgepgrjYmqzqpl32I6YgzhKPXWAetPALAMHiXShUVUq5EDLjDweUcnFHnSxZlVFzkElb0m8h0u44IlNItw+s48oYD8SeZF7VOiFiCnKf3cYjNKXlDBi2tUwizlgsAAFfXQswLElX5gsVSmtzBfmmrRmGfhaSFV9BH+Spn6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiOMveeh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386254; x=1756922254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EXM6g49SzTFN4g5RSuFkh8aFGvkVKWw6W6cmvo7DtN8=;
  b=JiOMveehk0YhFIVOvMnPgnr0ZNsFgHUyOcQHwOMG2ooZRwPGjKDtu2+S
   66u+kNSxblkzAaOWOtL3LWY6hp0za2eA+nzjjv+VZvXn4JBFjERB7Hg1v
   K9wEm62ijGODGSDOU+bm5hUvYFpS7SuQUq3EnAMP7np4bAv/4U67BDLU+
   FGKBvKBI2gRBW8OKDN6GM8C/oWUV+R+0FvfWqJD/77k+FBnvpUKB77ic3
   QwEjp6mVFjfCZLCdr9I6xKsZ1KRN0Y6s+pSjvhsYjc0U1CDGHWCaI6V42
   PCofu6DImVW1m5qKVW/Q9URwNYl3M9hysqqMaHy7v3XLtYA82gDl3lSUW
   A==;
X-CSE-ConnectionGUID: +9FmoZ7oR06ZXbMo3Dht4g==
X-CSE-MsgGUID: A+3zojCTTTuzeomuJpxsrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46532016"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46532016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:57:34 -0700
X-CSE-ConnectionGUID: ilIAXnsSSJKCUX3UsFOmrw==
X-CSE-MsgGUID: o0kt1GO2QYW28og6PAbGLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="102408553"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:57:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slXmR-00000004nRC-2Ik4;
	Tue, 03 Sep 2024 20:57:27 +0300
Date: Tue, 3 Sep 2024 20:57:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 00/22] iio: use dev_get_platdata() to access
 platform_data
Message-ID: <ZtdOB3VRN0QCGWU9@smile.fi.intel.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 01:16:45AM +0300, Andy Shevchenko wrote:
> Unify how IIO drivers access platform_data field of struct device.
> In simple and straightforward cases constify the local variables.
> 
> (Not tested)

Jonathan, in case you are fine with the series, feel free to squash, e.g.,
changes against hid-sensor drivers.

-- 
With Best Regards,
Andy Shevchenko



