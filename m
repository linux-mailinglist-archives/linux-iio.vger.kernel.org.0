Return-Path: <linux-iio+bounces-14226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE8A0AA87
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D203A7174
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84F1BC9FB;
	Sun, 12 Jan 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvK/tfQ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89E1B4135;
	Sun, 12 Jan 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696050; cv=none; b=aWZu2GiigVNDNxGc/PnKC+9Rs3OOl/BxpneGTDKF32SvBsl42NwGAQRjznyicvKSq63lIHBKnOCijw9bjz/DuarMpvNY4x5XW72irqDOl8iAnoMxj6muExUBiOBmqIkxLf/u7Pp3jZbC27S60BTcGCTUOvScmtqPO/BL1jNu/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696050; c=relaxed/simple;
	bh=7uOWkHH8UcGTGaRqhqKvqG7A/cJ7tHUf3cEH/3nGjYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUi9/zL618XJv5zXRIR20po5Mhr56FO4wIzaJHp7EW3EGCL+lt984B5qyzz9z1mRu/k/5ZUALw0ErTfDXYrBvFIxIZKYPBsaD9DeJs32eVCaXxCmJYjq2LIV7MxGWOBkAaDKkysxno/XzwG2+0lWn3IStUBBkMQZ+Vf99NptKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvK/tfQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCC7C4CEDF;
	Sun, 12 Jan 2025 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736696050;
	bh=7uOWkHH8UcGTGaRqhqKvqG7A/cJ7tHUf3cEH/3nGjYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WvK/tfQ12ur7+hVzrLbX57PCjkbWBxRRpqGf/Y47vYawBKSRTqOYMJun0xj5TczvC
	 wVeBCWdBQSGFaphXfzA/8PR8t7jTDNmGniCSNNitMLkoePYHyT40M1SIAdIL+5rAxm
	 tFG/UoL+6mJc0hEnr2gPr7/MlpNMYcf6ROfgP8o5kAzPix6D63VH0cYYCwJfHsy2qX
	 0DodCev31UGtGaDuAl9hhbQP8QVQTm6VQ1GMCJWSSWbFjzWQ0EMtmHaw6n5I8N5QLA
	 Q/oUCKbCH9mTr1+uGL6VNLU5k6IzjEl1lOSOD3waSGovkGt8W4oep41zUg//QqHcRS
	 MMPmQoVx1GOVw==
Date: Sun, 12 Jan 2025 15:33:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Robert Budai <robert.budai@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Alex Lanzano <lanzano.alex@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <20250112153358.16631b46@jic23-huawei>
In-Reply-To: <202501111951.NHXp98OK-lkp@intel.com>
References: <20250110074254.38966-6-robert.budai@analog.com>
	<202501111951.NHXp98OK-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 20:03:22 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Robert,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v6.13-rc6 next-20250110]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250110-154645
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20250110074254.38966-6-robert.budai%40analog.com
> patch subject: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250111/202501111951.NHXp98OK-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111951.NHXp98OK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501111951.NHXp98OK-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/module.h:22,
>                     from include/linux/device/driver.h:21,
>                     from include/linux/device.h:32,
>                     from include/linux/iio/iio.h:10,
>                     from include/linux/iio/buffer.h:10,
>                     from drivers/iio/imu/adis16550.c:12:
> >> drivers/iio/imu/adis16550.c:1202:18: error: expected ',' or ';' before 'IIO_ADISLIB'  
>     1202 | MODULE_IMPORT_NS(IIO_ADISLIB);
>          |                  ^~~~~~~~~~~
>    include/linux/moduleparam.h:26:61: note: in definition of macro '__MODULE_INFO'
>       26 |                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
>          |                                                             ^~~~
>    include/linux/module.h:299:33: note: in expansion of macro 'MODULE_INFO'
>      299 | #define MODULE_IMPORT_NS(ns)    MODULE_INFO(import_ns, ns)
>          |                                 ^~~~~~~~~~~
>    drivers/iio/imu/adis16550.c:1202:1: note: in expansion of macro 'MODULE_IMPORT_NS'
>     1202 | MODULE_IMPORT_NS(IIO_ADISLIB);
>          | ^~~~~~~~~~~~~~~~
> 
> 
> vim +1202 drivers/iio/imu/adis16550.c
> 
>   1196	
>   1197	MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
>   1198	MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
>   1199	MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
>   1200	MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
>   1201	MODULE_LICENSE("GPL");
> > 1202	MODULE_IMPORT_NS(IIO_ADISLIB);  
> 

You need a base commit from rc2 or above.  (technically 2 patches after rc1
but rc2 is probably a better choice!)  This will be material for next kernel
release anyway now so this all may become moot!

Jonathan

