Return-Path: <linux-iio+bounces-14831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E897A24A3B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C53A782B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4CE1C5D52;
	Sat,  1 Feb 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KirQZXW9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D81C2DB0
	for <linux-iio@vger.kernel.org>; Sat,  1 Feb 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426681; cv=none; b=VxMJ5DxjAlNsln8foH9IgE1gpIFEE806/h3TdWY9KpDGMkpksNZakxV0mSms57+qMuhw78J1nrvSqnd8z4RWFzuXk8+T/0e7lAYb3iETWgIDMgKi6nq+Kqz1rA7UuazTyJwcnrG5W/KXGBJOhfhUISQ90r9UO5NrfG/OatPQ9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426681; c=relaxed/simple;
	bh=xvd2NFP5FB+CZsHk6V20vbHOvYWsNy5uLFVc9vcIMRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNCO3mrU8LYIKAMz2fpmW/Jq+8qCR3UCR8OXN+ZunExvh5mcBlH3PHe5IhIe1hWlq9ZUTdOadrPIRm/Oio93GzenNBNirDO5Cb64aaSBvNYYwaoeS2hAgvqRUhikNEpLD/AawvIJu2AdU7bf0fUzJrnTgXdgOY6GcXuqOm1OLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KirQZXW9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3005916aso807553a34.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Feb 2025 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738426679; x=1739031479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xa6g2oNfuacwFq4nVjdCRSL/cRrTFR4jPo2z/+uIvHw=;
        b=KirQZXW9fhrVxIBkbls4JrCj4qPKGc4b7sPnylfDShm6gQAjfdZm0ICV4RxNMOIFQX
         YI9k+wKeslFceFY2M3CpcV6DYrzg/UN/19czNbKbiBVWCdjl3MFKvuIi6SVs9c9PNtgm
         N3sCJxs6r7hc83TdC6K5GiBfEGOeYoGw4++nHh+fvCgiezRFuDF6G3WLMnFEPM0ix+1S
         BF4ZLGrRvM7vXcORDTWdhElEVIoi67I6+mIMFSdFFe6ZuTa0rD2xR8TjlzxnYeQNX0Vv
         KBZejBh12HHi91L6j5xvJhnkfXsp4owYc3rXS1CfOdFQmHw6s7mdmpF41xpEFLn9NbNl
         ttmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426679; x=1739031479;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa6g2oNfuacwFq4nVjdCRSL/cRrTFR4jPo2z/+uIvHw=;
        b=re7XXuI3iAf4LNz3wBC4izZaDInGKywuJDCxu0L7sBN39sfV7u8d1Dsii0tASfnJaR
         AS+6qEXmvPBRd302NFnpfQWNFGOgm7n4zqX/jDv5/UDzQyC8OS8myWbnaLbO8MKfSv9A
         ZeZT/HsaiADSX+Irq+4Lyo/mDtR4vpXMEtq1eQF5+DiB4d/JxRifS9P9Age3Kg7qZauY
         PNa4kjWq5NMje3Vt1aIQMnxueC7/KRg5z/yEP6prnFk7S5e7Z5Skf4K/BoVwfksdeTv1
         pqCLaMXQBIN1fzI6QWmz2jueTn7hoW569yB45PhW/Vlg47MyF/ECB/64IWFNfOv9qR0v
         9y9w==
X-Forwarded-Encrypted: i=1; AJvYcCURJrSCf2JSyFLlpOG0sGjPLJaQtKuTEXzIBwSiGTn5DsH90uXu9QHdZJasiJXxuFc/TFhAVQcIPxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZmwI5SsfHnGuc+YH3gq2O/J1Hxeu/f/fjzWgCRO9Dg2MIR7i
	YKOxW9dkdEAWipnln8YDZi7y7SC2YopK+hkt85ylhy0EwAXxhUHVLj4kOqHs5vY=
X-Gm-Gg: ASbGncsA96UG+d7DIKjkX9VWhrifeuQzikrgC+HOAGrYRp3USMltstlH6jfhAezJnE6
	hCcT3TRTQ95SdEoeZt2HhWeWomjd1MQGOSAckd/vM17mzLGTGMBe5PBGqXlTkJU8HN2bkrWnu+j
	+9bzNDbssU//d6UKr3P/TKAV2p0e9jmx/SPdE/hYrbKWfOM8OT6duFx3Vm5mfteI4PadA3u8AFD
	4pZpoI6qRH1vYdCI39Hg96MY/i3o6Bq9bcddBJjKS9oQUi9VNIfiDUcfv0k9tuD0VtTe+HcRzF8
	IaFuFwP+jLBkSK3Pjfp1xbiQNzPep1UdT+hNmM9zwSIRCSqTG9nO
X-Google-Smtp-Source: AGHT+IFzTntDqApDTAnL1g6GyTMtXHnjjv0+Ekcn43kwaqkrr7pFq/ZL82JAD9ToxQaZIxfyiLBkBw==
X-Received: by 2002:a05:6830:651b:b0:71d:f343:5f5b with SMTP id 46e09a7af769-7265676f070mr10847417a34.12.1738426679061;
        Sat, 01 Feb 2025 08:17:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104e27cdsm1476222eaf.16.2025.02.01.08.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 08:17:57 -0800 (PST)
Message-ID: <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com>
Date: Sat, 1 Feb 2025 10:17:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
 <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
> On Sat, Feb 1, 2025 at 5:09 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
>>>
>>> This looks good to me except for one thing: the function prefix. I would
>>> really appreciate it if we could stay within the existing gpiod_ namespace and
>>> not add a new one in the form of gpiods_.
>>>
>>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
>>>
>>> Bartosz
>>
>> I was waiting for someone to complain about the naming. ;-)
>>
>> I was going for as short as possible, but OK, the most obvious prefix to me
>> would be `gpio_descs_...` (to match the first parameter). Any objections to
>> that?
>>
> 
> Yes, objection! As far as any exported interfaces go: in my book
> "gpio_" is the prefix for legacy symbols we want to go away and
> "gpiod_" is the prefix for current, descriptor-based API. Anything
> else is a no-go. I prefer a longer name that starts with gpiod_ over
> anything that's shorter but doesn't.
> 
> Bartosz

Oops, that was a typo. I meant to write gpiod_descs_.

