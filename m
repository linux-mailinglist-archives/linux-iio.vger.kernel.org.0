Return-Path: <linux-iio+bounces-21910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B3B0F59F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792841693ED
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D192EF9BD;
	Wed, 23 Jul 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzUqI9LT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CB2EF29B;
	Wed, 23 Jul 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281756; cv=none; b=AJ/6g4gw3Obqaq1OjTKO2o6xF3FgflVPXEVXIu2Z/E7iKDxpjVF3LAiCbZyCv+MJ1cL8PQ4GDUuWm6lP/uK5wUXqVNfVHLA4dQuBTxfsrf0li4/KhKmqyUDSyN0l9RASpVpA6ebCJgf3B4DIHXbbQN9mbL7MW/MV7qOFI8Eo3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281756; c=relaxed/simple;
	bh=EixATOmvq6d/Vv+wlPKnzbFFsh7ZcTMGBLQS273gUj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsFlpzOJ6cYNZHeJQyGCQ//P5+EEOl4ruCdsnzrb0BZkpBVL6+kze2h3b4Zccgev5jAwhFq88hEW3uOEy2F7o+BRgcf2xXPN/wZ+J3d55ZI/Vhtl05AH6URrSFXwaI0DIb2qWt2cdxsWsMuvkjwtTO9+SnrYXwVYXI0WE1J0/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzUqI9LT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753281754; x=1784817754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EixATOmvq6d/Vv+wlPKnzbFFsh7ZcTMGBLQS273gUj8=;
  b=WzUqI9LTgAoxdFLQ8i52jtIfnPCbu38QlQuqM3qHL5JUQfkYML17/Y12
   kYykGDLXSklFU9NEXIPRw/LjP6jhjntndBh2gj+3CvVuQRLCA8wptU9FW
   BGmB8KwfPJtAvnREMiQD5xqo4xKM0EfCZ255xrcuX1hjKyGWrKIzSNMf0
   5EjRz0/I9yuenFHjLmnxvm+StV1dsQr676rGcrKIeQfsvtonJSaLIJiwd
   SPzwFob9MzCU5ypJnHvUVxlwW/lCr7AKqrRoGet0aKkHh9dldyqyHgNZe
   ygEhXx3SYZmh8GZCyKeo0vCs45RTciq7Y5hwZV7ogTRKeayGi+k5qqWqc
   Q==;
X-CSE-ConnectionGUID: F5nYzJM6Rje4fh962ml7bA==
X-CSE-MsgGUID: BzcryFWDS6KIMkbaxIk1Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59380916"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59380916"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:42:34 -0700
X-CSE-ConnectionGUID: 073E5ZBqT/2LTIIiW0yMZQ==
X-CSE-MsgGUID: C9oyC7lPTZeMSwWIXj4f1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="158821994"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:42:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueafs-00000000JdJ-1Mzt;
	Wed, 23 Jul 2025 17:42:28 +0300
Date: Wed, 23 Jul 2025 17:42:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Bansod <akbansd@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <aID01DxC1Hf2PK0i@smile.fi.intel.com>
References: <20250723141359.11723-1-akbansd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723141359.11723-1-akbansd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 07:43:59PM +0530, Akshay Bansod wrote:
> Update the sysfs interface for sampling frequency and scale attributes.
> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> and recommended for use in sysfs.

...

>  	fs_table = &hw->settings->fs_table[sensor->id];
>  	for (i = 0; i < fs_table->fs_len; i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> -				 fs_table->fs_avl[i].gain);
> -	buf[len - 1] = '\n';
> +		len += sysfs_emit_at(buf, len, "0.%09u ",
> +				     fs_table->fs_avl[i].gain);
> +
> +	sysfs_emit_at(buf, len - 1, "\n");

Still looks a bit weird (while working).

>  	return len;

I deally we should have a helper doing all this under the hood for plenty of
the (existing) users in the kernel.

In any case, I leave this change to others to comment, I don't object pushing
it in this form, either way len - 1 is simply weird.


-- 
With Best Regards,
Andy Shevchenko



