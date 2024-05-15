Return-Path: <linux-iio+bounces-5059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610C8C6EB3
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 00:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4861F23836
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2024 22:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFB3FBA7;
	Wed, 15 May 2024 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CHC7+ZFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA43CF6A
	for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812679; cv=none; b=jlY0isvS7UlDnrIkJgkXHtwkMvpM9JvHzMvUDt1OK/nMi711kaipIhSaLj55Hm9PHy/MXveG6fFdfePQ51nXCIDolpxvG1qODX7/EbQUdqGJkYqz1f7202vd8E4PJgvXAwlDqd6WtWiHzVQMVU2suONVfi1AY3vwU2N2BbEKcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812679; c=relaxed/simple;
	bh=LAK9gqeeRypr0CEQ5aDcyGWZ/tUpIrRph0fJnrpzPLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzXkEnAhS3UpwA3vmivX9hMExH5w44VtKrx+WTmSQici2oppLcErJF2UOE1kqHlhgG0eT2pSEsCQR/lyWQN8baMNw9VqRTb7rWED5pj2WE+GzjiJKnZzHj40VPJwdPN6ptcoGKRJahrDoF7UQe/JgOr0rr5lAJUIDphrXuWcWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CHC7+ZFK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so904481fa.0
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715812675; x=1716417475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEgmrYZedq/+04pEwI8dkVxH/OdcAS6xqIEmbrHWo0Q=;
        b=CHC7+ZFKOR4jBfKKsKKbWmik++sbf9eOWQEhBsHVP1Q9wxD4f369ss7R+i+Yw+MdO9
         WeOIVDmnw5hVeAALY4GIEWgVaJcrKac/+RlkPHv8OjesuIuXUaJuNLVI4bSEwPFUNQ/l
         lqkRHUcFnt3jZdVYveqisF6GxouSmP+5luwuKOtOQTRM95Wcrwvjkh74rZ4WO9luw77k
         6AtAEI/P28doiqCzYDU378BQMTEAcmFqrBZ5WFyzStrD/24shlCH8SZNR8WdH9TNuqjD
         yGUn2Vb4GE4s6orNwnSu2nKvx4jE5xH8J+ogdH6BfNVwXt6fk1LM/yxWMVoFwTcPa5dL
         LqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715812675; x=1716417475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEgmrYZedq/+04pEwI8dkVxH/OdcAS6xqIEmbrHWo0Q=;
        b=rW250vLZSA1CRLAorjwIMtOS5DnDicnnDGjyQcy4ihgllI/BHNTFXSdx+IKdENwJ6R
         zNsiF0Ldf6LAG2EAdMll/hsN1luggFlGrUC3li914PrIsnH5YmUP8sEgwSYybj03cVmY
         gJ1XbUYKBOrGZA5t1fZ2Jx9o0EyfwND/mrIqUkHUKxtwmS1Ot4i4rFzi/M3CDHUGhx3M
         iQszfGmOyus1jL3/z20yb+oaesZNgak0qc6dCv0uA/iMZjLRlKAB9R3LDVgD/BwaYdKh
         6cOj8uMkgyYEjl0HPQMgVs/HwOKmHtjWsIDP8UiNVQ1ANUpE0RqOouN6dtd5Z7MYOwbj
         6kBw==
X-Forwarded-Encrypted: i=1; AJvYcCUy3bzb3mREaY6f7B9vciMd9YYRYaI7jR3IV9hjUtxdrlriHPoO57OiUD+q3auPAQH4ZP54jkI+kAIqNmJx14A18UeXMaLPw2Pn
X-Gm-Message-State: AOJu0YywxSl6datHU0jBMFE10jaoduCMyILem/wDMvdt1RjDR1LQUlST
	6KrUkbUDfYK0XAmPfi9voz8WasHU9RlV4IC3vzEmiiIvL7z3jIYHCcPwYy4jxy17++4jIGJiadE
	PzssFkd86pPDG3S3TqNBHsEkhKDZ3DboJKIV5vg==
X-Google-Smtp-Source: AGHT+IEA5Xebu+d/Kazl51uTWY4Wh2PV4hE69tsoGDHyjJbf8kuPYIFrAGIwg3u8xDi54yb67790MNscNLLyZWBFuAw=
X-Received: by 2002:a2e:868f:0:b0:2df:8e58:d05c with SMTP id
 38308e7fff4ca-2e51ad435admr55107431fa.15.1715812674616; Wed, 15 May 2024
 15:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com> <20240514-ad4111-v2-1-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-1-29be6a55efb5@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 15 May 2024 17:37:43 -0500
Message-ID: <CAMknhBGNPvxegL+YbnLGoKjA=P3Vx=x+39aXuMgq+cv2KgdeLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: adc: ad7173: add support for ad411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>
> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
> AD4111/AD4112 support current channels, usage is implemented by
>  specifying channel reg values bigger than 15.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 118 +++++++++++++++=
+++++-
>  1 file changed, 117 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index ea6cfcd0aff4..6cc3514f5ed8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -19,7 +19,18 @@ description: |
>    primarily for measurement of signals close to DC but also delivers
>    outstanding performance with input bandwidths out to ~10kHz.
>
> +  Analog Devices AD411x ADC's:
> +  The AD411X family encompasses a series of low power, low noise, 24-bit=
,
> +  sigma-delta analog-to-digital converters that offer a versatile range =
of
> +  specifications. They integrate an analog front end suitable for proces=
sing
> +  fully differential/single-ended and bipolar voltage inputs.
> +
>    Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4111.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4112.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4114.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4115.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4116.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> @@ -31,6 +42,11 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad4111
> +      - adi,ad4112
> +      - adi,ad4114
> +      - adi,ad4115
> +      - adi,ad4116
>        - adi,ad7172-2
>        - adi,ad7172-4
>        - adi,ad7173-8
> @@ -129,6 +145,31 @@ patternProperties:
>          maximum: 15
>
>        diff-channels:
> +        description: |
> +          For using current channels specify select the current inputs
> +           and enable the adi,current-channel property.
> +
> +          Family AD411x supports a dedicated VCOM voltage input.

Did you mean VINCOM? Searching the datasheets for "VCOM" comes up empty.

> +          To select it set the second channel to 16.
> +            (VIN2, VCOM) -> diff-channels =3D <2 16>

Jonathan mentioned this in v1 with regard to the current inputs, but
it applies here too. There is a new proposed single-channel property
[1] that would be preferred when an input is used as a single-ended or
pseudo-differential input (i.e. with VINCOM or ADCIN15).

[1]: https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.roman@a=
nalog.com/

> +
> +          There are special values that can be selected besides the volt=
age
> +          analog inputs:
> +            21: REF+
> +            22: REF=E2=88=92
> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD71=
77-2:
> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> +          Supported only by AD4111, AD4112:
> +            12: IIN3+
> +            11: IIN3=E2=88=92
> +            13: IIN2+
> +            10: IIN2=E2=88=92
> +            14: IIN1+
> +             9: IIN1=E2=88=92
> +            15: IIN0+
> +             8: IIN0=E2=88=92

I just made a late reply on v1 where Jonathan suggested that the
current inputs are differential with a similar comment to this:

It doesn't seem to me like current inputs are differential if they are
only measuring one current. They take 2 pins because you need a way
for current to come in and go back out, but the datasheet calls them
single-ended inputs.

> +
>          items:
>            minimum: 0
>            maximum: 31
> @@ -154,6 +195,23 @@ patternProperties:
>            - avdd
>          default: refout-avss
>
> +      adi,current-channel:
> +        description: |
> +          Signal that the selected inputs are current channels.
> +          Only available on AD4111 and AD4112.
> +        type: boolean
> +
> +      adi,channel-type:
> +        description:
> +          Used to differentiate between different channel types as the d=
evice
> +           register configurations are the same for all usage types.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - single-ended
> +          - pseudo-differential
> +          - differential
> +        default: differential
> +

As suggested above, we should soon have diff-channels and
single-channel to differentiate between (fully) differential and
single-ended. Do we actually need to differentiate between
single-ended and pseudo-differential though?

I think the AD4116 datasheet is the only one that uses both of those
terms. It gives the examples that for "single-ended" ADCIN15 would be
connected to AVSS and for "pseudo-differential" ADCIN15 would be
connected to REFOUT (AVSS + 2.5 V). So the only difference seems to be
if the voltage on ADCIN15 is =3D=3D 0V or !=3D 0V.

To make this like other pseudo-differential chips we have done
recently, it seems to me like we should have an adcin15-supply
property to describe the ADCIN15 input. Then we could use that
property to determine single-ended vs. pseudo-differential (if there
actually is a need for that) and we wouldn't need the adi,channel-type
property.

>      required:
>        - reg
>        - diff-channels
> @@ -166,7 +224,6 @@ allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>
>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> -  # Other models have [0-3] channel registers
>    - if:
>        properties:
>          compatible:
> @@ -187,6 +244,37 @@ allOf:
>                  - vref
>                  - refout-avss
>                  - avdd
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4114
> +              - adi,ad4115
> +              - adi,ad4116
> +              - adi,ad7173-8
> +              - adi,ad7175-8
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            reg:
> +              maximum: 15

As discussed recently in the the very similar ad719x bindings [2], we
may have been misunderstanding this limit so far. 15 is a bit
artificially low since input pins can be used more than once in
different "channels". But that is really an issues with the existing
bindings, not just this patch.

[2]: https://lore.kernel.org/linux-iio/20240511122955.2372f56e@jic23-huawei=
/


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7172-2
> +              - adi,ad7175-2
> +              - adi,ad7176-2
> +              - adi,ad7177-2
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
>              reg:
>                maximum: 3
>
> @@ -210,6 +298,34 @@ allOf:
>            required:
>              - adi,reference-select
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4111
> +              - adi,ad4112
> +              - adi,ad4114
> +              - adi,ad4115
> +              - adi,ad4116
> +    then:
> +      properties:
> +        avdd2-supply: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - adi,ad4111
> +                - adi,ad4112
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,current-channel: false
> +
>    - if:
>        anyOf:
>          - required: [clock-names]
>
> --
> 2.43.0
>
>

