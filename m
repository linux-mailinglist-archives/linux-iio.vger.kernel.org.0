Return-Path: <linux-iio+bounces-11435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C99B2AE4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046ED1F221E0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165951922E6;
	Mon, 28 Oct 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKZos0zv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D818D620;
	Mon, 28 Oct 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106160; cv=none; b=f+okKcfGTcQhSOzJbrFrDWk4gGhWjEH+PO4/ikCwCZERK5VDst4H7SRjHBUmby4FHJOyc9su3+J97mAI9uM+KJhNRkEDd5NbVxOdFkyNiIAeOOftITRjOfM1S9C04zFNz87Qk2DBSTpavefgMwn+uLSR6rVqc/sg04KB6dgkUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106160; c=relaxed/simple;
	bh=T3Dt7pOFiDuMndxZ8ubEMPBK3BxP/+sNB1QkeoHd8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kox6BSaXpBV84VLlb9+7Rm7rNwRlq6MjHKNftKQbjxPUoBXFgC7QodP3lI0s1rMRgmkDzJTcdsUSH8WzounNENh+xDVspAQD6nu0hHyO2XCZRSXIYtHZw1SSNQCg9EvolXiaxIjil8ozUfMtxSrMrMjw2nZ7djC6qjRGDekjDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKZos0zv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730106159; x=1761642159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3Dt7pOFiDuMndxZ8ubEMPBK3BxP/+sNB1QkeoHd8/s=;
  b=WKZos0zvZ8dGHzgIWZv/7nNJNJEJSJ0LZlh0HMMTCgTdocGjLd/W5Ay1
   3wp5/0YZw74/V4xNyxzp4RuRtWjgUZcKtPHImgjip7MZHk13Tz9vb9/r9
   EKA/p/3f2pQuO4GPCY86kqx9uyXzDWbzE8DOOLwRedjfRxCcTkO/2EQJN
   vF7KSZ6Cy2uTB/PyF34YUnXlgjKEzFuwBBgcDL77YvAXTM9W5kYwFFg1V
   1TQUfSUUdoJdgJQXGsqvdoaC14JePor3l7dgN154oCRAbj46lRgm3ytlj
   nwmSoLZPHm+oS8+LXYfNUN7W3/5j0l0YvrCJlPISh+jDSqQzX+YpbBECz
   g==;
X-CSE-ConnectionGUID: j6cctwVjTheU6O+qo8bVwQ==
X-CSE-MsgGUID: LOCYNizgSGy1W5HozvyCpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33604992"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="33604992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:02:38 -0700
X-CSE-ConnectionGUID: nbwpJFI5Qka+fO4C+JU3kg==
X-CSE-MsgGUID: sHvw4d4uRV+0kJKI+OFFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82371821"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:02:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Ldw-00000007syY-1GIO;
	Mon, 28 Oct 2024 11:02:32 +0200
Date: Mon, 28 Oct 2024 11:02:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rayyan Ansari <rayyan@ansari.sh>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 07/24] iio: accel: kxcjk-1013: Revert "Add support for
 KX022-1020"
Message-ID: <Zx9TKIVA0NlV53Dr@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
 <20241026121619.668d07d7@jic23-huawei>
 <fc87c8d8-db22-41f8-9594-4687f89881f9@ansari.sh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc87c8d8-db22-41f8-9594-4687f89881f9@ansari.sh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 03:58:52PM +0100, Rayyan Ansari wrote:
> On 26/10/2024 12:16, Jonathan Cameron wrote:
> > On Thu, 24 Oct 2024 22:04:56 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The mentioned change effectively broke the ODR startup timeouts
> > > settungs for KX023-1025 case. Let's revert it for now and see
> > > how we can handle it with the better approach after switching
> > > the driver to use data structure instead of enum.
> > > 
> > > This reverts commit d5cbe1502043124ff8af8136b80f93758c4a61e0.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > I'll take this the slow way as I don't think there is time to chase the revert
> > through the various trees and still get the dependent patches in.
> > Hopefully we will fairly quickly get the missing table data and can
> > bring this back again.
> > 
> > For now, applied to the togreg branch of iio.git.
> > I have tagged it as a fix though. and +CC Rayyan
> > (I'm guessing maybe that will bounce as you rarely miss people you should
> > CC!)
> Hi,
> Sorry for not replying earlier, I've just caught up with the discussion.
> 
> I don't fully understand why this is breaking KX023-1025, but you know more
> than I do here.
> Does this not mean that the use of KX022-1020 in the 3 devices (Lumia 640,
> 640 XL, 735) using this from qcom-msm8226-microsoft-common.dtsi will now be
> broken?

Jonathan already answered to the question, so, please, rework the patch and
submit it again.

-- 
With Best Regards,
Andy Shevchenko



