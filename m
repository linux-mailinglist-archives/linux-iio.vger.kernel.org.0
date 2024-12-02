Return-Path: <linux-iio+bounces-12965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BD9E0B3A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01FE16419B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD731DE3B1;
	Mon,  2 Dec 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDuB9Eia"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC221DE2B5;
	Mon,  2 Dec 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164932; cv=none; b=bfCWT6h/FDAMK2/g5DBxDIoJh0SIsP/r6luIwoP+hDU2pPOoFkN9m4oaVz7bXcTn1bVvPHHBxUX9g/irOcVxkH1qpdqSppCkrgRgj3lxH9cbPyGG+OmOSwQ91Y4LH98MosY37w0Dh+JkWqCwJIQa0Lsmxp9+pZh1feXDnVmYli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164932; c=relaxed/simple;
	bh=L5Ijyy9dZ3Ky9mGp6GfzWtNpgc+FMQNImJC3qA2CI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giT8dSxgyU934ZP4Kojj+hT6ozk+gTS+I9YssKCer5c6turm6QcXBqL41ouo9W939bbjm1c2p+ADxIT6YFbQ31MuQLc4Xn5GaaDNsq8LRa4NM8xvkr8msnDyzGAZUMOO7i4U1Mg2mm696noUHA3pp/MalmiHcyu1RqD1TvCd4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDuB9Eia; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733164931; x=1764700931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L5Ijyy9dZ3Ky9mGp6GfzWtNpgc+FMQNImJC3qA2CI00=;
  b=NDuB9EiaKzA8FAt03xT9fd0u3y+i42kLzJ620Iahfe2ZbqO5pP5fBaic
   I2h1NESJDkAPTpIOp+wdIP7DqsatMWwx74F9arbpsPKeP6EY3WIjdYIhU
   /76tYRleIc9xkfIopps73CH1zVAOecsqrG86qG024FJ5myKpvawkYA5R2
   HQaKhPU/KOj6hzMX37ywUJzChcuDw8XAy9UF+kXVZ+aRiAqoSx6NoIroB
   FZGXYfMMtwHInfUyWtvWb1ke55yw0Bi8DNbpR/m7YOs/qu3UVPUyBDSZt
   EzwoIDe1BTKS9UbrzQuIfqm00vniDVxzBlMKOyM75HW6iqpm522rN1/dB
   Q==;
X-CSE-ConnectionGUID: 2t/L6PDXT42NS0C5KwVVsg==
X-CSE-MsgGUID: JihQGMNMTeWRyebJ0Qlgfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37290703"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="37290703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:42:10 -0800
X-CSE-ConnectionGUID: eLbJ7IBJRkKkFYhiyn4nFw==
X-CSE-MsgGUID: 31XlT2VdThGTfAGMRDIHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93098357"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:42:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIBMy-00000003Dkd-1rrN;
	Mon, 02 Dec 2024 20:42:04 +0200
Date: Mon, 2 Dec 2024 20:42:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: pressure: bmp280: Minor cleanup
Message-ID: <Z03_fBy9PmqDGLg3@smile.fi.intel.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202181907.21471-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 07:19:04PM +0100, Vasileios Amoiridis wrote:
> Changes in v2:
> 
> Patch 1/3:
> 	- Switch if case for better readability
> 
> Patch 2/3:
> 	- Reword commit message
> 
> ---
> v1: https://lore.kernel.org/linux-iio/20241128232450.313862-1-vassilisamir@gmail.com/
> 
> This series adds the SPI interface description on the device-tree file
> of the sensor, adds proper self-described sized variables and performs
> a minor optimization in time variable names.

For some reason your patches still have v1 in them. I dunno how you prepare
your series but I recommend one of the two options:
1) b4 relay
2) my script: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



