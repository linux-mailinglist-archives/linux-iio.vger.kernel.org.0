Return-Path: <linux-iio+bounces-8361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A055294D049
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D300D1C214FA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB8194132;
	Fri,  9 Aug 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iys3YvRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5281DFF5;
	Fri,  9 Aug 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206775; cv=none; b=cjAsbWU6schNVNfekH5PcJnkBTTZ7HnIbl9m8qw3n/DNK6admYzdgKFl5Xf4OjZeRFte92vUhifREuv1GYUfUyfVNg2YL92HOj0j/yqlT93C0vLwyh2n1PEh9ZCqFYwUpaNUgWooHMsUiUSdAkTNxhP7ob/3epsTx813BXo7poc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206775; c=relaxed/simple;
	bh=bVxkj+M+/qQYL51947hehJnWkPK6ID3XtdlKAPMkPRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJYnF4m9CalSk5NPOFKvCyqp/m4L79eUBRzyOQl3wpdbP35TAKZD9Jx5xZQFZfcFj33/ckhh6cwqs+/1/kiBUu5jn2plXYLZv3uuCTu3SwRPI8Aazvqd5Ooe1+dp6K9lVVpOpifxApF2Be+tPWMk+Gh2uq4N+ZpPWgnf7nZ1XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iys3YvRs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a8caef11fso237763366b.0;
        Fri, 09 Aug 2024 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723206772; x=1723811572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owNanohVQNU73I5o2qMty3Cf+e76uO8QKFg2xVe2c7A=;
        b=iys3YvRsFXStNFjCiYrannqLlbb2irkxrJxxgVLfhya6fJ3iA2bZr4zwLXXs0n+yKr
         ymKvLikDwF9iqVvdA9CW6q2vVtXB9PP5cN3E/GdPnWq+xa4810ati136OMoQx7+wA9mk
         /YVKnoMEewmZ2nyUWZRBOjJA2ihwN6V6WTYlFWQJNV9kho/wpu00E3uccwjKPHblz17K
         acRSySq4zoopHSZVHa3tyFwjxD75vURSMkL3nT9F0UAM+/YBH655jAyyUHebSjy+S84+
         QrD83XO2hgQGSDps4pC/VV1ryAh4Ptkq9QXPERWjET2m1S1M8rAPxwUlR5UTWvVDrNbl
         xrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206772; x=1723811572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owNanohVQNU73I5o2qMty3Cf+e76uO8QKFg2xVe2c7A=;
        b=h87j1B91WMD+HmsL3O9PbKWs/ztiPhnhozpxMRq2xv3bW3C0eOZLh3JnC+xCy+bpPv
         LhC9EAOEo6GvPJbSgQtWQLj1wgMl3zJmuq8+k4fHgGO+yfXkuqwUhdX8uoPE/3wD1tYF
         XHUhQAa8Urm2Ll26XB3U+N0zGKVLyJPWfbrEEhxCOJ6cIE4m39ZjYthff3B1NgyGDl+3
         5w26EgtPbDohGl3F/yvGSEOWeDOkf4sbySfol3EJs8wVQF9cz5oXO2u9vlNIick2xUVY
         qd2r3O0XvCGTdUzxKh/QIpheftDG5cDwI90431GrvB2HV5mAjSYP9ZW/2D7gqbJr4cVf
         pS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQNdZuHiGLKPviSqYbGIEvhW8+IcwRgvbqIKbtHeURwPxnpmLhrnUjc6gWpNz5lf9gvMji1WKy5U7I@vger.kernel.org, AJvYcCXz8/XFnNRVt84rARZXNcwBtYaC5NAohSV51fFXrdV4iVSoUnvi/ObZaRspYVcufOFWDidzZeeHu1pJxuIO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1UYY3YGrwzRm6h4u0XsCdlIuymfVb9G+NlZvFETRl7BugVz5
	v0o4RTijryeHFZkZ0kCwbQg9Gm8Sum9+qglmCO2ANRWKM0mbdnZb
X-Google-Smtp-Source: AGHT+IHCmdH4T4+NUFBtQJxZxX6JEURsg9+GsOSDPh9PXi3OgJAGnNt8QcClGMsPMTuNCAj2LeCK2w==
X-Received: by 2002:a17:907:7204:b0:a7a:a06b:eecf with SMTP id a640c23a62f3a-a80aa53b6bcmr117096266b.3.1723206771965;
        Fri, 09 Aug 2024 05:32:51 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc95sm828415866b.85.2024.08.09.05.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 05:32:51 -0700 (PDT)
Message-ID: <39fa2711-7bd6-4c12-a668-9a3af33283d8@gmail.com>
Date: Fri, 9 Aug 2024 15:32:50 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
 <1a3dc92c4f91d271fd54f7b77b2850cd4d95301b.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <1a3dc92c4f91d271fd54f7b77b2850cd4d95301b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 15:26, Nuno Sá wrote:
> On Fri, 2024-08-09 at 13:33 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> This commit adds support for the AD4113 ADC.
>> The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
>> converter (ADC) that integrates an analog front end (AFE) for four
>> fully differential or eight single-ended inputs.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
> 
> Any reason to drop my tag :)? There a b4 command that can help you with it.
> 
> - Nuno Sá
> 
> 

Yes, I added a new field to the device info struct and changed dt parsing
because I missed in V1 that this model actually has a 16 bit data register.
I considered that the rb would not apply anymore and it would need a re-review.

Thanks for the b4 suggestion but this was intentional :))

