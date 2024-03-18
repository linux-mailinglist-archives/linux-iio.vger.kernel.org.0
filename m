Return-Path: <linux-iio+bounces-3603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE087F353
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 23:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D021C21756
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B15B1F9;
	Mon, 18 Mar 2024 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GBWUvXzh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3F5B1EC
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802124; cv=none; b=Te6KMmE4cKNjsOp4wYjfUO4NMDe45958yrAzGYZWAaNFo1Q3KC+jOBtU9wZcmTTPyYfacGjSJyWcC6Gv7as19RMUiTKdcU+5SURpOZGUyVFu5WTh9E5G5LHDlKQKKM3c/ZF7FzUtKi89zqHLCWCLYMjZZGQDkHO4kpCRFWCG27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802124; c=relaxed/simple;
	bh=jlF9kBQ6rKq2W2ELdfqYYMhpQURF2D8NP/Wqm50zMWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad/lKLrULtOXwGQPw/WJnV1/5bcp/SzPqRyrUtGTOvOjj0NdDc1EOVGMJetTY0x0so8FUU1qc3TieQ75LVOElJVJF7Vv042ThiPdqVabr+lRL0UM0CtHP1xplOX1nnSdcZi7Pz6j/GCTIHDJVExQWw859ZSycsSkVlEn0bmc5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GBWUvXzh; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a4789684abso2348185eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710802121; x=1711406921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jludn2bAG9CDnI255xg3vJq/imDA0vVQLTyCX+Hp1+Q=;
        b=GBWUvXzhsEzAmbmxb0ZZFs6l4AiWvRmH6JOk9OmE9aswQF3gbBrsX/srmz2o3LLi6n
         Zx6OvrJzB0HxM3Q7onHVGKU7eZpYbeiiUh51vPBcB7lQcv+a6lr2Zj2to8LEB/ic/6S/
         YuEtDOwE7icAM+zwbBzfIsJS4WK+ybNF7q2S7HZ01rrIh9AyxSXqiAIVX4Fuz0G8m9aV
         +mkQOZqUSlaciAARWc+fotNBH+QwG/3iCtn0ttkNFadg3JNjQc87Q+B9AnH3RwUrd8DU
         GGuHuzJSxxZ+8kcKZRxaPCRwZnUcQhoi2OkLoS/lX2BQA9RoFwlmZq8iFBSkwV/wgG+t
         oq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802121; x=1711406921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jludn2bAG9CDnI255xg3vJq/imDA0vVQLTyCX+Hp1+Q=;
        b=Xor39gyBmjED5muu8hMXXFl3+rk9EkZl10d7gQ5QHCpMw1AFxS2pgwAF12jpbi5SJz
         znFyDgcu3v4jwhyQJ4rtiY9KVyruzOZNwbOVi+olCmuOJlM5arnubRuUz7Saq+6k7Hc/
         vBOabzP1UZbq+3/HLSHB5+LqmySm27/vFy4feYdCNoKYbQq5YRQGcmoZb+HY1UL8iD4c
         APKKSGjbUj/j3v3fG4AwRurvG1lgpY44rdRqShOXd+f44NVwDN1fnsQjYGctprCNmBI5
         h3ex9DjFYgAmDWy0i2DdNNx9+xa0UHpuscLxg8u4Rnq+QDT6zal74E/awZSvvD+CPnfi
         xh5A==
X-Forwarded-Encrypted: i=1; AJvYcCVyPmcZqq0lp+lvdlmyMSGDm2T+oW9AHoQWQMvBh1h+zSoDfxQ08ajAb/iXUZ+kMLENR4eEX8ccApX40QIg5gP8kf0O907TpW4N
X-Gm-Message-State: AOJu0YyfeIe/rUXijnHX4JofD2zeia44E/eggjAIr10Jpz0CSaeoz1d3
	7hcEU/7898XThfN66AGmCbBXYkMN9V/bkkrQeCnBogDQFodszmdu2RWKr9PUFTc=
X-Google-Smtp-Source: AGHT+IG572b8WoUMjTLxCmZp49k013fssGeR3JqL53yuQr8mSPQRGKSXWXK2Ezesr51EW2P/66YSPA==
X-Received: by 2002:a05:6820:213:b0:5a1:6cb9:d6f0 with SMTP id bw19-20020a056820021300b005a16cb9d6f0mr1014886oob.1.1710802120822;
        Mon, 18 Mar 2024 15:48:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056820248c00b005a11d6d9accsm48094oob.16.2024.03.18.15.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 15:48:40 -0700 (PDT)
Message-ID: <3eeda38b-0bfa-4b46-8088-303f78b5f340@baylibre.com>
Date: Mon, 18 Mar 2024 17:48:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7944: simplify adi,spi-mode property parsing
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com>
 <CAHp75VfKZy45RVJmAAOEPyUFTW7MhxJmOeQHj3YV7p-NPKpkvg@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VfKZy45RVJmAAOEPyUFTW7MhxJmOeQHj3YV7p-NPKpkvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/18/24 5:43 PM, Andy Shevchenko wrote:
> On Mon, Mar 18, 2024 at 11:57 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> This simplifies the adi,spi-mode property parsing by using
>> device_property_match_property_string() instead of two separate
>> functions. Also, the error return value is now more informative
>> in cases where there was problem parsing the property.
> 
> a problem
> 
> ...
> 
>> +       ret = device_property_match_property_string(dev, "adi,spi-mode",
>> +                                                   ad7944_spi_modes,
>> +                                                   ARRAY_SIZE(ad7944_spi_modes));
>> +       if (ret < 0) {
>>                 /* absence of adi,spi-mode property means default mode */
>> -               adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
>> +               if (ret == -EINVAL)
>> +                       adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
>> +               else
>> +                       return dev_err_probe(dev, ret,
>> +                                            "getting adi,spi-mode property failed\n");
> 
> No need to have 'else'
> 
>                if (ret != -EINVAL)
>                        return dev_err_probe(dev, ret, "getting
> adi,spi-mode property failed\n");
> 
>                /* absence of adi,spi-mode property means default mode */
>                adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> 
>> +       } else {
>> +               adc->spi_mode = ret;
>>         }
> 

I agree it is better that way. Will send a v2.

