Return-Path: <linux-iio+bounces-14251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89157A0AB3A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C391887049
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981811BEF98;
	Sun, 12 Jan 2025 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I4XFi3Nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7194315A
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736702074; cv=none; b=r9tUUu2oJcMZM+N2ZyA7Hk9cyz2/mTQC+jgBcz8hwIYICrgTcdY8KWucMbG3ZbZmD/hx9ey/iZrcJu5vS/xQRQvNiDG3TO2HH9NKa8kM1LOmzfX0o8i9ZXdGGQUNtti5qspBUtNxw8zTwXgtrpAkJzHTsKFiSdauMT9bz7S+its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736702074; c=relaxed/simple;
	bh=Il39pY11lP0v97LPMc6RqA/oxxG0TgtjyclSP+RxwCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+nSskFVVZF2k+NAEkLYaUleaSiBjWDBRw5LcW1T9VXfEFXQb3u/dDZdxFgavBNAxyF3m7P9Fvpt464VO7IbqQVeRj0OFp2qji16uT+eFyXPPRyD5/V0Eioy5g8EDs7RJE8A+J+xM49iKIGCYq45nQy7oig+0pruLe59f2L3Dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I4XFi3Nu; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29fc424237bso2976406fac.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736702071; x=1737306871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWxqN+kzuNe7/HPSF0fETV2T/3iA00jo8P8nYOuV2sY=;
        b=I4XFi3NuWhTgQP0LUT6VGilrufNEU1qaD8pdUqOPNX7jhnmEA3gWnJ9+TLyrkoCvv7
         rAgnVmb/ct7T44TqdDxc0XSDlBu0sXS8N5kpHcNoWsFyDD1bc51egHoryty5vnJRIZhg
         17SybgZMjTyf31+NQfDlUYeZ/IOfa/9SIPKo9TOkj5HJPAtcbwpuKMVrhsIH9RBe0vBC
         sdLL59pqWQFc4QV03CR/t4soibsT1V9SLnMaNZpG7BbZ/3OhAUGJUC+pVBiNjm+7Y0li
         I5w2CxpyimWpfT1AWFLbdtizYbughRHdb+aFM6QDVG+CFSx4hLCpTRvzC42tvP3Bj7u1
         duaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736702071; x=1737306871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWxqN+kzuNe7/HPSF0fETV2T/3iA00jo8P8nYOuV2sY=;
        b=xLGnoYxDXuOZezykigxOYflvRCOOh8hEHqCQQ2SHpiQBmMAiAA56cNdENMt3LQ203n
         gt7bivoRlV2hndoPqlizsmuG0MJgRXPxXeaBu6KeniyI4tNhCOSDDHGD8gTUNE4RpYw5
         fvFbpw08VRU3AG3fnUCodKU4XLkmE506IwHS/sH1IgFdAvsp5JtmH2f4ziA5TSdGOiAg
         C7WfiZFulolPuzA5LJTfamooqEvQ7RkyOgV/SKbPux1TjXC1pW0HdRMMQRxn6R6q2K8s
         p7Jh2hpqPzred3C2Xfez+rWvukQzckRdfdrrjcDGDh58u5OGtnlG0aGMVbVAt+TtVEYX
         fFEg==
X-Forwarded-Encrypted: i=1; AJvYcCVnHdWytJkzwb+sOWX70BkORB0Zws5UUrXDpxddqfFbQr3F2XUag9TdD9gmW9vH2XVUs+PmB4zAhGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRcPtXiGsk5qxZYnbWtqvE4LLXAZmrfH7DUT9UBgCX0y6YqO9
	QnQTdAYUpeLcQDxyrrpw8jvc5iznBXPDLyynktNDHT2GHVnnXsGCfTVQdVs3erE=
X-Gm-Gg: ASbGncuzD0SOqPc99A/7CUtKXQDM7O8RsGhwa1Yx3V9bAAx/wfQtrQ90eBsThTvFbkr
	h5Fjc+q/51RVdxcKnGqwvgWtr1uw61Kn5kmnSgeQkbQiHjRVqfqnvPFihTVCdKJa+ovGQo6rWct
	jA51a2OHefvxK3vAjtACF9RNFIcvLzc83RUaWPuhXzkH/OupNe4DRWhg+Yuohi1/tGTKXtp2yt/
	gL9CzH7KTpTTvTNWkUBYcoigg4laNsSxEhdzDHiLEZSEqBWn5NkQliG1BqK11Y7Ol6AbhuRMJ2l
	6Kw1NyjJTj40kLfMFA==
X-Google-Smtp-Source: AGHT+IETiGF1kTK40hgNRIif8IOS1WGgUmOdhJQE9pRvl3rZcUHJ9bhykaoYPfu4kgQ9hIuNlsDwGQ==
X-Received: by 2002:a05:6870:1616:b0:29e:5bb8:fb35 with SMTP id 586e51a60fabf-2aa069e63c6mr9195037fac.37.1736702070860;
        Sun, 12 Jan 2025 09:14:30 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad809a64e9sm2908167fac.43.2025.01.12.09.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 09:14:30 -0800 (PST)
Message-ID: <86597fd3-5e20-4103-aca7-78addcf02eea@baylibre.com>
Date: Sun, 12 Jan 2025 11:14:28 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
To: dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
 <dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
 <Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/25 4:34 PM, Jonathan Santos wrote:
> On 01/07, David Lechner wrote:
>> On 1/7/25 9:24 AM, Jonathan Santos wrote:
>>> Add adi,sync-in-spi property to enable synchronization over SPI.
>>> This should be used in the case when the GPIO cannot provide a
>>> pulse synchronous with the base MCLK signal.
>>>
>>> User can choose between SPI, GPIO synchronization or neither of them,
>>> but only if a external pulse can be provided, for example, by another
>>> device in a multidevice setup.
>>>
>>
>> While we are fixing up these bindings, we could add some more trivial things,
>> like power supplies.
>>
>> Also, the interrupt property could use a description since the chip has multiple
>> output pins. I assume it means the /DRDY pin?
>>
> 
> Right! Yes, the interrupt pin refers to the /DRDY.
> 
>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>> ---
>>>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> index 3ce59d4d065f..55cec27bfe60 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> @@ -47,6 +47,15 @@ properties:
>>>        in any way, for example if the filter decimation rate changes.
>>>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>>>  
>>> +  adi,sync-in-spi:
>>
>> If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
>> should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
>> we should just be describing how things are wired up, not how it is being used.
>>
>> But if we also need to consider the case where SYNC_OUT of one chip is connected
>> to SYNC_IN of another chip, we might want to consider using trigger-source
>> bindings instead (recently standardized in dtschema).
>>
> 
> Do you mean the trigger-sources used for LEDs?

Sort of. There is a more general version of this binding in dt-schema now [1].
But it is essentially the same binding.

[1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/trigger/trigger-source.yaml

> I can try to see if it works, but would it handle the non-GPIO case?

Since the ADC chip is both a trigger provider and a trigger consumer, it would
actually have both properties. A chip that has SYNC_OUT wired to SYNC_IN would
look something like this:

adc1: adc@0 {
  ...
  properties:
    #trigger-source-cells = <0>;
    trigger-sources = <&adc1>
}

> While testing a multidevice setup, I found it simpler to 
> have a single device to manage everything. It lets us toggle the GPIO or /SYNC_OUT
> without referencing another device and makes simultaneous buffered reads easier.
> 
> Maybe we could stick to synchronization within the chip for now.

In the driver, sure. But for the DT bindings, we want to make sure it makes
sense for future use cases as well since it can't be changed later.


