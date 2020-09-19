Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7A270EBD
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISPDp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgISPDp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:03:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAC9208B8;
        Sat, 19 Sep 2020 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600527824;
        bh=VxYKfX7YU9HreeilW2aBIjZ2LzxDp3Po95dej4aeT4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R26cj/Se6FbTm9Ds6UJkv7G+Saq0gLPMRYG/o4E6JmKeeJ0jSBRJqAgv4S7+R1YYL
         GdtAEqzVZTZMiO5CeJsifsbsV8yoantWUX2igCQJORbznRG9Jqsn46B24W5Th8dHRD
         YcWX5bXiishBD4khZ0rPz4DuBEBeRKSMRiqI/+fI=
Date:   Sat, 19 Sep 2020 16:03:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v2 17/20] dt-bindings:iio:adc:holt,hi8435 yaml
 conversion
Message-ID: <20200919160341.70aa0435@archlinux>
In-Reply-To: <20200915191759.GA2339990@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-18-jic23@kernel.org>
        <20200915191759.GA2339990@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:17:59 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 09, 2020 at 06:59:43PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Very simple binding.  I've changed the example to use the node
> > name threshold-detector@0 as sensor@0 seemed too generic.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > ---
> >  .../devicetree/bindings/iio/adc/hi8435.txt    | 21 --------
> >  .../bindings/iio/adc/holt,hi8435.yaml         | 49 +++++++++++++++++++
> >  2 files changed, 49 insertions(+), 21 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> > deleted file mode 100644
> > index 3b0348c5e516..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -Holt Integrated Circuits HI-8435 threshold detector bindings
> > -
> > -Required properties:
> > - - compatible: should be "holt,hi8435"
> > - - reg: spi chip select number for the device
> > -
> > -Recommended properties:
> > - - spi-max-frequency: definition as per
> > -		Documentation/devicetree/bindings/spi/spi-bus.txt
> > -
> > -Optional properties:
> > - - gpios: GPIO used for controlling the reset pin
> > -
> > -Example:
> > -sensor@0 {
> > -	compatible = "holt,hi8435";
> > -	reg = <0>;
> > -	gpios = <&gpio6 1 0>;
> > -
> > -	spi-max-frequency = <1000000>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
> > new file mode 100644
> > index 000000000000..a35cf3876b86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/holt,hi8435.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Holt Integrated Circuits HI-8435 SPI threshold detector
> > +
> > +maintainers:
> > +  - Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > +
> > +description: |
> > +  Datasheet: http://www.holtic.com/documents/427-hi-8435_v-rev-lpdf.do
> > +
> > +properties:
> > +  compatible:
> > +    const: holt,hi8435
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpios:
> > +    description:
> > +       GPIO used for controlling the reset pin  
> 
> maxItems: 1
done
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.

Thanks,

Jonathan

> 
> > +
> > +  spi-max-frequency: true
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        threshold-detector@0 {
> > +            compatible = "holt,hi8435";
> > +            reg = <0>;
> > +            gpios = <&gpio6 1 0>;
> > +            spi-max-frequency = <1000000>;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.28.0
> >   

