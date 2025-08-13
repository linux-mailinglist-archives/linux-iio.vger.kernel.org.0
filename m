Return-Path: <linux-iio+bounces-22667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D5B24B39
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1071638DF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BA2EA74B;
	Wed, 13 Aug 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evuEMcXL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433D18FC80;
	Wed, 13 Aug 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093036; cv=none; b=m/+kgCC0sKHhCXG/VQtAMG6muLpZTjynZcEd4K32CeIvlZE+Vcgrd1690e0cPJDkuqLb3gOtlvlnbrVs0DPFdpGxP2Bsxbr517Az30U7q8I2iG1DjyolhyjugPdrDZ9odpP8gI18/rF5j7RqUf7qjpgiM7PJPb/NTJ8GbMuM6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093036; c=relaxed/simple;
	bh=rf7yiRzPgAKcH6/NhlYzbvBoZqWm1w11hNyF4KQ2Kyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s27eRSOGPBgbz4GO+qGwaXQrq9F5wpBZ+VWvx5EiRnlsTOR72Y1Y4/JtupAO6yQDHd0j9pvSTQ5DLowk+Qqn9w0hygMktK2oyuxldblzfOuQF1m+gXwTiSi9H/fVEOCA83YGqVhi9lfS8UrDGWyBrwND31aJ9UHomwAaCZ7RrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evuEMcXL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755093035; x=1786629035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rf7yiRzPgAKcH6/NhlYzbvBoZqWm1w11hNyF4KQ2Kyc=;
  b=evuEMcXLTUbH72UgSPCNKyvyoSiNi1bolO8PIs2LdfqJNqcjjhzk+1+J
   qCev7/nQDwYdc0fTn7eBD2vXxY9Lhyh8GKfc6sg3sUDItJGOOkKvj8Ouk
   qNXvgjfJrFCn5/Ztj5egm9v8ZrvqdY3Zl1NuNMHyHrPicXi2popbaSwbI
   MP1OTA9nnYQliZwgzGeNEY/HPNo08FAr5CXcbAQIom4XHbtTtV6vbbTcU
   iJothyprOwW5Rrt/ZZX8DTc1XKHAshAQyZTdtoEN1dPXzbxHEu4nWIoDV
   eRe1d6NYT923YUtOwTn3u67qfNsK9XfpJGGKAm6U+ofl8FD+Jei5YaaBy
   A==;
X-CSE-ConnectionGUID: HOfw0IM3SlCIApEaIk8Y0A==
X-CSE-MsgGUID: OADG8MX7SluPN//KNt55HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57288947"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57288947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:50:35 -0700
X-CSE-ConnectionGUID: 0MdST/WoRua8nlWLvhWELw==
X-CSE-MsgGUID: s7qdNHr0Sg27ZABTGMWZJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170928480"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:50:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umBs5-00000005Ro2-0yR3;
	Wed, 13 Aug 2025 16:50:29 +0300
Date: Wed, 13 Aug 2025 16:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Add device powerdown
 functionality via devm api
Message-ID: <aJyYJLMUYAm_uqUx@smile.fi.intel.com>
References: <20250813133017.72476-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813133017.72476-1-akshayaj.lkd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 07:00:14PM +0530, Akshay Jindal wrote:
> Use devm_add_action_or_reset() to do cleanup when the device is removed.

> Set client data with i2c_set_clientdata().

This is not used anymore, correct?

...

> -	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
>  
> +	data = iio_priv(indio_dev);
>  	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
>  	if (IS_ERR(data->regmap))
>  		return dev_err_probe(dev, PTR_ERR(data->regmap),

So this hunk needs to be removed from the patch.

-- 
With Best Regards,
Andy Shevchenko



