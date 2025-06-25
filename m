Return-Path: <linux-iio+bounces-20965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E716AE8BDA
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200301BC62C7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BB62D4B66;
	Wed, 25 Jun 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqLNhezR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4172255E23;
	Wed, 25 Jun 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874265; cv=none; b=PsSeUUClfWFe1eQgfCj2eKsWnTco3XpHjhHGcIE2Fiah6CSuxg2WRYT0DwNctOjP8RykSxU7TWmCCCc2Ey6tGb42kGNv0mh8L5txEqGXSvo+Ph1qjl0ZkbM6A4b4SKQZWd5OkVUpNPw2BHwx9pbhyjDQO5w2OTVt3dQxW4b8TZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874265; c=relaxed/simple;
	bh=V4AB7yzqPcNPebmWQ907ROAMiL5bdlgezWA7mRyUt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyOjxAGOFU+3IE/xBaQJVCb/RfqRWD7xXLUX4wBTNYSwr5mgmhwaFeXiSvmsBxggjSrkCm10WwuCmu3K9l9f8azHfEUjT+rx2rJdoX4PgrmEoR0r4WkQXl6Jttenx5v5AIkwODuotD50HndujcX/+8+xW7s0xMj2umdtgWy7eBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqLNhezR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750874264; x=1782410264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V4AB7yzqPcNPebmWQ907ROAMiL5bdlgezWA7mRyUt0E=;
  b=KqLNhezRdnIv2P10YDHT9HhxoJUMFTZJEYPfr/kzme+LuGTojTiLbbeB
   i/wdyiuiYI1JAuQYrrvnNLXvP89adMCVfEAHNTlrMxyrMx/5QTrUwIAU3
   l/kHzH5sYgGH5yBrzlwJnKZEfVYZiG/A8W5kHQ6a1OdpfbxEIqR+Tp8vq
   hM3xn8YzHG0bbYNGPPtds0d/bl5lv7y5En6KGbgyCgDMCkCr7up/TBR0s
   n13FxFU0aqB56jOstQt9jaGiPcvS2mqB+PZxECjt3QzyUhbhgNE5Y2NDo
   qrSngvv+LLXo0eg35VnD8gFHA3+oWeSYoAKi204roDZQ2iSRZqdtIzEi4
   Q==;
X-CSE-ConnectionGUID: tBEk/ol9SIu2JK/9UgNMVA==
X-CSE-MsgGUID: DJslyOytQJeD376y3XTCSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64590173"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64590173"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:57:43 -0700
X-CSE-ConnectionGUID: 1DUoNyo0TsWZn223XS7JYg==
X-CSE-MsgGUID: dW81NnFtQ26CTKLrO07l8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152581943"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:57:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uUUNN-00000009w2P-3IAK;
	Wed, 25 Jun 2025 20:57:37 +0300
Date: Wed, 25 Jun 2025 20:57:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: mazziesaccount@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: ti-adc128s052: replace literal by unit
 expression
Message-ID: <aFw4kesQt4WMt2uK@smile.fi.intel.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625170218.545654-3-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 05:02:18PM +0000, Lothar Rubusch wrote:
> Replace the literal number 1000 by MILLI from linux/units.h

Yeah, but with this units (mV, uV, mA, uA) it would probably better to have
dedicated definitions, like we have for Hz, s and maybe something else
(bytes?).

-- 
With Best Regards,
Andy Shevchenko



