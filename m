Return-Path: <linux-iio+bounces-25465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A69DCC0DE1C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 148105071CC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D129BDA5;
	Mon, 27 Oct 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Mrdusd4/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40F28FFFB
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570080; cv=none; b=GJr+TJjlemVKhuR28rzRwKfqHfbbPkJ8XXTYf9xvaLdtnxT5z90904sJlUfNeZTiGalyY1h4nAp0mEqqfhLIgmodBtjBXqysbX1JNyfEGUCVWU9QXsiR/myVU6cP58hKMLAH2k/5bsdRAAb/2kIO3MQ4ZwFOJQla95cznx1yWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570080; c=relaxed/simple;
	bh=986YysIn8Fe1HXmKjFlWdhnJPvdFAuoGinhshsvQYEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgwIDatxE7Mcv4vRzIqSuO7mTXZ0+tBnSV8lpy+v9sJ3o6nNEI7qhbM7d+O5n+YW/0mcwzvVZTeJUdLXv0oF3tNXTWXjIX6fRrs+9gKbq5muyDxfV7uFoagipJFyK8IX0aJjFk0h1JW9WcNVJeQ0k8wO6TEo9R/QWl3zXb28SOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Mrdusd4/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so5512134b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1761570077; x=1762174877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jhqQbXCqzrcL3E+XppIF1w4lMrJvn7tFwhW0pKGsNs=;
        b=Mrdusd4/UrHujgfIM3r9y+6fHUre8j/Vk6SV+/p1jSR893iCoGBRnKgKAAw97QS6Qo
         Sq0LS5AQzWrHZYRCw+vxwpxeu1PnH9q9sXs6vx9TUbLQqovrBd73ac4abA03sI68fd5V
         1plCq2miZezlAPOnSFNWn5upPFO4KtPHs4XVEvXMkZfCAuP9vZq6s54Y25iIdc4iERKh
         6nvxfXDfy0rrvoOE61czW+p53S93Ixltx1YxVlZESLMlHQ/jZqpBV1mi+Yzq9oHCfazs
         jAOtdvu/+gX0qxJ/esm511fMTkFd9GNTWb5o6p8EykNOe06EibYxrYLpJkTzYbFAxJ9q
         RzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570077; x=1762174877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jhqQbXCqzrcL3E+XppIF1w4lMrJvn7tFwhW0pKGsNs=;
        b=Bc6PJ+vtGEBDmrp2SiZrG1Qubqs0cjf9FjDoAnOTnsrjpjs4IyyO2NX+nFzFCuEBto
         JcCE8SBixE/05p0hzHWq0P/HtSF7kaGhtTqSwJu+XtRz9hk7NygPjIj3RdzHQnfZy1Mq
         Yyik4bkl4lQF4xSDtLfDG4WWdEjPbhiMd0d8sPd7iv+QLliSszRZT01AbTGcDPPduOeW
         0Vnec+UQLYJUf/6Yk3LgnEWwUWRSWg3o0VaTIrKfKZCJKf+tKdVmbx25aeyk3JLNuojN
         5pbzLHqd9PzIg6drZcejmQPsbxXtfUk68DH7fboyZcQaxY7kTESJwiwN8ICKVdFKKVZf
         GYvA==
X-Gm-Message-State: AOJu0Yz39i6/uX05beHYkqvTga1wVjzEy68UVs8bdB3gIO+Vdz2iVAbb
	krX12jdOg1T+AIEtLn1CApnN/9B1BHAyI7byoKfZCj7AYam3m4wiRvcDtOemXk1+m2g=
X-Gm-Gg: ASbGncsOITtebTodc4ntFSaMAOyL2/A/8NFhzEhO4j9qo7E2dd9xE5paHMx7++zcNyq
	liqxekb2Uh5M7JJvrdSpoTM3yy7YnzARnD+cEspAZoOAFZ9atxGy0mg8ISoqvwQxefyA48+ubRJ
	5Cs5E9OH8pNzZDy861cDYx+iTC57wMPwjrOKtr9T7tUp/aYNHXXWNb23ahesfCFww6/ETAgCfRt
	NisyNGJclpSPn280kKF7bmYuIu0TuuI5p/RP7LtojVF1fB+nAIX6eFFDcHs1vLD7OtAmhfPBDpU
	I4P27taDtxSbToB8zuv9VwahkoJ2hEJCfWLG0zrzAqGkS0dMNXd8JrNpTK7ti8HcBIFOB5zw/zM
	EmQ+8iIsdIK4iYujvPqfX6Lz2sF7m090uzK1PheEy4OQne+9GMfEatW8Bwc/nRosjvt3yhr+N6h
	9vhBWF1QpIATOHjTJptkh0kCZlJLpruTnzTiwwTgWfhM+PfNfE60qi3bGs1J7TZBpH/Gk=
X-Google-Smtp-Source: AGHT+IFz597Y7d5Kn0G6bkVUP3oCOfoggvomYjxgDPnOcMBnKIl/JIfYJkpaxyKj8FEWIIYpt3UWbg==
X-Received: by 2002:a05:6a00:8c5:b0:7a2:8853:28f6 with SMTP id d2e1a72fcca58-7a2885329f8mr12142180b3a.22.1761570076019;
        Mon, 27 Oct 2025 06:01:16 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm8034589b3a.35.2025.10.27.06.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:01:15 -0700 (PDT)
Message-ID: <301aff96-5565-47cf-b519-27234ea53ea8@tweaklogic.com>
Date: Mon, 27 Oct 2025 23:36:32 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: light: apds9306: convert to use maple tree
 register cache
To: Chu Guangqing <chuguangqing@inspur.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, javier.carrasco.cruz@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024073823.35122-1-chuguangqing@inspur.com>
 <20251024073823.35122-4-chuguangqing@inspur.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20251024073823.35122-4-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/25 18:08, Chu Guangqing wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>   drivers/iio/light/apds9306.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 389125675caa..7e68cca0edfa 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -350,7 +350,7 @@ static const struct regmap_config apds9306_regmap = {
>   	.volatile_table = &apds9306_volatile_table,
>   	.precious_table = &apds9306_precious_table,
>   	.max_register = APDS9306_ALS_THRES_VAR_REG,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   static const struct reg_field apds9306_rf_sw_reset =
Looks good. I will test it on a real hardware soon. Thank you.
Jonathan will know more about regmap internal implementations.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh

