Return-Path: <linux-iio+bounces-2465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369BB85131C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42303B27A19
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D13A1CA;
	Mon, 12 Feb 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHtfTUO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB633A1BB;
	Mon, 12 Feb 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739546; cv=none; b=NIDz8JmShTAZDATH+PZUQc0jqhu2MzdOR9nw9Ln0AsSSHY1bGbKVkOk+sCDlwbBunLHPD8iLYJ4wUR0qA13jyDuFJgiWIJrSYeQUKnW6N1k4ptTj760QFD/w6eHfTguxB4mUVl1mipLHJQKpZumv4IYvoc6IwiW52bRkOiaujnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739546; c=relaxed/simple;
	bh=heqvZ8L00XwEqmJ+zKJxsEYSoUe5w3rEmtRM5dTwTnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdQJ3l9NmVdgXxq3EEhunPPDeKEoJ+5/0y0rwQPmntSHleKLlY1BdLMHSUVBF8ZnI412XGaDPZUbcOJgNCAomot7UAnvuwaQimOw0dY9tT9IDlgo9tSfn7AlIk/NP5T7lTnbfb/c2PO6AZ3rFeuEV2pidA9JsKGh+T73DBWFd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHtfTUO8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739545; x=1739275545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=heqvZ8L00XwEqmJ+zKJxsEYSoUe5w3rEmtRM5dTwTnk=;
  b=EHtfTUO8eVUz0AeNn8FEtwQl58quQeY5U1XDepAWyCcG0kDYKUliBDle
   HYwTktmgJ8P+60fQX8iD64kyT6MGE+fpULTOAPHihNi36dYo0Js5wE+1v
   GzynBt+mppjEYpGeYY1R+Nl5Aqrz4SsvTkSrccX+62NIclytHH7C2c9zX
   6EDkdfvp6xoUzqlVVQDVv/3C7H+foePACZcUFaBJFALD+vOgmfXo/gllU
   3QV3oHzAiiXI7z9bnYVGq6RaHAwZBy87Hq9zzpa1qzYlZaePlyXovZMEH
   XZflUouNn86KObQdtob54E54Na7KxwwtMo/HRKlmw/VBQyBhIQ3l4w7Az
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2056714"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2056714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911463620"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911463620"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:05:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZV3z-00000003t5G-0cR8;
	Mon, 12 Feb 2024 14:05:31 +0200
Date: Mon, 12 Feb 2024 14:05:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
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
Message-ID: <ZcoJiiOcC0pnEm-2@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
 <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 08:49:23AM +0000, Sakari Ailus wrote:
> On Sun, Feb 11, 2024 at 07:25:27PM +0000, Jonathan Cameron wrote:

...

> > +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> > +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
> 
> fwnode_handle_put() can be safely called on NULL or error pointer fwnode

Yes.

> so you can remove the check.

No. (Technically "yes", but better "no".)

This has been discussed a lot, including the LWN wrap-up about the cleanup.h.

-- 
With Best Regards,
Andy Shevchenko



