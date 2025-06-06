Return-Path: <linux-iio+bounces-20256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A9ACFEFE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190CC7A819B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DC286430;
	Fri,  6 Jun 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjoeG4Ee"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E72286419;
	Fri,  6 Jun 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201291; cv=none; b=i/e/UYISJ2ArBKkRcu1iNhGKNGbdy8xnK+RaD0gO5nPV5NkOiYTdjM/1t+Av5PdWO3gv7of7r7sdRbt11PMRcNo4QM00jycMqVlYj7PDb01cho9FzXn+vSjUJM4F02SrZ9sBkakJu2PVq3NhAlnCdg7V8cJJzN4SYLbf1M4A4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201291; c=relaxed/simple;
	bh=2JiBmnzAZt/b74dkgeqvuFv398ChwEDi9igSc1dtK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R51Q56rpDAMuGSZJ2BNDpvzirutZluIf15HylUg85EQjkq/PY5hInkTrji6v8HryApLLO89SBUonrdhuI5ft1aBbr7Ucj/679f71re33WSFlQT9mvZB0hOQZOR0YmluYshzVWo2vEgEB/pplz6Am+uZfqcXiwbvy2cSRRKHV0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjoeG4Ee; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749201290; x=1780737290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2JiBmnzAZt/b74dkgeqvuFv398ChwEDi9igSc1dtK2s=;
  b=VjoeG4EegThTF57oJYt0nWJ+h7QEB//PDQ13D1Qyhd5qtjZVMrkkpIjr
   85AfpSeZCawXwr7s1Jb5xZ4CaqDEL+bhwwndwGmrvG9QizxS4Qnlwfeqo
   w2oU49tu6v3rdiX5s9wtbkKfc9XdSN9ETImRq6Dsiv59SHxtEpHUkLd8i
   KLXVPCC2X4N9zDg2RNrM00QyY+1p6k7Az0eWK2SxWTP59HXkrH+GKnziN
   +hyOAvGCWdS3GpD6cpuWwx1WG5mYieYNBC6QaW1OInJkzEisVFfPqZFDo
   1SIri/Hebtfi6bQlCk/W1m/SmkQ+Ojc2D5m3xLZObL7O4wbnP4uiZYyxK
   w==;
X-CSE-ConnectionGUID: N2oV0nJzSf6MPPp3GXDdnQ==
X-CSE-MsgGUID: lvwwZS03TfKwb7fBr+uhLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51447692"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="51447692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 02:14:49 -0700
X-CSE-ConnectionGUID: J9avamkJQriN8AOV9Y+kqA==
X-CSE-MsgGUID: EId4XSqmSiWf+8t7MGmokg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="150647666"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 02:14:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uNT9w-000000048uT-1wCU;
	Fri, 06 Jun 2025 12:14:44 +0300
Date: Fri, 6 Jun 2025 12:14:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <aEKxhPFDQEIN1xnm@smile.fi.intel.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
 <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 05, 2025 at 07:05:01PM -0300, Gustavo Silva wrote:
> Add a channel for enabling/disabling the step counter, reading the
> number of steps and resetting the counter.

...

> +static int bmi270_update_feature_reg(struct bmi270_data *data,
> +				     enum bmi270_feature_reg_id id,
> +				     u16 mask, u16 val)
> +{
> +	u16 regval = 0;

Redundant assignment.

> +	int ret;
> +
> +	ret = bmi270_read_feature_reg(data, id, &regval);
> +	if (ret)
> +		return ret;

> +	set_mask_bits(&regval, mask, val);

You can't do this on the 16-bit values on some architectures.
Maybe it's easy to implement cmpxchg() for 16-bit values there,
though.

> +	return bmi270_write_feature_reg(data, id, regval);
> +}

-- 
With Best Regards,
Andy Shevchenko



