Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123C6E3220
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDOPeO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjDOPeO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 11:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25146BF;
        Sat, 15 Apr 2023 08:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2412D6177F;
        Sat, 15 Apr 2023 15:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB322C433EF;
        Sat, 15 Apr 2023 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681572851;
        bh=mbTg4xdcbAp2u7Jx9zJYow64RoE4YGaPw7Jjp94KO1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BS4yYo/yQHmo9TPHpZMxWRJLhZbSjZvL0xczo5PQte0rsdLmABuK2G6veVg++L69j
         ad6Yxrlnr72ZhaiZ2UdPmIl/RPC6VWcvCzjxwrMWXhLIPvDZoX+RSju763eb2tEepO
         8m15GSGJB7W1SIJEIXuNSftKyWc1IcsiI3QrtWOYf7ofBsMn1FlYwWrr3kfChRAJPB
         faUkb8pAUcdctDAaZBV6AhxLV5JoVukTIsccRTORBFFfdT72f2nfXFRz/ekPgmSzSh
         +3c8t1PtT7ws0hw0cWUOwGbLB3s1nInBeobGTjPuwL8ibwKowOkOnygCqT5Wnk3hUe
         hrKQF+/XBAJUg==
Date:   Sat, 15 Apr 2023 16:34:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kim Seer Paller <kimseer.paller@analog.com>, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings:iio:adc: add max14001 bindings
Message-ID: <20230415163411.61e319e0@jic23-huawei>
In-Reply-To: <5219fd85-23fb-21f8-d765-9f862ea143ec@linaro.org>
References: <20230414102844.21579-1-kimseer.paller@analog.com>
        <5219fd85-23fb-21f8-d765-9f862ea143ec@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Apr 2023 23:15:07 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/04/2023 12:28, Kim Seer Paller wrote:
> > Add bindings for MAX14001.
> > 
> > The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs.  
> 
> Subject: missing spaces between prefixes.
> 
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.

A few follow up comments inline,

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,max14001.yaml        | 83 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  2 files changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > new file mode 100644
> > index 000000000..4546bf595
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MAX14001 ADC device driver  
> 
> Drop device driver. Bindings are for hardware, not Linux drivers.
> 
> > +
> > +maintainers:
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +
> > +description: |
> > +    Single channel 10 bit ADC with SPI interface. Datasheet
> > +    can be found here:
> > +      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max14001
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 5000000
> > +
> > +  vref-supply:
> > +    description: Voltage reference to establish input scaling.
> > +
> > +  adi,use-fadc:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    type: boolean  
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
> Keep one.
> 
> > +    description: If set, the filtered ADC data (FADC register) will be read,
> > +                  otherwise the unfiltered ADC data (ADC register) will be read.  
> 
> Hmmmm, looks familiar. Don't we have existing property for this?

That should be a userspace decision, not a DT provided one.
We have a bunch of controls defined for controlling filters. Ideal is probably
to map it to that ABI. It's possible that isn't flexible enough though for
this case (I haven't dived into datasheet to find out1). If so propose ABI
additions with documentation in Documentation/ABI/testing/sysfs-bus-iio

> 
> > +
> > +  adi,inrush-mode:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    type: boolean
> > +    description: If set, the device will use FAST inrush mode,
> > +                  otherwise the device will use ADC controlled inrush mode.
> > +
> > +  adi,filter:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2, 3 ]
> > +    description: |  
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +      0: Filtering off
> > +      1: Average 2 readings
> > +      2: Average 4 readings
> > +      3: Average 8 readings  
> 
> Isn't this also matching existing property for number of sample averaging?

Another one that belongs in the userspace ABI with driver picking a reaonable
default.  In IIO terms it's either a low pass filter, or oversampling depending
on exactly what the maths is. Low pass filter if next reading include elements
of the previous one (so a moving window). Oversampling if frequency of available
readings drops such that each real reading contributes to only one output.

If you need this stuff in the DT binding we need a strong argument for why
this is a feature of the analog signals being sampled, rather than trade
offs being made over noise etc.
 
> 
> > +
> > +  adi,current-source:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    type: boolean
> > +    description: If set, the 70uA current source will be connected to the REFIN pin,
> > +                  otherwise the current source will be turned off.
This is unusual enough that I wonder if a more specific name is needed.

adi,current-source-to-refin or maybe adi,current-source-for-shunt-volt-ref

I'm not an expert in these, so perhaps others have better suggestions for
how to describe this in a compact form.

adi,current-source alone could mean any number of things that aren't what we have
here.

Jonathan


