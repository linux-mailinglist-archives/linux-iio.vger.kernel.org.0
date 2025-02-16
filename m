Return-Path: <linux-iio+bounces-15612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36707A37791
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 21:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450483AE95F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547B1A23BC;
	Sun, 16 Feb 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCPJNAZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CEE55B;
	Sun, 16 Feb 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739433; cv=none; b=jqp+UF0nXBhAxGnabhwTTWWKB96DbvvTds0D360x4ogbetqhj4c9BVRQgCPKgnviYy3mCe9VlxYIc8mewS+NdmlvVf950PLqNUbsU6Gb65cViHI7SBtOjMnIifXADgyvGtJkjkvXCON9B97HRpVCogIQmd0Sii5hpc+aMy4NM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739433; c=relaxed/simple;
	bh=qpmYDbI5414LoAXsg1Wso6jHCQCn0aAfZK4f38DxgKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvSeq4grtSfYFqiLpURFqSmTeNRN104g2/uOJKKPa0MxfI0RG1Ial5qwVatK2jl8lPBq6ItV1JNIGYgXBkM3emkqxa6B9Nk0JhCvZV+HUe3FW8jbriQV7dC+GdR0XHouRG4gum1trwLkEhH0iULZdkCoXS0wsMUHeSfp0CB9lVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCPJNAZ1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739739433; x=1771275433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpmYDbI5414LoAXsg1Wso6jHCQCn0aAfZK4f38DxgKQ=;
  b=KCPJNAZ1Oxg/h5wOzCYLFaiL77MKd4pPsn0YAtV5xwVnrKkamHRDtK/w
   MWLQ9oIPIoKUDRDJl30VbNWK488BLcg0uW8rqLIYn8sljRR4afQNTZSR5
   nHfGXc0+m/+NioP5nXxnOh/FhCkoeAz/7s1xR+vERAieD/BSrdEAKXldH
   vVrtA323nkSU9YZzpB2O3nPPxyB7Ucj294ilbeQJErMzULhI9ZWCStnNm
   jaZrhKq8bK8+vdjY1pjk+Zpej2xp4ehFanlYuq4wKW34OmoTNMD8vbRER
   a8VqW6jpeTmJlU/o9uRTRmngXFoy7kYTmMqXFiQH7kCL5OQxgUnYuPhEt
   g==;
X-CSE-ConnectionGUID: 4yngzIveQEWeAs6P7xZxjQ==
X-CSE-MsgGUID: GjVKyzd8SXy1RyqfBKFasA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44181715"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="44181715"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:57:12 -0800
X-CSE-ConnectionGUID: HOa9lWoOSHerZgpKhD32FA==
X-CSE-MsgGUID: X7QjEGsGQnSqteClj9z9KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="114576033"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:57:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tjlhH-0000000CDJt-46jj;
	Sun, 16 Feb 2025 22:57:03 +0200
Date: Sun, 16 Feb 2025 22:57:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <Z7JRH8ITxA2KOozH@smile.fi.intel.com>
References: <20250216162721.124834-1-clamor95@gmail.com>
 <20250216162721.124834-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216162721.124834-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 16, 2025 at 06:27:20PM +0200, Svyatoslav Ryhel wrote:
> AL3000a is a simple I2C-based ambient light sensor, which is
> closely related to AL3010 and AL3320a, but has significantly
> different way of processing data generated by the sensor.

...

> +static int al3000a_set_pwr_on(struct al3000a_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret) {
> +		dev_err(dev, "failed to enable vdd power supply\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
> +	if (ret) {
> +		dev_err(dev, "failed to write system register\n");

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

> +}

...

> +static void al3000a_set_pwr_off(void *_data)
> +{
> +	struct al3000a_data *data = _data;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_DISABLE);
> +	if (ret) {
> +		dev_err(dev, "failed to write system register\n");
> +		return;
> +	}
> +
> +	ret = regulator_disable(data->vdd_supply);
> +	if (ret) {
> +		dev_err(dev, "failed to disable vdd power supply\n");

> +		return;

This is not needed, but I understand the intention. To me, nevertheless, seems
better to return an error to upper layer.

> +	}
> +}
> +
> +static int al3000a_init(struct al3000a_data *data)
> +{
> +	int ret;
> +
> +	ret = al3000a_set_pwr_on(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_write(...);

> +}

...

> +static const struct i2c_device_id al3000a_id[] = {
> +	{"al3000a", },

Remove redundant inner comma. And make style consistent with OF, i.e. surround
string with spaces.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, al3010_id);

Copy'n'paste error, obviously. Please, test every version before sending.

> +
> +static const struct of_device_id al3000a_of_match[] = {
> +	{ .compatible = "dynaimage,al3000a" },
> +	{ /* sentinel */ }
> +};


-- 
With Best Regards,
Andy Shevchenko



