Return-Path: <linux-iio+bounces-12879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AC69DF281
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DB12813BD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883511A9B37;
	Sat, 30 Nov 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVFURK4A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012F192D6E;
	Sat, 30 Nov 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990134; cv=none; b=F58FRwiEyntCJXOqX/LltllXmFe2UdYFx0gTWHrpXS72dmpN9pTmcvmpPfWmaiFSpidcZ8CmEm/QN3xwY91ZO4E5JYXQcgccaCp/EGBjM3i+2aaaEmAp5IzYCDwlqzCEvZsq+GaO4JeEkuPYmqmRrkRmTPsUEF4LMSvCJ/0bEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990134; c=relaxed/simple;
	bh=OLFgKRmtTL1ozpXOhlhvYa/HZKHBwX8YzJP43LrcI4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvKpnDB/Rx+4leXLFChOzHvLSOpwbmfUHu7pJnpZknjXaq52AAo/maurSHhjvc6g94jT7owGLmlrXKcZiEtKewdkTLJViIpDMV5bKBK12ubR0UXmEnyuqPFrzOUN82OAXtkY1CKp2B50QTtj7rXwKu4Ub7SzB4m+hqFx36wOzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVFURK4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF0C4CECC;
	Sat, 30 Nov 2024 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990133;
	bh=OLFgKRmtTL1ozpXOhlhvYa/HZKHBwX8YzJP43LrcI4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVFURK4Ai4+7bpUYlItetom46Xh+kBXetWO2EbZljpJjjf/wG3Oj1I1yI3V8ytind
	 OquEO07kyw1EILgkxz4VLAPLUp/mOMqE4DpAL7cpDL3lAOHfsEcebe6/nZZcAj6+DH
	 qw32T/+lQIIz6NR7nUrarK0zXGZsnOfY2EpXerNgjzrg1fdP1A/6pJ5IBF7ro7z8YD
	 LQgJmVu3cPVNLVR3U2UYkga37d19rCGAxnmx0aYic+mVoIf6Dkqkm94aoZENG7Qhu2
	 sFFvxsUdTWyFq0YiyzWlBm2cELGtBRzg5x+1civwkzoQXHfLs0xgY8NJfUzjFqu7ep
	 XuEgj0D0awQFA==
Date: Sat, 30 Nov 2024 18:08:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, oe-kbuild-all@lists.linux.dev, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <20241130180844.27a5c8e0@jic23-huawei>
In-Reply-To: <202411290107.KXHPQXRf-lkp@intel.com>
References: <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
	<202411290107.KXHPQXRf-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 01:20:41 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Matti,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on a61ff7eac77e86de828fe28c4e42b8ae9ec2b195]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/iio-accel-kx022a-Use-cleanup-h-helpers/20241128-170626
> base:   a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
> patch link:    https://lore.kernel.org/r/9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount%40gmail.com
> patch subject: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241129/202411290107.KXHPQXRf-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290107.KXHPQXRf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411290107.KXHPQXRf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/accel/kionix-kx022a.c: In function 'kx022a_write_raw':
>    drivers/iio/accel/kionix-kx022a.c:507:9: error: implicit declaration of function 'if_not_cond_guard' [-Wimplicit-function-declaration]
>      507 |         if_not_cond_guard(iio_claim_direct_try, idev)
>          |         ^~~~~~~~~~~~~~~~~
>    drivers/iio/accel/kionix-kx022a.c:507:27: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
>      507 |         if_not_cond_guard(iio_claim_direct_try, idev)
>          |                           ^~~~~~~~~~~~~~~~~~~~
>          |                           class_iio_claim_direct_try_t
>    drivers/iio/accel/kionix-kx022a.c:507:27: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/iio/accel/kionix-kx022a.c:507:54: error: expected ';' before 'return'
>      507 |         if_not_cond_guard(iio_claim_direct_try, idev)
>          |                                                      ^
>          |                                                      ;
>      508 |                 return -EBUSY;
>          |                 ~~~~~~                                
>    In file included from drivers/iio/accel/kionix-kx022a.c:8:
> >> include/linux/cleanup.h:308:9: warning: this statement may fall through [-Wimplicit-fallthrough=]  
>      308 |         for (CLASS(_name, scope)(args),                                 \
>          |         ^~~
>    drivers/iio/accel/kionix-kx022a.c:521:17: note: in expansion of macro 'scoped_guard'
>      521 |                 scoped_guard(mutex, &data->mutex) {
>          |                 ^~~~~~~~~~~~
>    drivers/iio/accel/kionix-kx022a.c:532:9: note: here
>      532 |         case IIO_CHAN_INFO_SCALE:
>          |         ^~~~
> 
The precursor is coming through tip as I understand it.

I'll have to hold off on applying this until after rc1.
> 
> vim +308 include/linux/cleanup.h
> 
> e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  306  
> 54da6a0924311c Peter Zijlstra 2023-05-26  307  #define scoped_guard(_name, args...)					\
> 54da6a0924311c Peter Zijlstra 2023-05-26 @308  	for (CLASS(_name, scope)(args),					\
> e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  309  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  310  
> 


