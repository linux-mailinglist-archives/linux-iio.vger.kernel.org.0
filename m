Return-Path: <linux-iio+bounces-25997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D61C3D135
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1FD04E01A6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918F34E771;
	Thu,  6 Nov 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngl0Bhrg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5544204F8B;
	Thu,  6 Nov 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453959; cv=none; b=GTXwDcBwWAhBhQNDZ2NLAT6SxJbBrrkomvXmIOIbYf7ppRK4bVkYROZ2cyTBKlRLUywOye2lVkqaewCGecBVozBPUVAiV3NXMygLKpg8xX7Ij9oGRY4JjaXdk4O5t8fSxs+p66IpI3Jv0tNU8NsJZ4+6L8BzPmJH5BvC5md+YDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453959; c=relaxed/simple;
	bh=fVzWW815nuMiOaUcKoR+xqB0xagzSP1lzJjAbneJHN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7BYH96YgALT2AvJihH3XKfoh2HoN/PX3/NHHkJQDpmotIuk61QdlEg7CRcnhm9lXK6kaKF2m3MMOPNKxeVQZydCktuut684HmdyDAqDAhOWnXZvyya/N58ITgqCvs3b80w6cDX4aw3Jz75LlRy6w+FW3KCTEzLgY00UqW5bww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngl0Bhrg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762453957; x=1793989957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVzWW815nuMiOaUcKoR+xqB0xagzSP1lzJjAbneJHN8=;
  b=Ngl0BhrgVDouM5+RkSGnggiKCFcCr+wLmb7bPwHf8J6WfyjOjmkBKgkS
   dynCv8UMb0ZIinXlts/DKNrNMMZAnOnvBbP4DlBFAeRpbsQLAKkfhWbPL
   bjdsIykZbRFcIMWPeuEDwVDBwDKsH/KW7WhlI6Ze78OBz8WPthjv9OksF
   VD/H7+ANLQwM34mqpTd3bcl4rfY+Jxkhb6jMYlBeQpR7kHOLiPen+53/P
   o5OlK3vSPZ2ti78zsQbuNCq/HqEPU+mMXnWHEl533iiRvQszphm53bMMp
   hDrQGuHHHQa1DA7yUUkVwwrJPqIesTI/F6kSwD9dp6PEHwhymExMg+ROU
   g==;
X-CSE-ConnectionGUID: ZKJfZzdGRe62y+VZVf6rYQ==
X-CSE-MsgGUID: ECjp0tMxQzKaPATDEVZMFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64518411"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64518411"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:32:36 -0800
X-CSE-ConnectionGUID: HOZfE0yCQ4CwxorGNlhNiA==
X-CSE-MsgGUID: 4V8v9CszQQeuLWJ1yAmWXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="225078793"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:32:33 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH4mb-00000006Dlf-2XO2;
	Thu, 06 Nov 2025 20:32:29 +0200
Date: Thu, 6 Nov 2025 20:32:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] regulator: ltm8054: Support output current limit
 control
Message-ID: <aQzpvR-030zgA82E@smile.fi.intel.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-5-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-ltm8054-driver-v3-5-fd1feae0f65a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:11:50PM +0100, Romain Gantois wrote:
> The LTM8054 supports setting a fixed output current limit using a sense
> resistor connected to a dedicated pin. This limit can then be lowered
> dynamically by varying the voltage level of the CTL pin.
> 
> Support controlling the LTM8054's output current limit.

...

>  #include <linux/array_size.h>
> +#include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/device/devres.h>
>  #include <linux/device/driver.h>

>  #include <linux/errno.h>
>  
>  #include <linux/gpio/consumer.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/jiffies.h>
> +#include <linux/lockdep.h>
>  #include <linux/math64.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>

>  #include <linux/regulator/of_regulator.h>
>  #include <linux/types.h>
>  
> +#include <linux/units.h>
> +#include <linux/workqueue.h>

This will be updated accordingly.

...

> +struct ltm8054_ctl_pin_work {
> +	struct work_struct work;
> +	unsigned int ctl_val;
> +	bool write;
> +	int ret;
> +};

Have you ran `pahole`? It might suggest a better layout to save a few bytes.

...

> +static void ltm8054_do_ctl_work(struct work_struct *work)
> +{
> +	struct ltm8054_ctl_pin_work *ctl_work = container_of_const(work,
> +								   struct ltm8054_ctl_pin_work,
> +								   work);
> +	struct ltm8054_priv *priv = container_of_const(ctl_work,
> +						       struct ltm8054_priv,
> +						       ctl_work);

These read better in slightly different split:

	struct ltm8054_ctl_pin_work *ctl_work =
		container_of_const(work, struct ltm8054_ctl_pin_work, work);
	struct ltm8054_priv *priv =
		container_of_const(ctl_work, struct ltm8054_priv, ctl_work);

...

> +	mutex_lock(&priv->ctl_work_lock);
> +	val = ctl_work->ctl_val;
> +	write = ctl_work->write;
> +	mutex_unlock(&priv->ctl_work_lock);

Why not scoped_guard() from cleanup,h?

...

> +	/* Standard IIO voltage unit is mV, scale accordingly. */
> +	if (write)
> +		ret = iio_write_channel_processed_scale(priv->ctl_dac,
> +							val, 1000);

One line. It just 82 characters.

> +	else
> +		ret = iio_read_channel_processed_scale(priv->ctl_dac,
> +						       &val, 1000);

Ditto.

And perhaps use MILLI/KILO?

...

> +	pr_debug("LTM8054: %s CTL IO channel, val: %duV\n", write ? "wrote" : "reading", val);

Besides str_write_read() from string_choices.h this should be dev_dbg().

> +	mutex_lock(&priv->ctl_work_lock);
> +	ctl_work->ret = ret;
> +	ctl_work->ctl_val = val;
> +	mutex_unlock(&priv->ctl_work_lock);

scoped_guard()

> +	complete(&priv->ctl_rw_done);
> +}

...

> +static int ltm8054_ctl_pin_rw(struct ltm8054_priv *priv, bool write, unsigned int *ctl_val)
> +{
> +	struct ltm8054_ctl_pin_work *ctl_work = &priv->ctl_work;

> +	int ret = 0;

Redundant assignment.

> +	lockdep_assert_not_held(&priv->ctl_work_lock);
> +
> +	/* The get/set_current_limit() callbacks have an active regulator core

/*
 * The proper style of multi-line comment
 * is depicted in this example. Use it.
 */

> +	 * reservation ID (obtained with ww_acquire_init()).
> +	 *
> +	 * Or, the IO channel driver may call something like
> +	 * regulator_enable(), meaning this thread would acquire a new
> +	 * regulator core reservation ID before the current one is dropped
> +	 * (using ww_acquire_fini()). This is forbidden.
> +	 *
> +	 * Thus, perform the IO channel read/write in a different thread, and
> +	 * wait for it to complete, with a timeout to avoid deadlocking.
> +	 */
> +
> +	scoped_guard(mutex, &priv->ctl_work_lock) {
> +		if (work_busy(&ctl_work->work))
> +			return -EBUSY;
> +
> +		if (write) {
> +			ctl_work->ctl_val = *ctl_val;
> +			ctl_work->write = 1;
> +		} else {
> +			ctl_work->write = 0;
> +		}
> +
> +		schedule_work(&ctl_work->work);
> +	}
> +
> +	ret = wait_for_completion_timeout(&priv->ctl_rw_done, LTM8054_CTL_RW_TIMEOUT);
> +	reinit_completion(&priv->ctl_rw_done);
> +
> +	if (unlikely(!ret))
> +		return -ETIMEDOUT;
> +
> +	scoped_guard(mutex, &priv->ctl_work_lock) {
> +		ret = ctl_work->ret;

> +		if (!ret && !write)
> +			*ctl_val = ctl_work->ctl_val;

Return directly.

		if (ret)
			return ret;

		if (!write)
			...

> +	}

> +	return ret;

	return 0;

> +}

...

> +static struct iio_channel *ltm8054_init_ctl_dac(struct platform_device *pdev)
> +{
> +	struct iio_channel *ctl_dac;
> +	enum iio_chan_type type;
> +	int ret;
> +
> +	ctl_dac = devm_iio_channel_get(&pdev->dev, "ctl");
> +	if (IS_ERR(ctl_dac)) {

> +		if (PTR_ERR(ctl_dac) == -ENODEV)
> +			return ERR_PTR(-EPROBE_DEFER);

Hmm... Are you sure about this?

> +
> +		return ctl_dac;
> +	}
> +
> +	ret = iio_get_channel_type(ctl_dac, &type);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (type != IIO_VOLTAGE)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ctl_dac;
> +}

...

>  static int ltm8054_probe(struct platform_device *pdev)
>  {
>  	struct regulator_config config = { };
> +	struct iio_channel *ctl_dac = NULL;
>  	struct device *dev = &pdev->dev;
>  	struct regulator_dev *rdev;
>  	struct ltm8054_priv *priv;
>  	int ret;
>  
> +	/* Do this first, as it might defer. */
> +	if (device_property_match_string(dev, "io-channel-names", "ctl") >= 0) {
> +		ctl_dac = ltm8054_init_ctl_dac(pdev);
> +		if (IS_ERR(ctl_dac))
> +			return dev_err_probe(dev, PTR_ERR(ctl_dac),
> +					     "failed to initialize CTL DAC\n");
> +	}
> +
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;

> +	platform_set_drvdata(pdev, priv);

Do we need this? I think "no". See below how.

> +	priv->dev = dev;
>  	priv->rdesc.name = "ltm8054-regulator";
> -	priv->rdesc.ops = &ltm8054_regulator_ops;
> +	priv->rdesc.ops = &ltm8054_no_ctl_ops;
>  	priv->rdesc.type = REGULATOR_VOLTAGE;
>  	priv->rdesc.owner = THIS_MODULE;
>  
> +	if (ctl_dac) {
> +		priv->ctl_dac = ctl_dac;

> +		INIT_WORK(&priv->ctl_work.work, ltm8054_do_ctl_work);
> +		init_completion(&priv->ctl_rw_done);

Do devm-helpers.h APIs help with something here? Does
devm_add_action_or_reset() help with not covered cases?

> +		mutex_init(&priv->ctl_work_lock);

Use devm_mutex_init() and don't forget the error check.

> +		priv->rdesc.ops = &ltm8054_ctl_ops;
> +	}
> +
>  	config.dev = dev;
>  	config.driver_data = priv;


From this...

>  	ret = ltm8054_of_parse(dev, priv, &config);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "failed to parse device tree\n");
> +		goto out_err;
> +	}
>  
>  	rdev = devm_regulator_register(dev, &priv->rdesc, &config);
> -	if (IS_ERR(rdev))
> -		return dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
> +	if (IS_ERR(rdev)) {
> +		ret = dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
> +		goto out_err;
> +	}
>  
>  	return 0;
> +
> +out_err:
> +	if (ctl_dac) {
> +		cancel_work_sync(&priv->ctl_work.work);
> +		mutex_destroy(&priv->ctl_work_lock);
> +	}
> +
> +	return ret;
> +}
> +
> +static void ltm8054_remove(struct platform_device *pdev)
> +{
> +	struct ltm8054_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->ctl_dac) {
> +		cancel_work_sync(&priv->ctl_work.work);
> +		mutex_destroy(&priv->ctl_work_lock);
> +	}
>  }

...to this no changes are needed.

...

>  	.probe = ltm8054_probe,
> +	.remove = ltm8054_remove,

Neither is this.

-- 
With Best Regards,
Andy Shevchenko



