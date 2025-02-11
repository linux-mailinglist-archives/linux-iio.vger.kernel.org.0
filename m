Return-Path: <linux-iio+bounces-15340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E22A30C37
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 13:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5543B3A8930
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DD2206A4;
	Tue, 11 Feb 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsCcIb8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BA21480A;
	Tue, 11 Feb 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278663; cv=none; b=MmMNTa8n9TRu1uhS6jXtvcXfjFNyQWaS/jRNbzy8JAC87q2mEhTnO+Vz+X5455qo/9q4MxqNjNwhzHUH9sYHKEg1AYMbQlV1UvKpbZtiPpbPfoQnNJiHnU1ykQcvF8IEu+3p8jSaVPf0WWTJtKTEBKd/3YjZHFfJsZLnyuASiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278663; c=relaxed/simple;
	bh=X4fB1Ellq5GKEOukrFF7YPbWRktsIcuO66L67hsODoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwB77/g9ezeZFD4mgOasRYCzxxQI5bJiGsgh6sVDA/DY1SWq/ALKpjAWL/LuI9G/p2gR7EOFYVb7iNTFv0gq8v0A599qlINJv5u4T+KP5SJhDwWWxlryQHDwQcMgDcaJVpED4ncoJOBLFOxTwZVqfYKNzwVcfYinKPfVAbUBIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsCcIb8W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739278662; x=1770814662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4fB1Ellq5GKEOukrFF7YPbWRktsIcuO66L67hsODoo=;
  b=SsCcIb8WojibYanEr7gMS9H9D8VxzJI+wS2A0mYVfLhUtX3bqcqrsVHG
   3plM9BaGhcY9JwV/F2vTlL9gmlF9q+2o4J/5f7QYtX+xnfLKvjFb+hNQw
   l9eTsFHYYMpXIcObw6n7ZoahVJktvxtqME/M7q/QgXDC84/uHU6LbKW6L
   l/bBsLr46Xs8CC7t4x6q6NVkrj/jP0rN+7zWuOo+n+SLRCWC+B/gM1N5V
   G2rkJRyN+eDFL/HPLO1H5Z4bnOuZ0HEOHHAy/4cVMBu4EL3LcANdTdeKU
   Je3G/B0p33CCBpWqs51jkmGS5Pn+ZBZMgtqOWUWw/6co/03ZnF6Mkf62/
   A==;
X-CSE-ConnectionGUID: 4SQgvuPPTiOUbzfuiRBurQ==
X-CSE-MsgGUID: MFz5LGCqSqGgEQmamEF0wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40019705"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="40019705"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:57:41 -0800
X-CSE-ConnectionGUID: t0LgvSdkSSy5isLBEeXO8A==
X-CSE-MsgGUID: B0jUdtFpT+aBUeHNlcg5UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="113023165"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:57:36 -0800
Date: Tue, 11 Feb 2025 14:57:33 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6tJPc-coP1Iw3qt@black.fi.intel.com>
References: <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
 <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
 <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
 <Z6s2cGMM9R6SZ9Le@smile.fi.intel.com>
 <49396042-31f0-4d8e-aa54-d89093ab5709@app.fastmail.com>
 <Z6s-S67MdpVrXRji@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6s-S67MdpVrXRji@smile.fi.intel.com>

On Tue, Feb 11, 2025 at 02:10:51PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 12:56:11PM +0100, Arnd Bergmann wrote:
> > On Tue, Feb 11, 2025, at 12:37, Andy Shevchenko wrote:
> > >
> > > The problem this series solves at the beginning is that not all the consumers
> > > of device.h needs it, in many cases the device/devres.h (or subset of
> > > device/*.h) is enough to include. While solving this, it appears that
> > > the current code uses ERR_PTR() instead of IOMEM_ERR_PTR() in devm_*io*() APIs
> > > and kernel test robot found this and complained about. While solving
> > > this new issue, LKP found another issue that is circular dependency.
> > > But the original code only wants to have an access to IOMEM_ERR_PTR() which
> > > is in io.h and can be moved to err.h AFAICS. Does this sound reasonable?
> > 
> > Yes, that sounds fine to me. I agree that not including linux/io.h
> > from device/devres.h is a good idea, same as no longer including
> > linux/device.h from asm/io.h. Moving IOMEM_ERR_PTR() as you
> > describe is the right idea.
> 
> Thank you for confirming the idea. Raag, please follow as suggested:
> 
> Move IOMEM_ERR_PTR() to err.h (perhaps in a separate patch),
> and drop io.h from devres.h as it will be not needed.

Sure, and perhaps drop a few patches to reduce spam while we sort this out.

Raag

