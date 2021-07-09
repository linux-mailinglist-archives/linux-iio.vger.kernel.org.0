Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4ED3C25C3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhGIOWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhGIOWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 10:22:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E28C0613DD;
        Fri,  9 Jul 2021 07:19:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g14so4578231qvo.7;
        Fri, 09 Jul 2021 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=AbweScTu+CSzzG5mO4s7QPojjdx+SBj/a+asVBSmxkc=;
        b=AouQHaKb6+HOpTFdltm93W8St56GH1+1PuGJjLNIpUiwKG9speTcmC40C+LWa1/1+4
         0ryUgO0gUJohod1AQFCH7KzpugukPVSDEfB9hD4H2q7aF2/9hE+pKWaXiBiBuOzSDEb0
         eWuOafwk9liKfVYg+p96ZeervMswHHHaLj7lpbKBFF70qr42GLE8qTZk6m0/H3Lp0yfX
         TQ7WfpijYv2j2FtCB87oFVxcbd2neTsUkUS3P5U9yq6GAF9lMc0ZM0QfxWK0aIrVuI/Q
         ipChWl9FoyWCfGGCRwRTEcVv4PaMIa2ZrFh2Imkvbgev2q/zHXEO7cn4e1mc9IPWocp3
         aoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=AbweScTu+CSzzG5mO4s7QPojjdx+SBj/a+asVBSmxkc=;
        b=oelpxtHlN0yqGIY8/wFSv/63CSmGnzfhEg56TX4jyY1DJg6/Urd/hc3WXH6Dolb0Wq
         URFZ8hb3e4Hlt0g0Trmnsr3kiM2eNq3vGuVaJZ3U+XAzdVRKkJ0jHt/cZN2+tt/X0MtD
         lsn3iFDI+WBQS6xUCuNqGIAMvExbo15cIvqPql83SYrvyAdY/rv7GJ9weqRbZagjb2qC
         DC8x98T6nrPofK5aFL2HKbJq2s981gBneRenxJ0fYchmQzs9DY8VTxYaUSkNSWs5yDmM
         U/h/DUywulKppwiJma3KmS4fCX7JMP77pl5ZlnqLGdp3Jj7lai6qasTcrT42f1rDJ8LV
         usEw==
X-Gm-Message-State: AOAM53144HlebYChcG0XzTnCx4RjGmIH6K2rdtMwv5Xa5g3lTnzhfNXz
        1YkB3diefA+mzss2lNSS2NY=
X-Google-Smtp-Source: ABdhPJxVob48UIFSG4unefpkzdf7LQRsfXIysItrnGJy6edT/WhDIivxlCG3JhYAzxUZeZVD6VMGCg==
X-Received: by 2002:ad4:4150:: with SMTP id z16mr12453311qvp.39.1625840369290;
        Fri, 09 Jul 2021 07:19:29 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s6sm2462794qkc.125.2021.07.09.07.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:19:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 10:19:27 -0400
Message-Id: <CCOOB5Y7NI0J.QOZXSZ74JNFI@shaak>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-5-liambeguin@gmail.com>
 <PH0PR03MB6366E7E1CBDC15B6B43F8BC699189@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366E7E1CBDC15B6B43F8BC699189@PH0PR03MB6366.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

On Fri Jul 9, 2021 at 4:15 AM EDT, Sa, Nuno wrote:
>
>
> > -----Original Message-----
> > From: Liam Beguin <liambeguin@gmail.com>
> > Sent: Friday, July 9, 2021 1:56 AM
> > To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> > antoine.couret@essensium.com
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org
> > Subject: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
> > adi,reference-source
> >=20
> > [External]
> >=20
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Add bindings documentation for the adi,reference-source property.
> > This property is required to properly configure the ADC sample request
> > based on which reference source should be used for the calculation.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7949.yaml          | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > index 9b56bd4d5510..3f4629281cc8 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > @@ -35,6 +35,28 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> >=20
> > +  adi,reference-select:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [0, 1, 2, 3, 6, 7]
> > +
> > +    default: 7
> > +    description: |
> > +      Select the reference voltage source to use when converting
> > samples.
> > +      Acceptable values are:
> > +      - 0: Internal reference and temperature sensor enabled.
> > +           Vref=3D2.5V, buffered output
> > +      - 1: Internal reference and temperature sensor enabled.
> > +           Vref=3D4.096V, buffered output
> > +      - 2: Use external reference, temperature sensor enabled.
> > +           Internal buffer disabled
> > +      - 3: Use external reference, internal buffer and temperature
> > sensor
> > +           enabled.
> > +      - 6: Use external reference, internal buffer and temperature
> > sensor
> > +           disabled.
> > +      - 7: Use external reference, internal buffer enabled.
> > +           Internal reference and temperature sensor disabled.
>
> I think typically the description comes first. I also don't think you
> need the 'allOf'(not even sure if it will pass the binding check)...
> Just have '$ref' and 'enum' on the same level.
>

Understood, I can reorder the patches so that the bindings come first.

I thought I based that part on the `example-schema.yaml`, but looking at
it again, it seems like you're right and the AllOf isn't required.

I did run the bindings check on this, but I'll fix it.

Thanks,
Liam

> - Nuno S=C3=A1
>
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.30.1.489.g328c10930387

