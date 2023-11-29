Return-Path: <linux-iio+bounces-480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170477FD164
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D27B282C0D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13667125DD;
	Wed, 29 Nov 2023 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7s10S/u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7190AF
	for <linux-iio@vger.kernel.org>; Wed, 29 Nov 2023 00:50:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00b056ca38so862995166b.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Nov 2023 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701247810; x=1701852610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xlabvtU9TYU854GcYhnSmDjYvklfmV7dgD/yBvexNM=;
        b=R7s10S/ukacAsCnN8V90dTwDTVKkyyITgmA4c+VeD3/lS2ax4LT1cIleIgZIhX7Lbz
         7tlrqXdUBXAUQGugxrRqrlpsY9hluBLwK/ThET5rmPytOhNOSCG8VLFI/60XVDYgaDgI
         GD0Xb2DP5dTl/IiehXX5daoQvNB4hnQWFdbcGrA+k1HNI7K+K3Q+m3Nj3QUxbLW/3EFY
         wfPveZzOItrepYYeGOOxG7pGu2UByt7f8q9t6cOZjqXfRvHOtzXG0Hmd0c8HrgO2aBlG
         6DhJ5M0PQs6xms10kwRoqnXomS1CrlOzAApi82IicPlCNg53ZmQcg1fJXWRwstzWuFFw
         H3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247810; x=1701852610;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xlabvtU9TYU854GcYhnSmDjYvklfmV7dgD/yBvexNM=;
        b=fcvYAhhrw20EtC3eIVJEUhA3Any4i0INUBLzHexv3RIvcgJ6DhhXM0TFCeROa9ZoZm
         AjVtuTPGKWXN1RmCzJLuiiXml+4vDAwDFETTHmdPuLvM0GzgsrK/hgWWNzZWdLPSbUFT
         lbcnEPC4ADi/jlPlwxWehstH++F74Xry8BLfLopx5b0iViZ2Fj+PA4aLCjYfzqjrvBkF
         lAxHrWtC0n+hxczy1QmKqkQL7Qm1G7Fn3ONho5iw8vLCbMWrUu7jhzsfQdtz1gtpoGRq
         spFQzFOGtnMjy2EEbLyHRT72jNVfLmvnSHgk/v7xtTRxOyyRir9VtFRn7YrZ0NMFIzY8
         FJ/A==
X-Gm-Message-State: AOJu0Yz8v6Tzvpb1qu+wLc8YujXQ/VntpLMb55HqLwkFA9YESdxoWPUz
	+aB3OlvR1/AL3TVpfvblG4XE6Q==
X-Google-Smtp-Source: AGHT+IG+baR5FaB5/2BmA4i5bsNNOLlOv7Bu12SdjPv9PBMaOWgglvvpinTEegKrP5pyZ9FnLKGnVQ==
X-Received: by 2002:a17:906:9d05:b0:9ff:6257:1b4c with SMTP id fn5-20020a1709069d0500b009ff62571b4cmr10529926ejc.37.1701247810254;
        Wed, 29 Nov 2023 00:50:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id mf8-20020a170906cb8800b009e776cc92dcsm7677727ejb.181.2023.11.29.00.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:50:09 -0800 (PST)
Message-ID: <745bbf6c-ea58-4401-ab1d-c2372d2f30f4@linaro.org>
Date: Wed, 29 Nov 2023 09:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: adi,ad5791: Add support for
 controlling RBUF
Content-Language: en-US
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>
References: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
 <20231128-ad5791-michael-stuff-v2-1-541bb1c9dc43@analog.com>
 <cf778d32-73a2-4ef2-a0dc-31c6c4efe3ea@linaro.org>
 <fde82c39dbf56eeb8decac715ce5ec723da31e32.camel@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fde82c39dbf56eeb8decac715ce5ec723da31e32.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/11/2023 09:28, Nuno Sá wrote:
> On Tue, 2023-11-28 at 16:58 +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2023 16:26, Nuno Sa wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> This change adds support for an external amplifier to be connected in a
>>
>> Nothing improved here.
>>
>> I said "This commit/patch" so you replaced it to "change", really, read
>> the Submitting patches document.
>>
> 
> And? Is this message so horrible? Yes, you did said "This commit/patch" but I thought
> "commit/patch" was the issue because yes, I already saw other maintainers/reviewers
> complaining about using those specific words but nothing really against "This change"
> (and I do have some messages like that). Yeah, the submitting patches document
> suggests to do it more like "Added a new property so bala bla ..." but I dunno every
> word in that document is blindly followed. Is this such a big deal in here that you
> had reply like I don't care? And even if you're technically right, there were better
> ways to say that what I have was not exactly what you asked for...
> 
> Submitters should make maintainers/reviewers life easier but the other way around is
> equally true and nitpicky things like this are not helpful. Really...

Nitpicking is caused by ignored review feedback and by not reading at
all attached/linked guideline. I gave quite explicit instruction,
including what I want the contributor to read. It was not read.

Best regards,
Krzysztof


