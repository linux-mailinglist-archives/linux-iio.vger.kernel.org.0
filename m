Return-Path: <linux-iio+bounces-26015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1BC3F8F6
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330F93B3865
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73679307499;
	Fri,  7 Nov 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVmdsALw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59282DEA89;
	Fri,  7 Nov 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512165; cv=none; b=nrREXRLv+wyYdBjZD7F5FEOeVWs66YC/KZGTWvNFa4Z0+8Z0pPmpSigsGxpspE7QikkgpE/Ur0GZSJEnCbbNJDaVFsKowS9o1XmI5u/8nEqwjxOSm0N/OtSV2na4K1LstvlpGuiBtd2QXx+yzB4B3OcqGPidWzci2wDJVf6FnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512165; c=relaxed/simple;
	bh=4f+tv6YmDv9PHhPG9r8au2y8HaBkG3+zpurKt4CAx+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdAV9TzCQfZPbz6uQnS1fHKPIdRQlK6s+ixorzhK4deG71V1wShoGIULXQeZrMQWjM43FP8El7NZ+HB1MPlVO2MDI3yQCttDxe6oCk0xv7E7CS37HRPOPPESSNWMzFWpUqIg7oOxO6aCzgh9WoaOkzUslfVhI/YkCvBdAlvUvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVmdsALw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762512164; x=1794048164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4f+tv6YmDv9PHhPG9r8au2y8HaBkG3+zpurKt4CAx+8=;
  b=TVmdsALw9ECw3XdK3NDFR+vnS69H/Gc7gmW8T+ZCfmrMb+OmjSAMdrWt
   uu1yE9fFTHXkOEtt6w3SRrII0mljKSl9eipiRwCRs/lrHYuhvg0pcgKmq
   6OW2F1BT+2675UVetsUAoMopWlgu3Goad7dYd7oslEf+uGXLr34xC3aUu
   lI2kk018LKhHfInvhdR4UTnj+YWqkP6TtLd8jQmq27SeElxPJC8g3CBba
   PmSAnWVvOdnAICHIaqbCIR4Zzq1MsI0o00xhhfUk+HZCQ8YnPOeKYXv6h
   pEZmEW3kEWAdMfNl0WBOXHNqaXIIYpzAWWYXPgWoBxEB56/FQWtOuCvxH
   w==;
X-CSE-ConnectionGUID: 2rBJ/9buRM6dP+Fscz2MoQ==
X-CSE-MsgGUID: HCSwHV+7SdeDhJLX4/r91A==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64360065"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64360065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:42:43 -0800
X-CSE-ConnectionGUID: /eQh7fCnQ8mgdZ9jOUNjYg==
X-CSE-MsgGUID: 647+2PqiT6i1cXPVy5ZACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187666695"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:42:41 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vHJvS-00000006RYH-1AIP;
	Fri, 07 Nov 2025 12:42:38 +0200
Date: Fri, 7 Nov 2025 12:42:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
 <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno Sá wrote:
> On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> > viio_trigger_alloc() initializes the device with device_initialize()
> > but uses kfree() directly in error paths, which bypasses the device's
> > release callback iio_trig_release(). This could lead to memory leaks
> > and inconsistent device state.

...

> > -free_descs:
> > -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> >  free_trig:
> > -	kfree(trig);
> > +	put_device(&trig->dev);
> 
> Yes, device_initialize() docs do say that we should give the reference instead of
> freeing the device but I'm not see how that helps in here. Maybe initializing the
> device should be done only after all the resources are allocated so the code is a bit
> more clear... But doing it like you're doing just means that we might get into the
> release function with things that might or might not be allocated which is a pattern
> I would prefer to avoid.

The put_device() here is the correct (and must) thing to do independently on
the preferences. The problem is that device_initialise() and followed calls
may do much more than just some initialisation.


-- 
With Best Regards,
Andy Shevchenko



