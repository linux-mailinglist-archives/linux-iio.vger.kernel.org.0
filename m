Return-Path: <linux-iio+bounces-2771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96985A2D6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104C11F2286C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAE2D059;
	Mon, 19 Feb 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqT4G+Wv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4C2E3EB
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344423; cv=none; b=sz4tLCHTlaakBeA6qzUMSGLwOj3c3Ag1/yPODe0Xavqi2ggrLJzqWFso+VYFevXwhVELSnFqYubRruTTz3xh2hgxje55E9bqOgue1nWnustxBvSOWvaRGa6R45/fOWFSiUsCetucDUEsBV4PlmX8xL+civq7wkbZIWV9cHPcoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344423; c=relaxed/simple;
	bh=g70a9KB39pH13Ohm2nVBfBMk77dBFtA7RZBVrFL5KZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5A5SwfbYXihLR6Bj96JayJpcpFENMcKG8p17iRZh9U0dGpyLSaXTb2VxW2jwbQHd+C6JuWHXPUAv6XtjdcMj6V5QFJAe+5vQeUIV3DroD4CvkKlECzy5SERTQ/5sDtZLJygVSqVKgsnq2xXfgbWCp1mVR1ulRV2bv3PcH4UvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqT4G+Wv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344422; x=1739880422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g70a9KB39pH13Ohm2nVBfBMk77dBFtA7RZBVrFL5KZg=;
  b=RqT4G+WvrW1/ftaUukuje2ccH096QQsiOD5hOwPe+ukle43LJg1A4pwL
   YgP/zT1WQxdozbfpe9AVeduDJAYX7kw2hv3D7OBEmGwMnS9yqxhyYkvJ/
   8jOB/dKWxt0os7jg24kqxEIOkumkHoyFeW/VOMRD46Zv7BMyzXJpDJwGL
   p14pTD4GVP4+RYFtxdamaxKUW8qqNbtihh6VEElYR7QPBjbpa0/73T17I
   vVRZ903W/TxTzjW1EXSOBjoBhkQYlu9CqUCagRVT66D4FwKm/556/Li8Z
   Z6NDOYEsdN9ZDCXEqtpbgDLvJXlNJElyPRiDYET4JcvA1Ele2xXsbC3ON
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5381135"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5381135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912864301"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912864301"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2QB-00000005oZ5-0Qxh;
	Mon, 19 Feb 2024 14:06:55 +0200
Date: Mon, 19 Feb 2024 14:06:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: Convert DT specific handling over to fwnode
Message-ID: <ZdNEXh7u1XdTv_4u@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:27:23PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Andy pointed out that some of the drivers I was using as examples for
> "[PATCH 0/8] of: automate of_node_put() - new approach to loops."
> should be converted over to fwnode / property.h based handling anyway
> at which point the device_for_each_child_node_scoped() handler could be
> used instead. He correctly observed that it made more sense to make this
> transition directly than to improve the device tree specific handling.
> 
> So this series does that and also some of the other drivers that were still
> using device tree specific handling.  Note the rcar-adc remains DT
> specific due to it directly handling maching against of_device_id tables.
> It probably doesn't make sense to move that custom handling over to
> fwnode.
> 
> I included one devm_ cleanup patch in here as I was touching the
> driver anyway.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!
I have some minor comments, but in general I like this series,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



