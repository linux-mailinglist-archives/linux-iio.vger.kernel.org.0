Return-Path: <linux-iio+bounces-11596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626349B5D75
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBA5B221B4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928651E0DD2;
	Wed, 30 Oct 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2DHjtRg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E71E0B66;
	Wed, 30 Oct 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276071; cv=none; b=IjvWt/sW7/GzbgyKHviMKqvbIkKIxJ0WkfT3nHRVyCiPMWNye3/Vl4FIDSjAMEoJTUwsqkWfa6gMMiNqv22Nk4C4KfbaFR7bw17tyar/5B4geaWZovCJ+4makQ9sLNURzPQE2kT8je3+0CwdWFVZ+IzdHVa6y0mMD3OFRfhFUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276071; c=relaxed/simple;
	bh=UbpY2GOfakxMkWzoCuhpkKYk5U6BVu6YeTuvftmsIiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1PkFswtpt97eSdleeXQYEq8d6uGDWZW9QcfMFwttDDDVqgSZCChu0S39PMi6fPvONqp+iARWB0aGci0h0lJtisciGbVb8zfp+qjzEqG4Cehv0M5tFT6Zga7BeWHopBSs/hcJqHja9GSINVJZOH8DI+jakdMiZKNOlGLIz/bbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2DHjtRg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so763723866b.2;
        Wed, 30 Oct 2024 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730276068; x=1730880868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqIFuN1iv5yYdh7qaBnPPoEinyPtBarh93OzzWG7zLA=;
        b=T2DHjtRgFHM+PbIFRRdY5bMwMVd+T3zGl8KtZ2S3X4Ro/xpUr5F9pRnkq28eeIuYla
         34sDZkAQUkLYibrDJJbung3gbdLid+dE2kSJls+8m9SIeo1pHbVtDfYKD+O3f2r8ToM4
         1ZsBubsre2Ges775Zdwy0pV6+K/zl5dUNK3OMVHwsYyqbP8/5J8A/g8CiXmsqPsihoIm
         wTTGeCKyPM5AA/eCVFRJORsLnqRcB6kVh/Icd5ZPsdr6fIJrQJj4Fw4SwG4bh4tqOM+n
         dKnc5snGIR+gc3rYB/5OGN/brrBiF/T5Be9/TPQjw2XeIt3FtEJKa/lTgrgAVlb5gtvi
         /cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276068; x=1730880868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqIFuN1iv5yYdh7qaBnPPoEinyPtBarh93OzzWG7zLA=;
        b=QbIWkJHi/A3fynMoUWbLxUTYiuGIisVH9wIeNFYatc1+D5mBdxAm+qvtYHVa0P+XtL
         R4IHxRdQ1l6q1CEJ/7KtbAys3smKEgirfLpSrunaeLTovrWNeU19WpmndvChUgtVsZkl
         FZ+GybCqXyHQmUwYF8YZFVE+zgoGC1ZjMdlVdAD1ZcSEx7Bm0O+Tnwt8kYfkYeFSjE5J
         LuYr0PRApLfOelxzHUFzYQhlkJj+LW7dJDEZ52gM2YUrZbyahE+653/KveXPUbYXrMu9
         JKsKzwIqFeIwfaPCt2NrbTnT+RBFkcXgSPHl0Ow3UKUzO/uUt5bFcdb6E7OpP3Io+Fzn
         ckug==
X-Forwarded-Encrypted: i=1; AJvYcCUmuQqFklA5W1X+4y5WxNc8p5O9oly4F+hycibGDqh9WD/3K2ZqrmnC2VzLqp/Wbdrk2RZ5Xioj1/f0@vger.kernel.org, AJvYcCUz9aqPNfan7EdxNKlLZaiD4vsMYrU5WGOi561RRTFTEcfgtiti41pepEB6iROU/3225zVkHvhZ2PA=@vger.kernel.org, AJvYcCVnI1c5c8SGzEJjG/Sw9E+6usHaujg0di5W5oD6bqArNBefhc6uGL/yifG9hpMy6Gq5CwC3P78+1CmdGg==@vger.kernel.org, AJvYcCW80HzFbEOJKHnK7kes+nNi80qWmLTTx1WEvftk7ifuk4B8d2AJ8rLRfSVwbVSb1BUyIA5tQ0Jn2OKBZHg/@vger.kernel.org, AJvYcCWkzhbbnWReIo1v8nZ1NFMzQvY7I7mlp1XdMs44QL/SAgs6gNgVplVAOzaOayTFCkNuuihc9vx+Kbeh@vger.kernel.org, AJvYcCX9L4Ckpfj6ozMnLTWVPe9+uaIe0/CM33bHhI1kR4Vyk+Bvv+zlNQn3QbBlJiQOZWjWloVNcNjpJgD7@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZOtubNM93EBj/neGBZRRtPUvWgBSSnlCBRewgDifiskQJdv0
	kwxq9h12DZsVv830lbf6u+W56RpyqBvspHLibn22lGrRaLbh8fr3
X-Google-Smtp-Source: AGHT+IEeSOEP66unxNe2QFnQlGS4YEDU2jrJx08MLL4oEp4a96EsXYOhRfV6NU+PLBebbSXBwQpaBw==
X-Received: by 2002:a17:907:1c88:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-a9de619406cmr1597304666b.57.1730276067318;
        Wed, 30 Oct 2024 01:14:27 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f29a430sm548725166b.139.2024.10.30.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:14:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:14:24 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <ZyHq4FJ0ubQVGREo@standask-GA-A55M-S2HP>
References: <ZyExK01iprBHhGm6@standask-GA-A55M-S2HP>
 <ki4wvjslncrngwpz7qukknzgdsjkxvrhitem7i5lof6ggyhu4e@tviovrd2wi77>
 <ZyHjW86v9Y59-TJQ@standask-GA-A55M-S2HP>
 <7db6431e-1892-463e-9c74-cd466ae3ca32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db6431e-1892-463e-9c74-cd466ae3ca32@kernel.org>

On Wed, Oct 30, 2024 at 08:48:25AM +0100, Krzysztof Kozlowski wrote:
> On 30/10/2024 08:42, Stanislav Jakubek wrote:
> >>
> >>> +
> >>> +  '#address-cells':
> >>> +    const: 1
> >>> +
> >>> +  '#interrupt-cells':
> >>> +    const: 1
> >>> +
> >>> +  '#size-cells':
> >>> +    const: 0
> >>> +
> >>> +  regulators:
> >>> +    type: object
> >>> +    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
> >>> +
> >>> +patternProperties:
> >>> +  "^adc@[0-9a-f]+$":
> >>> +    type: object
> >>> +    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
> >>> +
> >>> +  "^charger@[0-9a-f]+$":
> >>> +    type: object
> >>> +    $ref: /schemas/power/supply/sc2731-charger.yaml#
> >>> +
> >>> +  "^efuse@[0-9a-f]+$":
> >>> +    type: object
> >>> +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> >>
> >> I don't think this was merged. You still have dependency.
> > 
> > This is in next-20241029, which this patch is based on.
> 
> Try what I wrote below and see if this works...

I assume you meant the MFD maintainers' tree here.
Yes, that tree doesn't have the nvmem patch this depends on.

Would the approach with listing the compatibles and additionalProperties:
true be considered a temporary workaround?

If so, should I split this into 2 patches?
- 1st patch with the nvmem workaround above
- 2nd with adding the nvmem $ref back (which would get merged later)

Regards,
Stanislav

> 
> Best regards,
> Krzysztof
> 

