Return-Path: <linux-iio+bounces-4291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B08A5246
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BF61C21EF2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CB373527;
	Mon, 15 Apr 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T63ToMWp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FD7317C
	for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189090; cv=none; b=n+mO0rn6yPwJatbwi+//h97VFHxpkGKgJTMswpdJdOPrkal7XIAZmvUaZCiDSQ8jHj1LL3MArO0Mqf2SCBwd4gHnT1HFUY9RnPJ3S+lGJgN4gVsuoNXFr1qEsJ97bAmDh7E2HEPjENDoEQyI6Ke0rlKBPa+tRMax3xeeYLVO2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189090; c=relaxed/simple;
	bh=U5z04xeFEFohHeXTPP89QCfpwW85LDF/gltJCpHi0Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqOOqEH+ZDKeVJ5Y/YiA4cJ+igD3oneRjRB+v7uSSanxO5Rqm2WuhkmSmNynzTdzDvE8jh/IQLPUd7LOlNSmGu13Tfmo55Rc+qfoR6wAOp6vFUoenthhD6hxhjTnPkj5MCYiSel4QBZhNjbwT+OJWPkBdCQ4mIJYXVVF4cIjjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T63ToMWp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb7500abe3so642439a34.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2024 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713189087; x=1713793887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyF8j5e/Vn0tkB4dA5H/pOoSsq2QxVYbcq1G8bYyi4c=;
        b=T63ToMWpX6YPVHEyKABvnEAhvFMTBD+HnrTzRCLWXvnJaF6XFBCXT87CTLriAoTyyG
         MBi5NPTJYAgIf+68SMQnprffM2asOw34Wfa9HHg2F0/veFoeZglBVw6iRZW327A/u8+J
         FYG1cXGtbTOOnZid0STQiMsMtstWOmyRSKqx7ZHTh9MoUY1Rr3RzHkIElS0ZhIH0+8x2
         4zbqFaNtYRQK63PTfc1XfluSnjzgQJTSFfjhK0oA+JEMRm43zJ9mGnJ6rn8X4gNicem5
         aBTnOXt4H0OLSSyjwNAIMrpCOs+2n9zp8T+2GkG4CDiceeWxvwUUMGNzMR8XZ0b8xrQH
         koxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189087; x=1713793887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyF8j5e/Vn0tkB4dA5H/pOoSsq2QxVYbcq1G8bYyi4c=;
        b=OxmSzMFzCtQw6K9Qje80H0YvTGR18tvji4GACTuwJo/iTms9UYWkQPtTFaTfB/x3Rl
         hUGgCkaYPghPRCp597azSRJ1KyoHC7CnAG/1LlTnwvyS+qXhvdXm1acROM5l8/4SXjld
         ybRLIlneFROBN+bKJwMVeA5dZ46rNjIfRKEqaMQmCRBnnF9unsf3t3dka+8cfmvhghic
         xdwPVLwDKV7QG50pmjtWTvL/Zm0lj+u6dykyT/2Jh+JpSXhboLxmEKNKqwdWBF6arjx6
         E6He5FrmQZ2UYF3D6QXDxoESm545mxOPH4eW4IDAklPTxV0kaLgz5ACGeVRnBvq3Jq/Y
         si6w==
X-Gm-Message-State: AOJu0YycRDLDLITBKi/OyBju6Y4LgYpGHpYrNpYIzFXvNygJeE0nZhQ9
	gwIZsCBKpH7UbES2s6tcy5gfnl4XyeT2Dez5vLMHUAD88MtOvJ+dYfpz92zsaEM=
X-Google-Smtp-Source: AGHT+IEmNyG9InWbQhMb9+DiiGHS58IgBunb+N8T0XLN3J26EwxmoNFAoBWtY98vSMwY5P12yVPY1A==
X-Received: by 2002:a05:6830:1e57:b0:6ea:108a:ec55 with SMTP id e23-20020a0568301e5700b006ea108aec55mr10666655otj.11.1713189087594;
        Mon, 15 Apr 2024 06:51:27 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l14-20020a0568301d6e00b006eb7abcd6d7sm622048oti.62.2024.04.15.06.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:51:26 -0700 (PDT)
Message-ID: <179a795a-f012-4c0e-a615-c1ab3ba9093d@baylibre.com>
Date: Mon, 15 Apr 2024 08:51:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] dt-bindings: iio: dac: add docs for AD9739A
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
 <20240412-iio-backend-axi-dac-v3-7-3e9d4c5201fb@analog.com>
 <CAMknhBHZRfvNtkbpWbi7tTXYa_rgRk+Q4z5MOd0O61FeEqBQnQ@mail.gmail.com>
 <304de7549627332ebdda77cd0c00b327f7a7c188.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <304de7549627332ebdda77cd0c00b327f7a7c188.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 7:25 AM, Nuno Sá wrote:
> On Fri, 2024-04-12 at 18:47 -0500, David Lechner wrote:
>> On Fri, Apr 12, 2024 at 8:36 AM Nuno Sa via B4 Relay
>> <devnull+nuno.sa.analog.com@kernel.org> wrote:
>>>
>>> From: Nuno Sa <nuno.sa@analog.com>
>>>
>>
>> ...
>>
>>> +  adi,full-scale-microamp:
>>> +    description: This property represents the DAC full scale current.
>>
>> The description could be improved by saying what determines the value
>> that need to be entered here. (Also wondering if this is not something
>> that should be set at runtime using the _scale attribute instead.)
>>
> 
> Hmm, not sure what you mean here? For anyone using a device like this, it should
> be clear what this is about :)

I never used a part like this before, but Jonathan explained it in his
reply to my comments on the LTC2672 bindings. It does sound like this
is a common property.

> 
>>> +    minimum: 8700
>>> +    maximum: 31700
>>
>> Missing a default value since this is not a required property?
>>
> 
> Hmm, yes. That could definitely be added.
> 
> - Nuno Sá
>>


