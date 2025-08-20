Return-Path: <linux-iio+bounces-23054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27083B2DEFD
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489E54E84C7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067D2749F2;
	Wed, 20 Aug 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL99FOPi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A28224891;
	Wed, 20 Aug 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699306; cv=none; b=jqcPj9pVGh5mFFEnuV8RIQs2aE8O4OM+fRJHH3tc9cjM2kPMUhaGV41ztTHzOuPzYPnxf4Rvjs6WzNO9AWCyTC2TiAdZjPWzYGoMIJ2NeSU5K+SQWsGAZE4KbknK5TcuqKgNf5zcolRn7kz+3yy+b3F9cLubgBeQ2nsbUs6zvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699306; c=relaxed/simple;
	bh=CMCbQ4nUzOVBsCRH+U/MnL33leN1PQj2eDWMrPWqoSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuhchKdqrml8+ZBwNbrIxzYDdZRTFSkjGZn+AnDYdjbp2HROO5Tsp+PlsE5le4xaGKs/u5RTpKWhOrv8WTnwxWmAygg2l8ZiVPiSgrhF8UbPDVTTiMdtgfKqGlRf5keSe0hilCUOa9wjPHb536tX6zs94Ae6oQx1kHi9l0NOicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL99FOPi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755699306; x=1787235306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMCbQ4nUzOVBsCRH+U/MnL33leN1PQj2eDWMrPWqoSM=;
  b=RL99FOPinmtW6cvGPhtlqgccQfzAEc14F8OTVboZpijb4GxcQN4M7QLw
   f2LZQGNSpn89HgakSp1BWN1yMP1dp7YllctWgSxjAlaZXLD5m/N1OFHKm
   l/MAP2hgb2DiPsRD/J3XwVmleXUQiAYgczj1IYljl5vJ5HKf4zE9yOOQS
   Ny9M7JALAuiNpvOU8cOJmArIt9tqTdZz27arnqngwnbw1Zmd70Rl2Ossu
   FOAplmb/Upl32WfTKjJ505LKymne9Yll+0H/VmTHFaeb9or5qebabGzWd
   cYZgnlUV/5s/Ik1CYb3PXGtQkbZDIbMClohIVKME/x7MZLZPKhO8H8Jtl
   Q==;
X-CSE-ConnectionGUID: hpQfTPrRQzOACfyIaocbiw==
X-CSE-MsgGUID: 2DDAT4j1Rfub1+LuZhnEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60591841"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="60591841"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:15:05 -0700
X-CSE-ConnectionGUID: FZ2ngGBoTJ6AMDIqeGGmAg==
X-CSE-MsgGUID: z7QyWUtmRP6pVRCGLiuqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168491216"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:15:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojad-00000006xDd-0dmF;
	Wed, 20 Aug 2025 17:14:59 +0300
Date: Wed, 20 Aug 2025 17:14:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Message-ID: <aKXYYm0yXfujRb_n@smile.fi.intel.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
 <20250820120247.3012-2-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820120247.3012-2-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 03:02:42PM +0300, Ioana Risteiu wrote:
> Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support

axi_adc_num_lanes_set()

or I think even better to rephrase

"Assign num_lanes_set in the adi_axi_adc_ops to axi_adc_num_lanes_set()..."

> setting number of lanes used by AXI ADC. This operation is included in
> the generic structure because the number of lanes is a configurable
> parameter of the generic AXI ADC IP core, not specific to a device.

-- 
With Best Regards,
Andy Shevchenko



