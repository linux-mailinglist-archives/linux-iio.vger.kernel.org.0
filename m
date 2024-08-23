Return-Path: <linux-iio+bounces-8735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B893695D5ED
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E251F224E4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454301922E4;
	Fri, 23 Aug 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MF+Of4PT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156F193072;
	Fri, 23 Aug 2024 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440446; cv=none; b=uPMogyW0BMQr+rqRiewUG/PI98hrXjQ3qB5KU81vziormHvOU1EeB9aBq4LKz3Nl93hKWDCEt3LWztk88c2xEjWjNNLowwGhVrqV3oXBNoJjL3Z+XPG7v9I2hkviUnzSrpVML4aK0Hq4eQEpUfDOni4eJEuNhubL8IkPlaiAunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440446; c=relaxed/simple;
	bh=yHeI6cJVsQpHy3FEAWL2NUyHUh+xPNNDxdHPfT1Jcdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQFKQR6l64DntDH2F2FEoB817qS+tBLl8BAfODBZ+Vd9NHw5jxLQ87dIwKGGwrFiKeudby8t+eb1iIVk9/eC13nVJqdqdD8AEFwSQsl+2Csn/WfahEI6SP3BxhBrUzYNLkAFi51j9+CYsqk4j+nPizjwL1nT2QoiewFD6n2DFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MF+Of4PT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724440444; x=1755976444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHeI6cJVsQpHy3FEAWL2NUyHUh+xPNNDxdHPfT1Jcdk=;
  b=MF+Of4PTDUs48XU9ndjIY8RnXIXmlx4RZ9bOVSaP/xxIjGpdJ9YbnRGP
   PBVD5nvj4RKibfk9eBsWpLKPqzB39umqpvZbOap6bIhDn6g0uaPL+UQRa
   KcmrSQyWLXwdSJmPgey33uRhxCGHPn4ym4nms00ZzbQHYqJmJ7TCnlOcJ
   106rzZG22xdatjVj8B/REsYdvkGtOQtKkXDeAOZsF7saHSXxs3lXNbbBn
   MIspEyQZfr8W6bZCDRshd1RmSpEM1cur6VO/uyymlaHQoLJ2nsye9qZS+
   pPaNT/wm5rXpa6pwbtqbzAM++1e3wJtTKv4QYoVd4lCX3I5ih+uy0p6qQ
   Q==;
X-CSE-ConnectionGUID: CLxOy75dTPizGa+xipbBrQ==
X-CSE-MsgGUID: JdMpgkjNSGSwJ+uTVcIylQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33549407"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33549407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:14:04 -0700
X-CSE-ConnectionGUID: QTX1HO55QSeg9Z0VGC4E/g==
X-CSE-MsgGUID: vQnduMpbQze5nqMSU6ZePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92681951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:14:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shZjR-0000000107a-1ta6;
	Fri, 23 Aug 2024 22:13:57 +0300
Date: Fri, 23 Aug 2024 22:13:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <ZsjfdRWRl4fMJP0Y@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 08:17:09PM +0200, Vasileios Amoiridis wrote:
> The BM(P/E)28x devices have an option for soft reset which is also
> recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> initial configuration of the device.

...

> +static int bmp280_preinit(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to reset device.\n");

> +	usleep_range(data->start_up_time, data->start_up_time + 500);

Seems long enough to warrant the comment. Also, why not fsleep()?

> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to read status register.\n");
> +
> +	if (reg & BMP280_REG_STATUS_IM_UPDATE)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to copy NVM contents.\n");
> +
> +	return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko



