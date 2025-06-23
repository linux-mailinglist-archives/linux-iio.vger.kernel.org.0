Return-Path: <linux-iio+bounces-20885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FEAE3621
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB08E1892271
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E41F2B90;
	Mon, 23 Jun 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyLuO6PD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85551F09A3;
	Mon, 23 Jun 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661145; cv=none; b=OcUClztnaW0iBwAVb7HM1XMVGUih0PVwCEZ/Rr0OkN8zHgTONTupvnnu+/JvR6NnNiP1GLiVWz44GwJhHkCVGAXOaku44pWcJ+IKvlXQNPwXV8AT+JHzoikJwf+0pNRUEVH2RmeCbL3AA7LGPShcYbgSoWPQFSM+UGkooCsuCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661145; c=relaxed/simple;
	bh=w9OiTzZhaI79QJy6G2ci/B5q4sjHXmS4dpoPIF9Jmqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd+xEdY+D1Fw9rA/zcgoE3AgvFfeUygkbjeY/IT4MHwYSEs6m6McusHqWn3ozDDo91433fhRVzxUCO54LNanQz9b57esGpoSzMSdaJs9vfCwCwdGAiCUlPkqGTCnp+a9DaWJlEUIIn1qYT9fkcd3vUMOK6utOI5pkYG6VM5iQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyLuO6PD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750661144; x=1782197144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w9OiTzZhaI79QJy6G2ci/B5q4sjHXmS4dpoPIF9Jmqc=;
  b=eyLuO6PDZQS1KqSnJs23+qT3+Bt+x859vjjVlSU3CN8yFVsfT+Y4wBaL
   Cbo9dev8QyP3nYwQETis9rjo9qWegLEeaNmOfIgiRjrpJ4hTNYouPISoy
   qB6cl9NxdUmr90qFY+txFoxYWwjPbhtblFHM1gvXh+8QJbwhbHTn60wu8
   7QB3pUVOraddE8d6CPOOwvpWcvFgYgk6UoYusL0Uj6qD8aEGmKLkugpDK
   CIl9H0f3xRKQBPbYeXDvnYpgQ588x/8XQNzkUT2U/2Mh9V0TvdsWVbqbo
   +otRYa/tt7v4zaewoTf2bjrMpZVHDfZ96hUT1pvVcg5lsdtmxqEATPM2H
   Q==;
X-CSE-ConnectionGUID: +TLoDMBORV+2d6MZnCA1ew==
X-CSE-MsgGUID: jgJP4pmWRuG426BwKJvWqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="70422682"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="70422682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:45:43 -0700
X-CSE-ConnectionGUID: J3jnEaL7TRK4Pr1OCI+Bfw==
X-CSE-MsgGUID: yMYO4c2ARjOyC+stvMUHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="182379901"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:45:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTavx-000000095P7-0Qjh;
	Mon, 23 Jun 2025 09:45:37 +0300
Date: Mon, 23 Jun 2025 09:45:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Victor.Duicu@microchip.com,
	dlechner@baylibre.com, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, andy@kernel.org, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, Marius.Cristea@microchip.com,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Message-ID: <aFj4EI5CEIIQ8adl@smile.fi.intel.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
 <20250613130207.8560-3-victor.duicu@microchip.com>
 <CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
 <f980b3c1a4fbd60f70dda9670648479a38313439.camel@microchip.com>
 <CAHp75Vc2nueOycoy8+dYyQekAAMPO82wOYSVT0RZOC4yRaE5jA@mail.gmail.com>
 <20250621181946.28d831ac@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621181946.28d831ac@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 21, 2025 at 06:19:46PM +0100, Jonathan Cameron wrote:
> On Thu, 19 Jun 2025 11:29:30 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jun 19, 2025 at 10:22 AM <Victor.Duicu@microchip.com> wrote:
> > > On Sat, 2025-06-14 at 00:50 +0300, Andy Shevchenko wrote:  
> > > > On Fri, Jun 13, 2025 at 4:02 PM <victor.duicu@microchip.com> wrote:  

...

> > > > > +MICROCHIP MCP9982 TEMPERATURE DRIVER
> > > > > +M:     Victor Duicu <victor.duicu@microchip.com>
> > > > > +L:     linux-iio@vger.kernel.org
> > > > > +S:     Supported
> > > > > +F:
> > > > > Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982
> > > > > .yaml
> > > > > +F:     drivers/iio/temperature/mcp9982.c  
> > > >
> > > > So, with the first patch only the dangling file will be present
> > > > without record in MAINTAINERS. Please, make sure that your DT schema
> > > > file is in MAINTAINERS.  
> > >
> > > Are you referring here to the file sysfs-bus-iio-temperature-mcp9982?
> > > This file was in v2 where there were a few custom attributes. In v3
> > > I removed them, so the driver currently doesn't have custom attributes.
> > > Should I had added it to the files in MAINTAINERS?  
> > 
> > You should have added the file to the MAINTAINERS in the same patch it
> > appears. Not in some arbitrary change afterwards.
> 
> Perhaps the confusion here is that Andy is talking about 2 lines above, not
> the immediate line above this feedback.  So the one with the dt-binding
> file.  If Victor was reading it as being about the .c file then
> this whole cross discussion makes more sense!

Yep, sorry for the confusion. My point is that the first patch in the series
added a file, it should start a MAINTAINERS at the same time.

-- 
With Best Regards,
Andy Shevchenko



