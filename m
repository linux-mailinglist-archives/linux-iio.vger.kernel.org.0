Return-Path: <linux-iio+bounces-27403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48CCE542D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369A9301CE86
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0D227563;
	Sun, 28 Dec 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esVgcnsP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206001474CC;
	Sun, 28 Dec 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942473; cv=none; b=ajPXvsCgqaDIxFk7V1jo+7fXCho2wtr1dP5yCWl6Qsj40IWB3M3PHeqhtGkMHSUsVlxhhY543PsiKuHoJAF+UJl/PT8AcmYD1O1eWdCuZpDMlkvfSq+T/KuGCBPeqk2tHUUdSq5BukZKOccnx7A62SBcKjNwkvCvvGz/w5S1DSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942473; c=relaxed/simple;
	bh=q87EbX8pyG8YOCPcTGt0Mal3CRSYfu+2wAoWf1IRCZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MebQZH/GMHbpcLOvuUMl5xJGgzY4hs/2X+biFpzPtPMow9HgQFelLOrBnmBsAug2InDRx/sPR8+iUX15vL2ZnA5LOTaEinfQZuBNLq1L7/8PasHqnVIgwgM8vg7fArZi70I+cKpVyuUhyc0XxAfeIcJDNS7rl2RWtU81C0Vwweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esVgcnsP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766942472; x=1798478472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=q87EbX8pyG8YOCPcTGt0Mal3CRSYfu+2wAoWf1IRCZg=;
  b=esVgcnsPOI6suRE3YFvygi9U6LX024vP5mFjvwzfmLN/RSg1D67JxOrY
   NaMa131itZgiqCQw6zHQE788+c0mvG699poAhJGd85CutWnZygrNg3TgE
   F/t4xFe96H6FbRgUKHRPelM9bm2aNok8Zc9Ujx6XFtdTecULaDGWmTgek
   o2hkU4IRujquwzL6iwqb1ZDbkndSjJPEFWdEQ2Pg3/vBFd/4Nh73p314R
   VxOfSbz+d1M8bn6uyPwWcXJzuhkMI/OErsAPOLxmyh8iHJ+QtvMuSTIDx
   sudq2Qhz4W/G8RaQCE8gF8+Q3HJl8l9IUfukprRtUS6ztnGHOUgUQMcIf
   A==;
X-CSE-ConnectionGUID: XoLROQt0TZurXaFXWJH2Xw==
X-CSE-MsgGUID: iQqI8T+7RuKmDOIMYZ/fJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="71164636"
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="71164636"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:21:11 -0800
X-CSE-ConnectionGUID: 3mPolWyIS5yj4mUdorvCeQ==
X-CSE-MsgGUID: oQcD4IL4S3WpyeJzWFi53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="200378212"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:21:09 -0800
Date: Sun, 28 Dec 2025 19:21:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add alternative ACPI mount matrix
 retrieval
Message-ID: <aVFnA7mrVY_WBQxx@smile.fi.intel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
 <20251223025351.3099978-4-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223025351.3099978-4-samuel@dionne-riel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 22, 2025 at 09:53:51PM -0500, Samuel Dionne-Riel wrote:
> This uses the SLA0 matrix, which is how the SMOCF05 configuration
> exposes the mounting information for the accelerometer.
> 
> On a limited sample size of one (1) unit, the SLG0 matrix is the
> identity matrix. It is unknown how the SLG0 mounting matrix would
> logically affect the data, if it differed from the identity matrix.
> After all, the IMU is mounted as one single unit, its mounting can't
> differ on the gyroscope compared to the accelerometer.

...

> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2707,6 +2707,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> +	if (!iio_read_acpi_mount_matrix(hw->dev, &hw->orientation, "SLA0")) {
> +		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> +		if (err)
> +			return err;
> +	}

Seems that Accelerometer and Gyroscope have different methods, also the I²C
addresses and interrupt(s) are referring to the respective names in Vendor
Data fields. Perhaps that makes sense to also implement.

I,o,w, I don't think this patch is correct (place to put things in).

-- 
With Best Regards,
Andy Shevchenko



