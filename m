Return-Path: <linux-iio+bounces-11063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE109ADF03
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D8428A446
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6A1AF0C4;
	Thu, 24 Oct 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dJLlWfvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01157166F07
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757991; cv=none; b=rBkINu4t6uDv0HGvmyQxqAwqV2cSHi3Ggnrs0MHFt3yyIXIvD957XSVkEDntLmFQEs3FgaGnZ1FFiSAVuZ6BfSsOOqfb8YFpSUesC8LHX8nPhfzyoiik09CVYL8obHKVsbKqR8X6QIgHwaQUYhW9f75zy8+BBtFOfmODhzlqYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757991; c=relaxed/simple;
	bh=jJpoDcZzcf17R/3zdN17SftmPrsJXoXPfK84W/H5pz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzjGMwGeGnOeoKlkOtepDC3DDPnKWtbhslDHY1r2mwX0dFJCgUsl87mdb0z9NHso/+cZ9TpvtbDxmvJOgQX7s0VIqh4FKnAGnDwKgB8YZD3TyPgpHfZ3xodtjlW06UXYaNCBP7s9ULGMytPQJspmtFrHph5ezEQLRkMSeJ79NC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dJLlWfvX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso769943a12.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729757987; x=1730362787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs/aKFg3NFl0djqnSQfP+JloM/IzfO1teCS8RmqnkF8=;
        b=dJLlWfvXuhEKV0cSSRuOIDOdoPHHuGdzxu9B+6jm46B80TYgrX0h+hQXfhixIuYYJJ
         qgRVvlJe9svZ9oVRdWbRIU+Aa8Vuzbc6pyuaHb1jZMRsU6OJuFzR71W2WLh+ldFLceR4
         t3MNYG1W2MeyAPsWN+MygfzO35/uqVg35n88qQj0XiFSpkhodFEdEW+wS1aoJ4e9PKT5
         P1KwDcuv9JY8by1A9yhl81vR41rtf7tIwcGFwruUU0wK4x71dstoOlbflynVKi5wUSyh
         QGInFRNWIr6UD77kjZCGo491No9yzObgGnx3Skl/+ep2sXxrExWdfGgeEBbO/54KIoZv
         yuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757987; x=1730362787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs/aKFg3NFl0djqnSQfP+JloM/IzfO1teCS8RmqnkF8=;
        b=k0lGAwel1dYYgXOLOX6OEdVtfHk22Aal6dT9XE9LNlzJbFRsAfUbjNQifSXQTttOAy
         tCKTj2t6hM+iOqlzC/6YfeT3VtUtuPOpxrKvxSVEEN/F0BL0IN8rZ2NmZVWwvmOCQJLt
         jCLbM8Xl21TB7xFYOPpDZW9C2nxOIOPpGgAh8ZeM2DqCybVdriQ5t7LfAkAuYG4Cd8o9
         kgVBQ2hGGBhDaqJSZAf+pqwVhmsbsCeUzB4NtmGHC5mrUd45+hTQ8Vkk31MVtdo6owzq
         F18I3ibha4A24tupDQoTgRSTavYTFTD5RaE0okspWBB0RdjZO2fgKvWvmnICkdllw2yE
         3xpA==
X-Forwarded-Encrypted: i=1; AJvYcCVIydqT44+sfJk7WTXTPnrQVjjynAwNBjD3GXgq+ckJIuMIcLpfIvyhrR8m4VGdCwMnWc8wx005P2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiS28UrEn8DaYy7tO/FvTVdBLj55b0yWY2To17Zzm0OLX8cqg
	JrqVZ8tY8r0r4HMRwsidpWb9MrcqkP/aaJdZqBGPXDe3EvAT6V08bBVPnR8kg1XLkL9+ZTIHcTD
	Tsj95UyplGMiM+T41tO3AXKJkaF9WCqMwhQbcsg==
X-Google-Smtp-Source: AGHT+IEUz97/zglX4GUT3Pds+XQ9vhw/84CeXDgQkpGMRP1blc6osQow8h9eQWkAj9ZNoShkMCwOCiaT+o5nm4LK8oY=
X-Received: by 2002:a17:907:3206:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a9abf8d2614mr562372866b.38.1729757987320; Thu, 24 Oct 2024
 01:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
 <20241023-ad7380-add-adaq4380-4-support-v2-1-d55faea3bedf@baylibre.com> <7uih5kvpy6i4ggq5o7eudzczbicopbdnmbtkyprfperkkqgsmt@42q6bncox3ml>
In-Reply-To: <7uih5kvpy6i4ggq5o7eudzczbicopbdnmbtkyprfperkkqgsmt@42q6bncox3ml>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 10:19:32 +0200
Message-ID: <CAEHHSvY3QWkjDo6LdyFg-X+UnyY-cJ6kAFUYP-ZWBqgHoKxmkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4 and
 adaq4380-4 compatible parts
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 24 oct. 2024 =C3=A0 09:29, Krzysztof Kozlowski <krzk@kernel.org> a =
=C3=A9crit :
>
> On Wed, Oct 23, 2024 at 11:19:33AM +0200, Julien Stephan wrote:
> > +  vs-p-supply:
> > +    description:
> > +      Amplifiers positive supply.
> > +
> > +  vs-n-supply:
> > +    description:
> > +      Amplifiers negative supply.
> > +
> > +  ldo-supply:
> > +    description:
> > +      LDO supply. Connect to vs-p-supply or a 3.6 to 5.5 V supply.
> >
> >    aina-supply:
> >      description:
> > @@ -97,12 +115,46 @@ properties:
> >        specify the ALERT interrupt.
> >      maxItems: 1
> >
> > +  '#address-cells':
>
> If there is going to be new version/resend, then keep consistent quotes:
> " or '.
>
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - vcc-supply
> >    - vlogic-supply
> >
> > +patternProperties:
> > +  "^channel@([0-3])$":
>
> () are not necessary
>
> > +    $ref: adc.yaml
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The channel number. From 0 to 3 corresponding to channels A,=
B,C,D
> > +        items:
> > +          minimum: 0
> > +          maximum: 3
>
> No improvements, no response to comment.

Hi Krzysztof,

I am sorry, it got lost during my rebase. It was planned to be on the
v2 (even added it to the changelog in the cover letter).
Thank you for noticing it.  I sent a v3 with all the changes.

Cheers
Julien
>
> > +
> > +      adi,gain-milli:
> > +        description:
> > +          The hardware gain applied to the ADC input (in milli units).
> > +          If not present, default to 1000 (no actual gain applied).
> > +          Refer to the typical connection diagrams section of the data=
sheet for
> > +          pin wiring.
> > +        $ref: /schemas/types.yaml#/definitions/uint16
> > +        enum: [300, 600, 1000, 1600]
> > +        default: 1000
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> >  unevaluatedProperties: false
> >
> >  allOf:
> > @@ -140,6 +192,7 @@ allOf:
> >          aind-supply: false
> >
> >    # ad7380-4 uses refin-supply as external reference.
> > +  # adaq devices use internal reference only, derived from refin-suppl=
y
> >    # All other chips from ad738x family use refio as optional external =
reference.
> >    # When refio-supply is omitted, internal reference is used.
> >    - if:
> > @@ -147,6 +200,8 @@ allOf:
> >          compatible:
> >            enum:
> >              - adi,ad7380-4
> > +            - adi,adaq4370-4
> > +            - adi,adaq4380-4
> >      then:
> >        properties:
> >          refio-supply: false
> > @@ -156,6 +211,27 @@ allOf:
> >        properties:
> >          refin-supply: false
> >
> > +  # adaq devices need more supplies and using channel to declare gain =
property
> > +  # only applies to adaq devices
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - adi,adaq4370-4
> > +            - adi,adaq4380-4
> > +    then:
> > +      required:
> > +        - vs-p-supply
> > +        - vs-n-supply
> > +        - ldo-supply
> > +    else:
> > +      properties:
> > +        vs-p-supply: false
> > +        vs-n-supply: false
> > +        ldo-supply: false
> > +      patternProperties:
> > +        "^channel@([0-3])$": false
>
> () are not necessary
>
> Best regards,
> Krzysztof
>

