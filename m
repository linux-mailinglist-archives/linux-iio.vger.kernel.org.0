Return-Path: <linux-iio+bounces-8987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D345C968682
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106381C2280A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02B1D67A1;
	Mon,  2 Sep 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IINsDHhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3E16DC33
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277547; cv=none; b=RC4/rr8ZqXRwHLmRJHR4mlcwJW/Wfghlbn00o+bvCvx+3PVPsNR5wCLWq/Sc6YjMlo9IK2i/RIte7rpjXawU0KYZCPe/Eypht31KR8NoQLk+o4Cx9SJORairUa5s0/Sz4FwsYfHwD9TXuEoLdx6PFXljDlXWmF+blFwmywcuUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277547; c=relaxed/simple;
	bh=46lb6FxsLJkB85AjVIpHnzIRquXMlwuTR0Bp07fFsyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbkcbBS3lXuI5iUP2x3EztSQ+3O+fmNzF7o2QLXBaM0JTVtXTB0np4wj64FfcyjkaONiLEbhHAhGeByzqcwc17h14YeoZ5gpY2hbF+6qdNb8P0zCuEcH2krZlbzd4hvO3jP3deL5LbzPeMHToj/AyVrxDVl5AzQp9sH9CobpbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IINsDHhQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277546; x=1756813546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46lb6FxsLJkB85AjVIpHnzIRquXMlwuTR0Bp07fFsyw=;
  b=IINsDHhQiSVEg8rWWctpoIZUWCD/g1T4QJPwJ234Sqdu3mBdp6mjKmkQ
   /0t5G20O1fhunSaphKXs9UFDVaJg34Bi68RhesgV/ZoCu8EpwUsiCEczf
   MfI2IpQXhSpilf4nl68UGupe843QgG50LTdCtD22W96KMRcioUY9n2GlX
   HtThqfIljxWegU/ONCGdMlDGJlUlBKE/pClxbWz/cZWE+EbnKoF0/zhOY
   SRg5LJrH+J3fETSyxHJArfYS+CGbLrCxoXlLSvP0yPGUqHTZeMOAG3pI5
   Ade81GRs2pSP/bRm3u2Xgbe/3bjwI9/wD/9VNAkhixhHtbvQM4QNBMStn
   Q==;
X-CSE-ConnectionGUID: raZpYYkoQ6+qGKfzcuK/Ow==
X-CSE-MsgGUID: /0QE0nH7Sq6ijoQ+rZ2i6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="26756450"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="26756450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:44:47 -0700
X-CSE-ConnectionGUID: uALQRSN7T5eU84EpfPYfTQ==
X-CSE-MsgGUID: 4enF4poWTwOWEjDGbBkCWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="102040891"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:44:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Tw-00000004LVM-1PVw;
	Mon, 02 Sep 2024 14:44:28 +0300
Date: Mon, 2 Sep 2024 14:44:28 +0300
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
Subject: Re: [PATCH 05/15] iio: gyro: fxas21002c: use irq_get_trigger_type()
Message-ID: <ZtWlHNwhYCo5-dXq@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-6-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-6-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:40PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(data->irq));
> +	irq_trig = irq_get_trigger_type(data->irq);

>  

No blank line?

>  	if (irq_trig == IRQF_TRIGGER_RISING) {
>  		ret = regmap_field_write(data->regmap_fields[F_IPOL], 1);

-- 
With Best Regards,
Andy Shevchenko



