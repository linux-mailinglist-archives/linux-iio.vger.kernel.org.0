Return-Path: <linux-iio+bounces-1439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87F882600E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068951C218E6
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264E79FB;
	Sat,  6 Jan 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgnaQ/pW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7079E2;
	Sat,  6 Jan 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704554224; x=1736090224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WV9Md1sc6jmvJkWb3qwI49IMLJFPQvQcYg3O0AoBWkQ=;
  b=LgnaQ/pW+8pN+KdjzG5jGRnwacUoEZ4gTkxVBrH9oO4p2wC3c4wZ5ZgZ
   53UgL91CwM9NgOz8H1LoXoQOvh4SkvgHs+PBL/HubnEc3ajZNiAjlLw/l
   /Ic9Jj2eqnaLtmG9vlomftjYk725tprPl1nLtvQ0g74Vb4L7HqUP0UzyH
   fXL+rW0eZ6diipJPdvlP6mzUu5+C0eOoo3ZUOFoUAXZZagGGUXYPhsf5v
   Q5GkEsaFiaHXkaa+F4iLkn9MhEXLT4DSCY7rRJIIziIEH5LiRvd39KvI5
   TTMAKxE51VZhMvG+Nc91rXu8A88AbetMnfBL9LO3Qtu5bVRUf+dNNHaey
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4430682"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4430682"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1028017042"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1028017042"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:16:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8Pt-0000000BwFw-2Y5T;
	Sat, 06 Jan 2024 17:16:53 +0200
Date: Sat, 6 Jan 2024 17:16:53 +0200
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
Subject: Re: [RFC PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <ZZlu5fTW27Tx3drB@smile.fi.intel.com>
References: <20240101172611.694830-1-jic23@kernel.org>
 <20240101172611.694830-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101172611.694830-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 01, 2024 at 05:25:59PM +0000, Jonathan Cameron wrote:
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
> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))

In GPIO we have something similar and PeterZ explained there why if (_T) is
important, hence this should be

DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (_T) fwnode_handle_put(_T))

or even

DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))

as we accept in many calls an error pointer as unset / undefined firmware node
handle.


-- 
With Best Regards,
Andy Shevchenko



