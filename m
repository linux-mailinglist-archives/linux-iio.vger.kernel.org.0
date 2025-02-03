Return-Path: <linux-iio+bounces-14896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41246A2565E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B18D3A8EDD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F815200110;
	Mon,  3 Feb 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK1SAlur"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA31FE467;
	Mon,  3 Feb 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576427; cv=none; b=BNrAbtYvqlkw/fV9W+aDxctHZdGXjxc0o4PbuXkKzg26XDR2kOg9iclqXmI0ylntx+pyNgr2fwk4/WFHChnUPPAHHhCQJicEncELIcnQrZmgWD8kmoRSt8bX+fr2KBafF7O7K/m3SRlpA+k+ET86qD54Seq6rqOCXMzzWftz/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576427; c=relaxed/simple;
	bh=1ufzKtf4lCYm7K+YQzPxGUiMcMlBRRAyRHXicJPA2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUWk6IG0fngginrbxSYxDRRZMTll0KdG1Dcku4HrjDQ2mzDIeWErMM269dkBn/Da5HbrC9IUmbCoe69N4o5C67AbxQQaftM29IJwP+bNhQsdNy60K7Q2Okim6w1AeTsY8PoVt5X0k9b08rrJFNYO7ZznC/lTmYVl/4J4RhJ7VMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK1SAlur; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576426; x=1770112426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ufzKtf4lCYm7K+YQzPxGUiMcMlBRRAyRHXicJPA2dk=;
  b=WK1SAlur/VB2NKX6T64z9Px3sf8FPDV2yLKjwfH39dQDHRZIBLbkxJi2
   +OOXFyGmcl+6nN0WXjQGjEYcwBenevPduEpKoIiZ8Ri3mRRXy1PMcfpAM
   6OIxdop+F1BzJOzYJA9f1htElvR6I9Qx0kRxbxo1Ls4hqWtomFhKRB2BX
   k0xTnYg3pu08nOLU9cJt6QQmp0M2xjpa9HhqtJ2MX4RZaJzF9Dy+1/qhA
   TNlI23Ug1U7wiFzyemXK4lvP5ZeIvRMMqZ0r6SeM8ftelUGakw6ZTBHab
   ED+080Y22ig7/BN2hv7V4HpA8DPX679e6nHM5IfQE0edPa9Rk+tf8RLDe
   w==;
X-CSE-ConnectionGUID: twV7dlvJRBS3VYcXQ+7AWA==
X-CSE-MsgGUID: EH9FJe9qTO6MDtN9mrkMmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39163018"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39163018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:53:43 -0800
X-CSE-ConnectionGUID: mMi7A/0RRAu2llZv/sBXCw==
X-CSE-MsgGUID: cyBuCwDUTEO0FHo92SW7TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133496731"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:53:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tet96-00000007n36-0PGZ;
	Mon, 03 Feb 2025 11:53:36 +0200
Date: Mon, 3 Feb 2025 11:53:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 20/20] ASoC: uniphier: use devm_kmemdup_array()
Message-ID: <Z6CSH9aHUAB23BTS@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-21-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-21-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:39:02PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

>  	chip->num_plls = chip->chip_spec->num_plls;
> -	chip->plls = devm_kcalloc(dev,
> -				  chip->num_plls,
> -				  sizeof(struct uniphier_aio_pll),
> -				  GFP_KERNEL);
> +	chip->plls = devm_kmemdup_array(dev, chip->chip_spec->plls, chip->num_plls,
> +					sizeof(struct uniphier_aio_pll), GFP_KERNEL);

sizeof(*chip->plls) ?

>  	if (!chip->plls)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



