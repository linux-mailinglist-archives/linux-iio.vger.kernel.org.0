Return-Path: <linux-iio+bounces-8859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F19643FC
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF863B2163C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157D19309C;
	Thu, 29 Aug 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7uwBVz1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414118FC80;
	Thu, 29 Aug 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933431; cv=none; b=Xf9zhb2v1AI6r8hO6plXeL3V079jnTfObVH8EgOTvwoXgohMZZ0Q/MEVCXdNOS7+QJfpLS6zwH76ZugMBntXAfr1E8XdeELMT/b/Lfkh2gzZETdrFfonKK/xqhKnlfn7RQKYWoy1DkusMy2wb/m43DbpvlbHPy9e/ZbPhd+F5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933431; c=relaxed/simple;
	bh=BWfIxDIszghKM72xsGimQvm8ebIufTqI4ZhtIW6GIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfgJQ07QSaPr8JqvUN+WADstU+8/zdmcicx6LspE7iiwfUQlxhS0nLg3Ziord+tXL5fgeCXCtnXRtNHXMOnvMqQGX9DbUX/eu7HsBA6KzZqLzZccc7Qfxu4aCOiPDKGvr1TNLnAZBjMhUIcifYcUmKS2NGaOxOcIndJTGmRKMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7uwBVz1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724933430; x=1756469430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWfIxDIszghKM72xsGimQvm8ebIufTqI4ZhtIW6GIUM=;
  b=C7uwBVz1+Wj0/ZcMhlstEoBPqOfhVu3xElhVmp/hOoM0kn7Q5kNwCxHl
   FKDlrF9aKbvIFnJuEhQkO7p4dXlDwzJ7y3WLGFQb5w14lAxyIlHWT2Zzy
   3Udu1vGFy0vST1bRqyPl0TbZVuzGmGEoFFvLKnUr7ZWcbnRsDwOBG1IXb
   heQNFMElV01T4eIi2h3/u8ZfDagVvw+IkU7Q1SQjl5apQZ7XaJQzMx7fU
   May9hQUDM/uOtJtwoMQ2zOuU3qM9XIu8Ys8jvYQY/GXsMK5+H3LMGTOVU
   8bfymByUaBZJmT/Hsfm7EE8blQBgj7vMj+b0MbLNL42usOvwxM8WiVmkr
   Q==;
X-CSE-ConnectionGUID: w/E3D5mnTWeNWItDVsZ00Q==
X-CSE-MsgGUID: hpIIKBZ9QW28ZxlkB78w4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34925366"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34925366"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:10:29 -0700
X-CSE-ConnectionGUID: nRXq7b6aTYaLKmfp7VVK/A==
X-CSE-MsgGUID: smeY+cGdTMi27zwovyjM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63759310"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:10:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjdyp-00000002zJ6-0TKa;
	Thu, 29 Aug 2024 15:10:23 +0300
Date: Thu, 29 Aug 2024 15:10:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <ZtBlLqLgpi2h6kMl@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828205128.92145-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:22PM +0200, Vasileios Amoiridis wrote:
> The BM(P/E)28x devices have an option for soft reset which is also
> recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> initial configuration of the device.

...

> +static int bmp280_preinit(struct bmp280_data *data)
> +{

With

	struct device *dev = data->dev;

it will look better?

> +	unsigned int reg;
> +	int ret;

> +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> +	if (ret)

> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to reset device.\n");

		return dev_err_probe(dev, ret, "Failed to reset device.\n");

> +	/*
> +	 * According to the datasheet in Chapter 1: Specification, Table 2,
> +	 * after resetting, the device uses the complete power-on sequence so
> +	 * it needs to wait for the defined start-up time.
> +	 */
> +	fsleep(data->start_up_time);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret)

> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to read status register.\n");

		return dev_err_probe(dev, ret, "Failed to read status register.\n");

> +	if (reg & BMP280_REG_STATUS_IM_UPDATE)

> +		return dev_err_probe(data->dev, -EIO,
> +				     "Failed to copy NVM contents.\n");

		return dev_err_probe(dev, -EIO, "Failed to copy NVM contents.\n");

> +	return 0;
> +}

Yes, it's up to 84 characters long, but I think it improves readability.

-- 
With Best Regards,
Andy Shevchenko



