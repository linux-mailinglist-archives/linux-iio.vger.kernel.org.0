Return-Path: <linux-iio+bounces-23306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A7B37024
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E237172AD0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB73164C5;
	Tue, 26 Aug 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WTkNeWAu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F73164A6
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225472; cv=none; b=ZvUHOBb6n2XFoZ+egfZZ79eELszZPnI8rO09DN5fKcHYK5NbO6BGGQJvDOkhvakeFMGEDqOpPAQ6rizusfeohMa5/F4THRilflWZtmD3y8X85RWke/8WK5B3ARUgSpW6G797UMDOCFyxKJG8/Lqafid6PsUME80SacN6XSB186I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225472; c=relaxed/simple;
	bh=i0oEbDi2g1jzL5Dyxh76ow3SjoJVdIVZt3jL05gI6cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DSIZ3z4b3LGDdEpQGR7Rqxk0RuP3zWwVAw68+pNar2igP+bUgZRyL9MTLJ3pA1lCUWP7cRcPI6l6xDr3oO/1S9qg5WPI/rL5RCeP5hsB7erxL6S1wl0Ga6F67qxgFAYZ4Vn5fklr06QJZVmllQ4cKIW9t5BYtPiYS0ff7NCy1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WTkNeWAu; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74374a65f35so21773a34.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756225468; x=1756830268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxCALq8DDHHpB2BZLfew8o4so3+GwVKkNdqD7LtBjyc=;
        b=WTkNeWAuvzOLTKhyKT4148aJ5nmrEyBYHIQgC5EsaaMevUjtapdP31mC33L3BQThAb
         lrKguPcH+XLcZUNdll2WB46wmqFnlttTHafg3CAx8lfyEnQYUZIi1HSmNW0CwKe2Ww0P
         pw6qp6VDhDUC87zBnEly0VM9y8lagZKUecpFlhcOSKpzhKojsblVI20R2GeDnjshlhjw
         aiHEzN4cU2x5KRpWf5xuzhVKCOWEEzderDtcrPgp2x6FgUYzYoQf/uCOOlkjG2tNaekv
         VtMh4qFbgnSlaKkoN2VLUf3Hp8igQOj6C4f4yTrJiGuZLOa1MNjOH3fmNukWdgEfQvGo
         jDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225468; x=1756830268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxCALq8DDHHpB2BZLfew8o4so3+GwVKkNdqD7LtBjyc=;
        b=CwVtiU1BDReWziPcVJv331ByPTsDzyBrwGrLkSEDxNPLEO7RLq5nDDl9wfXnxFKeh4
         WPb8F947awCeUfAgyhZszHfWUmmrSe/D6EXK45lw4jAg7g1JnybjIF3v/WOThdVfRi/c
         qXPABIwiMo9A5dnyMw5zVyBYVju1tAQAIB9u1iOuFuUPuVzd0bdEqha0JxORWNRM4JGd
         tLRblIeyictu+i//CJZIbnxC6l46+NaY8eKiv7xuv/YKnMK2LXlfsasK27itqMBibF2v
         RnGX7twVgfoh90efTpH2qZCUtBBfvsfJisBmMwGUXkbFjxXpKcuSK58NYUbRwc36uwY4
         Z06w==
X-Forwarded-Encrypted: i=1; AJvYcCW3qbyrxrBgVmkctRbJmRugpMJR37d2FzBIHNRZ8y9hNh6cvbNhfoWxwzmhQhlGKSbVmcVR4UH5ahQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3ewD+VfN5i2M9ZMoi3fvvOSTzzRxzlr1d2wbhtxre8Sv2B8B
	xedpCEh26IjRAXqWNVB4bGrnRYmMl4p49qNUjOZYzAP1/znXIXskLSD6zXY3DXDRZZE=
X-Gm-Gg: ASbGnct32WtJYUQQzLoquK/IbNnUezeVJOBHsLItL8QPRa363srMyRmlt7y3bTDD2tD
	lTbkvdWb9epuChKZYP+if2TeWuAPJAtUO9VmB1ELElB2p78dqlDZVl1mePsh5WLBF0Bwv6vMjLz
	Gwpi33D76KA9XIvvLD1AsNqbF7QdDWhjJTM1h5IoBAYUs78DfCmSTno6h5iAmLGJYRt9ut2Om6F
	iTte6dzgppKRNJIPznDCy0+t4xh0yj5N70fgkpzExzEEm7Q13SeAt1ma9vInaOYot2DfPvqk2U5
	pKqNxRJUDQT+Bc2WOg6KwZtR1Yz0cWPln17KnUC6sKCPXikJWbsPfAImKsXMZ6FMKidlMpw34Hm
	FOqjlYgFHpxV0Y8ff1toPlOr9YM93XK2g5uVooSNqe6iwFv10BgswbI+OraQB29/iCtfln/DA3s
	gzjDsjhj4k3w==
X-Google-Smtp-Source: AGHT+IFfYRdanH4lMvOeslIkzUAsoFW9mKtvAJqYjbyEdJMFQ5DbdT6baaJfteOsGNPMe3IVB9CJtw==
X-Received: by 2002:a05:6830:258c:b0:741:bf2f:ee87 with SMTP id 46e09a7af769-74535b1935fmr900221a34.0.1756225468382;
        Tue, 26 Aug 2025 09:24:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e2690f3sm2409801a34.8.2025.08.26.09.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:24:27 -0700 (PDT)
Message-ID: <82a21a66-409f-4ec8-9351-365031b8646b@baylibre.com>
Date: Tue, 26 Aug 2025 11:24:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add IIO backend support for AD7779
To: Ioana Risteiu <Ioana.Risteiu@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 5:13 PM, Ioana Risteiu wrote:
>   - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
>   setting number of lanes used by AXI ADC.
>   - Add the generic io-backends property to the AD7779 binding to enable
>   support for the IIO backend framework.
>   - Add the adi,num-lanes property to set the number of lanes used by
>   AD7779.
>   - Move the initialization specific to communication without iio-backend
>   into a separate setup function.
>   - Add a new functionality to ad7779 driver that streams data through data
>   output interface using IIO backend interface.

It is more helpful for the cover letter to contain a high-level
overview of why you want this series included in the kernel. We
can look at the individual patches to see what they are about, so
repeating that here isn't especially helpful.

For example, I would write the cover letter for this series like this:

The AD7779 ADC chip has a secondary data bus for high-speed data
transfers. To make use of this bus, it is connected to an FPGA IP
core [1] which is handled using the IIO backend framework. This IP
core connects to the data bus lines as well as the data ready signal
on the ADC. This interface can use 1, 2 or 4 lanes at a time.

This series extends the devicetree bindings to describe these wiring
configuration, extends the IIO backend framework to allow setting the
number of lanes that are being used, and extends the ad7779 driver to
allow using such a backend for reading data in buffered reads.

[1]: https://analogdevicesinc.github.io/hdl/projects/ad777x_fmcz/index.html

> 
> Ioana Risteiu (4):
>   iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
>   dt-bindings: iio: adc: add IIO backend support
>   iio: adc: extract setup function without backend
>   iio: adc: update ad7779 to use IIO backend
> 
>  .../bindings/iio/adc/adi,ad7779.yaml          |  44 +++-
>  drivers/iio/adc/ad7779.c                      | 192 ++++++++++++++----
>  drivers/iio/adc/adi-axi-adc.c                 |   1 +
>  3 files changed, 196 insertions(+), 41 deletions(-)
> 

Please include a changelog of what was changed in each revision of
the series along with links to the previous revisions. Tools like
b4 can help automate this.

https://docs.kernel.org/6.16/process/submitting-patches.html

