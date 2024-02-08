Return-Path: <linux-iio+bounces-2326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51F84EA05
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 22:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C485B2251D
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAA4C3BF;
	Thu,  8 Feb 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T1xQahhz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF145BFB
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426139; cv=none; b=qzD3I0T1a6MmVKT7/4O4mSpVzqqkNjAj43G4UoA5T4mTUqQa5Sv5zikioUOCS2hwJytj2zpBV9sZk37LrRprmgjKx4/TL47AtpxUTPvhP150HfbPOo8SceAMi5QjvEwdTPsncQTeuNu0EoTUKvC5Q5jHI0HPQarLNwJe5cfOn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426139; c=relaxed/simple;
	bh=MPrJBQh0W6C64dmzyrjqYpEo6yYMroytIsZryjcV2xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbXR3d64zBkeZY45ArH+s14BPMS8v9E/v1qHwNuVoV+pWHBzmmX4z0veHOtk05BkYeJWAQANMfugHkDrNvAWh8kN6cFsBAH1KlL6Av5d38UPK1yL7a0srO7/DqGAa6TtUo3jCCQ3oG/sEgiVhban/+ndm9mqXpZYrQxle3R571c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T1xQahhz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0ce22b5f3so3692571fa.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707426133; x=1708030933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvjjVV3OVJFdrzwIkpIwh6ZmUksDN+MlaodV5B8GHkw=;
        b=T1xQahhzu1/VM2C03o7nTHgQLkWg3fbs62zGpOKGVS3VsJt6D9EMXqUQbm0F84gzvf
         emw602XVAV3QF7+zEfuC/JqzUExHrMEqkcxUymH13912dbVVEh4jsJWgZ5qlm3V3ERbf
         KKi3BrpYpX4enwtgAojLD0QfpTm7Pve68dKUxaDLqVTi1jlhuZUSQ1+IQuy/a3UUQmQ+
         KiAYeELgmwAxaa6GaHqxUXixTKeYcedLyJAPInqrY05YbF0Zrsnn/aRIRVWJXCu1Sksk
         +GWP9U71H+AJlCcg1vO+TBsm0xXiQuljhDCE9ph3CgVw4D0qoRlurrcaW8N+tWZYoOwL
         YH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707426133; x=1708030933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvjjVV3OVJFdrzwIkpIwh6ZmUksDN+MlaodV5B8GHkw=;
        b=U6BhUZTaKF3YVp33BERg0qjxYafFC+cEurfb/l+Go19bK+60UCw33ysuGAgERK6fix
         W2VSU2QYQ62K9ru8PuRLw44URScboAGAkWvXKXkML+bGMS/M3jBCU0LiE4001SEOmW2o
         R6MOsd5qu+zN35y78JyVgq1TXzmhD5dTMHUWmlZH4RM4oY3c4NkNleYcHI4tjBFQPvvt
         b6a69u1li8AbwQ40QT7v6bKkntgMSGO8pZ1ScxfVwi6TkQ+RbOpIs8ruOJfVBGHyPtNa
         NHSG1Vb9+67JoGMKtn2G8xGelsriYO+jF3NkKNBgACAr7vs1JBLUOb5fLglxBloDkHQK
         q64g==
X-Forwarded-Encrypted: i=1; AJvYcCXWH5WPUJDns4bA/6xxyEinxuEgzUE1rLYyBnTe1v8er7lz4GwzgAJDc2oAlWhnUTqaktD9L8kE/PFwcDr9+k2VTy+fmj37Qbpu
X-Gm-Message-State: AOJu0Yw88bPug0+lSpi4dLYq7hWDYAlOOkKkcoegdnNz/7SUQeaEEtpZ
	bpvZI8scEbN3TvwSIIfyJgrTa0UUe54g0JMuPJL/nOta0GbvSbXLgf2vsWTnVzHi1EDbrMICLQX
	LK5ZmT9kQelSGF9wb6ktENXPu4iWgP7wb3joctg==
X-Google-Smtp-Source: AGHT+IEmOae9wjka2hbpxlHm4kKA6Qy7H854xuj1LZpVQ0vWiZs28kTzmDWZLUiDYbmoFUh7D3xPfCz302NM5h7HR7c=
X-Received: by 2002:a2e:8550:0:b0:2d0:d294:60f3 with SMTP id
 u16-20020a2e8550000000b002d0d29460f3mr336715ljj.37.1707426133301; Thu, 08 Feb
 2024 13:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208172459.280189-1-alisa.roman@analog.com> <20240208172459.280189-5-alisa.roman@analog.com>
In-Reply-To: <20240208172459.280189-5-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 8 Feb 2024 15:02:02 -0600
Message-ID: <CAMknhBGauvnrNipcAoVrM5xnTHWoHyYuzDxmz=AY9_QHigwsAQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:25=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
>
> Also add an example for AD7194 devicetree.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..169bdd1dd0e1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>
> @@ -96,8 +103,44 @@ required:
>    - spi-cpol
>    - spi-cpha
>
> +patternProperties:
> +  "^channel@([0-7a-f])$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 0
> +        maximum: 7

Should the max be 16 since in pseudo-differential mode there can be up
to 16 inputs?

> +
> +      diff-channels:
> +        description: |
> +          The differential channel pair for Ad7194 configurable channels=
. The

all caps: AD7194

> +          first channel is the positive input, the second channel is the
> +          negative input.
> +        items:
> +          minimum: 1
> +          maximum: 16

As someone who would need to write a .dts based on these bindings, the
information I would find helpful in the description here is that this
is specifying how the logical channels are mapped to the 16 possible
input pins. It seems safe to assume that the values 1 to 16 correspond
to the pins AIN1 to AIN16, but it would be nice to say this
explicitly. And what do we do when using pseudo-differential inputs
where AINCOM is used as the negative input? Use 0?

> +
> +    required:
> +      - reg
> +      - diff-channels
> +
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7190
> +            - adi,ad7192
> +            - adi,ad7193
> +            - adi,ad7195
> +    then:
> +      patternProperties:
> +        "^channel@([0-7a-f])$": false
>
>  unevaluatedProperties: false
>
> @@ -127,3 +170,35 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            compatible =3D "adi,ad7194";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            clocks =3D <&ad7192_mclk>;
> +            clock-names =3D "mclk";
> +            interrupts =3D <25 0x2>;
> +            interrupt-parent =3D <&gpio>;
> +            dvdd-supply =3D <&dvdd>;
> +            avdd-supply =3D <&avdd>;
> +            vref-supply =3D <&vref>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                diff-channels =3D <1 6>;
> +            };
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                diff-channels =3D <2 5>;
> +            };
> +        };
> +    };
> --
> 2.34.1
>

