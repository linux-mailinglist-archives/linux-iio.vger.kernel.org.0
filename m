Return-Path: <linux-iio+bounces-22421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D515B1E1A3
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 07:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D77C7B2926
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F731F03C9;
	Fri,  8 Aug 2025 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAtxiRHc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6711E1DF2;
	Fri,  8 Aug 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630568; cv=none; b=jDDVjOkG8g0+AnFFNjy2vVVRrDAeG0hB1GLKYG8lDBzH8Y1FoEN6kUWbv+G65nqp6kaFqLN2jDxXe3Bv774X3eBd8Q0A4IYm/fwZ5xkPVxPs8zmJc8sFrkiAzdvXStHlM+SKvT7XOELkpZp+5ZScAKwkkRWm5H8cCr6lniqmq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630568; c=relaxed/simple;
	bh=0azJmb/q0F+G9pw/Yfihi9p0jRgkEl+Z2J1yL+Ogn2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfFtGNJ0iGY3zjK9E2qnC/zGaITTLycXrY2FpydBM2hzaC15Lfe8kQeVh3UE6OJFyJ5MZpI7dIB0W4qsAXC6ASnVjEoqk1k7yFd0Z/YDiZDhecyF0foM7PbtVvo4lEMOnHwHrJNdMiW0NX2hfcvvM6T0y9kpJ+WZopg6f+rbevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAtxiRHc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b733911b3so1886448e87.2;
        Thu, 07 Aug 2025 22:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754630565; x=1755235365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq2uNLY7qx/04QcmgUcnVJFqgyEjasbQct6zF6POZ0U=;
        b=SAtxiRHcbiYsWaT0GzStTJEAw0MSXNYPpDoyyzQBzdwhlb+bnwAgHX1rtXxz5rk1ep
         0StWVJg3GZl9N/2dgzFIrAjjyeU+Bkwz5NfbY/4OyeQCQRJLz7qzaHYvhARZ0H3jR1vr
         E/XLqMM7IRoz5e1nQC4sBeSvoNn+KQEl85M4wkYRUJlRsAhgr51JFYWpkYN0ZqaAmDOP
         iDZ1+DoJhW9q3WRGqw37PdZYpSskEgeyVKDTJO21vsy48qvxYtURgrAfzpsEG+FteNFb
         mpIVx/uB/ZibZtqK0c6x7x87ySS1msZqbaf583zU+AdVwBrLNTYWKwTyab+41aabTglu
         uAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754630565; x=1755235365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cq2uNLY7qx/04QcmgUcnVJFqgyEjasbQct6zF6POZ0U=;
        b=sY3bv0LyOjrdoasyspbm2JyZtZCOv7FJbeL4V+lpPSNmuNyV7WhSaj7pdxePj1bEix
         mVSOOTa3yEbp61X+ccdX9fr98iLgOa8Um+17f++h6POzZyFVY/BblgJ6Xh6jJkEVa+8c
         sMWpZ6/6ugnSbyYyjdCqvjbVXDuYN9DL1acGNQiNhR1eqrmZXb39v1DfRuuwuywBx9rT
         /iKIj+g/NKKBOFFHy2OxbWumsyQEbBY4MW5nvAR1mJx66iBbhWXIwbCy8gKV0GpLEtbV
         r4Xr+L2NSKK8A5jjXKeQjIiRbp3hJWG9T00XmfyaUR3wHpvIOdhvHXhTEaltmAcGN9xd
         9yNg==
X-Forwarded-Encrypted: i=1; AJvYcCU2RG42VtHtCOKc0T5+UGnHVUq0iL2m3/+JbPAA/vb5g8UpfVp3HGYNoy2uQrOfF4pazDVuHvrgnhIF@vger.kernel.org, AJvYcCX8MnAID1m5Rbqm10zV0ttnNGvUOaZxL1lZh6+1TaHv25WVX4kLGo9ySkRDl9WhT2Gqnb4JqH3aAnetiMIl@vger.kernel.org, AJvYcCXfZsUnRfMz9ex9R78l0PX9vllpt+z6sZ9jLVQEp40l3mC1+xY81qeu0EkaC9ItL0Aiu0khEPV8cnei@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWYwTbUFurmoboUEqbCsODdX1iaPB7uU7xIfrsn/elYqKH7oU
	tFXfjss8tR+G/xXTW6eqEQBL1XESC1ks1VYTquYnqDdp+GJZBVz+2iDoCAY33A==
X-Gm-Gg: ASbGncsB0EodEV2V625TgebwX1YNdwzbQfAu2tl7kPeHLcdHEJwZzCXt3SWTFNkiZmM
	JE1uAewrXt+K60N4CK43jWrKn62yy1Y0RC4Dp5V52FiklJBOlrpVemBw5h0XHoL0XWQLJVbbUdC
	iG02zxFQ8DbzZaayS4fQYyYQQ0uPir0frOYxbofop9EwzhZCPwcq8Jeg4YQPZ3XZX/Df8xr0A86
	Mhr7aG60+czX75NgX/YyxyxevdLPE763XTnJQER1WTsLQQxcNYHv5BfYDxnyjaagrExnpQXCef0
	ipG9nf6ypXz/b3TqXXPC41jaLf+t/QjUFKkchWXNZaRgOs6+CDFuZ8oT97yhxj/k621TZWAzIL9
	W2HDh9G+HHDlvcPdaCy6STbSJvA1qH30xVr7rg0RHqJ8TrGIwBnH5m9nxMo3S0aAevVelGPx7Id
	j7MkA=
X-Google-Smtp-Source: AGHT+IEXIxzsTQNU0Os77Pqh76kELLuOVlUqUpzzMCvcbbxBsLEkUFlYHoML0dAgVCHsbQyqMSA05A==
X-Received: by 2002:a05:6512:130e:b0:55b:9424:dda5 with SMTP id 2adb3069b0e04-55cc011952emr404164e87.44.1754630565042;
        Thu, 07 Aug 2025 22:22:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ace49sm2853832e87.71.2025.08.07.22.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 22:22:44 -0700 (PDT)
Message-ID: <7f82baeb-b26a-4525-aade-ff2217343d57@gmail.com>
Date: Fri, 8 Aug 2025 08:22:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] iio: adc: ad7476: Limit the scope of the
 chip_info
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <b23ac0b287926b87c36c74e9057139c18e3f4c91.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VeMwqxU9JaE6vb6xMffCTyAU2tevASduOWdgk3YMikPQA@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VeMwqxU9JaE6vb6xMffCTyAU2tevASduOWdgk3YMikPQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 00:12, Andy Shevchenko wrote:
> On Thu, Aug 7, 2025 at 11:34 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The chip_info structure is not required to be accessed after probe.
>>
>> Remove the chip_info pointer from the driver data to reduce the scope
>> and to make driver clearer.
> 
> the driver
> 
> clearer or cleaner? I think you want the latter...
> 

I actually think both :)

> ...
> 
> Not sure how the future of the development of this driver will look
> like, but it might be this patch will be reverted if one wants
> something else from chip_info to have a longer lifetime.
> 

Nuno had the same comment. I kind of like the idea of only having those 
bits of chip_info that are used after probe, stored in the "state 
struct". Or, to reverse this, I don't like having the unused (after the 
probe) data stored in the state struct. For me it is both clearer, and 
cleaner.

But yes, as You and Nuno pointed out, this leads to some data 
duplication. If the opinions were "1 against 1", I would try discussing 
this - but meh, I'll drop this as you both suggested.

Thanks for the review Nuno & Andy.

Yours,
	-- Matti


