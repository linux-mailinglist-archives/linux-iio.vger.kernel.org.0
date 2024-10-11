Return-Path: <linux-iio+bounces-10447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552E99A193
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948DAB24202
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06321262E;
	Fri, 11 Oct 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qspm5aAV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D01E3DC0;
	Fri, 11 Oct 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643085; cv=none; b=VXbM9agYNknheMvHqtOaKqpL07GCm85FAsZ/TejouvFFAXAC6GkP1VNf6VuPk7vYXgNruWG+ldNgivDTTc1JiaqWRe8MUZHSHgQCGqqFst1pALJbP3v2kBBah1TdUtz038Y73mypobvduS8609BfdoUoJQ9/f+uNtb2MXqqv6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643085; c=relaxed/simple;
	bh=1twMMpaoEITh/gUzq4DlkreG5Ork8s0bgnPmf4Efp98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUdYV1vdshq62y0XRmQZ8rO8FazmR6AVthB1vLY8S+rfGTnRfXI+uhkKdzoC0SXqUlQ9y9tnUGwK4ly5okYWKabA8KWuJlcbPsfI2moZhG0tousXguK3hlEZfRc8BGAY2f8MSrnwnH0JCqyd2d+2rM/P4q5kaLn05QP5gXFKlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qspm5aAV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728643083; x=1760179083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1twMMpaoEITh/gUzq4DlkreG5Ork8s0bgnPmf4Efp98=;
  b=Qspm5aAVZTF7gQAp1BVrEynDr0Scv44bSRydcLbUqi3vqURIanjON37S
   8JCIRLJq+oEOU2+cvMVvFUww1+PKtx3dxKm9XUnVntB7aB92w4/nTN+1o
   0YyWM+7nR7c0OcsUAsm4WxNBf06g2T0OcDILmItHq72hHmKQc7wv9RgBW
   Wp0MH5Y3Snsa8q1RL7il7g4mc3B351kIRqe2IyJQUhnl6D7V/HdJOih5/
   +ShPMDAEBcCLnJM79XCxdRZXcE9QYOV7CKB/ALXPkEpEpEXXNmeQlkhgC
   mv9hRy51OTz90all8dCzxgp18PP/05wdeqjh/S2ZQVqZEq6notEpuJacv
   Q==;
X-CSE-ConnectionGUID: 7MXWBY4OTQi3coHeYSSIZQ==
X-CSE-MsgGUID: Kz2YYMkfREuQs268fjJD5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39412938"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39412938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:38:03 -0700
X-CSE-ConnectionGUID: yDegCgUPQzeOV92uc52/RA==
X-CSE-MsgGUID: SYY7ej28RmexZCixIS8/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76789959"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:38:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szD1x-00000001rSZ-0ebI;
	Fri, 11 Oct 2024 13:37:57 +0300
Date: Fri, 11 Oct 2024 13:37:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/13] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <ZwkABN9RycsVPRwo@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-13-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-13-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:29PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add triggered buffer and soft timestamp support. The available scan mask
> enables all the channels of the sensor in order to follow the operation of
> the sensor. The sensor basically starts to capture from all channels
> as long as it enters into FORCED mode.

...

>  	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
>  	int ambient_temp;
>  
> +	u8 buffer[ALIGN(sizeof(s32) * BME680_NUM_CHANNELS, sizeof(s64))
> +		  + sizeof(s64)] __aligned(sizeof(s64));

Can it be represented as a structure?
We also have aligned_s64 for the timestamp.

>  	union {
> -		u8 buf[3];
> +		u8 buf[15];
>  		unsigned int check;
>  		__be16 be16;
>  		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];

...

> +static irqreturn_t bme680_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	u32 adc_temp, adc_press, adc_humid, comp_press, comp_humid;

> +	s32 *chans = (s32 *)data->buffer;

With the structure in place this becomes much more readable.

> +	u16 adc_gas_res, gas_regs_val;
> +	s32 t_fine, comp_gas_res;
> +	s16 comp_temp;
> +	u8 gas_range;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = bme680_set_mode(data, BME680_FORCED);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = bme680_wait_for_eoc(data);
> +	if (ret)
> +		goto out;
> +
> +	/* Burst read data regs */
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_MEAS_STAT_0,
> +			       data->buf, sizeof(data->buf));
> +	if (ret) {
> +		dev_err(data->dev, "failed to burst read sensor data\n");
> +		goto out;
> +	}
> +	if (data->buf[0] & BME680_GAS_MEAS_BIT) {
> +		dev_err(data->dev, "gas measurement incomplete\n");
> +		goto out;
> +	}
> +
> +	/* Temperature calculations */
> +	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[5]));
> +	if (adc_temp == BME680_MEAS_SKIPPED) {
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		goto out;
> +	}
> +	comp_temp = bme680_compensate_temp(data, adc_temp);
> +	t_fine = bme680_calc_t_fine(data, adc_temp);
> +
> +	/* Pressure calculations */
> +	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[2]));
> +	if (adc_press == BME680_MEAS_SKIPPED) {
> +		dev_err(data->dev, "reading pressure skipped\n");
> +		goto out;
> +	}
> +	comp_press = bme680_compensate_press(data, adc_press, t_fine);

> +	pr_info("comp_press: %d\n", comp_press);

No debugging in the production code. Or if you really need that, it should
use dev_dbg().

> +	/* Humidity calculations */
> +	adc_humid = get_unaligned_be16(&data->buf[8]);
> +	if (adc_humid == BME680_MEAS_SKIPPED) {
> +		dev_err(data->dev, "reading humidity skipped\n");
> +		goto out;
> +	}
> +	comp_humid = bme680_compensate_humid(data, adc_humid, t_fine);

> +	pr_info("comp_humid: %d\n", comp_humid);

Ditto.

> +
> +	/* Gas calculations */
> +	gas_regs_val = get_unaligned_be16(&data->buf[13]);
> +	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
> +	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
> +		dev_err(data->dev, "heater failed to reach the target temperature\n");
> +		goto out;
> +	}
> +	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
> +	comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
> +	pr_info("comp_gas_res: %d\n", comp_gas_res);
> +
> +	chans[0] = comp_temp;
> +	chans[1] = comp_press;
> +	chans[2] = comp_humid;
> +	chans[3] = comp_gas_res;
> +
> +	/* Push to buffer */
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   iio_get_time_ns(indio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko



