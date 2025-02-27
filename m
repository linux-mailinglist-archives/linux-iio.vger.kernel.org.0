Return-Path: <linux-iio+bounces-16112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A8A47729
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 09:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0997A5939
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7AF227EB2;
	Thu, 27 Feb 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH0IgmiF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565492222B8;
	Thu, 27 Feb 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643317; cv=none; b=uhBd/wXhUGMrvPszQgCj4r4zH82JIKhGOCfsrXIRoijuBU67DjP8sN9St8qb3098eA/klCusyktUHr6Rk49HVkZAa8tuvy+kAX4txEJwzHxv9KWnbQPufX7p9eOzbcFst546TaPz5gmJL3nkbrszcFDJS022XaWO84amyszi9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643317; c=relaxed/simple;
	bh=runjjTr95i43OiT1nxM0NLq9jU5kyxMdjAifU3Y72ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYzYpwW4t2rKaXewoZigSxvIvIFAswUHxKf1C4TAIu8rP5Djf5KDdNcv8nuBujDt0u4uPCak4AkMTgbbeKncZ8noo2WDYmDYX22Kb96jyCYKpCqyb0ovSTRgs8TLmO4D30xby7JnA4fHBE7+xOSgolOGj5nTy3OJzovoMmWR+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH0IgmiF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54298ec925bso963233e87.3;
        Thu, 27 Feb 2025 00:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740643313; x=1741248113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDtuSF+uNvwU/olXT0/1pp58GsxviGqVNXkV33zGjbs=;
        b=bH0IgmiFcPevoY2hqONYARZZmNLCwMY0AfK9x7thqbgPf4J+Qn4hBAcN4pQrZdPGtn
         McbOOwHbxpOO+7bjb8sRMU2W2Dg87h62N2jihV+zCmC/9jpDi9VNkXdeQe344sW+hzFI
         YDzEyoax1yxUuIuAQsOdd9IYFRLSlQmjoFK3OamCegJstxIThmsNoRuwNZzN5frCOzVi
         Qov1wO1hWKs4A5wQl3KU16hTjNjuCv9nzS1TTbFZz1nJ+om+OjRdQcEz1o+VwqT+3W/i
         j6eYFHdEk/YpbRhOac6A9J1ZbfjZSY7OVIs/DAaFrjPfKkb2s4McUW5uV3eiBdTw4XIN
         Hx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643313; x=1741248113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDtuSF+uNvwU/olXT0/1pp58GsxviGqVNXkV33zGjbs=;
        b=R2oStxMYjyAK8xz7CelsV2cxglL9rGkJ384Awfzo+8IqjUR12N3Fgq9vLzApenM9zK
         Ol5lk804Got6QYHLGT1edKka40463xxd4/E0iwPfUkPhFl3H+aPKiEilnxf6Bhb0x1Bx
         h/3KE3rw5nUh/BZFAs7Z6/z6Ni0nxJ/F0/0Xqo5/1hbUi/MruijkYEg9rIcyLGlPMjDj
         kXv+y/Nm6YI8TMvoJv4AayZHIVVA+ocM0Vu5i1yBj8eL6QAP5uP9RjfNOPYh4gqyTEtU
         XS+pc5MMRhbmejwgh9xFRe7HF4OheYoR8RetDTAqHutJ8iOmgcSkA0Yp137PWsNILtms
         FLvw==
X-Forwarded-Encrypted: i=1; AJvYcCV9BRPb9UiMYR2nxIxAsiGeLQWlBPCV7B6VF06ZnM/iTjtXtt7S9ZXofMqMUVylaxZ89BvwciE3GvUfm4DD@vger.kernel.org, AJvYcCVv/EIZF+V5AntFDLd6F+ICMZ8qw6wVr4torMdM17P0K33j8UFPNt5yIdBTcD8JsZYHovgyjwCA7oLGrA==@vger.kernel.org, AJvYcCWYgdGo/urCe2P5C8zJ/PK9b2oJMLiLcyeWqoYat6gKQ8fhPwPQVD+LoFdCD4GXjiTquYliHZRdVkrF@vger.kernel.org, AJvYcCWhNLLCjC1tETtdbXjgZe6EhzMqFGOCX8BoXEjJbvMnWBoj3wZbWQ1GRzQtgsgMX6Rskz4crolJLCNUfl5L8FVqURw=@vger.kernel.org, AJvYcCWpyfxJfrazKeaaqoEmseP8EjcCE179XprKS0SXG2wfVeENEz0ueD2GfkVVTIrY3tuCnCP44dX1v1D+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jwv8oyT5NQzkjDl4y8rJ2IvY9tCV0TdHvOZmzQDwZWSS/O62
	QVvBkOzsr9VwozZBFTKFnStdhe/YoxnGiROtXI09TKKpx4BzK8kw
X-Gm-Gg: ASbGncu9+YoOvt8Mw6OMO4OHwlEr9JKZAFwM0C0Q6Kf3STV0dt1o+alh2+iiuYSsDDI
	YRhGl/PQFBDRuZ35rbHNaL/Xlfm7DLTjavgH7G6QwP96fJaJNVqbALTMkb8Z7HZxOiF3MJvQzqL
	I0VrbpKVZCf8LrMqcxfH7m2TVAd+lkri9jXbnNYfmDaKNKGUVLRnaReKXioZ5hGJKolo2xbmcQb
	8TpDKStd6XUUJdAMDQJ6VyycYE/aYkHIsoiCpB0T5hQf8pAZ96SYxTkCx5vBgwWY304afoIhxst
	8cESDawJOummLbGNu4DsTM0Am3o0N500WWj58D9QINc5L8VquZM8iBl/p9P5TWWHcSIiGEykWCn
	tYPZjwvU=
X-Google-Smtp-Source: AGHT+IFjVjmK2qHUacoPpo4OU31ZwGA6d9bKKSSD59w0ISV0sOUUwTnyPiZ3gMGZR/v96mmqDXra0A==
X-Received: by 2002:a19:8c09:0:b0:549:43f8:824 with SMTP id 2adb3069b0e04-54943f8098dmr558221e87.26.1740643313017;
        Thu, 27 Feb 2025 00:01:53 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443bebd5sm98564e87.209.2025.02.27.00.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:01:51 -0800 (PST)
Message-ID: <d7982b76-3da7-47ff-b2b2-f964610af1f7@gmail.com>
Date: Thu, 27 Feb 2025 10:01:49 +0200
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
 <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
 <Z78g_uiXumn4mvET@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z78g_uiXumn4mvET@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 16:11, Andy Shevchenko wrote:
> On Wed, Feb 26, 2025 at 04:04:02PM +0200, Matti Vaittinen wrote:
>> On 25/02/2025 15:59, Andy Shevchenko wrote:
>>> On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
>>>> On 25/02/2025 12:39, Andy Shevchenko wrote:
>>>>> On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
>>>>>> On 25/02/2025 12:21, Andy Shevchenko wrote:
>>>>>>> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
> 
> ...
> 
>>>>>>>>
>>>>>>>> I did not check how many users are you proposing for this, but if
>>>>>>>> there's only one, then IMO this should not be a global function yet.
>>>>>>>> It just feels to special case to me. But let's see what the others
>>>>>>>> think.
>>>>>>>
>>>>>>> The problem is that if somebody hides it, we might potentially see
>>>>>>> a duplication in the future. So I _slightly_ prefer to publish and
>>>>>>> then drop that after a few cycles if no users appear.
>>>>>>
>>>>>> After taking a very quick grep I spotted one other existing place where we
>>>>>> might be able to do direct conversion to use this function.
>>>>>>
>>>>>> drivers/net/ethernet/freescale/gianfar.c
>>>>>>
>>>>>> That'd be 2 users.
>>>>>
>>>>> I haven't checked myself, I believe your judgement,
>>>>
>>>> I took a better look and you obviously shouldn't believe :) The gianfar used
>>>> of_node instead of the fwnode. So, it'd be a single caller at starters.
>>>
>>> ...which is the same as dev_of_node(), which means that you can use your
>>> function there.
>>
>> I'm unsure what you mean. The proposed function
>> device_get_child_node_count_named() takes device pointer. I don't see how
>> dev_of_node() helps converting node to device?
> 
> dev_of_node() takes the device pointer and dev_fwnode() takes that as well,
> it means that there is no difference which one to use OF-centric or fwnode

The proposed device_get_child_node_count_named() takes a device pointer. 
I don't see how dev_of_node() helps if there is just of_node and no 
device pointer available in the calling code. (Well, as I wrote below, I 
could alter the gianfar code by dropping the gfar_of_group_count(), so 
that I have the device pointer in caller). Anyways, I don't see how 
dev_of_node() should help unless you're proposing I add a 
of_get_child_node_count_named() or somesuch - which I don't think makes 
sense.

> API in this particular case. Just make sure that the function (and there
> is also a second loop AFAICS) takes struct device *dev instead of struct
> device_node *np as a parameter.

I think I lost the track here :)

>> I think I could actually kill the whole gfar_of_group_count() function and
>> replace it with a direct call to the device_get_child_node_count_named() -
>> but I am not at all convinced that'd be worth including the property.h to a
>> file which is currently using only of_* -stuff. Well, I suppose it can be
>> asked from netdev peeps but I am not convinced they see it as a great idea.
>>
>> If I misunderstood your meaning - please elaborate.
> 
> The driver is quite old

I remember having to modify this driver somewhere around 2010 or so. :) 
Time flies.

> and has a lot of room to improve. Briefly looking it
> may be almost fully converted to fwnode, but it's not your call (only if you
> wish). Nevertheless, using agnostic APIs if they reduce code base is fine.
> We have drivers that do OF and fwnode mixed approach (for various reasons,
> one of which is the new API that is absent in OF realm.

Well, we can propose this to netdev people but I wouldn't be surprized 
if they requested full of_node => fwnode rewrite instead of removing 
simple looking loop and bringing mixture of fwnode and of_node in driver.

Yours,
	-- Matti


