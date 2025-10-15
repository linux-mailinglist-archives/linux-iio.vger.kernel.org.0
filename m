Return-Path: <linux-iio+bounces-25111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DABE036F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D31584F9841
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2C2275864;
	Wed, 15 Oct 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gJqaZnRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA7325495
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553534; cv=none; b=T9zYwHxaNr0bB1/bmItZF56X0Wrkh3oFzN8Daw1iRjj634Mm8FY2vhSf2Q07HD6+8R8OHQbE87YumDL4k7CRXMALpzzeNIC+9vl5mpwlbweT8nnhcPSZWdDrT2lLi3OlQpCWJB9OYrne9mtTsXrgASoFV8aMUDRYl7y8+7VlQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553534; c=relaxed/simple;
	bh=A6ABvce90CoOKfZJ1YRD55sJ0SyCGKbP1stpO6hQahU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2H8Put9Hm5sif8sRQZh0Vor5jXHHXRb5U8Ibork4FSnprh7LiRctTcYPM9JjT7RUizUHJwBratLrffjC5ZVCL65rOrtVn+QTGpc221KQT/6kVClvIoT5GVMyCIwL6xG5DoOnNsUHxgyHlv+U2uw0vFMGvIipFbJM5StXcFFric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gJqaZnRI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-79d36a6298dso2380864a34.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760553532; x=1761158332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7Pa/1BHqYMBhXpBmEF4fAbsSTM4OPfXzGQjsT1agWg=;
        b=gJqaZnRIpydAa/IzHDREMVj5BjSuQEBbP02U5YPr3hlm2gzIik5Xjf1Qfgmqy3Hngb
         2nUYB43nLix6Hek5MChzxeJ1EGFUw4awYDla/+ex3mXjLmB9LgUyXRgvaIYBgDm2ksj8
         5guWBE8pkaBWIX5NDYjEZbYpQ2HiooPl+OSgrOq3EEc0qW+Ews6keSypV3OuMRffHJsK
         bK/ibcpaiAKn8RVFU9NFWeZ4Nqs7JzWI4e2eqA+kY2x0pI1tCK7yGRe/byddy9MI/m8/
         G6wHBzbkMQJtu+l/SQiqwaF+jkd9afzuNpJoK/AvYUTz47c45HzubofxhCxLHXKXxoYt
         QZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553532; x=1761158332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7Pa/1BHqYMBhXpBmEF4fAbsSTM4OPfXzGQjsT1agWg=;
        b=E6KtvwP6gOy2fdlJ8ubiNTZ8FF8y3K0XRXBv6CvECHIBhzq9oey9DWnJ0LEEwhW7FC
         u3kS/ZrlFdImVTAbEawJtjyYaruTpb79v4MzFJH2hfWT+h1uVEwsW5N8NE0raM0mDx+q
         VEt57qwbPAJPSeFuVWzpUjeBmgKWz9UnJtOYsjgmA1Kj8mXdBCdYXQhga57JHAhiNV2k
         x8vXCGCOicPSC4c3hQG900Wv/5SOnvI/3CHpzb6HpAJGl7yfNECWPYbWJ8PJgPI0T/d7
         dvP/Y91jkV/LLTK93qSQx7hJ6hHJnLiYvj0btLM6rLiXcGNt94rftUP/JWXKv2y3bjCC
         r1MA==
X-Forwarded-Encrypted: i=1; AJvYcCU+itbnDYExu4tyIK998/X3bo0ObSDvC+pta+6Q9GltDhK6RjMmwS0QsRXWuRM2/Dhm+/46/K1c0HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2fUC6a/J2J0fShFmxqTjmAmHWwtJWZH7xcc/A8eziy6tBv7n
	WHPj3cQSR4Ln9zxL1stdxeBppq//AxzL3KqfV0U5Pxa43jx2SptWzTCCxZqPHV6Ih9c=
X-Gm-Gg: ASbGncudOsNC2F8UZPjh3zYN+BaEUrHZ17+kkzUlUtpWPXlMXdsHFHpfEK5pYx1wkY/
	IdihxcI0Q1qiRLmzpzYfv1ytIjyj0wWo0HilUHstUQGxcIX6S1ZNvcTwhLB4MsXIgBsNiTP3VqD
	dbg4ncdv0Hb+K2GFgE6RlI+iKWyfoxuiQXLZrv0fjYKyCi2zAlrKFEN+xV+lwu4Lhej3JLRPB3o
	MAKlrm1gEQ7pulhelvi07ltoNbhzUZVak337jEi9/lwCoEdydOIHwlmY3VoaKWuVPEIPH+CB3UA
	iV6UvLwiSLoFgDWbuDtFpDLVOA3+spRvKg3MzTuNy+YXpJ4mpif/85uuEDejg78sUah24hkRRx+
	056S4fU8fSr0AThQ0SxEzY0E4MbTc6/oVeRzoPpFZfxhCtl9UjczNGlDyzUU6SS5napeA2zoohL
	gPKKyXuD4hANT5U+ommDaWdKAARQok1h8yjX9T
X-Google-Smtp-Source: AGHT+IFUFKcADmzsj/IXf4M39Ln3t08RBAMcgnpJ1VX0iX7hN5yNIgTZRlo50r/4Kc/y5Zljp8pqkw==
X-Received: by 2002:a05:6808:50a7:b0:43f:a2eb:861f with SMTP id 5614622812f47-4417b2bbcbfmr13447346b6e.8.1760553532023;
        Wed, 15 Oct 2025 11:38:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90510a2sm5533725a34.2.2025.10.15.11.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:38:51 -0700 (PDT)
Message-ID: <ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com>
Date: Wed, 15 Oct 2025 13:38:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
 <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
 <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 11:43 AM, Nuno Sá wrote:
> On Wed, 2025-10-15 at 11:15 -0500, David Lechner wrote:
>> On 10/15/25 10:18 AM, Mark Brown wrote:
>>> On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno Sá wrote:
>>>> On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
>>>>> On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno Sá wrote:
>>>>>> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
>>>
>>>>>>>         controller    < data bits <     peripheral
>>>>>>>         ----------   ----------------   ----------
>>>>>>>             SDI 0    0-0-0-1-0-0-0-1    SDO 0
>>>>>>>             SDI 1    1-0-0-0-1-0-0-0    SDO 1
>>>
>>>>>> Out of curiosity, how does this work for devices like AD4030 where the same
>>>>>> word
>>
>> The AD4030 is just one channel, so doesn't do interleaving. But you probably
>> meant AD4630 when it is wired up with only 1 SDO line. That line has to be shared
>> by both of the simultaneous converters so it alternates between sending one bit
>> from each word. This patch series doesn't address that case. But this series will
>> work for the AD4630 when it has 2 SDO lines wired up.
>>
> 
> Hmm I didn't even remembered that one. But what I meant with interleaved was having
> the same data word spread through multiple SDO lines (one bit per line) which is what
> (also) happens with the devices I mentioned. And since you mentioned "...two
> different data words at the same time, one on each bus...", I raised the question.

Ah, yes, I know what you are talking about now. I didn't mention that use case in
the cover letter because I didn't want to confuse things. But actually the AD4630
can have 8 SDO lines, 4 per each data bus/ADC channel. The groups of 4 act like a
quad SPI where 4 bits of one data word are sent at the same time. Those 4 lines are
considered one "bus" since they are all connected to the same serialzer that combines
the bits into a single word. We already have support for this sort of thing in Linux.
And sure, we could mix the two together. So a SPI transfer might look like:

struct spi_transfer example = {
	rx_buf = rx_buf;
	len = 4; /* 2 x 16-bit words */
	rx_nbits = 4; /* each bus is quad SPI */
	multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE; /* 2 data buses */
	bits_per_word = 16;
};

This would result in a transfer that reads two 16-bit words in 4 SCLK cycles.

And the .dts would look like:

spi {
	adc@0 {
		compatible = "adi,ad4630-16";
		reg = <0>;
		...
		spi-rx-bus-width = <4>;
		spi-buses = <2>;
		...
	};
};

The AXI SPI Engine doesn't know how to do the quad SPI part yet though, so
it isn't something we could implement right now.

If we tried to do it with spi-buses = <8>; then we would end up with the
"interleaved" bits (or nibbles depending on the wiring) that requires the
extra IP block to sort out when using SPI offloading. Technically, we could
make it work, but it would require a bunch of extra hardware description that
the driver would have to interpret in order to correctly format the struct
spi_transfer. I was hoping we could avoid that and just teach the SPI Engine
how to do dual/quad SPI like other SPI controllers.

> 
> So I guess I kind of misused what interleaved typically means (even though I guess
> it's not completely off :)) and was thinking more on the parallel concept Mark spoke
> about.
> 
> Anyways, from your reply I see the intent is to also use the stripe mode for this and
> have some kind of external IP deal with data re-order. I gave a look into the ad4630
> IP core and indeed there's a data reorder IP block after the offload engine.
> 
> - Nuno Sá
> 
>>>>>


