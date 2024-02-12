Return-Path: <linux-iio+bounces-2468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1272851344
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29890281F1E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26239FFB;
	Mon, 12 Feb 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrr36wia"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927D3D0D0;
	Mon, 12 Feb 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739869; cv=none; b=NhK2PKmnEPnbOWztR96BStmV9WyFD+mt5lBabiQ6dhuwd3TX4yPsrDbjoKYe3KxiWzknAtSIEQINTTJteI2d5m18Ub5BuGioEi3A8doRl1XhqsUbLSKwLdPy8s20Za4kEc5ueBrAmPiU5NrwmQMlnrsVUjcBFArO6n8X/Glvm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739869; c=relaxed/simple;
	bh=Y0fJhdwmwmI+cdi90OiPn+Q2ddp+yq27qdmkohFb8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRlAgr8Jt2W6Fe/rGLVdzU0la5xsE9ySgTeAZUIfv3fgSr/BadaS2F3p+sk7nbQIihT1CI8nbg5i8HKc4CWMMLDSZg0yzM/gIm22KF0ynVwiUiOhO1fdxQhU6RzSmLVy3DvgYGHZpQPxzVvrEgs0luLv79WmZr7+4PDPMUBSLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrr36wia; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739868; x=1739275868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0fJhdwmwmI+cdi90OiPn+Q2ddp+yq27qdmkohFb8qU=;
  b=Wrr36wiaQeS8fwJABRuXr1DBTcFcsUicy+eX/fJQkTuWDNHU6ZQet3X4
   C7bKuzbLEKUHGul4XTFAx+4vVTNeRkkPZySyzHDDQhkn3ikBbxpYSc1Jz
   9owrwdfLaTLM/T3QuI/pgYadmge/yd3+aYw32sqxudWKLV4K96lMefJG1
   qNyNpsA2vXbmjkvYAVK8YAgkC2bLzJeYnxZOPzZJmi65d5fsJsJgcZyMK
   S6fPNsfm66VyzmTtNpqSElpOf5vDdQb1aNyKfaJTOSfbZGPYeBFxDXZds
   Dzp4EgpXy6E5FPEx4RdMZ6k+nfkqni+wjPe15KLjcuvMFW7Zg38dpUBVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1590534"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1590534"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911464911"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911464911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:11:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZV9F-00000003t9Q-2AlT;
	Mon, 12 Feb 2024 14:10:57 +0200
Date: Mon, 12 Feb 2024 14:10:57 +0200
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
Subject: Re: [PATCH v2 03/14] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <ZcoK0Q8NgxolNeD8@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-4-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211192540.340682-4-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 11, 2024 at 07:25:29PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Similar to recently propose for_each_child_of_node_scoped() this
> new version of the loop macro instantiates a new local
> struct fwnode_handle * that uses the __free(fwnode_handle) auto
> cleanup handling so that if a reference to a node is held on early
> exit from the loop the reference will be released. If the loop
> runs to completion, the child pointer will be NULL and no action will
> be taken.
> 
> The reason this is useful is that it removes the need for
> fwnode_handle_put() on early loop exits.  If there is a need
> to retain the reference, then return_ptr(child) or no_free_ptr(child)
> may be used to safely disable the auto cleanup.

...

> +#define device_for_each_child_node_scoped(dev, child)\

Missing space before backslash, but I would rather to make them to be TABed to
the same column.

> +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> +	     device_get_next_child_node(dev, NULL); child; \

Please, move child to a separate line, so we will easily see the all three
parameters of the for-loop. That said, indent the assignment to the right as
well.

> +	     child = device_get_next_child_node(dev, child))

With the above addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



