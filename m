Return-Path: <linux-iio+bounces-9608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC43979EDB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05851C22EC5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7DB208D1;
	Mon, 16 Sep 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSd9Ue99"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAE41C62;
	Mon, 16 Sep 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480839; cv=none; b=l0h0J+oc8ltdSk2DiXOEi238P8iWkSwaDIjogfUf15FGTv44BmkdHdaiWnU1o5BJ5wEGA6EP45pHh9AXj9hQXxzQYnn6w3VNifMSb6E1VIaRx9M7MsfczYQqcKZiefa5PG9CHY5VEbQb6Bxguu40f1gq8kdcL309zKf+BSKddkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480839; c=relaxed/simple;
	bh=zkSAZIyyTSIOeweFiticyRcWayN4rbOIhMx+j9mFudU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2mQleOA24oRI0SKNZCar0L9sk9U/XKSFKDrq9Xeto5vE3mQFCbO56u6GkKVpeU6O/b3xD1mDal0SCUsOrpAvm1FWiHwovyDMAU6lS8578unjjNqQylyBtw4jJl/vvIwb6II03CmNpwAV58k4OOnIfvLl3QzvF18FYO2HEWtGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSd9Ue99; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726480837; x=1758016837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zkSAZIyyTSIOeweFiticyRcWayN4rbOIhMx+j9mFudU=;
  b=VSd9Ue991lfdX17dawoCoB7eMP9gzZAD65zfST0+kdlu0SAcchxdIYbx
   0+jc6hPfEzl+FUkx8+VgT4h0y3Hq1Ii49CBkLYPeMRmBsckKo2aGORS3B
   AY8mdFOYr40CpzXG4ygP25RmWPifVq89IReaYthEnIs7SufQrdSTuwW8q
   qX4ac5gjL/fjM98vVMMYvGI1I2Gl2+u3dGtOIqPWmU/eK8f12uY7bepIa
   qZrZV3P6BUkmlMoRrTspP+/mOg9s6csHQdSUkwMEsihQIc0Amg0+obXjq
   +mMrO+ImLNDvRU5CvEfVWZCBuJ34XztlOhQtb/xu389P6lZPVk/MNFhwO
   w==;
X-CSE-ConnectionGUID: 9LmSh1kOR9GSnjgRYku9/g==
X-CSE-MsgGUID: RiOVv59xQAKDqdDgSu62Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25394429"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25394429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:00:36 -0700
X-CSE-ConnectionGUID: hSnrBmB+TnWxbiGjioST9w==
X-CSE-MsgGUID: hptvynkLTJaLXu7Ol+SmaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68775523"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:00:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8X1-00000009PkY-1Sb1;
	Mon, 16 Sep 2024 13:00:31 +0300
Date: Mon, 16 Sep 2024 13:00:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
Message-ID: <ZugBvySTBehR57mb@smile.fi.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
 <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
 <9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 14, 2024 at 03:45:58PM +0200, Hans de Goede wrote:
> On 9/12/24 3:51 PM, Hans de Goede wrote:
> > On 9/11/24 11:22 PM, Andy Shevchenko wrote:
> On 9/13/24 11:31 AM, Andy Shevchenko wrote:
> > Have you grepped over your collection of real DSDTs?
> 
> Yes I did, but I just double-checked looking for only LTER and there
> are several DSDTs using LTER0303 for an ambient light sensor.
> 
> duckduckgo-ing for LTER0303 finds:
> 
> https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
> 
> which is actually quite an interesting URL to search for ACPI
> HID-s used in any Windows drivers.

Very good finding! Bookmarked to check any other ACPI ID case with that as well.

> Checking for LTER0301:
> 
> https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301
> 
> Shows that that HID is also actually used, so:
> 
> > Thanks, patch looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Correction, at least the LTER0301 ACPI id seems to actually be real:
> 
> https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301
> 
> So NACK for dropping all 3 HIDs.
> 
> It seems to me that the LTER05xx HIDs can be dropped and
> a LTER0303 HID should be added instead of dropping all HIDs.

I'll update the patch with reference to that catalog.

> Note I do not have any hw with a ltr303 light sensor, so
> I cannot test this.

Neither can I. So, let's drop 'LTER05' and add a comment WRT the 0x01.

-- 
With Best Regards,
Andy Shevchenko



