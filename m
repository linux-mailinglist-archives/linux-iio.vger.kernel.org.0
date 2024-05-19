Return-Path: <linux-iio+bounces-5129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DC8C95D7
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 20:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F71F21467
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC86D1C7;
	Sun, 19 May 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGaYEROF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93396CDBA;
	Sun, 19 May 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143896; cv=none; b=rFfi0KhKgYnlXPZ5HHCrsxzyHHI5z31QaY1t9iwNA6JStVMN5tD3nfkMpxLI+Iaknz39UP90aClraEFjZBDfFOFKZFeYehmxR9agRK16nDgsvrWJPFrIJHfJrOyMby4DDIZpgbmWZVwdDiLh1x0oJp+t1QA2+Ob+26J21flWCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143896; c=relaxed/simple;
	bh=lVCcZNgsc8zO7s/yax8GQlYEW+YH4cqOMEwcZkdmLCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyndJ/LlulFIYSBORCO+YHFHo1v7X1uKseoZED8EDdXFJCEA0K35C928vLEXstUXmwLUBpf7XgrwiiggOcmE/RzsMLe5oOL0fSYAI5nKGEx+vumPKWX/Z6Mw9gU77pAOgICgWet+8msCrrQ4DlGWmNMxOhQpArS5b29PJrqeQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGaYEROF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F81C32781;
	Sun, 19 May 2024 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716143895;
	bh=lVCcZNgsc8zO7s/yax8GQlYEW+YH4cqOMEwcZkdmLCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGaYEROFbcsOWz4dpnikAEeKk0KglCeQYp/W+CSvt4z32IW7Z+LXduDKBzcnX72gg
	 At0ZFGT4Rtde6o2ijU6n17ZvoE9boV/fSOoAHuJVthPqzo+cjyjozyE3l9fpxT56uv
	 b5sp41dVVQTpruGRFQntcOQFfVW/S9PYKNIJFSCf4m8c8cbOmyzTxPi+JFzKRHMvH5
	 TFWzNGrIL7sLes9h9LjyEDlkMt2fhJuZHBKm7sEVbHt7X7ERWW77/ZGU1hIaHaPrlZ
	 B00X6LWkGoZI3dIDCqTvuavjqUPZGhPseoK2o7uVN19Ys658+7QVCebwMDXoaSEpKF
	 ZIRJ/eZZd7Hfg==
Date: Sun, 19 May 2024 19:38:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240519193805.3bc1d842@jic23-huawei>
In-Reply-To: <202405181400.174vWAhr-lkp@intel.com>
References: <20240517074750.87376-10-ramona.bolboaca13@gmail.com>
	<202405181400.174vWAhr-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 May 2024 14:47:01 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ramona,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [cannot apply to linus/master v6.9 next-20240517]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240517-155051
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240517074750.87376-10-ramona.bolboaca13%40gmail.com
> patch subject: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x family
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240518/202405181400.174vWAhr-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405181400.174vWAhr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405181400.174vWAhr-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/imu/adis16475.c:523:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]  
>      523 |         &iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
>          |         ^
>    drivers/iio/imu/adis16475.c:523:9: note: (near initialization for 'adis16475_fifo_attributes[0]')
>    drivers/iio/imu/adis16475.c:524:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
>      524 |         &iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>          |         ^
>    drivers/iio/imu/adis16475.c:524:9: note: (near initialization for 'adis16475_fifo_attributes[1]')
>    drivers/iio/imu/adis16475.c:525:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
>      525 |         &iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>          |         ^
>    drivers/iio/imu/adis16475.c:525:9: note: (near initialization for 'adis16475_fifo_attributes[2]')
>    drivers/iio/imu/adis16475.c:526:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
>      526 |         &iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>          |         ^
>    drivers/iio/imu/adis16475.c:526:9: note: (near initialization for 'adis16475_fifo_attributes[3]')
>    cc1: some warnings being treated as errors
> 
> 
> vim +523 drivers/iio/imu/adis16475.c
> 
>    514	
>    515	static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
>    516	static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
>    517	static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
>    518			       adis16475_get_fifo_watermark, NULL, 0);
>    519	static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
>    520			       adis16475_get_fifo_enabled, NULL, 0);
>    521	
>    522	static const struct iio_dev_attr *adis16475_fifo_attributes[] = {
>  > 523		&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,  
>    524		&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>    525		&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>    526		&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>    527		NULL
>    528	};
drop the dev_attr.attr parts.  This will 'work' because they are all at the start of
the containing structure, but it should be the iio_dev_attrs as in a similar
case here:
https://elixir.bootlin.com/linux/latest/source/drivers/iio/accel/adxl372.c#L1009

>    529	
> 


