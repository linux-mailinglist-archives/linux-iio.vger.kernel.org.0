Return-Path: <linux-iio+bounces-11683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52F59B7648
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2238A1C21750
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134B14884D;
	Thu, 31 Oct 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eegy0m2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B2153BE8
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362870; cv=none; b=W0DWOkZN23Z+NCV/CiK7Q4pYa77FvZwWyf8AFmtpbMubRwldeOfMStSjFmyogE4hYri/bEKKeJ5lg9u3TurHwAqoPvlrdI//raXsPhmXNfLEv1fUVOf/gQmim3qAXAXOUog3r1FFtzY7DnFWu1unTfLwmJWaT/WzRbNeZMcLaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362870; c=relaxed/simple;
	bh=4HT1abZUuweuwCeojNvikVLPFVje8KzwJz5mQIJsIjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+f+9gwFG6/WFX9/1uh/69P5b7vd3lV0hn8SCdanM6a1b8FnF4GojPr4Y5Rs87tZh67HL3lYUA0VjP3GnPgPKUfEsInRvXPjeIZuJElqsMmiAl/k1zqn28sEJkqwBjezUWvw8VWpgHno1uk9x6Jh0PbRaz28WxesdbQmG7n12Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eegy0m2J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730362869; x=1761898869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4HT1abZUuweuwCeojNvikVLPFVje8KzwJz5mQIJsIjQ=;
  b=Eegy0m2JvN3x6Q1BxBLxWRPHFpuF1w1r3dY5ED0ozp+Sp0XFDs9vg/LO
   8Cmr2sYZMaGEkGLa2oySPGKC+P39C0An9jFZ85iZGbXRzSnLu/3xSSrvZ
   vCLixQPTcPfezcokpiBAGIJ7yokd+UauF0I7qFUrytFO8mjuKym70M0DX
   EF1bvU3n2b4gndMHHcQwpoa/+fFAmy2IFycl3131PZNADQrOwuFwSuLRz
   DQXySGht1IJyg1IBWsNoLUgTw0bS67K2BPnPj1b4Ezjs1lbulSz5cK1z3
   J17OBNCO0Oqa9CwrhQSKl+FxTrJR/g5yXLYjSe9Kj6wNpSXmnUfFyCeXg
   g==;
X-CSE-ConnectionGUID: z7kf/cjnSTq6t7uk/lIaIA==
X-CSE-MsgGUID: gqiUVI0RRW+tW9pksG0mdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="33877813"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="33877813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:21:08 -0700
X-CSE-ConnectionGUID: E/l3JaMlQz+4ted0ezmK/w==
X-CSE-MsgGUID: hXPcv4uwQ6eO7GRdy+zTgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82720326"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:21:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6QQT-00000009Zha-0wm2;
	Thu, 31 Oct 2024 10:21:05 +0200
Date: Thu, 31 Oct 2024 10:21:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <ZyM98BnZ-0yQFAHu@smile.fi.intel.com>
References: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
 <ZyJHpaWms8Fe2x94@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJHpaWms8Fe2x94@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 04:50:14PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 30, 2024 at 12:53:57PM +0300, Dan Carpenter wrote:
> > Hello Andy Shevchenko,
> > 
> > Commit 14686836fb69 ("iio: light: isl29018: Replace a variant of
> > iio_get_acpi_device_name_and_data()") from Oct 24, 2024 (linux-next),
> > leads to the following Smatch static checker warning:
> > 
> >     drivers/iio/light/isl29018.c:724 isl29018_probe() error: uninitialized symbol 'ddata'.
> >     drivers/iio/light/ltr501.c:1514 ltr501_probe() error: uninitialized symbol 'ddata'.
> > 
> > drivers/iio/light/isl29018.c
> >     701 static int isl29018_probe(struct i2c_client *client)
> >     702 {
> >     703         const struct i2c_device_id *id = i2c_client_get_device_id(client);
> >     704         struct isl29018_chip *chip;
> >     705         struct iio_dev *indio_dev;
> >     706         const void *ddata;
> >     707         const char *name;
> >     708         int dev_id;
> >     709         int err;
> >     710 
> >     711         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> >     712         if (!indio_dev)
> >     713                 return -ENOMEM;
> >     714 
> >     715         chip = iio_priv(indio_dev);
> >     716 
> >     717         i2c_set_clientdata(client, indio_dev);
> >     718 
> >     719         if (id) {
> >     720                 name = id->name;
> >     721                 dev_id = id->driver_data;
> >     722         } else {
> >     723                 name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
> > --> 724                 dev_id = (intptr_t)ddata;
> > 
> > How do we know that iio_get_acpi_device_name_and_data() will succeed?
> 
> Ideally we need to file &ddata with NULL in such case, but it will be
> equal to 0, so it only works with the chip_info in place.
> 
> Let me look into this once more, thanks for the good catch!

I have sent a patch series to address that (you are in Cc there), does it help?

> >     725         }
> >     726 
> >     727         mutex_init(&chip->lock);
> >     728 
> >     729         chip->type = dev_id;

-- 
With Best Regards,
Andy Shevchenko



