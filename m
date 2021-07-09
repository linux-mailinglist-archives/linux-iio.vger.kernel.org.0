Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C059E3C25F1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhGIOb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGIObZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 10:31:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA6C0613DD;
        Fri,  9 Jul 2021 07:28:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z25so4963553qto.12;
        Fri, 09 Jul 2021 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=vNiKju8q73JbtyCn6rNFEdpwD2qXtIUa7UuwlAEO5hU=;
        b=h82Q++ovugmmph115LR2r/Jl2eapOITUeMGu+UvLXwrRMo2jAn0Z3K8v7OcyZUNSYU
         7HGmRtwnKjbxua00XxpcHM7faYmoq9VQaCEy1dbA864toMOmMywRkMrRQ+9YAinLf42Q
         r0GvWuSuASVwcazHPyPBNCvNS4SKLsBIBch6HONY2hWgQpyn/hrpaQfCFl8chRzx1vaV
         N0HQaoLh1qC+3nNsfsfFZ0fYf0Qyu8/XILVwU3dcNy2aFn4ZdOalg8A6EPhwuZcaZA2h
         L2t9d4GvXw4HRxu3X/aC0bX26dOWySfj+5P0xXPzH54Ph30S/ft7xfviza/PO+QIqg5m
         ccFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=vNiKju8q73JbtyCn6rNFEdpwD2qXtIUa7UuwlAEO5hU=;
        b=kdSrrSzC+RUmMtlbqp5ReISkGVq4hadsgFGuwH7SgXUlbyQ7gZs5uaM47NOgRM/0hI
         uCElSoofWVNRhGMd4Zcl8F/6cTEuFV0bwaCgK0cnDTWnsIuG5PWHzFpKlFUUH8Iq5dhJ
         oqYubhXD61+LFqmOaFmYTcILJy7oa21SRznMoGeGCR+8LVlXuLrtImbrfFJkYjF6bV09
         zDNJUIkfd0uNL/wM4MnTX8ngVoqPQYt1lZzCUw50aJEfKSPMWJ5n5d2vCAmhii+6xowm
         a3nHPpSSN2WdO15yeWnplUyKK6xOQEt21wE++QTZ3W+5wPBPaNf5R2HmrwOKnBPrj1Mi
         eX+Q==
X-Gm-Message-State: AOAM533PSK9G7WINgW5pDh6rnk4BSio7Hgm24Z4aYv1x49frN/yVP79O
        bYCDLwu61olZ3ZV6sCfw1M4=
X-Google-Smtp-Source: ABdhPJxt+HiMHVq4pGULu/HRz4zz/JjX3ZScOUD8ZUZYrs+tDzj3L3G1D7LLD2n6gO0zqf553x5Q7Q==
X-Received: by 2002:a05:622a:178b:: with SMTP id s11mr17447910qtk.8.1625840921410;
        Fri, 09 Jul 2021 07:28:41 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j20sm2234303qtq.14.2021.07.09.07.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:28:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 10:28:40 -0400
Message-Id: <CCOOI7M0R35T.EXSVO86Z3YDC@shaak>
Subject: RE: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-5-liambeguin@gmail.com>
 <PH0PR03MB6366E7E1CBDC15B6B43F8BC699189@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366E7E1CBDC15B6B43F8BC699189@PH0PR03MB6366.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

I realize I misread your comment on the order of the description. I'll
move it at the top of the binding definition.

Liam

> - Nuno S=C3=A1
>
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.30.1.489.g328c10930387

