Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4926311E83
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBFP4H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 10:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhBFP4G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 10:56:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4C764E9D;
        Sat,  6 Feb 2021 15:55:24 +0000 (UTC)
Date:   Sat, 6 Feb 2021 15:55:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: Add missing ad5686 compatible
 strings
Message-ID: <20210206155520.68f971e9@archlinux>
In-Reply-To: <20210202211022.GB3706951@robh.at.kernel.org>
References: <20210202181427.3934218-1-robh@kernel.org>
        <efbfbb94-bf61-5503-9833-df23709f56a2@metafoo.de>
        <20210202211022.GB3706951@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Feb 2021 15:10:22 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Feb 02, 2021 at 09:55:56PM +0100, Lars-Peter Clausen wrote:
> > On 2/2/21 7:14 PM, Rob Herring wrote:  
> > > The example uses 'adi,ad5686', but the schema fails to document it. Given
> > > the filename and there is a similar part AD5686, let's just add the
> > > compatible strings including the 'r' variant.  
> > 
> > There are two variants of this chip. One with a SPI interface and one with a
> > I2C interface. This binding document only describes the I2C variants. But
> > the ad5686 is a SPI variant.  
> 
> Right, I should have noticed that.
> 
> > I think this is a typo and we should replace ad5686 with ad5696, including
> > the document name.  
> 
> Though we do frequently document both I2C and SPI variants in the same 
> binding, given there's no existing SPI support and the example is wrong 
> I agree.

Ah, this is what I get for reading my emails out of order.

There is existing SPI driver support if that's what you mean
we just haven't documented the binding for it.

Should work via the fallbacks in SPI that drop the vendor id off then match
on the rest.  As I mentioned in reply to v2. It's an old driver so
kind of got DT support by accident.

I'll play catch up at some stage soon on missing binding docs,
(I suspect there are quite a few for older IIO drivers)

Thanks,

Jonathan

> 
> > > 
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > > Cc: Michael Auchter <michael.auchter@ni.com>
> > > Cc: linux-iio@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >   Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > > index 8065228e5df8..190919291828 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > > @@ -19,6 +19,8 @@ properties:
> > >         - adi,ad5338r
> > >         - adi,ad5671r
> > >         - adi,ad5675r
> > > +      - adi,ad5686
> > > +      - adi,ad5686r
> > >         - adi,ad5691r
> > >         - adi,ad5692r
> > >         - adi,ad5693  
> > 
> >   

