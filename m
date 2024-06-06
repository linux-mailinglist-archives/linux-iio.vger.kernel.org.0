Return-Path: <linux-iio+bounces-5912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D48FEFAB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2DD1C20A69
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595319B3F7;
	Thu,  6 Jun 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgCygXIJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7013BAEB;
	Thu,  6 Jun 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684485; cv=none; b=ckZ+zl2YiUWROp0IBYAf0NQhZ3Zez/lEZdn7nSmkvEB/ZmqpMDKbVwmCbxdyLBnj7MQg6v4PJO1aY7cJVJoj5ogVGfqMt7p7TXHSFDPCO9iBJYSFRDt9MoAekEpKmvqyJ+JTnyqUXjpXncTJX6v9m+5O8jokrVW9D7hOHebr4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684485; c=relaxed/simple;
	bh=YY1PYyJeC1PyXSn+qiyDzr38/yGnCMAjjHhiy9ZjvBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9e3jkPQNHtJ628D2Vlgvyu4MZeU8bdCPQ0fZQMcraXGzBrLLjqMNKllQBvUUiFy8tzr6Hkc+onNtYIxKzlZR2/8x85w5Ufj1SNp2V++Draf0paqQJoLRQGg+gxB+jkRwyWxRocGXBLLukc3J+S4JlHDTx42ncVxDvFptdrHS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgCygXIJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a690161d3ccso104094366b.2;
        Thu, 06 Jun 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684482; x=1718289282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=su4UWCKwDPwClxm9C1O9EFHmbyfF86UhfbBVvb2tuZc=;
        b=PgCygXIJnuXoFBNBw7G/K6NcUD90/OqiqSirDfDc+tJ8HHnomRySLxNKeKmiO2eF/S
         3YFOWQ4rMjVQwMNoPN0+lDEqwZgOqZ+kZ+vjlOa1Cnmf0GdOEWHlQnhVPI73xellqxe3
         vTLvQEAN3nMjdk46oyIu1lQH4ts4DaZnmIsa6nS/Z9tla0u4kivnfTHDRhUpSBbrlw1d
         6TMh8nPFwkqUxT11hzEKJ0cD5um/CVaaTBgLUQbf00gHJydFwkJ6IMWZlxDZsQit5OMb
         WAmRWbGrYKwSIm/o8S3DzOpUwAHKRkQP43p6+LZBHaEwUUT0LYbzO0IsIIPvgFGM4Z9s
         ms1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684482; x=1718289282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=su4UWCKwDPwClxm9C1O9EFHmbyfF86UhfbBVvb2tuZc=;
        b=rbWEB9Tk/TWNW+HXqGQDF4YMFQSy1c4ogMEc6gN3/T9XjmpL3ITGhs6pgTjpCDWcKe
         +PNzOCbAr3lrU1pzJ7tZwHvAQmymDU3iTJx0YKbYjcsRLlcdRQ5MJ7Reqr12LH0PtXQA
         RVrm7rGFTmNUWym8VhE7W74J96CVje5j8Trum1Ljra1lS2P9hvE+t3t2+C0PJ9hbguLy
         fbUOKK4PvXD7XiuoBFIubsIoje8YGrdLcCqEEiGW/6Kf1EPJ8q9y+XZjPL/BQ2bWilu+
         ydTDbFBfBRDRimqtnWCmqoIEyNx9MhW7+JcpSTy6LP8OV/2JgbiXR+ttbZyFN3SEP82Q
         G90g==
X-Forwarded-Encrypted: i=1; AJvYcCVsAHS7OsRpTiAyC3Z6pe+KH+GIC3yZqhe2iRqRSL1jwBsqgy1VljyA6aOxxQlM44AdBHpyGvlH0G5IRUCftm9IrLiVb/kMcO/3jPo90ZsLD+bMTR4JhnTTHQDIBXaxkE8t9/TPDDA5
X-Gm-Message-State: AOJu0YxyMWv9BS51vBaB6tXW/yw2jJUqsCgKph2v3iTkQp8GkkFlK2Hs
	bjYBqqyG8WfuT+MFwzYtv520/2uLkYZDeagoqPmgihPvSFfMIUQrlZRTBiVi
X-Google-Smtp-Source: AGHT+IG1k/i2/wcTCdn3F2NXBNIv4jgIURxcJek0d5JUNrWtbYMwW+CGSBwztlhSfHXFpCFOaEi5UA==
X-Received: by 2002:a17:906:c408:b0:a62:c5f:e34a with SMTP id a640c23a62f3a-a699fac603amr341641766b.39.1717684481347;
        Thu, 06 Jun 2024 07:34:41 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070dcb4sm104407966b.156.2024.06.06.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:34:40 -0700 (PDT)
Message-ID: <6481f8ab-5082-4952-a29c-075a57239472@gmail.com>
Date: Thu, 6 Jun 2024 16:34:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: humidity: hdc3020: fix hysteresis representation
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240605192136.38146-1-dima.fedrau@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240605192136.38146-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 21:21, Dimitri Fedrau wrote:
> According to the ABI docs hysteresis values are represented as offsets to
> threshold values. Current implementation represents hysteresis values as
> absolute values which is wrong. Nevertheless the device stores them as
> absolute values and the datasheet refers to them as clear thresholds. Fix
> the reading and writing of hysteresis values by including thresholds into
> calculations. Hysteresis values that result in threshold clear values
> that are out of limits will be truncated.
> 
> To check that the threshold clear values are correct, registers are read
> out using i2ctransfer and the corresponding temperature and relative
> humidity thresholds are calculated using the formulas in the datasheet.
> 
> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
> 
> Changes in V3:
>   - Add missing changes
>   - Remove math.h, already included in math64.h
>   - Drop range comments
>   - Fix typo devide divide
>   - Add empty line before return in hdc3020_write_thresh
>   - Keep hysteresis value when changing the threshold
> 
> ---
>  drivers/iio/humidity/hdc3020.c | 325 +++++++++++++++++++++++++--------
>  1 file changed, 249 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> index cdc4789213ba..cf00999b826d 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -19,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> @@ -66,8 +67,10 @@
>  
>  #define HDC3020_CRC8_POLYNOMIAL		0x31
>  
> -#define HDC3020_MIN_TEMP		-40
> -#define HDC3020_MAX_TEMP		125
> +#define HDC3020_MIN_TEMP_MICRO		-39872968
> +#define HDC3020_MAX_TEMP_MICRO		124875639
> +#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
> +#define HDC3020_MAX_HUM_MICRO		99220264
>  
>  struct hdc3020_data {
>  	struct i2c_client *client;
> @@ -368,6 +371,105 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  

Nit: "thresh" instead of "tresh" (applies to several lines of your patch).

> +static int hdc3020_tresh_get_temp(u16 thresh)
> +{
> +	int temp;
> +
> +	/*


Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>


