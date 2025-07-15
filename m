Return-Path: <linux-iio+bounces-21664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF1B054AB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57432563031
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEF275AFF;
	Tue, 15 Jul 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaWhaQX0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0F274B35;
	Tue, 15 Jul 2025 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567657; cv=none; b=Mk5IMmX2jAXirYcyvF+fzmgARsegE85kPrduwLUrw/ldRNY8x5cGzNGQjpnNKZea+M/amzfwiG9NdN+zRowPAzlN+Fn5uNYCqnJTxKZEsEhBPQx4AHo4IPDvL4ThbJp8pqukNXsOe1za6MMld6Lf+X1wNylTF5SUFM8MBeGtXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567657; c=relaxed/simple;
	bh=iMd4tRB3gOxTcZdIQGJuMTUHchGSoX7MMCA/0kUDBGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0qlhf3O5e/uOBGbCyXO2754fQ0n2Zpf7ZPchGOYOW2TCvIRTi5Hw8Dged/hP7T9nxlnQcerpv2CnV5oN0KY8zlIi2vUINH3vv0G55PTI3iNR87/q3I0nlq9yYaR34wXv4K8XEAnhpWOK/wxeonhnwr3f3zW1w5DwyvLvWOlpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaWhaQX0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752567656; x=1784103656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMd4tRB3gOxTcZdIQGJuMTUHchGSoX7MMCA/0kUDBGY=;
  b=aaWhaQX0HKCojwNuh1o06cvueYVVkWZG6/jSUFyPO2tx/UAASuXAbuoZ
   iypOM+4F2GFtrZG28CUmB6j+2pDe6imfewr6feuAKT9ElssmKNa1tu8wU
   HOmElmbAeWMzDBMASkzZB9LGfUSi/zd8jGTmgs1cCMd3sMQeQbdvYikgk
   vtgl4J7sjwA+qgZIrOe7lKoJQBhCA48yTQDNd/D/xIUl+0xS1LcX8o+JE
   /6V9+b5A+qD89DBUhePy0BQeuw2zsT+yYtkx1iZntiVVHcBMlJO3pcjLb
   6D6vmMo82J/D+kwoJYWp9cIoaeCXN6jqdaWMUGaB2IvqEh0/ROwMomI12
   g==;
X-CSE-ConnectionGUID: 5mn4nRBtTDexpQUMo3igXQ==
X-CSE-MsgGUID: ktrn4zPgSu2AAJ1KhnvGfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57388273"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="57388273"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:20:55 -0700
X-CSE-ConnectionGUID: UoaDR9HfRmG7eLXoID6L8A==
X-CSE-MsgGUID: a92y67ciQYSLarhj834MBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156812729"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:20:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubauA-0000000Fav8-0Dgd;
	Tue, 15 Jul 2025 11:20:50 +0300
Date: Tue, 15 Jul 2025 11:20:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <aHYPYZgq17ogdEgC@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-4-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:19PM -0400, Sean Anderson wrote:
> Add an API to notify consumers about events. Events still need to be
> enabled using the iio_read_event/iio_write_event functions. Of course,
> userspace can also manipulate the enabled events. I don't think this is
> too much of an issue, since userspace can also manipulate the event
> thresholds. But enabling events may cause existing programs to be
> surprised when they get something unexpected. Maybe we should set the
> interface as busy when there are any in-kernel listeners?

...

>  #include <linux/wait.h>

While at it...

+ blank line here...

> +#include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/iio-opaque.h>

...and here?

>  #include "iio_core.h"

...

> +	struct iio_event_data ev = {
> +		.id = ev_code,
> +		.timestamp = timestamp,
> +	};

...

>  	/* Does anyone care? */
>  	if (iio_event_enabled(ev_int)) {
> -
> -		ev.id = ev_code;
> -		ev.timestamp = timestamp;
> -
>  		copied = kfifo_put(&ev_int->det_events, ev);
>  		if (copied != 0)
>  			wake_up_poll(&ev_int->wait, EPOLLIN);

Looks like this refactoring can be done before main change.

...

> +	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));

Is bug.h already included?


-- 
With Best Regards,
Andy Shevchenko



