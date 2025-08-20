Return-Path: <linux-iio+bounces-23069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D0B2DFF6
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C64A7A8FB8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE131DD97;
	Wed, 20 Aug 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgF4Q5zM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742803093BF;
	Wed, 20 Aug 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701489; cv=none; b=BoFhdLffVveUSuACShDXGK0cPNuOpIPL0qNd6ADPTSUrsy8hyPoeZEl+k6viiUn4+Yg+bNy2SUpHVwtdvmkI0DNBkmcx5ltQQ0Kxue9gw83rpME+5mPMdvq3ur03S4iqz9/IaSLcuFBEZdruVEOHDFG4vdO287Hnd+1fjsgkYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701489; c=relaxed/simple;
	bh=N7zy48vZoxPqIr5ffMMTY09NjXEde8BXKpYNlHhpxzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlPcPXT3XVA6k+R8NZs6ydZBrg0sG+kOsCBBVPSqIUR9phqTLB0rUVXLYhZjIlllP6l7NqeyZ2/eRoR6DW+yB0dqu0hd3T0w1KnYuZa1tZjkrrpYXxZPVRsZEa8Ciw9kub5RkO4q2cg7HXS52HqyI/DIHYkdqn/PqiTRj41SPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgF4Q5zM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701488; x=1787237488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N7zy48vZoxPqIr5ffMMTY09NjXEde8BXKpYNlHhpxzo=;
  b=dgF4Q5zMnS2zl+Cx83U1JnW2k+Fx5+q14MfhE/xbGZbr02tElDDSZcrx
   9yvmCX+hh1Hs99fbN/fzkbygLBSCn+8XP3FgN+tiVB2HeZjxllhCoptBs
   SPH3RZd0Pi68rkeMqvJ9n7krrAsvoCk0gwsfCmKgJKPyumMLJ+8DYRYri
   TdQgVSYGp6z0sfpkLzpkYXEDOcQ7JnpadkownTVsudWib7WtJwWRAEP8j
   gkHIWkjE9LdaaCdxQvFLCbF5wRYPwelGc9aTf1I8NdxMGVG2Z/UZGYNaa
   asTlWSMHhdrr9Ftealf9v/gJEe2ImFR89FAjgbeFEg1E3oB+iZEHcZsr2
   A==;
X-CSE-ConnectionGUID: TiBNwVAOSBelKJDk+zk9KA==
X-CSE-MsgGUID: guO6RvhPSKm/45wK20RA4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61798976"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61798976"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:51:28 -0700
X-CSE-ConnectionGUID: bug6ieumSQeiF1lzsjovuw==
X-CSE-MsgGUID: lzsGCcVUQNenDWXFGcd0WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173496824"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:51:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uok9r-00000006xm7-0dDq;
	Wed, 20 Aug 2025 17:51:23 +0300
Date: Wed, 20 Aug 2025 17:51:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 3/3] iio: pressure: bmp280: Use
 gpiod_set_value_cansleep()
Message-ID: <aKXg6h0nW-GMcy1m@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
 <20250818092740.545379-4-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818092740.545379-4-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 18, 2025 at 10:27:32AM +0100, Salah Triki wrote:
> Switch to `gpiod_set_value_cansleep()`, which is safe to use in
> sleepable contexts like the driver probe function.

The commit message is unclear on why? aspect. You need to elaborate that some
GPIO chips may be located behind slow (and hence sleepable) busses, such as
I²C).

Code wise I agree with the change.
With amended commit message
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



