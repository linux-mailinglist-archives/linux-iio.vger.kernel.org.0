Return-Path: <linux-iio+bounces-17226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F1EA6D61B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D71891B0D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A125D1FD;
	Mon, 24 Mar 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYvLjoj6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FB25C6FB;
	Mon, 24 Mar 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804642; cv=none; b=NUx7vQZgNnJ9ZWknQvoPbpzayl89z0I0ZaGvWnKuKoCEVNji1oUaea3GhLIt/DVEnsJf8HwBes4+VS8qVPn6ukTHtOxpZFm+PcuDVphmxAWJyOWcQ+BWXMdV5xNnjUzE0LHioK7jHq/Zr2L1xtwsFDB8nIRFFZzNzcfCiSgaYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804642; c=relaxed/simple;
	bh=wH9pjtxftMfZbkxAZn+96fnjiloTUPZbgvD/rvrrtms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkOPY6oOMSgS4+x93IcGU4Llsg2EZhqQt3E483vJq5PYY3yf0NCN90Tk+B83/JErvVp5bSZsbaqDVgAxkRQnK+QvdyotaFfvcM4NkR8WercFbVd+Q7D208tvrRAb4LwgfR6OedtdliAoptp7sJC8RCXm/78ch0E6vm/kvq4ujUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYvLjoj6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742804641; x=1774340641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wH9pjtxftMfZbkxAZn+96fnjiloTUPZbgvD/rvrrtms=;
  b=WYvLjoj60Wk5Rty/guTxe5/Ilb3rAYyDU/dBGFYcZdG7R1Xk3e5aVrhD
   KcDYmb1bW81S844+o8/X7QWpe/Q9p+aC3OfyynW9yV3HuxeWXxku8y47V
   LiJVMKlOA5KpcirM41PKTmFi83V9XK23ccMh3PlmINDaPHdcKx9jVC/ru
   3+B9a/AFNED9CPwLoLRzCRmn3J03r4RRyZvtSYgggEVk5bLzjbIRH2xQi
   IaIrUbBvgh20C/KugGdlEG/JmYym5Z9twD0g4W7sJeYzKNjEwy6EoIi+C
   XcUY6BpsS/uqQ45u/9ecAHC4EBAV7/N8SVpoTsuYEa1HpK7b/vDYtxGJa
   Q==;
X-CSE-ConnectionGUID: lA8Rqt+oTkmQW10eKxEWqQ==
X-CSE-MsgGUID: trg4LZakTLWm7+Dq9QgMqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="54630231"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="54630231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:24:00 -0700
X-CSE-ConnectionGUID: AZuZmgKeSqWww/tdcbPBmg==
X-CSE-MsgGUID: 3AjjyY6HSd+NFQzimbjgDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123963906"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:23:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twd68-00000005HjR-3wtP;
	Mon, 24 Mar 2025 10:23:52 +0200
Date: Mon, 24 Mar 2025 10:23:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v10 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z-EWmK2r6VgmPAqa@smile.fi.intel.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 09:13:42AM +0200, Matti Vaittinen wrote:
> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
> 
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.
> 
> Thus do not support the BD79124's manual measurement mode but implement
> the measurements using automatic measurement mode, relying on the
> BD79124's ability of storing latest measurements into register.
> 
> Support also configuring the threshold events for detecting the
> out-of-window events.
> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus, prevent the user-space from choking
> on the events and mask the received event for a fixed duration (1 second)
> when an event is handled.
> 
> The ADC input pins can be also configured as general purpose outputs.
> Make those pins which don't have corresponding ADC channel node in the
> device-tree controllable as GPO.

Thank you for the nicely written driver!
However, I have one big issue with it (see below).

...

> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				    unsigned long *bits)

These will be _rv variants anyway as there is no chance this series goes before that.

...

> +struct bd79124_raw {
> +	u8 val_bit3_0; /* Is set in high bits of the byte */
> +	u8 val_bit11_4;
> +};
> +#define BD79124_RAW_TO_INT(r) ((r.val_bit11_4 << 4) | (r.val_bit3_0 >> 4))
> +#define BD79124_INT_TO_RAW(val) {					\
> +	.val_bit11_4 = (val) >> 4,					\
> +	.val_bit3_0 = (val) << 4,					\
> +}

All the rest is fine to me and looks good, but above is a principal impediment
to give you my tag. In case you update the type to __le16, feel free to add
my Reviewed-by tag.

-- 
With Best Regards,
Andy Shevchenko



