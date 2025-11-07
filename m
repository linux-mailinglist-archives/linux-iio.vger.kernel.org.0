Return-Path: <linux-iio+bounces-26012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4987FC3F3CE
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6953B3BC6
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB96305949;
	Fri,  7 Nov 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHD/N4Mo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A633054E4;
	Fri,  7 Nov 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508671; cv=none; b=FI6ZFDrV5fyes/Oc/6C5pMRXu5Nxw14dygrB/RP/XWCl4RXiIpbwLpqynN+VxREVTZ3A5MAO4EJHqQ+M0K/JtKBGjhFJbCFXBnyzd+O1VdkL5uqoJPEwdDU29WMg/1dRPbuh9JLX3Fz5FoAVKlaMqqZGA5xA7aVdE4MQdJTqvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508671; c=relaxed/simple;
	bh=HeImgwmqI5Xxh4kXHCdMK9Vu3Gjea6W4SMp3xb6vOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWEnxS/+iCtTOjpr9woK0/sGeaRGK/AgEYjDIhDrKoeB1QDtcMHQkPUmyXrqLmkECT/Uyw91X0gSyTCzMGzz6vfDq4ccaINyZTbZPpeE2DsX2sGs/K6wLWksDXVnX5fY2kON19XR76Y48BV3AFp+R2hXdsLtKgHFiMUziTA687Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHD/N4Mo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762508669; x=1794044669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HeImgwmqI5Xxh4kXHCdMK9Vu3Gjea6W4SMp3xb6vOWY=;
  b=YHD/N4MonnffwQCgA43ZqgaO27MSaCImhjBl4eOhuRdte6v0dp1B3CZn
   KkpH5p0BxjZehs9QTVMlL64YLRg9QC4VeaAjtqy9LcbWyJy6NfRdTZJ6o
   jKOeGlO2QVoQz6SWf/BAQGp6Ab3NvMefESYw+1joAUERWMHdGgV/7vkK3
   0WhMyZmxIMozohBkTvHnHzmGjPTOvTm2m6SyfjRIi6MWyC4LqpHl3jACH
   jtTSplE+8n12DClrZrjgMaHGodjqE8LtV/j6GPv5oyIv+HF8k/CouzoyB
   kepwiovYKrQN9wt5aTbAWzalfDZ7Rd4MCMddhuJ6ky5V6OpU40FuhiTHR
   g==;
X-CSE-ConnectionGUID: r5emiBTnSQyZfxb55f4aKg==
X-CSE-MsgGUID: El36jitiRKSr2CpTvr3gvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64695129"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64695129"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:44:29 -0800
X-CSE-ConnectionGUID: 9Cy/uejiTU2pxWlcxBtQNQ==
X-CSE-MsgGUID: oaiYB27ESNCK8jfmeNUXuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="188718864"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:44:26 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vHJ15-00000006QFB-45d5;
	Fri, 07 Nov 2025 11:44:23 +0200
Date: Fri, 7 Nov 2025 11:44:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Message-ID: <aQ2_d4r7gwwxjLHs@smile.fi.intel.com>
References: <20251107-icm45600_fix_buffer_sleep_init-v4-1-5648fbfb57ad@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-icm45600_fix_buffer_sleep_init-v4-1-5648fbfb57ad@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 09:13:58AM +0000, Remi Buisson via B4 Relay wrote:
> 
> The sleep variable in inv_icm45600_buffer_postdisable could be used without

inv_icm45600_buffer_postdisable()

> being assigned in case of error. It must be initialized to 0 by default.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



