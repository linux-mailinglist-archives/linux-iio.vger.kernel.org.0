Return-Path: <linux-iio+bounces-5493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48338D4B16
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E302859F2
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF917E445;
	Thu, 30 May 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlM7da3W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD217C7DB;
	Thu, 30 May 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070106; cv=none; b=fwWP48zyvuCMV7JNwwQZvD2ScCdMVUmRBWs8tGWnTxDiOUNnBXVEmaA/tQCETJknj0+WutHUOl+CgXcLB9hnioSOHLrCT3BLLQFqsInRaCq6wmO1L1aeMwSmv+YogNlcFseQY9aZniwKJIOlYB49UM2Csppl3HwH1kWmk9gDHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070106; c=relaxed/simple;
	bh=nuTrPff7LYiWj4ug5SsKsttd9OLOCBvzCKzbDzsxMD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+swJJ4B38mV7dROyla1s1w32bSUfJSuTwDj60mtAA/Zd3UvRr4vtR95xX+dLEREk6LanMDGC3I2+yfKTbipkG4t3Zs646AaO0Ww1IqeLUEERnqJIIAmgJHamhS8t+By0nHfrRyGbJzWLqYn7zVCDfiJeG1V2N26m0GS93kcfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlM7da3W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaaa6so83530166b.2;
        Thu, 30 May 2024 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070103; x=1717674903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98Rwu4ByRm8xW3YycKDwkg84DOrNOo37YW7u3aMsN5Q=;
        b=VlM7da3WdN0+zAOSe7y3H4H9a27xpGraG8BTiITaGF9y1xaTBz1nm5tx2kPQ1p744Q
         XMeOdJbZ55FXKVEroC80wTIgHMNGLkZ0nzDHzJohZoTMWIgLFiP02jznLNNR8fzuqSxy
         almK7wgA5o+VQxae42AWMwPcBJYmsAvzll3uuE5Wk0ztgIg2eeLjTVNNu1v6DV+fo+Dd
         p+ODmQhCPe+5AzFk2dL6x57XCanf9folBbBj8lABgSyVSD/xT5ppsxaxiRzgn/UzQYQg
         GJxM+H1PWhICfL81wG05M8x+daGr77oiCPNqedZXtdMuiV7XEE2U3nOq8a+2Rhl024jf
         AVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070103; x=1717674903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98Rwu4ByRm8xW3YycKDwkg84DOrNOo37YW7u3aMsN5Q=;
        b=bL+xzuynka/sl2Aow7hqBo5R/w05c4DmFOAW5vAEY/DfCdxwhdl14DVKVdBf7XvNyw
         f4jeCXMSh9iFyc/lWfjMDtml43vIxlAUh+mvqxtEvQvF4hV9Ih4oHLwnwZk/r8KFMczI
         3P2Ip1672MRHXjKSEUiBuuloYpGvmf+bber3adCc9jHLvn25xPskdL5uCQ9owlKef2rh
         5ub7/co6160ye0w31xcEY4xAgdfZhhYb/leCZyHEFhUhEBVdfsGd8ckyCeYNWfzZTilj
         tvAR+frsYJ36PrHEBBCQ1vUwBDg4U9AlDVKRvXsuLU2kZa31YwkX19vgMX4RLEQUeETe
         t5og==
X-Forwarded-Encrypted: i=1; AJvYcCVvCpgTu83IDih4hkpcD0WZyNICah01y3g4EZaSHwlm31vXKdqicQDJV5euTrgmGzyiDe6mF+MIRLvl7pXH/BSUZkVUzdswai/YKWTcOHyHScUq4hLEDI8+1lrFEdbN7qvyqmN663eoKRpfqvG8Yn1bOZ8FO+oaiA6mwNlYigNeiBwucg==
X-Gm-Message-State: AOJu0YxNMM4ugVE+M1IpbTDJfoCSih5P0jrHEyx6K5Q0ia1y9A7zt2Tz
	/lq4ObRzmlMadDgoUFsrwPENHK87sRiF0cJUkUClhspSeSeX25WS
X-Google-Smtp-Source: AGHT+IHOqTD0p/PRYKnPlE8fsmtgFJ03ZAW/dIH6sZPJkZSmhSzaLE/4mI+D/zXzR/5nBVVdS0fzZg==
X-Received: by 2002:a17:906:3ecd:b0:a59:be21:3577 with SMTP id a640c23a62f3a-a65e8f7695emr126977066b.43.1717070102928;
        Thu, 30 May 2024 04:55:02 -0700 (PDT)
Received: from [10.76.84.175] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817981sm817586966b.31.2024.05.30.04.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 04:55:02 -0700 (PDT)
Message-ID: <17280af8-186d-47f1-a0c3-368f39e7c76a@gmail.com>
Date: Thu, 30 May 2024 14:55:00 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
 <20240528-filtrate-cloning-b9152322a3da@spud>
 <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
 <20240529-slit-verse-0fb06f3556fb@spud>
 <e0be3356bf809035963c4801f05b9db2675c111e.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <e0be3356bf809035963c4801f05b9db2675c111e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/05/2024 10:50, Nuno Sá wrote:
> On Wed, 2024-05-29 at 17:04 +0100, Conor Dooley wrote:
>> On Wed, May 29, 2024 at 04:38:53PM +0300, Ceclan, Dumitru wrote:
>>> On 28/05/2024 20:52, Conor Dooley wrote:
>>>> On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
>>>>> On 27/05/2024 20:48, Conor Dooley wrote:
>>>>>> On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay
>>>>>> wrote:
>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>>> +      adi,channel-type:
>>>>>>> +        description:
>>>>>>> +          Used to differentiate between different channel types as the
>>>>>>> device
>>>>>>> +           register configurations are the same for all usage types.
>>>>>>> +          Both pseudo-differential and single-ended channels will use
>>>>>>> the
>>>>>>> +           single-ended specifier.
>>>>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>>>>> +        enum:
>>>>>>> +          - single-ended
>>>>>>> +          - differential
>>>>>>> +        default: differential
>>>>>>
>>>>>> I dunno if my brain just ain't workin' right today, or if this is not
>>>>>> sufficiently explained, but why is this property needed? You've got
>>>>>> diff-channels and single-channels already, why can you not infer the
>>>>>> information you need from them? What should software do with this
>>>>>> information?
>>>>>> Additionally, "pseudo-differential" is not explained in this binding.
>>>>>
>>>>> In previous thread we arrived to the conclusion single-ended and
>>>>> pseudo-differential channels should be marked with the flag
>>>>> "differential=false" in the IIO channel struct. This cannot
>>>>> really be inferred as any input pair could be used in that
>>>>> manner and the only difference would be in external wiring.
>>>>>
>>>>> Single-channels cannot be used to define such a channel as
>>>>> two voltage inputs need to be selected. Also, we are already
>>>>> using single-channel to define the current channels.
>>>>
>>>> If I understand correctly, the property could be simplified to a flag
>>>> then, since it's only the pseudo differential mode that you cannot be
>>>> sure of?
>>>> You know when you're single-ended based on single-channel, so the
>>>> additional info you need is only in the pseudo-differential case.
>>>>
>>> Yes, it could just be a boolean flag. The only thing I have against
>>> that is the awkwardness of having both diff-channels and
>>> differential=false within a channel definition.
>>
>> What I was suggesting was more like "adi,pseudo-differential" (you don't
>> need to set the =false or w/e, flag properties work based on present/not
>> present). I think that would avoid the awkwardness?
>>
> 
> Yeah, that was also my understanding of your reply... But I think you're also
> mentioning to have this flag together with the single-channel property? 
> 
> I'm a bit confused because it seems to me that single-channel only gets one input
> while we need to select two for pseudo-differential/single-ended. Is this correct
> Dumitru?
>

Yes, that is correct.
 
> FWIW, I think we already have that awkwardness in the current form. If I'm not
> missing anything, what we have in the driver is pretty much:
> 
> if (not diff && single-channel)
> 	// then current channel
> else
> 	// relies on the channel-type stuff
> 
> So, effectively with the above we have
> 
> diff-channels = <1 0>;
> 
> but then wait, not so fast
> 

This comment properly and comically describes the hot mess 
that I've come up with :)))

> adi,channel-type = "single-ended"
> 
> To me the above is equally awkward (not sure if there's any precedence in using diff-
> channels like this though)...
> 
> I would like for this to be explicit... If we have diff-channels, then it's surely
> differential.
> 
> If not we could use the single-channel property and instead of using an extra flag we
> could make the property having either 1 or 2 items. If we have 1, then it's a current
> channel. If we have 2, then it's voltage single-ended/pseudo-differential. 
> 
> David's suggestion is also pretty good (and I like it's more explicit about what's
> going on) so I would likely go with it...
> 
> - Nuno Sá
> 
> 

Yup, as neat as it could be, I'll do it that way.



