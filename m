Return-Path: <linux-iio+bounces-16928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4DA642D0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47161706A8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565921A94D;
	Mon, 17 Mar 2025 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta1EDVJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C8218AA3;
	Mon, 17 Mar 2025 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195257; cv=none; b=YuiOakU4obrnuH74XuITH0VqQB36XzzknR1pjRfaWx3T0JFBjvtdzgGxy2YofgVWYmQeMe1O3zjkigWyj1TbfwE1isKBA8ikxrafr3I1yhgH3Tu9pTn/wE8luKtYSYJRN6QoK9TLXLkzIGL68T+aiBLtiYuhfdumjZOgcxkLg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195257; c=relaxed/simple;
	bh=LOh+/ZljR966F5cjMTmW/lrCj5rO1htI6feVU4FxXPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0DyQ+yq4LGtI5aGRhShBQVVQrQpOiROzfHhEGDMW41sAnTOo+fbM0X3njJwHOr09wCwZMss1yz3ClTY9+coPg0QrRuypv/E4B+o/+8KEudnXB+CFvJtivspetljpuTltKNZwH3Uz4J/amVLIhUZe/03yUSA8rhrFs1swcJ6Dag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta1EDVJq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfed67e08so45394291fa.2;
        Mon, 17 Mar 2025 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742195254; x=1742800054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vw1GWdMEM4Ckc8Wgm2iiWIdlF8Enbn4100EvI+MNLhU=;
        b=Ta1EDVJq94tnM05K/GeoX/Jx7+e+JEuIb/WWRfAHXp6+4GswGossyx5ZPm8GhXcjlr
         00VbbgYxcLtpUyZnBSzuIfrR8Evcdv1s+fNGuQeYL2aFSRvj0m8ZMVYHgIvGqPAF1GJ/
         7Qayd+N4L7XzAIok8QNXX0N5AMvEnyS0oZePZRpGzNEwJPXMr/fbEEgmVuZUPEQgLeLM
         xRZMk5AgwoMeVmDHZS4yhdMuy2x4cy0GwPWROEdjJYWza/dxWyGaVP6ByHfwpCAxB+n2
         d/QonHKhwAwVVWs5LrJqRKBTyfdNEUGgHbdMR7VBmMiuRZQveLka3Co5B/71nnhTmGBa
         yheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742195254; x=1742800054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vw1GWdMEM4Ckc8Wgm2iiWIdlF8Enbn4100EvI+MNLhU=;
        b=cXqo1CpB+GpuOScQMH9FzsYua/y5f70z9cT5/hV7cRdVByKQob3Hmozv1FYZHUatDk
         46LM2r+H11eaF1SRPGZHznmt49gHeEFPm81O1kyfldPrbN274qY0xB7+77G/Nh7/kLaW
         RJTI7LSG/F5Hf4XMeb+z1YR80tZadGz6qAVIPUYZfrJkuAuJn58DuPSDxDRwvFZP9OgB
         e4ObDaWZweoDkYTp4JefsVQr5b4lg5gaofE/aLRchX/olhGdSiI2PLEArB5hdFEVdzUq
         Tdhk59DEr2fx/Xl96gF1pntpy/z4jl9z7rEIq8AdSGYVU9V3jdX1OFWqrYbykV4sk73D
         qbxw==
X-Forwarded-Encrypted: i=1; AJvYcCUmhqTyIIWH1S4IDeUgVjVOUPQ2fWgdOUuf2t4jWtQQYZ9Qjhk6HyL/9jRX2PwH9NznKIpWGbblMZo5NZjC@vger.kernel.org, AJvYcCWx0y8Qwp2MZu7SQvmj00itsDQIErOnwQeLbWyOzi5QLhV+hXrFQE7yKzSZU/bGZow6J8aU1XeWdEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAks6kxB46Fi1lRShxEFfykEMUGOtq7WzxKnNytYbyGmBKN9Le
	8KwB5RFVPqX+OML19ox3tSU2ybyHQeHnl2tIgrkL3sg1IWV7l7S8
X-Gm-Gg: ASbGnct+lPVm/xV8xUW2dt76+sAL2g4XzUwoli5uo0SEjY1bCfM3sew0JXq0wxF6pbg
	oh+bENjAxKsa66Tz9mzhXz/pIOKjDHPMwFNNYE/vxpIvOuuq3/QF/NOtEpTQGdLqM3GRWlud5sz
	CagtVbHdmTRggACEWU7bdvgXdpeDjr2G+SkFcI2pk7H+mj8gypja4K0vRw+SCFR2TqqK2DqvM16
	YL02cpj/0I6JTc4Kfl7RoqqkwJnebJs7dbbONGByYDHcoQRjpu7gVOCjzf4iXfqBICFC+Hl1EDS
	44LBiXQffBMNAV0WB3eVwUIE0vq1qaa2jPlBfFubULfDJ+v2xSPdZqYwjD4pwyvKGBESNi1EZSy
	oEweUhY/toFjxkdwpBy8cSbivzw==
X-Google-Smtp-Source: AGHT+IEOhk6UOyvvp1T0Wosbqq9Jt0you8KiWrSVlr8avv3vR6ugFY3vWaMLIS12U32G6UwOg+hWYg==
X-Received: by 2002:a2e:a169:0:b0:30c:514c:55d3 with SMTP id 38308e7fff4ca-30c514c5620mr42196741fa.20.1742195253503;
        Mon, 17 Mar 2025 00:07:33 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c2527sm15203271fa.74.2025.03.17.00.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:07:31 -0700 (PDT)
Message-ID: <fb0cee75-30aa-4175-b518-cbf9f3b7d46c@gmail.com>
Date: Mon, 17 Mar 2025 09:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
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
 <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
 <Z9Q_GK0_4J6ga1or@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9Q_GK0_4J6ga1or@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 16:37, Andy Shevchenko wrote:
> On Fri, Mar 14, 2025 at 11:22:37AM +0200, Matti Vaittinen wrote:
>> On 13/03/2025 15:19, Andy Shevchenko wrote:
>>> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>
>>> Only I don't get why you can't use bulk read here.
>>> The registers seem to be sequential.
>>
>> After taking another look - there seems to be undocumented register (0x1b)
>> between the BD79124_REG_EVENT_FLAG_HI (0x1a) and the
>> BD79124_REG_EVENT_FLAG_LO (0x1c).
>>
>> I won't touch it unless there is a real verified performance problem.
> 
> ...
> 
>>> In the similar way bulk write.
>>
>> definitely not due to the 0x1b.
> 
> Okay, it seems I misinterpreted the values you have in regmap configuration,
> I was under the impression that regmap is 16-bit data, but it is about address.
> 
> So, we need to know why the heck HW has sparse registers

We don't know. And we really don't even need to know it. We can just use 
this device knowing there are some.

> for what is supposed
> to be sequential. This needs a good comment.

I think it is quite usual that devices contain undocumented registers. 
Not sure having a comment that this device also has some, adds much of 
value? I suppose I can add a comment that we can't use bulk_write 
because registers aren't in subsequent addresses - but having just 
removed bunch of unnecessary comments from the code (as requested), I'm 
not sure adding this one really improves situation... When one sees 
separate reads/writes for data spread to multiple registers, he is 
likely to assume addresses aren't subsequent.

Yours,
	-- Matti


