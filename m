Return-Path: <linux-iio+bounces-14512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEFA17729
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 07:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DEA169E40
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203515098A;
	Tue, 21 Jan 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daKNx3o5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E63D6A;
	Tue, 21 Jan 2025 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737439323; cv=none; b=oAjLPFfpIf6eGdfMFNrYd5rMdcRaB388DggNEfCqoVy1fxdcTd2+hbCQqfgkJdbPK9nWq8qG7ktvAmfaF/Gd679J+KMuYNSeffpwR2Hn4CSJjz7RMOz8HAmHXTkksxwmGRZboNKa3dmAgWT60pGdeMzzoFWHp6iDGVSUzF2AcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737439323; c=relaxed/simple;
	bh=vaaUEIPAxsKm7EwB3zdsDCaYUV0qUpeOfKo3pV97sBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVd5wMPTVlJDoSh+zwfDqyOUFJPRjLTXUt7o8n2bBhimI2yKRel15qfsy570qWKhJcMSprvs8TnfnKKtLgIq0lKQhKsBXLSscFoWoC3XkPD69vPpdjg1qmvwHcWWy25uqD4mWuOMHyHT0hs2B7KElZkol8Ja/dXpHCW9uSp71ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daKNx3o5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737439322; x=1768975322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vaaUEIPAxsKm7EwB3zdsDCaYUV0qUpeOfKo3pV97sBo=;
  b=daKNx3o5d5TGQT4BgYyFPqmblpe3nuwyimqrcE7WR/rty/2KYmFqh9HS
   O56nQfXkI1mwS/m4ktsY2OIlYPfDXqvGnOrMb0UO4iK85SNC306OLnWGr
   /CSnlwW3slUQbVCA6TpnPuBt+2HvADWmZk4xK6rkmnwICq0rHxhJU7i/2
   rfK6aZguWhfAcV7XIV8E25qCCggRYBPIIo/QfDdXabE/qeVELNR6Dw9ng
   dgNlI7McAxt0r6t7iT26CYD4d63VBZxUkMkXQ7PufRUkovZ4rVVbpHNYD
   uZ0wkytkPZTLMhSfmJ2UNT2TCxV413lLcpkuzvsOjbxfruVyr9vPpUhVP
   A==;
X-CSE-ConnectionGUID: ybpTyzpwTBGWc0VlxphlQg==
X-CSE-MsgGUID: 4oteCQeOSnqHqhZtQmZOug==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37712236"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="37712236"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:02:01 -0800
X-CSE-ConnectionGUID: BhkotcLXRmSYSJi6AEv/Tg==
X-CSE-MsgGUID: 5GqFI0gESImNW0s6J2NG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111799349"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:01:59 -0800
Date: Tue, 21 Jan 2025 08:01:55 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm9ds0: Replace device.h with what
 is needed
Message-ID: <Z484U1gDYolJ8CAm@black.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
 <20241203195340.855879-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203195340.855879-3-andriy.shevchenko@linux.intel.com>

On Tue, Dec 03, 2024 at 09:48:52PM +0200, Andy Shevchenko wrote:
> Instead of including a huge device.h with tons of dependencies
> include only what driver actually uses.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> index d03cec3b24fe..2b1b57761688 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> @@ -7,7 +7,7 @@
>   * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   */
>  
> -#include <linux/device.h>
> +#include <linux/device/devres.h>
>  #include <linux/err.h>
>  #include <linux/gfp_types.h>
>  #include <linux/i2c.h>
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> index 69e9135795a3..d3bfd74a69ab 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> @@ -7,7 +7,7 @@
>   * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   */
>  
> -#include <linux/device.h>
> +#include <linux/device/devres.h>
>  #include <linux/err.h>
>  #include <linux/gfp_types.h>
>  #include <linux/module.h>

Isn't struct device still used in these files?

Raag

