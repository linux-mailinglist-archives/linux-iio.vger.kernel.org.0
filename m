Return-Path: <linux-iio+bounces-16092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1102A461A8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 15:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11D23ACAAC
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3C18DB27;
	Wed, 26 Feb 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5LkNFts"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85C20D51E;
	Wed, 26 Feb 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578650; cv=none; b=NL1mkY80WR8ilPx/RM+EusXsY8web4viZVdE2nfPe86iYj7sFs26jKqSrd1X3Y6aaX0xUbyGKLH/QnK3e6a2mw74EymuPqTXIgcRDSZpk1vsxlPzzys8EGB4+rJygkdALlq3Hh9th7KklE29AfuOE3Z9BrC2PGJnYmNSjil8njM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578650; c=relaxed/simple;
	bh=S2p3Ef/P1krdtUktIdrjzgBiMwDtsBQhT0pWSVjIEF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh90EB4if3i3CaAmFZh58h58GP6hVCgY5zC6D3WRqA1hcmebCt6KaHB2Ea1fl0GxkTyVymRjdvHta0+GklZrLUETDhmcnzz2psErGeLSKVyRVQvvQ3Keo/Kryk8qEd1TYEXPzM82qv+la5P5FTY3lFjpgzK0hsH53/nPSeCfPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5LkNFts; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso8083446e87.3;
        Wed, 26 Feb 2025 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740578646; x=1741183446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iklNm2KayquShiYIwOiveLvoWuecEHw4Y693C3rLQds=;
        b=d5LkNFts5nJ0uu6/im/wtVezajX8b5Y3lODclV+NF2X/7yIEZhpqTCYAqk8He+1Ci4
         9JYHuoJnsNdzhKZxaEdbV3OiDaipHtfl+0AwpWXRNeRmdr2zH7nppPb5iy1mvj1d55en
         vK/tmJjkJ+sIHE9Ev7syLXkfADBTC+zlSiMoPTCCst8pY9kc5KCE80lTLOWcrDkb42sh
         amTbf0t+3JQwl9IfFNO50eOg6delgBBrwGiVdkd2YLEFN5wmCmtPLOGoALsHO37rmMKd
         qrJIGtVkddTNV/pkEAfO+jldrXTMld0oGc44ABDhYV164C0IPGC7EXcilWs+8/UWDLAB
         24FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578646; x=1741183446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iklNm2KayquShiYIwOiveLvoWuecEHw4Y693C3rLQds=;
        b=W+GQ4oRU1fbhf0IzF8fNl2n+PblddKT6S+X/pdftT5wvyZX5JcN27fDW/XH37Uj1h+
         YHGHvLVE2va4ciGugX4Be/aFwVK9ru+D4KRF4EIyZmwYwHFqnbZEbfEAx7/TkiBUfPZ7
         myFdsUcNmdJCRfymnzgvQZumHAQw1V8NO7LMt+dfQc1dk0ow4Fb8oGUxbHZ4pHQX4wvh
         ptzQ2HVSenRUlsC5l9A0ooyx0CxgmkzfWqpTCEOL0cosRr3TJugc/p73nOO6qR21BBMD
         +pYA0uHYmeyuR5BsN56LGiRfYSF6hUV4vg9njwoXpu+Pa8x1zeiQymWUSZkF58dKbOhR
         Votg==
X-Forwarded-Encrypted: i=1; AJvYcCV1r0CveRjGWLAjemB1z0fgD3zc8DHxkNf2Ybtm3M2ygCPM+60F1szcGkJNzqHznZDCt9viRIjyRYAE@vger.kernel.org, AJvYcCWNb3hUd/xpJZ58dXF57fFI/wIWHQMi/uzkPkVNGX6NNfB9/Y+ETX31HLwBUEdBJbI1HfUSPzZuIFummA==@vger.kernel.org, AJvYcCXCWvYLHEQR7kVME4PVmHkzgoWifYaVhhr6JM+i2KDzimE4SWDJCjdm7q6aFRo/PO7q/2+ZHNoAWs/C@vger.kernel.org, AJvYcCXOgZNDFzr12w4fmoJUQlOTrqFwllKAsudI1Xhmee4DKcQ8VRVLUyws5u/K8vzDVEH9tgORG/RHRo3zisj9cgYiRFE=@vger.kernel.org, AJvYcCXmb1HC19JoFpXKZwi2RVZt4qJnF3aaozQuyDzq8Coe1L3CVJ8u8qGD8pFYY5jjF5Nu/8aOTtk0uo6qBuVn@vger.kernel.org
X-Gm-Message-State: AOJu0YyHv5+SIASZ4d93eu5lvuPZoH+rfB5Un7o2j/0BCpZ0UM8+5KxT
	47amyx7VBEudvV/vzCdnAtH5ifzxZf5kSR+wi9prI1AfbcUFL7u+
X-Gm-Gg: ASbGncsdkcnwPuRNbfQ7VRItitZ8muJq01QLnsvhBdpC91pd9MWhIAB6dFHrNFNr4mS
	M/88Rrwerbs4uw/CqNJPUDgluj9LkpHL0s05D3IMsQMPqy4gxc/G2MhlBv6T2AhrWeOJtjwx93o
	6mEUagzrBjzoFdbLKdUTX23Ji5wvTnsAJo/ZBlA3+mevI9cm9UA1/EjUciWk/42KXfjeVnAVRhf
	NNWVXuEtRbxewcGT3Hwvb3kMxE63McYPch006UIA9VurQdqtaL39MGh1hWgsejxufjeMIjLFl3j
	tDpu/3pI2ce3sDSV9VfMljYoKef9NWVwoSD7NvO+ESxKIGiAORSpUF13Li/dnQb6wAAhdHwSzll
	XzpfS/K4=
X-Google-Smtp-Source: AGHT+IEpGk7dlruxQZybiX5fxanW29Ro9PxXVGS1JEbV3E8cZgaWlz6jdZJLrmU850dRn2ngJkTU1g==
X-Received: by 2002:a05:6512:39c7:b0:545:f4b:ed58 with SMTP id 2adb3069b0e04-54838ee8b18mr11567732e87.18.1740578645999;
        Wed, 26 Feb 2025 06:04:05 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b72bbsm462711e87.56.2025.02.26.06.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:04:04 -0800 (PST)
Message-ID: <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
Date: Wed, 26 Feb 2025 16:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
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
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com> <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
 <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 15:59, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
>> On 25/02/2025 12:39, Andy Shevchenko wrote:
>>> On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
>>>> On 25/02/2025 12:21, Andy Shevchenko wrote:
>>>>> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
> 
> ...
> 
>>>>>>
>>>>>> I did not check how many users are you proposing for this, but if
>>>>>> there's only one, then IMO this should not be a global function yet.
>>>>>> It just feels to special case to me. But let's see what the others
>>>>>> think.
>>>>>
>>>>> The problem is that if somebody hides it, we might potentially see
>>>>> a duplication in the future. So I _slightly_ prefer to publish and
>>>>> then drop that after a few cycles if no users appear.
>>>>
>>>> After taking a very quick grep I spotted one other existing place where we
>>>> might be able to do direct conversion to use this function.
>>>>
>>>> drivers/net/ethernet/freescale/gianfar.c
>>>>
>>>> That'd be 2 users.
>>>
>>> I haven't checked myself, I believe your judgement,
>>
>> I took a better look and you obviously shouldn't believe :) The gianfar used
>> of_node instead of the fwnode. So, it'd be a single caller at starters.
> 
> ...which is the same as dev_of_node(), which means that you can use your
> function there.

I'm unsure what you mean. The proposed function 
device_get_child_node_count_named() takes device pointer. I don't see 
how dev_of_node() helps converting node to device?

I think I could actually kill the whole gfar_of_group_count() function 
and replace it with a direct call to the 
device_get_child_node_count_named() - but I am not at all convinced 
that'd be worth including the property.h to a file which is currently 
using only of_* -stuff. Well, I suppose it can be asked from netdev 
peeps but I am not convinced they see it as a great idea.

If I misunderstood your meaning - please elaborate.

Yours,
	-- Matti

