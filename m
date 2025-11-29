Return-Path: <linux-iio+bounces-26562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA3C93F78
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0AE94E2B68
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706230FF29;
	Sat, 29 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+Dug8zT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958226F299;
	Sat, 29 Nov 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764426226; cv=none; b=c2RorHvQo7T3AYgVEimQYCjFQagYNXzTAhzMM2v3nGmi2AIIFxNHlR3EIVwVic76a2NYTsO1zbjPqD2SJZfCyQVZc/6AXrYPnoExLD96Ulw/g4Bdw0Sr0K+EqiS+kMdt7MRV4x5FI6P6BboRAQhg9Oe6Q1YQnynFJHub+vPReMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764426226; c=relaxed/simple;
	bh=B4czCDpM9F3GFULphnSrx1V2m/jmkkrTK0tJU9Z21qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVCXU9AP7Xt+SHjMsq2wKIG8qqLA+APEDdf4rC8vt8jj4IiucFAYN5ZgAQL7sFklik0yqlKHnRznRAyzCiac65UL4gTwKLJ5D7K8VXN0KNZ0vwCWEfrzzNh2bUm1pRNDrXYt/EoCK9djbz4SPsnq2yvwnb60QcLk/WbL9iLWfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+Dug8zT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764426223; x=1795962223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4czCDpM9F3GFULphnSrx1V2m/jmkkrTK0tJU9Z21qE=;
  b=I+Dug8zT2tWNKJxmCTrxB3R969Ax6PLiBg6bFhmFgXG2HQlkyaoRlyIU
   T83BjMghmaG9iVnBJTtwQcDxoHWD0PquRim3xuZmornw9qqZubHJ92nx+
   f0fl9nv803b1i0mhu/L9B0yV2sb/mMxtWhhJyxGty0f0pM0ROJG8LpwXt
   ECMlzh4O/NPcsQyj19JoU9roXyJ199xK1vDWSKqaE4XB2Lt97Q2rfV9p4
   1jiP6EaLFXFOK7NNARaI39NwCQyyCvfv2RdjJMsFYWMgF6D6mLdho/M9+
   QM63UjhGEcfqqHz2ndw/Zzw43qPvIXeLfsk6KVVluwRPUKn69j5t+irbD
   A==;
X-CSE-ConnectionGUID: 0A20LIXqQGG7khmGVznV1Q==
X-CSE-MsgGUID: w+BJuLeRRCWagVi6vW16ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="77106704"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="77106704"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 06:23:43 -0800
X-CSE-ConnectionGUID: TLQHIr30Qgq2G4QM4hUeTg==
X-CSE-MsgGUID: aYVQc0LSQLSTbwChoAAm2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="230949871"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 06:23:39 -0800
Date: Sat, 29 Nov 2025 16:23:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aSsB6JmmSdMT23YM@smile.fi.intel.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSsBdJZDWcadxEHC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 04:21:46PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 28, 2025 at 10:47:13PM -0500, Kurt Borja wrote:

...

> > +/**
> > + * ADS1018_FSR_TO_SCALE - Converts FSR into scale
> > + * @_fsr: Full-scale range in millivolts
> > + * @_res: ADC resolution
> 
> Add here something like this:
> 
> *
> * The macro is crafted to avoid potential overflows on 32-bit machines.
> * This imposes restrictions to the possible values for @_fsr (less
> * than 274878), and @_res (great or equal to 6 bits).

 * than 274878), and @_res (great than or equal to 6 bits).

(I missed "than")

> *
> 
> > + * Return: Scale in IIO_VAL_INT_PLUS_NANO format
> > + */
> > +#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
> > +	{ 0, ((_fsr) * (MICRO >> 6)) / BIT((_res) - 6) }

-- 
With Best Regards,
Andy Shevchenko



