Return-Path: <linux-iio+bounces-2674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF488584C1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 19:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3242B2341D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F38134CCE;
	Fri, 16 Feb 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8eiP2Xx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95031339B1;
	Fri, 16 Feb 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106582; cv=none; b=kCMhva5/ZMEk6EGcz98Rqph6OFkJ8Pr8kUhKFiEiT15ZNqYOjLxUuFavlDXFZlYndcmwzK0C4rAwfdI6MAPJiMD1acnZChe9MFKBF4s6+xXLP/8RPUsntsMM78G7AGgPQzqXX8AsJk1MwX8JtIltRqurY6hR4dGuPsT1WmAmyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106582; c=relaxed/simple;
	bh=QuwT4LCDUgH9Rs1RA4JpYgc+xfXdQePBF3mXlgUAkos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW8nMMebYme4DdnAHmLKw5OBfHipCauyPm8uqvf7rf2oSL6u1KAcTPIZlWYHe1zWaB7l6difz9n/4tehwnDl+Czo/UMQ/ULitfaRqbJW116WfhYqzdX7fyUE5GV3Z8l3fqq9W8ZVH7r0RBHoQcmst9xxg4UizE7TbXS3l/P5DU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8eiP2Xx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708106581; x=1739642581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QuwT4LCDUgH9Rs1RA4JpYgc+xfXdQePBF3mXlgUAkos=;
  b=m8eiP2XxXijhB4W6rTZNJwfzOUFkRPwCmn41MwqiE5N+O76Ma08uc5G+
   Sq7U1g8+ScabU9JR2cf1qXeK8ImxQYMIfB4vqm5FNE2lwNhHRPKc3zVa2
   VvzufxHXfKKV4wfZl8W9DSJweRNj4vYYBQeeuQAvg+UTyBzkdrZf9v7G/
   XOlac0ZeGRt27NBxtZTYChjKq5hFuANCyOKJ8C2zRSDnu//N93D/UTuZE
   PbFj3v/kapZ1u3BjjcllSmwtlAELI6VSJLV2Y5EGS4Ceb9V3MtfS7d/6l
   KKPl7aLS3+dRGFIbSTtOhWPf9m0gnjr+bpqIVVqxl3MNvkCchb5ZTtlG1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2376321"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2376321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="912398436"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="912398436"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:02:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rb2Xx-000000057eo-2T8T;
	Fri, 16 Feb 2024 20:02:49 +0200
Date: Fri, 16 Feb 2024 20:02:49 +0200
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
Subject: Re: [PATCH v3 04/15] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <Zc-jSerjhYjfndDg@smile.fi.intel.com>
References: <20240216175221.900565-1-jic23@kernel.org>
 <20240216175221.900565-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216175221.900565-5-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 05:52:10PM +0000, Jonathan Cameron wrote:
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
> +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> +	     device_get_next_child_node(dev, NULL); child; \
> +	     child = device_get_next_child_node(dev, child))

You haven't changed the indentation of backslashes...

-- 
With Best Regards,
Andy Shevchenko



