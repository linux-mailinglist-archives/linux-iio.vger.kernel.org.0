Return-Path: <linux-iio+bounces-25610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9CC1915F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1361C86A33
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2927314D0B;
	Wed, 29 Oct 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsAjmzo6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D817C9E;
	Wed, 29 Oct 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726297; cv=none; b=oQ7txd+6pT9CEAB1fLSUIEekjdxvjKENLh1cPr68Mn4AJj3Q1hdTjmZ16QF949YxeBuTSJ9d2kGLtMIO0tUAaRrTGaNpPlVJLAYS4x9m2P8edgmt0EchKn4f/KpGtfNVVsdZ5uNI1+YeLzk8YEQ6Kt42vrQMNf4mFojjNEMf2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726297; c=relaxed/simple;
	bh=yrgcVezLRmm2YgpELgOSxV94qyQRxfNwHl0FkZBkbXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAu+SAKI/ORqKhpUOV7jHLilQ0EqSG0p8hQuyj3M4PVQZqdt7q5Z9ssxwVprL3QWHxGym0AyJlyTC78kAtul/b1vMN/CBCBZ5DXdKMK6asC+a/ZY9h6DJ3z+uHG58k6oWnmOdVWqH9SOoV+gXNwK9K6SJmmM2ow1SqWCEv7mC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsAjmzo6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761726295; x=1793262295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yrgcVezLRmm2YgpELgOSxV94qyQRxfNwHl0FkZBkbXg=;
  b=TsAjmzo66Yuek9xpObriBYLQwFqpdqyP4Ag2c7fVTP9l5gPvd+h2EURQ
   +HvSWYIBRBJVCPh7gmtt0VJt/G7JmPAeNlavmk/ylN3CLNlDEsuYWQQJq
   3mzL1S2/82ir+l87/cOoE1pprJ07NfSOAachwKvwKfPGbIQuWWqaBzV3C
   rYhFmIKxsXpuz9aiPpxQa3RsWbEDbw20+rdN7ydN4EQPuybiM0Y9P/JeQ
   jR7k2xGQ9oZ6NZ1jy5k8QiHo2BlLONtF1TcMTo/mIr39M3+jPMddhoyrZ
   PJrpQPEUAQC4xd7Hir7gNVimF5ql3l8BW5cucAuiob8b4nifVrUFn+nYe
   g==;
X-CSE-ConnectionGUID: VInqOl1lS36nnYo2N3AH+Q==
X-CSE-MsgGUID: QHA7E9GgS9CqazLKk8DiTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62867351"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="62867351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:24:54 -0700
X-CSE-ConnectionGUID: Gr54iMgpQLW77h13uHEVQg==
X-CSE-MsgGUID: /2DjhMatSK+Y6DgT7Gu/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185225598"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.248])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:24:52 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vE1U9-00000003YOO-2XGH;
	Wed, 29 Oct 2025 10:24:49 +0200
Date: Wed, 29 Oct 2025 10:24:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mpl3115: add threshold events support
Message-ID: <aQHPUQ5bU7sFojul@smile.fi.intel.com>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028213351.77368-3-apokusinski01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 10:33:52PM +0100, Antoni Pokusinski wrote:
> Add support for pressure and temperature rising threshold events.

...

> @@ -322,7 +339,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>  			.storagebits = 32,
>  			.shift = 12,
>  			.endianness = IIO_BE,
> -		}
> +		},
> +		.event_spec = mpl3115_temp_press_event,
> +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
>  	},
>  	{
>  		.type = IIO_TEMP,
> @@ -338,7 +357,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>  			.storagebits = 16,
>  			.shift = 4,
>  			.endianness = IIO_BE,
> -		}
> +		},

Just a side note below, no action from you required on this!

Yeah, yet another reminder for the comma/not-a-comma choices made initially and
why it's important to follow the advice

> +		.event_spec = mpl3115_temp_press_event,
> +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };

...

> -	if (!(ret & MPL3115_INT_SRC_DRDY))
> +	if (!(ret & (MPL3115_INT_SRC_DRDY | MPL3115_INT_SRC_PTH |
> +		     MPL3115_INT_SRC_TTH)))

Can we rather keep this split logical?

	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
		     MPL3115_INT_SRC_DRDY)))

>  		return IRQ_NONE;

...

> -	u8 ctrl_reg1 = data->ctrl_reg1;
> -	u8 ctrl_reg4 = data->ctrl_reg4;
> +	u8 ctrl_reg1, ctrl_reg4;

> +	guard(mutex)(&data->lock);

Why this is moved? Before the access to the data->ctrl* was done without
locking. Is it an existing bug?

> +	ctrl_reg1 = data->ctrl_reg1;
> +	ctrl_reg4 = data->ctrl_reg4;
>  
>  	if (state) {
>  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
>  		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
>  	} else {
> -		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
>  		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> -	}
>  
> -	guard(mutex)(&data->lock);
> +		if (!ctrl_reg4)
> +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> +	}
>  
>  	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);

...

> +static int mpl3115_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 int_en_mask;
> +	u8 ctrl_reg1, ctrl_reg4;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
> +		break;
> +	case IIO_TEMP:
> +		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	guard(mutex)(&data->lock);

Similar Q here, why do you protect data that was (still is?) not protected before?

> +	ctrl_reg1 = data->ctrl_reg1;
> +	ctrl_reg4 = data->ctrl_reg4;
> +
> +	if (state) {
> +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> +		ctrl_reg4 |= int_en_mask;
> +	} else {
> +		ctrl_reg4 &= ~int_en_mask;
> +
> +		if (!ctrl_reg4)
> +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> +	}
> +
> +	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> +}

...

> +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int ret, press_pa;
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    MPL3115_PRESS_TGT, 2,

sizeof() ?

> +						    (u8 *) &tmp);

Here and elsewhere, drop the space between casting and operand.

> +		if (ret < 0)
> +			return ret;
> +
> +		/**

It's not a kernel-doc.

> +		 * Target value for the pressure is
> +		 * 16-bit unsigned value in 2 Pa units
> +		 */
> +		press_pa = be16_to_cpu(tmp) << 1;
> +		*val = press_pa / KILO;
> +		*val2 = (press_pa % KILO) * MILLI;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
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

...

> +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 tmp[2];

Use proper __be16 type.

> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		val = (val * KILO + val2 / MILLI) >> 1;

> +		if (val < 0 || val > 0xffff)
> +			return -EINVAL;

U16_MAX?

> +		tmp[0] = FIELD_GET(GENMASK(15, 8), val);
> +		tmp[1] = FIELD_GET(GENMASK(7, 0), val);
> +
> +		return i2c_smbus_write_i2c_block_data(data->client,
> +						      MPL3115_PRESS_TGT, 2, tmp);

sizeof()

> +	case IIO_TEMP:
> +		if (val < -128 || val > 127)
> +			return -EINVAL;

S8_MIN, S8_MAX ?

> +		return i2c_smbus_write_byte_data(data->client,
> +						 MPL3115_TEMP_TGT, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



