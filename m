Return-Path: <linux-iio+bounces-26479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCBC886EB
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 08:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFD53B058C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6929E10B;
	Wed, 26 Nov 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsO10XIw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49078246BD5;
	Wed, 26 Nov 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142513; cv=none; b=AGRIZ+U8lvI3kE+f0WvRTvd5vFPnXjbcbcaZML8dhLGUp9+B0XEjXVo2dCbtDCTkUTP8fhTfaNWAp3vgBs7XKLFtH/JOELlmrN7TWmuSMYHJ6wiKGzxaXPp4pCyWfl7cF2y+2L6KFBflKulbTU/FqSpV/X5EZa7dNLE77efFRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142513; c=relaxed/simple;
	bh=8Uc3vhNhhn0AUrcsoAiSh1S8SXneQ0eZI/3bxptZ6pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqwSgpmFiFl0xhwkgQGO4srWcEVRuRn7s9h02od0PiJilx1ESMBi0qymeTmWmDPYpWdySOW+z9zosSP41CCbjgYFoik8gT2M7PLm3C9QjaKbve+YZQ6z69pKxxjetcYagFcMP2yDIxHR1YiqkXHT+jVYBKQS+wWO+375tRJYFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsO10XIw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764142512; x=1795678512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Uc3vhNhhn0AUrcsoAiSh1S8SXneQ0eZI/3bxptZ6pA=;
  b=VsO10XIwo867a1bdvT0Lmio+6USQ2lGhB6iFtKxN4PSxejCGO0L3WKO9
   0KMMB4ZBTJbqyiwsVZTQ6f4njIIPWa4r9prIAoZVYe3kBkKmtmXZ2JvjQ
   U7NCxMavWKVMGIu9NWNYgI5C9cNKiL8AeDeQBVhkmGcubgOczbZTEr9qX
   OQooCkEoVQhHepZ+/2ERKgWKecaCb2qLucBx7FLes3xUF2KFM3phInI5l
   E61sL9teocGLWBF8SDAYdYPQu72bebR0tPoHplIRjUJ3q9K3c9qJZoaP4
   QLEZIh3dJP1TqgS8DxmrMeugx48YKeQCkQqivEZ89nSdkJ2ZKMJeMUIhq
   Q==;
X-CSE-ConnectionGUID: ZWPKtcpjRYCn5mzIpcjsvQ==
X-CSE-MsgGUID: OUGt4hhnTx+DKwAnEnvABg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76495571"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="76495571"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:35:11 -0800
X-CSE-ConnectionGUID: 7pPw2WRmTZC2lxxcotcgDA==
X-CSE-MsgGUID: KLKmAt+jRSKBgFaWE3lwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192762130"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:35:07 -0800
Date: Wed, 26 Nov 2025 09:35:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, heiko@sntech.de, neil.armstrong@linaro.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aSatqG9UEqkH0Glw@smile.fi.intel.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
 <20251126031440.30065-4-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126031440.30065-4-raskar.shree97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 08:44:40AM +0530, Shrikant Raskar wrote:
> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> -

Stray removal of blank line.

> +#include <linux/interrupt.h>
> +#include <linux/completion.h>

> +#include <linux/of.h>

Please, avoid using of.h in a new code.

>  #include <linux/iio/iio.h>

...

> +static irqreturn_t rfd77402_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct rfd77402_data *data = dev_id;
> +	int ret;

> +	/* Check if the interrupt is from our device */

This comment only for the second part and I would split the condition to make
it clearer.

> +	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> +	if (ret < 0 || !(ret & RFD77402_ICSR_RESULT))
> +		return IRQ_NONE;

	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
	if (ret < 0)
		return IRQ_NONE;

	/* Check if the interrupt is from our device */
	if (!(ret & RFD77402_ICSR_RESULT))
		return IRQ_NONE;

> +	/* Signal completion of measurement */
> +	complete(&data->completion);
> +	return IRQ_HANDLED;
> +}

...

> -	while (tries-- > 0) {
> -		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
> -		if (ret < 0)
> +	if (data->irq_en) {
> +		/* Wait for interrupt-driven completion */
> +		ret = wait_for_completion_timeout(&data->completion,
> +						  msecs_to_jiffies(200));
> +		if (ret == 0) {
> +			ret = -ETIMEDOUT;
>  			goto err;
> -		if (ret & RFD77402_ICSR_RESULT)
> -			break;
> -		msleep(20);
> -	}
> -
> -	if (tries < 0) {
> -		ret = -ETIMEDOUT;
> -		goto err;
> +		}
> +	} else {
> +		/* Fallback to polling mode */
> +		while (tries-- > 0) {
> +			ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
> +			if (ret < 0)
> +				goto err;
> +			if (ret & RFD77402_ICSR_RESULT)
> +				break;
> +			msleep(20);
> +		}
> +
> +		if (tries < 0) {
> +			ret = -ETIMEDOUT;
> +			goto err;
> +		}
>  	}

Instead, move the current code into a helper (in a separate patch) and alter it
here with new conditional. So in the result it will be something like

	if (...)
		ret = call_new_helper_for_irq();
	else
		ret = call_old_helper_for_polling();

...

> +	if (data->irq_en) {
> +		/* Configure ICSR: auto-clear on read, push-pull, falling edge */
> +		ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
> +						RFD77402_ICSR_CLR_CFG |
> +						RFD77402_ICSR_INT_MODE);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Enable 'new data available' interrupt in IER */
> +		ret = i2c_smbus_write_byte_data(client, RFD77402_IER,
> +						RFD77402_IER_RESULT);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		/* Disable interrupts */
> +		ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = i2c_smbus_write_byte_data(client, RFD77402_IER, 0);
> +		if (ret < 0)
> +			return ret;
> +	}

This can be also factored out to a helper(s). Something like this, perhaps

	if (irq_en)
		ret = call_a_helper(client, $CSR, $ER);
	else
		ret = call_a_helper(client, 0, 0);

...

> +	/* Check if interrupt is mentioned in device tree */
> +	data->irq_en = false;
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, rfd77402_interrupt_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"rfd77402", data);
> +		if (ret == 0) {
> +			data->irq_en = true;
> +			dev_info(&client->dev, "Using interrupt mode\n");
> +		} else {
> +			dev_warn(&client->dev,
> +				 "Failed to request IRQ %d, using polling mode: %d\n",
> +				 client->irq, ret);

If we asked for interrupt and didn't get it due to "linux" errors, we should
not fallback. No need to work around bugs in the DT, the DT description must
be fixed instead.

> +		}
> +	} else {
> +		dev_info(&client->dev, "No interrupt specified, using polling mode\n");
> +	}

-- 
With Best Regards,
Andy Shevchenko



