Return-Path: <linux-iio+bounces-12818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F79DE93C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B01B226B3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6721448DC;
	Fri, 29 Nov 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWMWmtWM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29013D8B4;
	Fri, 29 Nov 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893630; cv=none; b=IMIiJIQMoge6cvtt4IvQxwGvPuHdHcDQNkuo3zqHpFXIRT0h9IFH8O8wjnHFbVP5asJfFFdPiojjyjESkoukXS5RI4hsIGM7cpdqMY6UzN6vCCeEZPuFJWPuEktQyLFwhRRXgjS++NTmgpVuni4yvKETlYPIYS2pwwUQlbh053M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893630; c=relaxed/simple;
	bh=qXahpijGJKBH0HbN3Bqo3N9btobuZwZdWHQjVzlv1Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR8qo0cg9ZFi5du5IEIi9lC0AcTPfSZbzCYiRtk1ICarK5x2lYaqYYA4O0/DTvVBCw0vL2MDZtKz6wpOMj18CTmVZqLl0xe26zOuHnY+jsL5+fQYaVeDSueFRwbiC8BE16/K5fxnfYWuHeHfmn8S5AyvrJFoD0HfG7aGQJzTGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWMWmtWM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732893628; x=1764429628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXahpijGJKBH0HbN3Bqo3N9btobuZwZdWHQjVzlv1Ic=;
  b=CWMWmtWMT4U9IKkUO+LnftE52Kb93QwerbOzSc5GS+UygJeyWAO2Y0LD
   oQH9H84nSc1wnBQ6Kentg9+yrygpWtceiQ1tYrsFxss9uhUOK5ujeF7Dz
   k8wrt1FprgE7pFk3zzv9N+KP36TMTVVlpWtOQGKOxc/4AtlVLJ4zX5K77
   rSEaAEnV3eRvjSxF3ALaHdiVEwpPfseozlx4IkjLVLB6ks4HQyl6FuZ4V
   2er+NK2LOoOGqbWHfm5XbV8NppEaw0xykypL1eF3eOKvdDD50NNKgiqG3
   g8gCUyzNCM7Yux2/xWimkALAk4S/jiNYHLPiS14c/mzH5fi8HnjTexBSt
   w==;
X-CSE-ConnectionGUID: ZptXjBAZQAmpCdcTJdLB6g==
X-CSE-MsgGUID: Wk+AEuLDT2eAisEjhmqD1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="35994222"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="35994222"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:20:27 -0800
X-CSE-ConnectionGUID: CdVdRtR8Stix2buKHgq6Tw==
X-CSE-MsgGUID: QC37+fmkT4md8164xOhxDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="97616809"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:20:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH2n8-00000002HDH-1Q4s;
	Fri, 29 Nov 2024 17:20:22 +0200
Date: Fri, 29 Nov 2024 17:20:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: pressure: bmp280: Use sizeof() for
 denominator
Message-ID: <Z0nbtiVeKuTV5Amc@smile.fi.intel.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241128232450.313862-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128232450.313862-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 29, 2024 at 12:24:49AM +0100, Vasileios Amoiridis wrote:
> Instead of using magic number 2 as a denominator, make it intuitive by
> using sizeof().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



