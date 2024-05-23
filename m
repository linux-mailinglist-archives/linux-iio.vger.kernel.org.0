Return-Path: <linux-iio+bounces-5219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613348CD5C4
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB791F22109
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779314E2C2;
	Thu, 23 May 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QcgUb3hm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DE14D29C
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474539; cv=none; b=tJzazR2bsF4T2O6w29nEH7bD4yE8tgznlwMr3ZfTXH24E2wh18DxYfKJw0OcNmcMeaybqWacr3spvyQEHqxb6eOPngYu83wWP+qlFEzov1fXZ+ElKpRv+1m2SaayQKubA532OWIPlNlg7esugDuvqtuudgHcT+5Ife5dR5rxQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474539; c=relaxed/simple;
	bh=zaeMrFY2WEalSntOcIU1Zi30vA/q91IKHU5hWjxbg1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd772WyiqvPdl7qhBkGD0aFX0ofK55MJjXHIYtpfLtayMLH8uoH9MfZFoDMzbMDH5R1N5US5iY/94zUNJDE6sNldJsvlMnWKhaKBok/H19QdwMcRgnKwv7M0yjt3wAZ7iBRsEwGtQ8Dsh0HSIas8In3Dxks8CMurjwINHBqyYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QcgUb3hm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f12171523eso3449779a34.1
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716474537; x=1717079337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rSMKPqlVmyB8QJzbwpvKr56z/Yxr4Zld0KaM7W8/ao=;
        b=QcgUb3hmBdvwMxhND8tTznaGcqEcoC4y2gb7b46F7qSbQd/lcAGrMjt0xwhd9qhO5C
         do3WRUz/yfXWRNxjc48tJdpjux27ckS6k3eRpKHvoiFPknWWxVjWKwXBYAaGOmQvqaAh
         KlLu7xicKpEHbRWq2R5BNcGjaSSrKU+xbHaP269VVpTaGeXXKBNHATgs9Ua4xQWy2TRb
         tYXsMjAX+dr8ngFa+ALCAUJYOw8Ho3LmpvQGps0HH/r/63OccxqwI4FHK5XGDZRwLE5s
         9e8I1gKgAvwAuGEgFaEVQDNO5Z/lqwJjGOXnHuHcl9wGfVzCibGT5SXcxlY++JQUIq24
         zhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474537; x=1717079337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rSMKPqlVmyB8QJzbwpvKr56z/Yxr4Zld0KaM7W8/ao=;
        b=kctoD3LowxBQ9/aZvVYWSdDd4EE6EbdKBu3N8Pf69RlUzmOVcjV0PMAg2oeJJO9rdd
         zJOsbGYKFm926dn9gqR9UJIOLdIxVycyo8QvlhgjxT2KyzHTfmzliUogZjMM3HkvQO11
         PXVwhG298bSr4f5PCs+euYS6eC05qfV0OZsFJ4S+AQJD3Mf5n69jwtvRYx+klVcYw+Nn
         +jRPC/WPMtZLoEYv8eziHtU+K+qarNApEwsC98OCfEDNQFRpHw5UPDueYRWdZ3/f81ii
         r0IGRKJdTQr8fuHy5e6AQcjsTDZjSapZL0ikWC/+OO9IJRUjAqjbE5+LYSRre85vot7d
         hjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDY3J7Gx611pbiqDfCv5pyEhWe6xZNtwN617l4XAYd0wU4+vHwJaCvavRYIHvgKAowU0Wn58hPfvkx1quBQGYIhdIyhIk5acOC
X-Gm-Message-State: AOJu0YzWs+L7LDO9V4aqY28NvQaSxHODHZZkesKGtV3qpKX1H4+0l+pv
	pPY4U8dnZHStkX2LI6w4/84tWECw2ghNqp1gmpBEohzxfC82ftRzZ/L+GaD78/4=
X-Google-Smtp-Source: AGHT+IEmnlTOuI97MwBndYJ3jehFfvs/fsHkM0Y7ReJssf8Wlf+3CQIb09ick1EQmGSi0NWqMlZKdQ==
X-Received: by 2002:a05:6871:330a:b0:24c:5e82:1b59 with SMTP id 586e51a60fabf-24c68bac5b1mr5650043fac.1.1716474536651;
        Thu, 23 May 2024 07:28:56 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0f785b6eesm4586461a34.9.2024.05.23.07.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:28:55 -0700 (PDT)
Message-ID: <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
Date: Thu, 23 May 2024 09:28:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: Conor Dooley <conor@kernel.org>
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/24 1:24 PM, Conor Dooley wrote:
> On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
>> On Sun, May 19, 2024 at 7:53 AM Conor Dooley <conor@kernel.org> wrote:
>>>
>>> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
>>>> On Thu, May 16, 2024 at 4:32 PM Conor Dooley <conor@kernel.org> wrote:
>>>>> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
>>>

...

>> This time, the periodic trigger (PWM) is connected to the pin on the
>> ADC that triggers a sample conversion (CNV). The ADC has a BUSY output
>> that will go high at the start of the conversion and go low at the end
>> of the conversion. The BUSY output of the ADC is wired as the hardware
>> trigger input of the offload.
>>
>> In this case would we still consider the PWM as part of the SPI
>> controller/offload since it can only be used in conjunction with the
>> SPI offload? It isn't connected to it at all though.
> 
> No, in this case the ADC is a PWM consumer and the offload engine is
> not. The ADC is a "trigger" provider and the SPI offload engine is a
> trigger consumer.

Makes sense.

...


> 
>>> In fact, looking at the documentation for the "spi engine" some more, I
>>> am even less convinced that the right place for describing the offload is
>>> the peripheral as I (finally?) noticed that the registers for the offload
>>> engine are mapped directly into the "spi engine"'s memory map, rather than
>>> it being a entirely separate IP in the FPGA fabric.
>>
>> True, but we don't use these registers, e.g., to configure the
>> sampling frequency of a trigger (if it can even be done). That is done
>> in a completely separate IP block with it's own registers.
> 
> Where is the binding for that IP block? I think describing that is
> pretty key. goto continuation;

For the real-world case I used to test this series, it is an AXI PWMGEN
[1] that is providing the trigger event source. It has a typical PWM
provider binding with #pwm-cells [2].

Calling this a "trigger" provider to the SPI offload instance just like the
case above where the ADC is directly connected as the offload trigger makes
sense to me.

What I was going for in this patch (slightly revised to use #cells) is that
this trigger provider, whatever it is, is selected by one of the cells of
#spi-offload-cells. It doesn't seem like there should be a special case for
if the trigger provider is a clock or PWM where the SPI controller node
becomes a consumer of the clock or PWM provider rather than just describing
the trigger relationship.

For example, supposing we had an FPGA/HDL that could handle all 3 wiring
configurations we have discussed so far. A) PWM connected directly to SPI
offload as trigger, B) PWM connected to CNV of ADC and BSY of ADC connected
to SPI offload as trigger, C) self clocked ADC with RDY of ADC connected
to SPI offload as trigger. So the DT would have:

controller:
#spi-offload-cells = <2>: /* 1st cell = offload instance
                           * 2nd cell = trigger provider */

peripheral (choose one based on actual wiring):
spi-offloads = <0 0>; /* case A */
spi-offloads = <0 1>; /* case B */
spi-offloads = <0 2>; /* case C */


As to what is the actual consumer of the PWM provider in each of these
cases...

* C is easy. There isn't a PWM provider since the ADC is self-clocked.
* B, as discussed elsewhere is fairly straight forward. The ADC node is
  the consumer since the PWM is connected directly to the ADC.
* A is the one we need to figure out. I'm proposing that the PWM consumer
  should be whatever kind of composite device node we come up with that
  also solves the issue described below about where does the CRC checker
  (or whatever) go. I think we are in agreement here at least on the point
  that it doesn't belong in the SPI controller node?

[1]: http://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
[2]: https://lore.kernel.org/linux-pwm/20240424125850.4189116-2-tgamblin@baylibre.com/



> 
> I think you're right something like that is a stretch to say that that
> is a feature of the SPI controller - but I still don't believe that
> modelling it as part of the ADC is correct. I don't fully understand the
> io-backends and how they work yet, but the features you describe there
> seem like something that should/could be modelled as one, with its own
> node and compatible etc. Describing custom RTL stuff ain't always
> strightforward, but the stuff from Analog is versioned and documented
> etc so it shouldn't be quite that hard.
> 
> continuation:
> If offload engines have their own register region in the memory map,
> their own resources (the RTL is gonna need at the very least a clock)
> and potentially also provide other services (like acting as an
> io-backend type device that pre-processes data) it doesn't sound like
> either the controller or peripheral nodes are the right place for these
> properties. And uh, spi-offloads gets a phandle once more...
> 

