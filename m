Return-Path: <linux-iio+bounces-10324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C770A994231
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DBC28E804
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA271E3DDD;
	Tue,  8 Oct 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXHq2HWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B0158205;
	Tue,  8 Oct 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374826; cv=none; b=YDD8cpt67aEvykxel1BOZQRhy0ykhX9+SAwAivDp7piICPehghc1pYmnN5cVwXgKtR01RFpsgyN56jUVdk3s8TGLHhd4RR6D65anuc+CDHwIUQw65Lo7G8CZ0bNI/XVpO3Dvn+Jl2b7PG6ulMr7PApggifXtRFUm6Lm/RVijKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374826; c=relaxed/simple;
	bh=1FKCEDf1yYnvgKCYNRShU2hbbbp2kemCvRPvOPaV3Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3F4TIVtXG8uzTbU5NP3gIXahzy5CuTalmC4txptOOR9MmbGYiOrciXO+VZgjxHvpQFIjsgtLMdAaaAIJgtyT3SzJWYcCdwxf0Yf+D2yIik7nga6lFt58mjP+jP/NZYdMwgardf4x4P/XuMbQrErRB+nBhflgEX8FMqD7Hg9Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXHq2HWL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cc8782869so54592835e9.2;
        Tue, 08 Oct 2024 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728374823; x=1728979623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNFC4+hasWqZDuU/uZND0naunWg3Gxn9UxxGPWVmBzw=;
        b=jXHq2HWLzEp625NbuEmx5WMquUSlC8IcdAIRsxFUk8cSrk5ixGt0NRC1GF9ewJrrAu
         Je0nwI5jyBRWPs/jT/X9x2fg+cwoMeaP7IG2WLwzCPv6gn1cxm2gt+6msN3QU+OvuJDJ
         bMfScsG7azZ7Auf3dm+/Mf4pUxERwdEDudZR7wkhkwervZxHHuzJ5lmEskK6mqvkIMMC
         vuwcLQfbijwfVIgrDIS+mNdf8gbG4lEOVKSABkREm0zNGQD5uxv1ZW1Qo3fYfIdHkzL/
         KghDFAxH8d6f8rp6V3ZfmqdNF037U1EoaIc+h0+8eSFGPQz6k1xzHG+vNETc4dfR0m3G
         /qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374823; x=1728979623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNFC4+hasWqZDuU/uZND0naunWg3Gxn9UxxGPWVmBzw=;
        b=BFd0Gh2tJx4gsFmulYFqKvaSVz+do3E4wO5EbAVo9TRQdYriJamf2Eia4mtE6eTUlY
         pPQ7Dbvt5dkAP7cjBcAfxFHZ3W1/4TvRYlpQ+GnaxLKg+f06AiYP2r1Il0NuF68TqA1O
         6WQn1RrMmXeBaSEqID++SXXydMj4gTtIRhfHDxvM3c2DcuDJQbcQPgjH0RSMjqvK5XVK
         wyCiEaSAtEiuLEYAtNoytud7dLVIQ2ZzNz6xga7hpIfJLdK3SsSjVWGpkZXdnHgN0sBe
         +aGixFgf3oHTcmoT88+7bWAyTRtcjKijncjOlT1LfD2L74Kcc7ovJOW99XkV2scuBCaB
         QVDg==
X-Forwarded-Encrypted: i=1; AJvYcCWeuS3lRR3WxPvzVcQZwNxU1vmmAltLUW160navvM30Cd5Zqs+pO0CvTKwnqTuLp5Kg4ErMqDtiHlZ+@vger.kernel.org, AJvYcCXWptjSdRtES0+KKPAWT/T1T8dzUTSK7C8BQhB6JxhyePkYoqjNQiE3Q8PqJgvuzN43BZxpHh3YTGXi@vger.kernel.org, AJvYcCXr8K/qxpGT0ryX+FG4Ae4ZhaISbE2SH7VNtHyKBRgnih3XvU6di0wp+Sv8tVyNgmKD1M2dbJRSAX+DJcG9@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAIjKy1SCKbAFyG8jwjpzmmKMY8mj8xOacts0G5SoTI8y3ScM
	pGTC1cqyJBHTaHL1Gl4EOgKbaoQUsscu0ln4KOCoTaGwmhj3MLZ6UOy0cw==
X-Google-Smtp-Source: AGHT+IG1TXVqWOrMKTBMyUd/+MlPDkotGlQewVa9TEKv6HFTeN3eMLfQyNs5ziZxq96/IQgHq/pn9w==
X-Received: by 2002:a5d:5009:0:b0:37c:d23f:e464 with SMTP id ffacd0b85a97d-37d0e8df33bmr7648819f8f.38.1728374822510;
        Tue, 08 Oct 2024 01:07:02 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:578b:a230:63d:cdd6? (2a02-8389-41cf-e200-578b-a230-063d-cdd6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:578b:a230:63d:cdd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169701aesm7530173f8f.92.2024.10.08.01.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:07:02 -0700 (PDT)
Message-ID: <c63f92aa-3106-418e-a8d1-2673cb369fef@gmail.com>
Date: Tue, 8 Oct 2024 10:07:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: light: veml6030: add veml7700
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
 <20241007-veml7700-v1-2-fb85dd839d63@gmail.com>
 <4w7vnp56jvo67crvpxufb5nifjlobyohxgpg4kkpzzj553s5rb@z25g7rwcn3av>
 <045fa597-8977-44c5-8dcc-3233623ad7e9@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <045fa597-8977-44c5-8dcc-3233623ad7e9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 10:01, Krzysztof Kozlowski wrote:
> On 08/10/2024 09:56, Krzysztof Kozlowski wrote:
>> On Mon, Oct 07, 2024 at 10:36:37PM +0200, Javier Carrasco wrote:
>>> The veml7700 contains the same chip as the veml6030 in a different
>>> package with no interrupt line and no pin to select the I2C address,
>>> which makes it suitable to be supported by the same bindings.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>  .../devicetree/bindings/iio/light/vishay,veml6030.yaml   | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
>>> index 6218273b0e86..53b55575efd3 100644
>>> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
>>
>> There is no such file in next.
> 
> There was no in next from 4th of October, but I found it now. However
> the diff chunks still do not fit. It seems you are sending multiple,
> related patches. Organize your entire work in one patchset, so big
> picture will be visible and any dependencies will be clear.
> 
> Best regards,
> Krzysztof
> 


Hi Krzysztof,

this series uses iio/testing as its base, as it requires patches that
were applied to that branch. Apparently, they are not available in next,
and that is the reason why the diff chunks don't fit.

b4 automatically provides the base-id in the cover later, but I
understand that you are not expecting a commit-id from the iio tree as
the base to apply this patch. Sorry for that, I will rebase onto next as
soon as the required patches are there as well.

Best regards,
Javier Carrasco

