Return-Path: <linux-iio+bounces-18973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41619AA6DFD
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9996F4A633F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B122F176;
	Fri,  2 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5QT+9Jy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7822E3F0;
	Fri,  2 May 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177796; cv=none; b=oaka13bPlpaWFXY9Jn44oShprG+N8tQrDDOGQFToFc8oGa4AKA9TGORuXZzMWqcQ/O0W/TkWs09VPxZPbMUrh89BkL+BkaZD77fg8Jx8DBsFIdE3o8DiaTRpFolneEiv7IrMBRsncCVenJr/LgnP5MJNEfQQ9yueFM1AzxZ0M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177796; c=relaxed/simple;
	bh=U++3sNlCPeeANu+nz6fN0S33H3Je9z9LoqgHkKhQ0fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmZe5PPYBFACz9dpZ2v2Day/o+XHBb0Pd3r8hqe0fNuJUOu9i5ybYyiBhKahN1xvCH3BD5Z9/WimYNItdT6YlADdZtS8708nKSMcdWmgYZjQ78JwagPkq4zmqVlcasf7A2OzVkj33SqS6GZnhLvkJwIvQwcfAXp9tjDszzsXsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5QT+9Jy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746177795; x=1777713795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U++3sNlCPeeANu+nz6fN0S33H3Je9z9LoqgHkKhQ0fo=;
  b=a5QT+9JyayPJIWIyZ4QHQOG3Oq4QqpMSNncnaPKExBFP3q3+9oPyNwd9
   p8WBSX9ZaXfrhJRIEqSQOaDW9V2Tfb2hPs4o106dUY4iO0sBIALSI2n6I
   ndBwrzrZ8toNXCeUb2G01IQrkoobv3a899gwa6auZcKTvT0I4d77wXNbj
   DJI9cQtxp041Wyv6N1Dc+ytSSb2YHYz+1b8ShgzxKMkyBDAVcSQol0MVO
   CL4QGURQtzPamlVB69cREzrM+oN5me9cRIuGFS20FffGeo7YOL95ymASH
   hG2t9dMm34m9ZJNpGyAOAJN0CYY2Gx6lrxMDXtUPS84gZPsf5Xrap+pmm
   w==;
X-CSE-ConnectionGUID: bjQcJeg0TyOOGe+RE1dNjw==
X-CSE-MsgGUID: xRMmoHR8TDSUtOktgOgVDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47945288"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47945288"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:23:14 -0700
X-CSE-ConnectionGUID: iiQ1d/qGSoeCjpfWWLMd/Q==
X-CSE-MsgGUID: vFfdScTFQX6wwFxCDBTG2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165662214"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:23:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAmbq-00000002958-17hD;
	Fri, 02 May 2025 12:23:06 +0300
Date: Fri, 2 May 2025 12:23:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, tgamblin@baylibre.com,
	olivier.moysan@foss.st.com, alisadariana@gmail.com,
	gstols@baylibre.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aBSO-o4OFrXKJ82C@smile.fi.intel.com>
References: <20250429025505.3278016-1-j2anfernee@gmail.com>
 <20250429025505.3278016-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429025505.3278016-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 29, 2025 at 10:55:05AM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

...

> +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	int  err;

One space too many.

> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EOPNOTSUPP;
> +
> +	if (dir == IIO_EV_DIR_FALLING)
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +	else
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +
> +	return err;
> +}

...

> +	/* Enable Channel */

Channels

> +	if (chip->num_vin_channels <= 8)
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +				   GENMASK(chip->num_vin_channels - 1, 0));

Why can't you use the value kept in data variable?

> +	else
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +					&data, sizeof(data));
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable channel\n");

-- 
With Best Regards,
Andy Shevchenko



