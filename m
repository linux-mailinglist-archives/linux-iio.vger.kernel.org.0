Return-Path: <linux-iio+bounces-8989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F0968684
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B90EB24B91
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683EE1D6C52;
	Mon,  2 Sep 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFqzZ+ve"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE0A32
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277584; cv=none; b=ANqqrMM6He0zUUzsamDeJm2mcJEz7VAnQpfYhEWFx5ez/JlMoISnP52z0wLaUhV6oPgPB+5PbZztaE1UMeQN47aax1OxUSh0vgUP+oNCCGtDkufaPoX7v7GORJsazErZzu/1hXhO1esVPlLhY1D3Hukbsp7PuGTVVJ3vwjlJe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277584; c=relaxed/simple;
	bh=8TjqJFgSB/1Q2u84R4B9jbTcdD3H/iCxYGNimKMEpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm5Dyxt7MzrGNzdWr/ljWMgD7let7WVXZ5aCGUGHdWUdwO5neDJmjqkdLFaldRhviZdw7pa74sCG1lwGgwMLIpzwvaIw15e3qePYWgyYE8qwnsDYO16zcQKYgHPSLasJtntAq6qHlN7ljfgEPo/kKwRFB65uFZgTWDKtCJPulIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFqzZ+ve; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277583; x=1756813583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TjqJFgSB/1Q2u84R4B9jbTcdD3H/iCxYGNimKMEpwM=;
  b=FFqzZ+veoK1BWehgA0Xqpr1In031CWf5OJQiFyDZWID+fn5PJtDJEAu2
   JWjXstESevsOAxM6bv7B0WxEkieILxSle469AyYDLrjtf8ZnsWU4WLlFg
   REMxoqjP8Ml9boivYikRUvNhYzDiLbOtH6Q9yXVLytpakJm8iANIu4jEd
   BJvkl4zwpw1FQfrhKCIU9n7oKnTqWLQiYd+1o2EYJxpQlYva6lQJnHMWQ
   QLopEK8PPw8zSnWcbJKJw7hwxmfdjQD4NG6KWENIxLhsYGp6a08r7lQ7/
   LMvbhh+yX+EqxAMXeoZHIKg/JSGz0GoY2PDofxiDh4cvQTb0vKppQ8+To
   g==;
X-CSE-ConnectionGUID: cqz26AlnT1mVzN6b1OYVwA==
X-CSE-MsgGUID: Jw5NjRlqTRaTFf9IC9ztQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="49258253"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="49258253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:46:22 -0700
X-CSE-ConnectionGUID: +N2t4OlJRoWn2O8FXdWfxQ==
X-CSE-MsgGUID: /FViwBcGQKali3sxCeSqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="87820389"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:46:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Vf-00000004LXa-3JBq;
	Mon, 02 Sep 2024 14:46:15 +0300
Date: Mon, 2 Sep 2024 14:46:15 +0300
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
Subject: Re: [PATCH 07/15] iio: humidity: hts221: use irq_get_trigger_type()
Message-ID: <ZtWlh80w-zDa3XGX@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-8-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-8-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:42PM +0100, Jonathan Cameron wrote:
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



