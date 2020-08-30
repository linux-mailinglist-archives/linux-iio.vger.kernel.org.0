Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C111F256F37
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgH3PzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 11:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgH3PzQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 11:55:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52492071B;
        Sun, 30 Aug 2020 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598802915;
        bh=ZBg3bBtwaWRb6Xrh+TIV/MiNssG4YfxqbbeBnrqADxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RaAjUUb5InR4+1c1c/QsTHoW9uCaW8Qmd6pRMAx3Ho+zWVOXIKsVlmWjPGHyJuxUI
         +xVxmowXnG9kJoP/k8hsw8r3EKxJgkbWvQ3rI19V0P815q63V4L1dnVC9UWmzAEvew
         EOWGJnZc00u23WxZ0+uX7x3qv9HFWZHCqk8a8kTM=
Date:   Sun, 30 Aug 2020 16:55:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/13] dt-bindings: iio: adc: ti,ads7950 binding
 conversion
Message-ID: <20200830165511.0058fa33@archlinux>
In-Reply-To: <5a4f6244-8840-e871-4a15-b63ad461be4a@lechnology.com>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-11-jic23@kernel.org>
        <5a4f6244-8840-e871-4a15-b63ad461be4a@lechnology.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Aug 2020 11:30:28 -0500
David Lechner <david@lechnology.com> wrote:

> On 8/9/20 6:17 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple conversion.  This binding already had the
> > that is necessary, I'm happy to leave it as previously documented.  
> 
> This commit message doesn't make sense to me. It should probably
> just say "this converts the device tree bindings to yml" or so.

I'm not sure what happened there. I think perhaps a line got accidentally
removed.  It was meant to talk about the fact #io-channel-cells is
marked as required which may not make sense for all boards with this
part.  Will rewrite for v2.

Jonathan

> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: David Lechner <david@lechnology.com>
> > ---
> >   .../bindings/iio/adc/ti,ads7950.yaml          | 64 +++++++++++++++++++
> >   .../bindings/iio/adc/ti-ads7950.txt           | 23 -------
> >   2 files changed, 64 insertions(+), 23 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
> > new file mode 100644
> > index 000000000000..a759d9064718
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7950.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments ADS7950 and similar ADCs
> > +
> > +maintainers:
> > +  - David Lechner <david@lechnology.com>
> > +
> > +description: |
> > +  Family of 4-16 channel, 8-12 bit ADCs with SPI interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads7950
> > +      - ti,ads7951
> > +      - ti,ads7952
> > +      - ti,ads7953
> > +      - ti,ads7954
> > +      - ti,ads7955
> > +      - ti,ads7956
> > +      - ti,ads7957
> > +      - ti,ads7958
> > +      - ti,ads7959
> > +      - ti,ads7960
> > +      - ti,ads7961
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency: true  
> 
> According to the datasheet, max frequency is 20MHz, so this can be:
> 
> spi-max-frequency:
>    maximum: 20000000
> 
> > +
> > +  vref-supply:
> > +    description: Supply the 2.5V or 5V reference voltage  
> 
> Should this say "Supplies ..."?
> 
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "ti,ads7957";
> > +            reg = <0>;
> > +            vref-supply = <&refin_supply>;
> > +            spi-max-frequency = <10000000>;
> > +            #io-channel-cells = <1>;
> > +        };
> > +    };  
> 
> 

