Return-Path: <linux-iio+bounces-2467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE0851329
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951162844D8
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF73B298;
	Mon, 12 Feb 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHhAUK6Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EB3B787;
	Mon, 12 Feb 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739628; cv=none; b=HrleG/cafeJE/20KjMQ/kX9g8+tKftcZAevZFJ/Nj8mrMmVpOMGFumJd2x4vBVmFN59Xo42tmAYOrKOTTY6qgOhoyfFiA9h8u8ojusb4gChWQ7p4JYW5Npp0B3tg4cB51u2ppAify28O7iQkKmTF4YkD2UB3Upac2gPgu6iHusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739628; c=relaxed/simple;
	bh=Vl7Ew3c67JxRPVMcFO+ikqn6P3qpbw+YgyMBgGuye6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFqDYLaAci6oehiZXAEETLqBG3vbo+jDizQf3fiFmqAoM67H4qKxTNYqXnAhoiI7CgPuNsnKfDJuRyPWmc4QV/E/v+p4/bAldDRcRYjHe6OWzchyN89Z2sYRvfLN2Zz7bAYmhHac4bIISDQc9TLfAtxORbputvb64kHCU8lH9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHhAUK6Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739627; x=1739275627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vl7Ew3c67JxRPVMcFO+ikqn6P3qpbw+YgyMBgGuye6Y=;
  b=jHhAUK6ZfvloK2n77dzSvg2Hm0Q2bnSbWNl7DR/lZeD4BSlUXgdGwcSH
   aHnoiuGfN7iaXaliXuY0sssaX0F1B9CwKuZfMixwImxi2rPM0SxgqpMZ7
   6GySd/wG9rZbw9n3TmsWsF/n24h54tTmIijgvqTuC3D4XY+Vr6B6OEVM+
   oUFZnBU3Ae24MI/ltz4KzZBf+ULdElM0dpJPpJkYzMU9/0B4rkH37JyF8
   QdU1WRqR3HW7Oz/bxaQy4D/YwYEuv07BhJEaSeqLsoVlYPFYcA+CgOd6P
   23jDRlWA3TS6WD23kME05HvApvKb5ZOZUFDx1aSd3O5z7lyclLbkQDzvG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2056807"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2056807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911463951"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911463951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:06:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZV4q-00000003t5k-0Hwc;
	Mon, 12 Feb 2024 14:06:24 +0200
Date: Mon, 12 Feb 2024 14:06:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/14] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <ZcoJv8TgSDITc3M2@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211192540.340682-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 11, 2024 at 07:25:27PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Useful where the fwnode_handle was obtained from a call such as
> fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> and will automatically release the reference on the variable leaving
> scope.

...

>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);

I would add a blank line here, but it's a minor comment anyway.

> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))

-- 
With Best Regards,
Andy Shevchenko



