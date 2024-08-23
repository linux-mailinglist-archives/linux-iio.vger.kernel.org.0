Return-Path: <linux-iio+bounces-8730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B027A95D577
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31921C2209B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12C139D0A;
	Fri, 23 Aug 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7QfnfJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9F8F6B;
	Fri, 23 Aug 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438881; cv=none; b=hTW5jn3w2lnaxP4BHkXh2klqzTVlOuyUZS1t9MGFXHfVfGxkvUCErSn+u7wpAyi5scjN3609aVFTepa26foL6yzOZU2gmwdHbgJFa8PGrgnqza98iBCuEwaBugGe/w6lVS/PUCRpaoIaCndoIv00C4NJgqcnrk7QGCc5e2XQgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438881; c=relaxed/simple;
	bh=Y5H1f02bfP18o0eJ+LoR6Sc1Cx4Rlj1kHHn4/9asXyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbcyV3vufYGBmEUqHvku1QwZ4G5DptLWXyy7zdVhhMC0kkIi42etVJYT9qNnt/KpGJApE6XMBuZsAiRQ+lIffhfAfhXJQusdHIsv0E//xgm6WpQSOiRH8KQol46dtkCv5aJf+xDLQUjrYHXnLZ+dVSRyosyUAt0V9G8fO+CgOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7QfnfJD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724438879; x=1755974879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y5H1f02bfP18o0eJ+LoR6Sc1Cx4Rlj1kHHn4/9asXyI=;
  b=F7QfnfJDZIY5oRYcK7/BSAONKdHfX/bKojlxgVUs35YwXOhYFzZfPmDd
   VgXizsjSky7T+B2NBxP73ltdShXSyC4ynVSEuOdxV+50SPmJVXZv/Lgpj
   P3qN2FSfmor4m/sM7FzC7Xi7W/G/U95DHdlMZLRlTtEt9jua2GRWa1J09
   0mndjECwp2ZktXm49ZvpXtymLO79a7lOzm1P+sEv89c9YtEScUr2r6ucI
   4cR6tHIMaQ9zvRfG9VmkBYPX80mIhuTnJjnWR6CWuj76vo2mU0KiRJzg7
   OvDF+mFfn+OAaG1g08cALzLiXW8P2BbiM/Z+NKF2SzSkT2lEgjT8hpLpf
   Q==;
X-CSE-ConnectionGUID: PAoB8B+mQ2GI+05QZQQNmA==
X-CSE-MsgGUID: Kii+wUytTnuskxKyyy/WvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="13175511"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="13175511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:47:59 -0700
X-CSE-ConnectionGUID: bKHjxvGKRHCYYKn26MzvHw==
X-CSE-MsgGUID: Q2kZeuerQiS1odKhdrtKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="62180236"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:47:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shZJj-00000000zPw-1AM6;
	Fri, 23 Aug 2024 21:47:23 +0300
Date: Fri, 23 Aug 2024 21:47:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: pressure: bmp280: Use bulk read for humidity
 calibration data
Message-ID: <ZsjZOkglW1lGDNr8@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 08:17:08PM +0200, Vasileios Amoiridis wrote:
> Convert individual reads to a bulk read for the humidity calibration data.

...

> +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> +	calib->H3 = data->bme280_humid_cal_buf[H3];

> +	h4_upper = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
> +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, h4_upper);

This is a bit confusing. I would add a tmp variable and have this as

	tmp = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, tmp);

Also note indentation issues.

> +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> +	calib->H6 = data->bme280_humid_cal_buf[H6];

...

>  		/* Calibration data buffers */
>  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];

Side note: I would see rather sizeof(__Xe16) than 2:s in the above definitions.

> +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];

-- 
With Best Regards,
Andy Shevchenko



