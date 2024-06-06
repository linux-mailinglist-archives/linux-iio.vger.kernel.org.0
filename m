Return-Path: <linux-iio+bounces-5901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872208FEAE3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DEC1C25E1F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3021A188B;
	Thu,  6 Jun 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW0I7Rwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4371A186B;
	Thu,  6 Jun 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683188; cv=none; b=l9AzjAFIAjCPXQURifPN1uCmaCG2qxFcVB6xgWm/et4ryhh2qt1uP8NFEPIL2XlugmwaFwAQPHpQ6RSsVtNS84kyrPwSg48XyejxdvzPd9IZXL7muEAuN/vgX6dR/bRTUIrA3oq/FTjdXRZXwQCsat9qLvEvQYVTXS8nlSTEal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683188; c=relaxed/simple;
	bh=IsdLDPmj0SmbAXCgn+8qfRe+A3ztyr1j6wceGEhWF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxUIWfpaz1Fw7yoiPqy5MNkFllWtgJqde7VMeXsSPSmxhTEp8pe95vTUOOuvYqLQ/k5JqVttoQmwtYmFegPu7nFYCqEiOtE3VMDr+A4viQBTxDF3NB5Z10SNqCsZTJ2uqZFbEOvxbXecPzp0l9N+3BYPVuqx8qMuT9TfKaRcnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fW0I7Rwh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717683187; x=1749219187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IsdLDPmj0SmbAXCgn+8qfRe+A3ztyr1j6wceGEhWF0A=;
  b=fW0I7Rwh/brFkzpgDroUfYlzvwI8hDBjz+S8Z722ZvLihccNGyCoiQD1
   lXiAtdbHQUNOmp9+oZUAV5BQOpZCdoQI4nm4FFxagHuOgCdYyyo+DKOw7
   YuNSxqal9oMIgGLmnSOypOVhPRoWuiU1jAERHJmlgfo7nHrESSJE1ZEaa
   1K80tSuMHuQCX8XFRUUufUcW0roVhwtcQjNgcA2GokJzoy1Qzj/5D+aNT
   f6dgQ4GroxumTgQI7GJV8ev4nRJaqJuEPCanh9B/niaClUJ0NXXRtfEVg
   ASwo6CvnmAmd1nHRavYDphnzzBqDNUgO134pwCcxEgxZDBSsYv74+pNNI
   g==;
X-CSE-ConnectionGUID: B5CUVPBoQpKgD812XWCMuw==
X-CSE-MsgGUID: jsh/SuHASKuirfT5nbbO0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="24924368"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="24924368"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 07:13:06 -0700
X-CSE-ConnectionGUID: 8ND2elZKS2e+hKpRoRovhw==
X-CSE-MsgGUID: Ja7dKVhLT8ChYzA52oYi3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37837567"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 07:13:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFDrQ-0000000ECTP-019r;
	Thu, 06 Jun 2024 17:13:00 +0300
Date: Thu, 6 Jun 2024 17:12:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <ZmHD63_tvC75To8r@smile.fi.intel.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
 <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
 <ZmGMwwglUlS6_NI_@smile.fi.intel.com>
 <da57a64e4f5cdda7ee6b794c448995eee648c436.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da57a64e4f5cdda7ee6b794c448995eee648c436.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 06, 2024 at 02:27:03PM +0200, Nuno Sá wrote:
> On Thu, 2024-06-06 at 13:17 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 06, 2024 at 09:22:38AM +0200, Nuno Sa wrote:

...

> > > +			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
> > 
> > You can make all these lines shorter by using
> > 
> > 	struct device *dev = &st->spi->dev; // or analogue
> > 
> > at the top of the function.
> > 
> 
> Well, I had that in v2 (making the whole driver coherent with the local struct
> device helper but you kind of "complained" for a precursor patch (on a
> devm_kzalloc() call). So basically I deferred that change for a follow up patch.

Hmm... I don't remember the story behind this, but probably it's good to have
this done one (precursor) or the other way (follow up). Just check how many
changes will be done, whichever diff is shorter, choose that one.

-- 
With Best Regards,
Andy Shevchenko



