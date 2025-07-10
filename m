Return-Path: <linux-iio+bounces-21523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA57AFFDA5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1693D1C44435
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119228E59C;
	Thu, 10 Jul 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZlG7WDh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94412220698;
	Thu, 10 Jul 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138771; cv=none; b=G4wGvxusZjUqtE6ij0P7CGXW2v7RJC/4oogVd9nwE3QM5krZ6TwJBqVeUKmjaCG2kOBfvf2XPPC/oiBsfQTS2VWQMywNUVasRPrJmTP4nE5uILu9QHbxuhlpBScXw+sNnSZG5BBAkWfMyyyU7mmjB5R/mkd8Mx6RLRvMbRJ+ZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138771; c=relaxed/simple;
	bh=qyJAVh062G9WghC4ofr4Zk/CmZ0bxkKFBU+KRtZO3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra3xglOtkaqj9C8tC64ep4FxjxueHl2VY7sMBydfI+Vj7dLJ5ajkZBq14KrhQlty6kANHcANev1uF3u39xKzdthO1eohQ+T+W4YSd/IO9b/VWq0Hf6WUUDR0yLtX8fvGUk53h2eaW6f57IsaQRsWR/OWeCYHKMMUEQiZY4daW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZlG7WDh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752138770; x=1783674770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyJAVh062G9WghC4ofr4Zk/CmZ0bxkKFBU+KRtZO3LI=;
  b=KZlG7WDhA78A9CO2VSgjN+sbUxnWVL47+dt06C4lOIdFUYrIAMyDFmIZ
   /6xESRJyd2mbLAJOZowiGw9UiwCIp9E1OIWQ+GD7mekJVAtKFrdQe3jOF
   WcXeN7bz1lb9ZC8AGIxjIFL6v9unZryGNuxDHqs69QfZCYMEaWOXdVYsd
   tS17lm/+iQCIKTh1fvBp5lThw7MsfHM2/iGhcODGD+Hn3oCe9S6ZdfIa0
   C1N8OqdDVSaVAMAojQK5FJ8X8PK0VnKTfxxE8ley31ZZ0zq4DuA70Y3VZ
   9WONvSXdJIIIW0gWFGwwveNppvADRXT6eWTKU8+Yb+Ltb1IgXQUSwVawr
   g==;
X-CSE-ConnectionGUID: LwGpcpZPTESZU8T7p+0Sdw==
X-CSE-MsgGUID: 0VOxBatSRQijAwA0KzSaBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65863215"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65863215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:12:49 -0700
X-CSE-ConnectionGUID: 7glJjij6R4iLa4hg1dON6g==
X-CSE-MsgGUID: VHkWGpgbR1+iuNTht0xrPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156355552"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:12:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnKd-0000000E9W9-0G4A;
	Thu, 10 Jul 2025 12:12:43 +0300
Date: Thu, 10 Jul 2025 12:12:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: imu: inv_icm42600: pm_runtime fixes + various
 changes
Message-ID: <aG-ECkVpn_fvBEpi@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:35:08PM +0200, Sean Nyekjaer wrote:
> This series was triggered by "Runtime PM usage count underflow!" when
> unloading the module(s).
> By testing the driver in various use cases and reading code it was
> obvious that it could need some tiding up.

> I'm still not 100% satisfied with suspend/resume is calling directly to
> vddio_enable/disable. In my mind it should be managed by pm_runtime.

This patch series touches a quite sensitive area and needs a good,
comprehensive tests (better done independently from the author).
What have been done so far?

-- 
With Best Regards,
Andy Shevchenko



