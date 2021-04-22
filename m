Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29943368704
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 21:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhDVTRd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVTRd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 15:17:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A20C06174A;
        Thu, 22 Apr 2021 12:16:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso41286455otb.13;
        Thu, 22 Apr 2021 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFKHkdJ/TiTXIjZ61s8CUp/eOXsXcoYTAeerWwPKQQc=;
        b=KKmpmScmGCnRb2n5yZnt15wSgZqeNc0MwejlDkH9XKIhana5b62yO9zea7aBu+wZLe
         tSy29MfzGcHaZSEHJfUP0SlldG5v9kKvlBv8hHNLVEg0aePS9OSgN82ubHM27kFri9Hb
         tbQJq/Wq09mPvKoLP6NyG9tw68Z+rhdbvDDxgWRqEyJXvrnCVGm5mQbgGmvqhQcxvoLO
         E8g/3KaZUhJAbNTwQfZz9wkxCNuyXngN/tnsGSnfgD8yv46FF6QbGzGd2sElgL19Fvju
         fIVs9QsTftssrkCQ72Yvq3521HCcXwPoMfdXzyUQPBwXUP/xELiCjtGmBKOIC1A63Qvm
         LEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFKHkdJ/TiTXIjZ61s8CUp/eOXsXcoYTAeerWwPKQQc=;
        b=UQjEd/l5jxFzEIE0t4Uy2VnoxyHkqZbxTzYX+U5J7yyPNk5CQCGJXl7oZKKmIhFDwm
         kABmYpsY1gLE5s4+CmXoi7Ct6Wa5Eo+6XQTufZ4/2Fsb3eE+jM2fY+9d9qET1+UwVKL8
         1t153sW448EQaAZxceMRX2roQWBTIkkFRer7OE8paFEbv88tGpbcKBQFOqAw/uFK/0ds
         m763oal1W1V0TA6VKx9FAY8dc9EYhufeHxvbZg7Px3ChsOclmTdTWU7XtZj6QmyW2JfF
         KwLjg0tv+FkUwXyNIwhOd1MzPX5QMeTAby3n6PAWNy6+9no5ah0sYoNlheOq5xTI4+a7
         hEoQ==
X-Gm-Message-State: AOAM531TGaLKPmf7uFz2X33gL7xE65VmLr3bXZfVzi+1DC9bFK/mfoS6
        FrxdlnYxu8GO/d6akksj6WHUANQ3h3Fcu9BMemM=
X-Google-Smtp-Source: ABdhPJxuiqTLKR0jY2x7Mzae5sGw4GmHH/gcF0XZOd5CvZE0EHQQZPlFqR+JmcV96hu0Lu53i3715OdCAgAsmxky9Ak=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr88230otg.252.1619119017805;
 Thu, 22 Apr 2021 12:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
 <54a9eaeaa42d47037b2a07bd933e6dfade745d02.1618785336.git.lucas.p.stankus@gmail.com>
 <20210420193746.GA3632576@robh.at.kernel.org>
In-Reply-To: <20210420193746.GA3632576@robh.at.kernel.org>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Thu, 22 Apr 2021 16:16:21 -0300
Message-ID: <CACKVXZDtUync4HnScJnMEj=Gh7bukUUpnPrtE0w1PPgCZOHORg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: staging: iio: cdc: ad7746: add
 binding documentation for AD7746
To:     Rob Herring <robh@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 20, 2021 at 4:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Apr 18, 2021 at 07:49:51PM -0300, Lucas Stankus wrote:
> > Add device tree binding documentation for AD7746 cdc in YAML format.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > ---
> >
> > A minor note about the adi,excitation-vdd-permille property. Jonathan
> > suggested the name to be adi,excitation-vdd-milicent, but I was unsure of
> > the milicent naming. With a quick search I found out that the common way to
> > call a thousandth is 'per mille'[1], but I didn't find any use of it in the
> > kernel documentation. Any thoughts about it?
>
> Seems okay to me.
>
> > [1] https://en.wikipedia.org/wiki/Per_mille
> >
> >  .../bindings/iio/cdc/adi,ad7746.yaml          | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> > new file mode 100644
> > index 000000000000..a2a7eee674ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +
> > +description: |
> > +  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> > +
> > +  Specifications about the part can be found at:
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7745
> > +      - adi,ad7746
> > +      - adi,ad7747
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  adi,excitation-vdd-permille:
> > +    description: |
> > +      Set VDD per mille to be used as the excitation voltage.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [125, 250, 375, 500]
> > +
> > +  adi,exca-output-en:
> > +    description: Enables the EXCA pin as the excitation output.
> > +    type: boolean
> > +
> > +  adi,exca-output-invert:
> > +    description: Inverts the excitation output in the EXCA pin.
> > +    type: boolean
>
> 'invert' assumes I know what the non-inverted signal is. Sometimes that
> makes sense, but if you can define in terms of the inverse that would be
> better. For example, for a normally active low signal, name the property
> 'foo-active-high'.

Thanks for the feedback!
From reading the data sheet I couldn't quite grasp what would be an inverted
excitation output, but I don't have a lot of experience with CDCs. Maybe someone
with more experience could help out with a better suggestion.

>
> > +
> > +  adi,excb-output-en:
> > +    description: Enables the EXCB pin as the excitation output.
> > +    type: boolean
> > +
> > +  adi,excb-output-invert:
> > +    description: Inverts the excitation output in the EXCB pin.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      ad7746: cdc@48 {
> > +        compatible = "adi,ad7746";
> > +        reg = <0x48>;
> > +        adi,excitation-vdd-permille = <125>;
> > +
> > +        adi,exca-output-en;
> > +        adi,exca-output-invert;
> > +        adi,excb-output-en;
> > +        adi,excb-output-invert;
> > +      };
> > +    };
> > +...
> > --
> > 2.31.1
> >
