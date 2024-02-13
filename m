Return-Path: <linux-iio+bounces-2516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288D8536E8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E82861B9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F64D5FDA5;
	Tue, 13 Feb 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLK9tQUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD325FB95;
	Tue, 13 Feb 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844378; cv=none; b=n9pC54GzW2gov8WOgYYtyVUBHXUQuH0gRVKJ/Td29lM8PBOve3yPNtl4X3sKz2eHyAIKVcLLDtSGaf/IW5QlcDcI7KRlfSL58RxWHw5YltVGbGvT1jg8/f8hdfWmdxzlhVkm+3Wz9qG1om+Npxocc1xryV/AxABBnaT5C/JDEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844378; c=relaxed/simple;
	bh=amY0atvwg7GXc3uORzM52gPRhzVwd65eYIS7D0y6uZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeBiEoCe2UedZ+F2VoB+LNRbib7gVqgk2KpeerhnwJlZ7sYaB63hKkXWibF+MgIDqZ28vX+j92cBMeithCIPzDxciXfzGeT4knPR+T0eKURierdfaPb/8hh5RlP08UD8fLRCosOR1cqjkOZmU879kGZsmfp01/Hqsb4Lqd6lrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLK9tQUY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707844377; x=1739380377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=amY0atvwg7GXc3uORzM52gPRhzVwd65eYIS7D0y6uZg=;
  b=nLK9tQUY4K/I0R9wiQp2RVTAqJEasJllEtT4VmhugTPnlwtRjxF1RcWC
   ldVGITFAsFp2hqI0LQuYU0AsLAduAiotukABjpQe4y3jnBBWQ/WjZq7V3
   i3yYtCuOIzw9xzPmoQ78L5jIa7YtmojHqx23gt81GWFcNbG9sCZQ9v+V3
   uD9t/GFG/GcxB6X8A9j4VHQ/VLuhNvCS2VKFfRAD18RbkUnrmXf+IXZH1
   gtDWFmEu/wXSixdeAxURUqiD4hAVzd2dM1WnegKaJbn/Wv7HDpG+DeIB0
   p8k8g3COqU+83+RdAFs/CmcCmCQbVeXlW2z6LNZSY27f4i2xirfx97gLC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1741917"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1741917"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911839181"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911839181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:12:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZwKs-00000004H7X-3FZf;
	Tue, 13 Feb 2024 19:12:46 +0200
Date: Tue, 13 Feb 2024 19:12:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/14] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <ZcujDu0uQJqndFEs@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-4-jic23@kernel.org>
 <ZcoK0Q8NgxolNeD8@smile.fi.intel.com>
 <20240213102529.00003bf2@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213102529.00003bf2@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 10:25:29AM +0000, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 14:10:57 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Feb 11, 2024 at 07:25:29PM +0000, Jonathan Cameron wrote:

...

> > > +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> > > +	     device_get_next_child_node(dev, NULL); child; \  

> > Please, move child to a separate line, so we will easily see the all three
> > parameters of the for-loop.

Oh, I should withdraw above, we have other for_each macros there with
a child being combined with previous line.

> > That said, indent the assignment to the right as
> > well.

> Indent makes sense - but (to save another respin) how far?
> Next tab stop will be a bit random looking but I guess nothing else
> makes more sense.

Just make whatever TAB stop that doesn't require adding any spaces.

-- 
With Best Regards,
Andy Shevchenko



