Return-Path: <linux-iio+bounces-7379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0129292AF
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621B8282E50
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D673462;
	Sat,  6 Jul 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbHIdkPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F355589B;
	Sat,  6 Jul 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263512; cv=none; b=DhhBVCFbtopy3cPu2Kp6ryYM/csJxjSfLjQFu0lBajKcCPl9XB0yTVsQs6twqer9qetyIfYyQd/mugcZ0ZMv2UkD8DSHS/CHc3r/vG7ioBlJRtj+YnZniw/BCiNRwpGWffz6Zkx5+jkS5WFIJqVWeS4SlM7yUg5yXd+pcmSlWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263512; c=relaxed/simple;
	bh=XFmbSHZPyF4ncxdS/EMdWTrzlspJlgiQH+AGeELwC5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1ejs23K2C54XU5idDF4yBqSE0ZoKaI8qG4X7VEiCpT+4XSHuixXnB/UeJJKrPsrhWuB+a2St6u7HTW+UKvYZtnB4ky1Pxe7dpp2pEYFby89c8uKAemuu8Rbd54TzHiWJkS6mt/FuKwYrHaHhoWTdyEqbRVEJUM9GeDF4s7kRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbHIdkPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A15FC4AF0A;
	Sat,  6 Jul 2024 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720263510;
	bh=XFmbSHZPyF4ncxdS/EMdWTrzlspJlgiQH+AGeELwC5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbHIdkPbyDI0zp//4XKdrhjCHYfOseNHpqfSG2aP9N1bRlc1erSqCraNVQerpPRVE
	 +nCs33FtE6eI8u+WE9v8zzyvtVYSjBTP1fNmZsyQg+yPGRRQjZTSBwMrxsFJIDO+GF
	 w+cAw3SNTsEahv+QsSNEFKSFj9RN/h0enVpmsDLUgt1c4IWxRcKnQTJCmJIzvHm+r1
	 a5b+jzPsymuIOYfD94hesrH9nnNUonKILW6BmBleFIWtr2KE0Tr3d2EaGF9Vy+4dFT
	 xLoFym3fBBueEDZRfklXBgS1uG9ZpeJfED7e5o9uNyM/IZVthbgm5ps4SoHaK9/Q70
	 nofrsLjAdMITw==
Date: Sat, 6 Jul 2024 11:58:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
Message-ID: <20240706115819.49a570e3@jic23-huawei>
In-Reply-To: <202407061311.ZEmwMY8m-lkp@intel.com>
References: <20240705-sg2002-adc-v2-2-83428c20a9b2@bootlin.com>
	<202407061311.ZEmwMY8m-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jul 2024 13:16:36 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Thomas,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on d20f6b3d747c36889b7ce75ee369182af3decb6b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Bonnefille/dt-bindings-iio-adc-sophgo-cv18xx-saradc-yaml-Add-Sophgo-SARADC-binding-documentation/20240706-040736
> base:   d20f6b3d747c36889b7ce75ee369182af3decb6b
> patch link:    https://lore.kernel.org/r/20240705-sg2002-adc-v2-2-83428c20a9b2%40bootlin.com
> patch subject: [PATCH v2 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240706/202407061311.ZEmwMY8m-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061311.ZEmwMY8m-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407061311.ZEmwMY8m-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/adc/sophgo-cv18xx-adc.c:85:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]  
>       85 |                 struct cv18xx_adc *saradc = iio_priv(indio_dev);
>          |                 ^
>    1 warning generated.
> 
> 
> vim +85 drivers/iio/adc/sophgo-cv18xx-adc.c
> 
>     78	
>     79	static int cv18xx_adc_read_raw(struct iio_dev *indio_dev,
>     80					  struct iio_chan_spec const *chan,
>     81					  int *val, int *val2, long mask)
>     82	{
>     83		switch (mask) {
>     84		case IIO_CHAN_INFO_RAW:

I guess you figured this out but if not.. Key is you need to define a scope so
			{
>   > 85			struct cv18xx_adc *saradc = iio_priv(indio_dev);  
>     86			u32 sample;
>     87			int ret;
>     88	
>     89			scoped_guard(mutex, &saradc->lock) {
>     90				cv18xx_adc_start_measurement(saradc, chan->scan_index);
>     91				ret = cv18xx_adc_wait(saradc);
>     92				if (ret < 0)
>     93					return ret;
>     94	
>     95				sample = readl(saradc->regs + CV18XX_ADC_CH_RESULT_REG(chan->scan_index));
>     96			}
>     97			if (!(sample & CV18XX_ADC_CH_VALID))
>     98				return -ENODATA;
>     99	
>    100			*val = sample & CV18XX_ADC_CH_RESULT;
>    101			return IIO_VAL_INT;

			}

>    102		case IIO_CHAN_INFO_SCALE:
>    103			*val = 3300;
>    104			*val2 = 12;
>    105			return IIO_VAL_FRACTIONAL_LOG2;
>    106		default:
>    107			return -EINVAL;
>    108		}
>    109	}
>    110	
> 


