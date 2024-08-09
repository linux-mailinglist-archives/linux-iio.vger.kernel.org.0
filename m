Return-Path: <linux-iio+bounces-8368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573894D23A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C452280DD9
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0D197A6C;
	Fri,  9 Aug 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETRgyUlQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E923125BA;
	Fri,  9 Aug 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213934; cv=none; b=GmYu2k6wvy5BvTD7aLTXh634eso8wGWDe50AC09TqCszwnVwP8jswZ1HkAQ3bWs8PN4aIST3x23BMxcNntiUONfev+McUE1ps1nAXuM4ruRe3OaNXsrkQSrXH7zJtWGfV4ioVH0vfjMWaETvDil0Hncx+WwfFLmcJrn4L++/Xyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213934; c=relaxed/simple;
	bh=ecgWLraO+k1GMspoEC7wUJdlXKt+YpF/A0yCBuNsqNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV+r7S5vHU0twdkdwgRsB1cKFsrM+QzjwDMKCtIhb7Zp4RP8T5XSHsBtdkvsztOBJDC4YY8bcFDOaVyEv6nT9iStlwTH8pnHHY4ezG08iaDJNgh6Vx0SsMVsKLdHJU3E9QIaK2PdSdj1cAdX93FBLJuDTAoaYwNkKclTK5IViJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETRgyUlQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1e1f6a924so124086985a.1;
        Fri, 09 Aug 2024 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723213932; x=1723818732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NX+Q+EfixZ+2TPkwx6jvCoFLNCbUvWrwCvVOitm7170=;
        b=ETRgyUlQyx4SownIHLmN4RKb3FBBoiwQarkHM/0kAhZrtgK7r4ZhnUg6/hzaKfUK9H
         v9VQq1mPi64ybiKsSCQa+mn9M8jm92jD+MeY7k0NNnalOQD0UpIZurkrGViJMlCb6GjJ
         +V/+D1EyQHguaySvhvIjX2ireRsXIe56/QvpKTDogUaRu2X7VZPyPDpKxv6g7H47l5Z5
         LlJR2tnAUVlEXiXH6L6OtVn1b7H3zGjIQJUH1es4HQN/leN3IY7/9aTzV7pbpNcJBNKn
         ubv4RyQYa1buthUpUmxhh0QC6vKQGJsrGmuu9ePiP+PAIv3P4vpTANdiZA7OJTn2+dsO
         d9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213932; x=1723818732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NX+Q+EfixZ+2TPkwx6jvCoFLNCbUvWrwCvVOitm7170=;
        b=tJGO/+ZDEp7eFxHITATlb0nbS9f0W/26JqJvqdmnZ64xMr0s6VSX1vwAD5OjjMjnKI
         b+YDCZDzTJid0nJWQPefF/sJN0zgMXZh8qwOa44048FzO5aRsN0DogZmUkS1jBw++4oK
         fFtfaflSmuZ7xmEZjODlf8Dolf96Mmp5cqbFasO7Bst8e3RBZ18VnWkEyv7SY/tWE9S9
         vy3BmJgU6l+Il7PIyQhQS7m8QZaGl1VZA7wTDk+x8MwUi6SoCR2aI9LJQVqHYQ/eFFsJ
         nEx0eC3tLr7k5hW3c8UF0yLyJ5sLwQpnrfp0X8mqiqFUKnW8FE7vszrAL49OGsVGbgu3
         MW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUim1DtGBfmBTrkh3mTA/RE+gnegVimNVNMujOGffFGZxCdS6hal+Sl+dD7c2EyTjXDf7BlDfxpLdr5JBI/ALU2JFUTkF54YoaPYr6wu4pZuXUv7poz0eCAK2QOHRkWT5sxSQTtEs9/VPnVu/TV80A8yA7Qt4zv1JzVRJ3WvRsaaNwsDg==
X-Gm-Message-State: AOJu0Ywt5dy+49Y42un2C7/cXchBQsqSgz5GgKZ6w03qWocBQl/1TNRU
	s5J/kJ/ELqbp55EGehA8zybIe68Vp3pSL++RtXmZrcLA3b7E47Ij
X-Google-Smtp-Source: AGHT+IFXc4sg/wacPaEzwe3kfd5rk1wqFBAPNS/hyuzA4sIDiHLr1YrwflGmuOVKSyIXG5iZOrtjNA==
X-Received: by 2002:a05:620a:4091:b0:79f:1eb:d76c with SMTP id af79cd13be357-7a4c182c0c9mr204921185a.43.1723213931983;
        Fri, 09 Aug 2024 07:32:11 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e5c54sm266701085a.48.2024.08.09.07.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 07:32:11 -0700 (PDT)
Message-ID: <67eb7f5c-3f20-4831-a0cc-e407ac3f24ad@gmail.com>
Date: Fri, 9 Aug 2024 17:32:08 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for ad4113
To: Conor Dooley <conor@kernel.org>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-1-2a70c101a1f4@analog.com>
 <20240809-glowing-discard-87263f656a7e@spud>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240809-glowing-discard-87263f656a7e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 17:21, Conor Dooley wrote:
> On Fri, Aug 09, 2024 at 01:33:24PM +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> This commit adds bindings support for AD4113.
>>
>> The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
>> converter (ADC) that integrates an analog front end (AFE) for four
>> fully differential or eight single-ended inputs.
>>
>> Added ad4113 to the compatible list and the "avdd2-supply: false"
>> restriction.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> index 17c5d39cc2c1..ad15cf9bc2ff 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> @@ -28,6 +28,7 @@ description: |
>>    Datasheets for supported chips:
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
>> +    <AD4113: not released yet>
> 
> Am I meant to ack it with this placeholder? When will the document be
> released?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
Not really sure tbh, up to you. The document will be released in the upcoming months.

If it's considered best to wait until the docs are public and send another
version with the correct link. 
If not, and maintainers consider that these changes can be accepted even
without viewing the datasheet, I'll send a patch when it goes public.

 
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
>> @@ -44,6 +45,7 @@ properties:
>>      enum:
>>        - adi,ad4111
>>        - adi,ad4112
>> +      - adi,ad4113
>>        - adi,ad4114
>>        - adi,ad4115
>>        - adi,ad4116
>> @@ -331,6 +333,7 @@ allOf:
>>              enum:
>>                - adi,ad4111
>>                - adi,ad4112
>> +              - adi,ad4113
>>                - adi,ad4114
>>                - adi,ad4115
>>                - adi,ad4116
>>
>> -- 
>> 2.43.0
>>
>>


