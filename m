Return-Path: <linux-iio+bounces-17399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C707A7608D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BD9188B7DA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9291D5CC2;
	Mon, 31 Mar 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVrNp79u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD91D5173;
	Mon, 31 Mar 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407509; cv=none; b=VmxfA9oqzovW/oEvIryiuAznMVIC4XhjpIVqZLyvdLvlZZlRUrepjBcCBGUtg9acZcBRU27S+k/givQnyf+m5prWNT8p1X/ZJiFCBgApQFQmqLC4UvaaYmxz0cGSKHsaNcy7fe+O44dyNpY+fpyx9lXo8JTiOx6LtnYy/BUTiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407509; c=relaxed/simple;
	bh=9AlrBWzqBMKkpz9QdBD0P3k6CjMcH1F7/vTDVXY0dVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLbrn/pgBX5c0jfj/jR8IOFhx0Ks1kTml7oFf6NZM+5xAynAU3DJrkJhqWJZX4DHN6ofSAUzDjLYLpBoZE/8XJNpq+OiJWjKBOv0FbDul84BmUYzLolsKkIYfjat61UHyNndPP6Vn13dNSGJH1k9dH48SVW6/TWc1jyMJcK+xdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVrNp79u; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54998f865b8so4136550e87.3;
        Mon, 31 Mar 2025 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743407506; x=1744012306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JO/GzbUADDsdzMoe0v/KC2oqrn4xKGy14TQB03HNjw=;
        b=PVrNp79uZLNe5TtYo77nH02B+jPRYGMQR43pF4eF1O+GVTVYaD8kdHD5zjzfYXn9eq
         qp38e1v8gOovhKNqsaYi/lYjYsSf/3kacZy0MktJWYWRz56L04HM1mpGux4MMzsAqfFK
         iYXWNQuAn25qbQ05xnYilx5tjKjDCkmMcVei7AIrPfKfD174Kdt9nzO1O/BHNaIMxJuY
         4RN6NzHL/l1/TQUHftDujgIoeXNgRX/6Y51nWZfFU8cKeYrRTnLXTFYAAM9R/ptKc+av
         UOHyVORoex0lR4tJk0mBjKPKeF6RVSPVtPq0VTItSdl+KDONcPbJha6mqeUZu+tE3o2F
         w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743407506; x=1744012306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JO/GzbUADDsdzMoe0v/KC2oqrn4xKGy14TQB03HNjw=;
        b=henp4R3YzIhcFvhXLSMUqFWOJGxFkF//Gjn5wZZZxoImW4tgxCJtmBYrk0n9xacaDV
         A8DhVvJYkTeC8jSK/31pm1YFW7N9RLsoNwFtgnerL/POvRm6BTnG4uz3h6jjPPmjoPE9
         Yu9B9p3xcOw58etxCQ7mQw/S9kZRtvzXrWy6gvS7wzmhjuHD01rj9KoedL3qevCbAgRC
         XJLzUHeS2hCL7w1FNMKCrKidrY+/zrFvJKFP8Lo72FqGUlUqvqVyIqQbchS6U+op/MwF
         O764uqB3sutjtdcy1kxsX4lbSHY82reOgWVvPievGLHZCAaEij3VPhWkKyCi/MEEO3/K
         6hJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUID+cG8MjWmRtr274urdqAxO9LcpAAMpTNUAVPqAo7G5gWspk0rxN4wi3AF3lFnonUFXrEzdQm1i4=@vger.kernel.org, AJvYcCUMxeGpBHMlZGqn9/Ly5df67X2bfAPkgfFiWXrf6toqoGDEauagKJptTAFG9ZYveJvLnM1ZRXMRcn6OrPkL@vger.kernel.org
X-Gm-Message-State: AOJu0YyNER3NxBFXOqnBrzO5llPoanIPPXhygCoGEspq94wAtUJo0w7L
	xsSEwahKllD30Fugmba3X/WLW0uVNlCXinAZP85KpVcrebh9LcFX
X-Gm-Gg: ASbGncuIoFy/4pNh4mjE3eC6qnZBVqSJURhkb0rNxS8jrzfwQmp1XHzCoWmjF2TsuvA
	BUv+xR1x6sFw6r7kS9srlBwlBi9P4DCvHiWYuFo4D35ktpgVDzmU0YSkWM9NR/I5adkbjMR6ff7
	E0i3jxW3CPorwCd0cG1/u5WcDHf3sF4+2FgpmsBmrm4fxmXVU/ZkYhppzXN8FLph9o7lkJt6Fb9
	0FGWkYWhBPByNbE2haEl8xclKhPVDiHXTycP45TJVtYdhf3GSd+0zk0Voe1MSip5YavkUtYjWVe
	jHtcb4gBOj/h00GCwvQLK76y118pC0V42u8McG28Ky6qW9TXptnuXKuTpU5U5QaN9DoIqcS/EfW
	J9uat3JwtUls7h0HaJS9Gs+jSMg==
X-Google-Smtp-Source: AGHT+IHR8z29IH4xUp1tzR4Jy5JzJWNKfXwZz9XA5oFoqm5qZ0+weLIEGdoyserD2Si7bgz99JMW3A==
X-Received: by 2002:a2e:be29:0:b0:30b:fd7a:22e9 with SMTP id 38308e7fff4ca-30de0249359mr22606211fa.13.1743407505665;
        Mon, 31 Mar 2025 00:51:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b4c86fsm13259221fa.69.2025.03.31.00.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 00:51:43 -0700 (PDT)
Message-ID: <d360c0a8-2d21-496f-8ed2-9d3417527d78@gmail.com>
Date: Mon, 31 Mar 2025 10:51:41 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
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
 <20250316110237.0b558248@jic23-huawei>
 <222c5fa7-283b-48ce-9d01-34ca633674eb@gmail.com>
 <20250330170436.0fc14b64@jic23-huawei> <Z-pGIMC7cu0QPBzi@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z-pGIMC7cu0QPBzi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 10:37, Andy Shevchenko wrote:
> On Sun, Mar 30, 2025 at 05:04:36PM +0100, Jonathan Cameron wrote:
>> On Mon, 17 Mar 2025 13:24:07 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>> On 16/03/2025 13:02, Jonathan Cameron wrote:
>>>> On Thu, 13 Mar 2025 09:19:03 +0200
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>>>> +	return (data->alarm_monitored[chan->channel] & BIT(dir));
>>>>
>>>> Drop the outer brackets as not adding anything.
>>>
>>> I just noticed that the integer returned from here is directly provided
>>> to the user-space. I don't know the history, but it feels a bit off to
>>> me. I mean, I would expect the read from sysfs file "*_en" to return '1'
>>> or '0' - not 0x04.
>>>
>>> Oh well, I suppose it's too late to change this in the IIO core - but
>>> I'll do:
>>> 	return !!(data->alarm_monitored[chan->channel] & BIT(dir));
>>
>> Agreed it should be returning 1 or 0.
>>
>> This stuff is a little bit messy.  I'd not be against that ABI
>> cleanup if we squashed the values to 0,1 in the core as a follow up.
>>
>> I doubt anyone relies on getting 0x4 as that would be very driver
>> specific userspace code!
> 
> FWIW, the time this discussion was held, I looked at the code and it seems
> we have such drivers. I doubt we can change it without potential breakage of
> (some) user space tools.

Thanks for the check, and for sharing the results Andy.

I was considering this for a while but eventually I didn't want to take 
a chance of breaking things. I have a feeling that majority of 
application writers, who happen to be writing something using a specific 
sensor, would just make their code to match what-ever they see kernel 
retuning via sysfs.

I know younger me would in the early 2000s. If I got a board where I was 
able to read values from sysfs, I would have just written the code which 
matches whatever I saw in sysfs when testing out things. I would have 
tried reading the file and then making my application to expect exactly 
the value "0x4" - assuming other values may have some other, unknown to 
me, meaning. I wouldn't have gone after a documentation, much less to 
send a question or a patch upstream :)

So, I wouldn't be surprized if someone else had done just this same, and 
they might be upset if we break their app(s).

Yours,
	-- Matti

