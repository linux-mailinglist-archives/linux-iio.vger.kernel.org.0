Return-Path: <linux-iio+bounces-6949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CF9180AF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9468CB26825
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4818130E;
	Wed, 26 Jun 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="bbQ3F9/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E49180A83
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403837; cv=none; b=eiXdf0U+QIXYpcv5NrJItR6Jnxbl6/x3x2VOi+RDwvH3HuxLYHGjEaUKBeBcHvaeKx8mgq3rogiU8qvYaFQ4IRedZbGmId/K9K8ky9WiYvThtB04gObK6Rt4JxwrNKYRZJqATncI7w0jLP5M54vYFHttJ5Fj2kbC6/aUBdS9dcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403837; c=relaxed/simple;
	bh=xVPsUN2dj8hUX3hwXZx7bbERzlIaOLfEv5qp4l/oqGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xrx9Wn/6vhFdsrJTDyKbTyKhxqnVv+TfstGIgJRdM3qcJSBmu0+WRN3XgopQSk2ZJUE5NrGX8AsdpBpjl9V+g+pNbmYo8ajPYmbbIPq783P0utWLrd1DkVo4yvfhOytKH8s1Bfk14T14hSevi2/4HqnAfq4cyXRZBk+Rvmhz054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=bbQ3F9/n; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c2237d7aadso276967eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1719403834; x=1720008634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLp4nx5Il/H0k3+pTqRScL4zpsgACbKLzAI5nwUR2PM=;
        b=bbQ3F9/nWBYQrDygFJIUdZMuhLb8uoYffcIH6z5s74ClCoI65tEIYS+usJJaDJN1pr
         9a9FYz36CIFpwNPZPASArqmK5o1mDuX7dEva6N3jaio6izh/vMXhjWGqCPF0T2I4Pjsr
         veFvg5MbC3x0ednqlj3dYxQksaO/6vwOcfTIBf6ayYTkm3Mgp0RmQ9ziyeHqEunmuVe1
         6JIUe+xL+i1/Yg8EyexeqcTwtvQT4UpPW3yQdmJSElHyTnMkuMefQLWn1ves1PvGp3g1
         /i2jE4FPE5z0/pYRfjCrY/+Fn0/rasm/po9Aocf8YLD6nGjhpaFE25QlsAoqHoSroyZH
         86vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403834; x=1720008634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLp4nx5Il/H0k3+pTqRScL4zpsgACbKLzAI5nwUR2PM=;
        b=I86apGoeIyf42rcbZJoNg8ujtkdkXEbUrMLn+DzJ1/Nwib9K42W33Z7ZdZeA3f9FuL
         wRDvhtqnDy4Lbzhh96IuZFdGodiC3pAubNBZYB+IFgKvxiFRz8RQxJu23TMsRf8JxZFs
         JDN7fTGANorvsH4uqgLI/ohyl4VKzwkUNFKKiuAEaiI3yrQnT1DfVm9lptahRDLxcRG5
         LKdAi8kMLJt8AIAT4kZj5ARd/hMiBKby+MB8ZKGzM8pCADn0jLy4yYLrI4FAYSQWfyCQ
         zcRE91KDXZiwRTi438TA29q7qS4vLPTHIHWq4Wu29GDxsqLSO/sv+sy5sHygAJ0Hrn63
         3jwQ==
X-Gm-Message-State: AOJu0Yz77RDBM05KCuUQsaN9X8f94e2WohB/m+YEQA/yS0VsRMBq4rms
	4xMLGRz/GWHDeGdtRK/DF2O+rNxbLET18i6/eWV63ovqlw16OBGPBor2ud8J+9M=
X-Google-Smtp-Source: AGHT+IGmCk4m8jKgmDzkZK0zoZ/t9+RPx5xi0vYMNSB4H9T+czkp5m9btLXWuRAUEupFiRYEcmt9tQ==
X-Received: by 2002:a05:6358:430f:b0:19f:4ca6:86c2 with SMTP id e5c5f4694b2df-1a238a6704emr1373721355d.25.1719403834509;
        Wed, 26 Jun 2024 05:10:34 -0700 (PDT)
Received: from [192.168.50.161] ([180.150.113.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba79eb75sm8695843a12.70.2024.06.26.05.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:10:34 -0700 (PDT)
Message-ID: <bea64407-fcf4-4a87-bd77-6bd3f3e2f70b@tweaklogic.com>
Date: Wed, 26 Jun 2024 21:40:29 +0930
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: Fix error handing
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, dan.carpenter@linaro.org
Cc: linux-iio@vger.kernel.org
References: <20240625210203.522179-1-muditsharma.info@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240625210203.522179-1-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/6/24 06:32, Mudit Sharma wrote:
> The return value of 'iio_gts_find_int_time_by_sel()' is assigned to
> variable 'intg_old' but value of 'ret' is checked for error. Update to
> use 'intg_old' for error checking.
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> ---
>   drivers/iio/light/apds9306.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index d6627b3e6000..66a063ea3db4 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -583,8 +583,8 @@ static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
>   		return ret;
>   
>   	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> -	if (ret < 0)
> -		return ret;
> +	if (intg_old < 0)
> +		return intg_old;
>   
>   	if (intg_old == val2)
>   		return 0;
Hi Mudit,

Good find.
Working well on my target dev board with your changes.

Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>


Regards,
Subhajit Ghosh

