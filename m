Return-Path: <linux-iio+bounces-26974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038CCB06F0
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6119130D9139
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB22FFFB9;
	Tue,  9 Dec 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0TT4alm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00792FFF94;
	Tue,  9 Dec 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294924; cv=none; b=IUNtTexq02gxzfsMbvLgM9K4SFxklbJYLSagoc2hnOiQOjCGsgFxkIgdaulnS2t0Kg5sVVn8DvEfELHMdf1yX4k986vgJy95Led8udVXSGchTQLtT2IjdvrBnnAYORA0mkg2wd0zhNNRMfVsBu6JXjg1AL2iK/FlNzkrXPPpVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294924; c=relaxed/simple;
	bh=k3U25uDaw4izIjOj3XKZ1pTWxQ7Nkcc0U4Z89iy/KkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9Ojqby1oct7NLQqsPONxQGS6HoAYlmf4sFkjNvDmncT6y+Sk1UH0LA8HJxv8tuuN19RsluxUYo+xYTptZTXo5eanYHj7xByNIv068Yb39oAKbK1saVYaYHM97AhSsIz2+AuBbsqldrQSpoLnieRywVhEWLb2h9/Exl67GtzFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0TT4alm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765294923; x=1796830923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3U25uDaw4izIjOj3XKZ1pTWxQ7Nkcc0U4Z89iy/KkI=;
  b=m0TT4almBOcjI4TekmdK0qOUa+1tXoacW6TOBI+mduY/BEti9w47NnQ5
   aaWE9aNoQ0lbdbwbfy7D1zRNdwvfGQnreIyCKkRhbt0RqmWfFYj0dTwNH
   0jQ5gXPwdCCZo+XPmoM+C3KfePP9F5YDm2CmE/TU8HNnrtQpAlJofuEqh
   y1V+T2ZE9CHG6CWq64lxFby7LpxzXUaMKghUboUFHYRv8ulIJsmXTUn4Z
   pobDPYB9qv9uWpiV2sWIf4fmxhPCvrfhYEeUDA3Ryz0DZ7nMCvdLShgPO
   BvwSbe5IOLtfssVVKXL9ItZqnXnExTsr8lvsY0HNMbldiDLuBNUJpqLqC
   g==;
X-CSE-ConnectionGUID: 48Bd/BaRTLGVg2Evhb8nwg==
X-CSE-MsgGUID: NSUmLZNKTeCddfbM3GftpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67149597"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="67149597"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:42:02 -0800
X-CSE-ConnectionGUID: wPlBPDInQsGZm0hx1hzYJQ==
X-CSE-MsgGUID: q97XwC0BQM+15Taw8oBLuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="201176064"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:41:59 -0800
Date: Tue, 9 Dec 2025 17:41:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: ad9467: sort header includes
Message-ID: <aThDRciNYXHf5rCB@smile.fi.intel.com>
References: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
 <20251209-add-ad9211-v5-2-8da056eb62e9@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-add-ad9211-v5-2-8da056eb62e9@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 03:38:11PM +0000, Tomas Melin wrote:
> Include headers in ascending order.

Yes, this version looks good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



