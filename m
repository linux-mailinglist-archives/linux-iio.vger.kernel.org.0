Return-Path: <linux-iio+bounces-2015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10705840720
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAAB292D8E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09C4651B1;
	Mon, 29 Jan 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW7P15n+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB533651AF
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535367; cv=none; b=tGf9Juc+MUw83w0oRj/rBJlzXerWfi1CsYIxuwk56BwCTm/mOPjDpMMXUC3h3s1FJxyLO9eGa+VzrpfubwMwLqbc6nHCzwzk2jHBhDmUbuGDP1t82IWC4Wff0wI90z4SCuogd7siNOkYiTXwS3B651AdRHCTns25catUqSVw6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535367; c=relaxed/simple;
	bh=T4GnhyFR5y98C3HQibcoOIirEyGLtipGtL5LbXxfcq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwvpCvuWTiXs06tjN/xSJFRFwXz7DBf0efYu+KBAiKAqj7mDZawMwvAqf5jGBiYX/YW/Dn0kToP+bu6VcDjwfBn0flyTv4c/9ouh6mCs74yt1MsGlK4T/VXig7lOb7+Z1RIrinwTCbaHX2UEuSyRyXEfwFhY4BcLFMu9xaATlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aW7P15n+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2659417a12.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706535364; x=1707140164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q6N2pZMbADk6hGQInxPfW6SI2ZZFKsccj7BIbiE3RE=;
        b=aW7P15n+vpV22e8DoiJ5nNQqpiRAMkpWSGtaxRusrkkqxAo2zqtXFqbFYBUcOpuZ41
         AJeSiHADa/jyl/SivOSoLyxbudavmbg4192VyRFv9/YK874FD7gm+QUtUTbIb/HU22rU
         PQ7dmsQ0GzKsLSsIJgvuVZ96VpzPB9d254JwIthGlaXyrVgXIj+VMpo7qwINymP56qYX
         EH9r+BBAVAPQPtbFnpOMJOEi5qKkMrQyBgrKE6Tzqel5Rwv6p3G3JnlXNfg4X1k9kv00
         A+hhjj9ry3pML0YohftSknS/a0rFQ0UjzkQ0QR2IKu6rWYKXU2FSE1pmRaOpYCwxajEW
         3YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535364; x=1707140164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q6N2pZMbADk6hGQInxPfW6SI2ZZFKsccj7BIbiE3RE=;
        b=QebX59lcG+L1LL7acI33ypRvaJe8pxEEsVvJ/3mNWifGy3J+qLaYJrcE+uWZWW2JcO
         fDxR1YD3vb/kubq4rqxwhv12xWIy+REIClT7WTQVku5jSps4IbtbK4mV2xIdkCAvbxe5
         w6YR4ukbrKYjvQYHRH1u8VYdz4jrahTViBdS6spvA6JDA3ZtH13WSnnT1+UWtcrL01CG
         pMItLNoO2D2lvXkm6Nbymygc3zNGww5kJZJz7EbMSrPInL/C9O7Clu2Tl2+U0/yCcM3w
         lpTlBZV7B8rGsD++t8UIQK9+BgNgvkyJQ4X7mdXGQlvPA3JZ3CXij8lgRSiLBJtwi3GW
         nRAg==
X-Gm-Message-State: AOJu0Yxq52XYcGpoQ/PxsppYF27Wm8OEbG3O6vbQWEp0SiFQLoFTUXOQ
	gsdiPN94QvndGQ/LK83hw0VVUInPZQ4WHnp919N01obtTazP5gYaplMEYb5DlaY=
X-Google-Smtp-Source: AGHT+IFvSzupYrbAuZXVqQZS682YoFgm2/VdRtM3rplknMIFhn6DhR8wf6WmpMQ60zUU0D2kJ3zjhQ==
X-Received: by 2002:a05:6402:2741:b0:55e:c56e:b210 with SMTP id z1-20020a056402274100b0055ec56eb210mr4467097edd.17.1706535364032;
        Mon, 29 Jan 2024 05:36:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n3-20020a5099c3000000b0055971af7a23sm3906608edb.95.2024.01.29.05.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:36:03 -0800 (PST)
Message-ID: <b17b63cb-9c05-477e-9e0f-3027c5e45d00@linaro.org>
Date: Mon, 29 Jan 2024 14:36:01 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
 <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>
 <ZbeoczLjkGG8pogL@lore-desk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZbeoczLjkGG8pogL@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:30, Lorenzo Bianconi wrote:
>> On 28/01/2024 12:25, Lorenzo Bianconi wrote:
>>> Add device bindings for asm330lhhxg1 IMU sensor.
>>> Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
>>> all the features currently supported by asm330lhhxg1.
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
>>> index 28b667a9cb76..7ba3de66a2e1 100644
>>> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
>>> @@ -49,6 +49,9 @@ properties:
>>>        - items:
>>>            - const: st,asm330lhb
>>>            - const: st,asm330lhh
>>> +      - items:
>>> +          - const: st,asm330lhhxg1
>>> +          - const: st,asm330lhhx
>>
>> lhhx is compatible with st,lsm6dsr, so some explanation would be useful
>> why it is not included here.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Do you mean something like:
> 

I meant either explanation in commit msg or adding lsm6dsr fallback.

Best regards,
Krzysztof


