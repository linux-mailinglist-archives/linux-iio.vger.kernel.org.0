Return-Path: <linux-iio+bounces-25556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9492C13819
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11301A627C6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C42D73AB;
	Tue, 28 Oct 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyetWjTN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3253824BD;
	Tue, 28 Oct 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639575; cv=none; b=usXvw3d5UGp4DWG61dAy3Cw6rg4fjqswV3SDpnFuEInHPidoNyI3Hi4Kut+14U4uhzl9Jg3OnQIyyGdb7DNY6dse6yR4mMKOX+sw13yynbdMDPNcLTf+P8uaUA/g2mWzWzSDZ1hkSfd4l0IhJngDl2gO89exHV+VEcYdFP7fuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639575; c=relaxed/simple;
	bh=4+HHZ8nska1rNi+Y6CMZzaKHPELVr5SveLUFyjjMxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WckWiydgS303/idniMf0WATQEhPGeiRp8epTj/0A94ovFc5CIpg6A7pewxXn+k42Y0FG2+hbdejFoFf1PqldGn2fJ7uqjv8PWBYHUSyr1LwRjxnMBD0sFn6JLrDiSp/Q2yXqVCG87/Sd++ZIdPaIvBDaaChOL8JA+qoS+xDcjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyetWjTN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761639574; x=1793175574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+HHZ8nska1rNi+Y6CMZzaKHPELVr5SveLUFyjjMxB4=;
  b=fyetWjTNB8AtN1Jq5T5xD/Kh3/ebmD17dzxZv1DD1U5Wt3ftVFaSK8vx
   FXMMnsuFFgEqOAc+CteSR/QSdzJvOMj0LnyEPUi/0/jv0zONbvDnxbHdq
   JYmjOY7KO6UmPad5OokMCFlNXxRh2/W5n+lz+XB/sRoq/C79LpRw/PU1H
   lLg2mSqN0maQ0e70m1t4tzBMy3dzom3vVN+uw9mcRvdfHJ6xO9S57Jpd3
   x+1usiaevpYPZbNpMbqqARqQGe/mCMa3LkAuaIlUgZJ++AE2VJNDCmMIf
   lmkGMPbjdJpdHDcfN7j9v4ELjaXL6Zj22GAThBDZ2FiIaJewYrTNGWlNo
   A==;
X-CSE-ConnectionGUID: 1sIsOCsZToCl0xLIjw9TEw==
X-CSE-MsgGUID: 5tHy42KsTGqVov9PhaYJGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89202795"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89202795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:19:33 -0700
X-CSE-ConnectionGUID: TrZWUd9tQTOkRo3Fc1zUEA==
X-CSE-MsgGUID: 99L51bt+TrC0HvxoVZS5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184980522"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:19:30 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDevP-00000003FSe-1203;
	Tue, 28 Oct 2025 10:19:27 +0200
Date: Tue, 28 Oct 2025 10:19:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:

...

> > +	if (count >= sizeof(buf))
> > +		return -ENOSPC;
> 
> But this makes the validation too strict now.
> 
> >  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> >  				     count);
> 
> You definitely failed to read the code that implements the above.
> 
> >  	if (ret < 0)
> >  		return ret;

> > -	buf[count] = '\0';
> > +	buf[ret] = '\0';

Maybe this line is what we might need, but I haven't checked deeper if it's a
problem.

> NAK.
> 
> This patch is an unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



