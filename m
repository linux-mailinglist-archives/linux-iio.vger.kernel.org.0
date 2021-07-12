Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E713C617C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhGLRIP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhGLRIO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 13:08:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57FC0613DD;
        Mon, 12 Jul 2021 10:05:26 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 77so16894108qkk.11;
        Mon, 12 Jul 2021 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=qW4vqa6NnfEq0ub2+w7VBcq1lWh4sV+Zl2mjOZ0rHKw=;
        b=JIlgREPo/qGJuHW6y2IUEsJ8vXSOJ0Z03XbkP7R/RUmI0AoJN+Z0KVLI1WqmbJ6INE
         sbSGJU69B4rc97mt8yz5eDY91M7B/uRFizkKY8My0IKNxwnopy0vVGJ/HByp3S8rYEhF
         64AK9Mbx1I8oxN1SNHHfvu5vlbs2AxJAKcILk18i/AUdfumft3BZY0KT8aeAjMgWyRuf
         nB69cEVAYm8UBwd35UZHZGBZ8qdzcBBEShHWK3LrrsDEHVxBqDy5FUmimI4Y9Vcrq8NV
         5s6zpHW9KdecBStLlxiS0DzeIOmPHo1Nyn0t60DRj0obKM9wxUvHgrzP0mU56+prlQ50
         wpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=qW4vqa6NnfEq0ub2+w7VBcq1lWh4sV+Zl2mjOZ0rHKw=;
        b=a1QBOaFgYrdObIpbUuVctORlFcnReQVz5p/XHbQcjECWUpiImU4fl+J3hXElf0MqcL
         b4C57uzcGIK/vPyWClcrWO5nPMz3c3oYb8mkN+MbfwAf29sHZ0qP5KHPy1wxLObeM2fu
         TFlnr1WFGeaf/stSoAIBiScwBRDoqjzKCqsIAtlR4EByZSAZp2b9RiWGLQST/hMfojDh
         k3/AculRPQEgRIL6cJvrWMfAKvE/+B/J0xkqFSUkIvVzlxnyGBTve4H1MsM1ABT2KP2q
         hNFEpZg5aCIwxQghYUpfaeuBYi3A8j5aGZ4r/tqrDYbBQ8GBz6SPJr10sC+AEPcN2MSk
         95zw==
X-Gm-Message-State: AOAM533AMYJrXcAlTouVzenr46fjzJZoPUbYHPVlbJmJw+L5PaHzHFFj
        T+7YpTL1wwqlTz7aY8KC3ZA=
X-Google-Smtp-Source: ABdhPJxMvILkCudEGp4iByocnGwNPm6xwP0S2sKOmh+OkKpC0mI85oIHD4p0I5bgaYFtcLCCdEZzog==
X-Received: by 2002:a37:a2d4:: with SMTP id l203mr49010486qke.154.1626109525573;
        Mon, 12 Jul 2021 10:05:25 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id b6sm5875606qtg.1.2021.07.12.10.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 10:05:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Jul 2021 13:05:23 -0400
Message-Id: <CCRBPUEYGCAC.CJ1Y3GDWQYYJ@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
 <20210709155856.1732245-5-liambeguin@gmail.com>
 <20210710180001.051f7367@jic23-huawei>
In-Reply-To: <20210710180001.051f7367@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat Jul 10, 2021 at 1:00 PM EDT, Jonathan Cameron wrote:
> On Fri, 9 Jul 2021 11:58:56 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Add bindings documentation for the adi,reference-source property.
> > This property is required to properly configure the ADC sample request
> > based on which reference source should be used for the calculation.
>
> Should this be per channel? That will effect some of what I say below...
>

We could make it per channel. Ideally, I'd also like to add support for
differential channels, so might as well add per channel configurations
now.

> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7949.yaml          | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > index 9b56bd4d5510..eae3121cad01 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > @@ -35,6 +35,27 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> > =20
> > +  adi,reference-select:
>
> This is one field in the register, but it's not one thing, so lets break
> it up
> in DT. We should do this both to make for more readable dts files and to
> enforce the requirements on regulators...
>
> > +    description: |
> > +      Select the reference voltage source to use when converting sampl=
es.
> > +      Acceptable values are:
> > +      - 0: Internal reference and temperature sensor enabled.
> > +           Vref=3D2.5V, buffered output
> > +      - 1: Internal reference and temperature sensor enabled.
> > +           Vref=3D4.096V, buffered output
> > +      - 2: Use external reference, temperature sensor enabled.
> > +           Internal buffer disabled
> > +      - 3: Use external reference, internal buffer and temperature sen=
sor
> > +           enabled.
> > +      - 6: Use external reference, internal buffer and temperature sen=
sor
> > +           disabled.
> > +      - 7: Use external reference, internal buffer enabled.
> > +           Internal reference and temperature sensor disabled.
>
> So question 1 is whether to use an external or internal reference.
> Normally we'd make the coarse decision of whether to use an external
> reference
> by whether there is a regulator provided. That won't work so well if we
> make
> this per channel.
>
> Question 2, assuming internal reference, what voltage? Those should take
> an actual voltage (probably in mV and match against an enum of the two
> possible values).
> Binding should check to make sure this isn't specified as well as saying
> we
> are using an external refernce.
>
> Question 3, assuming external reference, is temperature sensor enabled?
> - actually dumb question, but why would anyone not want this enabled?
> Maybe turn it
> off in runtime pm, but in general if you've fitted a chip with a
> temperature sensor
> you at least sometimes want to measure temperature! So my gut feeling is
> don't
> allow this to be controlled (effectively drop cases 6 and 7 above as
> being
> unlikely to be of interest to anyone)
>

I like your suggestion of breaking this down so far, it would look
something like this:

	ad7949: adc@0 {
		compatible =3D "adi,ad7949";
		reg =3D <0>;

		vref-supply =3D <&vdd_supply>;

		channel@0 {
			adi,internal-ref-mv =3D <2500>;
			reg =3D <0>;
		};

		channel@1 {
			reg =3D <1>;
			/*
			 * defaults to vref-supply if defined or error
			 * out
			 */
		};
	};

> Question 4, Is the internal buffer enabled when using and external
> reference.
> This one is interesting. We could just expose it in general, but I
> wonder
> if we can do something that reflects how it is used. From the various
> figures in
> the datasheet this seems to be coupled to whether the external reference
> is on
> pin REF_IN or pin REF. If that's the case can we have two optional regs
> only
> one of which should be supplied? However, this gets more fiddly because
> the default right now is vref-supply actually being connected to the
> vrefin connection.
> That's annoying as it stops us using the obvious naming...
> Hence I think we can have
> vref-supply (actually connected to vrefin) and vref-unbuffered-supply
>

I really like the idea of using the same names as the datasheet
(vref-supply and vrefin-supply), to infer the buffered state,
but it's annoying (and confusing) that it's setup the other way
right now.

I wonder what happens if the reference is connected to refin and we're
configured as unbuffered (and the other way around).
I looked around and I might be able to test it on one setup I have where
the external reference is connected to REF.

If it's not a breaking change, would it be okay with you to follow the
datasheet naming?

Liam

>
>
> > +
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 6, 7]
> > +    default: 7
> > +
> >  required:
> >    - compatible
> >    - reg
