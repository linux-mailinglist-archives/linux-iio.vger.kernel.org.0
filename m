Return-Path: <linux-iio+bounces-5071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ADF8C7A96
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32F3284255
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57476FD5;
	Thu, 16 May 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T6vR3/R2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440754A3D
	for <linux-iio@vger.kernel.org>; Thu, 16 May 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877800; cv=none; b=uZ0QCsPkdd0z+3tQbDqBhJD9APdnLGq1E2Geb8W6NvlWtyNKDKAe+5BLN2GUVch9K7IEW60YPPSPRP6jGYNH15o+d+4QBCxrYETgpUNWZOFi+agZECzUj9jqReRjsqrcqK8SYCNw64w5vPjgZ8ky4TlizqkojfSfW4qtCDlJ11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877800; c=relaxed/simple;
	bh=qhdkkjG63mJDXlyD6fjALNrwjbUeN8euBvfpCnw6MQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dep3T17kNl5tP/MqOdQ3aMNXBqO+aJSu9xA6yEWZajcVPm3JTQR2/J7wWtqahe9W2zRoqIsf4/g4ljLk998UGmUjUQ7/VcvWm1s33TTK1VZO7bd4Hqo6aUGJmQ5W2JPrGdTRB2TQXkREarD0ARoZmV7bySLuKKIfbH0VVUe1Kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T6vR3/R2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e538a264f7so12693411fa.0
        for <linux-iio@vger.kernel.org>; Thu, 16 May 2024 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715877795; x=1716482595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79IRUvthFSgXLjweA1zUqe2seBKxPLlxqdBaQG4SKUw=;
        b=T6vR3/R2YWhJIVqbTLKcK4yJFxh7cFTHD5NrjfTAPfmF0r2reLIM66NP5YL2kCjuQp
         bjmDubXG8x5PfwuIk7gUN2EgKegyIujg1VKjyt3Hpn8/I2PU0dYaQchQYk79IERrcBdg
         btDiiHFgzIFHBqo9z1Cd8FhyXaLU8BCMawWSVUh2z/kykTY21gBFgaqUOrybccrkwgHx
         2Qcb3eQkypT7ZQjE5tiG+FOJ6qGbNhQKWxMPL6FsTHIFaY9B7vlGi2B/fwLAH9WRgUud
         PCEQ9yhE+gaob5VU58IfuRjHJuYDpFHAX5FWKvi3A6xSRnkyZi2m93eCVca0aL4mQlCN
         APrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877795; x=1716482595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79IRUvthFSgXLjweA1zUqe2seBKxPLlxqdBaQG4SKUw=;
        b=l/0Catzi67sTbSRp0P4lqZd+9SskExizt3TJ9J0Rzkoo3GXmRIMdhPhQYTyIKmzxpB
         ZxZLl5tmdtfPdcge7NSuJD+NEiBjmLj36wCQRlL2AXYHnO6zw56jQXdUEYuioCoYHNEU
         IlNz53p9BmDH/jtFh6G0lQTIL6/6rcJ188Esu1AlCjYCTBIkpQcJ+vyWgIk9BZ3fN+oR
         UQqdXjEYBLazTh7esiEOInpiP5N9JEYOUU+B73MZw+7yzMjSP42UZ440VbFy7y3Qxwiq
         hOgV8T9eQzFuHi7ZmIZWLmiSVQVUv3LHfSTwrDrYErSGZhf6T2C65yhPT1qEZ3+MqnmZ
         PMLg==
X-Forwarded-Encrypted: i=1; AJvYcCUsesbr/9wCc6z9W3/LtFGG5rh+q2+RPu31ATgsGEBScqS0wEuRW31uAvPcPg948+lfd39BqnrLSCUtojiwCqCgv1/yhj8LAvAH
X-Gm-Message-State: AOJu0Yw8A8yS5nXaFxkT+YywKiqAQL0fbze6d8mAZVVkZ9d7g9U/4w/0
	KshqQi4uS5CD1M4pqS3+FWOQYs+hCDxvPxwOQpgpWMDi2akcgh2ejv0HLTusamG9ZVOOjXqAuby
	PP/0tPc9A2wcyytDw0RgAi/pCh2xyRK+UYIsfXQ==
X-Google-Smtp-Source: AGHT+IGFobeuDVmgJIg/aZnlBscvXY51EDfry/lc6brTp0NxdfFW+gAy0JY4O/NTy2FJLYdANJUQeujyfscqopixA1o=
X-Received: by 2002:a2e:2c13:0:b0:2e1:e8fa:4f56 with SMTP id
 38308e7fff4ca-2e52028e665mr116051901fa.42.1715877795373; Thu, 16 May 2024
 09:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com> <20240514-ad4111-v2-1-29be6a55efb5@analog.com>
 <CAMknhBGNPvxegL+YbnLGoKjA=P3Vx=x+39aXuMgq+cv2KgdeLw@mail.gmail.com> <151d6893-3e9e-4331-8dde-5293e75f10ef@gmail.com>
In-Reply-To: <151d6893-3e9e-4331-8dde-5293e75f10ef@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 16 May 2024 11:43:04 -0500
Message-ID: <CAMknhBFKM+DC9jNDV+cZ5agwsXJ1iqU9DB3XD-y3sVcRWJOAsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: adc: ad7173: add support for ad411x
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:49=E2=80=AFAM Ceclan, Dumitru
<mitrutzceclan@gmail.com> wrote:
>
> On 16/05/2024 01:37, David Lechner wrote:
> > On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> >>
> >> AD411x family ADCs support a VCOM pin, dedicated for single-ended usag=
e.
> >> AD4111/AD4112 support current channels, usage is implemented by
> >>  specifying channel reg values bigger than 15.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 118 ++++++++++++=
++++++++-
> >>  1 file changed, 117 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> index ea6cfcd0aff4..6cc3514f5ed8 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> @@ -19,7 +19,18 @@ description: |
> >>    primarily for measurement of signals close to DC but also delivers
> >>    outstanding performance with input bandwidths out to ~10kHz.
> >>
> >> +  Analog Devices AD411x ADC's:
> >> +  The AD411X family encompasses a series of low power, low noise, 24-=
bit,
> >> +  sigma-delta analog-to-digital converters that offer a versatile ran=
ge of
> >> +  specifications. They integrate an analog front end suitable for pro=
cessing
> >> +  fully differential/single-ended and bipolar voltage inputs.
> >> +
> >>    Datasheets for supported chips:
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4111.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4112.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4114.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4115.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4116.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-2.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-4.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7173-8.pdf
> >> @@ -31,6 +42,11 @@ description: |
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - adi,ad4111
> >> +      - adi,ad4112
> >> +      - adi,ad4114
> >> +      - adi,ad4115
> >> +      - adi,ad4116
> >>        - adi,ad7172-2
> >>        - adi,ad7172-4
> >>        - adi,ad7173-8
> >> @@ -129,6 +145,31 @@ patternProperties:
> >>          maximum: 15
> >>
> >>        diff-channels:
> >> +        description: |
> >> +          For using current channels specify select the current input=
s
> >> +           and enable the adi,current-channel property.
> >> +
> >> +          Family AD411x supports a dedicated VCOM voltage input.
> >
> > Did you mean VINCOM? Searching the datasheets for "VCOM" comes up empty=
.
> >
> Yep
> >> +          To select it set the second channel to 16.
> >> +            (VIN2, VCOM) -> diff-channels =3D <2 16>
> >
> > Jonathan mentioned this in v1 with regard to the current inputs, but
> > it applies here too. There is a new proposed single-channel property
> > [1] that would be preferred when an input is used as a single-ended or
> > pseudo-differential input (i.e. with VINCOM or ADCIN15).
> >
> > [1]: https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.rom=
an@analog.com/
> >
> Yet here I thought that it was clear from previous conversations that
> we are not really dealing with a single-ended/pseudo-differential input,
> just a differential ADC that can be used in that manner.
>
> We do not have here such a clear cut case as with AD7194, where an input
> is dedicated for single-ended/pseudo usage. Here, the inputs are mix and
> match and single-ended/pseudo is obtainable with other pins than VINCOM/
> ADCIN15.
>
> When configuring channels we are *always* specifying two voltage inputs.
> I strongly disagree using single-channel for voltage channels in these
> families of ADC's.

Yes, sorry, you are right. I forgot that VINCOM isn't actually
electrically different from the other pins (even if the name makes it
seem like it would be).

>
> >> +
> >> +          There are special values that can be selected besides the v=
oltage
> >> +          analog inputs:
> >> +            21: REF+
> >> +            22: REF=E2=88=92
> >> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, A=
D7177-2:
> >> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> >> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> >> +          Supported only by AD4111, AD4112:
> >> +            12: IIN3+
> >> +            11: IIN3=E2=88=92
> >> +            13: IIN2+
> >> +            10: IIN2=E2=88=92
> >> +            14: IIN1+
> >> +             9: IIN1=E2=88=92
> >> +            15: IIN0+
> >> +             8: IIN0=E2=88=92
> >
> > I just made a late reply on v1 where Jonathan suggested that the
> > current inputs are differential with a similar comment to this:
> >
> > It doesn't seem to me like current inputs are differential if they are
> > only measuring one current. They take 2 pins because you need a way
> > for current to come in and go back out, but the datasheet calls them
> > single-ended inputs.
> >
> It seemed to me that the conclusion that we arrived to was to expose the
> precise pins that are used in the conversion and document the selection.
>
> Yes, it is a single-ended channel. So revert to the way it was in V1 usin=
g
> single-channel?

I'd like to hear Jonathan's opinion on this one.

>
> >> +
> >>          items:
> >>            minimum: 0
> >>            maximum: 31
> >> @@ -154,6 +195,23 @@ patternProperties:
> >>            - avdd
> >>          default: refout-avss
> >>
> >> +      adi,current-channel:
> >> +        description: |
> >> +          Signal that the selected inputs are current channels.
> >> +          Only available on AD4111 and AD4112.
> >> +        type: boolean
> >> +
> >> +      adi,channel-type:
> >> +        description:
> >> +          Used to differentiate between different channel types as th=
e device
> >> +           register configurations are the same for all usage types.
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        enum:
> >> +          - single-ended
> >> +          - pseudo-differential
> >> +          - differential
> >> +        default: differential
> >> +
> >
> > As suggested above, we should soon have diff-channels and
> > single-channel to differentiate between (fully) differential and
> > single-ended. Do we actually need to differentiate between
> > single-ended and pseudo-differential though?
> >
> Not really, so just a bool differential flag? (this seems weird as we hav=
e diff-channels)

Or we need to change the proposed single-channel property to allow two
inputs. I guess we'll see what Johnathan has to say.

>
> > I think the AD4116 datasheet is the only one that uses both of those
> > terms. It gives the examples that for "single-ended" ADCIN15 would be
> > connected to AVSS and for "pseudo-differential" ADCIN15 would be
> > connected to REFOUT (AVSS + 2.5 V). So the only difference seems to be
> > if the voltage on ADCIN15 is =3D=3D 0V or !=3D 0V.
> >
> In the ad411x yes, over to ad717x it's mixed:
> https://lore.kernel.org/all/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.co=
m/
>
> > To make this like other pseudo-differential chips we have done
> > recently, it seems to me like we should have an adcin15-supply
> > property to describe the ADCIN15 input. Then we could use that
> > property to determine single-ended vs. pseudo-differential (if there
> > actually is a need for that) and we wouldn't need the adi,channel-type
> > property.
> >
>
> I agree that we do not need to differentiate between those two.
> But the approach with the supply is too specific, the adi,channel-type
> property is not only for AD4116-ADCIN15, but for all models compatible.
>

Makes sense, especially given the point above that ADCIN15 isn't
really electrically different from other inputs.

> >>      required:
> >>        - reg
> >>        - diff-channels
> >> @@ -166,7 +224,6 @@ allOf:
> >>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>
> >>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> >> -  # Other models have [0-3] channel registers
> >>    - if:
> >>        properties:
> >>          compatible:
> >> @@ -187,6 +244,37 @@ allOf:
> >>                  - vref
> >>                  - refout-avss
> >>                  - avdd
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ad4114
> >> +              - adi,ad4115
> >> +              - adi,ad4116
> >> +              - adi,ad7173-8
> >> +              - adi,ad7175-8
> >> +    then:
> >> +      patternProperties:
> >> +        "^channel@[0-9a-f]$":
> >> +          properties:
> >> +            reg:
> >> +              maximum: 15
> >
> > As discussed recently in the the very similar ad719x bindings [2], we
> > may have been misunderstanding this limit so far. 15 is a bit
> > artificially low since input pins can be used more than once in
> > different "channels". But that is really an issues with the existing
> > bindings, not just this patch.
> >
> > [2]: https://lore.kernel.org/linux-iio/20240511122955.2372f56e@jic23-hu=
awei/
> >
> >
> In this case there is a 1-1 correspondence between this reg limit and the=
 number
> of channel configuration registers available to the device. Maybe another=
 property
> then reg? Sure...but this limitation fits the current situation.
>
> In addition, the device does not work the same as ad719x. If I understood=
 correctly
> that documentation, the configuration register needs to be rewritten for =
every different
> input combination. This means that the driver is implemented to overwrite=
 the reg for
> every read. This device, it seems to me, is more in the liking's of write=
 all the channel
> configs at once, then keep using those.
>
> For AD719x yes, it is artificial. Over here we have a clear reason.

I thought they worked nearly the same in this regard since they are
sharing a lot of code via adc/ad_sigma_delta.h, It looks to me like
the channel registers are only set up for a raw read (single channel)
or buffered read (only enabled channels), but maybe I didn't look deep
enough. Anyway, not a big deal to me.

>
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ad7172-2
> >> +              - adi,ad7175-2
> >> +              - adi,ad7176-2
> >> +              - adi,ad7177-2
> >> +    then:
> >> +      patternProperties:
> >> +        "^channel@[0-9a-f]$":
> >> +          properties:
> >>              reg:
> >>                maximum: 3
> >>
> >> @@ -210,6 +298,34 @@ allOf:
> >>            required:
> >>              - adi,reference-select
> >>
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ad4111
> >> +              - adi,ad4112
> >> +              - adi,ad4114
> >> +              - adi,ad4115
> >> +              - adi,ad4116
> >> +    then:
> >> +      properties:
> >> +        avdd2-supply: false
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          not:
> >> +            contains:
> >> +              enum:
> >> +                - adi,ad4111
> >> +                - adi,ad4112
> >> +    then:
> >> +      patternProperties:
> >> +        "^channel@[0-9a-f]$":
> >> +          properties:
> >> +            adi,current-channel: false
> >> +
> >>    - if:
> >>        anyOf:
> >>          - required: [clock-names]
> >>
> >> --
> >> 2.43.0
> >>
> >>
>

