Return-Path: <linux-iio+bounces-21662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BCB0542C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428B5178834
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10E2741D4;
	Tue, 15 Jul 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iub0AfNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623227381A;
	Tue, 15 Jul 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566959; cv=none; b=o47XLDUEypZJTBjMztqOWEpMNEMbye4I0SEBMlnpwIzv8vHSNkIh6EwWYyGZyBzraQpdlSfX5FRx18kixT4C2hiJQgxAd89F2jG5WwetqGWMCuo1icO8YU7YLrDat1u5HWPKgvhDBDTadv2h1ccWQcoiLsO8N5dTuwwQNYedVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566959; c=relaxed/simple;
	bh=uM50ySx9Kjkj0T8Mi2M3p5ShRWkdmqxZHE6SDBMnJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiRoH2o8sX1fsaOQhlPJlxi8Os4+E9Wnedkg4ROb7leVH6kOXhjLXfdM3kucXpDevEpi4Zp3An5WiB77yIRFlyy2Cru/AySTcP6MAlU7hz0ECmJiQy9IE9abEo5m/E27JhGj9BabqR9yyWM7va72wrBUJ9JtoTeqmWLe8g8cpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iub0AfNx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752566958; x=1784102958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uM50ySx9Kjkj0T8Mi2M3p5ShRWkdmqxZHE6SDBMnJoo=;
  b=iub0AfNxZm6SmF4VBloL2un6RCqObyTuzejf5KWahWaRF/9J8etyZ5wM
   iF7jD5nkgQBMspUf1c0Rh+nDza7rnh3qabEpRc90iKkjz8WlEO4PA0l3Z
   hGaAYwAVkziIUSB9NqWTkf5mPBc3osxVUOHvO6aUxDRkcWelksuFxGn5p
   fP92kCZCr7fi3HPv4ZsctprgIPbhqj6FoqRL+cJ7XdkNVjIkwCeDj9/KV
   t0q53fWStIqHI9HNspJGC2RTnJ2+XhoAOJSyEvD4Phk9+aR0mYV71+va1
   gaVMP6477x23Rdl0shNNoI3QdHj+R3YHuxDiyQ6ayv8HVbAi/F21lBw5F
   A==;
X-CSE-ConnectionGUID: YHlWLjctS0K9CDVjvHJ8Sg==
X-CSE-MsgGUID: FFmbneozQ9y4y5772m50sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66135169"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="66135169"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:09:17 -0700
X-CSE-ConnectionGUID: QBGt5UhhTJOQEZE4rxikvw==
X-CSE-MsgGUID: Us1vguXYRJC85Ok8RzRAhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161702936"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:09:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubair-0000000Fam8-4B3M;
	Tue, 15 Jul 2025 11:09:09 +0300
Date: Tue, 15 Jul 2025 11:09:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Message-ID: <aHYMpVIXJNuOfE55@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-5-bf76d8142ef2@tdk.com>
 <9d091fe4-3068-4e8b-8a9c-49c25036a216@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d091fe4-3068-4e8b-8a9c-49c25036a216@suswa.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 11:21:17PM +0300, Dan Carpenter wrote:
> Hi Remi,
> 
> kernel test robot noticed the following build warnings:

It looks like a false positive, but the code is fragile.

> 1fb5c2bf7348d0 Remi Buisson 2025-07-10   99  	unsigned int fifo_en = 0;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  100  	unsigned int sleep;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  101  	int ret;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  102  
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  103  	scoped_guard(mutex, &st->lock) {
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  104  		if (*scan_mask & BIT(INV_ICM45600_GYRO_SCAN_TEMP))
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  105  			fifo_en |= INV_ICM45600_SENSOR_TEMP;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  106  
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  107  		if (*scan_mask & (BIT(INV_ICM45600_GYRO_SCAN_X) |
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  108  				 BIT(INV_ICM45600_GYRO_SCAN_Y) |
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  109  				 BIT(INV_ICM45600_GYRO_SCAN_Z))) {
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  110  			/* enable gyro sensor */
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  111  			conf.mode = gyro_st->power_mode;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  112  			ret = inv_icm45600_set_gyro_conf(st, &conf, &sleep);
> 
> sleep isn't necessarily set if nothing changed.
> 
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  113  			if (ret)
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  114  				return ret;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  115  			fifo_en |= INV_ICM45600_SENSOR_GYRO;
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  116  		}
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  117  		/* update data FIFO write */
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  118  		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  119  	}
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  120  	/* sleep required time */
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10 @121  	if (sleep)
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  122  		msleep(sleep);
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  123  
> 1fb5c2bf7348d0 Remi Buisson 2025-07-10  124  	return ret;

-- 
With Best Regards,
Andy Shevchenko



