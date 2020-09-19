Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCB270E87
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgISOZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgISOZy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:25:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DAE20771;
        Sat, 19 Sep 2020 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600525553;
        bh=zVE0oLDDDmXmGhtnm366PTl705lYbU40PpsCSN2m1OI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WUiJBIOsqZ7z8Xekr2UO5sjwj2IyGei/j/FKY4wtBPFDawHZIHLWlJ+nYVjrxkk9b
         nHpQyxaC9DRz3QLvZFFtt6KU/+WHK038avV37SvCbF7zLNP7Qt2x+2cgiX5xv9JlGN
         a88J/0lLD4PZP4Gc/d0ScJcJx14pKQlwdEZZVR5k=
Date:   Sat, 19 Sep 2020 15:25:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 11/20] dt-bindings:iio:adc:motorola,cpcap-adc yaml
 conversion
Message-ID: <20200919152549.3ea68f26@archlinux>
In-Reply-To: <20200915191101.GA2327664@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-12-jic23@kernel.org>
        <20200915191101.GA2327664@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:11:01 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 09, 2020 at 06:59:37PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Conversion from txt to yaml.
> > Slightly expanded example to give a bit more context.
> > Description lifted from the original driver commit.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  .../devicetree/bindings/iio/adc/cpcap-adc.txt | 17 -------
> >  .../bindings/iio/adc/motorola,cpcap-adc.yaml  | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 17 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> > deleted file mode 100644
> > index ec04008e8f4f..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> > +++ /dev/null
> > @@ -1,17 +0,0 @@
> > -Motorola CPCAP PMIC ADC binding
> > -
> > -Required properties:
> > -- compatible: Should be "motorola,cpcap-adc" or "motorola,mapphone-cpcap-adc"
> > -- interrupts: The interrupt number for the ADC device
> > -- interrupt-names: Should be "adcdone"
> > -- #io-channel-cells: Number of cells in an IIO specifier
> > -
> > -Example:
> > -
> > -cpcap_adc: adc {
> > -	compatible = "motorola,mapphone-cpcap-adc";
> > -	interrupt-parent = <&cpcap>;
> > -	interrupts = <8 IRQ_TYPE_NONE>;
> > -	interrupt-names = "adcdone";
> > -	#io-channel-cells = <1>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> > new file mode 100644
> > index 000000000000..7811c0abd5d0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/motorola,cpcap-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC ADC binding
> > +
> > +maintainers:
> > +  - Tony Lindgren <tony@atomide.com>
> > +
> > +description:
> > +  On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
> > +  has ADCs that are used for battery charging and USB PHY VBUS and ID pin
> > +  detection.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motorola,cpcap-adc
> > +      - motorola,mapphone-cpcap-adc
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    const: adcdone
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - "#io-channel-cells"  
> 
> additionalProperties: false
Done
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.  Thanks

Jonathan

