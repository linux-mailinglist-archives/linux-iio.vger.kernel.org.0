Return-Path: <linux-iio+bounces-11802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5F9B95B3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FFE1F2287C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB11C9B97;
	Fri,  1 Nov 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQPUnopE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602A1CBE98;
	Fri,  1 Nov 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479369; cv=none; b=IRd0wUAuMP3P8kawgea0jRku8hyONFQBCfQh2t9GJGzQwCu4nRPMnnBxjLY33FEZw98fJ9kGgnInpdFolLysEQafTCvY/PRPm4ogjIMxmWLgXilugA4BhYV69dH6rKgeUnxSZhr/xgUI3gkPUq4f5q35zd2NjqbamumsJJQeKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479369; c=relaxed/simple;
	bh=cVy0S1byr07G00hHlUDVxRSACJrhKuqzww/9nKHjnlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8OHNb0h32N37IiJB8VAjHCD6cSQWXuJfaACSsSmFzx+ElrfqzHgQXLrolT9BsSFeCYFQTmJMBLMUNi9OlJ8mpe7UTmzlJt3DZTQh3+R1uvHcmkccVwmBFnx4zSA/mxAJi1DVobCpUN+HJRQq58sswLZhq5H3goMyUgwgmJoml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQPUnopE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730479367; x=1762015367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cVy0S1byr07G00hHlUDVxRSACJrhKuqzww/9nKHjnlI=;
  b=eQPUnopEl05tp86t8eWaIIVXpfDpIbxAJb6ML41biRHXl22R2JsODHkD
   +PhaJfrCxFABZBBsDRJXWPNT996HbQOwFZ5W0OWk/sBPOWqPTCUUVS+bx
   f9zEinYgpEXFZPAKOg5XRpHRJuh+6o7s6fvE0Z6C/TMPmHKCJrP3v0m84
   qO+wKt8IuDCS2RpZcxjOHP+w/ghRZi7niM2AAsLEi7PYLgw1RZte4ZoF7
   6JygrMymvbuvEQE/pPiJeJp1zNlx7Xc5xr7RvUweSZtXo+RSUUGj9d7ML
   MUeJJzry6i55pby5xXE/4ahq8gIVaKlNMIoSFXeeAprRxsaw0oOkfPT9Y
   w==;
X-CSE-ConnectionGUID: 0VYW/7+zT6+CMk+43pC6Zg==
X-CSE-MsgGUID: vFQr+hxgSxSEGMJ0BBwa+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="33087464"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="33087464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:42:46 -0700
X-CSE-ConnectionGUID: dQQxg3LgSLeUCe0xuaVMOw==
X-CSE-MsgGUID: +ixHzwP1QWO9HdqyfJOB9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="113785863"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:42:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6ujS-0000000A6GR-1aW5;
	Fri, 01 Nov 2024 18:42:42 +0200
Date: Fri, 1 Nov 2024 18:42:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/4] iio: initialise ddata for
 iio_get_acpi_device_name_and_data()
Message-ID: <ZyUFAjwjAWcJH8ag@smile.fi.intel.com>
References: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
 <20241101145938.304fd98b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101145938.304fd98b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 01, 2024 at 02:59:38PM +0000, Jonathan Cameron wrote:
> On Fri,  1 Nov 2024 15:16:00 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Dan reported that ddata might be used uninitialised in some cases.
> > Let's initialise it to NULL (patches 1 - 3). With that, update one driver
> > to drop an unneeded anymore check (included in patch 3).
> > 
> > While at it, one more cleanup to kxcjk-1013 (patch 4) is added.
> > 
> > Jonathan, dunno if you want to rebase at this stage (probably not),
> > but if you do, feel free to fold the patches 1-3 to the initial code.
> Ah. I've just picked v2, but given I squashed anyway the commit message
> changes don't matter.

Thanks, I have looked into the resulting changes and it all LGTM!

> I was curious what Assing meant but not need to
> ask given I wasn't going to keep it.

He-he :-)


-- 
With Best Regards,
Andy Shevchenko



