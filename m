Return-Path: <linux-iio+bounces-20334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812AAD2269
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F7188879E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33501DF97D;
	Mon,  9 Jun 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9VH6/mR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDC14B959;
	Mon,  9 Jun 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482840; cv=none; b=d3s/12gAXirrFlR1Lsu+BG6hl/qo1rJctaOiGhO21SgpqNr+J+1bjcu91DhIh6xLc+21lYRQXnKBdv6vgunQlNTcddrPY82+ejk8WVa4bkmLVbkOtIXQ8irkdafHytQhpih1/9ZCSszf2aQpcrvbvrdWuNY6dzEvt4kZ8o9MSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482840; c=relaxed/simple;
	bh=o7ct1VG4t9rousDJZ+7TWLrH0KE3ZRjzFOX5Z8Pv6wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0tv9Kj2V0hEhP5756dbVx3PC5kZK4yEdZOwyp7j1W4VHTD2b3+ZEvQspCZaj+h/d6Fwbch5mbvgRE67ujtSj/Zz2bkALNgu7nAQ2QFpVTqRnb1enMnv/hN4YzQpgM9MLsLY/PG9UkQSPUF99086gnVyMUggNoTRtWiZyldkz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9VH6/mR; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so3145697137.2;
        Mon, 09 Jun 2025 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749482836; x=1750087636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qh5Ks9XlsRgl2yqP+fq2mc7GwLoL64BI3NhfTID3tpM=;
        b=l9VH6/mR0ki+mZsJVT7KIFrIgRtc29AuJYUGGAsmjvAWBQ984kXpfGP+B/Qtn2sTJH
         ClYLvOlZ6nWWXSx1M6uJHK9GMiNBKL7HfyFbSeRmPhoayoYbPlbRL8kLtvfdt+sEILbF
         1NKyQJ1CGOJs8IA/7rPnt+chEEohwdnN/8FiKeRDVj1/5j+GramCwS4wyqZBLzRwRC6W
         FKL+msOLpodlBxP94tXfl9da+JyuOW5b9PYpp0Xg4zUZdWOKqQl4m5v+Yyzl1yo10X9n
         CXiNweKV9zbtgULPWyi7kRi2Su34/jDqLILWYIitxJjG9wntv8BwDe4UoVr7mOe4nsqM
         6vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749482836; x=1750087636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh5Ks9XlsRgl2yqP+fq2mc7GwLoL64BI3NhfTID3tpM=;
        b=gMGwDhn09SGWzGO4RAPMifh3AHwIf36rA1MwK2YLyZ1186EwUgYeI71hz3PsSNhNNd
         r7GCEDXikktlxvHX8N7pdPFbB5vpu9a7iqy/UXNlFgvm7qFA0iQ7bfn3Uo4R+6gCcFUD
         eI4RGD3lrwRNcoXaonayEhBkmtdUr/IV0WiTBKtI6YSd7iypoYDZ0NYlqESqlV+i579n
         xqL4KJIFqkcx6FtQD5JzCdYNMpLLOKd3I4t9zhd8JckV1F7Xu3+W/EDE4vna3QAAeYF/
         dNrEV2Q1GQsLo5If9VY0/CZ5hDpJxO6cDZgWFbY/yrWhDHwTtisdsmhlVGfoRjQYKeJR
         sFrg==
X-Forwarded-Encrypted: i=1; AJvYcCVL8w8K9SW01R+V+U9e5sGLHZV3p6iU6L60GBhKhmw2cyIkw4EJ3V9NOx+B/pOOGGNzvn2RQRXx4ur3@vger.kernel.org, AJvYcCVPBU65sSGJiK0ekN0LWXb2F4YkitUw35/AbpTHymBSkmBEI3ih6T0Q7VpsgUjl273QQm0Ua/+js5Gu@vger.kernel.org, AJvYcCVcEGL4Rg/Wm7+LUQOf0kymIbpP0A/yAhD+UKrHIUpnsIElWTj3ydIGsCYxVea04hkBek2avOc3vaQM0g==@vger.kernel.org, AJvYcCXaC0R95blkf9kc6gHqSPg93ipMxmC+gFDWtePbDoH3PhmtQeFbhaU3sCZehJrUy5gN0dPVR6kk1iIJKgnt@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPD297HyFNS1b8F+H1B6BMudcRrm5nTCqWW7QNsJXLOrWvEmn
	crMJzHYTDHqUQ9rJwqf1TnZfIbgzQdrZmEOuPQlrvoKszhL7DUPltMlL
X-Gm-Gg: ASbGncuKmNW7GScuKQ6fg/jMYlaHdVCX+7yOU4BTdzjgaZElPJ3Kag4LxX3+BFkCNaO
	2FwTElWEP/VTAfxCkE/xAsQvW9XCsrdaT479sTQgOodaEFYe2IiAT/xLSdMPQSJhO/oiNgMfJuQ
	t/KxUCF90QslCXUhHkFcbkHOuuf3jOe9yuevNmgy3I2hYQuNc803iGm+lb0URuqBHKgsF+XDek6
	RdpMUkhFSNr21laJsFq7PvZxFBSIQe1pfAU2BNiGtcWSZ0dYkp54NXgWE8s7M9tN/F5I+o/ErcR
	fghHvC65dMeIFsCzpG7Wp5O64bLsrR3F/N8WIWRdpXL4RqYfgS+/gYrMbvth57YChm/JRb9qQ4P
	pvCAhWg==
X-Google-Smtp-Source: AGHT+IHnTeNOGEEeUF9PpvnXnHJwvtelFzJ4pIEC1WJl3LQ9o+1fzFRn1D0Guy53dnudysMOxAQKCg==
X-Received: by 2002:a05:6102:3f94:b0:4df:4a04:8d5e with SMTP id ada2fe7eead31-4e77296a2e5mr11749773137.8.1749482836007;
        Mon, 09 Jun 2025 08:27:16 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-4e773974b31sm5046500137.25.2025.06.09.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:27:14 -0700 (PDT)
Date: Mon, 9 Jun 2025 12:28:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <aEb9uRx_2Hdh0PzX@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
 <20250607174521.6dee54fb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250607174521.6dee54fb@jic23-huawei>

On 06/07, Jonathan Cameron wrote:
> On Mon, 2 Jun 2025 08:36:24 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > 
...
> > +
> > +$defs:
> > +  reference-buffer:
> > +    description: |
> > +      Enable precharge buffer, full buffer, or skip reference buffering of
> > +      the positive/negative voltage reference. Because the output impedance
> > +      of the source driving the voltage reference inputs may be dynamic, RC
> 
> RC?

Stands for the combination of resistive and capacitive elements in the path
between the reference supply output and AD4170 REFINn± inputs.

Datasheet Figure 76 shows an example with only capacitive elements, but it could
have resistive elements too.
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf#unique_75_Connect_42_ID8013

I will rephrase to make that clearer. This is probably too long and detailed
description for a dt property. I can't figure out how to put that in a more
concise and meaningful way, though. 

> 
> > +      combinations of those inputs can cause DC gain errors if the reference
> > +      inputs go unbuffered into the ADC. Enable reference buffering if the
> > +      provided reference source has dynamic high impedance output. Note the
> > +      absolute voltage allowed on REFINn+ and REFINn- inputs is from
> > +      AVSS - 50 mV to AVDD + 50 mV when the reference buffers are disabled
> > +      but narrows to AVSS to AVDD when reference buffering is enabled or in
> > +      precharge mode. The valid options for this property are:
> > +      0: Reference precharge buffer.
> > +      1: Full reference buffering.
> > +      2: Bypass reference buffers (buffering disabled).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 1
> 
...
> > +
> > +      adi,excitation-current-0-microamp:
> > +        description:
> > +          Excitation current in microamperes to be applied to pin specified in
> > +          adi,excitation-pin-0 while this channel is active.
> > +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> 
> What motivated mix of using $ref and here where there is a lot of repetition?
> I don't mind which approach is used, but a mix seems the worst option.
> 

Because 
$defs:
  ...
  adi,excitation-current-n-microamp:
    description:
      Excitation current in microamperes to be applied to pin specified in
      adi,excitation-pin-0 while this channel is active.
    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
    default: 0

patternProperties:
  ...
      adi,excitation-current-0-microamp:
        $ref: '#/$defs/adi,excitation-current-n-microamp'


triggers dt_binding_check warn:
	patternProperties:^channel@[0-9a-f]$:properties:adi,excitation-current-0-microamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref


Thanks,
Marcelo

