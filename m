Return-Path: <linux-iio+bounces-17410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DCA763AD
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3424B188A14A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A91DF75B;
	Mon, 31 Mar 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIR839RD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BB1DE3AA;
	Mon, 31 Mar 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415082; cv=none; b=he5ZxibNDIGRZ6ItZGVC0RKrif/YZEuIykkccPPpWBhp5yqYOCfi+XqtQkIOIU7Gn0NuS2fWA2gTpSNhB5HPA0sOYBHRoJ672Tt7yqM6RgGuALWPuZ2KpEPLD8/OM0A8PI+jXXccpY7LUhJYT5ML+3klDGWxMyJLOmYhqpyiS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415082; c=relaxed/simple;
	bh=yK7nu7eWJM3nujHNfRadysWMa7kXdY+e6WXSaZJuUlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz0eehTs6n3767PJp3QqrlNcpKC3v43ZQGDATTdyAEl0OzvJvrZdP+S6GOhnn2TTTo+c2VDuECieKYaBe2dKTYtMqIvKVUwrz5ItyF0dgMHJLpCkWN9BWYR+jdteRnvyVquJsE/nnV1kAt9UK3Pez6TILGVjPXH3s9preCxo66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIR839RD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54af20849bbso2678160e87.0;
        Mon, 31 Mar 2025 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743415078; x=1744019878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGBJfvaNnxtRD6hIkqEgxjYX8qkJ7qsN5lK/+BN2aO0=;
        b=CIR839RDBhQyMuLnCcPV1LrqYJJQ5zoRT0N4FO5efd2kxXv6rhvIpgOTMNYN2NVXt2
         VUZvRgGRnaLcstwWAVJeywAhPUEwvB78xuNbevAHU0fkpWcG6ZnMuUkj+jjVlF3DiUY6
         eguVLIUTGObxOf3ss4GtBNY+HzJoqk2vnPpUDNDAdXlWeIE0K9Ln20zRnkNNltyk2+SW
         t8Rz5rIfF6x4+OTwesPWDt4DIu7SiKBOrFWxOy3Bj3w6dKJJFQzFmFyK9+HaxDKCj+AX
         CdMET2AFNCSDujk/dFP5krDHB3zH49IsBDZ3xbNyozmjqLJJFUnAUsB5GukWYGxVL56Y
         qUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743415078; x=1744019878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGBJfvaNnxtRD6hIkqEgxjYX8qkJ7qsN5lK/+BN2aO0=;
        b=eLaSx8hCEBFT7Wd+lUuSRSN5P1UhHDQ/4UukN0GyF4EaCuXn7vot0yCOOR9afX/r5+
         lOZvEKauVdxj8rOh65gEkIIWBISatUBzDyUOAhzcAPlgwmklM98fsa/Rg0o3ubB2q2lH
         IwerK4BW5tAYJUcbB6chmucbJEJH31qcAQVvbOkoGXRjpb/fKSeOLTcmBlmr+cznAyae
         y9Eg3McNYIWg7VNx46PXVJ7Hur+bOnN3da58AQQil63SUYVF4GgYVStpcdJgxunYoL4M
         qnC0+uMIrkVgByh0EFb4V0w2SULvADFWXY7cqkTlTpZOTdA13elsFV4kZwPq5/vpAKh7
         eRyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9c9gV9FGOnz0ub3XKCZ+LEt7uaWr7eXe0qPTA3rAiHBQnifxqKB1gY3/+8WTLKqz2U+CsTxuanfBl@vger.kernel.org, AJvYcCUYLCamRjRg2H42fr5yiRcUBg9Fj463Cnx/9jxTq+uFr+LKZ0na6RtLyreW6yCbeoyQB/v4aXEvsxBkQg==@vger.kernel.org, AJvYcCVD99Xd/CcFGI6xlY/cfVt4zqg2IH/I6atGwbcpPLZOlD1/kqd4kWxvQ4KR4u9mePgn2odPlRXTY3yDwfZZ@vger.kernel.org, AJvYcCVvbPoAcnKebA5tAc01jeokX7/1gQNddjk8fOw0dV74V4PZd57n0srU9GiqUdmONlGWqpCCAEv1pWkhkIKf3vhvzFw=@vger.kernel.org, AJvYcCXAGvkeUCzPnH87k6yUykOiDgrrh7FascVuLy0G8ANrHL7xL+zdgmmFUhq13b42f0V2pWQYo6IptoVt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4FWhGY4EUCXNk8K8M1ssMaETcqFfUC/+vnywJ2DcXeOZbsDe
	I1ZwNyqwlIDYq29QgUtHjtsXK94My10PooxQvgIuwDVooOinXSms
X-Gm-Gg: ASbGncvsT8vfeQJl6M+mIb3INKON0FIpnCr7YeTwOLre0+2hIGs31ae141dFGiRG8pU
	d+cxLiR28D8DThEXSp7S8FuqqNP3y9lk6YBnypApQdAbfGhwmU3ggnPcW4rNkcl2JtFfjVhHRBV
	D90+ySB9ZccHctJTuwz2aI0ldaBUKxWbjp8c2f0IKBRKRUg51E/5CDsUWfE1uJEJRl/wZWceyRe
	b5ddxKnpYBg8/96d4USy19oNIrpuH0ZMkOUJ/lcLCfHwDN2NyicmxgKF9efPO+KG0rlZhl6RKbg
	xieaE6u+7br01KegHToQDxG67dIirZyqDbI7vv1ygEltKVqhAtqKBk+EWbbveEeuw/zQMGOnc23
	I7CHgCuYAcdt5dxNHMagRhdh3eQ==
X-Google-Smtp-Source: AGHT+IGqeY06WugE+f6xFNsS8xeFCBQw/6TOQOGCtpw4PCZBd5XxHX4TAt+/prfgf/QFIXCNENTg8Q==
X-Received: by 2002:a05:6512:a95:b0:549:8cbb:5441 with SMTP id 2adb3069b0e04-54b10dc7c04mr2303336e87.15.1743415078069;
        Mon, 31 Mar 2025 02:57:58 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b103721f6sm786241e87.108.2025.03.31.02.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 02:57:57 -0700 (PDT)
Message-ID: <2f977814-bd9b-4b54-aa77-a36edb56e194@gmail.com>
Date: Mon, 31 Mar 2025 12:57:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com>
 <Z-mnNtYLkwsTYjMh@debian-BULLSEYE-live-builder-AMD64>
 <4d66b3b5-bfcb-42f0-9096-7c448c863dfc@gmail.com>
 <20250331104849.3eb748a8@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250331104849.3eb748a8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 12:48, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 08:39:35 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Marcelo,
>>
>> Thanks for the review!
>>
>> On 30/03/2025 23:19, Marcelo Schmitt wrote:
>>> Hi Matti,
>>>
>>> The new helpers for ADC drivers look good to me.
>>> I am now very late to complain about anything but am leaving some minor comments
>>> below that can be completely ignored.
>>>
>>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>>>
>>> Thanks,
>>> Marcelo
>>>
>>> On 03/24, Matti Vaittinen wrote:
>>>> There are ADC ICs which may have some of the AIN pins usable for other
>>>> functions. These ICs may have some of the AIN pins wired so that they
>>>> should not be used for ADC.
>>>>
>>>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>>>> add corresponding channels@N nodes in the device tree as described in
>>>> the ADC binding yaml.
>>> Not sure it's preferred to have ADC channels always declared in dt. That
>>> question was somewhat also raised during ADC doc review [1].
>>
>> I had missed that doc and the review. Interesting read, thanks for
>> pointing it :)
>>
>> We did also do a bit discussion about this during the review of the
>> earlier versions. I am not sure if we found an ultimate common consensus
>> though :)
>>
>> A recap as seen through my eyes:
>>
>> - It is preferred to have either _all_ or _none_ of the channels
>> described in the device tree.
>> https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/
>>
>> - This, however, is not _always_ required to be followed, and it may be
>> impractical in some cases:
>> https://lore.kernel.org/linux-iio/6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com/#t
>>
>> - We do have bunch of existing drivers which we need to support. With
>> some very different approaches to bindings.
>> https://lore.kernel.org/linux-iio/20250302032054.1fb8a011@jic23-huawei/
>>
>>
>> My _personal_ thinking is that:
>>
>> This means that we can't hide the binding parsing in the IIO-core. We
>> can't go and change the channels in existing drivers.
>>
>> But, we can provide helpers (like this one) for drivers to use. I also
>> believe we should still try to have common (and preferred!) approach for
>> the _new_ drivers. Eventually, the new ones will be majority. Some of
>> the old ones die, and if we keep same practices for new ones, the old
>> ones will become rare exceptions while majority follows same principles ;)
>>
>>> In short, ADC
>>> channel may and may not be declared under ADC dt node. ADC bindings often don't
>>> enforce channels to be declared. On IIO side of things, many ADC drivers just
>>> populate channels even if they are not declared in dt.
>>> The ADCs you are supporting in the other patches of this series seem to require
>>> dt declared channels though.
>>>
>>> [1]: https://lore.kernel.org/linux-iio/20250118155153.2574dbe5@jic23-huawei/
>>>
>>> Would something like
>>>
>>> A common way of marking pins that can be used as ADC inputs is to add
>>> corresponding channel@N nodes in the device tree as described in the ADC
>>> binding yaml.
>>>
>>> be a good rephrasing of the above paragraph?
>>
>> Yes, if we don't want to guide new drivers to either have all usable
>> channels, or no channels in the device tree.
>>
>> I think Jonathan said he'll be rebasing this to rc1. I am a newcomer and
>> I should not enforce my view over more experienced ones ;) So, feel free
>> to reword the description as Marcelo suggests if you don't think we
>> should prefer one direction or the other.
> 
> I've gone with Marcelo's suggestion because I don't want to be too specific
> here given the complex history.   We can absolutely encourage the all or
> nothing description going forwards though as it is logical in the vast
> majority of cases.

Thanks for taking care of it :)

Yours,
	-- Matti


