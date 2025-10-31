Return-Path: <linux-iio+bounces-25753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9EC254B1
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE0B46038C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574D13191CF;
	Fri, 31 Oct 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SS0n2iO9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54D2DC79D
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918019; cv=none; b=mSN0kwwJW3eEbXRi81I/zUhMWskEu0+lr0RhjQAT9ghayYg1mp4EERQ68/w+mbyD9CQ0vyl66u0H3tKpjNNOXUnh8hp4UlkKVGKJp6bM/kQR/9ORuCNneQPAEzvxuNXADhdYz4iWovufjfv0+d4ZpHHHplyt15DqT8yq7kvuoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918019; c=relaxed/simple;
	bh=r2QHE9GS3gym5GW3xP+PI8Ij0uOsbQhutQ+GM+aJWYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7UDSjQ4C8SvZFAg7XF621TH2BZnsB8nDD6eXoytqEPIGOjUnQ0s0oiT3ZHH3Vn60qyyyHDJbswo48xM05cb+JuBwIjRmFIrmAG0H77BIgt3l+4N7eDrZ4vh9X9ElWJMAmC8zSGsid873F7N40/37inZvHLwKZFyG2ymlZsSakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SS0n2iO9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761918018; x=1793454018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r2QHE9GS3gym5GW3xP+PI8Ij0uOsbQhutQ+GM+aJWYw=;
  b=SS0n2iO9tGbMqgQnJ0qHl6NZNvGIao3Y+tCH4T7nmaFZVoHAGOgp0c0c
   auSRIRP9ualdwybldCvaJHW8sHvHtQq3vFQDdJPfhOEQI1wQK1NS1VFIg
   Jk5v/0sNPu0yNJA8BY91kyCttujGDwPSH/QE5omARnUpFGqPZrlq1IN0t
   GYq9RLSwisX36CZyW9VbhKajv7hap5nN3OXnZ1dyowUFzvlWPSohsC5UO
   iGuCiHAW4mitr3gJdCU2mgtvw+af298flSRd9rLX9b9SOeyKRDBEadjvx
   hUGuEUgfjaBNG/ImXBugBYkbKkobCQNnWFLim755PxwPaiPAsCJTyma4C
   w==;
X-CSE-ConnectionGUID: Uy9YnM6VQCyRlufNrxqtaQ==
X-CSE-MsgGUID: QytYxigwRf6TUIiqYMLEkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67916470"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67916470"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:40:17 -0700
X-CSE-ConnectionGUID: Dmg8TuoXTxKFpG9VpmorgQ==
X-CSE-MsgGUID: c12IWzQTRayXKfhd8GOlOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185900366"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:40:15 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEpMR-00000004HSo-1R3u;
	Fri, 31 Oct 2025 15:40:11 +0200
Date: Fri, 31 Oct 2025 15:40:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 03/10] iio: dac: ad5446: Don't ignore missing regulator
Message-ID: <aQS8OjeWFPtLRHAZ@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-3-d3541036c0e6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-dev-add-ad5542-v3-3-d3541036c0e6@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:31:24PM +0000, Nuno Sá via B4 Relay wrote:
> 
> If the chip does not have an internal reference, do not ignore a missing
> regulator as we won't be able to actually provide a proper scale for the
> DAC. Since it's now seen as an error, flip the if() logic so errors are
> treated first (which is the typical pattern).

...

>  	if (ret < 0 && ret != -ENODEV)
>  		return ret;

Not exactly for your patch, but the whole chain can be refactored as

>  	if (ret == -ENODEV) {
> -		if (chip_info->int_vref_mv)
> -			st->vref_mv = chip_info->int_vref_mv;
> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");
> +		if (!chip_info->int_vref_mv)
> +			return dev_err_probe(dev, ret,
> +					     "reference voltage unspecified\n");
> +
> +		st->vref_mv = chip_info->int_vref_mv;
>  	} else {
>  		st->vref_mv = ret / 1000;
>  	}

(assuming ret is never 0)

	if (ret == -ENODEV)
		...
	else if (ret)
		return ret;
	else
		...
	if (!st->vref_mv)
		return dev_err_probe(dev, ret, "reference voltage unspecified\n");

-- 
With Best Regards,
Andy Shevchenko



