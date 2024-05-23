Return-Path: <linux-iio+bounces-5222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF038CD6A7
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F861F21CC0
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FDB657;
	Thu, 23 May 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lin99rP/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB89B645
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476755; cv=none; b=Xl84QMqJCxRbSC4LDaXkCV/XoGN3yISWn9MAMwAvPX72NqmFVSDo5pG4KlMzRd7KobSDa+smbAdqUWKKRXhP42mbaqfWaBb8RLs7NlHizh5MNkY1jR22bMMsMbnLvqeJVdA86gJCopDLFPdyv6zvButtGeK3WeNEtwMHbyCOKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476755; c=relaxed/simple;
	bh=iFvjg3XwqgAd5mquwOsqr45UsDV9LIRXN1unBZnpmoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbiW3CXg+MS+M++qVjDfw4aeEwqHWAmla9nOVIkz36jGUlWSNzBz9X+4x6Jx/TRGnBhA2W6HkAno/BQv3aEsTk/5gS6c+TytkjxixxotDM/H+zOa9F5zFpXAKWu36lffOyn4O4CGUA0ytHf+sxXMxZFcyf81Jnkg5ynhgLqmnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lin99rP/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7948b50225bso192459485a.3
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716476752; x=1717081552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uSp7T4uhgPczizgXTB01VF3ORzzoQszdtOdi980zfE=;
        b=lin99rP/0ByqQJCyO08MenEqr3FpNvBU8YPXeNNSNIOor0k5QEaWV1toMWwlWRevR7
         MPmPrO7qWWi63Zeb2xqvTysTlKjogAWuC9xLVB0StesuwYCopBs4l+XHlajZO6rB477L
         ZFtsxpJdZ8kUANeSf6JqkjnzW85jSBZjPoymxha8cA6tBtYHW6GtE/8Ppmg1MTlRUTTG
         Fdu/0/v54iA9ztpqfV7JXiYUhzc1c0AfT6NoqbzZKtGsubckG2gOKltG2x9FYmpQQ1bt
         IiQJ/aRMY938i19afEwanSQUF+BfTca+duig08mR8hI7b5x6UTS0/xrfcBLx40RRBtf6
         SvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476752; x=1717081552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uSp7T4uhgPczizgXTB01VF3ORzzoQszdtOdi980zfE=;
        b=KmULdrHHrgNVQabfIBZ9hw9oiv7vVm8ioZIfDoaxMwaIw5Yj9TYORPdCkgZBd1+iA9
         Fu1PVg4e53Q06gL0w9tfN79tAqzbD0AdmjmzQU2nWljw7PG1mfessFeGZ08Pn9bREzdK
         hYnywlmesPTXpFd+oUnTOGnGmFRbJ/l6oCa9BRsS6NFZgi/07FsBYCvxFn6/hIdf++p0
         dwZl04YQ2fOZuVsSzEs6rGbsYDo5wOD6HkEofZwVLB/wV3rbibzSS4bZGsJ7+zik0jaN
         Rd8tcEHwadYprdQ7LohS53x/oPCEZPj1jIfQ/26nGhy+9tNsgNtGtTjEy77Q0NMdKFx+
         i8hg==
X-Forwarded-Encrypted: i=1; AJvYcCXjYXjyfBg3gHwLbni/gdbwzcqJ3sImaWAZlxMv80AL6+6GvgwmA12kQGgh0cxUSu5UmgJxyb3zL5GS2kfrX5AsmVeAKzUQKysE
X-Gm-Message-State: AOJu0YyFumuTiHSCPGMuvEUxooONYZebu3k3szDT/9W66QIvSlZPItkG
	jJdewbaqFDi65qTZHODGHIe5FKTEsiF5a8Dwk8g6PJoNAbtX3uw7wLA1ITo/R+c=
X-Google-Smtp-Source: AGHT+IFsJ0Oht2KlIbxxejxL7QWFjMQWA52PIkChCCprQ7JsH2aiXe/Gm3y4+GYbUmrclCuE5eihyw==
X-Received: by 2002:a05:620a:5645:b0:794:8226:710c with SMTP id af79cd13be357-794994ced65mr523642085a.70.1716476752171;
        Thu, 23 May 2024 08:05:52 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf1cd143sm1500017385a.0.2024.05.23.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:05:51 -0700 (PDT)
Message-ID: <6e929426-25fa-4e91-8790-0774d59b34e0@baylibre.com>
Date: Thu, 23 May 2024 10:05:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/24 7:15 AM, Nuno Sá wrote:
> On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
>> On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
>>> On Sun, May 19, 2024 at 7:53 AM Conor Dooley <conor@kernel.org> wrote:
>>>>
>>>> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
>>>>> On Thu, May 16, 2024 at 4:32 PM Conor Dooley <conor@kernel.org> wrote:
>>>>>> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
>>>>

...

>> To remind myself, "Application 2" featured an offload engine designed
>> specifically to work with a particular data format that would strip a
>> CRC byte and check the validity of the data stream.
>>
> 
> I think the data manipulation is not really a property of the engine. Typically data
> going out of the offload engine goes into another "data reorder" block that is pure
> HW.
> 
>> I think you're right something like that is a stretch to say that that
>> is a feature of the SPI controller - but I still don't believe that
>> modelling it as part of the ADC is correct. I don't fully understand the
>> io-backends and how they work yet, but the features you describe there
>> seem like something that should/could be modelled as one, with its own
>> node and compatible etc. Describing custom RTL stuff ain't always
>> strightforward, but the stuff from Analog is versioned and documented
>> etc so it shouldn't be quite that hard.
>>
> 
> Putting this in io-backends is likely a stretch but one thing to add is that the
> peripheral is always (I think) kind of the consumer of the resources. Taking the
> trigger (PWM) as an example and even when it is directly connected with the offload
> block, the peripheral still needs to know about it. Think of sampling frequency...
> The period of the trigger signal is strictly connected with the sampling frequency of
> the peripheral for example. So I see 2 things:
> 
> 1) Enabling/Disabling the trigger could be easily done from the peripheral even with
> the resource in the spi engine. I think David already has some code in the series
> that would make this trivial and so having the property in the spi controller brings
> no added complexity.
> 
> 2) Controlling things like the trigger period/sample_rate. This could be harder to do
> over SPI (or making it generic enough) so we would still need to have the same
> property on the peripheral (even if not directly connected to it). I kind of agree
> with David that having the property both in the peripheral and controller is a bit
> weird.
> 
> And the DMA block is a complete different story. Sharing that data back with the
> peripheral driver (in this case, the IIO subsystem) would be very interesting at the
> very least. Note that the DMA block is not really something that is part of the
> controller nor the offload block. It is an external block that gets the data coming
> out of the offload engine (or the data reorder block). In IIO, we already have a DMA
> buffer interface so users of the peripheral can get the data without any intervention
> of the driver (on the data). We "just" enable buffering and then everything happens
> on HW and userspace can start requesting data. If we are going to attach the DMA in
> the controller, I have no idea how we can handle it. Moreover, the offload it's
> really just a way of replaying the same spi transfer over and over and that happens
> in HW so I'm not sure how we could "integrate" that with dmaengine.
> 
> But maybe I'm overlooking things... And thinking more in how this can be done in SW
> rather than what makes sense from an HW perspective.
> 
> 
>> continuation:
>> If offload engines have their own register region in the memory map,
> 
> 
> Don't think it has it's own register region... David?

I think the question here was if the CRC checker IP block (or descrambler shown
in the link below, or whatever) had registers in the offload/SPI controller
to control that extra part or if they had their own dedicated registers. So far,
these have been fixed-purpose, so have no registers at all. But I could see
needing a register, e.g. for turning it on or off. In this case, I think it
does become something like an io-backend. Or would we add this on/off switch
to the AXI SPI Engine registers?

Also, as shown in the link below, the extra bits share a clock domain with the
AXI SPI Engine. So, yes, technically I suppose they could/should? be independent
consumers of the same clock like Conor suggests below. It does seems kind of
goofy if we have to write a driver just to turn on a clock that is already
guaranteed to be on though.

> 
>> their own resources (the RTL is gonna need at the very least a clock)
>> and potentially also provide other services (like acting as an
>> io-backend type device that pre-processes data) it doesn't sound like
>> either the controller or peripheral nodes are the right place for these
>> properties. And uh, spi-offloads gets a phandle once more...
>>
> 
> But then it would be valid for both peripheral and controller to reference that
> phandle right (and get the resources of interest)?
> 
> FWIW, maybe look at the below usecase. It has some block diagrams that may be helpful
> to you:
> 
> https://wiki.analog.com/resources/eval/user-guides/ad463x/hdl
> 
> - Nuno Sá
> 
> 


