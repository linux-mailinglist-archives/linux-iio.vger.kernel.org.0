Return-Path: <linux-iio+bounces-3423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C287735E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EFA1F213F3
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4A545BE0;
	Sat,  9 Mar 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aAK4D8VQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252DBA4D
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009823; cv=none; b=irP/KqZUcDdnMwkLdg0bqjUASuFV1XzEClAk9c7C+Fd3VcmRCvcusmKm/lDW2yD5M/knFDREm//uJKFhyvLE1U/V0ZvQp4G40GndVF5zvtO5qlJKMkKo+iQ8HbFJ7jblb6PVm5Gq3Hc62J7pZW4/ooRKZJnZv6skefqls55jznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009823; c=relaxed/simple;
	bh=c8PmTWLnnDb//vMowOEKQb0imEN0Yqkw5iZkuZXjioU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0ZKJrgUEmWnEpmwphh9XCoB1WjMwJ9NPvolkEGqZIMp1ni8xjvB1+WEUF89EOqlyp2gw/7QKS/Y82BxPb318sh13zExusKOay8sAbDuNPRyr60fMsYNTIYEhxR/sT9E4HREAbfCkB9gphKzg/L23+8ixmB7zhfvP/1VM/rZKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=aAK4D8VQ; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id j1eIrVhPHEp3aj1eJrrqB5; Sat, 09 Mar 2024 19:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710009746;
	bh=0j0PKKkwYYvccxlRTUfbfOmfkc4Yb70UUL+d4S0VMjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=aAK4D8VQ2lfRVr54MgsRiBdhNCTXu1jbvzCEAWkVAS0JMSaZ/qY+fPRUUT6cg7XVU
	 oXCHU5lIZ9LjOXHq1vSHQGqny++IK6FGxdWOJgx7zWor10kSE2H4ZhJgNwjbaOK0ND
	 uwB1tjiAGL4NgOHN+4B/L39CyNU+rludAvZ9jfmGR/BcSLQO7tQ/H7x/NXZnY5Gema
	 Rxx52DN7raL1EH2GNMyue8N6zOz5BV5VNAXD3+erXujY3/ftAcYe3RayNOGaZgd8zL
	 KeNMEicN7pDLc8aYlQZxj9pfMyNLhsz20Nh7g3X9hgSmBr90FtItXZ/mO85HpHvcmZ
	 Yixw0nja3tpew==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Mar 2024 19:42:26 +0100
X-ME-IP: 92.140.202.140
Message-ID: <b354e05d-c699-47a7-b4e2-dd844902b85c@wanadoo.fr>
Date: Sat, 9 Mar 2024 19:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: core: Calculate alloc_size only once in
 iio_device_alloc()
Content-Language: en-MW
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: Jonathan.Cameron@huawei.com, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
 <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/03/2024 à 15:04, Andy Shevchenko a écrit :
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/iio/industrialio-core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8684ba246969..c7ad88932015 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>   	struct iio_dev *indio_dev;
>   	size_t alloc_size;
>   
> -	alloc_size = sizeof(struct iio_dev_opaque);
> -	if (sizeof_priv) {
> -		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -		alloc_size += sizeof_priv;
> -	}
> +	if (sizeof_priv)
> +		alloc_size = ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN) + sizeof_priv;

maybe size_add() to be super-safe?

CJ

> +	else
> +		alloc_size = sizeof(*iio_dev_opaque);
>   
>   	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
>   	if (!iio_dev_opaque)


