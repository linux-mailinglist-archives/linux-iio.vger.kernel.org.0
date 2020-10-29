Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C522529F48C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgJ2TKQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgJ2TKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 15:10:16 -0400
X-Greylist: delayed 76882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Oct 2020 12:10:16 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01FC0613D4
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2020 12:10:16 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B03CC2800B3C3;
        Thu, 29 Oct 2020 20:10:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 91442242DB8; Thu, 29 Oct 2020 20:10:14 +0100 (CET)
Date:   Thu, 29 Oct 2020 20:10:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20201029191014.GA18228@wunner.de>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-17-jic23@kernel.org>
 <20201028203140.GA24407@wunner.de>
 <20201029155025.0f3ce545@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029155025.0f3ce545@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 03:50:25PM +0000, Jonathan Cameron wrote:
> On Wed, 28 Oct 2020 21:31:40 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > On Sun, Oct 11, 2020 at 06:07:36PM +0100, Jonathan Cameron wrote:
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        dac@0 {
> > > +            compatible = "ti,dac082s085";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <40000000>;
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            vref-supply = <&vref_2v5_reg>;
> > > +        };
> > > +    };  
> > 
> > Hm, why wasn't the "vref_2v5_reg" node carried over from the txt file?
> 
> Showing how to supply a regulator isn't generally necessary in an example.
> I don't mind having it there though so can keep it
> (as the fixed regulator binding has been converted to yaml)

The "vref_2v5_reg" node is referenced by the "dac@0" node, so  I included
it in the example for completeness.  I'd appreciate if it could be carried
over to the YAML file, unless its inclusion is a bad practice.

Thanks,

Lukas
