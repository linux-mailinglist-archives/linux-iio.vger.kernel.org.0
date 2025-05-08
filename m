Return-Path: <linux-iio+bounces-19335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B1AB02EB
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 20:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30FD188EE2C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D396286D50;
	Thu,  8 May 2025 18:35:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7F4B1E7D;
	Thu,  8 May 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729325; cv=none; b=MQB7AUD9LTHl0ixcYs/YGVyDfdG3T2IOWR0yuZS3o11nMmBY8CrKZOlvqVj1k5+rfWkO1rppSaEqN0EizUzyN+jt1ejLHg1u1Oy7pE0S8EV9P8rOtc8YNxSM+NWvAYf6ruVEwgQ5/VsCvI1NyzrCQMcbCwlAui9OzYlhNcsMkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729325; c=relaxed/simple;
	bh=pQVCCI8EqkRoXe6jlfp88q7Ckl5MiVkBR4sc8JWAFWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg/cb2qt2pf97qADAoSg269ND+GTgZMNfuYMNhD2GrGHe5jxHsKgWG6lUtCpIDo6LdHypRt6rLq+uvoPlV/D1iQqy4EGiHPc1ThVsd+M9/sEd+KR/Z3wLTj3BYemMieAubPJ8OO8YjQr15zy9phP1yGgGs1FMX6t6ktzdq2LOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1VGZZ0+HTdSsOqSy8EL+SA==
X-CSE-MsgGUID: mIW0WpyQQBOVUBKta4jmGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52344853"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52344853"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:35:17 -0700
X-CSE-ConnectionGUID: bvrRQzUPTXqm6DaZU2h9sg==
X-CSE-MsgGUID: ut+I5uXbQZmzVtZD2uR6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136090820"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:35:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD65P-00000004CCz-1H8r;
	Thu, 08 May 2025 21:35:11 +0300
Date: Thu, 8 May 2025 21:35:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <aBz5X3AQRi1ONsly@smile.fi.intel.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-1-91a3f2837e6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-1-91a3f2837e6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 12:06:05PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO calibconv_delay documentation.
> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the conv_delay suffix.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
> +KernelVersion:  6.16

Here is the space being used...

> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Delay of start of conversion in seconds from common reference
> +		point shared by all channels. Can be writable when used to
> +		compensate for delay variation introduced by external filters
> +		feeding a simultaneous sampling ADC.
> +
> +		I.e., for the ad7606 ADC series, this value is intended as a
> +		configurable time delay in seconds, to correct delay introduced
> +		by an optional external filtering circuit.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay_available
> +KernelVersion:	6.16

...and here is TAB. Please, make the text consistent. If the original one is
inconsistent, fix it first.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available values of convdelay. Maybe expressed as:
> +
> +		- a range specified as "[min step max]"
> +
> +		If shared across all channels, <type>_calibconv_delay_available
> +		is used.

-- 
With Best Regards,
Andy Shevchenko



