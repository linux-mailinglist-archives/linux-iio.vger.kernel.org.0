Return-Path: <linux-iio+bounces-12016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A69C183A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BAF1C2307C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021EC1DF271;
	Fri,  8 Nov 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPz3KSbU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2F1401B;
	Fri,  8 Nov 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055268; cv=none; b=pHcfdCGpRLhQd0w1676xxVZYLXmTzlh+FOhXodV7XAF9A7Pcp06WbL09eV+ffhQ26mvjeEMGvGidjP7ddcNnd48YoWHisDfIzZIHbHApk64dixDF2XQvf1MQbRtXL9P58PJL1GGIRMu2J7C2uc3yHeuCdt+eqJp8b1MeX2E1CFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055268; c=relaxed/simple;
	bh=KvRs+aIHTd7p22IrO4Srco2xTOlfwvP2qMjZYsawVME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plWeLe48109pWF4skScu0l4tPd8zk4E1/7nudQHjxiV8VRhB2fl0vX3kEC2rPDXksHgJurGmknnK8+SGvK3gczFWhBvSgO7zzDb+odtmrB86lWBFjW2MyuaQR94HP3Z/tV+oYq4NlhI0nKb4tnee0FSp/DZZuxViLbdQiO7Qf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPz3KSbU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731055267; x=1762591267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvRs+aIHTd7p22IrO4Srco2xTOlfwvP2qMjZYsawVME=;
  b=RPz3KSbUetNLK9ikaYZgW0hhbcZFmpOt2NFhWcAwunS/6F9Jof99j8c9
   yENmg0Ea6KIuDlb/V8iF7mQGc99s8dUx9u3ZT55WlUG7ErN9YMBDphe8y
   4SzJ6dJybdA34nuPzCPo4/kluYBKqOsDHaNkRgAisTg3QDxz2gWPv3I1H
   p8Ag4dmhyIlPYfWSBw8qq0cLMw2lDK8HQRn2QUMLRS8dxo1I+I9jtse4/
   FKwWK8oI9icsuj/VmnRwXcZDQgQviee7ddhtYw5bkZlWh56WxfDYHfgh9
   SuHSPe2c6aQUTiGMIHox9FoJCMK13g1h+ykz/sSszbQ6Jqu85DxN2FAPo
   g==;
X-CSE-ConnectionGUID: 3qIJ2Qy1TNm3qI8/4lbRzg==
X-CSE-MsgGUID: RbJ7bVgPTnWZHXFBTVo7MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41546617"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41546617"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:41:06 -0800
X-CSE-ConnectionGUID: rvI/tnizTrGe+CxWG8aXSg==
X-CSE-MsgGUID: XIqvika3TxatnXwnLHWLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85680596"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:41:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9KYA-0000000CXTd-2QZs;
	Fri, 08 Nov 2024 10:41:02 +0200
Date: Fri, 8 Nov 2024 10:41:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: Move __private marking before struct element priv
 in struct iio_dev
Message-ID: <Zy3Ongpc0vdGxKsX@smile.fi.intel.com>
References: <20241107185746.138146-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107185746.138146-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 07, 2024 at 06:57:46PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is to avoid tripping up kernel-doc which filters it out before
> but not after the name.
> 
> Fixes:
> ./include/linux/iio/iio.h:628: warning: Function parameter or struct member '__private' not described in 'iio_dev'
> ./include/linux/iio/iio.h:628: warning: Excess struct member 'priv' description in 'iio_dev'

...

> -	void				*priv __private;
> +	void				__private *priv;
>  };

This is still inconsistent from the position perspective (while may still
work). I specifically placed it there, otherwise what you need is to have

	void * __private priv;

to be fully consistent.

That said, either you need to carefully reindent all the affected members,
or fix the kernel-doc, or both.

-- 
With Best Regards,
Andy Shevchenko



