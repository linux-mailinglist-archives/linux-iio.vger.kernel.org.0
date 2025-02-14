Return-Path: <linux-iio+bounces-15512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6BA35734
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 07:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D6118921D1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6D202F83;
	Fri, 14 Feb 2025 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef7FfXMf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BE188713;
	Fri, 14 Feb 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514980; cv=none; b=cr6bCsaT5TsCy5hCwyImItXsVB/zswW6sVRTrNqrBdYq7WFhDyzQPigeXzt1a21SrJ9DqYWDrYAD9vRITpxTXAJ98LtkIutDy6K+y7V13uw/Yq0eHWiRgisbPFPwLzpjkASxKYmD3y1HPv4CUlErCofKgx/oiUN7n5sy2FzIW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514980; c=relaxed/simple;
	bh=dYpkevYzawbzjUuruy7i8kw1spl4TjUm5dcxUK0Hjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUkB2gKM4javy+gpzgoW6JcNrWWMz2Q0qg5gLdcv5qX8pnnoqla3CljgEfk5SKK8n1HCbcCMUX7woO5wCeGr4+wKPtcHDSaZJOr41lstpEThlA2hTaWe2Gs2rkzO5CJVLKEjFtCHs50D8GE9XMnVR/yOrjuRzPXZ2yW1gmLVikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef7FfXMf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30737db1ab1so17543701fa.1;
        Thu, 13 Feb 2025 22:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514975; x=1740119775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UIqO0+pohQOFJGHr9iSuTHJlFXGJf4NaATqUI/o3Oc=;
        b=ef7FfXMfnxfwUVF0VKSijMG5STdSMHGokFsFb0RC6Jo+G/dRR1PVLQOFsrsC6ELnEa
         uTBM+GowjS0bIUALPXZdH5ItWXEhEp5EmWoD64VYNDJK1z9RASAekd/4Zs8TYD4FDlo4
         dZHxZsQBklQ/VSLYv8qGp8SlhkTl7ZsjR4tMKhiTFH3pgI8/yMEI3fKLgev7g2kHlYku
         r3Kwj56L9CuB7240hMJmTNm/DnYEp4+OzpaUAY51jD8njYB4La5F/72G3ahvAQYxZz7x
         fUIRHV/GCGrYg2K3cTYtK1N4IN6oyI0C6oHHFWlei5Kv31lTtzKc4HreFJEAq+Oy1A+4
         OHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514975; x=1740119775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UIqO0+pohQOFJGHr9iSuTHJlFXGJf4NaATqUI/o3Oc=;
        b=DDOlAjMnipShQZsoykv90kuxIVSTkSZk6Y8x0eC0ClAO+L/6FJZ4Qys6gBuEkB4CQW
         C2kbTYOtkogUqiHb3X4ciqDKWqGA0TOU46H750RXg5L37LZteIjR38UlSMB2Y8zNOXlj
         YzYGbx+YQPi9zXgqax/0xWcNxHYKstlyrIUyWbNg04warpFKYkB0fV5/F1YmlOZmIc3S
         9qgg4c+3zj5GPTyWboa/HeW5l8H7+emHGtwHjgpN6JJ6nvcfj/gQN0a6Yp8SP0EYxHlw
         6qhjch8cIsKbsQ3gMto1Q55fx8bXPoozHJDQaIqw0dNbDAg+8wZCtmPUKXxGx+J/y1Dv
         /JIA==
X-Forwarded-Encrypted: i=1; AJvYcCXZp7WOW91sk0HvhFwa7f+rxn9xfZC6Hd3h8dwxyIcee2UEqdE8298AhFa2MMEtoXP3YNnNUiFICjh0H1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE64+YOjcIzow2b4G5YoUoVQxLnA9GwpK54fYHC7J9P090UpzX
	q8YNgy8n9sM8EJhEH1dNUUtSEVj82ibq5PovOiPI4DQGdZfachNBWscIMA==
X-Gm-Gg: ASbGncvKLJDQCLPhVXcfy+j2qQVcdoiEZc+m+9+Bx2W8Dv7LNkCmqCpDHFy2JunRBqz
	zuUy98bcO6mxds+aZ1cuHqT34YwJ1H7TgO40nkAyqjMLiaNMhgureXkeKX1uJL3gOFxrIBl86jp
	eiJUB8V+deCArQqX9cr03Z7xruMdgodgf59rAFX+5fHi1pLKHxKFRTgwzhDA7PefH1OS7ZqKQlo
	qfjrIZ5cUsLP/ws+clfJmDCQIrfZEfNP9Qa1JmkUzWhPsp5yMEq2+3VWhbmYja9Ldy4jxNKVeHz
	BiasdxbdD+qKdH0IJ0hzq8HvCZ7zrJ9rNu+aNbeuHDjyn5AkmWT467RGOkC7ph9JzeOsRwkq
X-Google-Smtp-Source: AGHT+IFaOJo3v4LhMGF4ewT3naC4Ib+LGAuBQf+d3PbR82W+sX87qdzIBqRR7jCzWyjYutK/65aKZg==
X-Received: by 2002:a2e:914b:0:b0:309:bc3:3b01 with SMTP id 38308e7fff4ca-3090bc341d3mr18686131fa.0.1739514974887;
        Thu, 13 Feb 2025 22:36:14 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011ed69sm4569271fa.49.2025.02.13.22.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:36:14 -0800 (PST)
Message-ID: <af91db5d-b115-4577-83b4-0394b60895c3@gmail.com>
Date: Fri, 14 Feb 2025 08:36:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: accel: kx022a: convert to use maple tree
 register cache
To: Bo Liu <liubo03@inspur.com>, dan@dlrobertson.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212075223.4164-1-liubo03@inspur.com>
 <20250212075223.4164-5-liubo03@inspur.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250212075223.4164-5-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2025 09:52, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/kionix-kx022a.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 5aeb3b951ac5..3a56ab00791a 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -149,7 +149,7 @@ static const struct regmap_config kx022a_regmap_config = {
>   	.rd_noinc_table = &kx022a_nir_regs,
>   	.precious_table = &kx022a_precious_regs,
>   	.max_register = KX022A_MAX_REGISTER,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   /* Regmap configs kx132 */
> @@ -260,7 +260,7 @@ static const struct regmap_config kx132_regmap_config = {
>   	.rd_noinc_table = &kx132_nir_regs,
>   	.precious_table = &kx132_precious_regs,
>   	.max_register = KX132_MAX_REGISTER,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   struct kx022a_data {


