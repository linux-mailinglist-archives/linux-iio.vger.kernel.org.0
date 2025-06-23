Return-Path: <linux-iio+bounces-20898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973BAE3BDA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1265D3A58F4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD2238C21;
	Mon, 23 Jun 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvSTr90x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59D22D4F1;
	Mon, 23 Jun 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673488; cv=none; b=CDbvEBdN6RUCoEs0orRis5tFgKqyJDBGgAVboSEysRj+8ruolKwK9oDsAPZw846LtBrhztI3dw+qdr1vT6XBTQeru/9S7sVUMhFHtdSGY6HlyzAXSvSEazLiFK1PbmHIGluLJvdGX3+3fI54NaMWh9r62Px0fSt+vwoI+/dELF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673488; c=relaxed/simple;
	bh=OFKwZS2f1yjDnUpAHHlzk5SdSS1w7t5kE90KGJKypWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab3jHqPwZNQZRyniy5pwoQDlYukdmniwfmaYfy4AWOgnD+9GRnXhFpyTdxErQP5zlkBKmIkFztZIw3P00eqyxwnPzRjn8Xt8YXDKrUDlIzz9ypRpnXCvpy9SoHBEkKh/o5BmM7bkWtUzIhLpYfqwPC3fxCIJfiuXjh3VREQ5mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvSTr90x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750673487; x=1782209487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFKwZS2f1yjDnUpAHHlzk5SdSS1w7t5kE90KGJKypWk=;
  b=KvSTr90xiWqTSSWE/pTylGvzjoNYaq+PNJVF0k6E2StjHF7DfXfBW/KK
   HEXQX+rxtK/F3LIc8V/IpjTplLqVOnXYbfq1eSo/vEoHXup4/xM2BvFB7
   4HNq+IU5PR9xRNzwXmjNqMeMA2FyfhZpvSLap+Sv/SyOVL1piYv5MWgJw
   Q+TuVXW7waral5btKxUDBXiPUGDD7pmqY7Y09wPlo94pqV2OB9JAympXs
   LsxS52oWGiZBxfnd27mDCRIiveU43hBXylar6Te9S1n+jjP2G1hs4Zo9c
   Iz7zrqXUm47KQv3bPKTwK25BaN/X7pVWfwrcvgh96ShX/Q/ezFvMFIsvQ
   A==;
X-CSE-ConnectionGUID: fM//FshUTMC9VQbyeGdWAg==
X-CSE-MsgGUID: McvQqpOZSPWp3lDQIRks1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56681978"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="56681978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:11:26 -0700
X-CSE-ConnectionGUID: +cWrTyRVSK+2Q/9SQcr93g==
X-CSE-MsgGUID: oFv+Fkr2QBuXEG3Tnk3/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="157051613"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:11:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTe92-000000098LK-1i91;
	Mon, 23 Jun 2025 13:11:20 +0300
Date: Mon, 23 Jun 2025 13:11:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 5/7] iio: accel: adxl345: add coupling detection for
 activity/inactivity
Message-ID: <aFkoSBXuPOoQj3JI@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-6-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622155010.164451-6-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:08PM +0000, Lothar Rubusch wrote:
> Enable AC/DC coupling configuration for activity and inactivity detection
> by setting the AC/DC bit. Extend existing magnitude-based detection with
> adaptive AC-coupled mode.
> 
> Use DC-coupled mode to compare acceleration samples directly against
> configured thresholds. Use AC-coupled mode to compare samples against a
> reference taken at the start of activity detection. Implement DC-coupled
> events using MAG, and AC-coupled events using MAG_ADAPTIVE.
> 
> Expose configuration of thresholds and periods via separate sysfs handles.
> Note that both coupling modes share the same sensor registers, so activity
> or inactivity detection cannot be configured for both AC and DC
> simultaneously. Apply the most recently configured mode.
> 
> Simplify event handling and support adaptive AC-coupling.

...

>  static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
>  					 enum adxl345_activity_type type,
>  					 bool en)
>  {
> -	int act_en, inact_en;
> +	int act_en, act_ac_en, inact_en, inact_ac_en;

Just make it two,

	int act_ac_en, inact_ac_en;
	int act_en, inact_en;


-- 
With Best Regards,
Andy Shevchenko



