Return-Path: <linux-iio+bounces-2471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0418513E6
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5EA1C21B82
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19E39FFF;
	Mon, 12 Feb 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WANky/7H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD13A8DE;
	Mon, 12 Feb 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742693; cv=none; b=rTurBFl7UUS7/wO0jbM7LofR5Pin49o2QzQkvaujd3Sn312V8fMDtFV0a0ExhzzFG/ccvS2sDSdJ2K6ldBoZx3DeqElsZV2OSAq0A5Sf4spOBzuesSuseop2dd4uxb+6eoA69/hBruiSh0+K2MFRwticHjwOcg0HqgZfEITbaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742693; c=relaxed/simple;
	bh=FvedEkhfe/YYw5lZDojjwZOL9fqgcPLkDtzkDe3OXJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smCvPpYn4czacfS0WBbYUsUlPITRk2fuETqNLB2FCPUMXMmzFAO+vknCZqPqeJEmYs25jZTwjJ+vfhJyPoDASFdLbFd7b3XpkRx2Y15hVl3OG92KaTu0tJRIkBKainZl7uZqy1lZVWnqbq4NvsVIFvQCxo8YGtT5kjUl7xC8OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WANky/7H; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742692; x=1739278692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvedEkhfe/YYw5lZDojjwZOL9fqgcPLkDtzkDe3OXJ4=;
  b=WANky/7HMoKiTGUqCohc3qbyyFWtsFu/i4Qj6SXVeYkYUujI+YEWWn/5
   9d72p/X1zQ2fUxb8fsxOM82VDC/CmvwG7NoqTu8LI4Z0lG4iJuA83MIKs
   TFR3jv+H8w9ai/p1hIzNv6dz1VoIVaMBJozVT3USDljU2cUk5zDenOK2q
   fTsFDddbMb7LpCV+Kz1N1jt9/BPcwfAVVm9qE4uWrZDNHGe32aQ7dpA7d
   vKgDbwrlMUSGWdUaTrxZQteLzpo3AtshulXoghfxu+Out25aZ7YZEvSkF
   cGStNPi8gDBZ4ilWV3optcuEZJqeJ+dJCQdgFNQdNZD7yn2Ry4paOXDGu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13098932"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13098932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911474474"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911474474"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:58:05 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 16A5411F86A;
	Mon, 12 Feb 2024 14:58:03 +0200 (EET)
Date: Mon, 12 Feb 2024 12:58:03 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ZcoV2xfcCOYKZicY@kekkonen.localdomain>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
 <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
 <20240212114206.00005b9f@Huawei.com>
 <ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
 <ZcoTOZzJ3ZhSD0oi@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcoTOZzJ3ZhSD0oi@smile.fi.intel.com>

On Mon, Feb 12, 2024 at 02:46:49PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 12:36:46PM +0000, Sakari Ailus wrote:
> > On Mon, Feb 12, 2024 at 11:42:06AM +0000, Jonathan Cameron wrote:
> 
> ...
> 
> > Hmm. In that case I'd rather make fwnode_handle_put() and similar trivial
> > functions macros.
> 
> This will kill the type-checking opportunity, so I'm against this move.

Then it could be made static inline and moved to the header. I suppose for
modern compilers there should be no difference in between the two
optimisation-wise.

-- 
Sakari Ailus

