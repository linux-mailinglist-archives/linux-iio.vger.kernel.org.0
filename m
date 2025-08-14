Return-Path: <linux-iio+bounces-22740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317BB26A45
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26619A011E7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE621B9D8;
	Thu, 14 Aug 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BppAGEUt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85925202963
	for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183079; cv=none; b=pcXLXvI1F0+gQJsMV9YGqXQSISdd4ZZ9BN29WKqemLzYI87sZSwBgTnyjGLsx4nZ/DQHUbhWofk8RIchwOsnsHxJZGeIUWgK2pTHhtn3n8U6o7bVrHxeqlwDf5rlmtnG/+Sp1yK+1n6cWAT/4alh/V9V8zh3i4vNO/tGjaHHOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183079; c=relaxed/simple;
	bh=fyP/OLr3beYwssW4o3anr5GsJIQEhtOVd8ngVUetdSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYpLsTsIkuK7wVH3WvgLSz2luHdLeJZjm4grkxlkc4Qt6EwNeuVJhElflEqvmXv2y4GXjGsWc8D/hb6RFfSKm0RU/Aa0ss/6UWdGY4zKxYnia3T5XF1cFLUmsNitx21q9nbo0AwfDav0558BjON/EH5w2qosyvu5xwReC1S+7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BppAGEUt; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccea6239bso907277fac.2
        for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755183075; x=1755787875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhLbtz2pbCynkwC1z2ilVubEr1pcqPcdknoxUGu5RA0=;
        b=BppAGEUtHHtmsexkVgMOslgdxIUReQ8vAOm59cKPcjPnjmIxbidYBt0Q+MCtzFIw2g
         OPWMj1DaHSHkHPEMlALAA+QCUKxu+iroLsvOY6hiBJQl0+Oesrvspmcj7lSBRWIAwGeW
         J13NeImus4GIgqybGU+oVoC2AeOKP4T7W/73m8TTsN99Ug9ESQWmWHlVbyVfDQsQ9h68
         pzizqRKMLmdX4SNIWW0guvzFHnsClC2irrsD9L/yDRMM8MY7p+uNj6OJtQn+IInf5h5j
         7H2qw/K8S6NNhqdDXpzqN5TG9JgbyUmWoKSQ7AVBKZtr1c48QotX5nXyK9EWNv0lvHZV
         M+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183075; x=1755787875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLbtz2pbCynkwC1z2ilVubEr1pcqPcdknoxUGu5RA0=;
        b=oA9JHi2qzDgpI3npsm3hGcdEiKZvpAFVIOJQ0Rs8ctnBTGII1rjn5ljOt/l0DnLCLu
         UFfdusrQNpIrBnXbc7mRjDmMLKkEs7YLaACGO+dvV4N8ovtAyaSDF0dp9aTP7LyTInhd
         6f5xw6EPoPHBddFu40RK346BEGyLlEF5YEpvwYNxEUSbult4IXkAhZV3VKBx+z2yNZ3A
         EXbEvXQnUXfmjj7o3lhsYZevrsddpVFATUbtsJjT8+8o8sNzVs9DScgFM6CzqOeR3CjI
         SaLorcZcz7f4lTX7rM+Y9mztTttJJ8JxRD7Uf3Pvch1d07pBo8/j58ENXu55fDYUC3xs
         rIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrolGhMpvSmz6XMZ9sKpFHCSsR28enALmE0HbT0s8iwuKewuGkDUj41jQ6cuPRBDTVgEcn71zBvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrSTrpLZI2Bg9sGxFDBAyg1iCLiIlaHpzVkjMMYDh9Zb82LoC
	O8qjv6fOqTGM+ifpBiKrsMFCvDpqIdDcOxKOnN1ngKWQ4/BwO0xlddnjslo35apo9NA=
X-Gm-Gg: ASbGncs+oktLwux0IAS9aUBxhGUHnPSAITZIOsV/YXrZFLBHS3gX+hD4OytRz0s8LTa
	miSHHTJYCzlTqe0YSC3F2yPiH40kJTOJwOMxW8Ehnc9EcxnqsKMcXCaEF+tsrsbqlCtCuKm2IEe
	mpbgGVE6mf2lvId8EKfrHksF3z+eDGIK1Et4a3H/oPg4w9qbodPksSytTo6CRpJjz6tjJhUQANh
	BnaodugLUq0lMmNWb0lEwW6rgMtuauztJqZbgO+NRtXAUgXcWCjFKUQCJXcBNFfKNqr96Cf7ktV
	PNXjH0XrADULLJAAucLca2XkJWWI5Aj4cVJ0lR0LiKdkJjlNkTH0wyFYQ/gNq8R+uyAV4wMyIJf
	F16041tr8DTez/WnAQRDqSllve8/kFExyF01jtijbhBvhivf+plqJAV+lEdijPmIrT7Hs95dVCS
	g=
X-Google-Smtp-Source: AGHT+IGBSpWFh7v66sa0tHjx26XHgGotdF9DhOCF3YJvgTAZk5dQT2EANWxR0b3KAVLYLKWGk2J75w==
X-Received: by 2002:a05:6871:6a5:b0:30b:582d:8eed with SMTP id 586e51a60fabf-30cd1399dbamr2002074fac.39.1755183075184;
        Thu, 14 Aug 2025 07:51:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f879fabsm1436841a34.13.2025.08.14.07.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:51:14 -0700 (PDT)
Message-ID: <b1cc499b-403e-4dcf-9e6a-10d4d43a8b30@baylibre.com>
Date: Thu, 14 Aug 2025 09:51:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
 <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/25 4:57 AM, Matti Vaittinen wrote:
> On 14/08/2025 11:35, Matti Vaittinen wrote:
>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,

Is it just a difference in max sample rate? or pinout?

>> and, based on the data sheets, they seem identical from the software
>> point-of-view.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   .../devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> index f0a1347ba4db..6a6e6ab4aca3 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> @@ -14,7 +14,16 @@ description: |
>>     properties:
>>     compatible:
>> -    const: rohm,bd79104
>> +    oneOf:
>> +      - items:

You can drop the items: here since there is only one item.

>> +          - enum:
>> +              - rohm,bd79100
>> +              - rohm,bd79101
>> +              - rohm,bd79102
>> +              - rohm,bd79104
>> +      - items:
>> +          - const: rohm,bd79104
>> +          - const: rohm,bd79103
> 
> Oops. I believe the order of the compatibles is wrong for the fallback.

Indeed.

> 
>>       reg:
>>       maxItems: 1
> 
> Yours,
>     -- Matti


