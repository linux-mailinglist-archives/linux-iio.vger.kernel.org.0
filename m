Return-Path: <linux-iio+bounces-16159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF72A48AD7
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 22:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2120E188AACA
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0827180F;
	Thu, 27 Feb 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NchOCmf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F2227B8E
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693262; cv=none; b=siiTdred+m3EcUvOZPGfBMAYUiz4KN09dlVXgSzGqeqRfIMJHp0YClkJ2xgZg9E2gZF6wJAFYJy2FjUDpCFadAWvuYZCX/TT6IBBjP3Hb5ZRtDxYmnKaTb7q9Sn5DJDevwhO6vFu7K44L0pLWJM1ww5cilYT7b+cWYG/SLTgnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693262; c=relaxed/simple;
	bh=vQHbDRJK2BUW3sVk844uq3TqW7P1kixXvD0chqN70M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfB/feR4C4UvrY6lR9Mvzw0Do48n3JU4z+UN4nUiEoCrAhzvjuVEAIv3ZRQduEdzxiYGKhircKhHgJkab3EZghajeH/Wxk0Ma8WmKakR0S/hKn7EljtHPrCbF5/J+Y90mP9Uzk14+PNOU+s5dxoGfdDrM1a7DVToJAN3sspnQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NchOCmf6; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72720572addso954642a34.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740693257; x=1741298057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/hXAHCtNLeAWG63+hcCl8SC7KoqJ0y7pVArSY1JtLE=;
        b=NchOCmf6bMHnnHxl040Lq65ldRvmeF/mYcjC5nT+hsvtK6qv42bYpS99G0bAjOJTap
         w8w94ygtA3AC/r34AY8yKXmM7BFHDRKAEe0B8oklM3AYnzu8RaPVtJye1MH2hdq4PSBI
         DyNWr2e+BMyWKCqzAYiFvkt26qAzVlfpOKZ1bls/sZS/nSdOrqx/uiK4+mkVvHE9HN2b
         swBdS4tM8H43/opyqAp7naksuCu6SbLoDl80Y/iL/yy8H/vCaJ1hn7BO1IZx4otdUmJl
         kNWqicHO9OlFW+YNOItI8kF8Ovi0BVYkSFbs6EuQZbzPSOhZQQ6H0bl4EVrP34c9sps3
         9HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693257; x=1741298057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/hXAHCtNLeAWG63+hcCl8SC7KoqJ0y7pVArSY1JtLE=;
        b=BwcTDJeH4/D14EOtkGNEqpnSc0L3a38xB7XPR8DRP8OXYm+FXKvMopXd0FwDUavbSu
         D65B8aaNlVGpFx/s7YkG0mzAtSm38ZnxydHkUfeS10qIj2mLMfhLlTEs2QmjBtPar+1u
         SlObpLQPURYBI76MawI+9ivYliucNakvS+usP9WEBTWPhxnn2OS1sErAlqrJdlLcsZEO
         I0Z9EgeMmLg4Y4VUfbJL33biRkN7IoQMSubx06kp9cPHkXLupbo5k5xp7CgKXRBZol4+
         PGXCtCt7WEG/DWHWNwBRzDUlwY0oKMoYZvcrcEp1ooQy6DUVqEoblmiou7GeEQkxmcmV
         6vbA==
X-Forwarded-Encrypted: i=1; AJvYcCX62IKP6mfvceNj/IXIuuLRqx9QEm6AuG4gsePvRezSY0P9HxILa2m1LSzOUx8cQarw61V6MuZpUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNySTFV7h8AdvEuTkIsnifGPCX+ZGrAIbSQexV68PorgPaA6B
	iZwOq0rVbHEvOZTXFva0nkBFFAZB9Wgk0TIzFnNqA+8v5xg9iAcI/gLW2pRt7nWxjyHc84UOE8k
	n
X-Gm-Gg: ASbGnctJK8+e170eUo8dTQ5Cye8MqRWxW3xWhMymxK7UGQbNQQq5ilYxr1NxRmViEG8
	A+TnjQKeHTWbMKr+4wEkrWngf6db1FC0IuqqaRaNpY4lELywAWEaJPHxfm6K5e/exIzb1sNXDLf
	ghc8/XJTvmxaCKt2Dydc8WdapinZAF0nlkkd0AiG2B8VIOq/iYLFwDE68z+xrAiKNifw8zBejzZ
	uvdqo+nVKOG1Xsaq/QidpTpjlqAGW2/mFni1GTs0Q9AnwyWAKo83RbV4espBNs96prCEZ2PmvGD
	WQw1w9MxinYid7fizuxShT6JfGwfNwvrFnYe4bt11stMb0aH8i29Ff02edKmOYY=
X-Google-Smtp-Source: AGHT+IGX6e+UTV3fnyRf7e6ZqTStb+426CrDeWO0t2ai6r0zce8y0wyvZGrnkjPKj62Xq0Vh0eHNCQ==
X-Received: by 2002:a05:6830:6505:b0:726:ee0c:57e7 with SMTP id 46e09a7af769-728b8306535mr539540a34.24.1740693257155;
        Thu, 27 Feb 2025 13:54:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728afd76cc4sm404845a34.42.2025.02.27.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:54:15 -0800 (PST)
Message-ID: <47ae0fa6-8005-4c8c-9409-3189ba6f42af@baylibre.com>
Date: Thu, 27 Feb 2025 15:54:13 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
To: 7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
 <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
 <Z8DazwTguF/gfKW1@JSANTO12-L01.ad.analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Z8DazwTguF/gfKW1@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/25 3:36 PM, Jonathan Santos wrote:
> On 02/20, David Lechner wrote:
>> On 2/19/25 2:34 PM, Linus Walleij wrote:
>>> Hi Jonathan/Sergiu,
>>>
>>> thanks for your patch!
>>>
>>> On Wed, Feb 12, 2025 at 7:20 PM Jonathan Santos
>>> <Jonathan.Santos@analog.com> wrote:
>>>
>>>> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>>>
>>>> The AD7768-1 has the ability to control other local hardware (such as gain
>>>> stages),to power down other blocks in the signal chain, or read local
>>>> status signals over the SPI interface.
>>>>
>>>> This change exports the AD7768-1's four gpios and makes them accessible
>>>> at an upper layer.
>>>>
>>>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>>> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>
>>> Is it not possible to use the gpio regmap library in this driver
>>> like we do in drivers/iio/addac/stx104.c?
>>>
>>> It cuts down the code size of simple GPIO chips on random
>>> chips quite a lot.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> I think the answer is "no" since we need to hold a conditional lock
>> while accessing registers. Namely: iio_device_claim_direct_mode()/
>> iio_device_release_direct_mode().
>>
>> Unless we add some extra stuff to the gpio regmap implementation to
>> add optional callbacks to call these. Which could be worth it given
>> that quite a few ADCs provide GPIOs like this.
> 
> Since this patch set is quite large already, is it worth to do this
> here? if you say it is necessary, i can try this.
> 
>>

I'm a big fan of not trying to implement every single possible
feature in one big patch series, but rather splitting it up.

