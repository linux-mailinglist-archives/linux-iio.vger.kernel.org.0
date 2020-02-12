Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC815A72E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 11:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLK5a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 05:57:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38955 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBLK53 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 05:57:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id p14so853756vsq.6;
        Wed, 12 Feb 2020 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQAYmYWXHoQ/XJO0IhYrZodteSENqIZeB0+t/OPU7g4=;
        b=thrksr6Ind35TFRexPrLQ1FhNnDe/HUjzRqldvqnXRS8AsIAem5wZy17LlB09M6/b/
         RkE57xlXrQOxw6CFJSKDZTBDIEvNbsk/APYaYVGMgEP7w5kag4vPgd7iaLCKMx5Uf7tn
         SUjHLWcAI/9osscwurri37Uia9Rsg6cdT5RAf3fSzP0IAMAH0599QOW12I83RwywX2HP
         DDgql9W81PHfS3sXL8h4OJVsDp37hIQP/5p6CnzoH0H2NfslWNnn59u2Fs9I3xFpsXPR
         i9UxxAiO1SeALjApAp6map780nLjdaZW9BjOdLzIAJnaxka/6oMLUsefadyfpmDCOLMN
         7EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQAYmYWXHoQ/XJO0IhYrZodteSENqIZeB0+t/OPU7g4=;
        b=oT3iiyd54TWjbfyGSCCSqqOle1ZZ5rYqIwUsEcUPxC1sfuwjELyMgOIioFDU7Q4ZcQ
         FbnR69WdOnbn4Xn0Fht5PDnR/oh3LBBdI1ungI8JW+IQm0j7Rv6fwH0dP0Onc7NmXu0K
         njgvnys3QPL2KKdppjAL2sb1/cI/jUI85HglypFJoss+wIpXESApz4cHBS/hgr9lxJWs
         +IXE9Xq/CScY1HUHyBwmvK5Jeib5BvErKccBt32sdRCtCTI9GY9rGoyaTr7ptkANCDo0
         bs5Kd7gSqLPdqWjLOPI1KXaTMjKseVFYnLD2wU+iZ+IWzeRoddM8Okyc0V/kIl4pPmW8
         dHPQ==
X-Gm-Message-State: APjAAAV3/Tavdpq9/WTT49RKmIGIYmZIiZuU7/5qX6GOIYdcIB6sLDZN
        Y5ikmusPPcN+r8TQcLSe7UI5trt1C7RsHfpOtFY=
X-Google-Smtp-Source: APXvYqyp6c21Ni0kb56Qwb6uTMOr6939dOaOsN12CFIM82oglNutoowZ2P0fKXSA1a6LfrDW7L3D9FwaZuzk1025KHE=
X-Received: by 2002:a67:edd2:: with SMTP id e18mr11208855vsp.211.1581505048414;
 Wed, 12 Feb 2020 02:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20200205002121.30941-1-djunho@padtec.com.br> <b808cd095dd290ce3cf8ec6934f92edb2f94954e.camel@analog.com>
In-Reply-To: <b808cd095dd290ce3cf8ec6934f92edb2f94954e.camel@analog.com>
From:   Daniel Junho <djunho@gmail.com>
Date:   Wed, 12 Feb 2020 07:57:16 -0300
Message-ID: <CAKxs2cAb=zX9RvBYMQPy_rqcgoAU4dPbgB3JLVWbB-Ro9R2rHA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7923: Add dt-bindings for AD7928
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "patrick.vasseur@c-s.fr" <patrick.vasseur@c-s.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi.

Thank you for your review. I will make these changes and send a v2.

On Wed, Feb 5, 2020 at 5:24 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Tue, 2020-02-04 at 21:21 -0300, Daniel Junho wrote:
> > From: Daniel Junho <djunho@gmail.com>
> >
> > Add device tree bindings documentation for AD7923 adc in YAML format.
> >
> > Tested with:
> > make ARCH=arm dt_binding_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > make ARCH=arm dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> >
>
> Hey,
>
> Some comments inline.
>
>
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >
> > Hi,
> >
> > I got maintainers from the driver authors list. Let me know if this is
> > fine.
> >
> > Thanks.
> >
> >  .../bindings/iio/adc/adi,ad7923.yaml          | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > new file mode 100644
> > index 000000000000..8097441c97be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
>
> License header should be:
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>
>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7923.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7923 and similars with 4 and 8 Channel ADCs.
> > +
> > +maintainers:
> > +  - Michael Hennerich <hennerich@blackfin.uclinux.org>"
>
> For Michael, email now is:  michael.hennerich@analog.com
> That email may still work, but for new stuff, it should be updated.
>
> > +  - Patrick Vasseur <patrick.vasseur@c-s.fr>"
> > +
> > +description: |
> > +  Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> > +   AD7918, AD7928 8 Channels ADCs.
> > +
> > +  Specifications about the part can be found at:
> > +
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> > +
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7904_7914_7924.pdf
> > +
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7908_7918_7928.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7904
> > +      - adi,ad7914
> > +      - adi,ad7923
> > +      - adi,ad7924
> > +      - adi,ad7908
> > +      - adi,ad7918
> > +      - adi,ad7928
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  refin-supply:
> > +    description: |
> > +      The regulator supply for ADC reference voltage.
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      ad7928: adc@0 {
> > +        compatible = "adi,ad7928";
> > +        reg = <0>;
> > +        spi-max-frequency = <25000000>;
> > +        refin-supply = <&adc_vref>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +      };
> > +    };
