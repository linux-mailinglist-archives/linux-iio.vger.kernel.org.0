Return-Path: <linux-iio+bounces-25654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9EC1EF82
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1CA4E7BD3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926C335BAF;
	Thu, 30 Oct 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAI/LmWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3D32E69B;
	Thu, 30 Oct 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812684; cv=none; b=f1OJ/OC22XsKslN02azC5scj/mO4DbcFy67S64le6eVPCqK2kQuQb6iYVVquFA8a93Fsj5b1KVyYkKc+rYsRV2+q9UOpt428UsfIC4Ey67qvYkmwSLKxH8RqCv4H/+RsQpR44XV+MuxdpnIn/UP6BG27lslNcOZPtfLKHdQqqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812684; c=relaxed/simple;
	bh=b2dkplthGwsSV143iEmAOuYcZDKvI2X1EgZlXGLzbZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL51qLZj1ft0UzoO8Mt96u/r4aemfjoCVLbTTbzNROeliErc3JrmHGVkNgdV/QrS2lOMk4fRntd3u+IlWksDOmaKHgqjBwZHkhWlz/tzh2gLgrFpkEKaSF4OAQPq71IDxlHdSn8r4WK5Td26gIGoTptO4GAWJX8IevFSAuXrFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAI/LmWf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761812683; x=1793348683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2dkplthGwsSV143iEmAOuYcZDKvI2X1EgZlXGLzbZ0=;
  b=hAI/LmWfZgaZb7/MvhJxFjtJnlhgVS2jasuFz5VzymggcUZhtGVTO2lb
   wJjIDhRoPXxupMZNxZw3Ckv3+PEp3bhgQewQ35JmeZlsSNjU5iPP1hiBN
   xUMqrWsBx2fXQGNtE7yI5X3/lbLToDaxfgtRtsRJWvU0xb4U9tu7mnkYa
   SO+JIj6dkCJydF3HUeLIucOt4hTfW3hebg1kGCCQ8eDVeP4gtxyiGMoEZ
   33uTWgE5VYsXB7SCH+RgvOqsiCEQcEyUwLXtRDo1k40D4i5b7cf01vJP2
   MuUnWfHD19SGRKHRL4L7OokiIXIaHO0U8BhBM9AgH0t1w1UluFpDEUeiK
   Q==;
X-CSE-ConnectionGUID: SqKRinFcSnuXH95eqKVXOQ==
X-CSE-MsgGUID: Dc/WnMYKTBmSXRb2RqB/RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="62968914"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="62968914"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:24:42 -0700
X-CSE-ConnectionGUID: 1qirrtpNRbOB+B/4zlM8rA==
X-CSE-MsgGUID: E8Ae3r1MQ861JuXWIOU6hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185086308"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:24:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENxW-00000003qL4-0ejI;
	Thu, 30 Oct 2025 10:24:38 +0200
Date: Thu, 30 Oct 2025 10:24:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-9-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-9-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:
> In order to be able to configure event detection on a per axis
> basis (for either setting an event threshold/sensitivity value, or
> enabling/disabling event detection), add new axis-specific fields
> to struct st_lsm6dsx_event_src, and modify the logic that handles
> event configuration to properly handle axis-specific settings when
> supported by a given event source.
> A future commit will add actual event sources with per-axis
> configurability.

...

> +	old_enable = hw->enable_event[event];
> +	new_enable = state ? (old_enable | BIT(axis)) : (old_enable & ~BIT(axis));
> +	if (!!old_enable == !!new_enable)

This is an interesting check. So, old_enable and new_enable are _not_ booleans, right?
So, this means the check test if _any_ of the bit was set and kept set or none were set
and non is going to be set. Correct? I think a short comment would be good to have.

> +		return 0;

...

> +static const struct st_lsm6dsx_reg *st_lsm6dsx_get_event_reg(struct st_lsm6dsx_hw *hw,
> +							     enum st_lsm6dsx_event_id event,
> +							     const struct iio_chan_spec *chan)
> +{
> +	const struct st_lsm6dsx_event_src *src = &hw->settings->event_settings.sources[event];
> +	const struct st_lsm6dsx_reg *reg;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = &src->x_value;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = &src->y_value;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = &src->z_value;
> +		break;
> +	default:
> +		return NULL;
> +	}

> +	if (!reg->addr)
> +		reg = &src->value;
> +	return reg;

	if (reg->addr)
		return reg;

	/* Perhaps a comment here to explain the choice */
	return &src->value;

> +}

-- 
With Best Regards,
Andy Shevchenko



