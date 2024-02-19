Return-Path: <linux-iio+bounces-2764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0043885A27B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BBB1C216F1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42332E410;
	Mon, 19 Feb 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1v9I5QQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F837143;
	Mon, 19 Feb 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343374; cv=none; b=DJWIwvXElRM6dy34ncRQKpBkXgngz5i9CizHM2sAjpN6EP/DJtIT0kAPad0MkqettN+Xrg0s3aWd6Vgb4SQoiJvX1f5LcyR9IhxxTIKUAIaxPIrk8veyX70iLSCRiwbiAB/pVQwUYGoeF+9uhgOjgFfmAktQTVYL+adsEFRqvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343374; c=relaxed/simple;
	bh=s/s/Nm5wsz3NOrwi5ymySLZMbyvsSSK4VaJ7A2f9yDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwHQYHQ68TyWyZJ/4rAmL5qGF7mCJ3q48S2KrZKxpoJwWiElEAuff5oAtI/1SDi04nTJBLnCymZq0HLHDsGmqKmTZ0iBT4PgyaX2nxs2zSUDvmTlf5ieigb5dwWyh7/4O/fCBxZ5JswVeKUMj1mn7BnWowTMrntjbi8kDsI4VcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1v9I5QQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343373; x=1739879373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s/s/Nm5wsz3NOrwi5ymySLZMbyvsSSK4VaJ7A2f9yDM=;
  b=J1v9I5QQ0ZhaoK+b4B/jOl862T2OktDOyHPTa/+fHk2QGpRQjmKVzQnx
   zFsAtFjuqc/f1ZIhCdWfL2mhtRCXdcn3WmbjSzzK4V8aPgIPAZb1c4jD0
   j9YTWtkr0L310YlCffDngdLzvAiKzflCFLkvphyBIoRSTBCWdxxQ+ozQg
   NXmQgAhjCW+90JPE4wlANS1OHQfQQKeSZhy6T2AJ9I1/WSuaVUi15tuak
   nb7H6XcPfxPntuWqKpODZFHICxyoDDBJr80XVijKLxq1Nt1nmYV1XRPhL
   qf7CviCEYEyOCEQKlVJ0gUASrG6mcg9N+L3gPqT9ZIwBDGK9VZ6wqtlYC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19949981"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19949981"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912861883"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912861883"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:49:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc29C-00000005oLF-1HFi;
	Mon, 19 Feb 2024 13:49:22 +0200
Date: Mon, 19 Feb 2024 13:49:22 +0200
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
Subject: Re: [PATCH v4 00/15] device property / IIO: Use cleanup.h magic for
 fwnode_handle_put() handling.
Message-ID: <ZdNAQi6IlMN-quO_@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 17, 2024 at 04:42:34PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Sorry for the rapid resend, Andy noticed I'd messed up creating the v3 patch
> set with some updates committed in the wrong patch.
> 
> Since v3: The updates to alignment of device_for_each_child_node_scopd() were
>     in the wrong patch. Move them to patch 4 where they should always
>     have been. (thanks Andy!)
> 
> Since v2: Thanks to Sakari and Andy for reviews.
> - New first patch moving fwnode_handle_put() into property.h
> - Tweak alignment in the loop macro
> - Pick up tags.
> - scopd -> scoped typo fix in some patch descriptions.
> 
> As can be seen by the examples from IIO that follow this can save
> a reasonable amount of complexity and boiler plate code, often enabling
> additional cleanups in related code such as use of
> return dev_err_probe().
> 
> Given we are now fairly late in the cycle, I'd expect to take this
> through the IIO tree and we can make use of it elsewhere next cycle.
> 
> Note I don't have the hardware so this is compile tested only.
> Hence I'd appreciate some Tested-by tags if anyone can poke one of the
> effected drivers.
> 
> Julia Lawal has posted some nice coccinelle magic for the DT equivalents.
> Referenced from that cover letter.  Similar may help us convert more
> drivers to use this new approach, but often hand tweaking can take
> additional advantage of other cleanup.h based magic, or things like
> return dev_err_probe().
> https://lore.kernel.org/all/20240211174237.182947-1-jic23@kernel.org/

It seems you are got all necessary tags to go.
I commented with some side notes that may be addressed later on.
Up to you.

-- 
With Best Regards,
Andy Shevchenko



