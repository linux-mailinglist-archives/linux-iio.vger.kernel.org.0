Return-Path: <linux-iio+bounces-14899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504BA2567A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9579167984
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8820013C;
	Mon,  3 Feb 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3KzzirN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC481FAC3D;
	Mon,  3 Feb 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576637; cv=none; b=PwP2vsSJJkmnfg2BVPWxEx2W+yJtvrvqP5mPk8/3wQZnb4Va84kPmXLoI9AGtJ7ncUp8Nak/XsWNapg2Ap+FIuqGm2p2mOrPwb9cera4VCjIZ3z8tKzFwAoIHdFR+IipLiqepMvcWQ4ZA+GVPBZ40lMRowWgIHyQwWJRJrZetLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576637; c=relaxed/simple;
	bh=urrBZ/6GVCXqZdOoAIyHoDL2Fcu2h++C/73D15sq3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEnf/duq7irRQifpoc60xpD6MQAHqwHcxh7lhAR8YZsn0KzBXnejwABg2pIVF8YVM1hFy9VqPqn7LZMY6J8DA8quLFf6HrTy9yQ3O6/rTarZn+r0k6zWAqS44a8Br4zcxZqcQtPYuZpQRioUn6PI2OcjZBDju8idrOhKHL8vRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3KzzirN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576635; x=1770112635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=urrBZ/6GVCXqZdOoAIyHoDL2Fcu2h++C/73D15sq3tk=;
  b=P3KzzirNUClWBYhJ6eFsfTbdSOPpJqEnLLjYI40WO597oS25k9xeKCQg
   FakRiqzPoUZDIpqD6LpNqqtB4oReaQJEEE7ZF9dVx0lGo7AXZvirpcO2q
   sf5lqgk1JPTgsRCMC7Ko/lSgpyLCTyHc0N7lUT00dQudA279BekprIatO
   ydDXe3/S5GEc3F6SBSLEjVgLt67aMHf/aMs5P4JBhhuOSmhBlIz1XHDO3
   iwapU9qVPN4snYoUR9FCD2jy19hRjjz/gDdqCNy9CIR5X34aR5eSTQ4nn
   luqWmk4ytJuaPhEcM5045XA1iiMwW/uuVJt5PeTqNufj60Z3PAJsvmeDy
   Q==;
X-CSE-ConnectionGUID: RWc/S+SETYWe8tTMvh3gyg==
X-CSE-MsgGUID: eMi2AGwjQ+OPVjw2jYnxig==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="50053605"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="50053605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:57:14 -0800
X-CSE-ConnectionGUID: dttPdoLBRj6ws3opxLAL7g==
X-CSE-MsgGUID: XaZxNjHLRBGGAqutSMq2pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147443589"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:57:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tetCV-00000007n5f-3FpQ;
	Mon, 03 Feb 2025 11:57:07 +0200
Date: Mon, 3 Feb 2025 11:57:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 18/20] ASoC: uda1380: use devm_kmemdup_array()
Message-ID: <Z6CS88kG3dssSaIk@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-19-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-19-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:39:00PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

> -	uda1380->reg_cache = devm_kmemdup(&i2c->dev,
> -					uda1380_reg,
> -					ARRAY_SIZE(uda1380_reg) * sizeof(u16),
> -					GFP_KERNEL);
> +	uda1380->reg_cache = devm_kmemdup_array(&i2c->dev, uda1380_reg, ARRAY_SIZE(uda1380_reg),
> +						sizeof(u16), GFP_KERNEL);

sizeof(*uda1380->reg_cache) ?

>  	if (!uda1380->reg_cache)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



