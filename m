Return-Path: <linux-iio+bounces-16111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD0A476C7
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429047A3F36
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F338DF9;
	Thu, 27 Feb 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBgPB66T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4B213E71;
	Thu, 27 Feb 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642374; cv=none; b=kmX6d1UMIZPdfcc5p/x/53D2ExnebfoTSdim8fF8p53m0pr2H5IH5/Gn6PL/seR+BbRsZCh4/Nkjatj02udtTABEUiMb44J4QXwOt4MVDtEDA+ngYHbgBZ0kY+xzC8HRRHksWm9JWA4xI9V9anBC+lv9lvNTUMl95U4OUrmA3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642374; c=relaxed/simple;
	bh=NW+ec2UuJ/FXy8L1uMkrLm158JtfwpfDLNYHmBO9VdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJ1ZikzKqe1gc1qarjoEvXurdQaarhp+E5rpcCGELKEEFPfGYI1HdWSzA7IdiDkW5rrEHJG+3vxqG2R4LMuRCIT1kN8v5LbwAUeT33kEuQbqCK0dK3n+Dr/N3c6Cnc3mAdmLDbr0BM11VKIahj6yYYDDls2XVB1WIjUfgMcMiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBgPB66T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622e97753so670403e87.0;
        Wed, 26 Feb 2025 23:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740642370; x=1741247170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtUYvUWC1AkG8jyAiGXYjz4SHzVwMltIbWsY/nE9gH4=;
        b=BBgPB66TOwNh5vyzP6ojeoo8pITjpZhHShzzVbbgEhGDezsFg0x23DiKWpyBjAQdOS
         HBDQovJDCh1QM4a7mvd2tu07oL8bKR1XWbgr956baLMgnNB5NNjJdeJU392f1Tx363va
         yyfAQZzyHvH0QARIx2iUU2cBwfJjkwm2bI1wIVGh1vjfdR+JoPzEQmJDneC1zlUDjncB
         bYDoN5qC8kEt5aBGxOrqsov6aG4ng2CCDvzCxRV6n9YRNL6GlFMGQEfg/kmR5kTYo9cO
         04b7kzRtAItj+nzDmK6Tuez+N17yILhXF2rYAcV6ngncs/x9e78AIx3K4F0xG1ChZB0B
         y9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642370; x=1741247170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtUYvUWC1AkG8jyAiGXYjz4SHzVwMltIbWsY/nE9gH4=;
        b=jaIxy8nKqOyKF3WA62WC/bvnQBWsOgDJGls8VtoDT/gUt+jovyZ/lPwSWjx4CBVuAE
         ZTHaIoX97HcUlxtwMvtmyitTu+06VhosFq5eUd/g8nc3AEYCV/zsMQChp7g+4+5spFO+
         9Rr5CLPGFaPo3uqz4l11X9YJT+r4T8e6gjsUIJBjgEK/9iyKAnHDKYTbwSiaqENOMin4
         sF6nDsAf8Ul2sgvPDzwRaE7nOAAQgA0ULFO4ElI893ZMNLE0djre/FSvSv2OruebnEnb
         6liHeDfPUjB2G1lrFhlsmPk8IkXPOOa/WCUwTYUP6rVcFl+VLPOPsJmJsJRZkJSDQPmY
         rc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZCnok/5jJDb+FBUPMbOr7HGynlg4xLdF75lz6dajxzJ4W8RnZWloc64+5Kv7UHUpNauoVgoZu1pBr@vger.kernel.org, AJvYcCW1O1iCyZHu46vQe7lJFuJcZDnWnPgGpkCbIhHd53NNCHSgQA0w+H0Pv0z0AQNfDpf7E7UYS55qkHSd@vger.kernel.org, AJvYcCWGUtmFv4eT5Nze9idXXWC+ZIcX1Csi8f28ZIIbEx8oTUdFY2IJWCULQwxh6/eO6BQqmDbn6gZSTM1DKg==@vger.kernel.org, AJvYcCWRQ0aaR156iU05XnMmaF693ZKk68nf92U/o4pbSNn1nup14N+LLyhye4cEARxCQHl7hOQUEhCyltG7OgPF@vger.kernel.org, AJvYcCWt6Twia772Ydki49vmH1LkaPhSkYkhBTr9hoAeBMysmX35wz1U7DZPYgHLbF7sxT5j4LOUjwow1MqFgnMr3Q4TS0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2bCGu69HnbDPYj0EQTW/Fj/KEWw5e930lvLR9Wzq0BQwQLOs
	hBGrq4ebMoFAKRBV6FPxBcS6GSE6jiynYejOm+wgZ400xuqIm6Fl
X-Gm-Gg: ASbGncvkyxZBXttEOpGEVK0zQ5qdka9oNliAVz5v/2OF1Yta5vUWgFJbZGkF5BT1d8Q
	TkYmQa6gvJ7feg3GgXafhSxdKIu4SUn2aBwzKD6QoBe3nsGTnAYS75+W4VEnDSNLzYEUwNHHdFc
	c4htMZN4Z6TGQx87Kf9B/aHOFNzZaqlxJ8mjAlr7fXrCXlVL+fDl1NGt5d0C2xLpuqi84bKkn66
	lwRDiMFSzPac4KArtUumT1Gkr/CC4SEFYIOp9D12Z9eOpsEmxbpvtAFhHs2imC2oTflDEOpit17
	06AeX5z7p/8gKlngKebQv3IqxUcTwzjRjTZhoPjq/zyU3E5YEfpjteUCmQcfDWEAPY3pk3BDDLx
	nCODj9P4=
X-Google-Smtp-Source: AGHT+IFFyAsXsY4HRaIHHuW3BNl5wcOAhXKEwTKsY23Y5b/QvWafl4HHhRh6kgPntviPRCAyMbQxbQ==
X-Received: by 2002:a05:6512:1093:b0:545:2bc5:e27f with SMTP id 2adb3069b0e04-549432de182mr953232e87.12.1740642369865;
        Wed, 26 Feb 2025 23:46:09 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b1143sm93497e87.116.2025.02.26.23.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 23:46:09 -0800 (PST)
Message-ID: <9180ff11-888b-453d-9617-4b3a0fb38d91@gmail.com>
Date: Thu, 27 Feb 2025 09:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
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
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
 <0de7b0ac-eca5-49ba-b1b3-f249655f3646@baylibre.com>
 <1b308a10-9622-47f9-b489-bd969fbdfc34@gmail.com>
 <6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2025 18:10, David Lechner wrote:
> On 2/26/25 12:28 AM, Matti Vaittinen wrote:
>> Hi David,
>>
>> Thanks for taking a look at this :)
>>
>> On 26/02/2025 02:26, David Lechner wrote:
>>> On 2/24/25 12:33 PM, Matti Vaittinen wrote:

...

>>
>>> Similarly, on several drivers we added recently that make use of adc.yaml
>>> (adi,ad7380, adi,ad4695) we wrote the bindings with the intention that
>>> if a channel was wired in the default configuration, then you would just
>>> omit the channel node for that input pin. Therefore, this helper couldn't
>>> be used by these drivers since we always have a fixed number of channels
>>> used in the driver regardless of if there are explicit channel nodes in
>>> the devicetree or not.
>>
>> I think this works with the ICs where channels, indeed, always are there. But this is not the case with _all_ ICs. And in order to keep the consistency I'd actually required that if channels are listed in the DT, then _all_ the channels must be listed. Else it becomes less straightforward for people to understand how many channels there are based on the device tree. I believe this was also proposed by Jonathan during the v1 review:
>>
>>>> Hmm. That'd mean the ADC channels _must_ be defined in DT in order to be
>>>> usable(?) Well, if this is the usual way, then it should be well known
>>>> by users. Thanks.
>>>
>>> Yes. We basically have two types of binding wrt to channels.
>>> 1) Always there - no explicit binding, but also no way to describe
>>>      anything specific about the channels.
>>> 2) Subnode per channel with stuff from adc.yaml and anything device
>>>      specific.  Only channels that that have a node are enabled.
>>>
> 
> Hmm... does that mean we implemented it wrong on ad7380 and ad4695?

I believe this is a question to Jonathan. With my ADC-driver experience 
I am not the person to answer this :)

_If_ I commented something to this, I would say that: "I believe, this 
question is a good example of why providing helpers is so powerful. In 
my experience, when we provide helpers, then there will be a 'de facto' 
way of doing things, which improves consistency". But as I feel I'm on 
the verge of stepping on someones toes (and I am really the novice on 
this area), I won't say that comment out loud.

>>> There are a few drivers that for historical reasons support both
>>> options with 'no channels' meaning 'all channels'.
>>
>> https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/
>>
>>> In my experience, the only time we don't populate all available channels
>>> on an ADC, even if not used, is in cases like differential chips where
>>> any two inputs can be mixed and matched to form a channel. Some of these,
>>> like adi,ad7173-8 would have 100s or 1000s of channels if we tried to
>>> include all possible channels. In those cases, we make an exception and
>>> use a dynamic number of channels based on the devicetree. But for chips
>>> that have less than 20 total possible channels or so we've always
>>> provided all possible channels to userspace. It makes writing userspace
>>> software for a specific chip easier if we can always assume that chip
>>> has the same number of channels.
>>
>> In any exception to this rule of describing all channels in DT should just avoid using these helpers and do things as they're done now. No one is forced to use them. But I am not really sure why would you not describe all the channels in the device-tree for ICs with less than 20 channels? I'd assume that if the channels are unconditionally usable in the hardware, then they should be in DT as well(?)
> 
> I devicetree, I think the tendency is to be less verbose and only add
> properties/nodes when there is something that is not the usual case.
> Default values are chosen to be the most usual case so we don't have
> to write so much in the .dts.

On the other hand, I've received comments from the DTS people to expose 
all HW blocks in the bindings. AFAIR, for example, marking 
power-supplies as 'optional' in bindings is frowned upon, because they 
are in the HW whether the SW needs to control them or not. Hence I think 
marking either all or no channels in dt should be the way to go - but my 
thinking is not done based on the years of experience on ADCs!

>>>> Add couple of helper functions which can be used to retrieve the channel
>>>> information from the device node.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>
>>
>> Yours,
>>      -- Matti
> 


