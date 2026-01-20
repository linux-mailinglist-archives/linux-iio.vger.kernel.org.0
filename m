Return-Path: <linux-iio+bounces-28041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA10D3C0FA
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFE3F44065F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B913A63FF;
	Tue, 20 Jan 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNeZP5ef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC647334C02
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895578; cv=none; b=RUiieXUbT1eJfqeJ2mtOAypK9UPATvxAaoWLQ7ssNtvTreo28JDXLdkhJm3XnDOtp+1MHxvomy9vbOlrDcr/ReVNxyPPwbpxSMGmk1W/7XTAQm5HAbzew7XAX2AvUQ9VBdwBQOn5r9n0ujnRhWdoBabKK/1BWjZHW1lltwqfp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895578; c=relaxed/simple;
	bh=77NJxe7TXCXUjwd9in+T+enlTuHFbPEgxRSEkQEoCcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT5ZsR+xQio2YpC6Ej99dnENEWsGjbvOS9zj4lYx/okZN+lQrLkS0L6N5+e8ASa9Au0Dt3vWvvJJ4rJotlSBowDHSAmj73iM3SOXWP4SSTZNlRijwQrEb0BJe5w78nX4IjmmjlekSBzKkeq3DPzKj6io1tsn5Znrx0Mc2Hx181M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNeZP5ef; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895577; x=1800431577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77NJxe7TXCXUjwd9in+T+enlTuHFbPEgxRSEkQEoCcY=;
  b=LNeZP5efwt/VNsCYDerKFB+PIcDCGk8mVo4amFJSOj7R+FWKMH12h5UL
   StcrzKLENgnJo3qzV7OVMHFf9bZHq8fwdVdCyYpiLGf6GisdRt7Cfsw7y
   Q9jSztfkiRpKygu9PTB+PqPmdnpH++FEZ+DPZmgKGctGTFHjxjdXOchcY
   qM2mCoFd0KBgiK9vqZATVQWCXKR6LpztYFE2WG1FfAQjUnilCzAP8tiMq
   6RhnVXvgMwXYVtRgmU1ICloqMOlX+Iu2PFbzOlq+1xv6UKpZzV+lyQ92C
   J2M7/RvpUF5Y8p1REBXQbTAGW0vdaQPq9TqRlzqASeAQM2G0sG062JeaL
   g==;
X-CSE-ConnectionGUID: gK6aS+0TRsuDDO0CzpptAA==
X-CSE-MsgGUID: 0npZ3Uy1QIS5qBxGBOrdwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81535572"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81535572"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:52:56 -0800
X-CSE-ConnectionGUID: Z24+q77fQgqF5tG/dp1Jug==
X-CSE-MsgGUID: uZKPvxXAQdqKYKb9kehiJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205849531"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:52:53 -0800
Date: Tue, 20 Jan 2026 09:52:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/11] iio: adc: ltc2309: Improve include relevance
Message-ID: <aW80U7kH1y9EdnfM@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
 <20260119212110.726941-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119212110.726941-3-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:21:01PM +0000, Jonathan Cameron wrote:

> 
> Based on output of iwyu, drop kernel.h in favor of more specific includes
> + add some others that are only indirectly included from other headers.
> 
> Justification for additions:
>   #include <asm/byteorder.h>         // for be16_to_cpu
>   #include <linux/array_size.h>      // for ARRAY_SIZE
>   #include <linux/bits.h>            // for BIT, GENMASK
>   #include <linux/dev_printk.h>      // for dev_err, dev_err_probe
>   #include <linux/err.h>             // for ERR_PTR, EINVAL, ENODEV, ENOMEM
>   #include <linux/mod_devicetable.h> // for i2c_device_id, of_device_id
>   #include <linux/types.h>           // for __be16, u8

Similar comments and one Q here. Should we establish IIO header grouping in all
(touched) drivers? If so, move it outside of linux/*.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Liam Beguin <liambeguin@gmail.com>
> ---

-- 
With Best Regards,
Andy Shevchenko



