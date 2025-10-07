Return-Path: <linux-iio+bounces-24822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AADBC1682
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E7454F607D
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56802DBF6E;
	Tue,  7 Oct 2025 12:48:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A02E0410
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841336; cv=none; b=oZK6HxUz8jfWPsIPxD+tgTNmvk0CY8zfvv65Tp56J39XRtWJ5f2na4XubtksQcCKNehMRDK9kEDDsdEExeGoDHDbPiU4qvFJfTfhNGppwlTcpqJQ+QhrD2gk0cwpjeZDHPHZut/kGgkpz4o3FHwL4WiD20BHLaqKziYI8IaTGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841336; c=relaxed/simple;
	bh=UHumerp+A0bu+PJmhmb3hVWNWDM7ak4KKxSbxW8Jdak=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKfQ/D5Q7HIawVvK5Vu6GOHG0J+13jZ6q6oaOsW2ZpTJ6iCg307Ity0Z1qL6Bjn7+8nquCNh9TDTjYHl0XSZmaaBXbMqsd34ihFu+CjMdAR+yOYEnDZsqnWT/ibrtrTVl4H0zdfor7iOWIWeFb6GboWT69JE/B4YEYqeyoO8oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgwsr1rYBz6L4yD;
	Tue,  7 Oct 2025 20:48:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 730741402CB;
	Tue,  7 Oct 2025 20:48:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 13:48:51 +0100
Date: Tue, 7 Oct 2025 13:48:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Taimoor Zaeem <taimoorzaeem@gmail.com>
CC: <jic23@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH 2/2] staging: iio: ad9832: move struct
 ad9832_platform_data to ad9832.c
Message-ID: <20251007134850.00005f9f@huawei.com>
In-Reply-To: <20251006094025.259440-3-taimoorzaeem@gmail.com>
References: <20251006094025.259440-1-taimoorzaeem@gmail.com>
	<20251006094025.259440-3-taimoorzaeem@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon,  6 Oct 2025 14:40:25 +0500
Taimoor Zaeem <taimoorzaeem@gmail.com> wrote:

> The struct ad9832_platform_data is only used in ad9832.c
> so it moved there instead. With this change, the ad9832.h
> file becomes empty, so we can remove it.
> 
> Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>

Hi.

See my reply to earlier thread for why this makes no sense and what
needs doing to actually get rid of the platform data in general
(and hence the header).

Thanks,

Jonathan



> ---
>  drivers/staging/iio/frequency/ad9832.c | 21 ++++++++++++++--
>  drivers/staging/iio/frequency/ad9832.h | 33 --------------------------
>  2 files changed, 19 insertions(+), 35 deletions(-)
>  delete mode 100644 drivers/staging/iio/frequency/ad9832.h
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 49388da5a684..0517858bc5da 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -23,8 +23,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include "ad9832.h"
> -
>  #include "dds.h"
>  
>  /* Registers */
> @@ -117,6 +115,25 @@ struct ad9832_state {
>  	} __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +/**
> + * struct ad9832_platform_data - platform specific information
> + * @freq0:		power up freq0 tuning word in Hz
> + * @freq1:		power up freq1 tuning word in Hz
> + * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> + * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> + * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
> + * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
> + */
> +
> +struct ad9832_platform_data {
> +	unsigned long		freq0;
> +	unsigned long		freq1;
> +	unsigned short		phase0;
> +	unsigned short		phase1;
> +	unsigned short		phase2;
> +	unsigned short		phase3;
> +};
> +
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
> deleted file mode 100644
> index d0d840edb8d2..000000000000
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * AD9832 SPI DDS driver
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -#ifndef IIO_DDS_AD9832_H_
> -#define IIO_DDS_AD9832_H_
> -
> -/*
> - * TODO: struct ad9832_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad9832_platform_data - platform specific information
> - * @freq0:		power up freq0 tuning word in Hz
> - * @freq1:		power up freq1 tuning word in Hz
> - * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> - * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> - * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
> - * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
> - */
> -
> -struct ad9832_platform_data {
> -	unsigned long		freq0;
> -	unsigned long		freq1;
> -	unsigned short		phase0;
> -	unsigned short		phase1;
> -	unsigned short		phase2;
> -	unsigned short		phase3;
> -};
> -
> -#endif /* IIO_DDS_AD9832_H_ */


