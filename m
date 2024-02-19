Return-Path: <linux-iio+bounces-2766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDB85A29F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1632F282997
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69E2C856;
	Mon, 19 Feb 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV3MAn3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FB2E3FB
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343908; cv=none; b=O22zD42sBOnarg1DetMZvFtg679MF9oH88exfpWez/IAluybWlH0wi1YDV0WptFThZZ5ueC8JBKY5gJ4OO8mRGS0xxOZTAYrqi9t9H01i4tLayax8cvQoMiWv4zJB9ZBh0NtZpqZ5pTBinYTEIVG3eUvKSowxyW7s3u1vczR07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343908; c=relaxed/simple;
	bh=XEN6t5N6DsrqG+x8bSqtGz4pn2cltJJS0G3tLaD65kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxteokEwtnTodcmoiI5wtvHN8WyNpX1PdvgmSWBVUOvtnz6GGcPuoyvsb/vZq3gSdtyrXAYUVNCdQGgJ3cBFVAk0Q1mbv678SHD+vbTVH0DW59b6mb9F9zN2SuCUVfFW/mF5aYU35D6qbXYxqO4ot3bhUAEfwnWVJaq9hDZOtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV3MAn3C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343907; x=1739879907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XEN6t5N6DsrqG+x8bSqtGz4pn2cltJJS0G3tLaD65kY=;
  b=hV3MAn3C/KSTpqBazSe9qQYc1ZD4VSZPZ5iSCsBZePWag/qlidzr9Sau
   h9oLZ9TaK3FHNK2x0OFJOASk9BJeH3o417Pf3GZOz0QWa6UzkLgorKyOx
   k7UPjP5sSNzAYNILpH5ip0TBT+6GzhjOuJtR7W++eY1/wgSIfI+4KBmjM
   b2pUAKYSIdRaiCWGMZ5sNrG3YzNZfcPT0iSl45S706CyyhzAtcO/PplSP
   SPI/UW8l8qYu/UBFnluRKgvtAXKZ8lt8/jajoPOFUuyK4yCbAf5jzup26
   hgvpVmddvz/CoEo8yUxhTEuMc7wyXoM0vDRT8EGQKg6mfQv+pl2lGZXuq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19951174"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19951174"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912862933"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912862933"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:58:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2Hs-00000005oSd-46ON;
	Mon, 19 Feb 2024 13:58:20 +0200
Date: Mon, 19 Feb 2024 13:58:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/8] iio: adc: ad7124: Switch from of specific to fwnode
 based property handling
Message-ID: <ZdNCXFpPpsNgO6VJ@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-4-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218172731.1023367-4-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:27:26PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using the generic firmware data access functions from property.h
> provides a number of advantages:
>  1) Works with different firmware types.
>  2) Doesn't provide a 'bad' example for new IIO drivers.
>  3) Lets us use the new _scoped() loops with automatic reference count
>     cleanup for fwnode_handle

Similar remarks as per other patch series...

...

>  	struct ad7124_state *st = iio_priv(indio_dev);
>  	struct ad7124_channel_config *cfg;
>  	struct ad7124_channel *channels;
> -	struct device_node *child;
>  	struct iio_chan_spec *chan;
>  	unsigned int ain[2], channel = 0, tmp;

Shouldn't ain be u32?

>  	int ret;

...

> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, 2);

ARRAY_SIZE()


-- 
With Best Regards,
Andy Shevchenko



