Return-Path: <linux-iio+bounces-25243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14258BED553
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9984EAEBC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E3217722;
	Sat, 18 Oct 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z41LoTlP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B701C27;
	Sat, 18 Oct 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808645; cv=none; b=h3fHt9weCPgd8Gv6FerhmS9mgO3JIaTt700DsLtQt2JprxkgsGfaTKQVE+lmk112DU/WqD5FPJYPlGIDW/0u8On1y7HCSbuTeU5FMSx+b289tonSJB0/Jgd83P65oYKJT0Zs17KN6gTI9hTf2WfUDivHSY7LuuUj1X5uo3e5SJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808645; c=relaxed/simple;
	bh=lIKzaIigJZcdjRgYgnV5c8PZZ3V9sFEMaoxvbm3mXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHqGmqmeUTAJeydb6nA8YgJJVIGZkKJFKd+EF7UbHvIJCx9PlCBdKB+49u2zX/XvYW29d0kKtTkJ5bjC8cwOfD3s+mGrtMbmKmN5QaUKB6sF6GFKQ4AvnxsnMXV0yrKM7adynIs4adYFAuNm+H1Z2IDLkWfNHDz17nYYZBVIEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z41LoTlP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808644; x=1792344644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIKzaIigJZcdjRgYgnV5c8PZZ3V9sFEMaoxvbm3mXf8=;
  b=Z41LoTlPV+VNKfL1GLcam6EktWYwFUU2ajryqena1QtO0LfNUzr+cfgR
   kXBM51ItV/jr2bUErKIX73fBHJQM5wnSFjA6myugQk4ZlQpbx4UtQlB78
   ukuAii/i6Q9oE5YbYH3ibTsio4VO9Apysiq591I0utOHDgDpm/atszyyp
   nuQBp+RGpFqNPKP2DeBuReGxOAXsHDv3K7Mu7d1ztjhnkL5kEPVeObssn
   yXqpY6W5yswN489Kfv8D0zmUn+hc/1qtT5gEWI8gDy3xQ2XuLnSjr3LtI
   GCuG19OrGIdnXuXNIBNkIfaZoXbQA9R0y/VvMzbQdVNYXw3SyyVNZ4kh/
   Q==;
X-CSE-ConnectionGUID: zxEVL4J+R1ys6iVtzA7fBw==
X-CSE-MsgGUID: l3i/rS6fRYeFp5CO9dQ46A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50568007"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="50568007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:30:43 -0700
X-CSE-ConnectionGUID: fk2tr0z7TyikyPC+PyaKcg==
X-CSE-MsgGUID: U86ZlkAhQQOrmCSbsLG26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="220131328"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:30:39 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vAAlI-00000000s0u-0xwn;
	Sat, 18 Oct 2025 20:30:36 +0300
Date: Sat, 18 Oct 2025 20:30:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix array size for
 st_lsm6dsx_settings fields
Message-ID: <aPPOu431u8MPUN0p@smile.fi.intel.com>
References: <20251017173208.1261990-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017173208.1261990-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 07:32:08PM +0200, Francesco Lavra wrote:
> The `decimator` and `batch` fields of struct st_lsm6dsx_settings
> are arrays indexed by sensor type, not by sensor hardware
> identifier; moreover, the `batch` field is only used for the
> accelerometer and gyroscope.
> Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
> ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
> ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
> definition so that the ST_LSM6DSX_ID_MAX value is usable within
> the struct st_lsm6dsx_settings definition.

...

> +enum st_lsm6dsx_sensor_id {
> +	ST_LSM6DSX_ID_GYRO,
> +	ST_LSM6DSX_ID_ACC,
> +	ST_LSM6DSX_ID_EXT0,
> +	ST_LSM6DSX_ID_EXT1,
> +	ST_LSM6DSX_ID_EXT2,



> +	ST_LSM6DSX_ID_MAX,

Is it a termination entry? (Looks like that to me) Can we drop trailing comma
while at it?


> +};


-- 
With Best Regards,
Andy Shevchenko



