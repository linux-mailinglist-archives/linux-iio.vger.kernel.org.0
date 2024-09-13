Return-Path: <linux-iio+bounces-9482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB3977C31
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA67B1C245C2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4551BF7FE;
	Fri, 13 Sep 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbG2uPdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CED186E2C;
	Fri, 13 Sep 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219898; cv=none; b=YICBuq2NXAFsHVRKAIbExKJaLdyOtXh4OtzuswI8xh3bO2CFaZQaJktLJrUUqI+CQGZAaFufDCTN9e///WmjtE6ovZCnBG2zY8ofv+fvAtehtaH5MtpS2KghXu0MhQffysulZiHBuaiElXMLILYbKsgNimBQm2yzPay+MQhHsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219898; c=relaxed/simple;
	bh=ekuvhHPYKge6NJXqTlLTzq+obp+wVk2Rpy5JOBXtHrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBAFBSsrG4g0HBZF/1mASgMg7qG+SuKKH4G/pqcls/Ig6hUUkicoSZjB4as97mQS+SYIxKGHZyzxcR8EuWEvckt0m3+eQttvYiB3ojn7c/eDbBWzSEOba97EzjiLuisldoghKb9lkmJs6OwM3wfYgQ4O7/Ta8OiybA55+gAm5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbG2uPdD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726219897; x=1757755897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ekuvhHPYKge6NJXqTlLTzq+obp+wVk2Rpy5JOBXtHrw=;
  b=FbG2uPdDONMKeV2L56ZvZzBdRFxxsYwZPY9wnXPGAXQ9dzhIi7nU1g+u
   UvoiG/1ZS4HL6AmxaJ0MS1sC5DpoWMLq+iVYo8I9MlQRBe3mhuxhA9IT/
   a1+jS/ZPHWLKPR5ebW90/yqrY2dV1KIakz7oJfXSMPfBqdIBqkPQWO9mc
   YKEN8PtIVyeaR2g1xhpRaF5oPFpFZ+4nK6ocBKYv3CBKAhh1+xahfEHZ/
   SNLpTUm+61MkfNcPCx3habbvnz0aWkQsqjIyJQgMhUAzjj1XymJZ7LKMg
   Wu9c5RAMo1vMH+slRnVnsR220fsgMc8z+KpKttPZeoh6AJrrVudsfxoad
   g==;
X-CSE-ConnectionGUID: h7bmUtHjQ52xE03+xCoUHQ==
X-CSE-MsgGUID: iTW0e8O1TTOaiMgR7n+MkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="47628280"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="47628280"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:31:36 -0700
X-CSE-ConnectionGUID: zDnRAEnSS4OgiTvHoCvpOQ==
X-CSE-MsgGUID: IE1cu8MSSOy0Xr0N/6OfKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67616819"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:31:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2eJ-00000008FAi-2Iib;
	Fri, 13 Sep 2024 12:31:31 +0300
Date: Fri, 13 Sep 2024 12:31:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
Message-ID: <ZuQGcyrTFek1yExt@smile.fi.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
 <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 12, 2024 at 03:51:09PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/11/24 11:22 PM, Andy Shevchenko wrote:
> > The commit in question does not proove that ACPI ID exists.
> > Quite likely it was a cargo cult addition while doint that
> > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > 
> > Googling for LTERxxxx gives no useful results in regard to DSDT.
> > Moreover, there is no "LTER" official vendor ID in the registry.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, patch looks good to me:

Have you grepped over your collection of real DSDTs?

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



