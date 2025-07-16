Return-Path: <linux-iio+bounces-21731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F974B07E7F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 22:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114DE504176
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150B28DF0C;
	Wed, 16 Jul 2025 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="MDEoCLot"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D43288CA3
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696204; cv=none; b=HdzpzRBOiaXjlIDeqvrWsYyxqucqW2OouAYVYpAoEHhHh8sCAPSqmz/Tq/P51yNTD2czfX+2D5MGkuyWg/IENbHb706cGX1jwBx4FWnNuvAmsvAj9ZmH0qxZeOyByxmQol2a8HzXCligNngz4zsVerbB6d2RogFKgAnyzPaweEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696204; c=relaxed/simple;
	bh=Yxj+ey9K8wa4n8lniqZddhbfgqDCmM0kyNfW4p7rHQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdOTUP1lyO7OVs/7FIcTI8UmwRM82lIY2VqSf0h/YmwiIsubPmPpGRHYZ7Hq2aUs7+W3wyW6cJvoL7KRy4Wu4Y5Snh+sBcYzAzplZE0fdmWyKiqkRbt/FZ2h36TUSc+o+txNupzZlj3bSDAPXUsdrLQxjRMvtt5AMpJO3olccSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=MDEoCLot; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae360b6249fso36635166b.1
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752696201; x=1753301001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpfe0WOLMAls2njOL6yOdqStwbkUoLGErIsNXffP1cw=;
        b=MDEoCLot4uejvgNaU/1KPaYBD9y2XIgJYA4ZnzvtEf2vv/Tw/DQn8F9aS5CkqEt7Dq
         z/W5qvPcRYPGfUIgg8Yggm5WEnWiA/BpT4tadULGat8Ret6pUp0FdhD0HQyPkEFi741n
         2CJbiFJDtHgbLUa6YsHjvaDRrY+o/JcCUKhFa18tyGP15W2Tt0OWt3DsFr3wdLaEOJqh
         1Q84IUB4HapQbBLrIB5pqdwB6ozFz8i7LcB+O53QO4KBuLj+4hWEUTeAfrRjUHsxOZ/I
         Zw1pE6kSoos2A2UTF0Oum5Ydocson7HPbDioE8JlFDibD+2jj2SE+kJMTlEs71DMxAsu
         8UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696201; x=1753301001;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpfe0WOLMAls2njOL6yOdqStwbkUoLGErIsNXffP1cw=;
        b=F4sW/AJyQhyliSrfedEjxGQRQt6nXjq1P5J8ClWXCWJanfnOj8Ay0NTwOHnFz7FEmg
         OTq2oUSlOsG4biY9HO0CMMaIGCSy9jn4YkTFvpw/ypW4HjzUBCqJtoNLIbQbOM53lLrl
         Nqi8FSndiJawFxmEjEDXZRfG3IGVtbSk47EhIhN09NCQuEJFypdvbxj0d8supIMC+jyE
         nb9eByIsc72iCXIY56fAlKEykKNNajDIX45L6ebTlD411F8U9EWC1kJBp3fMXEWyYTDt
         S2m0JAdhkX7tkvjdnltn3DGFLKxRk27HYpq4KAnZ016CN8Kb0qksZdDY0IyoiJ64ulsH
         rIzQ==
X-Gm-Message-State: AOJu0YxCbLHVMjGd6Eckn1x21Dn66zfo9mhs6vEkosXX3/e5xB9rOoHl
	IaG/GfJqUM99+mi27uc/d3RhRLODuRfMWdwq6nesOBJr2HzPItERKy/I/DRwAYR4ppU=
X-Gm-Gg: ASbGncvZoUDUg0RC+3wWAHHN6qlh77TRHha0afzlM7MKlussG+pYs6bpYo6ZflFZigt
	Np5r+8jCaR5qhQrKS2HJTPbceEbI/7J1ppm3pbsspJ4gZ42i27TRI4nm26VqaKKwt+nCv9HZEuv
	6OjdxVhc/nBLoLuaPMc7rBpcs5pvyx3LIdGb/XujidKDBLYt1+5oqBW2I/FKbRVaa2sM9uihVcG
	jKKgnB1KdwPLYXjSZgU64l5SuNalzXti0+NashGmT/HjpwrsqE4b9dJsEKLW35GwtnsLInA2fVe
	nej7KXQDKR1FMUGW+Rga8eW6c45Qz9SyDK0dVNl4f6BXr/Js+sUimmgIifbfEoiB0mIzSbfLNSY
	yw4gibrxE5h+cQQf0uXwlEfPdWvIQzJwkXfar7vsYbkXB9TK5s8BQQVZye4T6Eos=
X-Google-Smtp-Source: AGHT+IHzUzuPOUxjn4HkaEMG0nrO0boX1DjRQiT2CoT8uS3rciR8p8Nc1sO35hUN371nlh+qz/F7og==
X-Received: by 2002:a17:907:6d21:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-ae9c998704fmr496920666b.18.1752696201206;
        Wed, 16 Jul 2025 13:03:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a864:eb02:add4:d64a? ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61253b999b7sm3737688a12.2.2025.07.16.13.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 13:03:20 -0700 (PDT)
Message-ID: <b27db733-4ad0-4533-a587-391d42ae2af1@mandelbit.com>
Date: Wed, 16 Jul 2025 22:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250716192231.30337-1-antonio@mandelbit.com>
 <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
 <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
 <c011f005-de79-4457-804a-d701f315b566@baylibre.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <c011f005-de79-4457-804a-d701f315b566@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/07/2025 21:52, David Lechner wrote:
> On 7/16/25 2:44 PM, Antonio Quartulli wrote:
>> On 16/07/2025 21:36, Andy Shevchenko wrote:
>>> On Wed, Jul 16, 2025 at 10:22 PM Antonio Quartulli
>>> <antonio@mandelbit.com> wrote:
>>>>
>>>> In inv_icm42600_accel_convert_wom_to_roc() multiplying
>>>> `threshold` by `convert` may result in a number requiring more
>>>> than 32bit.
>>>> In this case, although `value` is 64bit wide, the result is
>>>> truncated because the multiplication is performed in the
>>>> 32bit domain, due to both operands being 32bit long.
>>>>
>>>> Cast the first operand to u64 to ensure the multiplication is
>>>> performed in the expected domain.
>>>
>>> Is this a theoretical or practical issue?
>>
>> Can't say if it's practical because I don't know how large `threshold` can be.
> 
> 
> The code is clear that it is between 0 and 255 inclusive.
> 
> unsigned int inv_icm42600_accel_convert_roc_to_wom(...)
> {
> 	...
> 	if (roc == 0)
> 		return 0;
> 	...
> 	return clamp(value, 1, 255);
> }
> 
> threshold = inv_icm42600_accel_convert_roc_to_wom(value, accel_hz, accel_uhz);
> value = inv_icm42600_accel_convert_wom_to_roc(threshold, accel_hz, accel_uhz)

Thanks for pointing this out - I overlooked that.

> 
> So I would not call this a fix, just making the code more robust against
> any changes in the future.

It's the type being used that convinced me something could be off.
Maybe threshold could just be u8 and value be u32? (just to improve self 
documentation)
Also inv_icm42600_accel_convert_roc_to_wom() could return u8 for 
consistency.

I any case, this is a bit code cleanup and a bit bike shedding :-)
I agree there is nothing to "fix" at this point.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


