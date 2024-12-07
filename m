Return-Path: <linux-iio+bounces-13207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9939E81B2
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8858E1882A84
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9D14AD0E;
	Sat,  7 Dec 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvhXOYSA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239117E0
	for <linux-iio@vger.kernel.org>; Sat,  7 Dec 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597917; cv=none; b=nWuuN7loylGze5S4YBeF18thaNKELDFyFyZcsHpAXFSFzbPklqWjD17vw2NGkOEHwI2DI9U2xbbEybzxP4nOwZdv6HJ2Ia8gvtERWulwwhtvo+0g5WrwLaXgnCGeKOJ2p+0cicNhLmqQNbAAwpe4nbBKyhmzdPqWHt8d6HyOR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597917; c=relaxed/simple;
	bh=bYV405K9c4pghL10q5crHXg9uBz1P+gwcNo4hkGYxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4xim2M0P7fwFyCDwW1bzermmrxzB4eQRJq2AgixJLJsuntdZpDdgnr5MPR3bsr4lGCzWy5Njmc/7hPEB8Rp4Lrv2EQnQtUQFb5vvX9kKl4zyVRjB33dbyJyhsw8VtaBaonV2KpSTSrmcOsT03sEzZ1vGDYjayP0IArRyLzSp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvhXOYSA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733597916; x=1765133916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYV405K9c4pghL10q5crHXg9uBz1P+gwcNo4hkGYxxg=;
  b=IvhXOYSARrAz2AguPoDkzSbLEcJmxmNhJbAcJbmMu+YFRsi8cQbpbb57
   tJmrBttkL/+kAo52iS4mFHf4YPKNmyzqskqXLas66JedHYK500ufMg/R8
   W9dTMk6WW12dDP3263bGl42BPmNqwEY0lWz0LBzzXY/p6ZAmgKss03pAj
   DAGKb5MPyoqpAGarCX30KtOvHURYMQsvuL1FOPvwKI2fgqWO1KpZJbSy/
   iAamP+VBR0xaY8J64cEbo/PRFEf+B9PWEB+aQ2a468/biXGDa8hgLi/nB
   4sinzGMozYG1HNgvD60axv7I2XR1ZEqHBVPXOjVPKz5WoxcaENMwiSbV5
   Q==;
X-CSE-ConnectionGUID: jCFaF4o8SMSsqP9aiPOcag==
X-CSE-MsgGUID: NCg5twBBQSO9amiZNw9Qfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="33819336"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="33819336"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 10:58:36 -0800
X-CSE-ConnectionGUID: /6DBUX4YTuOp0C0PA//R2g==
X-CSE-MsgGUID: bqGobrmkR12YLARrz2hPlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="94785530"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 07 Dec 2024 10:58:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3517E1FF; Sat, 07 Dec 2024 20:58:31 +0200 (EET)
Date: Sat, 7 Dec 2024 20:58:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, lars@metafoo.de,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91: call input_free_device() on allocated
 iio_dev
Message-ID: <Z1Sa1-SlU9ENL5CA@black.fi.intel.com>
References: <20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241207173046.375dd855@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207173046.375dd855@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 07, 2024 at 05:30:46PM +0000, Jonathan Cameron wrote:
> On Sat,  7 Dec 2024 13:30:45 +0900
> Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
> 
> > Current implementation of at91_ts_register() calls input_free_deivce()
> > on st->ts_input, however, the err label can be reached before the
> > allocated iio_dev is stored to st->ts_input. Thus call
> > input_free_device() on input instead of st->ts_input.
> > 
> > Fixes: 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens without TSMR")
> > Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Hi Joe.
> 
> Good catch.  Longer term I'd like this driver to be fully converted to devm
> managed cleanup though which would have made this bug go away.

I dunno it's good.

First of all, the message doesn't contain any pointers to real issue, because
there is none. And this is can be checked in two clicks on Elixir. Hence, the
all dance with Fixes tag is wrong.

Second, the submissions is not following the researcher guidelines.

Please, consider dropping this.

+Cc: Greg to flag this email for not following the rules.
Joe, I highly recommend to answer to all your patches that you sent so far that
they should not be applied (at least in their current forms).

See also for the details: 20241204122152.1312051-1-joe@pf.is.s.u-tokyo.ac.jp.mbx.

> However, having looked at it, that conversion is a rather substantial, if simple
> patch, so I'm fine taking this fix and maybe someone will revisit to do that
> cleanup later.

-- 
With Best Regards,
Andy Shevchenko



