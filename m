Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2406884E7
	for <lists+linux-iio@lfdr.de>; Thu,  2 Feb 2023 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBBQ5B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Feb 2023 11:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBBQ47 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2023 11:56:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7665EF4;
        Thu,  2 Feb 2023 08:56:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6488FB82746;
        Thu,  2 Feb 2023 16:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8122BC433D2;
        Thu,  2 Feb 2023 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675357016;
        bh=Gvq02b9P/lXWWu1impdnZP8MBf9Vgtl3EK37Xtq1PQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6munLSfCJTT/MJhvhOdAaWevLr6cf8ENrbjUT7sQ2y3l4t+9YxjG+959fqA1goDb
         7HGK5SiYdhXksOCUMVmtkvPVGtXMvZy6GGdG8jBdS4nKgLgF4eEulQVO7Z0IelXdot
         FoLevu/DV84ngi/wlAavP2+wOu9qRxA85iq/G485Ekuh3zvPns9M+jiKwLHM0yicKP
         7rFr+nvh0LU2E1Zj5EW2BVQc8n+pTlnhUWKMWUC8TSCKMjwZbLJhtlmIMB6ktEjxrl
         9H5HvWSkX5a3cdAg9SRrsDjmB0UJ0uwQXegFNSJlpfHbrnV4pVRLfYnOhBRprdKkYE
         cPXI8tddOUi2Q==
Date:   Thu, 2 Feb 2023 17:10:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
Message-ID: <20230202171052.502ec666@jic23-huawei>
In-Reply-To: <20230201121343.vk2t2dfpbvhflols@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
        <20230131104816.w5sfpcdjulr2ogze@pengutronix.de>
        <1850476.tdWV9SEqCh@steina-w>
        <20230201121343.vk2t2dfpbvhflols@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 1 Feb 2023 13:13:43 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Alexander,
> 
> On 23-01-31, Alexander Stein wrote:
> > Hi Marco,
> > 
> > thanks for the feedback.
> > 
> > Am Dienstag, 31. Januar 2023, 11:48:16 CET schrieb Marco Felsch:  
> > > Hi Alexander,
> > > 
> > > On 23-01-31, Alexander Stein wrote:  
> > > > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > > > this ADC has two internal reference voltages, which the driver currently
> > > > doesn't make use of.
> > > > 
> > > > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for
> > > > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > > > <alexander.stein@ew.tq-group.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml          | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml index
> > > > 63369ba388e4..879768af0303 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > 
> > > > @@ -39,6 +39,9 @@ properties:
> > > >    power-domains:
> > > >      maxItems: 1
> > > > 
> > > > +  vref-supply:
> > > > +    description: External ADC reference voltage supply on VREFH pad.  
> > > 
> > > Please add it to the list of required properties, we can remove it as
> > > soon as the driver has support for the internal reference voltages.  
> > 
> > I was thinking in doing so before as well. But DT describes the hardware, and 
> > this ADC apparently would be functioning without a reference voltage on that 
> > pad, using a different one. What the driver actual does is a different matter.  
> 
> I have also thought about it first but than I checked the RM which says
> that "multi-reference selection" is chip dependent.

Oh goody. So is it detectable?

If we are going to stick to a single compatible rather than adding them for
the variants with and without this feature, should probably add a note at least
to say it is required for some parts.

Also, link if public would be good for purposes of discussion as my google
fu didn't find relevant doc. (assuming it's public)


Jonathan


> 
> Regards,
>   Marco
> 
> 
> > 
> > Best regards,
> > Alexander
> >   
> > > Regards,
> > >   Marco
> > >   
> > > > +
> > > > 
> > > >    "#io-channel-cells":
> > > >      const: 1
> > > > 
> > > > @@ -72,6 +75,7 @@ examples:
> > > >              assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> > > >              assigned-clock-rates = <24000000>;
> > > >              power-domains = <&pd IMX_SC_R_ADC_0>;
> > > > 
> > > > +            vref-supply = <&reg_1v8>;
> > > > 
> > > >              #io-channel-cells = <1>;
> > > >          
> > > >          };
> > > >      
> > > >      };  
> > 
> > 
> > 
> > 
> >   

