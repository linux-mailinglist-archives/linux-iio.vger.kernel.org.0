Return-Path: <linux-iio+bounces-9278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB8297029B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F698B2302B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9E15D5C1;
	Sat,  7 Sep 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bwUSC4cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE515CD41
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718191; cv=none; b=bGQi1ns4FDEVXibSdLiHi8O3NLN8jJNB4LUTeAdywnuhddICWSHsO5MfRf44SZw6V/dZcWPlY6N52gZFAGInocCv+GZpzUJvlkaTCh/edLJBLEq/b/W1cLJ+JU7OkGyywIiUwomwW6obkyqOSxpMAQFiQsHbomP7+tuDPHIz8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718191; c=relaxed/simple;
	bh=8RLIiF/EhNAkAd0B29n+wQKoPDxcgUv8bAEt4QMnu3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgAlFkGVsKLgh1kRXjym26SmVmJkU1I3F8qAaGwOpPxSQkwynfRzzhq3XcgZRGTZvsbfmgDe+LqgEnqdBZnTyAd0tuGlKgIfrf9yCw4JBnIZuQeJ94XhIixnVc/eDe36EUeTbIiPFLbPd3NEt5XGzfNcod/abp8cWeb4Pv8Qb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bwUSC4cp; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7091558067eso1361120a34.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Sep 2024 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725718188; x=1726322988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/QZJfBzCm4hUVLhVcDEOaWd70aOcgYhbhWmlTEpq24=;
        b=bwUSC4cpwahP+d3QdqKDRufkwuAepUkwiIGkAurg9yotmKWeiDuWkcrHCAhTcxGdwb
         9cu9ID37AgCNjGsUR3k+LWjZZsT06KcjyKie1H76WtvH9VkCiL69omXBNLua4+VBu+VR
         kFy8HOjpcgpF8nmzWdkAgLq1Ig3YEo58mNeVGionRwTc7AkctZnuM7mAxrr2FjRCjgMC
         Y0dRNYh0wIfHIpe2URZxjy6u8HD2ATaGUqfihzCl3+iSaUJ0mBHoA707cxboAmd3tEY2
         rLZZkR2rA0XMiENxrZZoQ+GllYrJjUMLaaBoJECz04PCsDz7GipK51tqneNvNzwEXzKM
         0+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725718188; x=1726322988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/QZJfBzCm4hUVLhVcDEOaWd70aOcgYhbhWmlTEpq24=;
        b=U6VGkDAOHh1GLqm1HLMTxKH8VzTf3gVm/xhwU3bZc7Q36F0NyhwN8bljbWzP+VvrVB
         fbOhXmYoGm/BvrcU0HkKMZBBHlHKZ5rt2XzUnUE1iIaz2+ICV7v15D0tsAnZUxRkRYNE
         r3b3obfXZqmifmQPKTEjnjIroBoHZ5bFLiAFeLCoq4aNk9B/LzbiZclHPLWhWsyZC3U4
         w24XuHTZ7Z6iOQ3tqxgRMRPkRPMkP2PFHfuw1GqgkEx7yiCqOwJwS8TwzSUESfQI8Czg
         o6z8PXhSW71kkz1z+LJIECM3+Y8EFuwfw5bzQ6rxaL1evOFkbHMkV1PIlDOwIX7L0L0h
         WjQA==
X-Gm-Message-State: AOJu0YxKQ5nfks3PwY4iGD0G1ssXU9WwfHZ/JisJAzF49m5HunA22Z3r
	awbsh113iyA7GKpQyan6k6lI3oTiMrp+Ja+Yr42VQgmt8/XQRLHu739Q6/UTw1k=
X-Google-Smtp-Source: AGHT+IFa0weaOhpprxoRDMhLm3AUJZ57Prw0T3MVjqqdX9fJcBkI3nZJhm4xxSKCkeuVvC/uSGqV/Q==
X-Received: by 2002:a05:6830:f88:b0:70f:593a:5a3 with SMTP id 46e09a7af769-710d6e298efmr2660793a34.15.1725718187951;
        Sat, 07 Sep 2024 07:09:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9de87afsm325238a34.80.2024.09.07.07.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 07:09:47 -0700 (PDT)
Message-ID: <a5472be7-26c6-486b-834c-2a5f6bfaf982@baylibre.com>
Date: Sat, 7 Sep 2024 09:09:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: add docs for
 AD7606C-{16,18} parts
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-8-aardelean@baylibre.com>
 <4f522d0c-7ed8-4dd4-83ae-f400d6958c6f@baylibre.com>
 <CA+GgBR-H8W_YS3gPrrvxAWoQybjEb-p36pqxEatFbEAnuz2DvQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR-H8W_YS3gPrrvxAWoQybjEb-p36pqxEatFbEAnuz2DvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 11:59 PM, Alexandru Ardelean wrote:
> On Fri, Sep 6, 2024 at 12:54 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 9/5/24 3:24 AM, Alexandru Ardelean wrote:

...

>>> +patternProperties:
>>> +  "^channel@[1-8]$":
>>> +    type: object
>>> +    $ref: adc.yaml
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description:
>>> +          The channel number, as specified in the datasheet (from 1 to 8).
>>> +        minimum: 1
>>> +        maximum: 8
>>> +
>>> +      diff-channels:
>>> +        description:
>>> +          Each channel can be configured as a differential bipolar channel.
>>> +          The ADC uses the same positive and negative inputs for this.
>>> +          This property must be specified as 'reg' (or the channel number) for
>>> +          both positive and negative inputs (i.e. diff-channels = <reg reg>).
>>> +        items:
>>> +          minimum: 1
>>> +          maximum: 8
>>> +
>>> +      bipolar:
>>> +        description:
>>> +          Each channel can be configured as a unipolar or bipolar single-ended.
>>> +          When this property is not specified, it's unipolar, so the ADC will
>>> +          have only the positive input wired.
>>> +          For this ADC the 'diff-channels' & 'bipolar' properties are mutually
>>> +          exclusive.
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +    oneOf:
>>> +      - required:
>>> +          - diff-channels
>>> +      - required:
>>> +          - bipolar
>>
>> The datasheet (ad7606c-18.pdf) lists the following combinations:
>>
>> * Bipolar single-ended
>> * Unipolar single-ended
>> * Bipolar differential
>>
>> The logic in the oneOf: doesn't match this.
>>
>> This I think this would be sufficient:
>>
>> - if:
>>     required: [diff-channels]
>>   then:
>>     required: [bipolar]
> 
> So here, I am a bit vague.
> This makes 'bipolar' mandatory if 'diff-channels' is mandatory, right?
> But then 'bipolar' (on its own) becomes optional?
> The way I understood the oneOf case is that:
> 1. if it's 'diff-channels' then it's specified 'bipolar differential'.

diff-channels does not imply bipolar in DT, so we need both properties
set to specify "bipolar differential".

> 2. if it's 'bipolar' then it's specified as 'bipolar single-ended'
> 3. otherwise it's unipolar
> 4. oneOf enforces that at least 'diff-channels' or 'bipolar' is
> specified if there is a channel node
> 
> 

