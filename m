Return-Path: <linux-iio+bounces-9609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF58979EDE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC4284918
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660414A4F3;
	Mon, 16 Sep 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjDWFZZb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4E17C8D;
	Mon, 16 Sep 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480957; cv=none; b=RrDuVFFxFWucnselKBljyO9BTgJrDxMv3ddGlUuu7xweKYM/vtoGgY+gLUvxYvzaf+24eS5o/dYYoTXJKzn8+dl/ArlUwkp7O0zY3X4qpuezXqbyJ7TtBlld6wupoDfGhn76AWqNLrw0xdv/KQvAsFQKzo3QkRVcJl8jdonEatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480957; c=relaxed/simple;
	bh=rQcJutdtdgfNyAOY1JMWhJc/Le0u05pineVybe16MiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvdltUD4nNE+H/7Db/GjHkY3y+LSBIBv2q14cjHP9hfJe+gOdTV9ejWQO/RqAP+Ln13KjX5/yk6OovWe0ioOsWXq4mQNh0nNXrfdbmrQUQ0lXfHM6pFBxmB9iNvVZvIk/LOKE0WKJYO8+YQM82+RPmzX5TQaiEHMVF3LIBuXnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjDWFZZb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726480956; x=1758016956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQcJutdtdgfNyAOY1JMWhJc/Le0u05pineVybe16MiI=;
  b=SjDWFZZbNKp9+byLxCFMuHG9IidpzPovLJyGJStdPTBy6XsZWsEmQE9P
   34/hlvU/+Cbuxy85BE77tD4roTkRvbGH67x18PCbWP6wHJVWsXRxbwJvh
   /dRtkTb3zl5GzncwjHHeu/AcUzEYM94469uaxaho4D/EpA87lUQ8sGgOb
   AD0EsEX4gQ/QYufsoM40Q77hWjMAyDrBYk3Os53BBXwr+3wJG1OJBGWaW
   5fWKmG7wbWciFUYIxsChp6YN2cjgbpP6L7NpdtcWgJd4GZMtbgrdlKilD
   7Sb68Jr6hiVOKfxRQH3prckTTIwCDgkMRwW1VO4OPzFUOu2dRsTe9lz7u
   A==;
X-CSE-ConnectionGUID: YnYUcyHgTcmmGBqm5kjFXA==
X-CSE-MsgGUID: RtoZHY8zRjuvL+V7A1QS/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="50716802"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="50716802"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:02:32 -0700
X-CSE-ConnectionGUID: ryQgs10YSVKkzmE2lBlp5Q==
X-CSE-MsgGUID: oq4koO4BTp+jumrve1j5kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68816970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:02:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8Yu-00000009Pmc-0RaW;
	Mon, 16 Sep 2024 13:02:28 +0300
Date: Mon, 16 Sep 2024 13:02:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
Message-ID: <ZugCM56HrIgWu4PM@smile.fi.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
 <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
 <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
 <aac0e587-3770-43c5-a9b1-4da4890c979a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac0e587-3770-43c5-a9b1-4da4890c979a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 14, 2024 at 03:47:21PM +0200, Hans de Goede wrote:
> On 9/13/24 11:32 AM, Andy Shevchenko wrote:
> > On Thu, Sep 12, 2024 at 03:52:34PM +0200, Hans de Goede wrote:
> >> On 9/11/24 11:31 PM, Andy Shevchenko wrote:

...

> > Same Q here.
> 
> Yes I did look for KMX61021 in my DSDT collection and I did
> not find anything, neither does:
> 
> https://www.catalog.update.microsoft.com/Search.aspx?q=kmx61021
> 
> find anything.

Thanks for checking!

> So I believe that this one can really be dropped.

Good. I'm on the side here to drop and look for bug reports rather than
keeping and provoke using badly invented ACPI IDs (as we see already
in the example of ltr501).

-- 
With Best Regards,
Andy Shevchenko



