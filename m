Return-Path: <linux-iio+bounces-25921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E2C366AD
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762A11A23925
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1A3321BC;
	Wed,  5 Nov 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0p7rc+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA01A3172;
	Wed,  5 Nov 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356327; cv=none; b=iIOIQqq38KohUCLdZbu/IumZzVAVkUZNwBJ0XYY9m4KDQFoqmc76gJZKMiHMoG/TT7Ngk2WPDuoUkaQG0OGCUvKh+HzacPWC7jdh3fOPu5RVYw7PobeU70xy0XGsichE9KEH2OAAfrC2hBYTDroJo7/Zmm//A61so8iUUi67uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356327; c=relaxed/simple;
	bh=HfvjEZ8zyKUtba01cWxDWXLISHrgdAAOlZhIhHId5TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r91uJb7WQlTpOPQyfuxy2RPu+oZ5XLS2r7H8N5ogaO8ICQux8EGjp4XpZwKBJguXJxa095ymDPqzc420kvTIUFzSvhv/9DY1zW5NHZ8nmzeWSUwFKy+KjrX33vhYSunBsbZAoEd8FA3yXrady23nry3R2CaKX0dsClmkdkZFpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0p7rc+n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762356326; x=1793892326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HfvjEZ8zyKUtba01cWxDWXLISHrgdAAOlZhIhHId5TU=;
  b=T0p7rc+npoi32U4SdKb/xiybwfkzYujBDdb3R0fOKaocsBPx6/zVEz3Z
   1+5PpBAKru/DCgHgv8rUq0N5x2O0lwXtr6j/jqGm4F6TVaQF/lOq/wyso
   bTzxZ3VXcS91bfgS6G13jo9bfitCD3nSfyqG/LJN0kFzcBe8KH9bhTMYz
   mwZ4IM+2wegeuNoNqslXw4pnJYutE5vNFviJbqW0RjMzckcj8ghqGJk5M
   eyVPzSCzHDjS9FB2iWJ/dLzQappOcp128PMdeASCvpMKUV3JgQF2REzlz
   KMMjhWVjyYdTDIeFUvpvkmfm7q+SGXElBSgvn7YGC+/O5BDYVMrLtGc4V
   A==;
X-CSE-ConnectionGUID: gMMTVAN0Sv6jbeIk8rhekQ==
X-CSE-MsgGUID: pfHeXYF1S32JyQxu+7KSug==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64507954"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64507954"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:25:25 -0800
X-CSE-ConnectionGUID: A7SgvF8rRdaIXVCFqgPLsA==
X-CSE-MsgGUID: sVKbbyk8R02GBNDNiNxmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="224728796"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:25:24 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGfNu-00000005pB7-2qhR;
	Wed, 05 Nov 2025 17:25:18 +0200
Date: Wed, 5 Nov 2025 17:25:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aQtsXcf_rHVdwqeZ@smile.fi.intel.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-3-apokusinski01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 10:56:14AM +0100, Antoni Pokusinski wrote:
> Add support for pressure and temperature rising threshold events. For
> both channels *_en and *_value (in raw units) attributes are exposed.
> 
> Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
> are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
> and write_event_config() needs to be now guarded by data->lock.
> Otherwise, it would be possible that 2 concurrent threads executing
> these functions would access the data->ctrl_reg{1,4} at the same time
> and then one would overwrite the other's result.

...

> static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)

>  	struct iio_dev *indio_dev = private;
>  	struct mpl3115_data *data = iio_priv(indio_dev);
>  	int ret;
> +	u8 val_press[3];
> +	__be16 val_temp;

s/_temp/$SOMETHING meaningful/ ?

>  	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
>  	if (ret < 0)
>  		return IRQ_HANDLED;
>  
> -	if (!(ret & MPL3115_INT_SRC_DRDY))
> +	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> +		     MPL3115_INT_SRC_DRDY)))
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_nested(data->drdy_trig);
> +	if (ret & MPL3115_INT_SRC_DRDY)
> +		iio_trigger_poll_nested(data->drdy_trig);
> +
> +	if (ret & MPL3115_INT_SRC_PTH) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PRESSURE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +						    iio_get_time_ns(indio_dev));
> +
> +		/* Reset the SRC_PTH bit in INT_SOURCE */
> +		i2c_smbus_read_i2c_block_data(data->client,
> +					      MPL3115_OUT_PRESS,
> +					      sizeof(val_press), val_press);
> +	}
> +
> +	if (ret & MPL3115_INT_SRC_TTH) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +						    iio_get_time_ns(indio_dev));
> +
> +		/* Reset the SRC_TTH bit in INT_SOURCE */
> +		i2c_smbus_read_i2c_block_data(data->client,
> +					      MPL3115_OUT_TEMP,
> +					      2, (u8 *)&val_temp);

Why not sizeof() here ?

> +	}
>  
>  	return IRQ_HANDLED;
>  }

...

> +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int ret;
> +	__be16 tmp;

Also name can be improved. And notice confusion between temp
(temporary?  temperature?) and tmp.

> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    MPL3115_PRESS_TGT,
> +						    sizeof(tmp), (u8 *)&tmp);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * Target value for the pressure is 16-bit unsigned value,
> +		 * expressed in 2 Pa units
> +		 */
> +		*val = be16_to_cpu(tmp) << 1;
> +
> +		return IIO_VAL_INT;
> +	case IIO_TEMP:
> +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Target value for the temperature is 8-bit 2's complement */
> +		*val = sign_extend32(ret, 7);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



