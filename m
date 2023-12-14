Return-Path: <linux-iio+bounces-928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68018135E3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725F62816BD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD345F1C7;
	Thu, 14 Dec 2023 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mNZxsiA/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0A10E
	for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 08:12:43 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so104786091fa.3
        for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702570362; x=1703175162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgLd3wB0jQIWdxHpeHgoYJ7Y9WZfKwtfMLFflx+P7WA=;
        b=mNZxsiA/3meM1yhZjRfKJqxXba/j6o85TFggXM+yxsl+XTPnk8AQtRvI/ZH469O+c8
         hIjF5T6m4vUPV7uBwmiDgSl1o+iHbtv7JXc8vrx2grbObvacdRp1ACiT0yq82IMz0xLA
         SeDA7+U7AP4m38L6rXe8sB+ucUySKcI/PuZ76fBvk1JsJGF4JAzHco96EPRtyZEqWtN9
         6R8TFzeL2wTVbmdjwhTv1rfCNK3Ic7mIvCdmNeOmOpmi6C0vyGINWfIA+pfSFWorX/JU
         bJCfHRYvzIx2Ar1nYUWUhTt8c6+7BYwyFFPUpEbxp1u8Hc7wUSA0Xq47OfgycbukDZPs
         V9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570362; x=1703175162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgLd3wB0jQIWdxHpeHgoYJ7Y9WZfKwtfMLFflx+P7WA=;
        b=nE9EN7qs5ZpuIkMPh6Ht+d89Jf2RajT7h0hXnsVFHuZq+EFMsM5gBm1Bf2XMNRSqWD
         I7GzA9TYgYQ8aGUi6PKMapDCmzmkebA5diuh+uWDT+wZopMl+zgHSTXXSbA2M9GNQxUJ
         fSZ47tjH4QP0m7erxIECrFNK2wKmIqqLZhH5H/HIQmWk3g+n6s7y50sWU0WrDjsN58rY
         /Z2PetujoJ3YOX6QHI4jtCXmnxYXqWYeLAy5b90Eq1HehRKnj8FZlzup3bWSNEYL+897
         s/2HMQl7hOH8l1/9wRZNoK6jGzQSSmDlcsLrXpn25rhoe/Bc/wqNeXZRUgrfLoIn61uW
         E67Q==
X-Gm-Message-State: AOJu0YyIC0Jx81NzRiLBBFBDLOLkYkBplGZ97oT9eY5Lb/RPAfXHlLc4
	XqwDsBCHBFYKLIi2lDoLfwU5ZnpQDK7WSJaN/98V/g==
X-Google-Smtp-Source: AGHT+IHQs312dUOBx5Ma7ewlNipNdaXg0ZHYPKPXysvpx5x/Rfo9iSSn2F9H0pVWT/hd9w+Jt4dBV+8rIwazDfs5/TE=
X-Received: by 2002:a05:651c:1a24:b0:2cb:28f3:244d with SMTP id
 by36-20020a05651c1a2400b002cb28f3244dmr3432134ljb.6.1702570361698; Thu, 14
 Dec 2023 08:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com> <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
In-Reply-To: <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 14 Dec 2023 17:12:30 +0100
Message-ID: <CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 1:43=E2=80=AFPM Ceclan Dumitru <mitrutzceclan@gmail=
.com> wrote:
>
>
>
> On 12/12/23 17:09, David Lechner wrote:
> > On Tue, Dec 12, 2023 at 11:45=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@=
gmail.com> wrote:
> >>
> >> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> >> which can be used in high precision, low noise single channel applicat=
ions
> >> or higher speed multiplexed applications. The Sigma-Delta ADC is inten=
ded
> >> primarily for measurement of signals close to DC but also delivers
> >> outstanding performance with input bandwidths out to ~10kHz.
> >
> > As stated in [1], we should try to make complete bindings. I think
> > more could be done here to make this more complete. Most notably, the
> > gpio-controller binding is missing. Also maybe something is needed to
> > describe how the SYNC/ERROR pin is wired up since it can be an input
> > or an output with different functions?
> >
>
> GPIO-controller:
>   '#gpio-cells':
>
>     const: 2
>
>
>   gpio-controller: true
> Like this, in properties?

Yes (with not so many blank lines).

>
> Sync can only be an output, Error is configurable. Are there any
> examples for how something like this is described?
>

Configurable pins sounds like a pinmux. Sounds a bit overkill to
specify everything for a pin-controller for one pin if no one is ever
going to use it. But I will leave it to the DT maintainers to say how
complete the bindings should be.

> ...
>
> >> +  interrupts:
> >> +    maxItems: 1
> >
> > Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
> > signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
> > pin. Although I could see how RDY could be considered part of the SPI
> > bus. In any case, a description explaining what the interrupt is would
> > be useful.
> >
>
> I do not see how there could be 2 interrupts. DOUT/RDY is used as an
> interrupt when waiting for a conversion to finalize.
>
> Sync and Error are sepparate pins, Sync(if enabled) works only as an
> input that resets the modulator and the digital filter.

I only looked at the AD7172-2 datasheet and pin 15 is labeled
SYNC/ERROR. Maybe they are separate pins on other chips?

>
> Error can be configured as input, output or ERROR output (OR between all
> internal error sources).
>
> Would this be alright
>   interrupts:
>
>     description: Conversion completion interrupt.
>                  Pin is shared with SPI DOUT.
>     maxItems: 1

Since ERROR is an output, I would expect it to be an interrupt. The
RDY output, on the other hand, would be wired to a SPI controller with
the SPI_READY feature (I use the Linux flag name here because I'm not
aware of a corresponding devicetree flag). So I don't think the RDY
signal would be an interrupt.

>
> ...
>
> >> +
> >> +patternProperties:
> >> +  "^channel@[0-9a-f]$":
> >> +    type: object
> >> +    $ref: adc.yaml
> >> +    unevaluatedProperties: false
> >> +
> >> +    properties:
> >> +      reg:
> >> +        minimum: 0
> >> +        maximum: 15
> >> +
> >> +      diff-channels:
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 31
> >
> > Do we need to add overrides to limit the maximums for each compatible s=
tring?
> >
>
> Just to be sure, in the allOf section?
> If yes, is there any other more elegant method to obtain this behavior?

I'm not sure. I would like to know if there is a more elegant way as well. =
;-)

>
> ...
>
> >> +
> >> +    required:
> >> +      - reg
> >> +      - diff-channels
> >
> > Individual analog inputs can be used as single-ended or in pairs as
> > differential, right? If so, diff-channels should not be required to
> > allow for single-ended use.
> >
> > And we would need to add something like a single-ended-channel
> > property to adc.yaml to allow mapping analog input pins to channels
> > similar to how diff-channels works, I think (I don't see anything like
> > that there already)?
> >
> > So maybe something like:
> >
> > oneOf:
> >   - required:
> >       single-ended-channel
> >   - required:
> >       diff-channels
> >
> All channels must specify 2 analog input sources, there is no input
> source wired by default to AVSS.
>
> In my opinion, there is no need to specify channels as single-ended
> because that would require a property that specifies the input that is
> wired to AVSS.

Makes sense to me.

