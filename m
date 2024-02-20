Return-Path: <linux-iio+bounces-2807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877C85B336
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 07:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6F0B2140A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CF28363;
	Tue, 20 Feb 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S23SH54C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AC186F;
	Tue, 20 Feb 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412132; cv=none; b=DtOqHRDDXNROJr4a8ciat0eH1Mnz+q9dpt1A3bl/K2Kd8TPUseXekkY0g26BPEOHNg21+jrh3z0q3P8ByRl9/JDk5qUoEO4x79OcVlhJ2ae9S+9lWXCdoOol3Ot4R7XJODHwambF1a1RGbkEHlmHb0m7HHh6Qbd1IzWDyhQKIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412132; c=relaxed/simple;
	bh=ZbeWLI+u0Im6wyY+YQK5HwdJcu5x5fe0e/cuHdUXBzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NosOimddnR3x30ogPPimrOZIt/8BbL9ipJQmascVNrfv8SdhmyEfXTI3F+bzNhZva1A1nHIVPLGH5jdq2oOS0kzBmdIRaOdPMNAv8m8tebeFJOO9qSiSLk5oInxTCNaU8pjBFqurP6NzE2nSYfCThQ0QS/01W3cPPU7aoOe8dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S23SH54C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412131; x=1739948131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZbeWLI+u0Im6wyY+YQK5HwdJcu5x5fe0e/cuHdUXBzE=;
  b=S23SH54CvvtJLTCDhjUP0S/l68r6j1Ycyg2HxAbFBVYAEOuGZDMoezAg
   hFP/40PSXaWpBQHHly/d0XCd1gvBV1pTljTs7cngGw1N0iZD422W45pDe
   yJ6A5Al5VcGEfNPw9Gra8f0Z6EVX5IH3Oh9HMl4oS6/5vm4txyofDcTdw
   4t4FPkJDe6Vd97t7LLmKHKHPjunomB6qqfGjc8c9SXrlTITDKG2eGowLu
   /xscYZa89X0HS7uBxrUCmGLVovQcayWBIbm6TQ/tdngfH19NbqQnPSINH
   5E+SBM9wvQiK2W+y60+BCeP4k7H9nzlUDYwUDA4AYCVSrKqST80kHshbF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2377744"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2377744"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9301043"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:55:23 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 782E811F7E1;
	Tue, 20 Feb 2024 08:55:19 +0200 (EET)
Date: Tue, 20 Feb 2024 06:55:19 +0000
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
Subject: Re: [PATCH v4 01/15] device property: Move fwnode_handle_put() into
 property.h
Message-ID: <ZdRM11WV-r1Djd2u@kekkonen.localdomain>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-2-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:35PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By having this function as static inline in the header, the compiler
> is able to see if can optmize the call out if (IS_ERR_OR_NULL(fwnode))
> This will allow a simpler DEFINE_FREE() call in the following patch.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

