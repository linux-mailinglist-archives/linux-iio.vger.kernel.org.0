Return-Path: <linux-iio+bounces-5553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980958D6806
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AC71C261F2
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D7176ACD;
	Fri, 31 May 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OODXxsxA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15762176AA5;
	Fri, 31 May 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175834; cv=none; b=P2pufVRpuw/lTHGg1qh1dKS4+/DqWDlX/yf3lu1Xykz5uzEAxhWdBTYV8YcIFU4IZo6665SHMk1e0SyJZM8PQZZgeM0PfFP7AV27/JByRWqyTph+E+G6ABwr0chxCx4LbStJ3DUjXghunfQL7vdUkF4v5YBl7DkkIvRzKgTwMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175834; c=relaxed/simple;
	bh=pV7oAwTBKTVDmPHen2NjZDaq5YMb1OZC6KpxCLdG8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi56EPNCAC6eht8vWctPcLdsfm5PY7/LiaZpFLCa8/3PHRHGjfsI8EkuB1JnGeqC3+gpRB8S2LqFuhz9Jwm8lmnvmRGwkgNQbn7F5OEKi1Y5tRvTHwSei6sNQVTDPwe8qNs2FZPjCahkUhfgdl661tAPs9/BYm/DdYbiRSsmyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OODXxsxA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175833; x=1748711833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pV7oAwTBKTVDmPHen2NjZDaq5YMb1OZC6KpxCLdG8wc=;
  b=OODXxsxALXI6j3rpPlVpJEYoI8v1q5K/jQ22egarfGqTzBE/FrmbtmEc
   1JInwZdc8FzeNen1T097LUSiufvLP2SvYMnqNefvsgqBOUtpo5gq3x/jd
   A6HdHGi1V+Qi9u/n0nP7W31i1Fg/ZW7hHvpxT0b2NTwyXSKuqZ3c0mISB
   G0tZ+aHUQHuIgqAyah09h3CKOZ1ewnNheTdobP8A+Ut22Rx6m4buUUutF
   jUSq5ie/CRJzB2AqkA5bAPaIMu7l4IJL3NTgOrQv/KbVzS6E6Kf+KcnXf
   LDsBnayZD+mW1dwvKwuNKvXTiZOHYyu4Ep/6g7nqLEzVIZ2wiRQAHJ2MZ
   w==;
X-CSE-ConnectionGUID: DozVmOrrS2ep/509YfXw/g==
X-CSE-MsgGUID: EKQPxrTWT8m2rXAAUBCxmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13852802"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13852802"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:12 -0700
X-CSE-ConnectionGUID: W8KdS40vTBaV8suge3taNw==
X-CSE-MsgGUID: 71sElCbDTB+wsvrIVyTAvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36306260"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD5sH-0000000CX16-2DQP;
	Fri, 31 May 2024 20:17:05 +0300
Date: Fri, 31 May 2024 20:17:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: johan@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Message-ID: <ZloGEY7qa3lPs_HH@smile.fi.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <20240531171425.GE1204315@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531171425.GE1204315@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 06:14:25PM +0100, Lee Jones wrote:
> Making sure Johan is aware of this with his new address.

Right, in any case this is not the final version (a couple of leftovers).
I have mentioned this series in the original thread.

-- 
With Best Regards,
Andy Shevchenko



