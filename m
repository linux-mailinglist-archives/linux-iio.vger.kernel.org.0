Return-Path: <linux-iio+bounces-20884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C3AE35E7
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B508170708
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820E1E5B8A;
	Mon, 23 Jun 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLtJ9a0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D451E5B90;
	Mon, 23 Jun 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660803; cv=none; b=VxQK2DdYzlKqllOHkJCaOsVm1HZ6Q23nHXxmRZdOso08zcXpK15C36klrwp/DN8EytnMsNYj2ei9oR36Pmeoo0fNlbu/94locA9lApeNyO7sWVCf1IZilA4nJorJhJQeo8PmFyKVfgQfQeyor40RJvHsmNQJqar6mxvzMXJQmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660803; c=relaxed/simple;
	bh=AkQsXjCKBE0FDDEmr6BLKHKqMfKtoslc3CQ/TntZLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSrhaCIx+J6lYR+DMWRFUShBNmtjmMB/ctSHwA3wKNVqqNX7goi61tUyobTeHUHebEvZE1f2d74eGp0qw8zpTpRpR7snwV40p0ooohFPiqtgYwgPRprTcmVtVSjOsjf7sq9zGKALQI5VHllpMgxfD3z4DXo/9dGYVK0Y3859+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLtJ9a0M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750660802; x=1782196802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AkQsXjCKBE0FDDEmr6BLKHKqMfKtoslc3CQ/TntZLjM=;
  b=lLtJ9a0MEi9Dh4GmsXcMPQl7l3SpB9RD0Gfe2e2la1kjykNAjZDpe541
   nFda4sSWTPXFfSyiibHfRBvgLG3Kdh6pqufXgceasXbikyABgptd34vMP
   eafSWf0r21kbXL1CzpQrJ5fsctyAxO23lJ2OQfn1GRqfebTFe7Vj+JF+8
   mmUNFfAZOclph47RSHvxv+R/efBQ82DBgK7FfQZZI6mAWWWOZeTBgHiF7
   dMFhG2jY4T87XGEKZ7u9lkDg4RUGYQ9GLLDbOa/s2CJn223fFxnzbf3ti
   X6aK98oygqyPMwW7SQi4SrKThyTXrost6mJSEr7oCNw8gy1QOs/TJnXu9
   g==;
X-CSE-ConnectionGUID: 5pEVYpVESHq7OztEm5I9lQ==
X-CSE-MsgGUID: BWLAIfykSU+obN33FZjohw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="70422079"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="70422079"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:40:01 -0700
X-CSE-ConnectionGUID: Ri1QsT2OQQW8b4ytEfKyjw==
X-CSE-MsgGUID: gI6CSArtRD2oNNdTMqXLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="182378616"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:39:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uTaqR-000000095Kk-3mBi;
	Mon, 23 Jun 2025 09:39:55 +0300
Date: Mon, 23 Jun 2025 09:39:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <aFj2u3Tv4o72Hqi8@smile.fi.intel.com>
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
 <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com>
 <FR3P281MB175775DBE90C5469637F3C66CE73A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75Ve0aQLaRS1-J5WoCxUAfX+Y=s2oj4ZkVvUG1XysXopZxw@mail.gmail.com>
 <20250621181339.0331ab8b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621181339.0331ab8b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 21, 2025 at 06:13:39PM +0100, Jonathan Cameron wrote:
> On Tue, 17 Jun 2025 21:33:46 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 17, 2025 at 5:43 PM Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > > >From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >Sent: Monday, June 16, 2025 16:33

...

> > > it is good for me if we can add Cc to stable.
> > > I don't know if I need to add the Cc tag here or when a fixed patch will
> > > require the rework. In doubt, here it is.
> > >
> > > Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > Cc: stable@vger.kernel.org  
> > 
> > It makes no sense here. This is a standalone change. It's not part of
> > any "fixes" series. You need to attach this patch to your series as
> > patch 1 and mark Cc stable all of the patches.
> 
> I think this is hypothetical at the moment as the only series outstanding
> is the WOM one which isn't a fix.  So I don't think this patch will
> ever end up carrying a stable tag.  However, first time we get a fix
> that needs it, if Greg etc don't sort it out anyway (they often do!)
> then a simple mail to stable@vger.kernel.org to tell them to pick this
> and the fix will resolve it.
> 
> For now I'll queue this patch up and ask for a rebase on the WOM
> series on top of it.
> 
> It crossed with David's series doing {} to replace explicit memsets
> so needed a tiny bit of hand tweaking.
> Pushed out as testing for 0-day to look at.

Thanks, Jonathan!

-- 
With Best Regards,
Andy Shevchenko



