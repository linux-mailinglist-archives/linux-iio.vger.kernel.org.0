Return-Path: <linux-iio+bounces-9567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F697918F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C10284650
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD021D0142;
	Sat, 14 Sep 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSjhCTs3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927D1CFEAF;
	Sat, 14 Sep 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324921; cv=none; b=IamwptxnpOAbxAkm4+zFPO1pRjZ/AOgIYn3YHhBiDt0Jc8JMbll72b63BJuxgu+M54ub7kCytqHIJjzJm9neR0Rw0tUj6LDkWkXLLEs3lUuDdRbTE/6unJqs/5scasW6LtT+RAWKmc4Kl0lxF5WSjOKBn6lqkrQkUCCXrlbiy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324921; c=relaxed/simple;
	bh=2fTeVWE7QWDTn2sW0I+WOTnmmUaO1ntRFYLY3pAM+lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKYQNn0a7rcvb30wv043PYeN07AZ+3COC5qpC43PUOzXJerEJkVi3HauXFVFXFSEmXnKjsnzwaV9bk2QM933BRlOhltooKwab/FpAZBBgyV8BUDIkjWygvMT8vK0k2kl2qTzRh166xTrthTzUCEWpCGJlUknmBqLJODYSVKFFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSjhCTs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27209C4CEC0;
	Sat, 14 Sep 2024 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726324921;
	bh=2fTeVWE7QWDTn2sW0I+WOTnmmUaO1ntRFYLY3pAM+lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dSjhCTs3NFab/S11o37zKrQ0e88QCXet353PLnSP870jafGMk6MzoeSxE4o6V6W5l
	 OtikdHN/hS4mf1lPYZUW+YzM5rZWCKrwEbAcw7KlE+PLeMQx8o32W9bR/s4Djk8DHr
	 AvxtDnJ3V0UBa3TLArQvkqcm+57SXtTgCT4CBcYgFmPnV0vBHOoS3EjrIOfx7wwDBe
	 SjRciUrBcVf4mNaYpmyQtlEmV7aGFOtnM5mbt4uXMu2h+ZOCziyvrU6SKWqMkGJGWO
	 p/yFDRGi8tygZB++DojklK+qnong7M6EPmqG9oJGWZQG7u2wOxdUGKsp3U/Ycg1fsi
	 UaUtu06gWnD+w==
Date: Sat, 14 Sep 2024 15:41:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v6 8/8] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20240914154150.6ce9c1b6@jic23-huawei>
In-Reply-To: <202409140416.KWHXjFSv-lkp@intel.com>
References: <20240913135744.152669-9-aardelean@baylibre.com>
	<202409140416.KWHXjFSv-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 04:30:42 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Alexandru,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on next-20240913]
> [cannot apply to linus/master v6.11-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Ardelean/iio-adc-ad7606-add-bits-parameter-to-channels-macros/20240913-220501
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240913135744.152669-9-aardelean%40baylibre.com
> patch subject: [PATCH v6 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
> config: arm-randconfig-001-20240914 (https://download.01.org/0day-ci/archive/20240914/202409140416.KWHXjFSv-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140416.KWHXjFSv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409140416.KWHXjFSv-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/adc/ad7606.c:39:27: warning: 'ad7606_18bit_hw_scale_avail' defined but not used [-Wunused-const-variable=]  
>       39 | static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/ad7606_18bit_hw_scale_avail +39 drivers/iio/adc/ad7606.c
> 
>     38	
>   > 39	static const unsigned int ad7606_18bit_hw_scale_avail[2] = {  
>     40		38147, 76294
>     41	};
>     42	
Hmm. Seems like there is no code that would use this, so what is it
and where did the numbers come from?

Jonathan

> 


