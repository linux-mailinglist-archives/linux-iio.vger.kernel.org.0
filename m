Return-Path: <linux-iio+bounces-2470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443D8513C7
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8866CB26F77
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2DE39FEE;
	Mon, 12 Feb 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU2mqw2S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7A39FE0;
	Mon, 12 Feb 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742022; cv=none; b=HEraGXYaL7ctwKVy2VWORWoOd3E1CuiwPUsBLy1HMpYmuTaW7wCzDw56MGhfWkAFfd09/tLdnV6LJliyrQ+pQqjGX+aCSi7myw1TkrAKoiQph+Ia6+qwK01I/YVjw/p6u5PDfgWArz0WSKc/wqlEQCu8+zrP1h5LRlaqs7yuUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742022; c=relaxed/simple;
	bh=VGjXjJHTBItfi8EDrKKzYJHx77XH7MOpvLPFD6P5q8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTDPryYPPO/nhy8u0hxe5NZkGMYEixcvw7NypFcN27TmmoI0Y7EFQgS5OgorY/uwsaMhaOStIcZimaqJrW/qu3VERedXnE9XDm1P6WzCiqkkOQ7vKlR9teQ8CZHVQIGEV90c4+as2UBoompOnQkVjjEJI8CqHp4cDsXug2eSKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU2mqw2S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742021; x=1739278021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGjXjJHTBItfi8EDrKKzYJHx77XH7MOpvLPFD6P5q8g=;
  b=lU2mqw2SrvFh8jD3LOJWaoo3aguLl0XoS6fuvr6jRs0lnshob+NBW5aJ
   zXu5RK23KR+NOpAk7WlF1xfml+aTMDk15vZCCHc24vqC4wHdGGo8LtLiN
   /QXMynSD3/yrVzy7ylk//qWccAxbbr9WQ1gYPcoS9SrCoI9idGll0XZ4f
   Oo+bfJXHM61biit0eqNjQXhvk1uGSaZzd9CMAyD6sG/KkVQgKu5HXQM4K
   FY2WyJr8BOkKdmnSNytxCsZyg2UTVcvMG6B22kW1oSml4RyWuO9Igjrgj
   jKdXc/ZcTWEk7SxCG3iTNG6/kYFttQgmtL495uS70fOoV81hn0ZduTOP/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13098180"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13098180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911473248"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911473248"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:46:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVhx-00000003tf6-1did;
	Mon, 12 Feb 2024 14:46:49 +0200
Date: Mon, 12 Feb 2024 14:46:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
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
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 01/14] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <ZcoTOZzJ3ZhSD0oi@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
 <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
 <20240212114206.00005b9f@Huawei.com>
 <ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 12:36:46PM +0000, Sakari Ailus wrote:
> On Mon, Feb 12, 2024 at 11:42:06AM +0000, Jonathan Cameron wrote:

...

> Hmm. In that case I'd rather make fwnode_handle_put() and similar trivial
> functions macros.

This will kill the type-checking opportunity, so I'm against this move.

-- 
With Best Regards,
Andy Shevchenko



