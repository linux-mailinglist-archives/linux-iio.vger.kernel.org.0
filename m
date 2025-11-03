Return-Path: <linux-iio+bounces-25853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE18C2C7FE
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE24E9555
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD54334395;
	Mon,  3 Nov 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZfCxeYZo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7332F778
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181629; cv=none; b=h5oVNAaoASsii9fFRwP6llAjYR4L94eLAManL3NWuQ4S9Er6y1/Ogj0ddEnjuKPmi7/mJ4O0jjOSOvbLDfymr+zY1TN1jfsbfRg/pQ1/byTuW9qzF6lNk01wjt9CJUmXvVp7Xt4QG/VUETKv3Z855fNIDrlXo7h08ucsovUxps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181629; c=relaxed/simple;
	bh=ehgZ4ZdKsHFQmxa3sEld7o3zP6QkHPreEmxCnU/yFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0LqluX90Eyk8oWiRuimM3bjXjX285Wt+XoB7TuWPDkEJt8mbn0TY4R6GjvLbsmKxWWRmxI04S8re0MRCj6WS8tcQu0NX/wk9t/+7OSOPe1U3FZmFE4JTAcr+L60i0m5sTNxup89sBvuNoo6CYecLKepJT9Lzp7adv33DdfHK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZfCxeYZo; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3d573d8bc5fso1530837fac.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762181625; x=1762786425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oRhMrtETyf8iDJxvxWets9ZrKCJQU2U505W6uUmeok=;
        b=ZfCxeYZoDItY2EIVbbo4sQ/Nb3PW88I90jpArNPXWD6CcSYkK1RoeNGFb1S084vABH
         g9aHk5DvPVoQmqHIWdZW8NzfyeuCpfNnwzkZAPsgG1OO68EE2Fx42rRHd+1//9tmhV/N
         mBjMNC1ZqhehkVbs2cm8th8ndl0KTSoCdsL7mbfBJkDx9qzb0kyKUSFIvET3vksQo/rK
         sPciLPY3P1DGV2yh1N4/FtOKt9VNU95tYI34UOMbkgEK30xZ+v6Q6u85VEh7Cni+tTcV
         adkPMwVSjkDKy9OBxtB9A8v6HtIHXaFifherVKFqcdGx8RY+q8jipJ4dnZV//TpL7wK/
         Y5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181625; x=1762786425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oRhMrtETyf8iDJxvxWets9ZrKCJQU2U505W6uUmeok=;
        b=ZASnfdfM8UNf634OXdKNbOffcq2QKvPhCFg5ZamCp0qwubFk/6/xK2az5w74xVkgZC
         dkb68sKiYi5kAb95G2KZB9eg78QKpOtExHySBMLBl0Dn76KVzyZ/ZcL5kc1AgFwB8p7D
         h5yrroHxS6lQf5+Qv9rYNW1qztop/uZVSQEK0g21lWpQjnvPKLaBbEPRZSLAiMhNhMjM
         e2im2+r3DuBVZP6obg5RtPAhpMz/UafLkk1df7boXut48EZf3fQiKZO5rEHYszj9FJqb
         916DeS9OqoQufzgENuqomaHVY7xQLHfOUk3gCPUz/x/zpmPFe9MUEmnTjuAS+RTBygZL
         3PSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDo1Yayre0Lp0HqCk6xY+/2ACffdtv/59kaiU5UBsLF0MuSecwh2wLIQ7X9DgiEVGjaUN5cYyejU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9i+jSV0jV04N9mTKqLDoIUbOaoBV0ZLEXv8mzucJdEf/B7lVb
	JcgMFaOyvQI1k/jZnwDyEsCMEtwkbFDNYK3uLB0EMec4loZDJfFQtYeXLLjNCy148RM=
X-Gm-Gg: ASbGncuq7uU4ngQM6ScdRcAXlmPEMS/U8jKAEPv5uJfYP8S/G6E5ArqFXJXs8o3gf64
	WNWlGqjH/8b+p2ioBN1fc+4DuUJjOzgnVQx+FwIY6x5yiev16zza+e4Ex7vF41ifmB96OSY2NwQ
	wrH0Orm0X/r9pKVnfacuJ6czs0H7gkXeS2stIEQb0qvnZ6FE9Se0cDsMxzcjvKcYlpqd3uh2+C/
	ExCfbw+gvSILLWxeAQZuz7hkTzw6Ske2tI4VkMwq6HJHyzjsAhlVl8jNruJzFK21Zvf/beEV29e
	bhRUoa1GvsaTxKB6wlRkUnOJ147uNuZhu1cFqssCWmXaGZsvLqo6vdp9TGRHiPLInoCluCjYZet
	Qzi/+7w0KV49MgtgCr22q5kmxqi9T6CpDoZFSK6qvWc5Jo1xaLhV3Q6rm2MioHR12hHSQLVsWuw
	1W4JLHZ3yTr6PNN2Go6dvyzBvpvgVhH4QuvX82oQtZGuMJ6s8iTLgqvXhgNwZC
X-Google-Smtp-Source: AGHT+IEJo7rLgIuSX0Rig2sD9HKUnrO5Vlavhp/7cDNnxbSPaLQkc0oS3be+i0RSaCSC/XzS1N8XhQ==
X-Received: by 2002:a05:6870:5d86:b0:3c9:810d:494b with SMTP id 586e51a60fabf-3daca101f52mr4992674fac.8.1762181625628;
        Mon, 03 Nov 2025 06:53:45 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff5213959sm116338fac.10.2025.11.03.06.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:53:45 -0800 (PST)
Message-ID: <798a41fa-eda6-4f27-955c-82fdb61c2083@baylibre.com>
Date: Mon, 3 Nov 2025 08:53:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
To: Francesco Lavra <flavra@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-7-flavra@baylibre.com>
 <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
 <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
 <aQNs8VVoStUJ6YHB@smile.fi.intel.com> <20251102112958.435688d5@jic23-huawei>
 <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
 <25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/25 3:34 AM, Francesco Lavra wrote:
> On Sun, 2025-11-02 at 15:45 +0200, Andy Shevchenko wrote:
>> On Sun, Nov 2, 2025 at 1:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>> On Thu, 30 Oct 2025 15:49:37 +0200
>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>> On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
>>>>> On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
>>>>>> On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:
>>
>> ...
>>
>>>>>>> +       *val = (data & reg->mask) >> __ffs(reg->mask);
>>>>>>
>>>>>> Seems like yet another candidate for field_get() macro.
>>>>>
>>>>> FIELD_GET() can only be used with compile-time constant masks.
>>>>> And apparently this is the case with u8_get_bits() too, because you
>>>>> get a
>>>>> "bad bitfield mask" compiler error if you try to use u8_get_bits().
>>>>
>>>> We are talking about different things.
>>>> Here are the pointers to what I'm talking:
>>>>
>>>> - git grep -n -w 'field_get'
>>>> -
>>>> https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas@glider.be/
>>>>
>>> True that it will be a usecase for that, but given plan is to merge
>>> that through
>>> a different tree in next merge window, it's not available for us yet. 
>>> Hence would
>>> be a follow up patch next cycle.
>>
>> Yes, but we can still define them here. Dunno either with #under or
>> under (namespaced) names, but still possible to use now.
> 
> OK, I will define an ST_LSM6DSX_FIELD_GET() macro.

The macro should be named exactly `field_get()`, otherwise we will
have to rename all of the callers later after the series adding it
to linux/bitfield.h is merged. And it should have an
`#undef field_get` just like the other patches that series. Then
later, we only need to remove the #undef and #def lines and not
change the rest of the code.

