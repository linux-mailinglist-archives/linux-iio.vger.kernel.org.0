Return-Path: <linux-iio+bounces-1780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17C8355A6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB2281FE2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9836B02;
	Sun, 21 Jan 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuBTEzBx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9236AF2;
	Sun, 21 Jan 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840141; cv=none; b=QuqH/gGRaKnGIrOk7EyfXSgKUWd/p/CEZ6DMUkuKvPBzg+/y5j2drjAUoAHqd3zzKK9Ae+kwyVqV1tWgbTySxDwA5UB+buByvwDcMd04h0uXlqmj/8a3Q59xfe/bB744lGIj2WDbJtbU13bMwlPCl9dusGTN2mbLCQcuBkYx7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840141; c=relaxed/simple;
	bh=Y6ol/RDZQ2ez7fxRFYvFa1Ns5wBcgPZcyyD8Gbgkfo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRyoZs8lf7pveVgo+iymDRGcvd+zSQSN4InMUzuMGgoYTDHVIBqBLsplULzS5rdrSKRTnPJQ58FJl0B+YdTQI7SfK9LVjGP1VluNxJzGR8m/YuyAXV6neB72eWQOjjMsQQc/pFc34HQp1sQTNPVKwXnKs8QnzIC2MPhOx2ixSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuBTEzBx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705840140; x=1737376140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6ol/RDZQ2ez7fxRFYvFa1Ns5wBcgPZcyyD8Gbgkfo0=;
  b=BuBTEzBxA6YzjUFGpG8WjOg7P6aTgt6L4pJFeLNkGUlJ62XXNqfYYWMH
   SJ8RSFMiwtEQ9iRQz0pIuhQZyse/cU/8IJ7Ruj+auXSS9BLqnjAloEtfQ
   bIMt3QXF7eBa+idh1KJcYFGN39LGGqx+ZqNlxle2kEsJ4oWI4nr3dfVJD
   XIRORjDcUhhdyEsr4L0xpaukvv5W4E8B58W7jbXzqhD2CAfePrgQIAGnp
   +SmarRtNvt0KpQDlnBzBrA/NpTCXqqTFqN3hoiXBoHi45QFUCfgeqVmoD
   J/V2Oka5/OzYc5kV0lDMtlvYwLLISEOOCs27/XUTcgae6w5B4qdYuldh6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="7785771"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="7785771"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="958501216"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="958501216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:28:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRWwS-0000000FcGE-0aPg;
	Sun, 21 Jan 2024 14:28:48 +0200
Date: Sun, 21 Jan 2024 14:28:47 +0200
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
Subject: Re: [PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <Za0N_5Hp2s-uwOoM@smile.fi.intel.com>
References: <20240114172009.179893-1-jic23@kernel.org>
 <20240114172009.179893-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114172009.179893-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 14, 2024 at 05:19:57PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This allows the following
> 
> struct fwnode_handle *child __free(kfree) = NULL;
> 
> device_for_each_child_node(dev, child) {
> 	if (false)
> 		return -EINVAL;
> }
> 
> without the fwnode_handle_put() call which tends to complicate early
> exits from such loops and lead to resource leak bugs.
> 
> Can also be used where the fwnode_handle was obtained from a call
> such as fwnode_find_reference() as it will safely do nothing if
> IS_ERR() is true.

...

>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);

I would add a blank line here

> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);

With the above,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



