Return-Path: <linux-iio+bounces-26939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FDCAD446
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CC43071AA6
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35DE313277;
	Mon,  8 Dec 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ud0e8hqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA21E5B7A;
	Mon,  8 Dec 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200449; cv=none; b=hPZSlpSffC//JaE139pXd4SIqDMVu4rRhruFwUHfcBLRGj9U7e444MAIojl8w6yBF3RSLVWfxLs0s+/mcZRFlSFt+UQVY3WGIff4xAUOu83DIgSuuJIc1DQwvoGHbTOH+QxLbvAzdtaDNvhBEOr3UdmRy6mUnKRw5esfyCEtba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200449; c=relaxed/simple;
	bh=XMTcb1/gYnNP+8nq0VZfYw0+4rpEVrK7AEwVB73HoVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzOnzxn/ZPAwQqW/oh+HwVsZIKtx1EIC9iJHLE3rqDFbc1a9xJQ5uB/T91aPwlE7arRXjQtp6RrgqqL47AYBNWaI2CRwHTNauEQx0wsQCR8tpTeSGyoWolG3CecljDBMbG1RTfLXIfaduB3/2TzWNkqZwTS3Fcm+gWrSjSTkeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ud0e8hqg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765200448; x=1796736448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMTcb1/gYnNP+8nq0VZfYw0+4rpEVrK7AEwVB73HoVo=;
  b=Ud0e8hqgHdx1iKKnOuKELIskLy2XKSzDuf5GuBy1ga07cOLDvEPkSLi/
   7pIsj/qA9qZ3HxGgv8iaXGr1ZVYbiBO1ecWTs07Jp+He4HyvCE57T0yz2
   k+u8MjL3QqvnVpwV7BcvNW4vVaMsXoa8ySoibtiI5ZYocqXSL4Lwhgjjh
   swHjnJUoz1y70dCqqqCzQ9qhjJ9ePGc/j0TKof8/v+47pM6Mh7PzrgdWV
   8Yk2O9TZTzipQLyNB5FDY4CNycXPMvsjoBQLBjqu+7Sogh5+ufjhux4WS
   mPYGHwrzdir69WQWKmVDjvl3YIpVuGtKai3FuCrU6kz+ZBVOz6rCU6XJy
   w==;
X-CSE-ConnectionGUID: jj7VAv/nRFS5o8C4IaA6+A==
X-CSE-MsgGUID: APD8K9vdS96QSSPQ1mSUxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67177426"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="67177426"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:27:26 -0800
X-CSE-ConnectionGUID: /dg/rHMcQiCBkNmYiwrxIw==
X-CSE-MsgGUID: n4Mt4cwcRPiqVSiG4Yj4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="200400681"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:27:22 -0800
Date: Mon, 8 Dec 2025 15:27:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: ad9467: add support for ad9211
Message-ID: <aTbSN22rSC55G-nd@smile.fi.intel.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-2-c49897fa91c4@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-add-ad9211-v3-2-c49897fa91c4@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 12:30:58PM +0000, Tomas Melin wrote:
> The AD9211 is a 10-bit monolithic sampling analog-to-digital converter
> optimized for high performance, low power, and ease of use. The product
> operates at up to a 300 MSPS conversion rate and is optimized for
> outstanding dynamic performance in wideband carrier and broadband systems.
> 
> The scale table implemented here is not an exact match with the
> datasheet as the table presented there is missing some information.
> The reference presents these values as being linear,
> but that does not add up. There is information missing in the table.
> Implemented scale table matches values at the middle and at the ends,
> smoothing the curve towards middle and end.
> Impact on end result from deviation in scale factor affects only software
> using it for scaling. All the possible hw-settings are also available with
> this implementation.

...

> +	.max_rate = 300 * HZ_PER_MHZ,

With this change applied, you may consider adding a new patch to convert other
initialisers to use the same approach for the sake of consistency and making it
less error prone (easier to count up to 3 digits than zillions of zeroes).

-- 
With Best Regards,
Andy Shevchenko



