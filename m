Return-Path: <linux-iio+bounces-26980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51605CB0D11
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D543301E9BF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA612F5A27;
	Tue,  9 Dec 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5sLtQhX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BA2E22BF;
	Tue,  9 Dec 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304272; cv=none; b=Wffa4ZubxHmlJS7cRZx0hYtPgfhdg0zyglzcbysygp7dhfvItBuCV0XLXwEfZ8vnp3HZ6J7U2LfGgFW3Q2cnPd9KSeKPyaahxmnQYmg36nXAagINaWr091ncBWCb67akavxuFGvK0DNt245DVoc4kgySzFvmIr8QN+xo1+9O0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304272; c=relaxed/simple;
	bh=f09w2Udon89LGFPFVpQ3hodYhn9Zi7YvqjQgrf1g/Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCepjWW+vFufS3HYJbnGmPvxjFSJ0m+cGbzK+2n6rniHHfxZSHxMw3kFHy1MHwzXsjPgk7onBqP+dujmouTL6aJTUg58MPxKag3rmP/6stZEcuY/OVFu5GB3KchG+kG5RNrpoTpUGEVY+F+4CSozU7BA+BBZ4Db4j3Ug2rSuSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5sLtQhX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765304271; x=1796840271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f09w2Udon89LGFPFVpQ3hodYhn9Zi7YvqjQgrf1g/Ow=;
  b=d5sLtQhXBKPLjMY8BmxCtTPX78afqDDfSYg1XNiGEmijAnM6tcJ5nY6Q
   OpcDf77A13hXPLF35Z1RiwSQcZCo+GE0majw/+ZLAQwxqLy/YEB77ut0T
   iaNL0VbprqwXT4KWJiEbrR/G7rFUOJ3DBZ9xN6GoLZCtJIRQFEwl69QM4
   4UN3t40tjbhAHT+7NIV8CA154UAEN6NXrxwM+XxTG/Mjh+w6XXlWPlgI5
   Yf0ioplyHMiiKRKRryncfEZk/MgKMvRIocoocVBq7v1v3TYH964LoNu0e
   GlPVbFmWOcpWxylKDFEMBwPfrkAZyBHY6ET9prvx1MhZgxtPe7A4l9eDY
   Q==;
X-CSE-ConnectionGUID: wgy8Rt7/RZ6bJ4043o+fQA==
X-CSE-MsgGUID: eTDVaL+IQbGtS0Q+7QhZHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="71131225"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="71131225"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:17:51 -0800
X-CSE-ConnectionGUID: Oy3w8CXgQRW4EPlix1ll0g==
X-CSE-MsgGUID: f0dajaqcQxi8EBDCOkpNOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="200719444"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:17:47 -0800
Date: Tue, 9 Dec 2025 20:17:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: ad9467: sort header includes
Message-ID: <aThnybDs4lk9ht_f@smile.fi.intel.com>
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
 <20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
 <CAHp75VeOZHvxr60R0TCS5_c-xsrmfC97gWdP4-EWvFPpbodLTA@mail.gmail.com>
 <7a792f4e-edba-42f3-bcc8-76004972c2f7@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a792f4e-edba-42f3-bcc8-76004972c2f7@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 05:46:16PM +0200, Tomas Melin wrote:
> On 09/12/2025 16:41, Andy Shevchenko wrote:
> > On Tue, Dec 9, 2025 at 7:34 AM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >>
> >> Include headers in ascending order.
> > 
> > Thanks, but...
> > 
> >>  #include <linux/iio/backend.h>
> >>  #include <linux/iio/iio.h>
> >>  #include <linux/iio/sysfs.h>
> > 
> > ...this was specifically grouped to show the relation to the certain
> > subsystem. At the end we should have something like this
> > 
> > linux/*.h // generic ones
> > ...blank line...
> > asm/*.h // generic ones (optionally, if there is a need in a such)
> > ...blank line...
> > linux/iio/*.h
> > ...blank line...
> 
> Thanks for the clarification. Sure, it's not a big deal to do a new
> version. But FWIW, that convention is not AFAIS explicitly stated
> anywhere and with even recent drivers not all following it, it's
> somewhat hard to know what expected formatting should be.
> It would really be good to have that documented somewhere.

I fully agree. The problem with such a documentation is that you will always
have 50/50% split at best. At worse ~100% will be against any doc updates
like this. For minimum we can do it on an IIO level (only for this subsystem),
see how others do Documentation/process/maintainer-*.rst. There is no IIO.
You can start it :-)

-- 
With Best Regards,
Andy Shevchenko



