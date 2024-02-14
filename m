Return-Path: <linux-iio+bounces-2561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0A854F88
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 18:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D71F2A57D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCC629E9;
	Wed, 14 Feb 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OScvr7L8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F03761672;
	Wed, 14 Feb 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930659; cv=none; b=Pyplsot1TNBEmBFnZrjpKMrdoW7Nr48924MtC5DoX7Xq7vG0h26e45HzihMhpnlygTVuuOqtds6MXhBFskj+XE8XOfjyda7Fum+B3DlwuYhZUO1fCvb2g6fCiCIEFLhsRR9AYbV6TzDwH442Lnh0OjtpYcXxVJxbcsySIAX3PkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930659; c=relaxed/simple;
	bh=bvnD+OjoQnA4QkDdelDCXVZDOi9UUtu5BLhiVc3e32w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5i3KiaxuPayRjfzJn0PTheu3S8FGo6Z/VB/pPaZ2gAml34k33/HQp0iLMseCdQdtDmTv+nkOS8gBhKox1/nTcSR+TYOKU3xGErjH0tVDvsM2OaFHnOn/sLKxTxirkwEmS3YJSniAUep8tghQywuWI0jD1ZsWuSHe7+uwJ+I5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OScvr7L8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930659; x=1739466659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bvnD+OjoQnA4QkDdelDCXVZDOi9UUtu5BLhiVc3e32w=;
  b=OScvr7L8nXbFYxNtkbU0GQCN5ROWbLjHxhMyabRsQuZBQOBI3xoOdORB
   z2MyFVz7ydXu9aK5cOLdMKXQBSijRMFL0dxyO618DNMr1ghmiE5kRLY3W
   9rRSlRGEL4Ubn5gOnyd12Svns67SBGHJYTvAqvEuNRTe6PNW9O520Z+7H
   v7KnF4hu+P1vATIWEWUIrRjnIB5WrjEaWcuI7rXqj1YxRBQjIU379voTk
   NjpMeLWu7Yi3KjRW9UJFh3OOBZHcyaxo3KvjOulpNmkVuXICrCfPa1bfx
   iUKj7CIuNCD2viFmr9tU3Gj4O7pdGej4ifz4PaOSgM1CQCw6RAQMUD1b7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19401889"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19401889"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7868332"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:51 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1030E11F7DB;
	Wed, 14 Feb 2024 19:10:49 +0200 (EET)
Date: Wed, 14 Feb 2024 17:10:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <Zcz0GVr8TTQWpPci@kekkonen.localdomain>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
 <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
 <20240212114206.00005b9f@Huawei.com>
 <ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
 <ZcoTOZzJ3ZhSD0oi@smile.fi.intel.com>
 <ZcoV2xfcCOYKZicY@kekkonen.localdomain>
 <20240213102245.00005c35@Huawei.com>
 <20240214140938.00001637@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214140938.00001637@Huawei.com>

On Wed, Feb 14, 2024 at 02:09:38PM +0000, Jonathan Cameron wrote:
> On Tue, 13 Feb 2024 10:22:45 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Mon, 12 Feb 2024 12:58:03 +0000
> > Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > 
> > > On Mon, Feb 12, 2024 at 02:46:49PM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Feb 12, 2024 at 12:36:46PM +0000, Sakari Ailus wrote:    
> > > > > On Mon, Feb 12, 2024 at 11:42:06AM +0000, Jonathan Cameron wrote:    
> > > > 
> > > > ...
> > > >     
> > > > > Hmm. In that case I'd rather make fwnode_handle_put() and similar trivial
> > > > > functions macros.    
> > > > 
> > > > This will kill the type-checking opportunity, so I'm against this move.    
> > > 
> > > Then it could be made static inline and moved to the header. I suppose for
> > > modern compilers there should be no difference in between the two
> > > optimisation-wise.
> > >   
> > 
> > Sure - will be a bit fiddly as this is only worth doing if we drop
> > the internal check that buried several macros deep.
> 
> Not enough coffee yesterday. We can just move the the existing
> fwnode_handle_put() to property.h as that includes fwnode.h has
> all the definitions in it which we need to be able to see.
> 
> I think that should be uncontroversial?

I agree.

-- 
Sakari Ailus

