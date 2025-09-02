Return-Path: <linux-iio+bounces-23629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70584B3FD54
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BF84884D5
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54B2F83B1;
	Tue,  2 Sep 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC0EUBnf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AB28541A;
	Tue,  2 Sep 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811218; cv=none; b=GJXKROApomwepYtVkawwKzBB5sfQpALb5/NUlCSo9wOnfWyfypnag9kitzdpsflojoWU6DxfxWXqECd6x+rUOy8Va5yT9gPsGHNo5iGS7e4d9hdJKHy1YrWfYLad1fXnseV270LkGJ1wI9/E8dlkXWPmi/7WxSW1NlGN/yOpfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811218; c=relaxed/simple;
	bh=bqhKBbFaxlfNUpOUFZdfQ3oL0LBK5S3VEHPSL8knTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdZ5fyhB3J0zBVLN+zeMD2uBGOS32jZPL9xIUvGVqiJ2thF/OCubMzoZghkG/c/WXCbXU01Dw/rxdnooMuk+haXFD4lAplCnRgdasKCe93LX7Rj9jHe+LsSY1JOjS+9drs/wgo1QfID6PV+U+msesKBrIf7Rrl5R85eGwKT2qK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC0EUBnf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756811218; x=1788347218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqhKBbFaxlfNUpOUFZdfQ3oL0LBK5S3VEHPSL8knTQI=;
  b=XC0EUBnfmMNB4KdOn/MV9gdDib1Z5FFmKn0AJ3bC+EzaSjiimziUl1SZ
   RRNBDQNuXl8RC7qYJFW7Hfc2723Mszsa5h9FIiv8LNJjM6A0PNcrjQo2W
   OC+KnlbNEz7XglIfPjg0BGK2ucP6c5B7HCEsAlK3oG3Fj2vXz4wpmyGn7
   QC48Io6xTobIHuUU9C6c6LjrMTQsUWOnLrdg7Er/MoWV5L20OLR46eXCx
   kESrBnoHuSHjGy/WZ6ncDtjdc/7p3ZaEDXdaG1fE+LnFUB6QlsSblYkzM
   XojCnv3sFt75W3rZ1DmbjQ5B6nWhPNAk9NT2ROmgGyKlzanM4Ex9/IJYD
   Q==;
X-CSE-ConnectionGUID: xBSqz30/S2qTu3UKFaA3nw==
X-CSE-MsgGUID: Q60/psc+ThWaosTUxkmo4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70460314"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70460314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:06:57 -0700
X-CSE-ConnectionGUID: wGl8brGaRp2Au9fh2S0SJA==
X-CSE-MsgGUID: khpair++SS2sFMTJC8qy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="202193796"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:06:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utOqe-0000000AfvR-0aC0;
	Tue, 02 Sep 2025 14:06:48 +0300
Date: Tue, 2 Sep 2025 14:06:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Lakshay Piplani <lakshay.piplani@nxp.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, peterz@infradead.org,
	jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, jonathan.cameron@huawei.com,
	akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v2 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor
Message-ID: <aLbPx8yPP_EgzTmW@smile.fi.intel.com>
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
 <20250827103105.2472328-2-lakshay.piplani@nxp.com>
 <72c3ae7d-cb54-4a1b-a27a-9e673ffaddcc@kernel.org>
 <20250901164717.6cba2d50@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901164717.6cba2d50@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 04:47:17PM +0100, Jonathan Cameron wrote:
> On Sun, 31 Aug 2025 18:46:32 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:

...

> This device does have a novel definition of register. There
> are 4 of them, 3 of which are 12 bits zero padded to 16 and
> the other 8 bits.
> 
> So, I think only way to wrap that up fully in regmap would be
> a pair of regmaps one of which has only a single register in it.
> 
> Agreed though that using bulk accesses is not a good plan.
> I'd been assuming that was actually a pair of registers, not
> a single larger one.

Why is it a problem? We have PMICs which have 16- and 8-bit registers and we do
use the bulk transfers. Yes, we have also an exception when it's required to
use byte transfers to make device work, but otherwise it works fine.

-- 
With Best Regards,
Andy Shevchenko



