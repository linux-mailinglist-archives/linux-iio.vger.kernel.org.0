Return-Path: <linux-iio+bounces-12763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C09DB323
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC71B21EFA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8E1487DD;
	Thu, 28 Nov 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWde0fdU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290C146D45
	for <linux-iio@vger.kernel.org>; Thu, 28 Nov 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778817; cv=none; b=JqNNQgxF7fjDhcQsipC5YtYm0vTFf6hNz4AhOZuqX9VJWiMijQntt8Jhv7eQypYdbz/woL9hW/MTBU9yprDq4B1nMaIDoAwAQs4P9pVaJNHfnmvqI9JduqazoeIS98PlvM6P3j2SqivtIluUsSIegw8oGKvmCA2zUc16hcC8Dtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778817; c=relaxed/simple;
	bh=pLOz2YuQx1sF3DfeE3uqwKBatiuvQk+YGAPg9txMgGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hZ9hq38FOozQK0AaH5RnUwyHhC8dUxhuzT0HqLLrcF0o9Vc7tHwcUDdLD2Cn0XQa2cY3i9k0fL+cDq/786AW1aH/6kMd6IgnSnYDs2EtShmo3DjCj4Qo5D4S8qzThTiM3I9VGcJU5FR+Xo1WkOeDwPw1Cimg/t8eI54dyBrn2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KWde0fdU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so4188755e9.2
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 23:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732778812; x=1733383612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kqh1KNqKnunsDJjpBDg96FW+lRvbuxgoy5i/G9dtrM=;
        b=KWde0fdUCQLkW/ahLZU/ncTXf0/R9V5r9rtkEOJp5Kd3NwC3i6uNY/F7ubBdTqv9VD
         +wLT7ZpgVPkqp54zt40mZDGkCtLiqarPCzHOMfKXVjgLp+ZlJLznjY4z7+14bE9bfFrL
         4CHcV+SLkSdC+NXyeAz9U2tCCnURh9NuTHKpAVAIrBKSXOfPvwMxVUMJIh4xS98sqB3o
         T851gWUIdGkbzVQdB1A72jD3iPezi//9yjgK2lfUN4++E88Gz7IGMarKZ2cKu/Wj1isa
         uTnwP/g6mEvL5j6O3iJWvIbZ3yI8Bj4UKHDKn9k2/eA+9WC1uefM2SdSHsxRmtAXi4PH
         9EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732778812; x=1733383612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kqh1KNqKnunsDJjpBDg96FW+lRvbuxgoy5i/G9dtrM=;
        b=lFoo4yTSEQriDFQnJ/s31Eq/SQxf6laSuLdDqkJwwY3sKrtdo9yNHwlXMQm9Pr5CIr
         iTUjkEuALm/imMzZbBiPepoNR/siUcoqzP03RzzVMl5DFDxvvCJZfG26YdEm1+ccSWQ5
         CLy0E+wy1ok14gcqybJqr47M/dq3065ANa6UxeeF1Umo2XCXa6hpAm6Xexfu+lIuO+lk
         0DnwuOUAYozXhrl9rxtaA3Ei2Bf5ZBMRJt/oXYlD9eQ0LDKPbglpk81OxfhxUKVEGMs1
         ByUqo6TOeIkfFB1DK7517eLjz1ptewhu4WQOWU8LE/QnWWoom5iR0RVMrrh7aqcadnvB
         up6w==
X-Forwarded-Encrypted: i=1; AJvYcCUASk1hHd7OBdgJ4pGWB8AdtKYixQ1xCYDh84QuMiSPfYJZTbXyBGQdkfunQj/ddfbfwm2GT+MMD2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxewx1qC2CPCBMhgeL2p9eEQ3UVYlKIALG3gunOjFavs2rmT+kh
	XqMwnA6zsjxFIBQtpZ3ZkpoYms9FZ6eYWaOeZJvqhcVykSMrDU0+h/ptWSv+qhE=
X-Gm-Gg: ASbGnct2wREsoOqJQxHafclZGShxsL59I8SXjhvkl7GRBamICw+/9afis3VFwTOp34m
	pTXmG//RGgRAUnnES5x5moNFbFLLy2y6ElRWp3vPfemcNBNG4M2yxipaxSAQ1pQvvVR4uvwnj+I
	oW3aFzK0yZYMJ8bUIrgpJoNe0wFqpCLz7m4cKJJ9gTfyr8Ioa7tX5MR+Fx4DCTjnRjeD15S1pNs
	ahF4sN2U0TnhXb67rPQ5TRMao+1nrzUfZl+PzaAsE/oi9c7o70zTjYQsjI=
X-Google-Smtp-Source: AGHT+IFLv++oJgv9Qwh3wkymj9ZOpRIqdb0ylXRtmM787YQXfSehzvlY/3Z1EYVe5oEXo8L0YnB7qg==
X-Received: by 2002:a05:600c:458b:b0:434:a924:44e9 with SMTP id 5b1f17b1804b1-434a9dcfedfmr57606425e9.15.1732778812529;
        Wed, 27 Nov 2024 23:26:52 -0800 (PST)
Received: from [192.168.0.190] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d26b5sm43808615e9.35.2024.11.27.23.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 23:26:52 -0800 (PST)
Message-ID: <e9d6831a-d0ef-440c-b235-fec18048deed@linaro.org>
Date: Thu, 28 Nov 2024 09:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: Fix use-after-free in
 sama5d2_adc driver
To: Pei Xiao <xiaopei01@kylinos.cn>, jic23@kernel.org, lars@metafoo.de,
 nicolas.ferre@microchip.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.belloni@bootlin.com
References: <1c67249dbc78678c451a155c04ef908627da6d1a.1732776187.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <1c67249dbc78678c451a155c04ef908627da6d1a.1732776187.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 11/28/24 08:45, Pei Xiao wrote:
> at91_adc_interrupt can call at91_adc_touch_data_handler function
> to start the work by schedule_work(&st->touch_st.workq).
> 
> If we remove the module which will call at91_adc_remove to
> make cleanup, it will free indio_dev through iio_device_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
> 
> CPU0                                      CPU1
> 
>                                      | at91_adc_workq_handler
> at91_adc_remove                      |
> iio_device_unregister(indio_dev)     |
> device_release                       |
> //free indio_dev                     |
>                                      | iio_push_to_buffers(indio_dev)
>                                      | //use indio_dev
> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in at91_adc_remove.
> 
> Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")

I believe that the commit that introduced the workqueue is different
than the one you tagged here.

With that changed,

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 8e5aaf15a921..4ba52b500054 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2491,6 +2491,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	cancel_work_sync(&st->touch_st.workq);
>  	iio_device_unregister(indio_dev);
>  
>  	at91_adc_dma_disable(st);


