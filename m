Return-Path: <linux-iio+bounces-25713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6692C22962
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 23:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4947B1A6160E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F633BBBC;
	Thu, 30 Oct 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eDQ5Qf7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742533BBA6
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864168; cv=none; b=D/zaUxsKigD1mZ/+bFNHc8MW6HW0noAacFDHJj82qnhsNm8gPUAAYIZ6yG4XOh0yo67r5CwCL+CdXbwMg2kmZBDTEVHI0CnWwmllPIM615N4ZNWyjNj+rpaClM66N+3syjxhbnRI8JWs6rbnGXGjBQFbc2nR2rl/0eJrVMBC3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864168; c=relaxed/simple;
	bh=9it6XLZdXae3RoTGHdsFpj66tzk86QiotM3zNBihiP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4kUJtxGmyjWBd1cUVPm0QoJ71SC15OxqEAabin/vdNxYOP+Lr436DuNZ9cOmj+NXbibkLuKQ5UQP4Bq7ROXDP9OVUEaJrtjQ1Sw3STbXJ5Ud3FM07x2Hz1eZfnikjx1MohaSHVrlBKVaQ+29Jo5b5OsTS53+E9DBTF/ky84Ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eDQ5Qf7J; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c5333e7033so609814a34.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761864166; x=1762468966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0HTAhQNYbWjGFi7/HeEAEeE9+brZM+DQRBAXbw9JCU=;
        b=eDQ5Qf7J5GvGDEx57LiV1CpbUE+9lQMIWcyGIiuTVkl6bY7fOMCDuG1b7rXJRduRBM
         3L63HyHbqJyF/QqNHrk5VB4jOCNbwiNRkvh79nPKauY6i3Xy3e96mwizL7rPpsitjHaE
         Th0OcvSuI98MmO8sF6ejghxau1AniuC4Ak/IYgYuyG8GgLDA9pEC8MmPxlSiuiHbL9/a
         Wg3z3uqcv6Upna8cAyfQ/fI0cWrZ2zcuFuFMjCHI9zVppPZ+PcNul4kz/sRHuG0gf28C
         qQ7EuuROSM11S2k24JhfuxB2eXHh6gNhCo8VUch99eTw1uTQPM94t6y6BRS6lbopkB4h
         Hkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761864166; x=1762468966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0HTAhQNYbWjGFi7/HeEAEeE9+brZM+DQRBAXbw9JCU=;
        b=lEiV4ipG5JcPjAOLTqQ4Uf6qzH7uk+/Pz9G6ayx2KmKinOgvm006+g39EXDwnPEMzL
         yMCefYhl5vw02DDBLVnytUuFxZvYWLEgTQG7eGZumqhLbsK2QfOGgW0qbkqqwziV9S+4
         kKOJ458N+r1DiO1LX4iZmmbfbIgjwWF13exuhVtse9+wr/pTXvKcGg5Rq9+v7Dhn0/ed
         /oqxzoi+lokfGVuzikXy/XH0Ksvi2b0UslJ85Tw51k4fDsmLrnZVcBM75D7HRTY9fmAN
         2Kj2hZbJcYTunqnDghiIynDKw99gpffIbyoA8hhliIS6auP0lUY2ZCu65QxHQAoW8Lab
         kr/A==
X-Forwarded-Encrypted: i=1; AJvYcCV1zY1SSCHNy7Gslju1NJS7I/E7ToP5fRmbwiaxqGWAJhpcvmSpYUntouzDbzkYL6H9UHHom8B1Qdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovNVtTvNmR4ZCQY/pRoRXDVXmsapu3GkwKLPxkLzWTvegAPt3
	GLnu6OVu9YiQEWDpnaJxOlZaE1rYoEPccj4N3oGyCgZ6RcqF10Y/SojHh8Pg/stMP7c=
X-Gm-Gg: ASbGncvd+Bzp/22TzR5i3vuRPgj8DJLchbfhyQrSNtoxS6MdGwNbDi5xU0/ztiC5Qxi
	EGGbozievbZLw5Y6z0jgyyCNqXiaufLttEj+vcut8FJTbOy3srSWXp+QNM8sDqvIKpgIu3MJq3j
	kAgSszKHgb6prn5gyU1NBOAvpSCQL2LgSPmMBRth1rrifnRnNOspCkJGIjrqQZYOjOnCzgiVKau
	GUy1XumN884V7CBoQutan9I70z0LKzMcKv0wF7YTNnubum6uu6VNMOZSiN7+7xOtbt7EpCBb+7R
	cXsNvXQeZG7gaLBmgF0osJK+Ty7li5CMR/+NfLfGVkr1Y33F6QFD6I9FT8xUYs1jk8jh2iFg7N2
	xoBQHXHq/uAO0KYrGEGUMfojYKNFlusEBeBRuDH73VnfouD4buHTJLvyqx+y8X5GS+i02eNU355
	RjK8Jx4FMIg0fFojez7uvZ/hTgarfebUF5EM9c+bA8OQ9tQQYU0w==
X-Google-Smtp-Source: AGHT+IFygVcKrCt8dVyx7K2d1dIpysOgPE+1OoIdRWbtjGAosZSMsYYLHZhJRI76gQOSql4L5yVCHA==
X-Received: by 2002:a05:6830:448f:b0:7b9:4dd5:1963 with SMTP id 46e09a7af769-7c6967b2d0bmr844138a34.24.1761864165644;
        Thu, 30 Oct 2025 15:42:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:aa90:4f8c:bf59:360a? ([2600:8803:e7e4:500:aa90:4f8c:bf59:360a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c699bde239sm44364a34.5.2025.10.30.15.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 15:42:45 -0700 (PDT)
Message-ID: <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
Date: Thu, 30 Oct 2025 17:42:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
 <20251030135126.GA3749313-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251030135126.GA3749313-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 8:51 AM, Rob Herring wrote:
> On Tue, Oct 21, 2025 at 09:59:22AM -0500, David Lechner wrote:
>> On 10/21/25 9:21 AM, Rob Herring wrote:
>>> On Tue, Oct 14, 2025 at 05:02:11PM -0500, David Lechner wrote:
>>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>>> specifying the SPI data bus or buses that a peripheral is connected to
>>>> in cases where the SPI controller has more than one physical SPI data
>>>> bus.
>>>
>>> Is there a reason why spi-rx-bus-width property doesn't work for you? 
>>> The only thing I see would be you need to define the order of the pins 
>>> like "data-lanes" property.
>>>
>>> Rob
>>
>> Because we can have both at the same time. In one of the other threads,
>> we talked about the AD4630 ADC that will require this since it has 2 data
>> buses each with a width of 4 (total of 8 lines).
>>
>> See: https://lore.kernel.org/linux-iio/ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com/
> 
> But it can't really be 2 independent buses/controllers unless the ADC 
> has 2 completely independent interfaces, right?

Correct.

The proposed property really only concerns the data lines (tx/rx). It doesn't
care if there is 1 or 2 SCLK lines and it doesn't care if there is only 1 CS
line.

So maybe spi-data-buses would be a better name for the property? Or
spi-data-ports (using the NXP FlexSPI controller docs terminology)?
Or spi-data-channels?

> Surely the clock is shared across the 2 buses? 

It depends on the mode of operation. In stripe or mirror mode, both
clocks would be synchronized/identical. It doesn't matter if there is
1 or two clock lines in these modes. And only one CS line is needed
in these modes - but 2 also works - these properties are independent.

It could also be used in a way where each data bus is used independently
(one at a time rather than both at the same time). In this case, it could
still work with one SCLK line as long as there were two CS lines. But if
there are two SCLK lines, then each one could operate independently in this
mode.

> So aren't you really just borrowing pins and the fifo of the 2nd controller? 

Yes, I think that is a valid way of thinking about it.

> That seems pretty controller specific to support that. 

Correct. This property could only be used with such controllers.

> For example, how would you support this with spi-gpio 

We would need to increase maxItems of several of the gpios properties.

sck-gpios could be multiple gpios to allow for more than one SCLK
line.

miso-gpios would contain spi-rx-bus-width * ARRAY_SIZE(spi-buses)
gpio phandles. mosi-gpios would be similar with tx instead of rx.

> (obviously kind of pointless given the bandwidth needs with 8 data 
> lines) or any 2 independent instances of SPI controllers?

Doing this with two separate controllers wouldn't work for cases
where only one SCLK line is wired up - unless it was a controller
that supported a peripheral-provided clock, then it might.

Performance wouldn't be great in this case either though, so I
don't expect that anyone would be tempted to do this.

To implement this, I would make a new SPI controller node that
takes the phandles of two or more SPI controllers. The peripheral
child nodes would be in this new controller node and the other
two controller nodes would not have any child nodes.

It might need some extra properties to say which data and clock
lines are actually wired up similar to the spi-gpio.

> 
> Rob



