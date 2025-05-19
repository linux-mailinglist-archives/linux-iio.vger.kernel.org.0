Return-Path: <linux-iio+bounces-19669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AAABBD91
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D23BF58C
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF12278745;
	Mon, 19 May 2025 12:17:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DE1714B3;
	Mon, 19 May 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657028; cv=none; b=YCSgAu1vf9SL3Ya2aabe0A3QF3xSu9Ftyb/horupLKTFXbIexkcTUa2aNlRQARKCF8JFkozssQKajnl4ZB7iHoJ0rL+RZNa8ZuxK10q5DI9DoEwzn2INWgKBDKNVPEc5kM8KvgCieIOH/v5ZRX+8449RNcXH00fSFL7PXPcXjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657028; c=relaxed/simple;
	bh=II7Uh3XayjV3u8X4CGxA51vygQVXJFl7Ri4yS+3JM78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpvYg7PXGjqlmbih3bdJmFun23keiMYGqHuyLuvxudAXppOSjjxTIr5GHFIi9gaHktiDfiSvn64MSMBwmJXaU33SIV9JAeJWxG9zdaCrOi3WMd6AaPCX0IOmpfSaX7FFa4WlHv0/J76ArtBKHbacnDzon7wMiNXkUtA7DgOJ1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 8/ty2+JLRnC/zIsF7Y5l5Q==
X-CSE-MsgGUID: rgzUCgEiQ/qLXVICs9TLJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37171605"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="37171605"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:17:06 -0700
X-CSE-ConnectionGUID: eBUO6ahkSvS6rDE3t3ffUg==
X-CSE-MsgGUID: 321et6/9QRGM4gOomXMoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144235502"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:17:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGzQS-000000031qj-3nJw;
	Mon, 19 May 2025 15:17:00 +0300
Date: Mon, 19 May 2025 15:17:00 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/12] iio: accel: adxl313: add inactivity sensing
Message-ID: <aCshPOIHVqluhXYs@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-11-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-11-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:19AM +0000, Lothar Rubusch wrote:
> Extend the interrupt handler to process interrupts as inactivity events.
> Add functions to set threshold and period registers for inactivity. Add
> functions to enable / disable inactivity. Extend the fake iio channel to
> deal with inactivity events on x, y and z combined with AND.

...

>  	en = false;

You see, now it becomes even useless code.

> -	if (type == ADXL313_ACTIVITY)
> +	if (type == ADXL313_ACTIVITY) {
>  		en = cmd_en && threshold;
> +	} else {
> +		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
> +		if (ret)
> +			return ret;
> +
> +		en = cmd_en && threshold && inact_time_s;
> +	}

...

> +			case IIO_EV_DIR_FALLING:
> +				ret = regmap_read(data->regmap,
> +						  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
> +						  &inact_threshold);
> +				if (ret)
> +					return ret;
> +				*val = inact_threshold * 15625;
> +				*val2 = 1000000;

MICRO ?

> +				return IIO_VAL_FRACTIONAL;
>  			default:
>  				return -EINVAL;
>  			}

-- 
With Best Regards,
Andy Shevchenko



