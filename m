Return-Path: <linux-iio+bounces-815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455180C708
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BD21C20F38
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF22576D;
	Mon, 11 Dec 2023 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEynplQs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827F13A
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 02:47:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54d048550dfso6119605a12.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 02:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291619; x=1702896419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iu10axCXNQOyUex5d6hKgTIU+7A72rRPdIxo/2huolQ=;
        b=bEynplQsPdHZ4qIk2DbRsdZaFgp+vSqN+VsqMr1RT8sm1FfRqk9TR/VRBtCQvhOCR3
         gPc+zwTyB5Kzln/ygU1gfEiq7DgCWmdxX1l84QOuy4u3hQbxLIXAYHgmIBI0DjJLk3sH
         tR7ELP49A/+R/Yd2odnmqSDO2WpCL8NfuHwHamZV3/ocX4hnS2xXoOIdV0TCCMbN/SqL
         5CltEkk+P/w4J6PJA4L1BeTtvIiW7xmVcmYDoMkeYhX4NVJZu5XagMpDFaG8AXknEsTF
         yNeoW/iEMjawbdEFMleMf4HUVObfkR7bSbsWEETCn73aYtvVILwQtDD/GdTPxlpRstJK
         TFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291619; x=1702896419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu10axCXNQOyUex5d6hKgTIU+7A72rRPdIxo/2huolQ=;
        b=qgjmea+/ebRqWHRbgnj7j4oPvPLysFn18iXs0SMpy2jgdSaOLF0Q7g+sneTgGGyigJ
         /8IJzLywa9RKeod9jZnVvmUQB+m+4MuQcsmh40MYncwkbyhnYsUpH6qbl2Ys1ycWvd7N
         DgWrnkjq17BWnJPvs7d2TFg7VV2PtTIEimXUCCGw5qLKn9yykjr0i8vKF8jOWJslr6jE
         ijp/ReZowtbQLKlIqNSb1iz2BkhGLtUCINLYrUnQMzbxn7jhS9zQJicqPE9HfO3ASCwD
         HzqUe/+2SmbcMve7NETmkyCCcWQf6o88TwFBWI9HDFMCTm7/QN/EzMNm12ptPhklGb8l
         dY1A==
X-Gm-Message-State: AOJu0Yy2+ue7+6haJXpclMAqjoqul/CIE5jQ/Lg9j9xaj8LbTG8rMvz3
	keLzR91EsSXlaLEDzZ0HqjRlbg==
X-Google-Smtp-Source: AGHT+IHKe/6dU6ujVtN1jyG6ulas74PMQJZJLzbYan0kA208Rp06au3hIt+aGpvTq01IEa4P5+xWxQ==
X-Received: by 2002:a17:907:3447:b0:a19:a19b:4213 with SMTP id ac7-20020a170907344700b00a19a19b4213mr1070297ejc.126.1702291619163;
        Mon, 11 Dec 2023 02:46:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a1b65249053sm4560965ejc.128.2023.12.11.02.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:46:58 -0800 (PST)
Message-ID: <40b4361d-ab14-4a67-bcd9-13075e0bc617@linaro.org>
Date: Mon, 11 Dec 2023 11:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] iio: humidity: Add TI HDC302x support
Content-Language: en-US
To: peiyu li <579lpy@gmail.com>, jic23@kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231206134655.559474-1-579lpy@gmail.com>
 <20231206135148.559564-1-579lpy@gmail.com>
 <ae0758f3-ccc5-49a2-a37a-42925f4b0944@linaro.org>
 <CAELPsEZEMY27wuQWKQJ5k1qyU9ZvsiT0Lqzqy-MJy69A4v5S_g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAELPsEZEMY27wuQWKQJ5k1qyU9ZvsiT0Lqzqy-MJy69A4v5S_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/2023 11:37, peiyu li wrote:
> On Thu, Dec 7, 2023 at 2:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
>>> +
>>> +maintainers:
>>> +  - Li peiyu <579lpy@gmail.com>
>>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> +
>>> +description:
>>> +  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
>>> +
>>> +  The HDC302x is an integrated capacitive based relative humidity (RH)
>>> +  and temperature sensor.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - ti,hdc3021
>>> +              - ti,hdc3022
>>> +          - const: ti,hdc3020
>>> +      - items:
>>
>> Drop items
> 
> Does that mean just drop the "items" tag or drop the whole items with
> "- const: ti,hdc3020"?

On this one line with "items", and re-indent appropriately.

Best regards,
Krzysztof


