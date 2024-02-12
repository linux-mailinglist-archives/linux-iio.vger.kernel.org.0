Return-Path: <linux-iio+bounces-2455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D24850F15
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 09:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95AD1F225CB
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A5F9D8;
	Mon, 12 Feb 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISBEuEQx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811610795;
	Mon, 12 Feb 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727774; cv=none; b=moUG6nCOE+ZfCs2zu1KqP5DJ6X3ZeA+YO7Yu+gIno6J/+jiaris5uqRN8nzYJ4wHi5sSAX8A8B3nxPAbDonLH6xLl4+VBpsCYXBqs2lEoCxKVdtZv1Zefex39thth4fvd6+dsz0hhHEZKETdaDPMXz+pLD1GI8jRKpHfhRyZW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727774; c=relaxed/simple;
	bh=KT/zqqCZcSifoTt5LnMwA52s1WVzZUmy5NnMYDaMo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5+ipXtXcZrM6crw+IZP56ku+/LlVeUprnTi1jPflsDLyCw6HuhBniQ9HSKg5ZKNbzLbGNxFEFNEklvWSahoXeGeC0fYA486jyzOBR+GNCYN1g0ZrvAgpKT/ArlUqLKWWAl3Sozw3p1iSEet+v+G6mxsIwiWqadcyQtPxQjUa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISBEuEQx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707727773; x=1739263773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KT/zqqCZcSifoTt5LnMwA52s1WVzZUmy5NnMYDaMo5w=;
  b=ISBEuEQxe7iJzfKmAWi0W7nderJFf8kMYBfRlRMZ10C3aQJo9wV1tB5k
   V5lbv2ZKRPM98n4cUt3E0INmMAmm3tiNIRyZOXhGEdf2q7+Rz5Y2ju1rX
   zx/jxExjstthw4fXiQAwaFnzGrEoRucPVR1Ju3iYOG7ZDy6x0qwbalOq6
   8bGexG4FaPtaZMbQSPIHa24rNLqkTcnwlT9/+8e2OElqrwtxfBGxDs16o
   hmVr+3ERb9ogyWJPZ48CK9nibE/tCwkMkqswVZ7zYkfrzIGfSnMZFap0Y
   gDNEl5MQ6RuJhdsCSubfUBtCa9UiVhJpJgqPuHg13xTSYAvjMQWdYeDEC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19199845"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="19199845"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2928002"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:49:26 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7A2F711F86A;
	Mon, 12 Feb 2024 10:49:23 +0200 (EET)
Date: Mon, 12 Feb 2024 08:49:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Message-ID: <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
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

Hi Jonathan,

On Sun, Feb 11, 2024 at 07:25:27PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Useful where the fwnode_handle was obtained from a call such as
> fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> and will automatically release the reference on the variable leaving
> scope.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/property.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e6516d0b7d52..bcda028f1a33 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -12,6 +12,7 @@
>  
>  #include <linux/args.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/fwnode.h>
>  #include <linux/stddef.h>
>  #include <linux/types.h>
> @@ -188,6 +189,8 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
>  
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))

fwnode_handle_put() can be safely called on NULL or error pointer fwnode so
you can remove the check.

>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);

-- 
Kind regards,

Sakari Ailus

