Return-Path: <linux-iio+bounces-10603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4699E21F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BECA1C230A2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9531E3769;
	Tue, 15 Oct 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+YQlj2d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D21CEAD3;
	Tue, 15 Oct 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983027; cv=none; b=Pm6K2OBlNbT4x3rinXxEhc5YZbWQcS+t06Vc9NxxFe6mT1VGOD1wdD0PVtkPC4bjA9r/iqmkVwMh2f/4chOsOHnqM1bEiIuxPWn4bKUF1RNcvd6ts2y2qsSSOJ5YgQyuVPI5i++rdScwt2nwdwW8IlSHQczQQWhAPihZ+dvXPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983027; c=relaxed/simple;
	bh=AMkaLA4Mi5Chw4QIHjguMez3+mBcL4d6+Dof6LEPiSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H+j9scFPdVoKbilQr2mlSjypMYxRFaNzlXd43FA/x6fT5utmq0EY7HDiU7rBLI689YkJ0QOnsacX2W/NHJaEPzKzTfWSThf+8hV/RBx6gRFU7/uo1TDv7k50ZdpHcvh5zTpXWwIbsEnpwuLBgfVrT4PFqaOxTvS2EI1MpNEo5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+YQlj2d; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e690479cso2805905e87.3;
        Tue, 15 Oct 2024 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728983023; x=1729587823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amCmXoa7/qdp/E+J5s/pZO9Jv9VzLkAxAzBHyIQJmUY=;
        b=P+YQlj2d4VdUXMPUX46DogycCpnVSBXEir4ACdVTELj8/7wrsMz2zGnMOVqvQcqwJJ
         Nj877TEBz+0XfWnPQ5Q/Pa9ql4JnG36RYp3rXUwRyfBgpiUp4uT+jjihALhoK/6z53Hz
         3lsZYoHSmKynXyFD6tP9YXS4wI0pYKZV6/nsw/J+HrfY2t9l9QdhaPFgfQI30u5Z4SQF
         UwBFxeoNv+es8uAwBcj6I9QnsZ/PJ9PsdHdErPJ3NUVozLEq74vAa3zpwO5u95Bch5iD
         HGlDGEg9wNSaKpPCwO0ZeiC1+35tE5xsHLkclW4NHRS9GQ4CTudiDGykP/KO9Qh8GxdU
         0vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983023; x=1729587823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amCmXoa7/qdp/E+J5s/pZO9Jv9VzLkAxAzBHyIQJmUY=;
        b=cQ7PtWxIeP2pFACT96vdenB/sMVmK7mys8fbm+YGekMs706/siHKAUnJCziwy0LZ2y
         h1ZeTWwWDMt3zyOFWpC5mTjDf5RpWHKD2x1gcOWLpQNuopIzXxFbz5i3U5GQL9i8Xehe
         ozEhYflXh3JFarsIbcsRWzFNe2bPHNxnBTslh+jnpF15Qp+PdTNfF8CGSUzp2z6rnthO
         6hpyp2w5lhKS+Qox5j1I297sWj61ioJZ9o7LdPdYop8vMhbuko+xKEPYzZAwtcZJ/79F
         tpunW29CJSlpaSaOFXSQt84ZxliLVjKD6Arp30U/8fbePk0QtcDiWz+KVotm6Y+NFGsN
         tU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJL2shwnxtxGU7Q5++Z/75wV6FdygBC/mEodRIaGFLM+axOY1RFJxZ6XUALXlPDkafnTCgWzocmv0=@vger.kernel.org, AJvYcCXdPi9nUQWwH9nDJkiCl1pzPG7yiCKtyrTyjY6IVz9NBflJoiSC7wQaV/VWtv572+Rz1DbbV/WwqydWSWu+@vger.kernel.org
X-Gm-Message-State: AOJu0YyskkKwdHkkZOJZyFuumDZ3W5UCuawG5fSj/NqyE9IBK0OCYCrq
	Yj4c3G3ec8xiJRx8Y5www8x34H92gKYqPNMRme+2e1v6MYmZdSaO9TL3vQ==
X-Google-Smtp-Source: AGHT+IHST7XtyFDypUIKnunu4IfyPe4x8iA1ssf2/T4YDQlXkLYy6xBay6W2eNxE7uZo7HCTCIenwA==
X-Received: by 2002:a05:6512:2398:b0:536:a695:9429 with SMTP id 2adb3069b0e04-539e54d7706mr5077020e87.10.1728983023079;
        Tue, 15 Oct 2024 02:03:43 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1a86sm108936e87.73.2024.10.15.02.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 02:03:42 -0700 (PDT)
Message-ID: <76d96ab6-4e13-42b9-bff0-03a2e1b96f57@gmail.com>
Date: Tue, 15 Oct 2024 12:03:40 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix memory leaks for i = 1 error path
To: Jinjie Ruan <ruanjinjie@huawei.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241014013144.576701-1-ruanjinjie@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241014013144.576701-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks a lot Jinjie. I appreciate your fixes!

On 14/10/2024 04:31, Jinjie Ruan wrote:
> If i = 1, and per_time_scales[i] or per_time_gains[i] kcalloc fails in
> iio_gts_build_avail_scale_table(), the err_free_out will fail to enter
> kfree for loop because i-- is 0, and all the per_time_scales[0] and
> per_time_gains[0] will not be freed, which will cause memory leaks.

I guess the loop never frees the memory pointed by the first pointer in 
these arrays. I mean, the freeing is not working as it should even if 
the 'i' was something else but 1.

> 
> Fix it by checking if i >= 0.

The fix seems good to me. So, with a tiny change in commit message:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> 
> Cc: stable@vger.kernel.org
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/iio/industrialio-gts-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7326c7949244..5f131bc1a01e 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -315,7 +315,7 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>   	return 0;
>   
>   err_free_out:
> -	for (i--; i; i--) {
> +	for (i--; i >= 0; i--) {
>   		kfree(per_time_scales[i]);
>   		kfree(per_time_gains[i]);
>   	}


