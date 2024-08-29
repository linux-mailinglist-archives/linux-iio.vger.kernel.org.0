Return-Path: <linux-iio+bounces-8858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5D9643E6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEDC1F232D1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AD14B96F;
	Thu, 29 Aug 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL4bR+VA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8317191484;
	Thu, 29 Aug 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933199; cv=none; b=GXkQWzemwPgTWPn/r0PLG2UxNzJ+eUqbei6HQYeEoxS1GuHavhQGOHLFn1BwMEcfENlt3gHRLgIkDXwaru8nCZTolO4w+A1bA65cXrHxrkp7xfEbcTrofJ9Wb9z7TDpCTGzsnc4iVjovNitapwP8xHALb0WozkzcR6fhPGrdcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933199; c=relaxed/simple;
	bh=+E0TYoC9A8uXLguv/Jkw/zwcuXpNrTVLwhTVwVZOVSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QanxNghVeQWBurqjn29Yc1eTBaH6P41/w435QgFd0UsD05jfMEUU0gN5iJ44JzTO0pV1ZIbW3Wiph1o3fXsYDYF/pQZ9BNmAnDt6or7g/HqtcR8WVEagQzDa3cW03XMgC3hdVPW5AjWgnVDngH7HSrwn4QUWG/a+7D4iHPtq/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TL4bR+VA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724933199; x=1756469199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+E0TYoC9A8uXLguv/Jkw/zwcuXpNrTVLwhTVwVZOVSM=;
  b=TL4bR+VAzQfrlXWRK5srZ7kZWuQTJmakXhNBqxjpNxsTkFxxjgu5y7Er
   sb0Yis4o2DPiSl0NBWpYoEWK0kMuvlITHOgaqrTUxf0u1jh+moq7Ro18g
   BSHylHRG2uCUsUYywrMEB6zmG0XQJq2gBJoRPLxEOqktYbnrdTKHmYalg
   haknx6dEKhrmXK8g5M9UHdJSE17eOfXOqO4Himxs8m+ghkch0zjjs7e2O
   Nc82tpCTiVAwQz0rjNSsugZ6XV001IZBqgKwKe+ScMuDSs17X+BlVtR+T
   +T3qS1MMAJtyaOt7h4ONSGY7LWGdndA9SwMWCyoU5P0c2aMzYFHY7pxrG
   Q==;
X-CSE-ConnectionGUID: C7gF54MCTk6Y9ORacrU5Vg==
X-CSE-MsgGUID: xkQOdkvoQPKXf3VmgawSvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34894553"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34894553"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:06:37 -0700
X-CSE-ConnectionGUID: k+W/toi/TWe2IfsTonTjMg==
X-CSE-MsgGUID: lvERwannT0OBKxNI/IUyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63890665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:06:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjduo-00000002zFD-1bmO;
	Thu, 29 Aug 2024 15:06:14 +0300
Date: Thu, 29 Aug 2024 15:06:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 1/7] iio: pressure: bmp280: Use bulk read for humidity
 calibration data
Message-ID: <ZtBkNu0luJyT1emw@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828205128.92145-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:21PM +0200, Vasileios Amoiridis wrote:
> Convert individual reads to a bulk read for the humidity calibration data.

...

> +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> +	calib->H3 = data->bme280_humid_cal_buf[H3];
> +	tmp_1 = get_unaligned_be16(&data->bme280_humid_cal_buf[H4]);
> +	tmp_2 = FIELD_GET(BME280_COMP_H4_GET_MASK_UP, tmp_1);
> +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, tmp_2);
> +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,

> +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));

Either I don't understand the side effects, or this is the same as tmp_1. No?

> +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> +	calib->H6 = data->bme280_humid_cal_buf[H6];

-- 
With Best Regards,
Andy Shevchenko



