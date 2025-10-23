Return-Path: <linux-iio+bounces-25397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8387C03073
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D19E3AA6B3
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BAB28032D;
	Thu, 23 Oct 2025 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1Q2pcq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349627AC4D;
	Thu, 23 Oct 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244685; cv=none; b=mOPGFcdoHMeSwUD6YRqgWE9J7B0Eg76i+8l6NdYxLyxXVAsYBh8FxYgGYgtxEn4azmv4934LGiXImvS4wCQpdIGRFMMfR8oFtvaez5MO4IKVJWAKL7GHjqxXFbSbKZy+Qe77PJq+njwPEuPtfPur7UBHWnmVYOlt3GKhMT5ZXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244685; c=relaxed/simple;
	bh=jFr4xShDGQKlComnou2o80VctOUNsQv0T6YGPfBQUoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV1WQ3UzjQzkJSXUR0NJczOc1PPfj2EnOVJq8OId5+lmXMerL53aSVItSILF7o+s+AYvaPcdMT14X1WRLnrFnglbpYG6AoYD3G9xT8hUdv+meMjkOpp5qtBwcwUzbS1BaGQMBwGJvKEUTgCMz7l9x1DdBWl2cV4PMZsVgD98dLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1Q2pcq8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761244683; x=1792780683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jFr4xShDGQKlComnou2o80VctOUNsQv0T6YGPfBQUoQ=;
  b=Z1Q2pcq8Xc63+WBRlkv/kDnIdoOkMQ29nPIERR6dEh6zrR8tss/uGIUa
   tBhwjMOIAtt1LFnHtKvG7w/QYOlTySkBtsFvYT0DCt6Cd0LdFF5Y08Z7N
   2XTU5J63kSt2IMxzzJ1c0m+T2etULcPysx3CEsZG8tk2IhHdGCpXSOzhL
   z4nTx6bTF/ryWaNKcSIB2XWoIfiCR0N5sKCRB2P4xPD+8rqQiIjwlQLYs
   1H4H9s158zVrNh6GXL4RBHm+ZsD0FsbkCXsdyJKcWrROW3HouCU7rMtWi
   cDH0ZhUEV/PvQLeb1WZ39nB1prJVNID9R7JfrSgT4bWn/XyD768JB2N5D
   w==;
X-CSE-ConnectionGUID: rq8I0zChRfSV5PiubmdJrg==
X-CSE-MsgGUID: JNBNwR0LTGykbbk07w4waw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63573129"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63573129"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:38:03 -0700
X-CSE-ConnectionGUID: Q06e3c34TgmL0Zx1SbB7uw==
X-CSE-MsgGUID: PzTvBSmrQhyrGlieA0m7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184615898"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:38:00 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vC0CE-000000020wR-0E1k;
	Thu, 23 Oct 2025 21:37:58 +0300
Date: Thu, 23 Oct 2025 21:37:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <aPp2BeNqFJABsAkg@smile.fi.intel.com>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
 <aPjE-n0wKNIJd2-M@smile.fi.intel.com>
 <20251023182318.00004319@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023182318.00004319@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 06:23:18PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Oct 2025 14:50:18 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 21, 2025 at 01:31:49PM +0300, Petre Rodan wrote:
> > > Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> > > based on i2c_verify_client() in bma220_core.c that would make core
> > > always depend on the i2c module.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > But Kconfig for this driver is a bit strange. Usually we do other way around,
> > i.e. make user visible selection of the glue drivers, while core is selected if
> > at least one of the leaf driver selected by the user.
> > 
> This comes up from time to time.  There kind of isn't a right answer
> to my mind in the trade off between complexity of configuration 
> and desire for minimum useful set of Kconfig symbols and people wanting
> to build only exactly what they want.  So we've ended up with a mix.
> 
> I don't mind setting a policy on this for new code going forwards, but
> that means we need to decide which approach we prefer and document
> it somewhere.

One immediate thing from top of my mind why current approach worse than
proposed by me.

- when you have an SPI or I²C enabled the glue driver will be silently build.
As a used on the embedded system with smaller resources (flash/ROM) I prefer
the opposite behaviour, i.e. when _I_ control what SPI/I²C component driver is
needed even if the subsystem is present.

But let's give a time to gather other opinions and justifications.

-- 
With Best Regards,
Andy Shevchenko



