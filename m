Return-Path: <linux-iio+bounces-25681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1AC20673
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227274043A7
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20026264619;
	Thu, 30 Oct 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhM/ejB8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABA21B905;
	Thu, 30 Oct 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832183; cv=none; b=kLaX6stCeLlGk7JLLp2WxSwyg7rEuk8xkoqVjxBSHdB/s+VXZV1k+ZOoFS1o74FITQkRguKleNZhn9ic3EPaBp3cr3HuD8FLQIffuYgvg/ZN8Ukj4bEs44+OGnVe724opAGf1x4ujGCbgfg5pg6I15hfv7SrVjMyOFMOQYm+UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832183; c=relaxed/simple;
	bh=sN0XCCCUUDLanPFz9Yo1ljiXFWTv5T7AmLNYumDrem8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRi8Xmn/V6XSO9vk5/eaIvbk9Jdhee6v13cOV8OJOGowemR1zKKbfO9LgfdBPfQyElzpjW4j9DxA5xbZMTmbukbdkFQZZXcDrG8lsrw3WP9SKEmkjY2PAoUDm4rSenpOYp28vUg5AVWlnIXVuSRqL0xQyUO9ZwbluoHYvI8GrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhM/ejB8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761832182; x=1793368182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sN0XCCCUUDLanPFz9Yo1ljiXFWTv5T7AmLNYumDrem8=;
  b=jhM/ejB8sKa1uGlvYp8n5ep1mmkEPb5OZyInLCpqAZjPzINiRXct3HYO
   iuoQtuxroHnuRne5h12mtXhIWrIpY1AnXN3hAVecPTigbvO10wqpdQGBO
   GaU4SaZm2E1DGymoaTCNxp/DA/WyoQeMEmldiZWXcNwxoXwy9Qjmyt59r
   1wkPC0AIUCSe2K72tOVeg/CyeDKFnhUNspjqueRXaCKtAq0wALTb0bv/3
   HmcR2M53rv+kBfBNvY5I7JkAbC9cG8lDNRZspTstfjd2Gf0D0OdC/ZQeL
   zytnjddbI+NCpbG97WHUH6CrQePmu4x58quOxEGE8y+KZkVc35y/8ODfC
   Q==;
X-CSE-ConnectionGUID: g+o36qowRDWQBCt1UTogfw==
X-CSE-MsgGUID: Q3kDdFjLQ9+AhGMGKjWlcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63882772"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63882772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:49:42 -0700
X-CSE-ConnectionGUID: 9mT3K1PPSumQuoEE8gxwyw==
X-CSE-MsgGUID: JAwAwIgQRX+eyXDPBIPX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190318506"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:49:39 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vET21-00000003vYy-2hTw;
	Thu, 30 Oct 2025 15:49:37 +0200
Date: Thu, 30 Oct 2025 15:49:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
Message-ID: <aQNs8VVoStUJ6YHB@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-7-flavra@baylibre.com>
 <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
 <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:

...

> > > +       *val = (data & reg->mask) >> __ffs(reg->mask);
> > 
> > Seems like yet another candidate for field_get() macro.
> 
> FIELD_GET() can only be used with compile-time constant masks.
> And apparently this is the case with u8_get_bits() too, because you get a
> "bad bitfield mask" compiler error if you try to use u8_get_bits().

We are talking about different things.
Here are the pointers to what I'm talking:

- git grep -n -w 'field_get'
- https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas@glider.be/

-- 
With Best Regards,
Andy Shevchenko



