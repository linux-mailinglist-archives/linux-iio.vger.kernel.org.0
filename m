Return-Path: <linux-iio+bounces-25719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315FC23B55
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E5ED34E79C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B53132D0E2;
	Fri, 31 Oct 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaZUKr8O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18962F3C25;
	Fri, 31 Oct 2025 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898166; cv=none; b=go/74rPPpTZHJUQ6vdhH7Hqs1in2pZZUYNg2SntWk+1rzyz/dxiEm6hQaMB4pnD7FEmBnhyNRwBpymYv88dAlPIlZgOoKEqWreRBLgZh96uL/2l8uRiL8on3W9/V79xgzB3khh5U3XX5FVghLOH4yIb7UvEbNi1ZpUFQ2IN4pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898166; c=relaxed/simple;
	bh=o9FBPBRATXBwXK/2M5swSUhsXlpoKgEfd7COEYBxngs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epyNPQtko3EsUjAuoW7cFcEfZDEhbJEWNcGGaw3LGeWrkCqvfhlnu608LAKOd3l2RLiAB3PoL/OgD7nLlkMsfCiYXm2YdFN+Cy79nwboTuZE5RwGnJXnzgXxOzFdGCmUzGhX2bx3/pogffkICgeP6Nb6sbEAL1IfJhxpTX4K3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaZUKr8O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761898165; x=1793434165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o9FBPBRATXBwXK/2M5swSUhsXlpoKgEfd7COEYBxngs=;
  b=OaZUKr8OtBrGc87fQqfbHH7ZzWfhPLhR9+87QgS9rr++H9noFPp0Xkkv
   TKWykLWN9tuXSuMnvkd3DGpIaW8RQJ0sAH01o0t9zHXZkWfM0vioBzllF
   8iKLFjx1ZxOYTqeIm0aSiSxe5N4JNkELImvgB6VlAMwLxbpBTs7WzmS6B
   8BA+XUrCR7SkuKBDh12E/N9krYeS4pAoAiZCPqQshqMkR1So+v72gFE+q
   SDBX6jPWxYU+7/6B1lIGYc/Iv5Y1pTF0GndF2jlVOm7qLpITzvET5GVnb
   9VDObjnsMJuh7/Nsm5nHDhJTy06JO+xOu/soV9tEuHXc0K+6mSSKBIwr3
   Q==;
X-CSE-ConnectionGUID: U629vDU6SpW32GI3AHwysA==
X-CSE-MsgGUID: MscwsG95QAeL0TLhT+feew==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="89518439"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="89518439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:09:24 -0700
X-CSE-ConnectionGUID: OQN2MLtbRryxW153S58zTA==
X-CSE-MsgGUID: YU5gG/sbTbaXAjB/ZVC+kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216828945"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:09:18 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEkC9-00000004Cho-2vhT;
	Fri, 31 Oct 2025 10:09:13 +0200
Date: Fri, 31 Oct 2025 10:09:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <aQRuqKn6iTenCfiL@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-2-flavra@baylibre.com>
 <aQOVcCinTd-ZJJX3@lore-desk>
 <55cf525d734878369f936834cca60ce7972d268a.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55cf525d734878369f936834cca60ce7972d268a.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 09:04:58AM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 17:42 +0100, Lorenzo Bianconi wrote:

[...]

> > > +static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct
> > > st_lsm6dsx_hw *hw,
> > > +                               enum st_lsm6dsx_sensor_id id, int
> > > index)
> > 
> > please try to respect the 79 column limit (I still like it :))
> 
> OK

FWIW, the limit is the exact 80. Don't waste that 1 characters when it's the case.

(And moreover there is a note in the documentation that allows, and we follow
 that from time to time in IIO, slightly longer lines if it really increases
 readability.)

-- 
With Best Regards,
Andy Shevchenko



