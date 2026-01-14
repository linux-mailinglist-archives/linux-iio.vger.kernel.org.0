Return-Path: <linux-iio+bounces-27760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A5D1DFAD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4753027DB1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042E38A724;
	Wed, 14 Jan 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA0bMu7N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DD3559F8;
	Wed, 14 Jan 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386043; cv=none; b=hoZvdMrs/RtUkMcoHyYWxq3vx1e2RYKiIZRraF908ZqPEk/kIaFGmfzG1uptWzeOn8+RoFuAY1Vbi41Uz3Tpj+SkoteTR/spsH1SuvTfAX++NdWOQ/TBxbe4IEjMupvthDufd18/5aG/XlDee44gmGn7Yz2R2MO6NMyo+U9tZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386043; c=relaxed/simple;
	bh=27rhnn79mi4x0HCTWsZdx4vRUjdG9pobUuHnHHE+F1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btHeBVEvbPH/Eh1bNma/qreFUiUhggjbEod39o9uE69S5qHZjuSYc3lyf7Fv6NIqWY37VAKgj60PLy4iqh8r/HDmtZrIMFVuZK4JveUv+xtC3blBmiA6o89ZCdAQmwjk0ai7N1/w9OWHwyESroMpULcMDw9WOJoM0i79NRCo5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA0bMu7N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768386034; x=1799922034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=27rhnn79mi4x0HCTWsZdx4vRUjdG9pobUuHnHHE+F1o=;
  b=dA0bMu7NEXcEL5E8oP1s+b0zq3HhknGnBYTWaQIGyuMn+l+8DrYnL6mC
   f68X+5yz/mqxQo3pU3HP7AihtZWLabTx0on61D4s1CTd7fJPEtL8BY8V4
   RL6qsvWEOX3OTac3gQ1MmHi7+djNxtIB/spJqX8p4TjbVMOfitdTlEUcA
   HYNfslmSi7rbtRmKQxAGbckTS9iXDm8Gxz/pogK+ydIXwSr8mRVefXL9m
   NGTIqu5NHsd3g6P3FMtturamUuEANPsf0dRKfFHSi6IzPVkWbPgs9V9+c
   By/Q8oNB9nLqHPOvv3vHXARRJt985lgMCxtAGKBYWAAYy/NslXzWBcqIe
   g==;
X-CSE-ConnectionGUID: cKGwE6s4TVKULruuiFnszQ==
X-CSE-MsgGUID: wAftApgyQ4KOIQSswkdAMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69766060"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69766060"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:20:30 -0800
X-CSE-ConnectionGUID: APZWiNGyTmetARPDoE2BoQ==
X-CSE-MsgGUID: GwqJN1i9TwyZPIJrmct34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208793548"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:20:28 -0800
Date: Wed, 14 Jan 2026 12:20:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 12/13] iio: pressure: mprls0025pa: change measurement
 sequence
Message-ID: <aWdt6RpjLctkOxVp@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
 <20260114-mprls_cleanup-v2-12-5868b0045316@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mprls_cleanup-v2-12-5868b0045316@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 12:05:46PM +0200, Petre Rodan wrote:
> This patch implements a measurement sequence that does not involve a

s/This patch implements/Implement/

This is described in the kernel Documentation (imperative mode).

> one byte read of the status byte before reading the conversion.
> 
> The sensor's conversions should be read either once the EoC interrupt
> has triggered or 5ms after the 0xaa command. See Options 1 and 2
> respectively in Tables 16 (page 15) and 18 (page 18) of the datasheet.
> Note that Honeywell's example code also covered in the datasheet follows
> Option 2 for both i2c and SPI.
> 
> The datasheet does not specify any of the retry parameters that are
> currently implemented in the driver. A simple 5+ms sleep as specified in
> Option 2 is enough for a valid measurement sequence.
> 
> The change also gets rid of the code duplication tied to the verification
> of the status byte.
> 
> This change only affects users that do not define the EOC interrupt in
> the device tree.

-- 
With Best Regards,
Andy Shevchenko



