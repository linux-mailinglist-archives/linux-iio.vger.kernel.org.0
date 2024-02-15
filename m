Return-Path: <linux-iio+bounces-2594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB09856F88
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 22:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BA21C20EEC
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDA141995;
	Thu, 15 Feb 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rh9lSOmr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734ED13EFE6
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033768; cv=none; b=NdA/W34i8icnPcOvmUHlI9ZBJovaB5H8h8362m0VUHv1M2zQZUDTeLGnx2aa+zvpQx++0BZPzvDJRcBsrFPaUQYRmCjNYoam9FV6C0fz2xtDvisH+Yj7IvbGKQGlfnVYNv45cn8llwOse38wG02R5UOTpTHx3Bw6zv0pNVtWR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033768; c=relaxed/simple;
	bh=egrIl87HVa6P/9NzKEjM0euP217KPHODBvobgCHy12A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJX+BVChuMP0Am9tTcOIdoU+1GK5gupamBMyKX+6fwfOqhRmuRkDVRb52oDs7nK0PK1r/z66Ph4h2/eV16TnAFqFlfNSjluCQuCje3Xg3YnIORbEg7SjUiNdrR4VzfUzLdrLhUNmr2RCszkXK2YLG96w6/keD/zVkqyX61cBVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rh9lSOmr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116ec49365so120945e87.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708033764; x=1708638564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy4dy8qC/aEpgjhI6zSmtJIrU/2TuVH5URvhfhOyGwE=;
        b=rh9lSOmrU+eCmbHKQwi9E9XEvOeICGmz0ntsyrw+XJ/xjZjRAzEo7QVJAjidP3IrfC
         Sn9KbY2qYcHOPcpMaeIzajiJaqwBgGXfNeko9YB92BEcHsrXlM0Vyat4NlPZWUEjOmqc
         LHIgsXjkIHmtkVhyhdyS03Y7RhuFh7k5Y2tCq9XmOODfe+jkuzIRgvq45VIchQ5ru2lx
         VkvomhrYCA4hTxEbGkbUdZKLNjHHar1DQAUlrs6+ST9FZq4UoWY5PysTWkg5FIqFXhlj
         NTCYMgp6dIwRA9qwpplKmd76Dhk05r9uzdOkHqfav4GkP91JK+/O5ffcmDyefwwQZFBL
         tVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033764; x=1708638564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy4dy8qC/aEpgjhI6zSmtJIrU/2TuVH5URvhfhOyGwE=;
        b=u+nAOQmlFEKggJwCzfxU1EI8H4wZnK+imfuCiIS2hTi6byzOIdgIqZ1ZNmldtjdiHY
         pF9ZhEuoEbVbJtuqNP7rTh3/NO3lpOCLR35XOTwDSLqewk/XDeE/gAscOxheEkFU4mDe
         WJ7HQz/aU6itHWS/N2jcEBZKz1QIWriIghAhq0ow9We35Avx8R8sBWWaI0U1wqUcZCg5
         unES8pO1ERcXOY72g9C/rPYYqRV4FSZht+tIkceevUIR3Y7rA++1bNhDChbW9Ke5RqWz
         +au+cWWa4GbGyGH5uXDf21Sq9EkspIyYTP8L+Opchu5yxoRUz6BkHJT2by/3y3LPF28q
         l3eQ==
X-Gm-Message-State: AOJu0YxeA+8KI8FVqkQY3fZvX9gdF8j8mMIwEXWtoJomaPRSk140OC9b
	950xDFW8F0RlkwBI/C731vqvfORdpcL3ndFsgjLmhPu0t7wXiR5Ne3vn64i/eGY8wbQlh+ZS3LL
	4wCPKeRTHlyDVbiEBkEdCGijkHUzRuO+2K5AbMA==
X-Google-Smtp-Source: AGHT+IFblS658xAUkyzNInl0/6coFWFu424jBrjv6P7mBNcHohWTiH831Tul1x/9RSSF6JS9qjHsfg7rEDFJ3nMR9BI=
X-Received: by 2002:a2e:9c87:0:b0:2d2:1699:fb5e with SMTP id
 x7-20020a2e9c87000000b002d21699fb5emr210697lji.2.1708033764453; Thu, 15 Feb
 2024 13:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com> <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
 <20240215132334.GA3847183-robh@kernel.org>
In-Reply-To: <20240215132334.GA3847183-robh@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 15 Feb 2024 15:49:13 -0600
Message-ID: <CAMknhBF8BQQfXkMvu3dS-RtaYBeOZ7mfCNxMaq3LOWwLp1_cxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:23=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Feb 06, 2024 at 11:34:13AM -0600, David Lechner wrote:
> > On Tue, Feb 6, 2024 at 11:26=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:
> > >
> >
> >      if:
> >        properties:
> >          adi,reference:
> >            const: external
>
>          required:
>            - adi,reference
>
> >      then:
> >        required:
> >          - ref-supply
> >      else:
> >        properties:
> >          ref-supply: false
> >
> > to be sufficient here. However, currently, if the adi,reference
> > property is omitted from the dts/dtb, the condition here evaluates to
> > true and unexpectedly (incorrectly?) the validator requires the
> > ref-supply property.
>
> That's just how json-schema works. With the above, it should work for
> you.
>
> However, redesigning the binding would make things simpler. Just make
> 'ref-supply' being present mean external ref. No 'ref-supply' is then
> internal. Then you just need a boolean for 'internal-buffer' mode and:
>
> dependentSchemas:
>   ref-supply:
>     not:
>       required: ['adi,internal-buffer-ref']
>

Per Jonathan's suggestion, I plan to simplify the bindings like this
but just use the presence/absence of refin-supply as this boolean
value to simplify it even further.

