Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8281794D6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgCDQSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 11:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCDQSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Mar 2020 11:18:17 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF4A21739;
        Wed,  4 Mar 2020 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583338695;
        bh=rkEU4eLVPSGyjC+W5QQXVir/h4v8Bes9tXj7f/O6jSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBr54LAnn55gniSieBFpR/b0Ke8+EqQyDZO9+0o3LMC83AcG6pl5rPTwzvraciZfp
         N6PFmoXmvDA7/qCZnHEV56WMwA/9p4RXS0L7Z472UM/bw2VNO9Z71ghAd1WcFl7287
         TBGWZgcK48wRwkkXwRhAmdvqQxIIEmY1tX3t+1gE=
Received: by mail-qk1-f177.google.com with SMTP id e16so2163029qkl.6;
        Wed, 04 Mar 2020 08:18:15 -0800 (PST)
X-Gm-Message-State: ANhLgQ0y+h9qyRnT792B9Fep3JYFLQxGyVws2Hl7Dt7lOCNOrgV1FqM+
        tYOehhhzGpmZnoPcX0sn2HuHzT5CE/KnZKtjlQ==
X-Google-Smtp-Source: ADFU+vsjnswSGP2m60kwTzWnFzRxFJmlLh7GF6JHFk0NmQeplvYVYnDswx1IFykpcXGAhgSdECAQY+TKoUoOtoR6z50=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr3729521qkg.152.1583338694869;
 Wed, 04 Mar 2020 08:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20200227082719.6343-1-alexandru.ardelean@analog.com>
 <20200227082719.6343-7-alexandru.ardelean@analog.com> <20200303165323.GA32472@bogus>
 <e8075f2fc949b541ccc369bc0cc5d3726ea0a3bf.camel@analog.com>
In-Reply-To: <e8075f2fc949b541ccc369bc0cc5d3726ea0a3bf.camel@analog.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 4 Mar 2020 10:18:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrzjKbKF3A1EGFVpP=KgeRY97yWf_k+T4t-nWZ3=n0zg@mail.gmail.com>
Message-ID: <CAL_JsqJrzjKbKF3A1EGFVpP=KgeRY97yWf_k+T4t-nWZ3=n0zg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 4, 2020 at 1:55 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Tue, 2020-03-03 at 10:53 -0600, Rob Herring wrote:
> > On Thu, Feb 27, 2020 at 10:27:17AM +0200, Alexandru Ardelean wrote:
> > > This change adds the bindings documentation for the AXI ADC driver.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi-axi-adc.yaml         | 69 +++++++++++++++++++
> >
> > Follow the compatible string: adi,axi-adc.yaml
>
> ack
>
> >
> > >  1 file changed, 69 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi-axi-
> > > adc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> > > new file mode 100644
> > > index 000000000000..d45d41f4f08e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi-axi-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AXI ADC IP core
> > > +
> > > +maintainers:
> > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices Generic AXI ADC IP core for interfacing an ADC device
> > > +  with a high speed serial (JESD204B/C) or source synchronous parallel
> > > +  interface (LVDS/CMOS).
> > > +  Usually, some other interface type (i.e SPI) is used as a control
> > > +  interface for the actual ADC, while this IP core will interface
> > > +  to the data-lines of the ADC and handle the streaming of data into
> > > +  memory via DMA.
> > > +
> > > +  https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,axi-adc-10.0.a
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  dmas:
> > > +    minItems: 1
> > > +    maxItems: 1
> >
> > Just maxItems is enough.
>
> ack
>
> >
> > > +
> > > +  dma-names:
> > > +    maxItems: 1
> > > +    items:
> > > +      - const: rx
> > > +
> > > +  adi-axi-adc-client:
> >
> > adi,axi-adc-client
> >
> > Though I think 'adi,adc-dev' would be better name.
>
> works for me
> one question though; this still gives:
>
>   CHKDT   Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> /home/sandu/work/linux/upstream/Documentation/devicetree/bindings/iio/adc/adi,ax
> i-adc.yaml: properties:adi,adc-dev: {'description': 'A reference to a the actual
> ADC to which this FPGA ADC interfaces to.', 'maxItems': 1} is not valid under
> any of the given schemas (Possible causes of the failure):
>         /home/sandu/work/linux/upstream/Documentation/devicetree/bindings/iio/ad
> c/adi,axi-adc.yaml: properties:adi,adc-dev: 'not' is a required property

Yes, not the most helpful errors I know. You need a type reference and
'maxItems' should be dropped.

$ref: /schemas/types.yaml#/definitions/phandle

Rob
