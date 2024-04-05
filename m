Return-Path: <linux-iio+bounces-4078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B26899656
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB0283E68
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714172C860;
	Fri,  5 Apr 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="F4rmytWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053714288
	for <linux-iio@vger.kernel.org>; Fri,  5 Apr 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301282; cv=none; b=WwWnOeaDOKi1h6VyDAA7CBHMiy8errUOmSHiUHOGt/nOwVj865fQgVsMJknq+A0MibL1sxXSivJNvQpX8AkPpsMChXzWAtYUQ4qr2NX8wb5V2PyNpc93UcUlaUgC8+xmPcfm0mleAWfCnkds9nF1kfxxcRGfyiyIUX50gaLXS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301282; c=relaxed/simple;
	bh=SaiKRf3RQbp8FV10MR4XbyWuycnREfYo3jf47AiQHiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUmYUXxPpfxUfY8emp4F0hJQlMDydua/ryAYCFrHf+pTmSGroXaNqVhDhukrZoTCA4+94etia5k/KAgZybnrKzYOhhCgTXTOiW0loUsSiraDhZgwX/me2BrFKk9AWO0mbvfFFmzhRXOvYv+fIj55OUziCbL+Je7ph0HqRBgnfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=F4rmytWg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6a1d24770so1046828a34.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Apr 2024 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1712301278; x=1712906078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9skp/veFntESVv5IBHSeh0fw1XOzAJyP4HZp0g89cM=;
        b=F4rmytWgo6milu2bsaV3MoFR738b7PdQOldSqtJSnokLVD6WG9h3QzVYbt1nqH5YqJ
         E9/w4YutP8rKGE4qP3HBoJSxhDqasAAjLxknPBAYADa2kftYv3viLE3EvXBb9Vj9EzgI
         RX8P9gyrzk9BqhcQkNXY+yurwKkvyjEHQcyjhO6rYjTr8B1UoFAgc93Ow/PAXVgVr6m3
         PVFHZzFCB+AZL3pJCcGkE7H7kjOtvhwR+iLjzdOUjuL7iN77B/E6P4wKFcSLYOrSxSUx
         WJzZvURGaWnC6U+p1Sic1tDD4jkMqTeYlBfhs19GwNL7zNfeZJNcWENjyAD5t/PJnLws
         ZKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301278; x=1712906078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9skp/veFntESVv5IBHSeh0fw1XOzAJyP4HZp0g89cM=;
        b=fv2thME+iXeFCdM0qj43B09Sfi/4/ZdLg2wF5EK348tMbZD8zFla+1X8l4YNYr8eph
         yMxSn8TC0HU7/aL5oFrU3Ow2hB8Y263RUFuVRYCk2uSYZ7tJKI2Ts/cZ3S+i0f2SSvCg
         0fVyzEtxoGWseaat1I+HMl9W3SuqFw016Q00wzMVJrA8bAs9W93zf7vWEJzD8oNif7De
         NQk9Rq+M37rS8LAOPyKXqpKEROCKis5O0qIA3b+ZCk2VVYriYNk2lFfqShiUzMN3XqiE
         XJ5/twzpTKtvAW5MyKHtN1YB7iuYJX+0ZYFiS9WpdJdqey9lhT7kjjL615NMUMl8oBK3
         orjA==
X-Forwarded-Encrypted: i=1; AJvYcCXkedP55FrythUCOV7uMLzO07dY+87UBU4c2WReHMD35bcWIoGno/OKToixi0cLvfIVS+RFKSBzUx+K010BGzjPcIjDz13Tw/Vz
X-Gm-Message-State: AOJu0YyrNFrhwOkDQhzkP7zc506s/KSdIS9yfNe729jJU/MJol8fCdMB
	KzlX4lO3UH1GEt/ZmGWQPZR6S2Cvxf6sMbfwH/m1z3Qeo2iGFRjn6LtJfHkqGow=
X-Google-Smtp-Source: AGHT+IGja6uppOhisB7znHWGeozcffmJLxLnLmJLpdn9gQKm01/J3UU1NMKfhr8BvFaTqUkqaPpdbw==
X-Received: by 2002:a9d:7dce:0:b0:6e6:b9ed:694b with SMTP id k14-20020a9d7dce000000b006e6b9ed694bmr674113otn.26.1712301278118;
        Fri, 05 Apr 2024 00:14:38 -0700 (PDT)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id n17-20020a635911000000b005dc3fc53f19sm784922pgb.7.2024.04.05.00.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:14:37 -0700 (PDT)
Message-ID: <7a54d993-8aff-472f-8132-85e0ca79ff13@tweaklogic.com>
Date: Fri, 5 Apr 2024 17:44:31 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: Fix off by one in
 apds9306_sampling_freq_get()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 18:01, Dan Carpenter wrote:
> The > comparison needs to be >= to prevent an out of bounds access.
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/iio/light/apds9306.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 4d8490602cd7..49fa6b7d5170 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -635,7 +635,7 @@ static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
>   	if (ret)
>   		return ret;
>   
> -	if (repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
> +	if (repeat_rate_idx >= ARRAY_SIZE(apds9306_repeat_rate_freq))
>   		return -EINVAL;
Good find.

Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh
>   
>   	*val = apds9306_repeat_rate_freq[repeat_rate_idx][0];


