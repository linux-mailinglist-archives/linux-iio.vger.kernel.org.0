Return-Path: <linux-iio+bounces-435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B607FA5D9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486851F20CE1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5B35F02;
	Mon, 27 Nov 2023 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuQ3qJbg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6921A7;
	Mon, 27 Nov 2023 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701101596; x=1732637596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F/1Z6F/qkdvf+ShW0L/YhA3CPDTmDttQCk27xrnwW8A=;
  b=QuQ3qJbgZzwVMaJBPKDXjCneHvzKBfFSCLIA2shqlHURVmjnjjXI9dgX
   yKXkqsYdm9xiCsT/P692u2WprvqC/3VRG92f+5zbwSukzOHLeCS0/n2U7
   /Wpei0Yi1Fw7fJQz0rMQWQ0qsdnxjSVp7H5U5MiDIwt5/D01gYLGFwlhG
   w5klOta+sGYxiWvk5YTUBRKgWYTwj+4elHimHtwZUdgAN7UbSnxldNwwx
   IxHo61TUW1N+kZoIfR0dXf3PqZKvXIAjUgVpqbjUmz//nHmOd88RtiS3j
   6Gd1livHe/JsPo/jwSzvDY52R/Xb++sBKW89gbYsCYYFqBpORTFJ4sDl2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389886472"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="389886472"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744607590"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="744607590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:13:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r7eEL-0000000HYHk-4B1u;
	Mon, 27 Nov 2023 18:13:05 +0200
Date: Mon, 27 Nov 2023 18:13:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZWTAEWRreMir7x_T@smile.fi.intel.com>
References: <20231125222738.97875-1-marex@denx.de>
 <20231125222738.97875-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125222738.97875-2-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 25, 2023 at 11:26:23PM +0100, Marek Vasut wrote:
> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.

...

> +	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
> +		if (chan->type == IIO_LIGHT && val2 != isl76682_range_table[i].als)
> +				continue;
> +		if (chan->type == IIO_INTENSITY && val2 != isl76682_range_table[i].ir)
> +				continue;

You forgot to drop indentation level for 'continue' lines.

> +		scoped_guard(mutex, &chip->lock)
> +			chip->range = isl76682_range_table[i].range;
> +		return 0;
> +	}

-- 
With Best Regards,
Andy Shevchenko



