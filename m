Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00C758610C
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jul 2022 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGaT1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jul 2022 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaT1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2022 15:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551CAE5B
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 12:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F418F6106D
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 19:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F96AC433C1;
        Sun, 31 Jul 2022 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659295620;
        bh=Z6mQffiBWEXimYeV6+Ehln0Vbvksh+1M+IKFgHg4Qw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LP8xsHlEFt9nz9tcV8Mjh69LVVsrN+M7vuPxdS7Pq15Qa9+nRNy4mp/PiIvliLtoZ
         2b+9vQlAWJ75KhS1U777XvxSgL2OpS6hDty9BG/PZk72IEy2MKpnNX0bivAZ7IIvme
         69ccbbvy2+9ZQhlq4ce/1rd5Y2ZsFmVipWN/JtQjZ+a0VfprjZoH+H/rJjAUq0KiiQ
         NgDBE7wzfOsWcQVaxy1L/RbVyzJqNGkGgSNZlu4odBcpWOge8oT9Z2Dg5zBSBkWMCD
         gS5fTlt/BayVja483xaC4nJwufe31uQRGnSc4BypgvqKhuUV3KN3FrV98fUbq5yvHx
         Xd/6OkTD96t2Q==
Date:   Sun, 31 Jul 2022 20:37:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220731203710.5b8854cf@jic23-huawei>
In-Reply-To: <20220719145932.96-1-Ibrahim.Tilki@analog.com>
References: <20220707164810.7811fbb0@jic23-huawei>
        <20220719145932.96-1-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jul 2022 14:59:30 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> > On Thu, 7 Jul 2022 08:31:26 +0000
> > Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> >   
> > > Adding devicetree binding documentation for max11410 adc.
> > > 
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>  
> > 
> > Hi.
> > 
> > A few questions inline. Mostly stuff I couldn't figure out from a quick
> > scan through the datasheet.
> >   
> > > ---
> > >  .../bindings/iio/adc/adi,max11410.yaml        | 168 ++++++++++++++++++
> > >  1 file changed, 168 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > > new file mode 100644
> > > index 000000000..f28d29fb2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > > @@ -0,0 +1,168 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2022 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices MAX11410 ADC device driver
> > > +
> > > +maintainers:
> > > +  - Ibrahim Tilki <ibrahim.tilki@analog.com>
> > > +
> > > +description: |
> > > +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
> > > +  found here:
> > > +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,max11410
> > > +
> > > +  reg:
> > > +    description: SPI chip select number for the device  
> > 
> > Description not needed as same for all SPI devices.
> >   
> 
> Removed in v3.
> 
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description: IRQ line for the ADC  
> > The description doesn't tell us anything so drop it.
> > There is no need to provide description lines for self documenting
> > items like this.  
> 
> Removed in v3.
> 
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  avdd-supply:
> > > +    description: avdd supply can be used as reference for conversion.  
> > 
> > Mention it's also a necessary power supply.  As mentioned in driver review
> > I'd suggest you actually treat this as 'no explicit reference supplied'.
> > That simplifies the meaning of the adi,reference below.
> >   
> 
> Please see my comments to this in section "adi,reference".
> 
> > > +
> > > +  vref0p-supply:
> > > +    description: vref0p supply can be used as reference for conversion.
> > > +
> > > +  vref1p-supply:
> > > +    description: vref1p supply can be used as reference for conversion.
> > > +
> > > +  vref2p-supply:
> > > +    description: vref2p supply can be used as reference for conversion.
> > > +
> > > +  vref0n-supply:
> > > +    description: vref0n supply can be used as reference for conversion.
> > > +
> > > +  vref1n-supply:
> > > +    description: vref1n supply can be used as reference for conversion.
> > > +
> > > +  vref2n-supply:
> > > +    description: vref2n supply can be used as reference for conversion.
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 8000000
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - avdd-supply
> > > +
> > > +patternProperties:
> > > +  "^channel(@[0-9a-f]+)?$":
> > > +    $ref: "adc.yaml"
> > > +    type: object
> > > +    description: Represents the external channels which are connected to the ADC.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: The channel number in single-ended mode.
> > > +        minimum: 0
> > > +        maximum: 10
> > > +
> > > +      adi,reference:
> > > +        description: |
> > > +          Select the reference source to use when converting on
> > > +          the specific channel. Valid values are:
> > > +          0: REF0P/REF0N  
> > 
> > VREF0P etc to match namign above.
> >   
> 
> Corrected in v3.
> 
> > > +          1: REF1P/REF1N
> > > +          2: REF2P/REF2N
> > > +          3: AVDD/AGND
> > > +          4: REF0P/AGND
> > > +          5: REF1P/AGND
> > > +          6: REF2P/AGND  
> > 
> > Is it valid to use REF0P/AGND for a differential channel?  If not
> > I would reduce this list to 0-2 only.  If it is valid (so actually
> > useful to do so) then we are stuck with this.  That does make me wonder
> > if there is a difference between 3 and 7?  If not, just don't list 7
> >   
> 
> Yes, it is valid. Option 3 and 7 are the same, 7 is removed in v3.
> 
> I think we should list 4-6 here and removing 3 would cause more confusion
> to users in that case. This enum reflects the register field directly, maybe we
> can do some mapping for convenience. AVDD is already treated as default reference
> and user is free to specify it explicitly.
> 
> Maybe we can split reference description into two parts:
> "adi,reference" = <0>; // [0-2], AVDD if not specified.
> "adi,reference-n-agnd"; // boolean for connecting negative input to agnd.
> 
> But I think it would be more confusing. The most straightforward way is the enum IMO.
> I cannot think of a better way to describe reference than what we already have.

Fair enough.  Sometimes we can't do better than something opaque :(

Jonathan

> 
> > > +          7: AVDD/AGND
> > > +          If this field is left empty, AVDD/AGND is selected.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > > +        default: 7  
> 
> ...

