Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B61B8758
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYPYb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYPYb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:24:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EB82071C;
        Sat, 25 Apr 2020 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587828270;
        bh=YYlOpFJVzH3Jxf/CWXh16DTDqEKfKsrRb+fRydNLkiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EUaXQmc7FWqoDDqF8NwHBkl/GDImouhDgLovwJK2BBmjka/VYQFUGqWiXisz7wfW9
         oKIhvH4517Qgbhu+Ok2ySy5NStnmTZ/QEJ2ZKUgQqWcGwZR69PAreaEAgWkDpLEWfI
         4wuyw5ziM7T0sCWc1cHRE4AnLdK8un8yCGU4P/S8=
Date:   Sat, 25 Apr 2020 16:24:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, narcisaanamaria12@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 1/3] dt-bindings: iio: chemical: Add binding
 for CCS811 VOC sensor
Message-ID: <20200425162426.43d2f9d1@archlinux>
In-Reply-To: <20200422182715.GA27920@Mani-XPS-13-9360>
References: <20200414184930.5576-1-mani@kernel.org>
        <20200414184930.5576-2-mani@kernel.org>
        <20200420211111.GA754@bogus>
        <20200422182715.GA27920@Mani-XPS-13-9360>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 23:57:15 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Mon, Apr 20, 2020 at 04:11:11PM -0500, Rob Herring wrote:
> > On Wed, Apr 15, 2020 at 12:19:28AM +0530, mani@kernel.org wrote:  
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > This commit adds devicetree binding for AMS CCS811 VOC sensor.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  .../bindings/iio/chemical/ams,ccs811.yaml     | 51 +++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > > new file mode 100644
> > > index 000000000000..5cb068666a3e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: AMS CCS811 VOC Sensor
> > > +
> > > +maintainers:
> > > +  - Narcisa Vasile <narcisaanamaria12@gmail.com>
> > > +
> > > +description: |
> > > +  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ams,ccs811
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    description: GPIO connected to the nRESET line. This is an active low
> > > +                 input to CCS811.
> > > +    maxItems: 1
> > > +
> > > +  wakeup-gpios:
> > > +    description: GPIO connected to the nWAKE line. This is an active low
> > > +                 input to CCS811.
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg  
> > 
> > Add:
> > 
> > additionalProperties: false
> >   
> 
> Hi Jonathan,
> 
> Do you want me to spin another series or you can add it while applying?
Added whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Thanks,
> Mani
> 
> > With that,
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>  

