Return-Path: <linux-iio+bounces-20278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1CAD0884
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9923B215C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755C202980;
	Fri,  6 Jun 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vgk/KkY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977032CA6;
	Fri,  6 Jun 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749237267; cv=none; b=XG08arosnCZLMNgVCitB627Fk33T0zbfV8qiOHXauWJiWcTuIoyl9mlANFILtlLZT8sYpPd4AM2HuLIpq4nsTp/yA/qR3bR1YwJqihnNvpKli0SVTdEQycCiGCeDxkKp+rdd4wMM00P/wnEwuj7TIHDccC+UDCIYizLSRBTl7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749237267; c=relaxed/simple;
	bh=VykvfO7Iq4NIgpGD2e+wxvJ1l+F79KW09ICX22DAs5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgLxb5xsw5fBVpGg1CZB/lM7Wd8Dls3mxmbQlIyO4MmpogDcu2Y7pTWesbxC3mu6OJu4BF/GY920pkWX2ltt5qZWvNIt2EsknihY8mnrH4YRAhee6bVlHv8idgAeJrq6UIbWdusoR48W1R/GE+VBGVBdz+SplCmu1QdxjWBHjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vgk/KkY4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749237266; x=1780773266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VykvfO7Iq4NIgpGD2e+wxvJ1l+F79KW09ICX22DAs5o=;
  b=Vgk/KkY4MxCkwXYm6456Iv9lMsLkL5F6Hq+msgLwQjB8POTgqAU7Ls+6
   W71O30mSiCFoarv/qftpDnr+viyupBr4wh1dScFdVmH8PUWuCJV9KuDQ1
   bjvaiEqgKrQ8lwRcQC/mJzA2TeokDvpYh+1ezcdtTHn5jeQ9yMp3HqbzO
   lDxOY0NdWZbNbw8nJ4YBlmO/btTNcLoYzi/4UgQ/eJKggs7z39sOeN8O1
   KaeWv8HdBje4fEA02GpZUZMOIU6sQzS9KA/Xi9UqAiP24uDUzh2ABX7kO
   rcuWFcdpBi4dlUPD6eoW6Oe0gSH5ugwSzQAS8jhaoluzHoS2HxyuI4xn/
   A==;
X-CSE-ConnectionGUID: nvsErlo2RkC/0WuQbbf1pA==
X-CSE-MsgGUID: mW3j7TJVTa+v0KgRyYnJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="55057537"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="55057537"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:14:25 -0700
X-CSE-ConnectionGUID: N81RlHGxROePa8Cre7ag4Q==
X-CSE-MsgGUID: DRemVxsKTOuXBnHKjizcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="150919253"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:14:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uNcWB-00000004IAB-1gwM;
	Fri, 06 Jun 2025 22:14:19 +0300
Date: Fri, 6 Jun 2025 22:14:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/7] iio: adc: add ad7606 calibration support
Message-ID: <aEM-C0HHPcYTTpBd@smile.fi.intel.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jun 06, 2025 at 04:19:15PM +0200, Angelo Dureghello wrote:
> Add gain, offset and phase (as a delay) calibration support, for
> ad7606b, ad7606c16 and ad7606c18.
> 
> Calibration is available for devices with software mode capability. 
> 
> Offset and phase calibration is configurable by sysfs attributes, while
> gain calibration value in ohms must match the external RFilter value,
> when an external RFilter is available, so implemented through a specific
> devicetree "adi,rfilter-ohms" property.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



