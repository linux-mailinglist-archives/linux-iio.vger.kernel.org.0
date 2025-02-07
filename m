Return-Path: <linux-iio+bounces-15125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04AA2C6FC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D173B0088
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C223F27B;
	Fri,  7 Feb 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XYaujCYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46241E1A33
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941842; cv=none; b=cICFeI2JDRcIsqG4+xjLzf8oc7EZHmp4Osq83Lk1Z2m2sRndUfYQwmrPixqZ8g8+LuICxax2N95vdxCQk8Zf6fb0NDE8/J+Ir9b+qHDqdPohkcMC+7Mk71Sn7tIfLvi0JjCue+5Rqjz2TOg9xPcmUjavkoxJnLaVgLBanPjjhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941842; c=relaxed/simple;
	bh=0QDQqHrgVLXCxx+qW9kTksbcFhM3nUPG5B9br80WLWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCt1qAB1mDQeaNIh/OPp4/i52qttRQswn2oeOOKaXrOvLbN6r3CKR/k15VLVFmbo54NaCuPdg1WsqREMQKtVWrLeGILyMcpJnBNtNTFeWDMbWAgILIlNVfn/hX8vTAcEANvg+sSo5FXSXoRprP2sK7HFUG+oZy8wS2oDD9Q8lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XYaujCYb; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2e370bb3aso654963eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738941840; x=1739546640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxr/gLgLMBNgytGiMYTlRHUYI9qRODMAWATD12wZy7U=;
        b=XYaujCYbI88MZnV/G1lJee/MJ+aCiASTiFsxGFr9js3x7vf8JGH98j/GA1jebLnB7k
         AYCBzmQ5J04Kkmnx8bwh5xQuGwHIGssb+JITSRCnTiScbPdDSJ7oTTtxMQ7jMCfICJ5h
         AGIvkX9jOQ7Ulj255s8i/mBds32LVSMexP+G7G1coNQJqWieGncNv0zDB+nUuoaNWx9a
         Ym8HUmf231hNfPIToW0B/21hQn3CJeW/8kLwDhLnMXi09ErzQN86A4DcQz7yYQFh6IXm
         blS/OJmd0k2WGFyABzHbqHbdlIg+4QZ2NTvP0JqoZ0aSyZuIgki6GSgiClYuTufvcFAs
         xTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941840; x=1739546640;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxr/gLgLMBNgytGiMYTlRHUYI9qRODMAWATD12wZy7U=;
        b=RUhNtszlZXKcw+g9EvWPtlNUcQAvO9pAHE6Y02PKFA3H+VDm49yqPqcN2u14uzBYbl
         vpUMiLnd2kcKkygXmS6OBUZ+nKAor9JECU9UpjRlRMUDCRhgg+JfOG5iH7BM7EddDYhU
         8q/9sEQ2gLdGNH+8/TFgr0IvoXWffjgEEdZ3gYToLnmuZoyrh9VafEjFX8QsFnhOuwAu
         c/EaUGIfWoOxWyuhT2LIna1XqWX3sX/h+x+pcy000IcyN3GTJARYdSgu28SxX/ZDMa0l
         rtVl4wva2/UtyS/N0XjyAxhflP8p3AvUQgPHYryCqVr/m9DFPoNs5BEH9A0uPxDKqHJr
         E53Q==
X-Forwarded-Encrypted: i=1; AJvYcCViqr+Z0kso2vZWf6hWzv0VDSme8YfIU45d991tKk5Bl4bmZx2ASir371ytlss6UYXakLubAIyt5TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI99jWorYYNIIbJ/eb2Xe2nyLqBJMr+hz6jt1MqBFR7ZkeV+xF
	Xl9SA5i7KTbUfOUT3pMznDX2yOKQxyEVfsQyxBShOgIT5N/ho5Xv18Vx/Oib5Tc=
X-Gm-Gg: ASbGnctUPSLC+nlIbsoKlZyzasyqmpRJ2kZJfh6uKhajvzWPYTyGVUf8reoAo/NVa8F
	M8OxD4Yg8Ut8VGsCk7+XSRp8BHSEojp5NSRIWqLPE78xPpVx3pfveeHYUgeem1TY4W16FxWumg7
	fY2+AJLVNkbrXkNwLbVXTizoNYdV6Ym2rgjgY8Wwz0E0h8GFQzQjd4Z1vxQbmE0NqUtyagUEZjd
	VBVB/0AaXgPIXtX6mweRpTAMGt9Pz5rAIvqLevKA+scyUu6u5Tz7OqUCMZto6lN1y9bvTBjq4wv
	fCpukdji8TuCh1LMcjhlGMapSdOzJvBKIsxdPwdx49nDLMJdGgeu
X-Google-Smtp-Source: AGHT+IF71KkvJXcsCE6zlhD6P6zBCyc3Fr6QETt2X0hURimYWWudXZ1vnECtKv4gtVKmBwfLEwmh0Q==
X-Received: by 2002:a05:6820:162a:b0:5f6:765c:d260 with SMTP id 006d021491bc7-5fc5e707990mr2247407eaf.7.1738941839640;
        Fri, 07 Feb 2025 07:23:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b03b4sm781542eaf.3.2025.02.07.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:23:58 -0800 (PST)
Message-ID: <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>
Date: Fri, 7 Feb 2025 09:23:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
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
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
 <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
 <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 6:17 AM, Andy Shevchenko wrote:
> +Yury.
> 
> On Fri, Feb 7, 2025 at 2:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>>  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>>>  {
>>> -       struct gpio_descs *gpios = ts_nbus->data;
>>>         DECLARE_BITMAP(values, 8);
>>>
>>>         values[0] = byte;
>>>
>>> -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
>>> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>>
>> As I said before, this is buggy code on BE64. Needs to be fixed.
> 
> Or isn't? Do we have a test case in bitmap for such a case?
> 
>>>  }
> 
> 

Maybe not the best style, but I don't think it is buggy. Bitmaps are always
handled in long-sized chunks and not cast to bytes so endianness doesn't affect
it. I didn't see an explicit test, but bitmap_read() and bitmap_write() use
array access like this so indirectly it is being tested.

