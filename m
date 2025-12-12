Return-Path: <linux-iio+bounces-27051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A80CB9076
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 16:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B433082A30
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2B3112C2;
	Fri, 12 Dec 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BksqUDnm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500027979A;
	Fri, 12 Dec 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551887; cv=none; b=M2PwJjy9sGAldTlV+RXfSGFkJbzDGaJSNBPNlDPWAxx+UzkMvU6h8t3+Lpp6LnuJrDOFcXlyNOB1drL7VGelGroDoUvZSqL7tkf7mzo+QdqD3NKbpUbXEodVe+KXLaYry6XdNEjwr/xjpJIXynM/TOydjcL9Qy4KExOAWSfB4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551887; c=relaxed/simple;
	bh=j/H0AoaiiNsQ/43vkWoHKGGTIGldMMdwCZUrKZVNK5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhFrwLQGQ6SntpgFNUfhVe/89eLWRdpkFLy7EbRRp4jXMAOO2dfB8/dD6Twb860ycIdYrPK2rPAIz+dE32tDF3iy5pvw+Ww0NDP9EqlSYafAugzg8cpynDKZDnFhvuJ9Gxi7+wXyE3M70Zo/jlEdh0Lu63Kor+vqzkWi95d5/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BksqUDnm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765551886; x=1797087886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/H0AoaiiNsQ/43vkWoHKGGTIGldMMdwCZUrKZVNK5U=;
  b=BksqUDnmVKphQ1GDiMWvZGmsbOEFERxQUaeXVqIXjrD6cwxi7XjGuZ2p
   vJFnKDCc6nKOmF9/bHE/SSadbH+23TMuvpjKRwZdi7VuZbNRUzi885/Pc
   DFONtLPCcY9VA3vkyiIMKwDVsrJ4vTBnbyV7l1tzdMqUuBOMXH6y2+KO8
   XFWaPNP3/ZOtOnaVFjardGFTTE7dfPZVFS8bvw5rbRmLu3tJ+jVM9kcJl
   Q+gcHXiCRTKZY6V/TocKmUy2ddzphYQpvA1lxCooFttb0eg7jzjsP+zlR
   hagSzoVEZ3hBejnqmCsPPHB08newa/F3NJ1oRleq5BZ0P2n86oGCuBHAG
   g==;
X-CSE-ConnectionGUID: xPxGI/2HTYStM19Dsj4jrA==
X-CSE-MsgGUID: ajfOXJD8SDe06kcapXSmNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="70138490"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="70138490"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:04:45 -0800
X-CSE-ConnectionGUID: +V5bDRF5ToOXvHGkNLPalg==
X-CSE-MsgGUID: mqn8+32JSBKd/6bxayETnQ==
X-ExtLoop1: 1
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:04:43 -0800
Date: Fri, 12 Dec 2025 17:04:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: 104-quad-8: Fix incorrect return value in
 IRQ handler
Message-ID: <aTwvCSJKtC26tK21@smile.fi.intel.com>
References: <20251206180007.1365-1-vulab@iscas.ac.cn>
 <20251212033417.24108-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212033417.24108-1-wbg@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 12, 2025 at 12:34:07PM +0900, William Breathitt Gray wrote:
> On Sun, Dec 07, 2025 at 02:00:07AM +0800, Haotian Zhang wrote:

...

> >  	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
> > -	if (ret)
> > -		return ret;
> > +	if (ret) {
> > +		WARN_ONCE(true, "quad8: regmap_read failed: %d\n", ret);
> 
> The warning should indicate the purpose of the operation so users know
> what failed for the hardware. So perhaps "quad8: Attempt to read
> Interrupt Status Register failed: %d\n" is better.
> 
> >  	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
> > -	if (ret)
> > -		return ret;
> > +	if (ret) {
> > +		WARN_ONCE(true, "quad8: regmap_write failed: %d\n", ret);
> 
> For the same reason as above, perhaps "quad8: Attempt to clear pending
> interrupts by writing to Channel Operation Register failed: %d\n" is
> better.

On top of that, I'm wondering if we can use dev_WARN_ONCE() and drop "quad8: "
prefix.

-- 
With Best Regards,
Andy Shevchenko



