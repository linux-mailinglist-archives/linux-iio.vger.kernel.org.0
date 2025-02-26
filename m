Return-Path: <linux-iio+bounces-16098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66528A46698
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77829188D26A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275F21CC60;
	Wed, 26 Feb 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EO3IEWiR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2E21C9EE
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586210; cv=none; b=clu6tmZ32MsLJHgym+Ca8ZLMoE2QmkLKx5lIOF+mJ2mslIqsJ5O+f3WbyP1LOeHTsx4ROKN41SrhX+yfwR3IAjoh9v7tJLXkCVSvmYMldlfg3FId3YMfd5hVv3YJJmyKkTFQ84zTA3RebbiDbbwH66ZHnzJKpapNKtz03WfC9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586210; c=relaxed/simple;
	bh=x2om7tYp0gEmgSJpi6j4oAprnXjR/G/t+gh7S3DVTUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQZFN8uihWsIZb/laogqx1LsgaW8XUXUb60Mlnm3nqZfyP/ISQ9/xbCPW0jf0XrAUGIf5rGjwmy5v3TSNPtUHmSLeFLa+CeE2ho9i4hQUFGwkJERznDurf/NLYLyR2Ld/g45qfDebedx8BARtJ37a4PpcV78/8DoHLLN4i0I4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EO3IEWiR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b8e26063e4so5388fac.3
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740586207; x=1741191007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8B98WlgviCORS8xNE8tp9wUkQXa0yNmModNYUMBxdlg=;
        b=EO3IEWiRfrpJQ5dOfNxzA/rlUDiykFRHM/3dpBJGc/958dPGVuPBezPy60gZrRwpws
         QT3qm4VHzMXStwm04EzFsbmGwmWJZD9kN/JzqyYd1cIGx+OjM6k/S27javqv9w+S8X3g
         g5B7vuvdkkpKq6BM6LMxBS3ZYJJmdjiNpoaqkSYxOfByHKShaD4iHiOD/rl3Fr5e0qXH
         FT6ND6aNA6und98x1kPy8CyB2yO3PzC18bEnLqhTh3k+9rH/oBk2UxEQQ9JRk3Y07CTk
         +1M1z8ngZudpwwISzlk/5flP/TTOFo3WUOeulQXHWCMIslP50mi1fLLm+lJAijeMNKX8
         dRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586207; x=1741191007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8B98WlgviCORS8xNE8tp9wUkQXa0yNmModNYUMBxdlg=;
        b=bJSBycG9kGZm+a3Q5d0bRZ92yVRBtNLyP4Zjq4yZ6/uH2Vo6uqB7c4QHdtYuZIfiVo
         nAvpSLUwW2UHCK9UvTA5HsxbgUM/sCI9vFtTDh6KEFlspvh2I14r2QstHEWFCV0eyB9w
         LYjwOlZDeivVHa7CeGi+6QrNmrqZWReIlD6SiryHOBP3Y+nbERW0rvymiT/+8Shzf2XY
         pL6RUxC4avTKzJkf+BGdERGiykU1l2i/I4/0+4Nw0P0wUDSBBQlkG/ONw6ShseS06ebm
         WFiwAeMiIUScOth0HuCgvod7vb4NaSrS//+sjxMeZeVrJ4aTWCyvNe4+R4KO29rGfQFt
         FN2w==
X-Forwarded-Encrypted: i=1; AJvYcCXrYwagXa6HNVnG0kIahvqI5nokLI2sg/Rqm/VRubODL0Gu0C9kbGDULkv0oyWMMFs+10Z8Y1NQdUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeU7Qmsq5An0u8rO2uCLB77cXzcOFZn1LgByJTTD56uAYW51G
	zlaCK2ySR1qw0BHVETTVUiOE9hpKr7zLgXVl1n6ks9JdmdeZrRbe0WagrlLEGtQ=
X-Gm-Gg: ASbGnct4EyYci0CyN34VY+gDODcFce3+CNMPc28kR6B1LU5E+G5Q18j8C8rBExAfKV+
	rtow9KExLfxfVtOjW8SZmE9/APdxQ1azVWjRoGt3F4vCozNFbRpMLebdZc5wAnw4VQ2aqjiSapo
	QQYNSV8E3UG5h9hqmU0oO4/oFM6SY3Gvf+X/OOEb5l39JiynZwR00e3YtzYWNVrwklg0EBvIO9O
	xUHvWqRvKZeLgdQZebrkcTXg1W33ljHzx2H0lcntmaZzXlZxKTGknR+qmdlOIxPeYLWT1o8BJZ3
	iD1Zl//Tq6laOWWoDvEzEzT3I4LaqSyrNd4WPZ8Za3aZu9STfp4jr2ati3dgjuA=
X-Google-Smtp-Source: AGHT+IEOYib871oGajJ0tAwCyUvFn0Ok9l/YPouvQLougV8cmfpAu3KKTSDRFWXcP1FZvlfxqquzJA==
X-Received: by 2002:a05:6871:7c02:b0:29e:3c8d:61a0 with SMTP id 586e51a60fabf-2bd514ef349mr14836245fac.8.1740586207211;
        Wed, 26 Feb 2025 08:10:07 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289df559edsm745510a34.62.2025.02.26.08.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 08:10:06 -0800 (PST)
Message-ID: <6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com>
Date: Wed, 26 Feb 2025 10:10:05 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
To: Matti Vaittinen <mazziesaccount@gmail.com>,
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1b308a10-9622-47f9-b489-bd969fbdfc34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/25 12:28 AM, Matti Vaittinen wrote:
> Hi David,
> 
> Thanks for taking a look at this :)
> 
> On 26/02/2025 02:26, David Lechner wrote:
>> On 2/24/25 12:33 PM, Matti Vaittinen wrote:
>>> There are ADC ICs which may have some of the AIN pins usable for other
>>> functions. These ICs may have some of the AIN pins wired so that they
>>> should not be used for ADC.
>>>
>>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>>> add corresponding channels@N nodes in the device tree as described in
>>> the ADC binding yaml.
>>
>> I think "preferred?" is the key question here. Currently, it is assumed
>> that basically all IIO bindings have channels implicitly even if the
>> binding doesn't call them out. It just means that there is nothing
>> special about the channel that needs to be documented, but the channel
>> is still there.
> 
> I think this works well with the ADCs which have no other purpose for the pins but the ADC. The BD79124 (and some others) do allow muxing the ADC input pins for other purposes. There the DT bindings with nothing but the "reg" are relevant, and channels can't be trusted to just be there without those..

Makes sense.

> 
>> Similarly, on several drivers we added recently that make use of adc.yaml
>> (adi,ad7380, adi,ad4695) we wrote the bindings with the intention that
>> if a channel was wired in the default configuration, then you would just
>> omit the channel node for that input pin. Therefore, this helper couldn't
>> be used by these drivers since we always have a fixed number of channels
>> used in the driver regardless of if there are explicit channel nodes in
>> the devicetree or not.
> 
> I think this works with the ICs where channels, indeed, always are there. But this is not the case with _all_ ICs. And in order to keep the consistency I'd actually required that if channels are listed in the DT, then _all_ the channels must be listed. Else it becomes less straightforward for people to understand how many channels there are based on the device tree. I believe this was also proposed by Jonathan during the v1 review:
> 
>> > Hmm. That'd mean the ADC channels _must_ be defined in DT in order to be
>> > usable(?) Well, if this is the usual way, then it should be well known
>> > by users. Thanks.
>>
>> Yes. We basically have two types of binding wrt to channels.
>> 1) Always there - no explicit binding, but also no way to describe
>>    anything specific about the channels.
>> 2) Subnode per channel with stuff from adc.yaml and anything device
>>    specific.  Only channels that that have a node are enabled.
>>

Hmm... does that mean we implemented it wrong on ad7380 and ad4695?

>> There are a few drivers that for historical reasons support both
>> options with 'no channels' meaning 'all channels'.
> 
> https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/
> 
>> In my experience, the only time we don't populate all available channels
>> on an ADC, even if not used, is in cases like differential chips where
>> any two inputs can be mixed and matched to form a channel. Some of these,
>> like adi,ad7173-8 would have 100s or 1000s of channels if we tried to
>> include all possible channels. In those cases, we make an exception and
>> use a dynamic number of channels based on the devicetree. But for chips
>> that have less than 20 total possible channels or so we've always
>> provided all possible channels to userspace. It makes writing userspace
>> software for a specific chip easier if we can always assume that chip
>> has the same number of channels.
> 
> In any exception to this rule of describing all channels in DT should just avoid using these helpers and do things as they're done now. No one is forced to use them. But I am not really sure why would you not describe all the channels in the device-tree for ICs with less than 20 channels? I'd assume that if the channels are unconditionally usable in the hardware, then they should be in DT as well(?)

I devicetree, I think the tendency is to be less verbose and only add
properties/nodes when there is something that is not the usual case.
Default values are chosen to be the most usual case so we don't have
to write so much in the .dts.

> 
>>> Add couple of helper functions which can be used to retrieve the channel
>>> information from the device node.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
> 
> Yours,
>     -- Matti


