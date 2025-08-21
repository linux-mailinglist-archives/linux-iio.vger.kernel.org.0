Return-Path: <linux-iio+bounces-23096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14381B2F405
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFA718943E3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F42D8763;
	Thu, 21 Aug 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MB1ll6bg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826811F3BAE;
	Thu, 21 Aug 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768806; cv=none; b=uqFxaid6KekhQmbbCd/W05EzDPspxNeNPehA9LnrFZE8cT/dhc8mzkt0M41GH7HlTK4YEBCQrEOLgQSzBDohhNWErM2M711EFkVz0coOQJVDqFlpkCgV9lYOz90bBCzgkpRbFZdphHuP2oPN56NdwXM7E86Sg3qfWtJnQcmhbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768806; c=relaxed/simple;
	bh=zi3d/9Je3Jsyyxd6QlTdXw4CB/lfFnOuOdagOMYLJEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLfcHandQtQXP50LF4pDPyjX2cmSKI/0DbX2p+2JDcWRe1ldsocMncFSVDmsZ3+ZDP7bVDHoJaXAjH/g1y/9+cGxrVuZl+G6JMpOMFHIexj1zzHkeEjwbYTj45pCu8YpgMGwTi+56/tDS3I+vDqYqVLbE4QeOdzuSMAhgpV5aR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MB1ll6bg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755768806; x=1787304806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zi3d/9Je3Jsyyxd6QlTdXw4CB/lfFnOuOdagOMYLJEc=;
  b=MB1ll6bgwlouhY+xFtPJU3rm3q4WONQax3ewn4c2VDxNRYuAobmq3sQW
   wz9tYbN2JTERXlvsKe1wrUr0lrRu8dM2GasvZNhpcLAyjXkHs6lgAF1v9
   WzT/rFhcLoBB8zIwno7NcHskimGjpQl7HGd8TXtNLjmPwUL3rT9zURVzF
   CcfLcqy6E64rX6NPaiZAYfOwiJYqGSmGrr6vWLXIVXQO+fe2txQCRtDRW
   cCTg3tu8PF9KcwV8aJyFgpe0vnBMK0bHgn+ychxBQSi7NnGnatzQJls0/
   JDVf8Y1TU9JFtcLw6f8LxNHRkPqwSevgXe73O0L6F753PsZ8WfNV3wC5N
   Q==;
X-CSE-ConnectionGUID: Dq5hDRXfQimIrP8Blj3B7g==
X-CSE-MsgGUID: LLJANpJ7QIatzEjt0I9eiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45624532"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="45624532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:33:25 -0700
X-CSE-ConnectionGUID: iZjUslTaQtaTauut5G1eEg==
X-CSE-MsgGUID: qxPAxHq5Q4Gy1oZnH45InQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173701227"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:33:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up1fb-00000007BaD-2MSc;
	Thu, 21 Aug 2025 12:33:19 +0300
Date: Thu, 21 Aug 2025 12:33:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <aKbn39Ek1pOVO7rb@smile.fi.intel.com>
References: <20250818035053.32626-1-bcollins@watter.com>
 <20250818035053.32626-4-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818035053.32626-4-bcollins@watter.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 17, 2025 at 11:50:51PM -0400, Ben Collins wrote:
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
> 
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
> 
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.

...

>  static int mcp9600_probe(struct i2c_client *client)
>  {
> +	const struct mcp_chip_info *chip_info = i2c_get_match_data(client);

I believe I have commented on this already, please, split assignment...

>  	struct iio_dev *indio_dev;
>  	struct mcp9600_data *data;
> -	int ret, ch_sel;
> +	int ch_sel, dev_id, ret;

...and put it here.

> +	if (chip_info == NULL)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +                                     "No chip-info found for device\n");

Wrong indentation.

Besides that I have commented as well on

	struct device *dev = &client->dev;

at the top that helps to make the code neater.

...

Since it seems the comments were ignored, I stopped here. Please, find previous
emails, take your time and fine grain the result for the next version.

-- 
With Best Regards,
Andy Shevchenko



