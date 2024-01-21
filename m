Return-Path: <linux-iio+bounces-1782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BA8355E3
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 13:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153D91C21C4F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B7374C9;
	Sun, 21 Jan 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOkdsABu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6A364DE;
	Sun, 21 Jan 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841821; cv=none; b=GPrq/KFJbFbbdMNG8TYcexfDpw4cLn2Nih4hKqbm1b4ppjwLAXj3uh1EmPM61s9dv50ObfroPGv1zG43AGl4yUOXPmi9xBpLnmi4GuKiwdVhBuwsjoQOe/RgJVg5NE7jRpP4tODFCeMXmXLeeZu8+s+aedD43OLHMaxhJUpmPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841821; c=relaxed/simple;
	bh=6eY2EsvgLtd1tdx27pT2jiesQjvpacfStJLRMuLR5HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbI2R762K1RUJxnoYElRP+FWtTbAPvEi6ph7jIaRWI9APnxYTBnDdpm/zz/yrH0/ac2CjDrU1yRIUxt0mVLZSZ5IwwrIe/ZppPk52kEmKt4J86HbtOag/lzvwMCV4m9UaqxLGYpzubDka5ZWrZ4jew/xuNtQ7BeQ721Jlhgoxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOkdsABu; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705841819; x=1737377819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6eY2EsvgLtd1tdx27pT2jiesQjvpacfStJLRMuLR5HE=;
  b=gOkdsABujlYpPKXOsyMhkdgfyPtnEwyVeRfaflS52qbKavpD8iVKljO7
   iqKuitkzX4ulMrsaSnjX4S+/ZOSDCeRBYiEWXUJCkB6XwVv3vCOqJamZj
   kvwHg0uvL79KSdq7idHCATzrMCR/RrovZcOaWiXkvvVcZoocAg5twjwPW
   usgzMH7RxJMw7QjzjbJ30niSzHqfapSBMJ93ARvtQ2Km134XcwUJVLnr6
   gPekFGYZnnqtx89co3EK+LOzg7JP7xY3U8Dk10bKNNgFtqTT2AXKp55oj
   qfuNKXOhT8DbBT94M3rLbuBPI1PLPBoGX/OrHNCkqviaxAx3mvuV4HzCJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="399901697"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="399901697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="904591545"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="904591545"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRWvW-0000000FcFt-2GTK;
	Sun, 21 Jan 2024 14:27:50 +0200
Date: Sun, 21 Jan 2024 14:27:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/13] device property / IIO: Use cleanup.h magic for
 fwnode_handle_put() handling.
Message-ID: <Za0NxrgBb0ve233b@smile.fi.intel.com>
References: <20240114172009.179893-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 14, 2024 at 05:19:56PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Chances since RFC.
> - Add if (!IS_ERR_OR_NULL(_T)) check as suggested by Andy Shevchenko.
>   This may allow the compiler to optimize cases where it can tell that
>   this check will fail rather than calling into fwnode_handle_put().

FWIW, this nuance is mentioned in [1] as:

  "Within the macro, this declaration is creating a new function called
  __free_kfree() that makes a call to kfree() if the passed-in pointer is not
  NULL. Nobody will ever call that function directly, but the declaration makes
  it possible to write code like: ..."

Not so explicit, but still...

[1]: https://lwn.net/Articles/934679/

-- 
With Best Regards,
Andy Shevchenko



