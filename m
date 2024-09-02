Return-Path: <linux-iio+bounces-8984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C130968678
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A246D1C22875
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1171D61B2;
	Mon,  2 Sep 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnUQwjcO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0551D618C
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277314; cv=none; b=LOg9ZcxnIYimr62BiNd/89SjnuqR92MkZHlNrK0UVkkWLPM2O94eTxHpzbmm+a147yVYrvYWGDgM91XzSAI96VOwi3YnhhLM/DKnduZdCz/bWdtutyfIZQVg1TiEMvRSFvt3hs3H/Oc6npdhvXsfCp05oayLjiOeYrE8Hoamwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277314; c=relaxed/simple;
	bh=okF0c5cCs31CzC/odO/JAvS0BkP7xrUOpMDWtzbcN/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx4TUkDiaBI+RLGgXbpL0ww7/bWtLMw3uYtWLNv2JiMZUmsIVvWx3APhKtYyOM+XNqrE1Cv1Kn+QCod09neyOSsMzWg5EXzqWimsFWNeKSkq6MLYbh83CK+TbOVVtDjzTimqMyb+Sxn94Jl35LaB4KRca8XzNlkvgof4IvwErew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnUQwjcO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277313; x=1756813313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=okF0c5cCs31CzC/odO/JAvS0BkP7xrUOpMDWtzbcN/U=;
  b=gnUQwjcOoDi6QHSS60bpn0qmX3x3YASQ8gLi9jGf0nTbWkJYLoaiv3it
   0Nz2H/lfeq1uvIMsY6UH3suRZL8RceKzOVIBl0Z6M6Bj+p9LRTb5kCjyb
   PqNqmtY7cM0fDLOZxu68QQTKh+UfzFjlqx6W1cL797jSLAu3Kim1b6AYm
   FSsw0wSM5WEAOih4BGKukx/w2wrAksvIBBNR4WNO4lwGUbVHIhR72kIfK
   OD6MaTIDM9DYl8RGzWBytWqiKKzUaEQQkbIbX62F6Cb3Dn8KeebsRxEXD
   Q8XzU5y9RE/nJoE2fTj98BrPmCcif74JBB47aCZic4HdlfpH+IEn6TzB/
   w==;
X-CSE-ConnectionGUID: UcBLnOfpSWmJrjgdSj7BRQ==
X-CSE-MsgGUID: UBUSroZ3TK+rTMBt/Kjp7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34465531"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34465531"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:41:52 -0700
X-CSE-ConnectionGUID: tCxeXcQKTc+0whflUR5RAQ==
X-CSE-MsgGUID: P1ji9yrMRdWjwusO9Z/OVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69453329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:41:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5RK-00000004LRv-06uF;
	Mon, 02 Sep 2024 14:41:46 +0300
Date: Mon, 2 Sep 2024 14:41:45 +0300
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
Subject: Re: [PATCH 02/15] iio: accel: fxls8962af: use irq_get_trigger_type()
Message-ID: <ZtWkeSbUTaF1iV-9@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-3-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:37PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	irq_type = irq_get_trigger_type(irq);

>  

While at it, I would drop this blank line as well. Because the next line is
quite coupled with the previous one.

>  	switch (irq_type) {

-- 
With Best Regards,
Andy Shevchenko



