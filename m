Return-Path: <linux-iio+bounces-9484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD4977C8E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CA4287801
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903021D6DBB;
	Fri, 13 Sep 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWbWyGvp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5D1BF7E3;
	Fri, 13 Sep 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221124; cv=none; b=equGvNshAiNFflTEeGIVH+2JgXlmR2BlcE78jDGViG6Fw/1S/mIshLHlWuzCrCis1ONjrOCNjlftQv4d1FVjBZLL/2kidqhHL9GBEjChOTy4Uj0/Ff/wQzgYbad11OdWo9dxf1kQx/N9us2yvFwh+5nGeXlCWkwTWtJb0qI/jHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221124; c=relaxed/simple;
	bh=HouVnrGuBJ0vEff0wCB7G3P0H8zvJt0xl3sx03nL+9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD53chuNHB3U8soPA4cIMPlaZTt7fAUgUaa6eb6oJky/ulcD1rOkHl5jRB3YzcarIIODj2QRWwdsuPSTWJ5yxDfOqg7TGEdivszSI+oESAS4mw4UjQx3QVl7IeFRFnASca/Szz1mVv+ouQcQ6qP39JW8XomrCTXUzrb1W4beKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWbWyGvp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726221123; x=1757757123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HouVnrGuBJ0vEff0wCB7G3P0H8zvJt0xl3sx03nL+9s=;
  b=UWbWyGvpO94TjFDJ6vWTxHENA95S3f6+LqGBUgO72vVli5XXgZUew+TN
   dNi5gb725nK9GE9P545fo52sFCtsKnGeLfT1/SVpZmjNXnJgCySfsYn6Q
   ACX0rECaETqvS0xp9PpMWkPl98Zvg6hFpG7b1mPuHvxF66pnii0WLbhz2
   3F7Mz5MgbmmNgTYz0+XAL0ujt1bjGBMf+AWlQGg/J1zkzP9wR3FXIDruH
   ZySt5MR6cHW5UMtYSyQIg11xazLxsxVmujwX4BkJCGGlmjvZd+xkkCbI9
   u+SloY/aIybEeko7XeU0b6aFBv0cHtwng11kHi1hHe9O9TdNGXkabuu6K
   Q==;
X-CSE-ConnectionGUID: RnZHSr8uSzStu5MyzMiUZA==
X-CSE-MsgGUID: 1YkqcsczTMahIaIr3QPO5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="42623783"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="42623783"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:52:02 -0700
X-CSE-ConnectionGUID: /WndNwMjT1+h2WtZf2XsIg==
X-CSE-MsgGUID: xM/yDa8VQsCnWNjxzeUH/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72804129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:51:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2y3-00000008FWm-2hSM;
	Fri, 13 Sep 2024 12:51:55 +0300
Date: Fri, 13 Sep 2024 12:51:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZuQLOwjQUTjo1nPg@smile.fi.intel.com>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <20240912233234.45519-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912233234.45519-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 01:32:31AM +0200, Vasileios Amoiridis wrote:
> Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> Sensors BMP18x and BMP085 are old and do not support this feature so
> their operation is not affected at all.
> 
> Essentially, up to now, the rest of the sensors were used in normal mode
> all the time. This means that they are continuously doing measurements
> even though these measurements are not used. Even though the sensor does
> provide PM support, to cover all the possible use cases, the sensor needs
> to go into sleep mode and wake up whenever necessary.
> 
> The idea is that the sensor is by default in sleep mode, wakes up in
> forced mode when a oneshot capture is requested, or in normal mode
> when the buffer is enabled. The difference lays in the fact that in
> forced mode, the sensor does only one conversion and goes back to sleep
> while in normal mode, the sensor does continuous measurements with the
> frequency that was set in the ODR registers.
> 
> The bmpX_chip_config() functions which are responsible for applying
> the requested configuration to the sensor, are modified accordingly
> in order to set the sensor by default in sleep mode.
> 
> DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> the BMP58x version, are not added.

...

> +	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
> +	    (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {

I would add one more space to make the indentation follow the logic.

(no need to resend until Jonathan asks for it, otherwise I believe
 he can amend this whilst applying)

> +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> +		return -EBUSY;
> +	}

...

> +		/*
> +		 * According to the BMP3 Sensor API, the sensor needs 5000us

Can we use 5ms...

> +		 * in order to go to the sleep mode.
> +		 */
> +		fsleep(5000);

...and 5 * USEC_PER_MSEC here respectively?

-- 
With Best Regards,
Andy Shevchenko



