Return-Path: <linux-iio+bounces-4958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55E8C3198
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DCC2821BB
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3251C44;
	Sat, 11 May 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXtmD/zk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315D51034;
	Sat, 11 May 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433784; cv=none; b=bRSktxDUwBXUghLW5OruANTyHQ60GNyBbZS9lzXdTVXNYxahjLWtelZxsmZtiXTTW+1gNYIkqYxfZflb1cUACyIg2W3jVdxcm8cPSYFR+wnb8CRyuvSObYDFKlzlLLYERjDQIIUc/ZnP9rCtM7u7vvU47BgVN2NV92w0yC9X7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433784; c=relaxed/simple;
	bh=nMMGfSK4wOZIKca9fxpU6gUwCMQgGMZfXqeXKxACGhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhQP0Dur90OgQGl6k3rdKsFUezMGkKfgAi7a2bIXwQKmNxZ8mG85FU+xgxjwbfCdPAKOhJmXlkN7Yo06XAAVH257JHXycD/I9zbN8iCobA24IusZHjhi1v2ZJgjewxOD+nMsco6TU5TEIGnvhGNy3EMtCNUUIrRq9BVoOr9xlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXtmD/zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E783C2BBFC;
	Sat, 11 May 2024 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715433783;
	bh=nMMGfSK4wOZIKca9fxpU6gUwCMQgGMZfXqeXKxACGhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXtmD/zkf7sWXZqSKrL10bz6muqF3rOATCIjQXqKOe3+n5W0Y2Bmymxb0s3s84Ou+
	 X8aTx3RM8taxKbPO1Jt9nuLp7y9hKR+DyjexbQpt6eeueJJnROtK7QQx1CFuCk+F/y
	 vtyv0YvQ07Po7fUPVQUkkQ0uNdAPBWR6GoUiDd4X+lzuRr0DYT6cygLHHMTudthDjg
	 xIxkGeTE6zZgQyTnt8hyKpAT7p7NzSd/k+E3mND0BNteLVWIc0nr0b65DeMrE+DbN6
	 LNvbeVt6YUKCgIKzxq5ktPyOrI/xJZh/HnvFdYYu0SN6bG8BQUz0XdtqUvPZ0QAwLI
	 NZwZH4lgghmNQ==
Date: Sat, 11 May 2024 14:22:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 4/8] iio: imu: adis_buffer: Add buffer setup API with
 buffer attributes
Message-ID: <20240511142252.4c3b11f0@jic23-huawei>
In-Reply-To: <202405110642.5PmTepVs-lkp@intel.com>
References: <20240508131310.880479-5-ramona.bolboaca13@gmail.com>
	<202405110642.5PmTepVs-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 06:21:53 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ramona,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.9-rc7 next-20240510]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240508-211559
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240508131310.880479-5-ramona.bolboaca13%40gmail.com
> patch subject: [PATCH v2 4/8] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240511/202405110642.5PmTepVs-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110642.5PmTepVs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405110642.5PmTepVs-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iio/imu/adis16400.c:24:
> >> include/linux/iio/imu/adis.h:530:60: warning: 'struct iio_dev_attr' declared inside parameter list will not be visible outside of this definition or declaration  
>      530 |                                               const struct iio_dev_attr **buffer_attrs);
>          |                                                            ^~~~~~~~~~~~
> 
> 
> vim +530 include/linux/iio/imu/adis.h
> 
>    524	
>    525	int
>    526	devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
>    527						      struct iio_dev *indio_dev,
>    528						      irq_handler_t trigger_handler,
>    529						      const struct iio_buffer_setup_ops *ops,
>  > 530						      const struct iio_dev_attr **buffer_attrs);  
>    531	
> 
Forwards declaration needed.   I don't think we'd want to include linux/iio/sysfs.h in here so
struct iio_dev_attr; before this is the cleanest solution

Jonathan



