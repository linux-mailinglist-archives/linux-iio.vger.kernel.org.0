Return-Path: <linux-iio+bounces-17719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D078FA7D3D6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F46188A570
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8C224AE1;
	Mon,  7 Apr 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql55X4yx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B4DDD3;
	Mon,  7 Apr 2025 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006212; cv=none; b=mLq48o+IExLT/n9J5NcW1uewiqz7gVl5q8XIdyrP/F+c81ieY8SSFFwVKIDgvC/8d9z2sr4XCUVJjcUH2xVW0Ecy9eZtcIA1BWbRLman2o/LhxlUtHEyf4OQZtmuU1g1aNEVDTb2hOPPlfZkjx8JCFpG3g7jj/QftauSs33YEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006212; c=relaxed/simple;
	bh=WHptMty8/X/ube0FQL8nrBNpTd+8qRvV8oDKOCjRJ/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssJibcDNM3aZDhWuOBYZBrauhkfJqLsRd8wL/mSAMaKAluMu65sEHMjF8l03JzDM9ZPMJ8QnIWLv7MssHO4AV1Jlk/B0l7X7J8igEJ9Re4sAIxeosaVDiIGMBtp/gUYHuM5gVGxsxepujaUXfrtHjdVmoBzxN3alrhnIfHqNMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql55X4yx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54954fa61c9so1492947e87.1;
        Sun, 06 Apr 2025 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744006208; x=1744611008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tQt3XJvixzCS8l8Xq4o4BtUJ6YS65Te0LIUOY4NnHk=;
        b=Ql55X4yxHd/gwcN9Ai2a5moMPA0InDNCJI2WPgH7REoyAnUbusstFrD5xyzKquh7Kh
         k4vFlfG8rB5fUcjkfQcyTDFY/a1x5RGi0If8BL6vUtzRCBBFI3wBkbf5OHzuMCyM6cAu
         okrjVfqokEcLKDpROiVtLShrzL+GnEMhvPMDHW8KLd4KnNC1qZ5p2Gc6RWMc5mFI41xv
         JYmHBNXr8Cq+0zu1RGmfJrA2ERDJjGVu5cTm8WCzADfvdITgfBjqk89FfUx+U1IXQbbX
         f2KIctMU/y2Y/HbBKXpZH1dBLkKXjntD+deYmhePUEQd5UCquoT9A/IBKKlyFT91J1k2
         V9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006208; x=1744611008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tQt3XJvixzCS8l8Xq4o4BtUJ6YS65Te0LIUOY4NnHk=;
        b=PsXvrhXlbBeZIq7A8o0XeRqZtKMKxbyVTRYW67veBORtCtgZQFX9x00+Ta+cbaz58M
         jvlMAI1IzZL9sNzDq+gfOBEUplAaT+OkOXbreMKRix15jkamYtwh7Etqr4q3nyYMsBmF
         790qSE4Vfi+HuRYDORn9In/3MmfCg1o0NOrxt4quciwY63uQpPoQvdANqb3SLRr1aMci
         f08hh6nz6p4jCczJjS1AVkJNyPYDA/kqVnprRZtBRkp/IwG4OyU63OjJ1ET9r0nPAbtN
         5cXz76wSkEEDNgDHZkw+JxKVO2JoJg3H8+L4eq6ZumLqhndlRmNrzXdjX0c7KRpOdWFj
         YvJg==
X-Forwarded-Encrypted: i=1; AJvYcCUwsaFkX9f+pa9vQeus47O/aFzmJxcxMaSZ1jsKXEJnV45OG3dUv+V47M/N6irBD37FWc4R6ij8aAob@vger.kernel.org, AJvYcCWK6c9eg+5F6IPzmTHs28PHfnFhoF3ueZvaWqV7asBmyRLkoGQzUrEfzCaNH+vgdhkHRy0m5lyyOT9R@vger.kernel.org, AJvYcCXPNAYsKPoCDqAoMAR8Tp9Y0gKfAO9G/VhxRe3imm+4HYBSAk9C8VD9xYyMPXWtHV39PhYBnRFUDv6ig5u3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAOcMLdKUNzLZ+BCG6l3zn4lZwP3X8n6IkEieRW1MVGH4xWFg
	Hv9oryGhezXv/2nJwX9EuazlM76n6YJmrjhfjcL5YD+iZfhZu4GN
X-Gm-Gg: ASbGncs2CTp29OrdwJXpEGziLvfbKXWDHSypMzQFVrl/VorFJ+q46CUmsMGAAMyyk1s
	wow6unLFe4YpmpweNuLSClnEG2d1cqj8CwSOV0AGeaWWru1p9v0y/AyHj3O9TOZRpRB30pNZT+I
	gaSw9yw84KGZggiJytrTTROeydIcKDZVF2EoiSaBQvk7o4oeoaoX8i61KsJJfNHOxW97gXzs7oN
	LzoRrzlbG9aNs7nBoXN/+80qGuuFHdpz3qWoWjXrYIdrkbQv263vGdnSbkcYbRS5h5C9zG6xrpW
	uOKWydHBwziAA+jzVpktOyQOGhk0fUKrIUf5ZZ9z0yaNmHFtb3f2xR/Olvq7l0uo3U4JHYHd5CV
	Ikfxu9eJh4HWkFXpdKAvIzF9yFQ==
X-Google-Smtp-Source: AGHT+IGQciRZD1LR83G4S8zlR0hZxoK4W9ubK7Hlcuv4dP4RJxWWqZW4WXzMhLTpCHd17H+HQihVkw==
X-Received: by 2002:a05:6512:e9a:b0:54a:cc75:3d81 with SMTP id 2adb3069b0e04-54c22769a54mr2960657e87.4.1744006207979;
        Sun, 06 Apr 2025 23:10:07 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c2158sm1138523e87.93.2025.04.06.23.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 23:10:06 -0700 (PDT)
Message-ID: <99d1d972-d9a5-4ca3-811a-b22083bea4e6@gmail.com>
Date: Mon, 7 Apr 2025 09:10:05 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ti-adc128s052: Support ROHM BD79104
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1742474322.git.mazziesaccount@gmail.com>
 <8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
 <20250331122247.05c6b09d@jic23-huawei>
 <a35ab4b1-4d6a-4b95-963a-96b2ab4c05e9@gmail.com>
 <20250405184346.3c4b1234@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250405184346.3c4b1234@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/04/2025 20:43, Jonathan Cameron wrote:
> On Tue, 1 Apr 2025 15:33:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 31/03/2025 14:22, Jonathan Cameron wrote:
>>> On Mon, 31 Mar 2025 11:03:58 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The ROHM BD79104 ADC has identical SPI communication logic as the
>>>> ti-adc128s052. Eg, SPI transfer should be 16 clk cycles, conversion is
>>>> started when the CS is pulled low, and channel selection is done by
>>>> writing the channel ID after two zero bits. Data is contained in
>>>> big-endian format in the last 12 bits.
>>>
>>> Nicely found match.  Sometimes these are tricky to spot.
>>>    
>>>>
>>>> The BD79104 has two input voltage pins. Data sheet uses terms "vdd" and
>>>> "iovdd". The "vdd" is used also as an analog reference voltage. Hence
>>>> the driver expects finding these from the device-tree, instead of having
>>>> the "vref" only as TI's driver.
>>>>
>>>> NOTE: The TI's data sheet[1] does show that the TI's IC does actually
>>>> have two voltage inputs as well. Pins are called Va (analog reference)
>>>> and Vd (digital supply pin) - but I keep the existing driver behaviour
>>>> for the TI's IC "as is", because I have no HW to test changes, and
>>>> because I have no real need to touch it.
>>>>
>>>> NOTE II: The BD79104 requires SPI MODE 3.
>>>>
>>>> NOTE III: I used evaluation board "BD79104FV-EVK-001" made by ROHM. With
>>>> this board I had to drop the SPI speed below the 20M which is mentioned
>>>> in the data-sheet [2]. This, however, may be a limitation of the EVK
>>>> board, not the component itself.
>>>>
>>>> [1]: https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>>>>
>>>> [2]:
>>>> https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/dac/bd79104fv-la-e.pdf
>>>>   
>>> Prefer Datasheet tags with # [1]
>>> after them for the cross references.
>>>
>>> Those belong here in the tag block (no blank lines)
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> One request for an additional cleanup precursor patch given you are
>>> touching the relevant code anyway.   It's a small one that you can
>>> test so hope you don't mind doing that whilst here.
>>>
>>> I'm relying on the incredibly small chance anyone has a variable
>>> regulator wired up to the reference that they are modifying at runtime.
>>> I have seen that done (once long ago on a crazy dev board for a really
>>> noisy humidity sensor) when the reference was VDD but not on a separate
>>> reference pin.  That means we almost certainly won't break the existing
>>> parts and can't have a regression on your new one so we should be fine
>>> to make the change.
>>
>> The change you ask for is indeed small. I have no real objections
>> against implementing it (and I actually wrote it already) - but I am
>> still somewhat hesitant. As you say, (it seems like) the idea of the
>> original code is to allow changing the vref at runtime. It looks to me
>> this might've been intentional choice. I am not terribly happy about
>> dropping the working functionality, when the gained simplification isn't
>> particularly massive.
> 
> Hmm. I suspect this was added at my request (or copied from where I requested
> it)  Back when we did this there was no advantage in doing it at probe
> as it was just a question of store a value or store a pointer we had
> to get anyway.  So I tended to advocate what I now think was a bit silly,
> that someone elses board might have it changing...
> 
> User space wise, what code checks for random scaling changes?  So it
> was best effort at best anyway!

Ah, right. I suppose this should've been accompanied with scale setting 
which could've changed the regulator voltage - and I have no idea if 
such hardware would make any sense.

The slim chance I can imagine is that the reference voltage can't be 
set/known at probe time.

>> Because of this, I am thinking of adding the patch dropping the
>> functionality as an RFC. Leaving that floating on the list for a while
>> would at least have my ass partially covered ;)
>>
>> I'd rather not delayed the support for the BD79104 though. So - would it
>> be okay if I didn't implement the clean-up as a precursory patch, but
>> did it as a last patch of the series? That will make it a tad more
>> complex to review, but it'd allow taking the BD79104 changes in while
>> leaving the RFC to float on a list. (Also, I'm not sure if you can push
>> an RFC in next without taking it in for the cycle?)
> 
> I'll probably just merge it even as an RFC :)  That way it's my
> fault if we break someone and they shout!

That's fine for me. Well, doing it this way around (as a last patch) 
should ease reverting, should it be needed.

Yours
	-- Matti

