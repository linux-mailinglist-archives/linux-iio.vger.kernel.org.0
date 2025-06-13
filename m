Return-Path: <linux-iio+bounces-20593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C67AD8C90
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0C188A39A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DD1BC5C;
	Fri, 13 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP8hRBt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A01862A;
	Fri, 13 Jun 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819224; cv=none; b=NFN5bZGMkORbKLincCmjEOd2u4JvaDnOT5p0irtnsrBwAMFgfnjaQQ/LVImxEmaO/owOhhOzMZhiGzjAfgARLmH2QDz01YiRZ6hkWkEaihiOnfvMbFM0I89TmrEm1isMtzw7fugSg2HYPpuaiBMfKg96/Yw/G+4SS9lg/U64F6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819224; c=relaxed/simple;
	bh=bUAaw68plyRec84yC3DRAZa8bUPMpRAHJ9ginor+ThA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECsxl7Q9CIVHD7xdgzu6WmR7fzVGgqwM81bJu/74RCcBGKtXEnQMsIEzvxNH6/WnGqVW555d0t0sXuu8BBMMs6vvs1QglM1PYnRqdyy474+moxl1+YlvFzxTXp/WCy+KATcHbZbEC5JbdNwqV1i2DlB2hoH/s8+JlBTn+285MoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP8hRBt3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749819223; x=1781355223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bUAaw68plyRec84yC3DRAZa8bUPMpRAHJ9ginor+ThA=;
  b=QP8hRBt3u/GLs+Y17INKzA95uRPzquDz2QLlIZw+qC7N5e/EPIRC1x+r
   37PZMhsyZ9RsCQ+NL2K32u5ZpM2JoXJjJzi0VWZCAjsLZUrLN1yLEhWRN
   4kpGXEOFtNoGPXHxTcsIJOjs+x1GcVisWe8IwXjqvd+tYeticGtDinGFA
   ULTFWjcfVyFhN8Z2LVquI5aNY3cuFaMax0KUPZhfb/80eecG6XA18wyqJ
   RRe7jQRB5N4tt8Qs4RMkJp6II5b/1ipyg0kRD7I9Q8hIfufsezW+VrsMn
   G6oqq/S/acpOvlMkkID9LUNIzFafEAjZLtB8N8QqTEw5hXLGg2gLo7iuV
   w==;
X-CSE-ConnectionGUID: HFuhGv0nSYq/n/LpWliyZA==
X-CSE-MsgGUID: ESPEZbyVQjCGPRzPfPVk8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62685476"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="62685476"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:53:42 -0700
X-CSE-ConnectionGUID: S4fC78AnSSWqOKrwz1YYJQ==
X-CSE-MsgGUID: UononswRQiyDi0AwwC3mVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="178719207"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:53:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ3ua-00000006FUj-3dpQ;
	Fri, 13 Jun 2025 15:53:36 +0300
Date: Fri, 13 Jun 2025 15:53:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <aEwfUMgLTnQxOh_k@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Friday, June 13, 2025 10:29
> >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> >> +	if (sleep_ms)
> >> +		msleep(sleep_ms);
> >
> >I still wonder if we can get rid of the conditional here.
> >Would the
> >
> >	fsleep(sleep_ms * USEC_PER_MSEC)
> >
> >actually work as expected?
> >
> >Ditto for other case(s) like this.
> 
> fsleep(0) would call udelay(0) which is architecture dependent. It seems like
> it may delay for a very little while, but I'm not able to check that.

Hmm... This is unfortunate. Somebody needs at least make it clear in the
documentation if not yet done.

...

> >Overall, looking to this patch again, I think it would be better to prepend it
> >by replacing *int*_t types by the respective uXX ones. Because in this patch
> >we add dozens of new ones which increases an unneeded churn in the future.
> >
> In my opinion, to respect the rule don't mix *int*_t and uXX types, it is better
> to keep *int*_t types. If it need to be changed, we can change afterward the
> whole driver types with a replace tool and send it in a separate patch.

It will be never ending story, sorry. We need someone to solve this tech debt.
And since this patch adds more than 3 new users of it, I think it's a candidate
to embrace the burden.

> Jonathan,
> what is your statement on this point?

-- 
With Best Regards,
Andy Shevchenko



