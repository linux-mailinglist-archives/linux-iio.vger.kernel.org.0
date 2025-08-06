Return-Path: <linux-iio+bounces-22356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E09B1CD33
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F777B38C0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFBE2BE65C;
	Wed,  6 Aug 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+WKUVCf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447D2BE037;
	Wed,  6 Aug 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510816; cv=none; b=pPy/PzetvihnlpqQm1fielqSVodKaOg9PoGYG85tP7ucVFjifZqHxmgdoYM8k8J0vfV1RKD0s9RLrAnfvhPJgJ1r1+/rkqu2aKUN6SDIWdFYJXOe11UUlYJG7dxLsRz0MScMQn0fAaKIERULx2PNXO35tKI9kEub2CZjPmPrQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510816; c=relaxed/simple;
	bh=X6SkoBN6Gq75qeH5mXPfzDukvxJCfHWpFZt5FEA5+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl3eBSlFEh9nEril4dB5gziFuygKhT8e9+uZQ6my45/AjQWyfiYOmwChMq+PaYHFJdB6Fb+h+dIWFnitZkC54NetWo3FkOL3uhNdAjxDDh4yg6ACUkFtdqMhIyXsUCfCooQ5Udlstxd/+Ah3f2IQaj2Zrw5OdMY7nD+sA1/n6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+WKUVCf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754510815; x=1786046815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6SkoBN6Gq75qeH5mXPfzDukvxJCfHWpFZt5FEA5+BE=;
  b=X+WKUVCfOzLDl9+PZA4BvF350BrSX4CloR11QoR2omtlU6Q4FGFzMj9c
   ZQClaWDIHXUBy6KFfIhObDDLczzmIH4ZyKEZtEShvjixtqIzAI+cymflx
   hNCmOitzqq6OKpYnEEr03Xi/CdwQBLiJ6ZTT7fJEKq+Jl4yR2492GESTM
   aG+AyKoK2bawKnWb2S4nDbK/6oEu+q7dbwlmkoU/aFkACA+E/LMGAlnQc
   o4Nifg13TTlPVte53m1zMiy2wLK8OCqnKq2LjC7IXksat053tvrMOPoSe
   iUQAvahBy3JtlHwI9zKLtP5mEiWtFh4vBTxl2mTTcWbEmxu8sEWOcsyJG
   A==;
X-CSE-ConnectionGUID: bBfpG68rRjiDg/kWl3c0Dg==
X-CSE-MsgGUID: DbhdfYf8TES9OvBXQiAy5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67917231"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67917231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:06:54 -0700
X-CSE-ConnectionGUID: lpCNklMATW6KWmQQ3IGYIg==
X-CSE-MsgGUID: sdoiasCPRaGg36mI85yplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169116683"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:06:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkPQ-000000046ZA-3Yhw;
	Wed, 06 Aug 2025 23:06:48 +0300
Date: Wed, 6 Aug 2025 23:06:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ad799x: reference voltage capability
Message-ID: <aJO12OMmnXzAomq3@smile.fi.intel.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806090158.117628-1-stefano.manni@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 11:01:56AM +0200, Stefano Manni wrote:
> This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> in order to add the capability of the chip to have an
> external reference voltage into the chip_info struct.
> And so avoid ugly conditional checks on the chip id.
> 
> In addition the AD7994 is marked to have the external
> reference voltage as well.

On top what David said, missed changelog.

-- 
With Best Regards,
Andy Shevchenko



