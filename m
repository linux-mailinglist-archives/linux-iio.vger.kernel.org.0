Return-Path: <linux-iio+bounces-8990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6096868D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE351C2277E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B11D6C6D;
	Mon,  2 Sep 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAjkFLzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4FA32
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277669; cv=none; b=gIve2UZ6WQlJGd4+P34AkH3Xeu0n+EfgmZPx9l8NWhARuXXpSwTfuEL7q4h+/s7kmt5TQu04KFiQLWA+QzTqmrg063ENo3LLUof7XTVCmrXXdLw1BpgJXRwhjM2JkW7lE1EA98jqvlHRStTZc6ucX5o2pTKeaGkYLY6TVT0Jrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277669; c=relaxed/simple;
	bh=q44aKTYGPmP6oIZ7EBy3FnZ98ER2NP5vOxyz90FZ5EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/aAoshd2yZrRoiA+CZEvh2s2ikcSyWv3n3wm5qbCl659bHHQXytDJeB40hp0I2E5uVSoZ6lqeVOes441rM78feEuavhr4iUwRe0H1V0AvJmKAYG+i8/V00PgrVIt/MEFa+/RhrYeG1+t/mEJHzRP/PRVpBlrcSZil2crXe3s5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAjkFLzp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277668; x=1756813668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q44aKTYGPmP6oIZ7EBy3FnZ98ER2NP5vOxyz90FZ5EY=;
  b=aAjkFLzp+uwGEppa19zOpqe5IM94lKDsSGtYcqOF81YVzA28iTjN39bJ
   GnIZCKNXeZjLz+YJQ6gEMJEH2uU6I/XqESmS0u+wTLmPlbwRWNtQ1//a8
   1A3tuWh6HtNQQlc6FYX28ptTr4tet14Wgh7v76L1MLSHTkr/jLGIOj5Vz
   exAn0LuLrgTPzADGEVBPeXZaf7AoACF/WKSKI1eblwjT5erfYZiaYOS2p
   E+N7KNTdVnXdv6ZkwjN6ZvEs1alTNQ28yw8ZqFdHioyPhU29dDKt79M7t
   KyEtf9aprTKjdld6FvMgYNFK8+GBK1mG9bQgvBZI6xvHujHK8fc+hh14Z
   g==;
X-CSE-ConnectionGUID: WxIsAeipR0+EtMTiu0QMeQ==
X-CSE-MsgGUID: GaGgcFjQQSisc0B8OMxw8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34465974"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34465974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:47:47 -0700
X-CSE-ConnectionGUID: RZzeb0kuSeSVdYkFI8tL1Q==
X-CSE-MsgGUID: +Kb9i3MQQV+Knp3nUYkPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64404962"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:47:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5X2-00000004LZK-3tUz;
	Mon, 02 Sep 2024 14:47:40 +0300
Date: Mon, 2 Sep 2024 14:47:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/15] iio: imu: st_lsm6dsx: use irq_get_trigger_type()
Message-ID: <ZtWl3BXLowd-7Y9C@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-13-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-13-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:47PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> +	irq_type = irq_get_trigger_type(hw->irq);

>  

No blank line?

>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:

-- 
With Best Regards,
Andy Shevchenko



