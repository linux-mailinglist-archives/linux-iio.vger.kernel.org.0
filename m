Return-Path: <linux-iio+bounces-11057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E210C9ADE6E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C51F22956
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B91AF0BB;
	Thu, 24 Oct 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+te8pk3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B831AF0A7;
	Thu, 24 Oct 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757171; cv=none; b=XX02jTj/B6zamz9AZh9R8Et9rfGGBNfW+Vaj2Bxq8avM/Y1jcKUoTfarIpNiCWQrlvkx87Yd6I0+Y/xttM2VsQeZF2ASTQut3NkRImxMLeQBJJbR+BHZoYu0SLlPB8sE6vlbBuDIRM9KYr/nTWUIbsI9a7aN1XLUoEbr3f3/q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757171; c=relaxed/simple;
	bh=ADBHczovnvH3IZCxUZr2i83TDFOat0njs/s/hAQ/iks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSGgTHdryMYvOXSZ4PXZrkdwtVStlATXEbPkQ/UDWeQbqt6VtcfTIY1Ni4EMo5aDXmJejt64CnpCGhPNLomEf3K9qXV0ptHVNlMe1/rJecYQhkMOMYHYByAUiirXkCYUft17fIgoW7hC7y6dvGacLKOVOeY60Y1pOkpOW994810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+te8pk3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757170; x=1761293170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ADBHczovnvH3IZCxUZr2i83TDFOat0njs/s/hAQ/iks=;
  b=C+te8pk3Pf+Gwuy7wRgj5B++tg7Kc23QtENftycXRoPKqPQGwbGSd+ss
   nU3BMdaRDr7f2NmWAqG0k8hn9NhKYxrHnRkV5YduBl9aAkN9itebklz82
   OfAqWQrIeb9t6SxoocQcNlGMqyVQJL8iIPxkNywywmBL8tVIjGRizEVoY
   bzvBzew1n6zPQDaghzR3VcIeh5a9VSMsGE0xVtciXeqF+ZFXzk35QYjo4
   MU9Eyn8Jv2bJdJBsfq6Jf4ntRYfIC8GITKlip6dPF9pqtJeeGQ5x3JtMX
   35yTJFOnp8R+JsCVD7pEhuqXJBbYHgC4d1KCKvFmkjfVDkrXu7lrIxDJq
   g==;
X-CSE-ConnectionGUID: vbQbmgeeQkuL/nBhXN5MfQ==
X-CSE-MsgGUID: yA/4BDkeTBSZdOmfA/jD5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29539789"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29539789"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:06:09 -0700
X-CSE-ConnectionGUID: xeagRbDBSu6y7CKTuJjBDQ==
X-CSE-MsgGUID: +3ctW8tXQiCslZwORHIYuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80516097"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:06:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3sr5-00000006VGN-1Itk;
	Thu, 24 Oct 2024 11:06:03 +0300
Date: Thu, 24 Oct 2024 11:06:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 00/13] iio: Clean up acpi_match_device() use cases
Message-ID: <Zxn_61abUi2cAiQk@smile.fi.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
 <20241024085231.132a8786@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024085231.132a8786@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 08:52:31AM +0100, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 18:17:23 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > There are current uses of acpi_match_device():
> > - as strange way of checking if the device was enumerated via ACPI
> > - as a way to get IIO device name as ACPI device instance name
> 
> Quick note on this one. That's an ABI bug that we are stuck with because
> we missed it in review a long time back and names aren't critical enough
> to justify forcing a fix through.
> 
> I don't have a particular problem with a function to wrap that up,
> but thought I'd just make it clear in this thread that no new
> driver should ever do this!

That's a good addition!

Let me cook a v2 where I add this to the kernel doc and actually I have to
update the SoB chain in one patch.

-- 
With Best Regards,
Andy Shevchenko



