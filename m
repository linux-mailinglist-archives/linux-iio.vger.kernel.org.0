Return-Path: <linux-iio+bounces-24890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69579BCB1C4
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A553A6F0E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B928643C;
	Thu,  9 Oct 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GknBeJOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266E63CB
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049468; cv=none; b=MBq2e7IuHioWA+zZpBzW43iRyVt9xyI8Ouf8m27O6ztd+m7b/S1WR6UbQP719XtoAtn+ItoSq93Pb0lpKXGy1scZ2MHW4yZR4rG+Ih5CB+YmYtl2fdgflibtB6dBmCx66t6ogshfExNYHBqvLYyYPhM/VntqxWLK56b7GKmdbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049468; c=relaxed/simple;
	bh=06Oss/3UIz0tmiG70XcuIAov0LIBCglrwSlpCzass3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUqCRoFxDF3TYGXnlrA4iFmxyNhrNdI5xkizkJeXEtOtEty07nXXHtK8xAfN1JtDpbwNuynU2uCixz0I9DbU3dQ2FJUElqU7T2Z0ioYoub4r34y2JzCcyi0i/vV1W5wsAv5EDProNYEzY4su2bZXpetbIO2Q8hFx2L9qalbm+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GknBeJOb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so1721494a91.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049466; x=1760654266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vSYh0w/N0eKfZDlAE1W3Yr22uU+B6qBWlQxI/RC8Byo=;
        b=GknBeJObumQbIiJUgKS2uhvH57vuhDmyIF7H2F2vClvJe5hcTb8mpdnv2zN6RMmpEe
         1d2e0Lr+z3m/yKDxrICSs7SKqPHAeyOKAhw9CRMvU595JvGg8Uy9xafFfUzzQhtWTrti
         uvYcmeVGInnin0HFeybc2EKkPR+I1vQ9EMPRv4xAYr1yh0J2fxBcokE4wOO4w4mb7Dc0
         XHRvN7b+L6DmVnww+kobQsmLSx2o0/6pvdiKwZejwnahGgBolm4pBKSkmUQuxjs/OIQO
         ZvOBaePQCKkxBSh/U9wdaGPCpeUPSvo1AWYsm8u91RcOe+BXj7Wil54+K7sihX23l9H1
         4JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049466; x=1760654266;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSYh0w/N0eKfZDlAE1W3Yr22uU+B6qBWlQxI/RC8Byo=;
        b=BDY81xI8y84Lbf933dX9b37pmbm3RxmPO2JklKQbLpH+7MNxNPZlc8dutP833rgpga
         AYXrGJxYHy0IlhbNbQiRxyKOR+UooONgl8nsBBdQoN/RkUTf+4ZiUpIWJ/KjXJUTtsAc
         pHslclyyGjsGBZzh0Yf2XgO/Q5j14coZSTGgvNE1JiijjwdOMPaWf7r5AvLY8FBUKXbl
         Ey7ZyYuPRIGofW1Z5KsORFOQuAqV0oOr4+WRy4Hyhs5p448s1FS04jGncmvMFnyBDwK+
         dx/v3FlVnU79cGk8Ua1BzuQteEnTvJwD3WlFnZV1ID/MLUy4kYonvnAH5aNwDTRiFTyu
         bVvg==
X-Forwarded-Encrypted: i=1; AJvYcCXButquuSd47aBPyM4xtIX0UWoPegnvD9AoDgczkfCj3Vs1/PYV1lQV/dS1pNSKOUs331OhcO9sA9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVd9brWiC4onrjD1L40w7rn1kbpLAwnVpMgcwRvWy2KKYizOYe
	CJAd7io+Pe+ZjaQnGw74G5A29cklNgAtqwt6Yak7ahFP8Nl73XiZEAse
X-Gm-Gg: ASbGncs19R1Yg7vLHAvYUT1qnXfM6naYHYQQ/u4C2Vwb2fYPhSgjzJGi9ajR5ITWKJl
	6FM3+H+oLYE6Zc2fG9+DMLAt/V/Jx4gwHqFKd8tgdUbvCYWDysd9c/WPiqxz5FRMNILHh8QfWSX
	QcBu8LHzH9jGEAwxDXQ5K1X/MmfxMaxjtQxGu1bJDLfNhdfylhQb3yHQfJf+JdNBM4+jfLdj7mF
	o1US4z1S82i7WdfUKFe2o/GgPrXvzYan32upU58vnHT43MMN0ctN3O9GM6bxzFcMcmo95Yze5vf
	PHy1zyT6Zz7UIvL+IxgwVC9Jf2j/SjSDQ2HKxVfsezxS71ZdNimRrE65VgB8UPzkIR2oOzPrUia
	Kj2EMT0JO3vBB9GdT3ePpMM4JjgS05cx6jNwwAHyTgVLJ/uKgGi+CshbmXI248p4JSXqbLGsnzU
	tP1xewCH9h2VEsEPNCpbo=
X-Google-Smtp-Source: AGHT+IGog/PneYO0nL24iL7Dc+KdKGYSUtX3kNsDtV2v0Br8doc0KrPg0Zb1nxGl1FCvfJht8YEaig==
X-Received: by 2002:a17:903:37cd:b0:235:e8da:8d1 with SMTP id d9443c01a7336-29027213309mr107072425ad.8.1760049466335;
        Thu, 09 Oct 2025 15:37:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3b85fsm38619155ad.102.2025.10.09.15.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 15:37:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4fd595a-8507-43b7-9390-d819867d7cef@roeck-us.net>
Date: Thu, 9 Oct 2025 15:37:42 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
 P3T175x temperature sensors
To: Lakshay Piplani <lakshay.piplani@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
 <andy@kernel.org>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "jstephan@baylibre.com" <jstephan@baylibre.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
 Vikash Bansal <vikash.bansal@nxp.com>, Priyanka Jain
 <priyanka.jain@nxp.com>,
 Shashank Rebbapragada <shashank.rebbapragada@nxp.com>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
 <96f5443f-5b40-4d05-b350-78d55a1d841d@roeck-us.net>
 <AS4PR04MB9362FDA1FE35AD06C99B85E3FBEEA@AS4PR04MB9362.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <AS4PR04MB9362FDA1FE35AD06C99B85E3FBEEA@AS4PR04MB9362.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 22:56, Lakshay Piplani wrote:
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Wednesday, October 8, 2025 7:41 PM
>> To: Lakshay Piplani <lakshay.piplani@nxp.com>; linux-kernel@vger.kernel.org;
>> linux-iio@vger.kernel.org; jic23@kernel.org; dlechner@baylibre.com;
>> nuno.sa@analog.com; andy@kernel.org; marcelo.schmitt1@gmail.com;
>> gregkh@linuxfoundation.org; viro@zeniv.linux.org.uk; peterz@infradead.org;
>> jstephan@baylibre.com; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; devicetree@vger.kernel.org
>> Cc: jdelvare@suse.com; Vikash Bansal <vikash.bansal@nxp.com>; Priyanka
>> Jain <priyanka.jain@nxp.com>; Shashank Rebbapragada
>> <shashank.rebbapragada@nxp.com>
>> Subject: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
>> P3T175x temperature sensors
>>
>> [You don't often get email from linux@roeck-us.net. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 10/8/25 03:07, Lakshay Piplani wrote:
>>> This patch adds support for the P3T1750/P3T1755 temperature sensors
>> under the IIO subsystem.
>>>
>>> P3T1750/P3T1755 support two operational modes:
>>> 1. Comparator Mode
>>> 2. Interrupt (Latched) Mode
>>>
>>> The HWMON subsystem is more suitable for implementing drivers for
>> comparator mode operations.
>>> Reason:
>>>     - Temperature thresholds can be polled and exposed via sysfs.
>>>     - Register reads do not clear status, allowing safe alarm state derivation.
>>>     - Matches existing drivers under hwmon.
>>>
>>> The IIO subsystem is more suitable for implementing drivers for interrupt
>> (latched) mode operations.
>>> Reason:
>>>     - Interrupt mode uses edge-triggered ALERT/IBI signal interrupts, which
>> can be pushed to user space using iio_push_event.
>>>     - IIO's event API (IIO_EV_TYPE_THRESH) supports timestamped
>> rising/falling edge events.
>>>     - I3C IBI integration maps naturally to IIO's event push model.
>>>     - No persistent alarm bits are available; so polling in HWMON may result in
>> missing events.
>>>
>>
>> This is just wrong. Interrupt support can just as well be implemented in a
>> hwmon driver.
>>
>> Guenter
> 
> Hi Guenter,
> 
> Thanks - agreed, hwmon drivers can support interrupts.
> The distinction I meant to highlight is about semantic alignment.
> Both P3T1750 and P3T1755 does not provide alarm/status bits. In TM=1 (interrupt mode), the alert is latched
> but cleared on register read, with no way to query alarm state afterward.
> 
> HWMON typically polls alarm flags via IRQs, expecting them to remain asserted during threshold violations.
> Without persistent bits, supporting interrupts in hwmon would require emulating state in software, which diverges

So ? Various drivers already do that. It is not even necessary to "emulate
the state in software". Just store the state in the interrupt handler, and
report (and clear) the state when the alarm file(s) are read.

> from its ABI and could mislead userspace expecting stable *_alarm files.

This is just incorrect.

> IIO's event API, being edge-triggered and timestamped, aligns more naturally with
> this transient behavior and with I3C IBI signaling.
> 
> I'll reword the cover letter to clarify that this is a design choice based on ABI semantics, not a limitation of hwmon.

Again, that design choice is not a reason to have two drivers for the same chip.

Guenter


