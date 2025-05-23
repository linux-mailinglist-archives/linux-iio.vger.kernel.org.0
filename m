Return-Path: <linux-iio+bounces-19831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5EAC277C
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C665423FE
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C8296FA7;
	Fri, 23 May 2025 16:21:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760515A85A;
	Fri, 23 May 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017296; cv=none; b=tp3thMAU24XfqnrFFm8qrO9HLtWyfh/Njn71iZINzgYKIpUTTNt/NBkrO4zpwh+NKibpaWk1CjBne0gkQXs2IQibng9beQ8ooBbnucJG0xyA7mFFImRrtJZE2rQ6GoZ6sz2W0rwSP8UEj6kvbRforr3blVogG00U3sGfeZRF70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017296; c=relaxed/simple;
	bh=TrhmAZSZj+zcv4/V5X1Oolly8Kxy3PHsC80uzCkSXQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTK3LzVMojXJlFMd/pXdkvNpY3xJq6zWnzYycqmrsyz9Qf7kyPd8uVWIaTeX1SEEyENHSu39KBHfa9fMlNsRn/MI3bQOsexZRoruZkwy4UwLah9kNBBRbJfZFJWLOyQRklxJTriaY5qkac4o3VPdb8wrZmd7quQbkCWtG9ts+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: BkNkIJPqQgaW1+nWtW+CWw==
X-CSE-MsgGUID: B2MgBHZIT3ucX2f2YL6+PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53740178"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="53740178"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:21:34 -0700
X-CSE-ConnectionGUID: Z3TVpMQGSI2J/s19a4lvjA==
X-CSE-MsgGUID: v0Jvt8P2TU2dB/Vpdp2ROw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="142234960"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:21:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uIV9F-000000006IG-2TSv;
	Fri, 23 May 2025 19:21:29 +0300
Date: Fri, 23 May 2025 19:21:29 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Victor.Duicu@microchip.com
Cc: Marius.Cristea@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, nuno.sa@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Message-ID: <aDCgiQKL3ySfpkZr@smile.fi.intel.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
 <20250415132623.14913-3-victor.duicu@microchip.com>
 <CAHp75VdzVzNV1k8RqG6Rxsg06Oqu_p1o-4QFeT10xBjrFOEZHA@mail.gmail.com>
 <82538eaeb9bfc8dffe0b67d7dd00826b96ed573c.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82538eaeb9bfc8dffe0b67d7dd00826b96ed573c.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 22, 2025 at 09:18:06AM +0000, Victor.Duicu@microchip.com wrote:
> On Tue, 2025-04-15 at 22:05 +0300, Andy Shevchenko wrote:
> > On Tue, Apr 15, 2025 at 4:27 PM <victor.duicu@microchip.com> wrote:

...

> > > +#define MCP9982_CHAN(index, si, __address) ({ \
> > > +       struct iio_chan_spec __chan = { \
> > > +               .type = IIO_TEMP, \
> > > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > > +               .info_mask_shared_by_all_available =
> > > BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > > +               .info_mask_shared_by_all =
> > > BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > > +               .channel = index, \
> > > +               .address = __address, \
> > > +               .scan_index = si, \
> > > +               .scan_type = { \
> > > +                       .sign = 'u', \
> > > +                       .realbits = 8, \
> > > +                       .storagebits = 8, \
> > > +                       .endianness = IIO_CPU \
> > > +               }, \
> > > +               .indexed = 1, \
> > > +       }; \
> > > +       __chan; \
> > 
> > Why in this form and not as a compound literal?
> 
> I can have up to 5 channels, which have very similar specifications.
> I use this define to simplify definition of channels and avoid
> repeating code.
> Is it now preferable to use compound literal?
> I could implement something like this:
> 
> #define put_channel_defaults \
> 	.type = IIO_TEMP \
> ...
> 
> priv->iio_chan[0] = ((struct iio_chan_spec){put_channel_defaults,
> 					   .channel = x,
> ...
> 
> This way when initializing the channels I don't have
> to repeat the common properties.
> Do you find this approach agreeable?

No, just find how the compound literal macros are written in the kernel,
e.g., PINCTRL_PIN_FUNCTION().


-- 
With Best Regards,
Andy Shevchenko



