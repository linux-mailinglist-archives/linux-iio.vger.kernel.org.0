Return-Path: <linux-iio+bounces-17885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918F0A82CD0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26248440891
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6E26FD9E;
	Wed,  9 Apr 2025 16:49:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B911DFFD;
	Wed,  9 Apr 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217373; cv=none; b=ikrpbpOPnXKQ8s07N7OdGiTTqfcJxq8z6sWDrPms+KrNfhSPJurTSRxgNDfOBijo5cVCrUK/QTzAxNCWHW++M4II1xRiGDYMzM8oJGPhZ4hgzZJtImuRslFPb3DQkrHZv8O8esvnLyTnFzoMEbPNJ0Q9c4MLn4wqoNT8Yq1Px9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217373; c=relaxed/simple;
	bh=ohqSg3uL9U8X2utjsHNNmkbc85ajApTInDk/ZUqjaCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKT82UlHHuptDpL0IB52hGkoyYzSX8gScBDi0v5DQzrtmFWW+WiB6E8qOEoOTt3AeYD9anKZ2OFKGkmxvGC+a78L7+z6BNn99zAnVHw3ZvPEE4GE8Gc3RiKvD8r3QpTcMK8ujv7DjBHsq05dIZIuszg/17CalunBATo4445y75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4bt8YLn/SZK0dbFot+XbDA==
X-CSE-MsgGUID: 2LWYIrUhQ9GZob9gxSuefA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45598683"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45598683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:49:31 -0700
X-CSE-ConnectionGUID: VtuiWBZlTUCo5IUdr68law==
X-CSE-MsgGUID: 1Aihe0+hSkeE0TMw5t9SMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="165851114"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:49:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u2YcA-0000000AndM-0C72;
	Wed, 09 Apr 2025 19:49:26 +0300
Date: Wed, 9 Apr 2025 19:49:25 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/2] iio: dac: adi-axi-dac: fix bus read
Message-ID: <Z_alFXGBhFxk-h0e@smile.fi.intel.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
 <20250409-ad3552r-fix-bus-read-v2-1-34d3b21e8ca0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-ad3552r-fix-bus-read-v2-1-34d3b21e8ca0@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 11:16:54AM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix bus read function.
> 
> Testing the driver, on a random basis, wrong reads was detected, mainly
> by a wrong DAC chip ID read at first boot.
> Before reading the expected value from the AXI regmap, need always to
> wait for busy flag to be cleared.

...

> +	ret = regmap_read_poll_timeout(st->regmap,
> +				AXI_DAC_UI_STATUS_REG, ival,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
> +				10, 100 * KILO);

It's timeout, we have special constants for that, I believe you wanted to have
USEC_PER_MSEC here.

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko



