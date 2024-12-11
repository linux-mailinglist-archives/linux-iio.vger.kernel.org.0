Return-Path: <linux-iio+bounces-13327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD439ECDB2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94C32858E1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F6236913;
	Wed, 11 Dec 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="We7Ro6Qp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3C22C353
	for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925210; cv=none; b=ogrn8PUx0HIn/TDIRKNwCdEpvR2FBd/i3O/tyD4OE/Dg9r85xtc07EtuG2/CkvTlMRUs6rQ8HV+W9oa/NJvlla/quwxTspfMn5IGz+vIYgZxOmxGFtV99q575miO9+xOQZyJzDyEsXthSnjh9RfVI2xlMBej1qSwJjfWKRbKMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925210; c=relaxed/simple;
	bh=YSdh0Mm0FonlMgaa3imnf9PPReZOary7MqBo29RKeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqLPIFPR0OGQJhT/ihmB9bJXsav79bOxXJeX8ob0AR/0vahAqUBw6Q45W0jOWPw//LAH3nK0Hj4igbNfB21AcUltSx0r4is5uyFyf7HsjOuDAU9Y79WBjwMIfuCl4dhAfbyvE4F91IUufrwHqo8lI6ri2FEXdwjdPtW4bZYzaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=We7Ro6Qp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso1041168966b.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733925205; x=1734530005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JAQ94DgwmZTsFqQuFhEr5XjtlJo5Liq/MWFSbEP7oQ=;
        b=We7Ro6QpXdFqx1EZCLNk/BGMGe7KhGl6PAlNriTd27U4td+pcYwIjAR39eWjr3fQV3
         hbwqiaKicF/joN8+62DAYg8Wf9/MURxT8V6z8bGdUlL0iV0Y0xNXupuRo9OjB3QYbfXB
         csYSDW2tU10Y1v8TLomFlX/NG62h5wyDlxRXMB8/GWwUj6vIlZrublRxbyO8JQNTZs1M
         OcPBeDjVKdSmVLyG3jFTn0n0XIj0HAlr/ZL0YbhyX4t0B5HGjOtgCwRfE8wv4qfhgf1p
         XHhWsm3/GVeyw5+QUaPsEKGZ4IfFzeXu8dZNVG5Z9qY2DOR51vj1yLn1M/mVxfIyXI4X
         sg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925205; x=1734530005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JAQ94DgwmZTsFqQuFhEr5XjtlJo5Liq/MWFSbEP7oQ=;
        b=geieHQ1bZO6s7tT1yEIfvL+A8NyT7a3gXWzU2MTdvKVURzNAcHDz74FygPZEdpk6TD
         RptP0JdOe4aovxbYFkL0qVyvX6BYLwElLftk0Ll1YfvGKpa96pvZC3gi6OwCDUNvdSpR
         sGAbmvdIios1wE+7Jz91z9slUNaWqrLfKviyT6SEAbQoFGAtOXVw9ziccuDXDf+YonPn
         Gjni3Xmqxy6Cdt9gGHIwN1iIwtMDoCEbiLouD4BNZ5q/eau1r2UDtj7JrlLcFqmUl8ga
         jVTDiHv0nRMoCfel8E4S+sWRVU2oiNSwHTB8VutgQMUW6niq7H6ZjptJuSb/q12aj9aR
         aOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpF1MgisWGuvQvuYa4MnJjX1JpHERRqIYk9vlyeSGKUu2Ut7LHBFKCRdqCGBZLO0Ar02wARPQNjBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+IgWNG12DlQ0qPNcxgu1Xa24XztZMCT3vMJiccsXu37fiw8F
	7aiCyIaKq4Dtr01uj1wzpixaZca7rrBUpHExeQfxhzvWi2vROyebSSYotfJZCIg=
X-Gm-Gg: ASbGncsUB3NCmqxZDYVDv7PU/HNGzyEVjk8YyD7feMY0GAZWCE32Juh/a5KWT4EyPMk
	q8bu+sVSA2ZfnNCT+s3RGMBWOpKaFPTEwl6OTxNXX4JH7VLR44oZ7GMvjoM6iIOPXQaQlMvucxE
	+i+JnDAXrf8dx+OUXKqMmf1ZnJ3mzG73Tzfg+4vGPJxUoY3Wj+Dmu59G5zDagZAf+SwF1wGx8uq
	FQPYro14K4vwdxeneBq2h7fdtyIrl8wGsH7LA9fao41m5vo0cKDMF+rjDOfZGU=
X-Google-Smtp-Source: AGHT+IHhR+q/yjOR8fMgpp+HvsWmN+ncd/5Lo5Mk+pkPGE0cvah/TqVw4ZywcOYOxY2cukLaXrgmug==
X-Received: by 2002:a17:906:b3a1:b0:aa6:75e1:186c with SMTP id a640c23a62f3a-aa6b1505cf0mr213318566b.50.1733925205362;
        Wed, 11 Dec 2024 05:53:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653d1df95sm682900766b.98.2024.12.11.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:53:24 -0800 (PST)
Message-ID: <5e7d316d-2e13-436d-8474-48411e2a12d9@tuxon.dev>
Date: Wed, 11 Dec 2024 15:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: renesas: r9a08g045: Add ADC node
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
 <20241206111337.726244-15-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 11.12.2024 15:27, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Dec 6, 2024 at 12:14 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add the device tree node for the ADC IP available on the Renesas RZ/G3S
>> SoC.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> @@ -87,6 +87,59 @@ rtc: rtc@1004ec00 {
>>                         status = "disabled";
>>                 };
>>
>> +               adc: adc@10058000 {
>> +                       compatible = "renesas,r9a08g045-adc";
>> +                       reg = <0 0x10058000 0 0x400>;
> 
> Table 5.1 ("Detailed Address Space") says the size is 4 KiB.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.14, with the above fixed.

Thank you!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

