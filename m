Return-Path: <linux-iio+bounces-21962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A90B10981
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337681CE0888
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9426E6E4;
	Thu, 24 Jul 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nz4Ludj7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F041853;
	Thu, 24 Jul 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357668; cv=none; b=GTbd0WMtHQC02PCM6AqWD30xhQtZcGOMCuAoyDpO74Vb4j6tcKJBBbWX3p6Bo+ceehCqEEzOH961GeCE6iu/niG/+MMUV6ooZ7u8TUpygF6815DeBLvmkEhjyphIrI+kzz0zwfUR4PXqfAyWTrffYaIdQLPoxWZXFEG1JUTKX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357668; c=relaxed/simple;
	bh=xgs77wx0lM2xjLQDZNmkRKSFSgm61ftYEgfHt5CdHN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nocmY4/9ByS8SxAtDIU9mnkTMEA6ZrHSZN8SK5mKtqTNYzakUGHDyBf4jmxLZ8hrnoNYqYDqJkNDFTWVD8EQzuJhUsjlNBZxmQBPRfWH5GR2/f0v1KkxBGuC2Ym50a9ON2YSK+SN/fpOrh/Hxkahj0w8yWORO6Znphx8YeA/cvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nz4Ludj7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753357667; x=1784893667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xgs77wx0lM2xjLQDZNmkRKSFSgm61ftYEgfHt5CdHN8=;
  b=Nz4Ludj7N4BuQ4GN6Zv0rtyxlOJKV5y+VOg5HqePtAdrjc7n7rCnPljC
   Z1AyydO4ICdWQ3QB0GVrd0RdaVNWxt0zJQwiSBbNFs1xOPYMw5ArsYXF5
   WWwcoyRLoD6/iva+A9KLtiNv9e3fgGeW7VFPit+9FgmBLT3T7xPxH80Uy
   tqasjh0wCAHtw+ixpo4ktHArXZo09NoOEqS5+gsAs2JPbCqkX/nxybljZ
   JU747sq9Q2xIggazQLMcrAOAMK2a6iVj5otfJyjP7EIjXnMPTwPIHIMrB
   64DyzUPg8EIaIGFIfMkilnlDwwKnk5Yj/wEk8v82pTlkLS2aQlhurDzRF
   A==;
X-CSE-ConnectionGUID: CTZNpP2mS8SIB8D9H/qlyA==
X-CSE-MsgGUID: Bt5Vn+aUQrGGBna1pSUtGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59325236"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="59325236"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:47:37 -0700
X-CSE-ConnectionGUID: kvjP7398T1mxSOqTWcEF1Q==
X-CSE-MsgGUID: xsRqIuZyT7mW5crc68TO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160175276"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:47:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueuQ7-00000000Yh7-1siL;
	Thu, 24 Jul 2025 14:47:31 +0300
Date: Thu, 24 Jul 2025 14:47:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Akshay Bansod <akbansd@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <aIIdU7mJi_cEdRuI@smile.fi.intel.com>
References: <20250723141359.11723-1-akbansd@gmail.com>
 <aID01DxC1Hf2PK0i@smile.fi.intel.com>
 <20250723164100.34e864d6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723164100.34e864d6@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 04:41:00PM +0100, Jonathan Cameron wrote:
> On Wed, 23 Jul 2025 17:42:28 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jul 23, 2025 at 07:43:59PM +0530, Akshay Bansod wrote:

...

> > >  	fs_table = &hw->settings->fs_table[sensor->id];
> > >  	for (i = 0; i < fs_table->fs_len; i++)
> > > -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > > -				 fs_table->fs_avl[i].gain);
> > > -	buf[len - 1] = '\n';
> > > +		len += sysfs_emit_at(buf, len, "0.%09u ",
> > > +				     fs_table->fs_avl[i].gain);
> > > +
> > > +	sysfs_emit_at(buf, len - 1, "\n");  
> > 
> > Still looks a bit weird (while working).
> > 
> > >  	return len;  
> > 
> > I deally we should have a helper doing all this under the hood for plenty of
> > the (existing) users in the kernel.
> 
> hmm I'm not sure generic is terribly easy

I agree, I have some plans for %p specifier extension, but I was stuck with it
and it in half-basked state in some of my local Git branches.

> and I'd prefer this using the
> read_avail callbacks that require the data in an array where ever possible.
> Mind you that does the same print at len - 1 as this.  Let's play. 
> Completely untested.
> 
> 	for (i = 0; i < fs_table->fs_len; i++)
> 		len += sysfs_emit_at(buf, len, "0x%09u%c",
> 				     fs_table->fs_avl[i].gain,
> 				     ((i == fs_table->fs_len - 1) ? '\n', ' '));
> 
> better?

Without extra parentheses this makes the job.


> It's definitely not more readable than the above, but it does avoid the write
> to len - 1.
> 
> > In any case, I leave this change to others to comment, I don't object pushing
> > it in this form, either way len - 1 is simply weird.

-- 
With Best Regards,
Andy Shevchenko



