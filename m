Return-Path: <linux-iio+bounces-11680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5F9B7563
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B696B21085
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF114D2A7;
	Thu, 31 Oct 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uck0mrUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFF10A3E;
	Thu, 31 Oct 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359937; cv=none; b=W20aYMeA6ZbbILB9Dd7nMMqhCpXHsy8QTuyD++uoIPTI1BhJyIAIUcGbtBwssaAF1FfVnq/Su5Gw9nEQ6m2hpySAr1QP1+7C2PKaORjqotuvsQTRwojtBu3mIf72tUHX+C90n6klhAoTDC9mEKclLa2IpJxiCd6LHJyj0j/a92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359937; c=relaxed/simple;
	bh=ByNryT807jPQO2/Nq8j6KK8oRmiXZmFa/Dm/RwytioE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7DJFOiEf+UApIhOy4zFM9YBy7V39+OWNtOTrVow6DDGU6Nb4yxdpz4IpjJhOk/+9ZaCqbpIoL8jrPncLCu2UrSn+4scoi4Tpe025POnBC3HsH3NsLFGUXm+ze48KDZ6vUPheYNiGX3vsA+tUv5yfAl/awAq12zun6rPEY0Hl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uck0mrUo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so981769e87.1;
        Thu, 31 Oct 2024 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359933; x=1730964733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXBCAE5YFs7bIo9qj6bwIQiECKD+0RVcggJ63Dxnmlg=;
        b=Uck0mrUoQMzrT0LO7yuBtGjjMA5fawcnAOW/FKSAnyrLcxh5Ao/JyK0JD9640gY/0p
         mI5Mb6sah3BsSLXtlU8n9BPmjVG2dfaRODHNf0DBe6klpqc0e5Wqph5cj5Ld7+3ugnMu
         v38w279LQvm+Mgh0LQtakeDJI/fijDRKBnI01ai+bxALPRNeWqyP07Z5xOclhjL+fU+3
         ErPY1R9sNfg9q7W/W8dDt/E1+U7Wo/DwmDjQZwVYBwC0ylZPOdlM90VtvuKXdZPktKkl
         vYwI9zcZBY7RAqLzHs8Rp9Uio2iLgYE6O4mZNKuUGuCka1Ex3k578ZEw66lzQqTmREtr
         YELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359933; x=1730964733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXBCAE5YFs7bIo9qj6bwIQiECKD+0RVcggJ63Dxnmlg=;
        b=KnIqnzoU6qQUHka74DWL4udMgc9e4UB947DCDxqEDxyyB71c3TlJ90yqRiLCmPaN5k
         q1/oLQzkYClQjFPFGR7B8GP1A15oBykqAZm/zU2T536knDP5ysB3EMDBjvgj6hChRwZq
         pHpe/gqN0Tu9ZPpIJ4ZAy+ANEwizMl/j8fJwYS2c5x3MZs8LHZshwVzlg9xd+EFVBQ6O
         0thJLgYIrXE+JE5tOTQoAgSKNhjpU9b07e+XfrqkNx2GxJPVKwA63vcvLGV3ihC1Gc8b
         Bqbv1OxfrfZu2ZtqLgfg49C3x6TKwa+WemneWMjV6F87zfWc55y9KCGVc7OANnPObgUy
         jt9A==
X-Forwarded-Encrypted: i=1; AJvYcCUMc+9mauOdhYkvVbuNM1RidKHUud+Y25RK9Cbe03HunYbElgHl1nR9fTqmnUx/fk+1YEJlV1Si9K4=@vger.kernel.org, AJvYcCX2z55H+oLHOqLWV5ZHfXIITeAogeW8ENWTo4oHxis8cwvGGzQ/cxl7+VEuFaDHYpprKlWn5pUD+WLzYzz8@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRnA6P0aJKdA4/HH85U12jzoDXRMgruPEEq1jpgLhUZfdBJlu
	WZjWUD/ujmF5knNwRMozzUbjDxTqvnYobLmE8E3uBwrjlQtXb31r
X-Google-Smtp-Source: AGHT+IHhXTBpS0JMzRUCqX+rY8GoD1Grx/DK8687++qnb7Sryc7gUhJGbtTkg+njK3XB+s1bvdTD2g==
X-Received: by 2002:a05:6512:1090:b0:539:f13c:e5d1 with SMTP id 2adb3069b0e04-53b7ed18ccemr3441270e87.38.1730359932788;
        Thu, 31 Oct 2024 00:32:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde02easm112589e87.250.2024.10.31.00.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 00:32:12 -0700 (PDT)
Message-ID: <9ee46109-8503-4b5d-bfd4-45b7ac03029a@gmail.com>
Date: Thu, 31 Oct 2024 09:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: fix memory leak for
 iio_gts_build_avail_scale_table()
To: Zicheng Qu <quzicheng@huawei.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
References: <20241031014743.2313121-1-quzicheng@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241031014743.2313121-1-quzicheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zicheng

On 31/10/2024 03:47, Zicheng Qu wrote:
> In iio_gts_build_avail_scale_table(), the memory allocated for
> per_time_gains is freed using kfree(per_time_gains) before return 0.
> However, the type per_time_gains is 'int **', and the memory allocated
> for its inner elements is not being freed, leading to a memory leak.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>   drivers/iio/industrialio-gts-helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 59d7615c0f56..f2450b2e740d 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>   	if (ret)
>   		goto err_free_out;
>   
> +	for (j = 0; j < gts->num_itime; j++)
> +		kfree(per_time_gains[i]);
>   	kfree(per_time_gains);
>   	gts->per_time_avail_scale_tables = per_time_scales;
>   

You're right, thanks!
This, however, was already fixed by:
https://lore.kernel.org/all/20241011095512.3667549-1-ruanjinjie@huawei.com/

Out of the curiosity (and no need to respond if you don't feel like) - 
are you using the gts helpers in some of your project(s)? I am glad 
seeing these fixes coming in and just wondered if all these bugs are 
found because these helpers are being used outside the ROHM drivers :)

Yours,
	-- Matti


