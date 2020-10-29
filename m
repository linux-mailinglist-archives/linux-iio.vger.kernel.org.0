Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772A429F077
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgJ2Pua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgJ2Pua (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:50:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E878720790;
        Thu, 29 Oct 2020 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603986629;
        bh=dA00gHspf3+RD0r9MncZuSElXT9InNUncEmzQpUzpsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+toyB4MuzXcQzUEjFGnO8LPfJ7OGJ1gZJva/xCUZlU5x5qwypeNs9IiGGcn9gRiH
         wFa+G+mFLC7VDx1Xunqvdx0QwPdDJwdSEezmrszGNqJDSrCvQdGoXYqyKlCxGvBTnL
         1/sBVb5WwEs7NF9ukT+AdQDLPWbGCz9En+K6Zzzc=
Date:   Thu, 29 Oct 2020 15:50:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20201029155025.0f3ce545@archlinux>
In-Reply-To: <20201028203140.GA24407@wunner.de>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-17-jic23@kernel.org>
        <20201028203140.GA24407@wunner.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Oct 2020 21:31:40 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Oct 11, 2020 at 06:07:36PM +0100, Jonathan Cameron wrote:
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments DAC082s085 and similar DACs
> > +
> > +description:
> > +  A familly of Texas Instruments 8/10/12-bit 2/4-channel DACs  
>            ^^
> s/familly/family
> 
> 
> > +  spi-cpha: true
> > +  spi-cpol:
> > +    description:
> > +      Should be either spi-cpha, or spi-cpol but not both.
> > +
> > +  vref-supply: true  
> [...]
> > +required:
> > +  - compatible
> > +  - reg  
> 
> "vref-supply" and ("spi-cpha" xor "spi-cpol") are also requird
> per the existing txt file.

I have no idea how to specify the spi-cpha xor spi-cpol unfortunately.
Have a question out to Rob on that one.

vref-supply was a stupid mistake from me. Will fix.

> 
> 
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            compatible = "ti,dac082s085";
> > +            reg = <0>;
> > +            spi-max-frequency = <40000000>;
> > +            spi-cpol;
> > +            spi-cpha;
> > +            vref-supply = <&vref_2v5_reg>;
> > +        };
> > +    };  
> 
> Hm, why wasn't the "vref_2v5_reg" node carried over from the txt file?

Showing how to supply a regulator isn't generally necessary in an example.
I don't mind having it there though so can keep it
(as the fixed regulator binding has been converted to yaml)

> 
> Thanks,
> 
> Lukas

