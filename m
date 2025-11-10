Return-Path: <linux-iio+bounces-26119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1BC45032
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 06:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4470D346609
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04082E92BA;
	Mon, 10 Nov 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnT/khbH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DE2E92D0;
	Mon, 10 Nov 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752488; cv=none; b=Osn2rbVmRAdXIHIlWE4RxUe8+GPnl8jM5h6Lb4ruWf0Vm0MG738jfOWbyj5Q5Q7bI1NdCx9aXs02AZKP5GsXGQMbM3gE8m0o7vIqYWLstW4Dx1QAORHLSbv2tKtHdXN3HadBNzBch0kAylQ9Ax0b47A2KwUlyW4xntQmtSeumVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752488; c=relaxed/simple;
	bh=cJ+BeV/2f/O/DthNjrR3bgLiwFS/tTEB3azrEgPiDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSnX0vGZI8w5ollkSC255oXaZJoO2zpBp0VkOh994t4A045C3Mt8R/tP1roryHuQXhJpOOOnOygo1AAYHE6YXzxTcStxR2va2Io7Ye+A6fBtXyLlhpzf8Zt7i2D8e932WMuB5CikWLqcnQ5gsTiqgcErp01XWVy5sTRzCtOfRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnT/khbH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762752488; x=1794288488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJ+BeV/2f/O/DthNjrR3bgLiwFS/tTEB3azrEgPiDEg=;
  b=MnT/khbHM1as5zbSqhSe3gCkvTcILlNZZBcZp/nw7Kgncdk/p/ajmmlq
   jMfZIdWnfhbdRzrd4w3zwr4kOZD5ePBHZ9KbRVZb5iX8wKMh1P1ivY6vT
   b4b4L9/4Y2ApheuCt7/O31xmsEpvdMLHxHK8h3hHLdGiYg4Qo2lrVVMRM
   DONPHsJJxqC9gyfG9cc2TU5vB+gIpWZh28ZP2iltKmyHUMT2rNB9XJjKk
   sUV1xgkv4y03HZWi8sOiTlFglTbhjiyP/sPU3sCYmbcYfvaY7s49acD+f
   +TcpIcKQkhzyN8CWSF5HpCMk2CWRTNGcp9r47ZwLJIROlLv4HnzVKj157
   w==;
X-CSE-ConnectionGUID: h3YSaOK6TjCMRErzX4BLZg==
X-CSE-MsgGUID: GQ0kqVjLQPiFRKSumGOo+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64680211"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64680211"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:28:07 -0800
X-CSE-ConnectionGUID: F3zFX+7sQJ+4TRfZ0xEt/w==
X-CSE-MsgGUID: 7eV2wQTMQKimrwIkzPDj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188420652"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:28:05 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIKRe-00000007LnW-06pt;
	Mon, 10 Nov 2025 07:28:02 +0200
Date: Mon, 10 Nov 2025 07:28:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 2/2] iio: trigger: fix device initialization order in
 viio_trigger_alloc
Message-ID: <aRF34dlvZaD-stgt@smile.fi.intel.com>
References: <20251110035838.37029-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110035838.37029-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 11:58:38AM +0800, Ma Ke wrote:
> Move device initialization to the end of viio_trigger_alloc() to
> simplify error handling. This follows the pattern used in similar
> functions like spi_alloc_device(), where device_initialize() is called
> only after all resources have been successfully allocated.
> 
> This change eliminates the need for complex cleanup in error paths and
> ensures that the device release callback only runs when the device was
> fully initialized.
> 
> By moving device_initialize() after all resource allocations, we can
> use simple kfree() in error paths instead of put_device(), making the
> code more straightforward and less error-prone.
> 
> Found by code review.


Thanks for the update, my comments below.

...

> -	trig->dev.parent = parent;
> -	trig->dev.type = &iio_trig_type;
> -	trig->dev.bus = &iio_bus_type;
> -	device_initialize(&trig->dev);
> -	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);


> +	/* Initialize device only after all resources are allocated */
> +	trig->dev.parent = parent;
> +	trig->dev.type = &iio_trig_type;
> +	trig->dev.bus = &iio_bus_type;
> +	device_initialize(&trig->dev);

> +	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);

Why has this been moved?

-- 
With Best Regards,
Andy Shevchenko



