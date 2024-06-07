Return-Path: <linux-iio+bounces-5982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B88FFF19
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B992E1F29D27
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8715B131;
	Fri,  7 Jun 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj2f/I4S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DF525D
	for <linux-iio@vger.kernel.org>; Fri,  7 Jun 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751940; cv=none; b=Yb4YVdhmGCe4HYI8iAhh1i1t0OAjeH1/sCiAJkFPB+vawzCE5hhw9GhCTVPGOIp0ZQwtyzQhVIqEtLkJue542EDWeJChgiInijfk8OfT1p3hyQMMBCZNEglyVUX8yUCu5+yEY2AAVUD7YLU5oDlyYdghhH9WwZ+BY2OAp5AweLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751940; c=relaxed/simple;
	bh=GGBwkNwaKLuAZt/gpy69pFlBu9B1OahtS1M1l1qbKpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkz17iPPSQTyZ5g7b0X2MkQWc0i1vShUOmqTxiUZJvXtQUG+jYPux3/OGGACZWiEpnKS4ffIAcXRpMG/FIql92wWPX3tpZEeyn2wtJ1DhJVSTDvzZaLDu0vfcjtKLPHBVb/YVcOwVQSJTmG9bb4v9BOkmIEad2klkD+29doZ+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dj2f/I4S; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52962423ed8so2254728e87.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2024 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751937; x=1718356737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IDOvdQG4G5HM3mc6kbrR9DttpzyvecPUDpSffGUSbyw=;
        b=Dj2f/I4SPJUrM3xIIFU29m1RycEmZCvrXV5EmyYOyRUnJHBvM5ro3r+D8z93XJ5rIc
         XW2KJRaVcndz3mXukkeR0wu1KEGDoMtid1nGCYNZmuMtQDXouEN6DnmhxVbN0YDYxlWB
         HxGnitYgzRmumJmTqG2Jyh1oFji2EqHHmpRnw7dVtgisV/MuhKcDZtWzDiVfTN+1Jctf
         Mg5FstwStxRtIUQyDcjI2SHmY7Rh2YRGrN0+iVzF1BYuVTKc6ydi8WEGHicual3AjtiD
         06pkHj6Ny5JbcIV/36vYi9sH8QAyJ/JEPblVNeNpqzQX6egcfBFa4N+ZjXfZlng4Ica9
         oKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751937; x=1718356737;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDOvdQG4G5HM3mc6kbrR9DttpzyvecPUDpSffGUSbyw=;
        b=L/M/RK/9hi96aXEi5tI0eoLs2pDJPQ4xnAEoE6TkbhGgI7DPwkWOoBU4VUnBI9/ZNJ
         Wf7BC2e5OoCfEojz+t4CPN3bFFincNqcfAC1sUbz8OHvNZFGauBrk6AmHsgrBweeFINr
         /RkR2f+5u154V5la02dKcLIRQZNB+MbXKCWHWxv4n7bW025bwppzKWKgz6yOBL9sKM4Y
         H9yCG2hjdMf1/Q6jzv2n6S+ic7XVLOHj50Qq79fDTaI9s/p2UbouP+dzyCNPttNg/cfH
         WdKJIvXNsTp5l+oeOG2rsQSaAXZfIYwaVCrsxuWOrSWsmZFxcbV0Z1eiz27wYCBJ7Eve
         FSmQ==
X-Gm-Message-State: AOJu0YxoIrK96PMNCsbKjYl79gBb2SrEH53cd0i/YhDXEht4bdGPdFui
	maSM59RcL+ACgfElxNGH+iGiNz9F1xAQV4ul60u36iRslrK8KTGFoY9Hch89mf4=
X-Google-Smtp-Source: AGHT+IFy8Jc8e6kLiNxq4Z/D9xjF6XZElG+SeUuG9+pQP3ajt90IUj6L089W6JHTDMeW7DZxVtTZ+Q==
X-Received: by 2002:a05:6512:3c81:b0:523:da2d:6b8a with SMTP id 2adb3069b0e04-52bb9f7cdc4mr1563602e87.24.1717751936643;
        Fri, 07 Jun 2024 02:18:56 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm48597545e9.40.2024.06.07.02.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:18:56 -0700 (PDT)
Message-ID: <69e1a5b1-e5ce-4bcc-a0c4-2d02e777c296@linaro.org>
Date: Fri, 7 Jun 2024 11:18:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iio: accel: adxl313: simplify with
 spi_get_device_match_data()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Lucas Stankus <lucas.p.stankus@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Ramona Bolboaca <ramona.bolboaca@analog.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
 <20240606-spi-match-data-v1-1-320b291ee1fe@linaro.org>
 <7ecabb8e342b9bd4fc2552bce29dc8c7a98971ee.camel@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7ecabb8e342b9bd4fc2552bce29dc8c7a98971ee.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 10:57, Nuno Sá wrote:
> On Thu, 2024-06-06 at 16:26 +0200, Krzysztof Kozlowski wrote:
>> Use spi_get_device_match_data() helper to simplify a bit the driver.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/iio/accel/adxl313_spi.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
>> index b7cc15678a2b..6f8d73f6e5a9 100644
>> --- a/drivers/iio/accel/adxl313_spi.c
>> +++ b/drivers/iio/accel/adxl313_spi.c
>> @@ -72,13 +72,7 @@ static int adxl313_spi_probe(struct spi_device *spi)
>>  	if (ret)
>>  		return ret;
>>  
>> -	/*
>> -	 * Retrieves device specific data as a pointer to a
>> -	 * adxl313_chip_info structure
>> -	 */
>> -	chip_data = device_get_match_data(&spi->dev);
>> -	if (!chip_data)
>> -		chip_data = (const struct adxl313_chip_info
>> *)spi_get_device_id(spi)->driver_data;
>> +	chip_data = spi_get_device_match_data(spi);
>>  
> 
> I understand you're sticking with the original code but since you're doing this,
> could we maybe add proper error checking for the call? Maybe Jonathan can even
> tweak that while applying...
> 
> (same comment for patch 3)

I consider that a separate patch/work, because it would have functional
impact.

Best regards,
Krzysztof


