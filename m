Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC573A1F5E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIVwW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 17:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIVwT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 17:52:19 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F82C061574;
        Wed,  9 Jun 2021 14:50:12 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x2so12988492qvo.8;
        Wed, 09 Jun 2021 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=oAAcTHn7zsGOU/9mFCsBJNXCxut5oRA11Oha7/kgmbM=;
        b=DhkPHswMA8Q08Myri2fJaeFyu4jBcPmLelZCB3wccmsAQQ7usGBBeA4Qin14GKETr4
         Gq0ARzSZH3Ks754X2Yvjcb9uf7Vvz0o9D0OZhYBabFeaWjo0Jo7Nb9iZ4lJyaTxgp42j
         FpopnjLTxvKBsKf0imDNTfkwo8QK4vpr2Ll6k1Xsu/GJu+8wXe5ir+WZ4mi3J7jwuSpb
         M2bX+EAXA6T9cZUFWl4rFBlMzwAEQSNZgvjTXU8ws1tzMnYD+VteIoAQoTUvRak//1SI
         Pgv362ttPgUh6gw0lAoh9sDuhHf2T/PVc480S84ApAd8AzlOti8PwLGfP/PZIlrpLe6D
         zMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=oAAcTHn7zsGOU/9mFCsBJNXCxut5oRA11Oha7/kgmbM=;
        b=PZguZRnEsO+PJmz6mH+l5c0u7E624Xd8vs8FBChy7dxKTTZPOlfDOlEOCSSRuLeM/t
         ora46pbTAPT57iOwOBObm5UHDgSaso6x6/GGffFwkz5ukLmUjQREUQHHtOG01j7bm4Y9
         Av69H5iidZ0GiYxd3LpO0TzHQNCFXWZ2HEgA5cdIYRA0ytjCEDUv/cfMwm/PWaVchMsE
         6FF52wGrbcfLmUa7UNhqsElvVo6SQE3JDxk7eH1oom52EDuN2yHuKpO0kI56YD/xOWsl
         E2wyn5b1X4VYy41ZQ921EsJ//KQZW0m6uWK9UxyW0gUmXpWuYQiDu0DfNK825hTVe5b9
         9GFw==
X-Gm-Message-State: AOAM5328DDd8sKpgn3Lr6Ccj4kD2ez/1AogdIu6eBVMoLn4liU/jxRq7
        dULNoyh5a5PVmNXTA8btBsP5ima2z/0Row==
X-Google-Smtp-Source: ABdhPJyYOckGPac+wKTiLT4XLKMy03Z76MhWJ9yoiyuSItaBCkGWnXt4bMWZhKsxFppoBFXmWx0NCw==
X-Received: by 2002:a05:6214:c28:: with SMTP id a8mr2003543qvd.11.1623275411243;
        Wed, 09 Jun 2021 14:50:11 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm1005824qkh.19.2021.06.09.14.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:50:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 09 Jun 2021 17:50:09 -0400
Message-Id: <CBZF3WD2U0HO.19APPB2DD2S4P@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 8/8] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-9-liambeguin@gmail.com>
 <20210609215214.7e3be504@jic23-huawei>
In-Reply-To: <20210609215214.7e3be504@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed Jun 9, 2021 at 4:52 PM EDT, Jonathan Cameron wrote:
> On Mon, 7 Jun 2021 10:47:18 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe such a use case, the measurement of a temperature
> > through an analog front end connected to a voltage channel.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperatu=
re-sense-amplifier.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sens=
e-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-se=
nse-amplifier.yaml
> > new file mode 100644
> > index 000000000000..08f97f052a91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-ampli=
fier.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-amplifier=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Temperature Sense Amplifier
> > +
> > +maintainers:
> > +  - Liam Beguin <lvb@xiphos.com>
> > +
> > +description: |
> > +  When an io-channel measures the output voltage of a temperature anal=
og front
> > +  end such as an RTD (resistance thermometer) or a temperature to curr=
ent
> > +  sensor, the interesting measurement is almost always the correspondi=
ng
> > +  temperature, not the voltage output. This binding describes such a c=
ircuit.
>
> Perhaps add something about this only covering the linear cases...
>

Okay, will do.

> > +
> > +properties:
> > +  compatible:
> > +    const: temperature-sense-amplifier
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +    description: |
> > +      Channel node of a voltage io-channel.
> > +
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> > +  sense-gain-mult:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Amplifier gain multiplier. The default is <1>.
> > +
> > +  sense-gain-div:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Amplifier gain divider. The default is <1>.
> > +
> > +  sense-offset-millicelsius:
> > +    description: Amplifier offset. The default is <0>.
>
> Whilst it may seem obvious I'd like to see a statement of
> how these are used somewhere in here.
>
> temp_celcius =3D voltage * gain-mult / gain-div + offset
>
> Mainly because those familiar with the IIO usage of offset
> would expect
> (voltage + offset) * gain-mult/gain-div
>
> which doesn't make sense for this device but might leave
> people confused!
>

You're right, I'll add an explicit statement of how these parameters are
used.

Thanks,
Liam

> > +
> > +additionalProperties: false
> > +required:
> > +  - compatible
> > +  - io-channels
> > +
> > +examples:
> > +  - |
> > +    pt1000_1: temperature-sensor {
> > +        compatible =3D "temperature-sense-amplifier";
> > +        #io-channel-cells =3D <1>;
> > +        io-channels =3D <&temp_adc 3>;
> > +
> > +        sense-gain-mult =3D <1000000>;
> > +        sense-gain-div =3D <3908>;
> > +        sense-offset-millicelsius =3D <(-255885)>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e679d422b472..4f7b4ee9f19b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8887,6 +8887,7 @@ L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.y=
aml
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifi=
er.yaml
> >  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> >  F:	drivers/iio/afe/iio-rescale.c
> > =20

