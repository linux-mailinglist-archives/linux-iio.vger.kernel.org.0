Return-Path: <linux-iio+bounces-18330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B52A94427
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3E13B8F18
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A71DE2DC;
	Sat, 19 Apr 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrEnSkui"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EF86338;
	Sat, 19 Apr 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745076220; cv=none; b=ErXZu2mtgojqMjjNjbO4xWZY3Whx1g/4dPi28khgGCjWVngf1tZBXxvZWtXSIoVyqZXSEiXpeDGBnhk2mTqZmpPekcXIX6efPAM6UTS3hotWvGgFuQf4eQJY7/J2u8ljr69bn+mG/WbaOVwY8leefh0r8mtz1JZdXTOi6wgH6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745076220; c=relaxed/simple;
	bh=jKx3xVhsHVOtER/pLqrjsPM2BE1BLfp7Mcm2zgmDd1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4SKKcES5xEvTeQBpgg5dBou8QeEvYEphfSkgrBYxPuiQEZtwqejfnCs3SevQ+VQyjODQdjF6Kgg/HevOzgphDcYpI9GzsFq+r0O9VFJhgsF6wm0XJ7QUq+8uNJxB11QAp1aVk3ra5DVavOXLHMjEMro98gTkAs3sClayC2wMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrEnSkui; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745076220; x=1776612220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKx3xVhsHVOtER/pLqrjsPM2BE1BLfp7Mcm2zgmDd1c=;
  b=hrEnSkuilUw13tQHADD8YYj2AdaaW21M0/Gh8vUS6qQCrHbbaCFTMHiJ
   VpNSOXF2VccDaeClmUwVDbG+fcOcBDrOXFIvnyMdeUE65OZroMfGRlG9Q
   jAdfe0AZqkLmkT25Hdvc4tfAWswSy6v4cG7DjjtPmKNi4+TpwUeav/TKU
   1IiDut6Gw47/ZHvz5ozIf4R+nQXaypwpbEXK8nCwvbhceg3q7s6VFR0CH
   FNRubIzbck6lkUmdGNSYTywxuS3C6+IFDNK/HqqUi337mA71n1FisdDXv
   GzXLIRGNQcFTMxZ7505y1L9mI9Olb0RnRk/KmZY6PjxMdWrEgcn4MXgrS
   w==;
X-CSE-ConnectionGUID: P2PVXL+yR16JkjO42O8NYw==
X-CSE-MsgGUID: AlE8zcwwS8WT3ztoJNBdSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46597031"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="46597031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:23:39 -0700
X-CSE-ConnectionGUID: qoW8PW5/ShazG6pX3wtPpg==
X-CSE-MsgGUID: qkcI1+AkQMCWDZtIWUrO0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="136165710"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:23:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u6A2U-0000000Dqmi-077r;
	Sat, 19 Apr 2025 18:23:30 +0300
Date: Sat, 19 Apr 2025 18:23:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eason Yang <j2anfernee@gmail.com>, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
	gstols@baylibre.com, alisadariana@gmail.com, tgamblin@baylibre.com,
	olivier.moysan@foss.st.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, joao.goncalves@toradex.com,
	tobias.sperling@softing.com, marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com, herve.codina@bootlin.com,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aAO_8d7j-KgxbmKU@smile.fi.intel.com>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
 <20250416081734.563111-3-j2anfernee@gmail.com>
 <20250418171326.07634113@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418171326.07634113@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:13:26PM +0100, Jonathan Cameron wrote:
> On Wed, 16 Apr 2025 16:17:34 +0800
> Eason Yang <j2anfernee@gmail.com> wrote:

...

> > +	struct device *dev = chip->dev;
> > +	__le16 data = cpu_to_le16(NCT7201_REG_CHANNEL_ENABLE_MASK);
> 
> Assign this value down near where it is used. That will generally help
> readability.

Actually it is a good, but not a main reason, the problem with this style is
long-term maintenance when some code may appear in between and become so long
that one can screw up this assignment at some point.

-- 
With Best Regards,
Andy Shevchenko



