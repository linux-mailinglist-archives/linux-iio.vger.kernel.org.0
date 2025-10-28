Return-Path: <linux-iio+bounces-25583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F194C1538A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235991B20155
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65088238150;
	Tue, 28 Oct 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igwOak7r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A4231832;
	Tue, 28 Oct 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662752; cv=none; b=lOYE4kHPwiMXD2/+69XjChVvlh6ieQmIMYgXly/BKm+SrARebOtf3eXF8m1b0dAh+SvFjbGUhVtmZXap7XVccX889reXUNFG9NAJaF9fe6k6JntVUaxcd0djYg736Pw9ftBiTBV5qh3740vX0su4UR4X/qeOUyWZYNPkN9OoU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662752; c=relaxed/simple;
	bh=CKz4/uGHSCJbggykL29OUDHmz0rpQ9olHSJpLyDmkh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdIkENh9choUkK4j9XkmOAmZqsptVx6kemv9IKwDjehz1fXOkgRQIg9QxrDiWR8hxJ/U9EvKuWOb14Ca18XM+L8YffHSG+AD+RGC8qCLQZznFa+1OwyJaUo1YiIoAMVUCl1dqY9zL++XyqsQG+fk9or6DC86VKV4eAwQbkfKYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igwOak7r; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761662751; x=1793198751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CKz4/uGHSCJbggykL29OUDHmz0rpQ9olHSJpLyDmkh0=;
  b=igwOak7rTmMc6krsJpVMFbmAwRZXLGR9hA6SPlSMlYwTNo8sRt4o67Hc
   pdEWvKMsUORGyYMn1yXNufcT2YaQGBf2pejsUR/T78S/cJD+3H2lA/dBo
   GtQsOoGo39zLpcyJj2FFIHFQG8DaoEhoLSdMM1Qtfr56STCblU+3Q8zRM
   StaN3jg+Z8CV8whi6tnao4g5R2f0SibxNm2lh6Df4TFgKgt1KeXg16YZi
   dXbGGKlHHajBD98/4lvnwBtsglkSKAcFqKGdL216AH7UUnopk6KxmuYy4
   OGDolhBwNPiQM74HfDIhM8hM9Mtz4lbn63zVrHfgKwbkdG5am8DCTk95B
   Q==;
X-CSE-ConnectionGUID: 1JX92ApKSR6GGXIjiMAqXw==
X-CSE-MsgGUID: kVh3zKVaT52limn0G7Ro1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62968848"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62968848"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:45:50 -0700
X-CSE-ConnectionGUID: iWCXSjImRhGTf0U7Z51A1Q==
X-CSE-MsgGUID: JmD6khTuQtSN9qRoSpbcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184542880"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:45:47 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDkxD-00000003LEB-3qpd;
	Tue, 28 Oct 2025 16:45:43 +0200
Date: Tue, 28 Oct 2025 16:45:43 +0200
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
Message-ID: <aQDXF-AIF6wNIo76@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
 <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 12:31:04PM +0000, Nuno Sá wrote:
> On Tue, 2025-10-28 at 11:07 +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:

...

> > > > > +	if (count >= sizeof(buf))
> > > > > +		return -ENOSPC;
> > > > 
> > > > But this makes the validation too strict now.
> > > > 
> > > > >  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
> > > > > userbuf,
> > > > >  				     count);
> > > > 
> > > > You definitely failed to read the code that implements the above.
> > > > 
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > 
> > > > > -	buf[count] = '\0';
> > > > > +	buf[ret] = '\0';
> > > 
> > > Maybe this line is what we might need, but I haven't checked deeper if it's
> > > a
> > > problem.
> > 
> > So, copy_to_user() and copy_from_user() are always inlined macros.
> > The simple_write_to_buffer() is not. The question here is how
> > the __builit_object_size() will behave on the address given as a parameter to
> > copy_from_user() in simple_write_to_buffer().
> > 
> > If it may detect reliably that the buffer is the size it has. I believe it's
> > easy for the byte arrays on stack.
> 
> I think the above does not make sense (unless I'm missing your point which might
> very well be).

It seems I stand corrected. I was staring too much at copy_from_user() without
retrieving the validation logic behind simple_write_to_buffer().

> So, __builit_object_size() is for things known at compile time.
> Moreover, simple_write_to_buffer() already has all of the gymnastics to make
> sure copy_from_user() has the proper parameters. The thing is that it does it in
> a "silent" way which means that if your buffer is not big enough you'll get a
> concatenated string. Sure, you'll likely get an error down the road (due to an
> invalid value) but I do see some value in returning back the root cause of the
> issue.
> 
> So, the preliminary check while not being a big deal, it's also not completely
> useless IMO. I do not have any strong feeling though. However, I think the below
> is very much needed...
> 
> > That said, without proof that compiler is unable to determine the destination
> > buffer size, this patch and the one by Markus are simple noise which actually
> > changes an error code on the overflow condition.
> > 
> > The only line that assigns NUL character might be useful in some cases
> > (definitely when buffer comes through indirect calls from a heap, etc).
> 
> I think you can easily pass a string >= than 64 bytes (from userspace). AFAIR,
> you don't really set a size into debugfs files. For sure you can mess things
> with zero sized binary attributes so I have some confidence you have the same
> with debugfs.
> 
> And even if all the above is not reproducible I'm still of the opinion that
> 
> buf[ret] = '\0';
> 
> is semantically the correct code.

Yes, but it should either be explained as just making code robust vs. real bugfix.
For the latter I want to see the real traceback and a reproducer. I also wonder why
we never had reports from syzkaller on this. It has non-zero chance to stumble over
the issue here (if there is an issue to begin with).

-- 
With Best Regards,
Andy Shevchenko



