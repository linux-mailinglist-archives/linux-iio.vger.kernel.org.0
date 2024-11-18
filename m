Return-Path: <linux-iio+bounces-12383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961599D1837
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0DD281692
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DF1E1023;
	Mon, 18 Nov 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mQJ0sUnk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3D1DEFD6
	for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954826; cv=none; b=LYWd+v7L+AYBweG831/PNAPRZv4Bi9Pfu8W5ELZZQlmp+8lLXPv/ur9uteMFQ65vErfgin/PJobWdo/E676x8IoCb42iaU/2xlHAFVtIviPSVLOyfZRaslZ3cTUbma9skP35/+AtNn6ji/VVlVJ03aPgX+xFT1IR4WkobFrXUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954826; c=relaxed/simple;
	bh=PbL5qU7G89QRGe1mqq27S87ShiVyJjnCIGnqWYBTVYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJYiu32L0XdaDqRua1qbm+/7+JII6e0QXdW218O0akSf0wOBm4ex2zxllq0YuWiesGN+gyinYOSqLYW+uv2QTHQ3P/u4ZvJ7DKB0S7HFdFhSw8kUJ+zVFNBt1G89/yZqKlM0apfl9PdrZ2m9oWtOMBKYPMG24TbKilCi19kvVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mQJ0sUnk; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2969dc28dafso531179fac.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731954821; x=1732559621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aneuQOiwaFYBr88lA/0AyLISQzg4VGgde4c28AMLP6Q=;
        b=mQJ0sUnkYBzditB2hTN1FFUvTpznayKuJyEUOv5bhDcSp04nzcFEZJOKM9YHbA6E5K
         W4J69OMkCjm2sRbGRiPaZQSVTVo1xWij2gplfecUofmIh/kVeHzoMSmkjb9w6YMZPDeu
         M9xEJurtMKp0LRwgVAWKijimUv5CRC/jkkSiqIwzgY+sMk/FOxqufyofNys9tnatEMW+
         sWFVS2DRSS5pctAWgdyGSfqywF+aKo6d+iElKe3z2JyH2Rsf4MOQhPCu982N3XdeGoOl
         OkUyg6twnFoVeTK9oIR6LTHAicPhXgj8C6AuDU1s8UFLr3hU+cb7QI8Inx7E+v1TBW9c
         TJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954821; x=1732559621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aneuQOiwaFYBr88lA/0AyLISQzg4VGgde4c28AMLP6Q=;
        b=JqJR1oyLU0Gk+u4SGQ3Lrf/PrfJ8nyYYx9qD/io+yuGFI/W7KKMxIjdqy1hgSm7cnK
         v8fffSHPw54OD6naqFiHW9/Ql9pipX605/2CcHSu53zb0iR6I7PO4XlERZne6wZiUt2F
         zRT21i7ZEDVqUk8qoIf9lGHmpt6psd/So7sTm+GVGB3XQ0MXtLxiaC+E4a0e4psQKJMI
         rVFhSeGi7LUQwQ6ez+/gCtebJ4NsI13jehPU9VBy4D03hLhIgsJbR1I9yRyJEbUni+Ks
         WJoHyhkEl84bWkGhYvZZcguGxcggCEV0CTy6qsUbATNOKRfUIFvWsIX8izeF0nJQ6I5s
         b0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW20ATNlC8ExSY1+hVM6LzDknk9TAiUxaRBhybQ3EIuEvgoVpCK6n06dpUOQoADv/RdXf+TQpKbmzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3cW6uKN3rIx065y1A5uKJs+L9Wv2Ze2QdW5VDm5/vUPDtpx7
	ikaP+X83WYhqLZaCKLd15Ci2o0W8pJLjcJXxL0HB8dEeKhJGeQizUrXcJL9AeFk=
X-Google-Smtp-Source: AGHT+IGAsbhwJF0VOk/JdSVM72aUtGwdsVL9k36/zRYH/9py/W7xVmgcTjrc6OIRRMTekxdNRRCHQw==
X-Received: by 2002:a05:6870:5d8f:b0:287:7695:6a87 with SMTP id 586e51a60fabf-2962de1a23dmr11493982fac.10.1731954821562;
        Mon, 18 Nov 2024 10:33:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780fe329sm2913082a34.25.2024.11.18.10.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 10:33:41 -0800 (PST)
Message-ID: <02e0efcf-99c8-4c42-ae66-925c08a544b8@baylibre.com>
Date: Mon, 18 Nov 2024 12:33:40 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
 <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
 <Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>
 <ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 12:25 PM, Marcelo Schmitt wrote:
> On 11/18, Marcelo Schmitt wrote:
>> On 11/15, David Lechner wrote:
>>> On 11/14/24 5:50 PM, Marcelo Schmitt wrote:
>>>> Extend the AD4000 series device tree documentation to also describe
>>>> PulSAR devices.
>>>>
>>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>>>> ---
>>>>  .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
>>>>  1 file changed, 114 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
>>>> index e413a9d8d2a2..35049071a9de 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
>>>> @@ -19,6 +19,21 @@ description: |
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
>>>
>>> It would be nice to sort these lowest number first.
>>
>> Ack
>>
> Actually, I didn't get how I'm expected to sort those.
> Isn't ad4000 < ad7685?
> Or did you mean to put adaq at the end?
> 
> ad4000-4004-4008.pdf
> ...
> ad4020-4021-4022.pdf
> ad7685.pdf
> ...
> ad7988-1_7988-5.pdf
> adaq4001.pdf
> adaq4003.pdf
> 
I think all of the 6s, 8s and 9s were playing tricks on my brain when I wrote that.
Looking again now, it looks fine to me. Sorry for the noise.

