Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022675E8D35
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIXN6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIXN6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 09:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82AE62E2
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 06:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4C27B80FF2
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 13:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B56BC433C1;
        Sat, 24 Sep 2022 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664027900;
        bh=n2MdIn3PhP9OJdCGv5nKPXsYM4lWm6MylI4xk22bjZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxZL3U+QFGsiN1NVtLSS3zn1MOk6JOD6aYsQapsF7+V2JDlz+MelgIK3cI3PMIUb2
         ihSyhug0wYdw2kBBPVy4JseV5K6jBdGZK32TFvecmJVOiIE95oPlGrvXrIMQeSKKHF
         +VZpJiSyEG0RkvrvpJUQfhH/pvChtkZucAmyDs0JQlQs8ztJzTZT8H2Jk9n2b43JaS
         5/YR6UjLksTei2iYWgnZzG0gHKkIttWkghqgGS4fV7EUKJ13A/h7+ebA0X0myzxSCp
         n6D+78xhWOAKO5DeczEcPfc/BEE+zjiFl4V5fYXZ8luEGuNkdssunxl2L8HKOaA39z
         ix67C9ftXajuQ==
Date:   Sat, 24 Sep 2022 14:58:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bolucu, Nurettin" <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220924145828.27659029@jic23-huawei>
In-Reply-To: <DM8PR03MB62477EAB8BCF6862032B30C5964C9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
        <20220908144924.205547-3-Ibrahim.Tilki@analog.com>
        <20220918162211.7a5ebdac@jic23-huawei>
        <DM8PR03MB62477EAB8BCF6862032B30C5964C9@DM8PR03MB6247.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Sep 2022 15:27:23 +0000
"Tilki, Ibrahim" <Ibrahim.Tilki@analog.com> wrote:

> > On Thu, 8 Sep 2022 17:49:23 +0300
> > Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> >   
> > > Adding devicetree binding documentation for max11410 adc.
> > > 
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,max11410.yaml        | 174 ++++++++++++++++++
> > >  1 file changed, 174 insertions(+)
> > >  create mode 100644 
> > > Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > > 
> > > diff --git 
> > > a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml 
> > > b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
...

> > > +
> > > +  interrupt-names:
> > > +    description: Name of the gpio pin of max11410 used for IRQ
> > > +    maxItems: 1
> > > +    items:
> > > +      enum:
> > > +        - gpio0
> > > +        - gpio1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  avdd-supply:
> > > +    description: Necessarry avdd supply. Used as reference when no explicit reference supplied.
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
> > hmm.
> > 
> > If explicit references are supplied and used, then will we query the voltage of the avdd supply?  If not, it doesn't need to be supplied. Power is needed but it might be coming from a fixed regulator no one bothered to put in the device tree.  Perhaps we just don't care about that corner case?
> >   
> 
> That is correct. If all of the channels use external vref, then avdd-supply
> is no longer required. It is fine by me if we ignore this corner case.
> 
> Current driver checks for avdd-supply unconditionally. Maybe we can change the
> driver so that it results in error only if one of the channels use avdd as reference
> in the absence of avdd-supply?

Does it query the voltage in this corner case?  I don't think it does.
If that's the case, you are fine getting it and if not supplied (and various
other conditions are met) the regulator core will provide a stub regulator
that will work fine here.  All we might want to do is remove the required
line from the binding.

> 
> 
> > > +
> > > +patternProperties:
> > > +  "^channel(@[0-9a-f]+)?$":  
> > 
> > name isn't that flexible as we only allow reg 0-9
> >   
> 
> I changed it to "^channel(@[0-9])?$" in v5 but will this allow us to define
> more than 10 channels? Sharing analog inputs accross multiple channels is
> supported by driver. But I don't know how to correctly specify it here.
> For example following configuration is valid:

Ah. I'd not understood this correctly.
The adc.yaml binding requires the @X number to match with reg.
It doesn't provide a way to not have an @reg.

Interesting corner case if you have overlap of single ended and differential
channels.  I guess we could specify reg as have no meaning for differential
channels other than as an index.  Not sure what the DT maintainers would think
of that though.  It isn't obvious what we should set reg to for differential
channels.

Ah. That meant I just checked if this had gone to the right people.
For all dt-bindings you need to +CC the list and maintainers listed
in MAINTAINERS.  They aren't going to see the binding otherwise and
I won't take a new binding without their review.

> 
>   channel@0 {
>     reg = <0>;
>   };
>   channel@1 {
>     reg = <1>;
>   };
>   channel@2 {
>     reg = <2>;
>   };
>   channel@3 {
>     reg = <3>;
>   };
>   channel@4 {
>     reg = <4>;
>   };
>   channel@5 {
>     reg = <5>;
>   };
>   channel@6 {
>     reg = <6>;
>   };
>   channel@7 {
>     reg = <7>;
>   };
>   channel@8 {
>     reg = <8>;
>   };
>   channel@9 {
>     reg = <9>;
>   };
>   channel@a {
>     diff-channels = <1 2>;
>   };
>   channel@b {
>     diff-channels = <7 9>;
>   };
> 

Thanks,

Joanthan

