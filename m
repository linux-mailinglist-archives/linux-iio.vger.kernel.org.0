Return-Path: <linux-iio+bounces-23873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41085B48387
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EF617B11D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 05:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96955222564;
	Mon,  8 Sep 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRD0yaXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C83FFD;
	Mon,  8 Sep 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308219; cv=none; b=m/Os5YMqxJGaVn9R3TbBEPQSZHZ8koUPndpW8cg+iMC0tEKd8nOsItld/9S/jJkC9QH1ADuEf7BGx6hhZgCU+VY1vHyxRA7BKAMWrncj9aDbL6ngdStOaJlGLpsYCMgM5OEtpyuoMau4aGjTG2oVljsVspd+jHeZvXGkBeuyERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308219; c=relaxed/simple;
	bh=Z4kq4jfnEyJU+3AHLchTPdyiIQs7HcLPdehBA3x2JC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYkljyVZifINdVfHDix6nKTgHuDMncvhymIhxyjlvF3FUBIlP9R2Em95B5wKR6x8h3ea9dDy6YRyXKmJk4+pKBiVhaMepDLncI+LEp6sR0jjioSxmhpAXSAiDhWTxCLbYwmINU8/oCEOrhQaaErOhCRB3uo209RoOtzplClCGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRD0yaXF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-56088927dcbso4933908e87.3;
        Sun, 07 Sep 2025 22:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757308214; x=1757913014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwvNPa68nMU4VRtmS8hjshjXdwUbdSMn2k7fmBvI9kw=;
        b=WRD0yaXFutEagvj9Dp0XkU23O21JDsDvnPizvqZerlWdV9QE7rcJ8RnNvYChvTckmz
         bSwp8u8ZP3hm3mjOofVm6N1FNHSYdc10zyMGPjDGK7wlp8SQwOwlAP3lfWfNmUCRDfhD
         /yTkt4xmgpLInb9TmXwT36p9Ldi3lBtMc9FjxwxEU5CmwwiUV18AW6XFe5gQq9JQl9pe
         BC8TqhsmZ8gQiuK8njOsH8V8Jz9k8SfyQaTxtkIpDNxUJk97HJr59oiv5TWng58HSHeB
         Rsd76eqlcZyg/oW6wsWTM0KuZ4TTI9A1ay4ZjqM62XRclhZxEd1iF0zOGuFM7lme1ix+
         kbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757308214; x=1757913014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwvNPa68nMU4VRtmS8hjshjXdwUbdSMn2k7fmBvI9kw=;
        b=JRbPVV9PKkH5avTbXr9gkWnUz8nP8nxT2/iSGiHL5KquHWDIRWuB2+d2yFRtts6iqT
         TTjCH0vfQZMJk3N1kgPZxzlzpXQhpDdNpq+gB4yuqcJoWmfRBEbk80jOGP7zGPue5VBN
         S0sniqHmFLqZJ2zbCWfeVCmCd8hHB3ILDGB99rYRpK9o1XQ+Byz0S/jTkqDdS0KOQTY4
         xTNTprYEGZhW9RSM+/nR0Qp9/zSK5vN0KoFK1LaOyXHggDzAsFWobh01rsRmVpSTKpup
         YBGiUWx8OEj/xmNObyWDKmdoK9DrnzP8Pu2lnMJcdPc+s7P3qyUu1WrEyvlecD/zKOI5
         8QDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUySjhHGnHwXP13jFHgwk2fQaNfd1u3CyPV1/bu2DMSybaWvXPMdKTp8rSgRvoFGMJCfh8u7a20aJ993neC@vger.kernel.org, AJvYcCVbTQu1XkW6b70V3EZw6ntjP1a5JmR29OnHDY75sNvtNK1ggjFx1wcIL5h3LoRsRtuB7UN26RagxS5zsg==@vger.kernel.org, AJvYcCVwuLjUxAwzGmLEPDSCtOXl2q0auKdrOxWrG5RV5gy+uxEGxrpvZ3w2YV0FVsSvv11rOpNxKATZ0liq@vger.kernel.org, AJvYcCW8bFaCA8N5VQY1dk8rW0iaoDNAAC+2CgDljiJ1ZSfxC1hicynA3vQxGmhRfvWlH3oItbL2XIPLh/G6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyip8xBcWQ6EBYKtq1TWCAcSSxi8y1THlBYdNEB+85c7PWylYVK
	w2g8thA9gawRzd30IpL8gMsEKTUbcSDDI3bRbiH9ABTbB6hDZ04QLZdn
X-Gm-Gg: ASbGncvjTzadlAtURFRf7UNuPviFdCXVyYCOHtpmKF4QAQgZTw19xMvCdZ+Cl4NHtvB
	pP0xiXJi5QNdb8yE18cbBzWmMCXJvwce4bvZvD1PaG+loJyOPzxkSE8bgPKrXM1g4nfDbMjmeV0
	c2EKpafs2q1ffIFogRWgVxA+kWF5L6scrgYfpVc8jqNcwNa7pAMyFk6lJfT9LwDGJ2t4UQdjJ2x
	NwFixlQ2ONEdZ5a/UtlKnTfqvBmhOm7HMyGNCT0usUlw9mnxz9YhHpYANYVHmQe9nY0S3doRYZ7
	tpNlUbHy988wTCLeD60czZOgSemZPmWHh9gidDuPAXbla4gksXjmQrl8j3uSUvJ6BLpA7xLUBnC
	OXKfAkvzImhBnu7H5l/FccnGLcSn7BlEzxaoJjmJDC3WdGwmQhHbX/DCF1pY+Ka1Eu0zDj7Xdbv
	nKut+G/VZ6vc2tecM=
X-Google-Smtp-Source: AGHT+IH+vtWIGdiWyIBl+H+UubUCnnORHKARCt16A0PKDJ4/6PlwygQLoAKW9jLmfGGQg19WTAS1Ww==
X-Received: by 2002:a05:6512:3989:b0:55f:542f:1f62 with SMTP id 2adb3069b0e04-5625f90f8dcmr1756390e87.19.1757308213417;
        Sun, 07 Sep 2025 22:10:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc152sm3402830e87.101.2025.09.07.22.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 22:10:12 -0700 (PDT)
Message-ID: <de6b31ec-7a5a-43a1-b352-2b46055a1a23@gmail.com>
Date: Mon, 8 Sep 2025 08:10:11 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Hans de Goede <hansg@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1757053456.git.mazziesaccount@gmail.com>
 <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
 <20250907124207.2fe64214@jic23-huawei>
 <CAHp75VeaHFDDZDmc9xsbUxZbRgkipRtcSdXN=ZXL2+V2OvL=Mw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VeaHFDDZDmc9xsbUxZbRgkipRtcSdXN=ZXL2+V2OvL=Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2025 23:55, Andy Shevchenko wrote:
> On Sun, Sep 7, 2025 at 2:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Fri, 5 Sep 2025 09:42:31 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>> +/* ADC channels as named in the data-sheet */
>>> +static const char * const bd79112_chan_names[] = {
>>> +     "AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",       /* 0 - 4 */
>>> +     "AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",       /* 5 - 9 */
>>> +     "AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",  /* 10 - 14 */
>>> +     "AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",      /* 15 - 19 */
>>> +     "AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",       /* 20 - 24 */
>>> +     "AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",   /* 25 - 29 */
>>> +     "AGIO14B", "AGIO15B",                                   /* 30 - 31 */
>>> +};
>>
>>> +     /* Let's assign data-sheet names to channels */
>> Not seeing any value in this comment given the code that follows.
>> Probably drop it
> 
> It was my suggestion. I don't know if you noticed that the amount of> the values is *not* power-of-two and it's harder to find a needed
> value in the list. Moreover, you can read the discussion back and find
> that actually it was a mistake in the list, which can be avoided (or
> chances of which will be minimized) in the first place if we see the
> comments.

I believe Jonathan meant the:
 >>> +/* ADC channels as named in the data-sheet */

not the "index comments". And I kinda agree with him, that's not adding 
too much. I'll drop that as suggested.

Yours,
	-- Matti

