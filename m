Return-Path: <linux-iio+bounces-27759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D956D1DF82
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AFE03053284
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D138A716;
	Wed, 14 Jan 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOL5VZIJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78038A295;
	Wed, 14 Jan 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385706; cv=none; b=I/EPV1IUGw5Wm5Eu/WhKmXzEGGGTLT5tpuQYEwYlzzpEMchhy5T5+mPuIligPS6dBYqSZO6Oi9GzaDw82pE0m9uo9QGdbu3hOIquqnaDkNQNt6YG8v+l53X3TM+ey1c5WhsuFx55c4/uvs5MTZ2819cui3DYrjiMLp/SkBnVwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385706; c=relaxed/simple;
	bh=5wqBT/bmdBt49CmD4zjJqAc61AtZQtiHsVxipG6TAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE4eyclCRS0gmqwNjECM3Q3+WT+CBFw+L+W7vioAVcfbVRtFSXUmPzg9sITK6pIsgrZmBvhB82r0Uq0Q3I6Z7kObpIQsJuITCg5RInWJR3MmE9p8+1JI2TJ4/d7lBfWfBvb0GpnIjHhS0T+wC3gSksh+/N/nBvPKTwertb5e7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOL5VZIJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385705; x=1799921705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5wqBT/bmdBt49CmD4zjJqAc61AtZQtiHsVxipG6TAok=;
  b=OOL5VZIJUdwwElhzHwPFhSHJgcUhKTWkTdLOLv8T4Kjt5lddl7IcNt2o
   fjSYVK0zP2XCKdgHl/eF7QC/h+576mskHWwdRdAKdxg5WLg5r/NTNX+WX
   UTKd1e6MLX21ScNYOoA2Qp5Fd0A9fMiQxrAPdwMdXWdeUKO3sK8mIAXRr
   PMNYp1UzfV7Dxq78/gz6xzWyDySjOvPWXr6QeegNbHqk05DfCVH1Oo1uJ
   sDgfythSSuBpkWUCRRWa1WJJ+DOkvaidAYyWnl+cA4IxtKmoMOa7yn8mO
   ZOgVDVzhJEY8PdCH7idADfmg3ctj2FdkLOKcQG9IKE14/83zsWHyfmfx3
   Q==;
X-CSE-ConnectionGUID: 3gaLqS6kQAewcPRlOEEE3w==
X-CSE-MsgGUID: F4lxCdzHTDydO/Gzdcjudw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="92351307"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="92351307"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:15:04 -0800
X-CSE-ConnectionGUID: aK5vZ2t6TJWURuugzydd7A==
X-CSE-MsgGUID: ISCNKrdHTUaFi77V/WF1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235892925"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:15:01 -0800
Date: Wed, 14 Jan 2026 12:14:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/13] iio: pressure: mprls0025pa: fix pressure
 calculation
Message-ID: <aWdso0jjRRdEpcAC@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
 <20260114-mprls_cleanup-v2-5-5868b0045316@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mprls_cleanup-v2-5-5868b0045316@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 12:05:39PM +0200, Petre Rodan wrote:
> A sign change is needed for proper calculation of the pressure.
> 
> This is a minor fix since it only affects users that might have custom
> silicon from Honeywell that has honeywell,pmin-pascal != 0.
> 
> Also due to the fact that raw pressure values can not be lower
> than output_min (400k-3.3M) there is no need to calculate a decimal for
> the offset.

...

> int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)

>  	struct mpr_data *data;
>  	struct iio_dev *indio_dev;
>  	const char *triplet;
> -	s64 scale, offset;
>  	u32 func;
> +	s32 tmp;
> +	s64 odelta, pdelta;

Please, preserve reversed xmas tree order. And in general try to stick with that one.


-- 
With Best Regards,
Andy Shevchenko



