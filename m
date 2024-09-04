Return-Path: <linux-iio+bounces-9143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6C96C01F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D621F21E1B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053641DCB2E;
	Wed,  4 Sep 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MprrJbni"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8B1DCB2D;
	Wed,  4 Sep 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459554; cv=none; b=EWchLRVfovAdc79SuVVPzvRcf8BQuwQlTWIji0GKH4MTTqnBW5TIixfZvD9nyWS9bX6dwbFjfoAHmoh6RZs2EC/SlRob5qj/lBHeZPVs/iYYVmNS/hR4I+UoVyzFfTTn49mEDZy+WlFlA55EctOd7Kdj4mv+Rwn9vZIwMTEo5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459554; c=relaxed/simple;
	bh=uSLQCxe4IDaovCutek/xI4IU59+dVjLkoZhmTMkkGVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdd7K0Xl8Q8zFChg/Qp6fiDDsUPCEIZuhpGqa3rgTqhgXO/my4jaBc5H85YoNco6dcJqsE/VV+wla1w1inRL1VVjwDP8788VIVRfVq3kDJrM0tRKp4e797SfavO5dgh+RXUpS8IC/872SSwloL/2+Jkh/bkHSC5N8xxdk0f9PtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MprrJbni; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725459554; x=1756995554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSLQCxe4IDaovCutek/xI4IU59+dVjLkoZhmTMkkGVE=;
  b=MprrJbnimcDNxj3TUjteHrU6OcS2MpU4mbBmV++0qIfuO1rrPsDbhaP/
   T3qsFbyexFJw4b4l5HocHQ1qI/FPqfxnThMIuuZ1dt43dCA4nMHez3N5P
   MxHFtPEWaUggWS0yG5eiD7YZMHglek87nivR35fUglxbybCQ+C+tYMm16
   MaVQSrPUI/RC0YLiCcQwO92n7V1yS5mHxQLE++qpP4MhhUpymoAFgY9x5
   6kaE9Ph5GVdhdNWknLIDts278cFdY04Ra0WP1nKxlSZh6KkbuNrep8mK/
   wnIM7nnPWrTm4y2A65YdJHqp0uGEx7gCSYCkStDqIYk/ZTP9T/NkFyOTQ
   Q==;
X-CSE-ConnectionGUID: UTy740wqQgW7flANBDumrA==
X-CSE-MsgGUID: Znz6GnSaTZmWwrH7f8zj3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24077835"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24077835"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:19:13 -0700
X-CSE-ConnectionGUID: 4fVMMdv4TKuvaHt9rmVPLg==
X-CSE-MsgGUID: h/6hZmfdRZqP4bxpRhIcrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="96091784"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:19:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slqqf-000000055SV-3W71;
	Wed, 04 Sep 2024 17:19:05 +0300
Date: Wed, 4 Sep 2024 17:19:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <ZthsWaBKR8D5qXrC@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-7-vassilisamir@gmail.com>
 <Ztce3XuXZ-hxwU8h@smile.fi.intel.com>
 <20240904102812.GB44250@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102812.GB44250@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 12:28:12PM +0200, Vasileios Amoiridis wrote:
> On Tue, Sep 03, 2024 at 05:36:13PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2024 at 08:42:21PM +0200, Vasileios Amoiridis wrote:

...

> > > +	data->trig_open_drain =
> > > +		fwnode_property_read_bool(fwnode, "int-open-drain");
> > 
> > Where do you initialise fwnode?
> 
> Ok, I need to retest this with the device-tree.

But don't you compile with `make W=1`? It must warn in such cases.

-- 
With Best Regards,
Andy Shevchenko



