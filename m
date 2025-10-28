Return-Path: <linux-iio+bounces-25596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FFC15699
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94066502608
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329A33DED3;
	Tue, 28 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuEpn00l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A02E7BAA;
	Tue, 28 Oct 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664760; cv=none; b=fIEZp/DnEVp5uVSg+ZOYiaMg3+m19M1j2WH3gPI48aYD29xnFiLwVhRBRp0TzyyFPicEnxPouNW+BAPGnJVTTZYYWgx3Be3XKmadUKfJbrfkkitfHLEUWd6l4k96n42JtacnisWDzr9TiQbUf1QdyiVg/PSPgr0VDZUO1NHsdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664760; c=relaxed/simple;
	bh=YfeA9WDImd+OY7C5WhOa1hQ4s8wAxkujvBRU2K6EBg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcKz/wHAEZ9VbTWKe6ofvRH0hfBuvm0dTyFFxANes7D3TnY+rzxk2zXSM+pjQUtfKs2DOi7vawvyG4tjOp9WmyghfyM5cp+jO67UiDmn0DY3wNpHMmavbjRR54OahH+0BfOyJcSCwUSx9TDfr9y/svSqDBB8ZECbMnxnycjpuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuEpn00l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761664759; x=1793200759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YfeA9WDImd+OY7C5WhOa1hQ4s8wAxkujvBRU2K6EBg0=;
  b=UuEpn00lwbrtw+EG4/wCEowCowkcStLEOySLOcVszOScbWtaqhgKBvUr
   /7yZXE8eoVFB1hlc/3ScR1N9Nu33LPj3XmBrBc3MqHryyjSo0IHhy5QHi
   YYZMByXRc3DTwGYp6zZUW7EswrS8pu7uRCxgjNgKVDbGICv07wR50FIa6
   np1SLNNnTsScsslX9BMyhU3yDTFR9Fz0kaVjVueAPNRA8oEBYU2DPrw+G
   Y8eIGMQ59cmT6sOBGvIzLcTbWe6gwRF5kusVEoo13tUqihWJfGZ9Sc/eu
   7eu81xDhbujZdEGtLq95zhQBdQJiJkvQ54gVY8CW3trkSi0mMZWvAULrC
   g==;
X-CSE-ConnectionGUID: 6TkJkKBkT9WOHcVhpDeJPw==
X-CSE-MsgGUID: CIuUfOADQTiiFpyHzFVpXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67632035"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="67632035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:19:18 -0700
X-CSE-ConnectionGUID: 23FxZjE0RhSi50fQRTKghQ==
X-CSE-MsgGUID: zAQ6VqKPSP+GPyCHdgQyRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="186122207"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:19:15 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDlTc-00000003LlR-0BQf;
	Tue, 28 Oct 2025 17:19:12 +0200
Date: Tue, 28 Oct 2025 17:19:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Miaoqian Lin <linmq006@gmail.com>, Markus Burri <markus.burri@mt.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <aQDe7-ienRpcfNV_@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
 <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
 <aQDXF-AIF6wNIo76@smile.fi.intel.com>
 <aecd2e25900f2ef38f937a295e995269c433453b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aecd2e25900f2ef38f937a295e995269c433453b.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 03:12:29PM +0000, Nuno Sá wrote:
> On Tue, 2025-10-28 at 16:45 +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 12:31:04PM +0000, Nuno Sá wrote:

...

> > For the latter I want to see the real traceback and a reproducer. I also
> > wonder why
> > we never had reports from syzkaller on this. It has non-zero chance to stumble
> > over
> > the issue here (if there is an issue to begin with).
> 
> If I have the time, I might do it. If my suspicious are correct, it should be
> fairly easy to reproduce.

My suspicious is also like this, if you have a working setup for one of such
a user (like this chip) already, it's ~15 minutes to get it done without
writing an additional code.

-- 
With Best Regards,
Andy Shevchenko



