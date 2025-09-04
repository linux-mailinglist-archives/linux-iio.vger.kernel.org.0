Return-Path: <linux-iio+bounces-23703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92234B43BAE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D15B5A26E7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AEA2ECD23;
	Thu,  4 Sep 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg6hOliE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8C2773CB;
	Thu,  4 Sep 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989342; cv=none; b=qCVOrwU2GGXP25iFdss2ZKLAJS56j0dDBKyrPb90Pz1xjfgUjF2eyWrU7SZ6KseSEaw2nLBOpoDuvIKVZo/COJ4umhlnCB4djzB8GahL4I2isWeIgnDc/xvAFl/ezK9JMzETczkrp5G3RTEcNRws0djeFbqFLpLrBaknhLSx2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989342; c=relaxed/simple;
	bh=iGXqsuFVuUG2I1oYAHZMxD6alZmWDXebto1yrO4oz5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxUPzDNzVv/cxdaKCrpkhk822uooHDou3wBtCgksBL1ClahQRLfnRV3zkAjtR42JMrEOh6IcPpnoDFmO+M35UHynmcWRJBjyyMn5V1q8kgh1RrruB2ur8JgLM8kXYBBgBvr80LPHX1+Krb2KTpF4ziAsoRCHwn+TAkNIqD7Vfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg6hOliE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5607a240c75so1014525e87.2;
        Thu, 04 Sep 2025 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989338; x=1757594138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzLj+zIgPpFrAWVtQ6jPGHmw4+7i/5dMoIlp+lkaKxU=;
        b=Bg6hOliEUsH9Vc1qD4Pt2pr28rcTznEsyc3MdkW88lmU+EExJDvLQ6n7IHOP5wgHOP
         8EmmQmfwJmKhr/zWXr94pSkEmicJQ1tpCGV0i+0IhtlCGz6XSjKZhigIN48bqS16e1z6
         or3eoImaCLTuxV+CLbgsngznPiJRCDt3jXNeiaxQzFQjyymRdMt194jc6jbCRxgJassM
         qmMWagCkmkaOgf4NntjdwhBg8mI/vp+HhuKNOI9tQqfCi7FxbvpXgycfb8zd5iu0WQsP
         T6SWAJwPlG9lFAVDGLM/aDCOJ/EOaUPFNz2+bHIt+JiicS1BDNaDepTt14Fr8HaefLSC
         u+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989338; x=1757594138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzLj+zIgPpFrAWVtQ6jPGHmw4+7i/5dMoIlp+lkaKxU=;
        b=llq3rzq36mzc88+fBgJ11yoTg7MrEXfAZTxri05vJA90Vn3CFHEV5LaX+zkwM+BIUI
         YTgJttYv2TTT2T3YDYfWfrWpnq26RnMKZdJAJCe++N3oloz6aywt4pUscp6ovYeECzvo
         GALb3WPMqFI8wAYuJz5F3fTiLvfsi5d0089bINbPy9nBxR0hqjuUncSzY+52XTNvsYOM
         iUpe8xgqtqTj7qf0jg5Nj1nGcpLX/s6UWKNIjIN96kbuiDVYVorszkUZ2vzFjC4ttJaY
         ANz4AF7kQujwA7T0PpOIIecjnFRB//sfGNp1RqD6ARN/htVRkH5ZTqjjTVKtktRvNSrB
         SqbA==
X-Forwarded-Encrypted: i=1; AJvYcCViFNA0ZALerrA69jAmaK0ybiZC9khPTuY8gcITySeeXXm9O5bLL5rvj1pDG0YzJ6ib3f7pPMsRUbfF@vger.kernel.org, AJvYcCVrTm0lcMBIls6ihvkw7czlYzfu5QT222cxPBckOSOJ/8C1xnicgQFzwL3Y2FiND7mz5qgwrdZlSAoor0uV@vger.kernel.org, AJvYcCXazBo8Q9g5Y8xcrdGUi8bSeLwsIyyhPMAe2Bunss5odJy/kRLo8fNdjxq149/AwUn2nwJyIf4Wfv+zKA==@vger.kernel.org, AJvYcCXhyiEjELJkpm0XxUfo6J3EqK/7UY4k3S+M8l/lRLzJgmZ+T0f6//BXp3LFKZ+lWfsSZtojxo7z/kLm@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYckjiL+ZI+ExkL44QKILlqn4TT4IXJCptL3YSlQ5KEqt/SS4
	4a/RM0yRuEOxgVXP9myhASPEzlhCeHB72xmbGi03jCm3KfatCaSmjXAI
X-Gm-Gg: ASbGncvWLKuHX3Sf6xgx0qbhgrA0fojTkLBVQgJiYGYiucpxjiQAT5l7M8UcfbA3Kfi
	AYMnj6uC3ccghLnyDvuWeIxNglDBsf6R7n0fDrEQsAD7ylEchU+P/R6JzGcfO69y4LScvpB2Lbl
	9qKmjqcHGpD9MCls/HR6s6Pjo12nqxxA3jX4LMefmlaiwepS/KSch8Gj9rp01v6lcNtfFKdIWpS
	qUVp53bBhbAgwsihOvtlowYTHW9Mwjk56vP/ZAAwhCKpNe01Q9KHpjQ7LxId9jx3GgKajpLCrJC
	CLEvmQ+54dhps1Klmg4Zx1WT/R28NFxLvBkRSEQXsqfslNmSZZd2YDMGleCfgbTmq73sb/LtEU2
	xliCZ4MYebjG2GsCMyTc5YnGmQf40TDrU
X-Google-Smtp-Source: AGHT+IENMFv5xHK/CdOCub0m4AEAAbu/52uJtZNubU/VRWn4qjb27C+owK+OSqSLCNN4YWFaLtIHPQ==
X-Received: by 2002:a05:6512:6390:b0:55f:348b:ffd with SMTP id 2adb3069b0e04-55f708c1fcfmr4313703e87.21.1756989337947;
        Thu, 04 Sep 2025 05:35:37 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c174sm1216379e87.11.2025.09.04.05.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:35:37 -0700 (PDT)
Message-ID: <43141a95-2267-44de-bd7e-11eb8c80090e@gmail.com>
Date: Thu, 4 Sep 2025 15:35:36 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com>
 <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
 <aLglJoqBDap_eMIj@smile.fi.intel.com>
 <10c6b0c4-d75f-494c-bb3c-883c06cf3bc2@gmail.com>
 <CAHp75Ve4vgU5kK3z3bZyGqDOPVkMbW7RUd6_EA3jjZSeruWs=Q@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75Ve4vgU5kK3z3bZyGqDOPVkMbW7RUd6_EA3jjZSeruWs=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 16:29, Andy Shevchenko wrote:
> On Wed, Sep 3, 2025 at 3:14 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> On 03/09/2025 14:23, Andy Shevchenko wrote:
>>> On Wed, Sep 03, 2025 at 09:52:02AM +0300, Matti Vaittinen wrote:
>>>> On 02/09/2025 17:15, Andy Shevchenko wrote:
>>>>> On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>>>> +  data->vref_mv = ret / 1000;
>>>>>
>>>>> (MICRO / MILLI)
>>>>
>>>> I find this much more confusing than plain 1000. (I know we had this type of
>>>> discussion before. See [1] again).
>>>
>>> Rings a bell, but that's what IIO reviewers suggest to do nowadays as a
>>> compromise between creating a new bunch of unit (V) related definitions.
>>
>> I am sorry, but this just seems stupid to me. I'd say that it is very
>> obvious for most of the readers dividing microvolts by 1000 results
>> millivolts. And if it is not, then having this MICRO / MILLI is likely
>> to just cause more confusion.
> 
> No, it tells that we have a value in microSOMETHING that is converted
> to MILLIsomething.

No. I disagree. This tells that 'ret' from the regulator API is divided 
by some unknown value, which is a result of division of two odd defines. 
Especially odd because one would intuitively think MICRO is smaller than 
MILLI. You need to look up the definitions to understand WTF is really 
going on. I think this is plain terrible.

The fact that we store value in vref_mv should be enough of hint that 
idea is to have value in millivolts. Dividing by 1000 before assigning 
makes it 100% clear the ret is in microvolts even if you didn't know the 
regulator API to return micro volts.

>> I _really_ dislike these defines. Why is MILLI 1000? Why it isn't 0.001?
> 
> You know exactly a few reasons why it's not.
> 
>> It makes no sense that KILO and MILLI are the same. Especially not when
>> we are dealing with physics.
> 
> Yes, this is the limitation of computers and particularly of _a_ kernel.

No. In my opinion, this is an example of, hopefully unintentional, 
obfuscation where blindly following some paradigm like 'avoid plain 
numbers and always use named defines' just results things getting worse. 
That combined with bad naming. If KILO is 1000, then MILLI can't be 
1000. That's 1 per milli.

And still, the original "mv = uv / 1000" is superior in clarity. Using 
(MICRO / MILLI) there to avoid plain number is just a sign of blindly 
and religiously following some 'golden rule', even when it results worse 
code.

>> This is just an obfuscation compared to using plain 1000. (I kind of
>> understand having a define for a value like 100000 - where counting the
>> zeros gets cumbersome, although 100 * 1000 would be equally clear. But
>> 1000 _is_ really 100% clear, whereas MICRO / MILLI is not).
> 
> See above why this way.

I see no real justification to degrade this - other than "because I say 
so". Sorry but that's not really a good reason to me.

> ...
> 
>>>>>> +  gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>>>>> +                                    iio_dev->num_channels);
>>>>>
>>>>>> +
>>>>>
>>>>> Instead of leaving this rather unneeded blank line I would move above...
>>>>>
>>>>>> +  /* We're done if all channels are reserved for ADC. */
>>>>>
>>>>> ...to be here
>>>>>
>>>>>      gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>>>>                                        iio_dev->num_channels);
>>>>
>>>> I suppose you mean something like:
>>>>
>>>> register_gpios:
>>>>       /* We're done if all channels are reserved for ADC. */
>>>>       gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>>>                                             iio_dev->num_channels);
>>>>       if (!gpio_pins)
>>>>               return 0;
>>>>
>>>> right?
>>>
>>> Yes.
>>>
>>>> I don't like this because now the comment suggests we do call
>>>> bd79112_get_gpio_pins() only to see if all channels were for ADCs. This,
>>>> however, is not THE reason for this call, only an optimization. I think:
>>>> having:
>>>>
>>>>           /* We're done if all channels are reserved for ADC. */
>>>
>>> Then you can amend the comment
>>>
>>>            /* If all channels are reserved for ADC, we are done. */
>>>
>>>>           if (!gpio_pins)
>>>>                   return 0;
>>>>
>>>> is clearer.
>>>
>>> Which makes my approach sustainable.
>>
>> I like your wording better, but placing this comment before the call to
>> bd79112_get_gpio_pins() is still more confusing that placing it before
>> the actual check:
>>          if (!gpio_pins)
>> is still misleading. Comment applies to the check, not the retrieval.
> 
> The variable assignment, or i.o.w. the source of the value we are
> testing is also part of the equation.

The comment explains why the check, not why the value is obtained.

Yours,
	-- Matti

