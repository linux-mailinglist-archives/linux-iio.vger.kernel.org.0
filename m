Return-Path: <linux-iio+bounces-24162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF8B597C2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0109E4E68F8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249630BBB6;
	Tue, 16 Sep 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+eq16zf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161228315A;
	Tue, 16 Sep 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029749; cv=none; b=IccagmZZV9s+2LHNZXrppmI1eloupIOzmVR/XXrcetnlTEcl0u9HO9mRr9xfJT5wEAJdzaUW60rp+rQMnZDwP7KBLWEMarlHAC/Nq3jSlSQK/9XWT9TrIR1RC138xrtX0HxURFLo0UUcC7mdVLptQSj/421kx84AY9KQjOHBoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029749; c=relaxed/simple;
	bh=xNjcCrqL3Fvvxc/pvu1fHNLYA6h0GPV11qPf/HCmCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plrKICyAbNjky8aQUsGYA5rTK6pH+glJ0TKCPoiEWm9JFBn/I56ziybKQ08YxFcGfN1UpyYpiP+HqvjJ/xer3n/urCq0RrbSCacljP3Tv//ltKMQZ+OE4hdZq90c6no8/t0i3Qx0WwqmtUKM3yivPHnv5AXx7rzA/Xb53rETFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+eq16zf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758029748; x=1789565748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xNjcCrqL3Fvvxc/pvu1fHNLYA6h0GPV11qPf/HCmCrw=;
  b=m+eq16zfU6moWDxJxMNbl4K/7EXM4q6fONd6EM6LDFAWN2QWzVl2BHz3
   Nfxjy9FV8NKdSvJ4vq/Ca82axwJfLO1BS97yN+xxodHn6BeucvIqO9TqO
   cbIEXbK3KVHV4NU21QpxPL0HxTyG7kVSm18ASBWthiqxpm4zaKduKGJ0s
   eJwlE/NowA153FB5lmB4qsA8zRJpnJnihQxo/Z97WUixaEZ7MbMkDiBdy
   iLID0WYR09DE4yq0oX3gY/UbNiL4bW0kR1aNi6M7Jt/KaiICG+8QaWzdK
   SIwOcSpd/AbcZw2NBTZ2WahzqnMTGklMbnH4Z5uk2Lbe3sZ+itbnXqRfb
   A==;
X-CSE-ConnectionGUID: o7cQcBz/Qrq5awzfO6pOSw==
X-CSE-MsgGUID: g2b37pKGQL+iUtg0L6zqRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60237209"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60237209"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:35:46 -0700
X-CSE-ConnectionGUID: n5JHXARFTkK+1BMz1LMX7w==
X-CSE-MsgGUID: fePhtN52T8GQra3atVYGLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175365031"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:35:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uyVqJ-00000003XU8-1c1D;
	Tue, 16 Sep 2025 16:35:35 +0300
Date: Tue, 16 Sep 2025 16:35:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aMlnp4x-1MUoModr@smile.fi.intel.com>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno wrote:

...

> > +MODULE_IMPORT_NS("SPMI");
> 
> If it's exactly the files that #include <linux/spmi.h> should have that
> namespace import, you can put the MODULE_IMPORT_NS into that header.

Which makes anyone to import namespace even if they just want to use some types
out of the header. This is not good solution generally speaking. Also this will
diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. make it
invisible that some of the code may become an abuser of the API just by someone
include the header (for a reason or by a mistake).

-- 
With Best Regards,
Andy Shevchenko



