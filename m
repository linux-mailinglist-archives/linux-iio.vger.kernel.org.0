Return-Path: <linux-iio+bounces-2808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963085B338
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 07:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDFF1C20C6D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442581EB27;
	Tue, 20 Feb 2024 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG98GoAA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDE1EB38;
	Tue, 20 Feb 2024 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412151; cv=none; b=GH+/9nPodb131DR+5MplduFEyzEicHsDtzyoULL4MCr+4gVXtxaWd5IL3XSvEZpWT1356fPo5tBnyxqmRXc62TgYeko/OBAPwEFADAzgMbWxfh6zM7dFaZX7m04OJGHsMvrzCFQR+uPaGoy/DSG7wcyN434zd1U2oIqUZhzmFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412151; c=relaxed/simple;
	bh=Be6CVYvpuxyTMQF7JI0v7EwFajEEOSdq2YOUD/ZTjdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChOssY8rDZXKCCGlFZl/BoiGqJKYXJ/4pQZRlkF87SmRw0oN4Dy0pUfE3iPVPf1qFr9sGU9VrPnID7/UMnbifMgyeZEBvxTeUJdGIgceHvgNctyh/EiQ6JOCChqn0a8HkdcVzjkALpjrgiKRAodix+oSmtVd1yrgtZcsYkqNmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG98GoAA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412150; x=1739948150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Be6CVYvpuxyTMQF7JI0v7EwFajEEOSdq2YOUD/ZTjdo=;
  b=TG98GoAAyCTbjn/YRlWvd+I3GgOiOROdPQaddYTbgSjUuTasdXnsxVtQ
   Mw54WrLXoVre6WppDpePuEZheo8TBgr/EO/rUiczwQE0CP0+E6LXWPZUG
   qjsDLRBQaqqytYQ0IzWKKHv03xHiZV5S3vs3IOYTcz567aPqfNL27lY+R
   8/s/XS8DSTM+dc0ikiRz6+VpbzuQ/2OT1IqVt9u6Q86n5fV4PeC9xLULL
   qkfgojcthPyIDJbsHzM5IVbE6HzJdYkbNStUQI3R+FC9I6zVi9f0PviYi
   moeuwLFqyBmEDpmjBsuMDuq4+ka2Tc9d5kRMWLC9BNjfVmQV/nS834KWS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13054410"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13054410"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="42179925"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:55:42 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id ED0DF11F7E1;
	Tue, 20 Feb 2024 08:55:39 +0200 (EET)
Date: Tue, 20 Feb 2024 06:55:39 +0000
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
Subject: Re: [PATCH v4 02/15] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <ZdRM6-RB75dZZxN7@kekkonen.localdomain>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-3-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:36PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Useful where the fwnode_handle was obtained from a call such as
> fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> and will automatically release the reference on the variable leaving
> scope.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

