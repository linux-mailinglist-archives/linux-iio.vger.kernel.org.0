Return-Path: <linux-iio+bounces-16773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5616A5F40A
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A33189F775
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B292673B2;
	Thu, 13 Mar 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGKGsC+a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CC1EE7A8;
	Thu, 13 Mar 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868160; cv=none; b=e4j4w08C/KP7SJUR9Y5M/ngK+7DhxfO4aOCIM00UvxEkjH4PP6xC9MayT9mb7sRfDBwdxl+vncE+y+uWSzusKXWeU0x6S1nHjn1L+ZEufXV4Abhj+l7p/fMwYsjzkZWK2mgy8ep8oe1mreiEwnCLrp49ssKyN5e64YdfehGoJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868160; c=relaxed/simple;
	bh=kaAou0aCgzlU0oUfOlYrlysp520v5XX91y8STuDaS4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sO7RDuTMre2vKkuLmHiUM0djQ+qHw16K3l7vDPqodzKxgJugD3LPTvcgxDIUg9xWx+GzYq1LflsRYZQHV5NPyzBsKH54YOJgNfqv6tPNg70ppb4UllTmXA3cjNdnT5rLEaM4v6f0G7w6hxfpelCMZnNMv90mjH7gmfd3I0nc2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGKGsC+a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741868158; x=1773404158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaAou0aCgzlU0oUfOlYrlysp520v5XX91y8STuDaS4w=;
  b=BGKGsC+aTNDz8s3H7Uatw7AzNydq7Q/eBHRKMXyFcag8Kv7lvJL8bNbd
   7Jfl2CAh7e+ZSyT/cnJx3zaKIeUTXilVjFQDy4QPD8HayPlv1TwQ77qeu
   8CHLZHIBQpSzxOQAox0A/enhzEcvRLZebT63wIhySPzw6phyoIf7Y0R9z
   zAj23/JIrq1DymzpbqgKoYAsXtutYiI0LKcETbYMxZjAYvEpVzo04/dHU
   7Rrd3eMhu86qowhmSUAYjXt2hc9DUVtYsylh5d8y+wNLxQ86Ij+roqdbh
   uTOzAGGTeAo5i+khJAAbxjQrchISVOe1RwRaCwZaXohg7WuqpHPnQyfo1
   Q==;
X-CSE-ConnectionGUID: ICs70ZJwTE6V10V5OJ6tzQ==
X-CSE-MsgGUID: OJEVOFguS0mjzVWjK6j0mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43181045"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43181045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:15:57 -0700
X-CSE-ConnectionGUID: RNQkYJ4BQiWZX4u2f7QQFA==
X-CSE-MsgGUID: MbZIX0BrROucfQ4ERBpTHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120655368"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:15:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tshTY-00000002AQF-3GON;
	Thu, 13 Mar 2025 14:15:48 +0200
Date: Thu, 13 Mar 2025 14:15:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 02/10] property: Add functions to iterate named child
Message-ID: <Z9LMdDKNLT57RdIL@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <f613b5f120a4dde63d28b0a2e0186dcb8dbf57ae.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f613b5f120a4dde63d28b0a2e0186dcb8dbf57ae.1741849323.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:18:00AM +0200, Matti Vaittinen wrote:
> There are a few use-cases where child nodes with a specific name need to
> be parsed. Code like:
> 
> fwnode_for_each_child_node()
> 	if (fwnode_name_eq())
> 		...
> 
> can be found from a various drivers/subsystems. Adding a macro for this
> can simplify things a bit.
> 
> In a few cases the data from the found nodes is later added to an array,
> which is allocated based on the number of found nodes. One example of
> such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
> 
> Add helpers for iterating and counting device's sub-nodes with certain
> name instead of open-coding this in every user.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I haven't checked the rendered kernel-doc, though.

-- 
With Best Regards,
Andy Shevchenko



