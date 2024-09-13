Return-Path: <linux-iio+bounces-9483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA7977C33
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8594A1F27660
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130701C1AA4;
	Fri, 13 Sep 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Exlarc59"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004D186E2C;
	Fri, 13 Sep 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219940; cv=none; b=MNQYsjH5nylVG6P9arPva/aCVyafk6V1NZCqJmeDAjSW6J3//JZTFw8UlHVnoUzVQ9CPz+GPN2JFYYKV0YoSYvo6i6FE9aGL/GaDwmJiDFy3U+maJnsEHhqgo7oRInyuvbC5FbOY+YFhScF4IzPrUXiI/TUNTfbkOIw1mvhLsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219940; c=relaxed/simple;
	bh=9irAKzGFtUS0xzWAeFO68FCPUTDILQHTPta0d82KoaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKxZmjoe9IvtsF+tokfNRH+jg5j0/Kpnt/hq3RvvIcuNZ27wt9d1Qz3RAovLJ+tkj4aL8+VNX/NBZgV0/TQztkB56MtKeuO4S3C88qNu8xyEWZpK4cnVRJJ3h3a2NBNieeUixwnEPhigfLjYJiR7ea4F9XixxouOZY0HkRl1x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Exlarc59; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726219939; x=1757755939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9irAKzGFtUS0xzWAeFO68FCPUTDILQHTPta0d82KoaU=;
  b=Exlarc595NHbNExeYvb3NlcQIj44gKOd69BdStTkEXl58QXUrSd4vr93
   LlSCfb0KzDRuL3wQVClQiSzjnsH2V5yj0LSgo+mf5wOH3moA4CtkqMhXi
   9w/iMwbtzh5J5zX9DvUIg28ZJgmx8kbI6I5amnkEepdNjGZ12cd5hfwjv
   zZeJ099ah+0LeHehB3/xwrrONrApJRkWR5Oq23GVbjp+q0IVy8zYCe1wX
   VxcFVAD4nyQmKytEy9AB5XSeW2y/U4WiWhzQJQD3BzsCxV+KF6AAbOwjP
   zw7XqUdvXmKO57RQfQlXVBZrK4lO2HtyuC0Vc6f1uwYojKrRsNsJUN648
   Q==;
X-CSE-ConnectionGUID: +a4061cbS4ue9NTCKdg78A==
X-CSE-MsgGUID: Z4UJ8sdlSJeh0U372dYLNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25265211"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25265211"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:32:19 -0700
X-CSE-ConnectionGUID: +Byo6285QdGWZNHF2EuUyQ==
X-CSE-MsgGUID: sy5Gb5NuTRydgBezJA4f2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72099006"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:32:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2f0-00000008FBN-41kh;
	Fri, 13 Sep 2024 12:32:14 +0300
Date: Fri, 13 Sep 2024 12:32:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
Message-ID: <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
 <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 12, 2024 at 03:52:34PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/11/24 11:31 PM, Andy Shevchenko wrote:
> > The commit in question does not proove that ACPI ID exists.
> > Quite likely it was a cargo cult addition while doint that
> > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > 
> > Googling for KMX61021L gives no useful results in regard to DSDT.
> > Moreover, the official vendor ID in the registry for Kionix is KIOX.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, patch looks good to me:

Same Q here.

>  Reviewed-by: Hans de Goede <hdegoede@redhat.com>

And thank you for the reviews!

-- 
With Best Regards,
Andy Shevchenko



