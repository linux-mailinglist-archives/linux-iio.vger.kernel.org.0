Return-Path: <linux-iio+bounces-24202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0AB7D402
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0BCF4E27B5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CD2F60C4;
	Wed, 17 Sep 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGmkMkmt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC6285CA9;
	Wed, 17 Sep 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098858; cv=none; b=ZV4YCksEQrfiKhcs1vLiDI22S04spf5CFDOwouVWDtecRaOQFKtkPmGm2axlOv3BD07ZYu1wYgtqy8SA8WdXYiB37wVA4uzjOP4xgQ6bmCnBYu4NHtJstoU4R9ex6TRrvhZl3kFkWcPT/QpjZfGw9ogRfqyPfAeRTfZ6MRY63j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098858; c=relaxed/simple;
	bh=WkzohTudC0x+vl+4/fcJ6KBEZ7BqS45IMhaCRsr5tz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxKquFE/RCmBF/dD7kf0Bj5KOPTYi/O/gKmDH5sRUR1IXggXljkdXe7LfyIcvL0BLs8gIsVnjtnKR+dZrmn/E6y0zu7wWIHxFai83b32xGs59axQz9WEL6PzjeeFSDHS8ADVcRd9mXf6QCrbwA/UvXAw0T7YlaBg7YfOW8GAVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGmkMkmt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758098856; x=1789634856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkzohTudC0x+vl+4/fcJ6KBEZ7BqS45IMhaCRsr5tz4=;
  b=kGmkMkmtRUZONGElO2fp7izoEdkxJZ+BIQdAzYcE+JM5Q7aK8PYySyQA
   DlQ0LOvGVoKmjaTuwZs0Di8wu+uG4Wt7qeFvnt+Q907OTjKuEG2nKeuUe
   ElNTyijAilu8h1cBDvOt124QIAO7NJpEpbfyjMylYh77rR39pF+KdxNDm
   c33RjeQBNWKW4Qy4IxIVB06oaKkfOzJmouAmUGjwZkEEWoFr8jqzV5xCF
   2PGS8eZl5O++DwYrqyV4TSe6PPPsdoC4qpm8dOdQ6DzWnU1OwAgi4FSdc
   NbIrwuMR7t2unos2KeyTZ9paqChUMalYxx67zTSH8czc+LfD5U08lBJ3y
   g==;
X-CSE-ConnectionGUID: dKY9MTl4SveKOaV5bj0bow==
X-CSE-MsgGUID: Mei8hZy3QaiOsA0bCmj2fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64215358"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="64215358"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:47:36 -0700
X-CSE-ConnectionGUID: 4kOutKrdR4+/3lllUWX+dQ==
X-CSE-MsgGUID: oiC2OLyRQe2kCrB/Zsl4cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175101917"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:47:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uynp5-00000003l5i-0dqx;
	Wed, 17 Sep 2025 11:47:31 +0300
Date: Wed, 17 Sep 2025 11:47:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: ABI: document accelerometer event attributes
Message-ID: <aMp1orvA-SSSZeN2@smile.fi.intel.com>
References: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
 <20250916-bmi270-v6-2-6acd8d26a862@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-bmi270-v6-2-6acd8d26a862@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 08:38:24PM -0300, Gustavo Silva wrote:
> Add ABI documentation for accelerometer event-related sysfs attributes
> exposed by the bmi270 driver. These include threshold, period, and
> enable controls for adaptive magnitude (any-motion) and rate of change
> (no-motion) event detection.

...

> What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en

>  What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
>  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
> +What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en

> What:		/sys/.../events/in_accel_y_raw_thresh_rising_value

>  What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
>  What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
>  What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
> +What:		/sys/.../events/in_accel_mag_adaptive_rising_value
>  What:		/sys/.../events/in_anglvel_x_raw_thresh_rising_value
>  What:		/sys/.../events/in_anglvel_x_raw_thresh_falling_value
>  What:		/sys/.../events/in_anglvel_y_raw_thresh_rising_value

> +What:		/sys/.../events/in_accel_roc_rising_value
>  What:		/sys/.../events/in_accel_x_raw_roc_rising_value
>  What:		/sys/.../events/in_accel_x_raw_roc_falling_value
>  What:		/sys/.../events/in_accel_y_raw_roc_rising_value

>  What:		/sys/.../events/in_accel_x_thresh_rising_period
>  What:		/sys/.../events/in_accel_x_thresh_falling_period
> +What:		/sys/.../events/in_accel_roc_rising_period
>  What:		/sys/.../events/in_accel_x_roc_rising_period
>  What:		/sys/.../events/in_accel_x_roc_falling_period
>  What:		/sys/.../events/in_accel_y_thresh_rising_period

With the given context (above and below) I'm not sure this is the best place of
putting an attribute in the list. Perhaps something below will not disrupt the
xyz structure (like mag cases)?

> What:		/sys/.../events/in_accel_z_thresh_rising_period

>  What:		/sys/.../events/in_accel_z_thresh_falling_period
>  What:		/sys/.../events/in_accel_z_roc_rising_period
>  What:		/sys/.../events/in_accel_z_roc_falling_period
> +What:		/sys/.../events/in_accel_mag_adaptive_rising_period
>  What:		/sys/.../events/in_anglvel_x_thresh_rising_period
>  What:		/sys/.../events/in_anglvel_x_thresh_falling_period
>  What:		/sys/.../events/in_anglvel_x_roc_rising_period

-- 
With Best Regards,
Andy Shevchenko



