Return-Path: <linux-iio+bounces-16927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259DFA6422D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2180B1890BAF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338F1DE3B5;
	Mon, 17 Mar 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upqmpc0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07A154C0D;
	Mon, 17 Mar 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194339; cv=none; b=EFT77hC5dGNRmUFNg6/RJ9aFPoCNKtAP8gOz/guUO7/F4wizSrrsh1JISKMjLiYgzgDNCl3s1dSkqp5nq2FdmxFu7lsfyk3OsuPW7vtocEjHhC2bgPtZJ4Zs8JZjQ08mK2J4HgJ0VIJbLy/rcWpZG9kcR96o4W1YcYt+nQ6xM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194339; c=relaxed/simple;
	bh=dgde7QjU5NzrulQjv+nC8gia1h90VQGW4bvT3fO3XY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN2xyVXmU1Dl1jlrZbBgzSyXsxOxoUYqqkv6t5DmO1IGariF0inUKQc93aFUeHVDU7V9CoOsYOCIHon1VMZw7t3uc7oODkrBkR8ZBH335S6gAPKeYoNzS4wbbZlKXNnpoOgykICWY+GCZ28BT9vE4bakTw3RgKBR/mYO95xLX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upqmpc0q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499bd3084aso4173432e87.0;
        Sun, 16 Mar 2025 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742194334; x=1742799134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gasgoAze4PfSvdUivzZ1QQeZ3gra51s87x24FFJFeOg=;
        b=Upqmpc0qBn1N4UO8iUSbFzWp+hK1wEvK24PX7X08jGA7BwYTRqonqzpUlb1EL6w7bC
         QzLjFuvOOXt7os5qUGefqJhJaaIMB/h+2BF9onHieiwmPHrc+BVNbSNY9iBara3DB7f/
         +Vw1hsTWWjZ/rcTuGTCqZwIwmYoOPX96/baUfzdVQlKvU7fhdCRLM6+EP5pPdZXTq97B
         MqMZmPY4MLaHGRTnyVojKSxJd6RMSHFHwij0MMokfGQVxtY++Gb5lom4P03CimPOkL1v
         kK4F27CNJyEA1TeSuEXm+yPukn+6q8mZzHtDNbxg+2lW/gqv/pFK0mcBM3rPETLEO2IU
         XcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742194334; x=1742799134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gasgoAze4PfSvdUivzZ1QQeZ3gra51s87x24FFJFeOg=;
        b=kH5p192DZ/cOh2eMjdU42uVujfQHV0OJ/otI1xS0Aec+JF4ey2qM6VQJ/T5elkoqMM
         BppKl9vPic+dB2utW2Dfgqk3nllv/3rj13wdjKQAK0SwUpOUP5+oxtmTe6JksMf8MFL4
         K8D0eG9x0lP9WQrc7qArGHQsHRkUljhkVqtqwB2FVBSsnmiRYkQILjwApGWzHGKldV14
         dloNgqR8PmkMA/a5bxtwVp1XSPFYU4ycDh0vFtuGcD099P8suPG//RCxi7aPD/SnJPui
         LxvV4QRWDjWRETJ+KfUgrZF0Hl2XCsqmqc7LHiHYIFD1SqBaAKtAEx73pmZk357kUj7m
         LD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDDQGvWVuvMKxOzp6K6oE/k80rePN9scDqaMN6xbtARBxcJPwsK5CX09un+FqNH1J71so8yVbcO71sMFGe@vger.kernel.org, AJvYcCXUerr20d2EwHzqiIwNDIm7RXfQC+NgcJoSGbatTNAStDceQHxgWgNeczYcSGGXu+n1NW5vUYQGa/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiumIlQTgSzShRhYS/xLClhWjZWOAQ6/43DaR9ooqxO2o9ED6
	nuY09AdqiBSvjAC8BCPtXqXdLg1VyNU9GcH2Huwk9u8GGxfx27QW
X-Gm-Gg: ASbGncvCaseleUHtMj0o3UVvaThzhrb01KYqH7jbyOwiPLv7Pwt9/pBQfszv5DMqjAN
	AtNh2D3g9Twv1ZxW1gPrY060c+7Wn6/xZcn9B0dSARO7rveeoORM7ctBo5UfgDCKIKEOUMNDMzr
	LIMIvf8ZuF2L41v/f9zmv3er1p/DDBHRR7dViB9NhmAyFkxlkYebFXKCQ5ixhrKDlzJv/Ubn/2U
	hJMag10/H2PuLZoY9lMK1JECWfKfLGJFGooh1D2XbQXRVy6L/wu6d4uSVaAKzippFxsdoqWu5Lg
	o39VW+nFJJi+xGUtwkj+GEi0mOrfONU8EucGCz3EJAImUSrVdI5UCq6AqOPwg44nIsZWra5GtEJ
	nHWp89emJVR6Ww8Mz+XPHgARhqnuNW0IYImjK
X-Google-Smtp-Source: AGHT+IFuv4k/CfvsKuOboK+i7Xb2DjT7/C+AfWgfzY2Qp/J/T2fDJ9WndujqgV2XCWAG9XELpn0T+w==
X-Received: by 2002:a05:6512:b05:b0:549:9143:2609 with SMTP id 2adb3069b0e04-549c38cf99bmr6832474e87.3.1742194333245;
        Sun, 16 Mar 2025 23:52:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8804b4sm1198072e87.171.2025.03.16.23.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 23:52:11 -0700 (PDT)
Message-ID: <c7ef9333-c044-4640-b126-7771a1135d87@gmail.com>
Date: Mon, 17 Mar 2025 08:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
 <Z9Q-KcadLHdDLxVc@smile.fi.intel.com> <20250316095233.20d1a134@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250316095233.20d1a134@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2025 11:52, Jonathan Cameron wrote:
> On Fri, 14 Mar 2025 16:33:13 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Fri, Mar 14, 2025 at 09:31:58AM +0200, Matti Vaittinen wrote:
>>> On 13/03/2025 15:19, Andy Shevchenko wrote:
>>>> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:
>>
>> ...
> Picking out a few things to comment on...
>>
>>>>> +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
>>>>> +#define BD79124_LOW_LIMIT_MIN 0
>>>>> +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
>>>>
>>>> These masks are not named after registers (or I don't see it clearly),
>>>
>>> Naming is hard. I usually try to make a balance between:
>>>
>>> 1) using names which explain the purpose when seen in the code (at call
>>> site)
>>> 2) keeping names short enough
>>> 3) following the naming convention in the data sheet
>>> 4) maintain relation to the register.
>>>
>>> I put most emphasis to the 1, while 2 is important to me as well. 3 is
>>> _very_ nice to have, but it is often somehow contradicting with 1 and 2. 4
>>> is IMO just nice to have. The register is usually clearly visible at call
>>> site, and if someone adds new functionality (or checks the correctness of
>>> the masks/registers), then 3 is way more important.
>>>
>>> I am open to any concrete suggestions though.
>>
>>  From my point of view the starting point is 3, then one may apply 2 and 4,
>> the 1 may mangle the name so much that register data field name becomes quite
>> abstract.
>>
>>>> it's
>>>> hard to understand which one relates to which register. Also, why not using
>>>> bitfield.h?
>>>
>>> I saw no need for it?
>>
>> Hmm... Okay, I think Jonathan will ask that if really needed.
>>
> 
> I won't as I'm not a huge fan of bitfield.h. In many cases they bloat the code
> and increase the writes that go over the bus.  Don't get me wrong, there
> are good usecases, but it's not a universal thing (unlike PREP_FIELD()
> etc which I love :)
> 
> I do favour burning a few characters to make field / register relationship
> clear though.  A few things can help I think.
> 
> Structuring defines and naming:
> I like using whitespace in subtle ways for this.
> 
> #define PREFIX_REGNAME_REG				0x00
> #define  PREFIX_REGNAME_FIELDNAME_MSK			GENMASK(X, Y)
> #define  PREFIX_REGNAME_FIELDNAME_FILEVALNAME  		0x3
> etc

This is close to my usual way, but not quite. I most often do:

PREFIX_REG_REGNAME
PREFIX_MASK_FIELDNAME
PREFIX_FIELDNAME_FIELDVALUE.

Problem with
PREFIX_REGNAME_FIELDNAME_MSK
compared to
PREFIX_MASK_FIELDNAME

tends to be the length of the define. Also, sometimes registers contain 
field(s) which have nothing to do with the register name. Sometimes it 
results confusing definitions. (Confusing meaning that seeing the actual 
read/write makes one to wonder what the register field is supposed to do).

> Makes it easy to see if we have a mismatch going on
> 
> However, I don't insist on this in all cases as it is one of those
> "don't let perfect be the enemy of good" cases I think.
> 
> So Matti, good to have one last look at the defines and see if they
> can be wrangled into a slightly better form.

I can at least change the MASK to MSK and save one letter :) What comes 
to the ordering, I see you prefer having MSK / REG suffix at the end - 
while I like having it right after the prefix (just because it makes the 
MSK / REG to stay aligned - which in my eyes looks a little bit better). 
So, I'm not sure if I change it to your preference (which may end up 
being more common in IIO if it's what you prefer), or if I keep it the 
way I am used to.

>> ...
>>
>>>>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>>>>> +				    unsigned long *bits)
>>>>
>>>> Ditto, .set_multiple_rv().
>>>
>>> As you know, this started at v6.14 cycle which is still ongoing. I don't
>>> think .set_rv() and .set_multiple_rv() are available?
>>
>> You mean that you are still hope to have this series to be squeezed for
>> v6.15-rc1? That's not me who decides, but if not, those APIs will be part of
>> the v6.15-rc1 (at least they are pending in GPIO subsystem).
>>
> I'd vote for a rebase on rc1 that should be really easy to for me to pick
> up.

I sure can rebase if the series is not merged before the rc1 is out. I, 
however, rather not delay versions (unless explicitly asked to).

Sometimes postponing things to wait dependencies to get merged backfires 
due to some 'last minute' delays. Hence, I don't usually adapt to new 
APIs until they are in the rc1 or target subsystem's 'for-next' (or 
other suitable) -branch.

> I'd accept a follow up series though.   Ultimately won't affect
> when this series lands as very unlikely Linus will delay the release
> long enough for me to do another pull request this cycle,

No problem. You'll pick this when you think it's ready - and I'll rebase 
if new rc1 is out before that (and convert to set_rv() and 
set_multiple_rv() if they are included in the rc1).

If you merge before the set_rv() and set_multiple_rv() are in your tree, 
then a follow-up will be done when they emerge. :)

Yours,
	-- Matti

