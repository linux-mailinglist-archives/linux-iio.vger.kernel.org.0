Return-Path: <linux-iio+bounces-2768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095285A2C7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121ED1F2321E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABD2C85C;
	Mon, 19 Feb 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJnKDyjO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE031A89
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344159; cv=none; b=I1feW2HuNQRqSGUA5s8DVlGXeQvbyIbLYrKJFiLUisdXW0pda9+p8gGLn6Ml4OSfCs5c3/rWQoTdJcveGRlPfuSW+gN2wQbK4yaAJngpd/RKZsEuxmepxcx0vXWRr/pu4Lf6MZoSILCAVlrscGtM2RuKBRnDfrFnnW8yMFlYCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344159; c=relaxed/simple;
	bh=cJ069myId/c0BZ22/hI/m+pk4xah8bBedCmukIaWpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lio0gOObA9ZhHYq38G9gpukHK8WHzKrs388QB+1AR3X+BsP8sxu6IDTKD2KmtEK689bqGjvBHgbQhGm4IegLRBizXMZPiuqWOWQzgV3emjeafPG00tz+KA4+iQsOOF6HxIVygXp2dbF59pNUzHzts9M4ssLHPk0PZFoU4jsYv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJnKDyjO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344158; x=1739880158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJ069myId/c0BZ22/hI/m+pk4xah8bBedCmukIaWpVQ=;
  b=QJnKDyjOdWRYGvXZcqs5OklUe9NLvsdvXnF5fAAFBO8dudMkEjK48Nne
   RwhZ18sWbT0nbcvdUrtWtz9UBXwDnnuFJEQK+2nAseqgWlhMbZP+aNxD/
   H5afQFqW1tmyeilIG5XOUTCNaAnvL6GTd2wM+ky8SuRa2M0UiqvJIeTr9
   cCxCE3jWIk0368bEj76qVKPRcAFZtvtQTl7Zo9lXN2INdOhNlG8fafrlQ
   xgwIng8p8aD14OTh/bgeevrQR7H6girEgGfk1L87FdD86JLtRplk9V+UB
   m6x70sweFVZ6jzt/q5mQNFlHBc1BFbx0zPRgq2dPnoFTczCk8TRO6r7AE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5380612"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5380612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912863744"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912863744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:02:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2Lc-00000005oVB-0zZw;
	Mon, 19 Feb 2024 14:02:12 +0200
Date: Mon, 19 Feb 2024 14:02:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/8] iio: adc: ad7192: Convert from of specific to fwnode
 property handling
Message-ID: <ZdNDQycAQ-EmKgQU@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-6-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218172731.1023367-6-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:27:28PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Enables use of with other firmwware types.
> Removes a case of device tree specific handlers that might get copied
> into new drivers.

...

> -		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
> +		dev_warn(dev, "device ID query failed (0x%X != 0x%X)\n",
>  			 id, st->chip_info->chip_id);

Now id can be moved to the previous line (but it's up to you as you may argue
that this is the logical split).

...

> -	burnout_curr_en = of_property_read_bool(np,
> -						"adi,burnout-currents-enable");
> +	burnout_curr_en = device_property_read_bool(dev,
> +						    "adi,burnout-currents-enable");

Same pattern as in the other patch?

	burnout_curr_en =
		device_property_read_bool(dev, "adi,burnout-currents-enable");


-- 
With Best Regards,
Andy Shevchenko



