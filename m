Return-Path: <linux-iio+bounces-26830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C4CAAA41
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95530301C78A
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231032F0C46;
	Sat,  6 Dec 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7LPJj64"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31830213254;
	Sat,  6 Dec 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038665; cv=none; b=L6H42yziddx3K1ZD+H40OvBy9mpI3clnk89r5cE0Ay4Fpw9A4iy7e82FUCrKbf1IEOHk8BHyIj9KTQsCFahrCmB0Lj34ADvi25YdJUlarc/CxD2TtGqPTCtgs8Q2LIo+oGE9l8bqckiD0lp+5etpYEqlKfEVgU9Tr3+OIK946U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038665; c=relaxed/simple;
	bh=6UR3+Sfdy3YPa+swKlNxpHvxQFvtbDzdoPw41EWzBPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asyz4uVO4xfJCLvrHiogE7RoCYbVRKoJos/ftiaiix1fA9f808zC7aiB2IvZV4qyRU/9SAgiFRDx+I0pGCzWNosG7Fs/pM9v17soOcQSruK8Pctifpsw5cNSNMP9kZgHPEjhwVpexXIkAXbBrwHJX279XVIKCDpaWtdTCMq/eC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7LPJj64; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765038664; x=1796574664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6UR3+Sfdy3YPa+swKlNxpHvxQFvtbDzdoPw41EWzBPY=;
  b=n7LPJj64z9fILuWfVFA8mZi3eOvj4m0I0vyL+CEJ/tYR56e/JNyaj6+1
   5d+6/h7gqGHrdXGrlLx4VboMB0QR5xmEIHHurdAoKPpONdcT9preXyACw
   GbgEscdRPe0vJu7xsLGqKXcm7xqsZLgaKaCbQ4/oeMbSk21vAX4y5iBLJ
   BWuxEUWoisk10gvbtFvbF93Ccl/FVxu8MaWlL8YJt25lvB9bdO63gbYVq
   VTlCxpDeE6tvTAbClveM9et6aQ3JuyMuQXLiJ0a0A/Y18Lj+1NY+llLSO
   5xTpTNTuTxovcwm/Ll6AQIe6u8paHX81jbFBekALMARc2B/UxzCbl2XIH
   w==;
X-CSE-ConnectionGUID: 43KJQgHfRpSysFlKpFFjpg==
X-CSE-MsgGUID: RUzFPMoMSxqvtLULGzoG7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="92523593"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="92523593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:31:02 -0800
X-CSE-ConnectionGUID: lr8bKK/5SHmocKRkJz5ulA==
X-CSE-MsgGUID: zP/4+l4hSPqVZL2nSSNkjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="226565267"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:31:01 -0800
Date: Sat, 6 Dec 2025 18:30:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Fix incorrect return value in IRQ
 handler
Message-ID: <aTRaQzwbHXhGKE_n@smile.fi.intel.com>
References: <tQ6gupeNR5WXy61K0UZmDNzA2jlqAjibu-EqYV_XRtlg9D0x97yhFy6HUvzN7vLm6DePuDcSVd_qZ_lqin6_8Q==@protonmail.internalid>
 <20251202083952.1975-1-vulab@iscas.ac.cn>
 <aTOv8GxTcWRR39y7@emerald>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTOv8GxTcWRR39y7@emerald>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 06, 2025 at 01:24:16PM +0900, William Breathitt Gray wrote:
> On Tue, Dec 02, 2025 at 04:39:52PM +0800, Haotian Zhang wrote:
> > quad8_irq_handler() should return irqreturn_t enum values, but it
> > directly returns negative errno codes from regmap operations on error.
> > 
> > Return IRQ_NONE instead of raw errno codes on regmap operation failures.

...

> >  	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
> >  	if (ret)
> > -		return ret;
> > +		return IRQ_NONE;

This return is correct and we can't do much, if we got again to this handler
due to unserviced IRQ, hopefully the second attempt will succeed. At the end it
will mean something really bad happened to the HW state.

> >  	if (!status)
> >  		return IRQ_NONE;

...

> >  	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
> >  	if (ret)
> > -		return ret;
> > +		return IRQ_NONE;
> > 
> >  	return IRQ_HANDLED;
> 
> You are correct, we should return a value of irqreturn_t and not raw
> errno codes. However, it would be nice to indicate to users why the IRQ
> was left unserviced before return IRQ_NONE. Is there a way to indicate
> the regmap_read failure, perhaps via WARN_ONCE() or similar? Is
> regmap_read actually capable of failing in this context, or should we
> just remove the conditional check entirely?

I'm not sure about this case, clearing pending interrupts is something
that should not affect much the flow, I think if we return IRQ_HANDLED here
we can re-enter to the handler and re-read the status. Yes, it will be
spurious interrupt, but at least it will reduce the probability of IRQ storm
registration (when when we return IRQ_NONE).

-- 
With Best Regards,
Andy Shevchenko



