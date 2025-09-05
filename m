Return-Path: <linux-iio+bounces-23816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BBB46512
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 22:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF8BA4882E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF62E5B11;
	Fri,  5 Sep 2025 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VO3ut7AQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7372E36F1
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105926; cv=none; b=WblV+5X0qcXlijlet0v/bhh625MYFSjU8rCLNZJs7joBW0YmyVvI3Mj9b+H0XC0qNxS7KrETDThjuZUyhU3zZ/JtVEsSTSxyoBjyYDo0Quw2OeysRmRc6sdNUevLm00Vy+3ZGELocby8+F8/2+ho05xn63aR3Dhe7dgiYXaygVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105926; c=relaxed/simple;
	bh=JE+vWgl+J/mXD3WaYWUbbwLtIN+kep2SQRmhl33Q8hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoYlruzaqirII56dkXKXYOnEYw2rqUPrCXHa1BSFo0+jpcp85s7VhYU2d0lxq+hv/8u98QA6sMKM/tUmOMTCE3y4HS8kkvpA12f2qWqbl6LcA496h/koohupPQaqEu9FTi2gwER602tt7jtnJccsz3CKHgUaucA0ejQz19WkjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VO3ut7AQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e537dc30c7so376435f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757105923; x=1757710723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3qhvGkvWjmzTYnbRf6LUTpVwuX2R1TomdWWbhzJ/U=;
        b=VO3ut7AQzqlyDgwT5nM6DYu+KEoO7CLp6zLxYXqpb3Ypg6BpnjAVWsnicIB+okfcns
         Jia1ooUzBsLhOBqEL+xUelkaA37zpOqluWKj6Q4bWRjTlMBtK7iTuSpVuI5ghjKmGH7V
         PMCAXTFEa2tjlqe6R3x1NRBmcsvIiM+xY7XW1TBd8uSbOvIz6zPBZA+89GyLgxF5rky+
         +I7ganOLWUZbgrAIKOL5UWOfv49KX4pYbjt4UoROhcrQ89eQCoaxKvWx+AdW7ndwcr0Q
         ryMSEgDIer0H1Trg7EEgZI7GjtvkDi4B2t+WMaDocBaXe7Fz/Na397kRmz7j5pVUyXI7
         ZW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757105923; x=1757710723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3qhvGkvWjmzTYnbRf6LUTpVwuX2R1TomdWWbhzJ/U=;
        b=Ao3Gf9iJteQ8yCiUjel6Iqurx9HSXO1EXRb2qCdJsVaGUU6ThCJornRvArEXV9VVJm
         k2ht5S2q+CFHTbB7KxCBqztRDPzzAJMxUqweBTKxaD5NT6Tzmjd1lqTyp6JUx6L3O7TQ
         0FXjnT0L6WqoRU3vUySPw+4IZkn7kriVLmNHHzB6nbGl0MuswBTmNK+nltN8z4EPPEAE
         DbmQkV1aix5TAZyxlAXd43DmWxZ6gZMKEqBEhUMsFiddVpDlUrWCmyXDswtyvLBcNcrw
         Xyr/diYpK3+SMtRDwuRgBdiiHgYbxpbDYyJr+1ug/5M7qc1r8qaBMyEPUz1apX/Sh4z6
         Vunw==
X-Gm-Message-State: AOJu0YwPqEiUPuDTEGrSvoxtzMjkeFnjz0NGBUZVjIzlbwIcE1zNaYMI
	UmQ8Uxe1es0whtqHmWI5Sr53XJvvit6Q1pBQS5fRl8sR5DFwp5AuqmZ2F/rTmdwlwMs=
X-Gm-Gg: ASbGnctaOly9gHbV1qrDJvIXlUqbTYsEnpGR5JUcjfrC5tDFCgg2fM/bAi+QEqXgdXO
	W6HKdaczR42/TlPLwgHxX0+CriFczs8LwCY2wkLhJ8BpHTjE1HRukhUoeOm90hB6gsvF0V5zTMd
	+qyFT/vNHmO1ckXpGyhQr67ax9UdM2ddKlOjCf8EYILVVw7kLAl8/YMna1jEAyhnXxIRkL6B40B
	Yjz4oKhVwT53URFLr66vz+qb7n0zOAZs8lz4xpNob8/p1yDbdqAyTX05On8ggQgdrk4nsVvT2op
	KVd19S+FFQn0Ru6ju0PA1hX++8FrAM66NM0D448uFoiwC1iTMpRgYRc2+t5o9VtMCBmYfOjWknc
	bb6hRKeoS9dm4jz8zkmNgmkNOInXp3TixRqYLE1gZHtfieVPtYX/Y5aZwX9FLVX93mDc4EYYQ9H
	7N6avo4X0nCBYP
X-Google-Smtp-Source: AGHT+IELX1IohyCRbd4MOAxXRTUwh2SHXc2VAXJB7Lr05lK/1BKEmFD2R34ayIj0GxcCWJr9wAhxjw==
X-Received: by 2002:a05:6000:268a:b0:3d4:2f8c:1d37 with SMTP id ffacd0b85a97d-3d42f8c2014mr20060507f8f.26.1757105923080;
        Fri, 05 Sep 2025 13:58:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992? ([2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dcfa3ec60sm95019335e9.15.2025.09.05.13.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 13:58:42 -0700 (PDT)
Message-ID: <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
Date: Fri, 5 Sep 2025 22:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 17:25, David Lechner wrote:
> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>> On 04/09/2025 19:49, David Lechner wrote:
>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:

[ ... ]

> Taking a step back, what sort of real-world uses cases do you need to support?
> Or are you just trying to implement everything that the ADC can do? The latter
> can be a bit risky because you might end making something where you can't do
> a buffered read and a single channel read at the same time, but later find out
> you have a real-world application that needs to do this.
> 
> It looks like it would be possible to implement buffered reads in lots of ways.
> IIO devices can have more than one buffer per device so we can add more in the
> future if we need to. So I would just drop the DMA part of the implementation
> for now and implement the basic triggered buffer using MCR[NSTART] and ECH
> (End of Chain) interrupt request and just reading data from the ICDR registers.
> 
> I would wait to have a real-world application that requires DMA to decide the
> best way to implement that. There are lots of possibilities, like does it need
> an external trigger or is continuous mode good enough? Does it need to be cyclic
> (something the IIO subsystem doesn't really support yet) or not. Is exact sample
> timing important or do we just need a big buffer? These questions we can't
> really answer without a specific application to use it.

In the case of this IP, the use cases are in the automotive context. The 
system running on the APU is supposed to monitor at high rate (or not) 
the different channels which can be connected to any device the 
integrator choose to use.

For this reason, the driver should be able to support the different 
modes because the integrator of the car computer can decide to monitor 
the devices connected to the different channels differently.

Said differently, we need these modes because the capture depends on 
what the integrator decide to connect to the different channels. That 
could be a real high rate sampling, or triggered with a dedicated global 
timer on the system or just read the value at a low rate. We just know 
all these use cases exist.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

