Return-Path: <linux-iio+bounces-27420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D420CE9B63
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B0213010E6D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301331D5147;
	Tue, 30 Dec 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M53XBX0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667F4A07;
	Tue, 30 Dec 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099435; cv=none; b=dOEK+4lNQaPlaLoo1hZL0sNu/5x101Pp2zGX9PZxZu7vn64ZVPk0JVKTv9/QRJuUxy5zpYVFx/iKs1cD74Nqlgq7X67DTYSFq5h8ZO+QEGjqv8d+JVmEwL7L257iGNftP+CgQm602A5mhU9eQrGf8Py2yYk9+DuqVjZ+NFa+tZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099435; c=relaxed/simple;
	bh=xriujunTMYnrYEgRYl2UZ0v8qcZlWOuqptUXDT6MjG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRlfLB+DRadwll012zuyenWd2f2QlhkAhyiRbLcSXtiyCQd8D8a1H/pOM8Ns0ynVcAbOBg+w9T86J949gvMGzvbk9xgZFkkwXrt4E7XI/wqeOeK2l0uZ+5s9G51+Gqt7ca1mBdERhZNjPc5LafJi988GqavGdOUv8HIlGz0mAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M53XBX0l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767099435; x=1798635435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xriujunTMYnrYEgRYl2UZ0v8qcZlWOuqptUXDT6MjG0=;
  b=M53XBX0l+WVfbh0dlTp9nnlaZsAglh84GhUmSyB4C1utspWpmnDlImwk
   5Uw1kLymBxeKrXzoIxmBLH/gsEpGHfVo6qMoSQAhijSA0L2BuJSrF+rjH
   0Mb1z+1zeTezOx3P8dCSUbUKZ+zREwnpEM9mwxmBcWzkB5a0Atr7Saq9y
   /nD0gB9ipTeea+rk5Hj1/FA+x3xpLrKvtLYNvh8LMOLYWYO5itjdkiInT
   xoGlo8ecs7PYZJ8YWef+aUURhQZksRFi5nvt58pCJFpDviVcm9EzVsFo+
   Om4pjTKlg8Rtmq+aY6OShuxnkgA5Qfj4h8c4k7nephmPIejOIRAFbSquR
   g==;
X-CSE-ConnectionGUID: drG+LFXyRwuahd5/+VUTRw==
X-CSE-MsgGUID: 6NwzexlFTuyVvevG1fQGWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="78992173"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="78992173"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 04:57:13 -0800
X-CSE-ConnectionGUID: 3gpVMCFzQiar2BcmKecY6Q==
X-CSE-MsgGUID: hgh+PWLJSOmE38O+O5p99g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="201468000"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.103])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 04:57:10 -0800
Date: Tue, 30 Dec 2025 14:57:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:frequency:adf4377: Fix duplicated soft reset mask
Message-ID: <aVPMJFt07PG9oHMU@smile.fi.intel.com>
References: <20251230123609.210454-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230123609.210454-1-suunj1331@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 30, 2025 at 09:36:09PM +0900, SeungJu Cheon wrote:
> The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> twice instead of checking both SOFT_RESET_MSK (bit 0) and
> SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check.
> 
> Fix by using both masks as done in regmap_update_bits() above.

Shouldn't we have a Fixes tag here?

-- 
With Best Regards,
Andy Shevchenko



