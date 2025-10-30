Return-Path: <linux-iio+bounces-25652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6CC1EEE2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4B4E5A8F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBB24DCEB;
	Thu, 30 Oct 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfZf58eJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B837A3AC;
	Thu, 30 Oct 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812148; cv=none; b=fkHboxe72ii7mJYufZ7Mfez91TOUzrhbRe/XsDvWhBYrTUrMBKhXQ8YfZYDgSglj9JP6YbqoAnKVlEwL/8yu4doSkMjxt7QiT2b5UdhXg5WmguHk1u5q1qMWdTIEkdx9zXPyhgwc5jWk0cOcudfmWtsEhFZmY/nWq/rDzhwsR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812148; c=relaxed/simple;
	bh=gtFpoZB4tLI9fWCuAFN+kMNuciEAV5JNZ0JpGmyzjUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyRnDz3k8hTdz3Pq0bzAIwzLQ+tCWVJ2MEt0/H0mooPpnVHU/WekAzFIL92G5yD1OGuTkx/FK8WM8MdaABuyGgbMq8WPfJKKMaGwYZXL5slcTc6TAG8NNBM5QEiwmVYOseYyoBB3WVoQdC0f9E4XODgWpynij8kQ9hiWL1CPu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfZf58eJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761812147; x=1793348147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gtFpoZB4tLI9fWCuAFN+kMNuciEAV5JNZ0JpGmyzjUc=;
  b=TfZf58eJbJbT1DetNSBVYI1gllbQAq9wJJlL9w83jbqQm73S1P4Xhz7T
   OUqb5nrbFUe2khbAS+NmoRAkLbDM8dlHnom5CAToM8b3SLZowepvYEM7f
   QpKk3COvJx+k6pc+Jv67SoQdYZtugKDh1wJh4dDN6elfUsy6tx1Vyvd9K
   ywsU2xae0eVo1JXpOJt9kiZ6g/vbe6i5RlgcbDQXRY3UTja+Y5zVV+K/s
   6z/+cOgckO9aAwFHllnPjUxJzn06dY/P2kP7LHJePx0ZJWrbk/EHrWtI4
   B+Ko9yvTLT9OX9YFJk3ryWVppbt4q63cM8Nb0D9ekNK0kZ0AraJW/TJY/
   g==;
X-CSE-ConnectionGUID: 1NrSVWl4R8iT+6wBg+Q1Rw==
X-CSE-MsgGUID: vzrdyoV1S4+ziluMzg0lGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66562053"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="66562053"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:15:46 -0700
X-CSE-ConnectionGUID: 7NHcElIpQoaJW1j+I0dvBQ==
X-CSE-MsgGUID: /CcS7tquRyKTvh7WobndhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186236331"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:15:44 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENor-00000003qEo-3je3;
	Thu, 30 Oct 2025 10:15:41 +0200
Date: Thu, 30 Oct 2025 10:15:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: imu: st_lsm6dsx: make event management
 functions generic
Message-ID: <aQMerfm6peHvHAz2@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-8-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-8-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:27:50AM +0100, Francesco Lavra wrote:
> In preparation for adding support for more event types, use an
> array indexed by event ID instead of a scalar value to store
> enabled events, and refactor the functions to configure and report
> events so that their implementation is not specific for wakeup
> events. Move the logic to update the global event interrupt enable
> flag from st_lsm6dsx_event_setup() to its calling function, so that
> it can take into account also event sources different from the
> source being configured. While changing the signature of the
> st_lsm6dsx_event_setup() function, opportunistically add the
> currently unused `axis` parameter, which will be used when adding
> support for enabling and disabling events on a per axis basis.

...

>  	mutex_lock(&hw->conf_lock);
> -	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
> +	if (!enable_event) {
> +		enum st_lsm6dsx_event_id other_event;
> +
> +		for (other_event = 0; other_event < ST_LSM6DSX_EVENT_MAX; other_event++) {
> +			if (other_event != event && hw->enable_event[other_event]) {
> +				any_events_enabled = true;
> +				break;
> +			}
> +		}
> +	}
> +	if (enable_event || !any_events_enabled) {
> +		const struct st_lsm6dsx_reg *reg = &hw->settings->event_settings.enable_reg;
> +
> +		if (reg->addr) {
> +			err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +						 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
> +			if (err < 0)
> +				goto unlock_out;
> +		}
> +	}
> +	if (enable_event || (!any_events_enabled && !(hw->fifo_mask & BIT(sensor->id))))
>  		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
> +unlock_out:
>  	mutex_unlock(&hw->conf_lock);
>  	if (err < 0)
>  		return err;

This whole block is hard to read. Perhaps you need to refactor it to have something like

	if (enable_event) {
		err = call_helper1();
		...
		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
	} else {
		any_events_enabled = call_helper2();
		if (!any_events_enabled) {
			err = call_helper1();
			...
			if (!(hw->fifo_mask & BIT(sensor->id)))
				err = __st_lsm6dsx_sensor_set_enable(sensor, state);
		}
	}

With this you can see that actually helper1 can be modified (with one
additional parameter) to combination of

new_helper1()
{
	err = call_helper1();
	...
	if (!(hw->fifo_mask & BIT(sensor->id)))
		return __st_lsm6dsx_sensor_set_enable(sensor, state);
	return 0;
}

And the above goes as

	if (enable_event) {
		err = new_helper1(false);
	} else {
		any_events_enabled = call_helper2();
		if (!any_events_enabled)
			err = new_helper1(hw->fifo_mask & BIT(sensor->id));
	}

with assumed good names given this looks to me much easier to understand.

...

> +static bool
> +st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)

Why not one line?

> +{
> +	bool events_found;

Seems useless. Is this function going to be expanded down in the series?

> +	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP, IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_EITHER);

Indentation.

> +	return events_found;
> +}

-- 
With Best Regards,
Andy Shevchenko



