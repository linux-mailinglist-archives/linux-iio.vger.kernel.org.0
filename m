Return-Path: <linux-iio+bounces-2809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E259785B356
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA31F21EA8
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474E5A0EE;
	Tue, 20 Feb 2024 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZYfWpSM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796A5A0EB;
	Tue, 20 Feb 2024 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412418; cv=none; b=AtIBv2keDxPtdlyZOmKpiEC6VzhpeflsXCYu13r1ZC9KiH0AwLINYNFOTDVtWMKFeqV8SThkWag9S5bvDPNw2mxSiqaIoFugAg1NwT8eADUji2n0rO9n6cPwcdfmDU1D5mvVcfitImtsTr1b/ha43lcNALEgEsWHu6Me1UznhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412418; c=relaxed/simple;
	bh=gvA7C1qXgupfhtfLt4Oax65NTnQad2ytf50sYY/59tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQHqIrJ3xXNxB1radDu82XCSwEEUFv2TKe0zK3oNeRO9g/cZxgzJt69h+3W7qfxJC0T5RxBsxBXLVA3kjK+ir4XF/4jxkBFTqrxBA4Xq+LdUcLmvLXNPuGfQzsZisO4Cr28lkPV6kmoWfsPk6ySeBMaTYS+JV2aOXOkve9T1G8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZYfWpSM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412407; x=1739948407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gvA7C1qXgupfhtfLt4Oax65NTnQad2ytf50sYY/59tY=;
  b=KZYfWpSMwx6UnweQTOReacewfPqA66+Hx9zRL611pvD9zUelCMwQ8PI3
   z0GVRdIIy4xwZwsNvj+qM/aHaf6BIfoUcp+oW9GjOBJUIkZrjbtytJ+m4
   VR1m4BOZvAIpb6nj0Nu1IFnCaBN/hPkfaPuGnXSYgSYhwjMcEeJ3WINAV
   SuUTUlppRfhLkf4b3NMXYjhI66fESXGzHH+xbR/i1n2SH74UAyerWZwbU
   I9Y3RLAL26vxAq3bBYhV60WO2d1QQWPkdU8qoX+DqRnBCFVTtvsDhrjYT
   tqqhXfNx8m9fneIu1UQTZyQK7eBAFD2RWC+UFjkskSYTyEGup7fsZUXSe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2363501"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2363501"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5055814"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:59:53 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 19CF611F7E1;
	Tue, 20 Feb 2024 08:59:51 +0200 (EET)
Date: Tue, 20 Feb 2024 06:59:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v4 04/15] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <ZdRN5zdFLcR5oRdl@kekkonen.localdomain>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-5-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:38PM +0000, Jonathan Cameron wrote:
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
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

