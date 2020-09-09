Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655EB2626D9
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgIIFqp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 01:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIFqo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 01:46:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86616C061573;
        Tue,  8 Sep 2020 22:46:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1154483pfp.11;
        Tue, 08 Sep 2020 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2UhuYpJejZc5ElG1FVc/lxyhIXx177Vex4idKVTX14=;
        b=gRMPXh5i3oNQ9q/jPGNCZ9ckeN/kZdR41zGM7bev4cvYhKHv8SLVKVJX8jd8r1PUlq
         jbMee2uZrcE1A1feMQ6t+RVXl5rVowf3Bz/RK8EZtiQc+QGQCJHybE5cvonx+VDY+hzs
         0g2Bt/ydEgkAe/z5fCrt78qry3vnJpl+axB0xvBGyLgG3Nl2CE6OK61pWyrzd4xrg0Lz
         ehRkD+9mEuBtxebE2LILHBztGigHuJFFvIKW/v+ENdobG3Tfi0C3ICQmf361mBgx7zBM
         fQC6HQ4w4pvpqbqPUBr4Aprv1NGSCoUmHqzF+JM0B+9CPJ9B/hF1RRnFh/wN3iDjG8A3
         iSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2UhuYpJejZc5ElG1FVc/lxyhIXx177Vex4idKVTX14=;
        b=Kwp/aMVZFNXATDAM27eLRCX9m/9TktAgqWZYHYnSuyO9kwLMe7qQCLF5jbW57uh9N7
         51mL37R7Aq6CNO3/6vvBFFyi17x9tdNJJozzEOR+eKg/syRliGvbEVP5RlVhq7baDxOG
         +XLABAA3Q7MwqqxzlXmoi8myscDjTRKsvGL54xWvKwvXmDfgQrpF7yDVxx31kRxKtqVN
         Aey7n5GWfV8EV96WIdflfF2opjprkkcLtdDA3xxXlEJ5E9202sNglv9wzqVVATchm9ns
         JaRwyW+lyFLKdqV/vUxUgk41Vw/pzaOlrLyzJi6SvYU9igPVLwzDCPVx4YN7ifBxKZqz
         PojQ==
X-Gm-Message-State: AOAM533VhJgHDUpF2g2naPLNRSZgxjRHRZfSxWGhnos9MRWnavO2isg2
        e4EIUbArNTuNOuhmFMHLhf5d9D28E+WZgw==
X-Google-Smtp-Source: ABdhPJyz26/uP7vOvSq+6g4m5jBM9THUqUo053ROl5vjaBnP0WVAno8OhD8GLu1veEwzlLv7ElHjbA==
X-Received: by 2002:a63:594a:: with SMTP id j10mr1667431pgm.402.1599630403879;
        Tue, 08 Sep 2020 22:46:43 -0700 (PDT)
Received: from ThinkPad ([114.250.39.43])
        by smtp.gmail.com with ESMTPSA id j193sm1211193pfd.89.2020.09.08.22.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 22:46:43 -0700 (PDT)
Date:   Wed, 9 Sep 2020 13:46:19 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml
 conversion.
Message-ID: <20200909054619.GA13589@ThinkPad>
References: <20200905173004.216081-1-jic23@kernel.org>
 <20200905173004.216081-7-jic23@kernel.org>
 <CA+H2tpE2-f7Sugi04hFwx4QrczufnE2gNHPzAoHWMwARgyOyLw@mail.gmail.com>
 <20200908101232.000032c5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908101232.000032c5@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 08, 2020 at 10:12:32AM +0100, Jonathan Cameron wrote:
> On Tue, 8 Sep 2020 01:46:40 +0800
> Orson Zhai <orsonzhai@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sun, Sep 6, 2020 at 1:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > I changed the name to reflect a specific part in line with normal
> > > naming conventions. If there is a particularly strong reason to
> > > keep the wild cards let me know.  
> > 
> > Why do we have to change the file name of 27xx ?
> 
> We don't have to, but generally we try to avoid using wild
> card naming.   It is far too common for companies marketing departments
> or similar to decide to group incompatible parts.  Basically picking
> a part number and saying 'and compatible' is much less likely to cause
> confusion than a wild card!

It makes much sense to me.

> 
> If you feel strongly about it and can do a check of whether there
> are any incompatible parts or not covered by that wild card range, then
> I'm happy to change it back again whilst applying.
> 
> Feel free to give a conditional Ack btw!

Acked-by: Orson Zhai <orsonzhai@gmail.com>

Thanks.

Orson
> 
> Jonathan
> 
> > 
> > >
> > > Otherwise this was a fairly simple conversion as part of converting
> > > all the IIO bindings to yaml.  
> > 
> > Thanks for doing this for us.
> > 
> > -Orson
> > 
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > ---
> > >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
> > >  .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
> > >  2 files changed, 72 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > > new file mode 100644
> > > index 000000000000..57df6439dd9d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/sprd,sc2720-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Spreadtrum SC27XX series PMICs ADC binding
> > > +
> > > +maintainers:
> > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > +
> > > +description:
> > > +  Supports the ADC found on these PMICs.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sprd,sc2720-adc
> > > +      - sprd,sc2721-adc
> > > +      - sprd,sc2723-adc
> > > +      - sprd,sc2730-adc
> > > +      - sprd,sc2731-adc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +  hwlocks:
> > > +    maxItems: 1
> > > +
> > > +  nvmem-cells:
> > > +    maxItems: 2
> > > +
> > > +  nvmem-cell-names:
> > > +    items:
> > > +      - const: big_scale_calib
> > > +      - const: small_scale_calib
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - "#io-channel-cells"
> > > +  - hwlocks
> > > +  - nvmem-cells
> > > +  - nvmem-cell-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    pmic {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +        adc@480 {
> > > +            compatible = "sprd,sc2731-adc";
> > > +            reg = <0x480>;
> > > +            interrupt-parent = <&sc2731_pmic>;
> > > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +            #io-channel-cells = <1>;
> > > +            hwlocks = <&hwlock 4>;
> > > +            nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> > > +            nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> > > +        };
> > > +    };
> > > +...
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> > > deleted file mode 100644
> > > index b4daa15dcf15..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> > > +++ /dev/null
> > > @@ -1,40 +0,0 @@
> > > -Spreadtrum SC27XX series PMICs ADC binding
> > > -
> > > -Required properties:
> > > -- compatible: Should be one of the following.
> > > -       "sprd,sc2720-adc"
> > > -       "sprd,sc2721-adc"
> > > -       "sprd,sc2723-adc"
> > > -       "sprd,sc2730-adc"
> > > -       "sprd,sc2731-adc"
> > > -- reg: The address offset of ADC controller.
> > > -- interrupt-parent: The interrupt controller.
> > > -- interrupts: The interrupt number for the ADC device.
> > > -- #io-channel-cells: Number of cells in an IIO specifier.
> > > -- hwlocks: Reference to a phandle of a hwlock provider node.
> > > -- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
> > > -- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
> > > -
> > > -Example:
> > > -
> > > -       sc2731_pmic: pmic@0 {
> > > -               compatible = "sprd,sc2731";
> > > -               reg = <0>;
> > > -               spi-max-frequency = <26000000>;
> > > -               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > > -               interrupt-controller;
> > > -               #interrupt-cells = <2>;
> > > -               #address-cells = <1>;
> > > -               #size-cells = <0>;
> > > -
> > > -               pmic_adc: adc@480 {
> > > -                       compatible = "sprd,sc2731-adc";
> > > -                       reg = <0x480>;
> > > -                       interrupt-parent = <&sc2731_pmic>;
> > > -                       interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > -                       #io-channel-cells = <1>;
> > > -                       hwlocks = <&hwlock 4>;
> > > -                       nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> > > -                       nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> > > -               };
> > > -       };
> > > --
> > > 2.28.0
> > >  
> 
> 
