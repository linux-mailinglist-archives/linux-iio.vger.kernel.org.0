Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2536A10C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhDXMAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDXMAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 08:00:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A66B61422;
        Sat, 24 Apr 2021 11:59:52 +0000 (UTC)
Date:   Sat, 24 Apr 2021 13:00:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Rob Herring <robh@kernel.org>, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: staging: iio: cdc: ad7746: add
 binding documentation for AD7746
Message-ID: <20210424130025.35b5cdcb@jic23-huawei>
In-Reply-To: <8b2c672a-f260-fe19-5baf-adf6ce6fabf2@metafoo.de>
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
        <54a9eaeaa42d47037b2a07bd933e6dfade745d02.1618785336.git.lucas.p.stankus@gmail.com>
        <20210420193746.GA3632576@robh.at.kernel.org>
        <CACKVXZDtUync4HnScJnMEj=Gh7bukUUpnPrtE0w1PPgCZOHORg@mail.gmail.com>
        <8b2c672a-f260-fe19-5baf-adf6ce6fabf2@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Apr 2021 22:56:38 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/22/21 9:16 PM, Lucas Stankus wrote:
> > On Tue, Apr 20, 2021 at 4:37 PM Rob Herring <robh@kernel.org> wrote:  
> >> On Sun, Apr 18, 2021 at 07:49:51PM -0300, Lucas Stankus wrote:  
> >>> Add device tree binding documentation for AD7746 cdc in YAML format.
> >>>
> >>> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> >>> ---
> >>>
> >>> A minor note about the adi,excitation-vdd-permille property. Jonathan
> >>> suggested the name to be adi,excitation-vdd-milicent, but I was unsure of
> >>> the milicent naming. With a quick search I found out that the common way to
> >>> call a thousandth is 'per mille'[1], but I didn't find any use of it in the
> >>> kernel documentation. Any thoughts about it?  
> >> Seems okay to me.
> >>  
> >>> [1] https://en.wikipedia.org/wiki/Per_mille
> >>>
> >>>   .../bindings/iio/cdc/adi,ad7746.yaml          | 73 +++++++++++++++++++
> >>>   1 file changed, 73 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> >>> new file mode 100644
> >>> index 000000000000..a2a7eee674ba
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> >>> @@ -0,0 +1,73 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> >>> +
> >>> +maintainers:
> >>> +  - Michael Hennerich <michael.hennerich@analog.com>
> >>> +
> >>> +description: |
> >>> +  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> >>> +
> >>> +  Specifications about the part can be found at:
> >>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - adi,ad7745
> >>> +      - adi,ad7746
> >>> +      - adi,ad7747
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  adi,excitation-vdd-permille:
> >>> +    description: |
> >>> +      Set VDD per mille to be used as the excitation voltage.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum: [125, 250, 375, 500]
> >>> +
> >>> +  adi,exca-output-en:
> >>> +    description: Enables the EXCA pin as the excitation output.
> >>> +    type: boolean
> >>> +
> >>> +  adi,exca-output-invert:
> >>> +    description: Inverts the excitation output in the EXCA pin.
> >>> +    type: boolean  
> >> 'invert' assumes I know what the non-inverted signal is. Sometimes that
> >> makes sense, but if you can define in terms of the inverse that would be
> >> better. For example, for a normally active low signal, name the property
> >> 'foo-active-high'.  
> > Thanks for the feedback!
> >  From reading the data sheet I couldn't quite grasp what would be an inverted
> > excitation output, but I don't have a lot of experience with CDCs. Maybe someone
> > with more experience could help out with a better suggestion.  
> 
> This is the only thing I could find 
> https://www.analog.com/media/en/technical-documentation/application-notes/AN-1585.pdf.
> 
> The datasheet also says that only at most one of them should be 
> inverted. So maybe only a single property which selects which of the two 
> is inverted.
> 
> 

Nice. I was wondering what on earth that was for as well.  That note
makes it a little clearer!

I'd keep them as separate properties because there 'might' be another
circuit where inverting them both makes sense (though I have no idea
what it would look like). A reference to that note though to explain
why you might do this would be great to have the dt property description.

If anyone ever actually does do this, we'll need to add a description
of the analog front end somehow to actually support reporting in
meaningful units.

Let's not tackle that problem today though and it might be we'd actually
just use a generic AFE IIO consumer to do the scaling rather than needing
anything custom.

Jonathan
