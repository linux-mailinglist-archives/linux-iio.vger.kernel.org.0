Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF22A155F
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgJaLCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 07:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgJaLCj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 07:02:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2922B20739;
        Sat, 31 Oct 2020 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604142159;
        bh=BdH6g1yPDhdM1c+vzvvm9E9sC8aMjf8oqx96jEly48w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mCVBQ2j/1UX3etNKWHOynLp3Jeod/O4sp0MpWUgrOh8EB+i68e6oZgzPCrr7wcv6I
         vHe7ZygRBeR6JGcgMGeU7sC1FNAV2QhwZ8jYTEqgigq8QlTG6dbA3MEgJnD++QG66b
         NeyLYADLqTbUuy7Q/7Cf9KrNscd1lUNqjiQKy8fc=
Date:   Sat, 31 Oct 2020 11:02:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20201031110234.4d70fca3@archlinux>
In-Reply-To: <20201029191014.GA18228@wunner.de>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-17-jic23@kernel.org>
        <20201028203140.GA24407@wunner.de>
        <20201029155025.0f3ce545@archlinux>
        <20201029191014.GA18228@wunner.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Oct 2020 20:10:14 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Oct 29, 2020 at 03:50:25PM +0000, Jonathan Cameron wrote:
> > On Wed, 28 Oct 2020 21:31:40 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > On Sun, Oct 11, 2020 at 06:07:36PM +0100, Jonathan Cameron wrote:  
> > > > +examples:
> > > > +  - |
> > > > +    spi {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        dac@0 {
> > > > +            compatible = "ti,dac082s085";
> > > > +            reg = <0>;
> > > > +            spi-max-frequency = <40000000>;
> > > > +            spi-cpol;
> > > > +            spi-cpha;
> > > > +            vref-supply = <&vref_2v5_reg>;
> > > > +        };
> > > > +    };    
> > > 
> > > Hm, why wasn't the "vref_2v5_reg" node carried over from the txt file?  
> > 
> > Showing how to supply a regulator isn't generally necessary in an example.
> > I don't mind having it there though so can keep it
> > (as the fixed regulator binding has been converted to yaml)  
> 
> The "vref_2v5_reg" node is referenced by the "dac@0" node, so  I included
> it in the example for completeness.  I'd appreciate if it could be carried
> over to the YAML file, unless its inclusion is a bad practice.

Sure. Will do so.  Many bindings don't do it, but nor problem with being
more specific.

If we followed the logic of including referenced nodes, some bindings
would end up including nearly a whole board dts.  That's not the case
here though so no problem.

Jonathan

> 
> Thanks,
> 
> Lukas

