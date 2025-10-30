Return-Path: <linux-iio+bounces-25649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433DC1EDE4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 419634E69F5
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9F337BBD;
	Thu, 30 Oct 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAeoE5X1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0373370E8;
	Thu, 30 Oct 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811055; cv=none; b=eFApbSa/2E5nL2P+w4HFDYqum+lhSkO0n2BzNqqYQLIpZ6w/5LValVaqu3lga+MxXgT9ZIef6QwJQX3rjBKYMoP1oD3lmQX2kI667Mm8T5dGXyneoZ6Na/oCQhWKDM7jhobDisKrMCqOp0oaxwygixQ0Z50JlJJxuUa8hnyxY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811055; c=relaxed/simple;
	bh=jmkoTYfXOYR/kQSWEvqT4Zd7d1/KE/iBvwy5wjdIF+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZVeWfDtGvufNosRscLQpMpnubX8Sz2zIjYJLeC970q4xGyxDa7zlZrsL41F7he/lkKbrnfddHV5dnGb/b+KbFCJuzrbqtAhsWIeLwFJmSG8vNZgQyXN86yfZ94Som5jq2j6nkuTLw6EPGy0JcK35lbtcZ7SqAj0XlxnVl367wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAeoE5X1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761811054; x=1793347054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmkoTYfXOYR/kQSWEvqT4Zd7d1/KE/iBvwy5wjdIF+g=;
  b=GAeoE5X1HwBYDwdYTqbrWMWxMDD1u/kZMWxwDGxRhT/crFsoS2AgFn2E
   ZSMUzXIyjHwz3lbYC2T6gtsmW0H24+KQkYPobMSH0lqHMI1XDr0wdh2Ws
   PJoV+u4ixe5vSPMmGm83XQYcMHq97RENAxhub+8xv+naVzykj1tIe0fqO
   FKG0i0KPKDDBQs6Azp4cQhdEvGlzWI5u7DNWvRklJQiv0i3sRZ+Wvwed9
   A2Go5+jYq5KjhtQZ4zXfaysXeQ4fQTyXDn8uJzUguOr6zv0SSVeTDEIGe
   72OiN7gwDcjC0IjzmOPMaTNZzbUgIzitgkZbZ7dZytQjpTK63vce1EnPP
   Q==;
X-CSE-ConnectionGUID: PAihyLHETXW0exdt552i6w==
X-CSE-MsgGUID: bgQifCB+ShqMge024Q0H6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75064810"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75064810"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:57:33 -0700
X-CSE-ConnectionGUID: GcRp7Q2aSSGTPgNXsvhsJQ==
X-CSE-MsgGUID: pRiA4t45TN66otEe3kWBxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185821911"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:57:32 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENXF-00000003pwl-0Nl3;
	Thu, 30 Oct 2025 09:57:29 +0200
Date: Thu, 30 Oct 2025 09:57:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <aQMaaHWjgC2GMGmj@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-2-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:27:44AM +0100, Francesco Lavra wrote:
> Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> for the iio_chan_spec struct arrays makes all sensors advertise
> channel event capabilities regardless of whether they actually
> support event generation. And if userspace tries to configure
> accelerometer wakeup events on a sensor device that does not
> support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> a NULL pointer when trying to write to the wakeup register.
> Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> initialization of struct iio_chan_spec arrays, where the
> st_lsm6dsx_event structure is only used for sensors that support
> wakeup events; besides fixing the above bug, this serves as a
> preliminary step for adding support for more event types.


Sounds like a bug fix. Fixes tag?

...

> +static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct st_lsm6dsx_hw *hw,
> +				enum st_lsm6dsx_sensor_id id, int index)
> +{
> +	struct iio_chan_spec *chan = &channels[index];
> +
> +	chan->type = (id == ST_LSM6DSX_ID_ACC) ? IIO_ACCEL : IIO_ANGL_VEL;
> +	chan->address = hw->settings->chan_addr_base[id] + index * ST_LSM6DSX_CHAN_SIZE;
> +	chan->modified = 1;
> +	chan->channel2 = IIO_MOD_X + index;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	chan->scan_index = index;
> +	chan->scan_type.sign = 's';
> +	chan->scan_type.realbits = 16;
> +	chan->scan_type.storagebits = 16;
> +	chan->scan_type.endianness = IIO_LE;
> +	chan->ext_info = st_lsm6dsx_ext_info;

+ blank line

> +	if (id == ST_LSM6DSX_ID_ACC) {
> +		if (hw->settings->event_settings.wakeup_reg.addr) {
> +			chan->event_spec = &st_lsm6dsx_event;
> +			chan->num_event_specs = 1;
> +		}
> +	}

if (foo) { if (bar) {}  } == if (foo && bar).

Based on this I'm in doubt what to suggest here as to me sounds like those
couple of lines might deserve for a helper.

Hence two options:
1) do an equivalent conditional and reduce indentation level;
2) do a helper with the inner conditional.

+ blank line

> +	return 0;
> +}

...

> +	channels = devm_kzalloc(hw->dev, sizeof(*channels) * ST_LSM6DSX_CHAN_COUNT, GFP_KERNEL);

devm_kcalloc()

> +	if (!channels)
> +		return NULL;

I would expect comment here...

> +	for (i = 0; i < 3; i++) {

3 might need to be defined.

> +		if (st_lsm6dsx_chan_init(channels, hw, id, i) < 0)
> +			return NULL;
> +	}

+ blank line

...and perhaps here to explain what's going on here.

> +	channels[3].type = IIO_TIMESTAMP;
> +	channels[3].channel = -1;
> +	channels[3].scan_index = 3;
> +	channels[3].scan_type.sign = 's';
> +	channels[3].scan_type.realbits = 64;
> +	channels[3].scan_type.storagebits = 64;

+ blank line.

>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  	iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
> -	iio_dev->channels = hw->settings->channels[id].chan;
> -	iio_dev->num_channels = hw->settings->channels[id].len;
> +	iio_dev->channels = channels;
> +	iio_dev->num_channels = ST_LSM6DSX_CHAN_COUNT;

-- 
With Best Regards,
Andy Shevchenko



