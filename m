Return-Path: <linux-iio+bounces-21901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B099B0F47E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7CD188120C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F392E8E09;
	Wed, 23 Jul 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZZg4N/H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A132E610B;
	Wed, 23 Jul 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278572; cv=none; b=GSgKGrWuUBS7X91GVpsfSXLfwHtqbCk69h2qK1ezTr9rXIOAnFgw7i5Al2SDDHUZ2vh21dAtiygkVswPSufogcbT0Df0QtjsswdH5661LYE7GeMLUSoBWI/eVXk3A/8Atx4pnGZMtjmupQ67CWrfoO+KBwn0kOPkZRtm+XQm+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278572; c=relaxed/simple;
	bh=7uFRCZ7As5+NVhpVoYy9lZqVRjgL6TOc2bTAujGB+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smjpPv3fFQ99GiiQ2Pin3CHZfqf0+w/p/Ho8+8xTErC6plhmbLdxuuW2w4RkHEy3MAPZiD1cbu4PnXudTEjoBO4kHwMDlMVrkswekHtQA7aKXgdNVzQOKMySAK4B+Z8B4R60O8tRNzO3CmpculBO/okq4fd9an9jAh2DKknM6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZZg4N/H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753278570; x=1784814570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7uFRCZ7As5+NVhpVoYy9lZqVRjgL6TOc2bTAujGB+fw=;
  b=RZZg4N/Hv5N2F/72JxAzkJR/KjDIucSD2FxTlLUBYmnmK3aORq5S94Uv
   PRxA/dC/w9LphF+nHO0OoQwHCklSyWLLcnfpOYQusSvArXPmNoqEaxUVR
   oLvYENhRW6nu8HV2HmJBG8q8Np9l4NAKz4N7UXlF3G6wR5ZuFU/RaREPn
   suam5SVwFjvubV+XG6wphO0UaUqzufE8A54MYBX9BWVaqe/uOToPBtdrZ
   Xakc1QzJTa30CfI72yzk6LiDebNsSQuTULVDCGWKkSe09O8MDInCHtOPc
   ly1+IPhJqWZNgTLqxxKvnbytJCxhCm42v1yo2rf0I9Ztghi/OuKSo6mIH
   g==;
X-CSE-ConnectionGUID: jsK61R/SROOsVojyPAi1GA==
X-CSE-MsgGUID: JLvM6ccOTeKhcVWBFg1qSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55503677"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55503677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:49:30 -0700
X-CSE-ConnectionGUID: 3D5XKCJrQRaJeDgMUzC4mw==
X-CSE-MsgGUID: 5QQAC3LXTZOKG/jqI10etQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190478089"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:49:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueZqW-00000000Iwh-3EDp;
	Wed, 23 Jul 2025 16:49:24 +0300
Date: Wed, 23 Jul 2025 16:49:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel
 and avg sample before setting register
Message-ID: <aIDoZHBjO4tU3Gkh@smile.fi.intel.com>
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 17, 2025 at 07:13:49PM -0300, Rodrigo Gobbi wrote:
> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.

Is there any issue with a Shift key?

> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

...

>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/completion.h>
> +#include <linux/bitfield.h>

While it looks unordered, it's still better to squeeze a new header to the
place which organises a longest (but sparse) group of ordered headers. This
will reduce churn in the future for the ordering changes.

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

-- 
With Best Regards,
Andy Shevchenko



