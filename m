Return-Path: <linux-iio+bounces-21728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94BB07E4E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CDA45BE5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03518D65C;
	Wed, 16 Jul 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="mG/R8SPd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6815D1
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695073; cv=none; b=IZqwP1FDcn1v7lNSuQvpwbHLcX1HH8CQSMVYDBGyQ5lnD16/j1KT89N3hgUj4DSamHDNwUFiIexiHXqUcnNL97OdL61kchYkTVz/ubwP2+ZhMeiHE/QvbZy0gtrIIdFr6L0SqAbRtHyoyBrjbAaDnj/CFYpNVOO7MjRWK9Huvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695073; c=relaxed/simple;
	bh=nWE5v2Ki7F7BgJ/VMbkxc1mYgcjDgaaJ4T4Qv/4ybNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=movehG9IhLUOm+6J86n4cNfIm/Ce0mRuujIBHibrdwXAyu0GOveR/KeT8jVZ6v9twRGYvlXyWCgcS6UXBJfwKXSkKNr7btP0U/9h+G9/MBtmctaIZ0FrSBhWkBdc2nCla7LsPvDCoXAq4ZlTl1EcNZx0+RXPvrmoO+k56zkx4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=mG/R8SPd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so47316466b.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752695070; x=1753299870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TbYtRdok1kKGFcn4lHwDt2XmUQ2O7FTIIY/6AbKWin4=;
        b=mG/R8SPd+IeikeuoGruUo3hl/t3PFnzHlBQu0JPWnB7qlrW7hbMFeF7GbpasG6pVqS
         EayfBXLNnWqFwve+hqcS5UUfJIgG8QBRjI6kq0UHpXRjaSs0HuPNGke2lPmP7CvJEmQj
         aDwTAHLC/yiIwQ0HGhahb+iZ+467lUaFqVkoKMw/69WRNrf6/E6qWS/ia3LieDVQs1Dv
         jg+w+TlUtmiS7Y2NP0JaJnmNwCAVlEme7ku5yQjCyijGo9I+iNbzs/UCBKC9Xa6qat4m
         2Q4yaqBNoimkos89ssYv2JgHIOcUrbKezezAANPQxlFMgS2H6bRbo9Q+iJX3mrR8jJv+
         bzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695070; x=1753299870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbYtRdok1kKGFcn4lHwDt2XmUQ2O7FTIIY/6AbKWin4=;
        b=t3BGLpfNIzIMFpMq8oSNPHJJXq8yQQ4XCN1qhsX34+CCH2NqNWy627VZQwD3LMAY8w
         IrRkc0stiSd0X2pOUbNxZLabd1MBKm+/YmdmLMU6j7KHTC6w3zIAgnIOCoqG4JuT+Zbq
         dBPk2l7r5NCFQTCvVhEQDycSJ2AJp5TIzrK/5uX2BshYt28oIOzPCkUm9JCnWRUr7ABj
         JeYnxDRylM4rb+ZBC81Y0GYm8I9rr9eehoy4MBLz0v4cfWbo99mLeB7DWFwm5dKzYfoY
         ibqwto6Lh4F5ScqX2zAzwcWHnYwzR6BwFBw80oArQ9D2GPF2kToOwY0eXamwkqF01Y9s
         gihA==
X-Gm-Message-State: AOJu0Yy176QnzXbK32x1TUP3JspIJipOmiV3OlwjWTVnNqpA8z2d/vWO
	1ygeGzvUu22yzV+NUV0hWKcZDYDdcDxfbGZ0BZr3283qXILZcB8g8wft3El8sIQRIO5o+wVIEhU
	yO5kN4L18mA==
X-Gm-Gg: ASbGnctTyEszuKIRyEiBYPgxaGoiUry0dGC2imBMsWYUW2XL15xrAPLVpNCzBVER/Go
	PKkr6NV5f+kgn+PUYDtPGnHSjifTggTfOZTKz5IZddDBj7WWF27gNnRbUBsTxTPqUj6ZySI9Akr
	CxuNaG4UbvytjVEGHKpk0CFggF/KLGVVKCXBS4IfbN62RRfNHk6DjBEK1x7w3Md+onrXp6okAz5
	d1fXBqS4KNTTtv/JDVAw5x3sWvJ8uHMfKcwb2Bn0WmxxkA1yVVkFT0zQpcn/DXV5vC514lF0zTE
	NYbJomQOTIpFn+K0BFDPL88e72ISINscOS1IAUW6BJmkkGj29/UxCDykiX8SWd+nKesaJrz/GAZ
	owsOoTOcfAhHviIng8Y7uChe2kHCnoXzBAo+3qgHTDXQ1zHREdqS1BrUIwORbhG4=
X-Google-Smtp-Source: AGHT+IE7y66HvwS3jTY8AhjopGonr5P/+upsi1oUn5o59+jhHkWC3ecsLeFEJl5//TW8G8JOWB7LxQ==
X-Received: by 2002:a17:907:d0b:b0:ade:bf32:b05a with SMTP id a640c23a62f3a-aec4f74b76bmr25460066b.0.1752695070125;
        Wed, 16 Jul 2025 12:44:30 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a864:eb02:add4:d64a? ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae5fsm1242732866b.64.2025.07.16.12.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:44:29 -0700 (PDT)
Message-ID: <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
Date: Wed, 16 Jul 2025 21:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20250716192231.30337-1-antonio@mandelbit.com>
 <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/07/2025 21:36, Andy Shevchenko wrote:
> On Wed, Jul 16, 2025 at 10:22 PM Antonio Quartulli
> <antonio@mandelbit.com> wrote:
>>
>> In inv_icm42600_accel_convert_wom_to_roc() multiplying
>> `threshold` by `convert` may result in a number requiring more
>> than 32bit.
>> In this case, although `value` is 64bit wide, the result is
>> truncated because the multiplication is performed in the
>> 32bit domain, due to both operands being 32bit long.
>>
>> Cast the first operand to u64 to ensure the multiplication is
>> performed in the expected domain.
> 
> Is this a theoretical or practical issue?

Can't say if it's practical because I don't know how large `threshold` 
can be.

This said, `value` is declared as u64, therefore I assumed the result is 
expected to be potentially larger than 32 bits.

> 
>> Fixes: 50cfaa9a46c8 ("iio: imu: inv_icm42600: add WoM support")
> 
>> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFORE_WIDEN)")
> 
> Is this tag now official? I can't find where it's documented.

I don't think it's official, but it's what I have found in the git 
history for other bugs reported by Coverity.
I already used it on other accepted patches as well.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


