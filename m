Return-Path: <linux-iio+bounces-27467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D29CEE8C2
	for <lists+linux-iio@lfdr.de>; Fri, 02 Jan 2026 13:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66EA73012DF8
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jan 2026 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860472E8B8B;
	Fri,  2 Jan 2026 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRPOQG/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880F7262A;
	Fri,  2 Jan 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767357263; cv=none; b=UYnCLsObtqT55RxahmkMs83ymCBmgUjDrLTpfY5EnJ6jp+0qftqr6UBsoyrOtRvhPkCnS87Fw/tbQ7CGmSkulUWADquqqUjQx8XvJBg0jg3pnGN1lMWh9nKP1YMbZx3n+vqFqopiEiFG01FNcxRuNC9ADQmF9QZ3foEDE+Fyw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767357263; c=relaxed/simple;
	bh=Q4DM2XFHhXSfD4G/rmWG1+RJvma9k4Igb/0cDI84WQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRLn4wdUN64nswYsJ313rqqflbp6po2WfZq1vsEoYYhjG3Y1nfWZGAfhKyQpPUnA0cBQkuUdqd7s5wl9Pa6zHl7eVaz+hfv0lfV4n6dY1rTK0A1McKUwzmAFQaHCGApsPIh2LgkD6zBU6RQ3WrpWG/ot6MLzpjefd5UmBeaQUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRPOQG/X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767357262; x=1798893262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4DM2XFHhXSfD4G/rmWG1+RJvma9k4Igb/0cDI84WQg=;
  b=SRPOQG/XZz207CXvNPBAUPokplSsUEXkcZbBFaMZY011YUL+mSnQk+Nn
   MmU5wVKIgcg7sClU7WSc2VI+EYon3vrKo3KdvNs+6zcb9XpXof6vPMLza
   Sd7aD/2H2RLETEMBVQBt/LCVc+ankwaARCV4rRaC/BTBp2Jl+37qRtrOT
   fgxKHVmTK9abQ8C+e8Vn/mlIAaxGgibIIQNPZkByzhQRRehM0137bSYxg
   vcOB9Lib7xRVuu1bgkvkNCt3ZDzAYdBgVrqcviitdbf2nmreob4TUXaHJ
   zIVjmNVuaTJ2dN267N3AVJz67ucViMorj3ztGejINspHvCszRvArr2fWe
   A==;
X-CSE-ConnectionGUID: 9M6wkN6JQsqa4uj86sRvlg==
X-CSE-MsgGUID: vxt3Mc6aTuifKEqT2Uxpow==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="71432061"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="71432061"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:34:21 -0800
X-CSE-ConnectionGUID: 6UD8Z8RcTbmQooNHNOxIJQ==
X-CSE-MsgGUID: M2rzRvqeTPKqCyiVKx7e7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="206299625"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:34:18 -0800
Date: Fri, 2 Jan 2026 14:34:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aVe7SP914oI-jAam@smile.fi.intel.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
 <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 01, 2026 at 09:47:41PM +0530, Shrikant Raskar via B4 Relay wrote:

> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
>  #include <linux/iopoll.h>

Same comment as per previous patch. Do not add even more misordering, please.

...

> +/**
> + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> + * @client: I2C client handle
> + * @lock: mutex to serialize sensor reads
> + * @completion: completion used for interrupt-driven measurements
> + * @irq_en: indicates whether interrupt mode is enabled
> + */
>  struct rfd77402_data {
>  	struct i2c_client *client;
> -	/* Serialize reads from the sensor */
>  	struct mutex lock;
> +	struct completion completion;
> +	bool irq_en;
>  };

The kernel-doc conversion can be a separate patch, but I'm not insisting.

...

> +static irqreturn_t rfd77402_interrupt_handler(int irq, void *pdata)
> +{
> +	struct rfd77402_data *data = pdata;
> +	int ret;

> +	if (!data || !data->client)
> +		return IRQ_NONE;

How is this possible to be non-dead code?

> +	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	/* Check if the interrupt is from our device */
> +	if (!(ret & RFD77402_ICSR_RESULT))
> +		return IRQ_NONE;
> +
> +	/* Signal completion of measurement */
> +	complete(&data->completion);
> +	return IRQ_HANDLED;
> +}

...

> +static int rfd77402_wait_for_irq(struct rfd77402_data *data)
> +{
> +	int ret;

Missed blank line. Doesn't checkpatch complain?

> +	/* As per datasheet, single measurement flow takes 100ms */

Please, be more specific about datasheet, i.e. which Chapter/Section (with its
number and possible name) or Table specifies this.

> +	ret = wait_for_completion_timeout(&data->completion,
> +					  msecs_to_jiffies(100));
> +	if (ret == 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

...

> +static int rfd77402_measure(struct rfd77402_data *data)
>  {
> +	struct i2c_client *client = data->client;

This (conversion to data instead of client) can be split into a separate
precursor change.a but it seems not a big deal. Up to maintainers.

...

> -	/* Poll ICSR until RESULT bit is set */
> -	ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
> -				ret & RFD77402_ICSR_RESULT,
> -				10000,    /* sleep: 10ms */
> -				100000,   /* timeout: 100ms */
> -				false,
> -				client, RFD77402_ICSR);
> +	if (data->irq_en) {
> +		/* Re-initialize completion and wait for interrupt */
> +		reinit_completion(&data->completion);
> +		ret = rfd77402_wait_for_irq(data);
> +	} else {
> +		/* Poll ICSR until RESULT bit is set */
> +		ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
> +					ret & RFD77402_ICSR_RESULT,
> +					10000,      /* sleep 10ms */
> +					100000,     /* timeout 100ms */
> +					false,
> +					client, RFD77402_ICSR);
> +	}

This is ping-pong type of change. You just introduced it a patch ago. Make sure
you don't remove/modify (too much at least) the lines that were just added.

One of the possible technique to achieve this is to use a helper function.

...

>  static int rfd77402_init(struct i2c_client *client)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct rfd77402_data *data = iio_priv(indio_dev);

Can't this now take the data as above modified functon?

...

> -	mutex_init(&data->lock);
> +	ret = devm_mutex_init(&client->dev, &data->lock);
> +	if (ret)
> +		return ret;

In my opinion this deserves a separate change.

-- 
With Best Regards,
Andy Shevchenko



