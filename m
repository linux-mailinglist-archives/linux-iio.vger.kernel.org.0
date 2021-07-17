Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1973CC516
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhGQSCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 14:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhGQSCS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 14:02:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03D66113D;
        Sat, 17 Jul 2021 17:59:19 +0000 (UTC)
Date:   Sat, 17 Jul 2021 19:01:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/15] dt-bindings: iio: dac: ad5380: Add missing
 binding document
Message-ID: <20210717190142.26680c2d@jic23-huawei>
In-Reply-To: <20210714155421.GA2641406@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
        <20210627163244.1090296-5-jic23@kernel.org>
        <20210714155421.GA2641406@robh.at.kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Jul 2021 09:54:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Jun 27, 2021 at 05:32:33PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A simple binding for this particular DAC familly.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  .../bindings/iio/dac/adi,ad5380.yaml          | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
> > new file mode 100644
> > index 000000000000..d599b418a020
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5380.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5380 and similar DACs
> > +
> > +maintainers:
> > +  - Lars-Peter Clausen <lars@metafoo.de>
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description: |
> > +  DAC devices supporting both SPI and I2C interfaces.
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad5380-3
> > +      - adi,ad5380-5
> > +      - adi,ad5381-3
> > +      - adi,ad5381-5
> > +      - adi,ad5382-3
> > +      - adi,ad5382-5
> > +      - adi,ad5383-3
> > +      - adi,ad5383-5
> > +      - adi,ad5384-3
> > +      - adi,ad5384-5
> > +      - adi,ad5390-3
> > +      - adi,ad5390-5
> > +      - adi,ad5391-3
> > +      - adi,ad5391-5
> > +      - adi,ad5392-3
> > +      - adi,ad5392-5  
> 
> You could do this:
> 
> pattern: '^adi,ad53(8[0-4]|9[0-2])-[35]$'
Feels fragile and not possible to grep, so I'll stick with the full listing.
> 
> Either way,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Thanks!

Jonathan


