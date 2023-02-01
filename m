Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD13D6865C4
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBAMOB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 07:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBAMOA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 07:14:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDB46D65
        for <linux-iio@vger.kernel.org>; Wed,  1 Feb 2023 04:13:59 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pNBzm-00044S-HQ; Wed, 01 Feb 2023 13:13:46 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pNBzj-0008Hb-J5; Wed, 01 Feb 2023 13:13:43 +0100
Date:   Wed, 1 Feb 2023 13:13:43 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <20230201121343.vk2t2dfpbvhflols@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
 <20230131104816.w5sfpcdjulr2ogze@pengutronix.de>
 <1850476.tdWV9SEqCh@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1850476.tdWV9SEqCh@steina-w>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexander,

On 23-01-31, Alexander Stein wrote:
> Hi Marco,
> 
> thanks for the feedback.
> 
> Am Dienstag, 31. Januar 2023, 11:48:16 CET schrieb Marco Felsch:
> > Hi Alexander,
> > 
> > On 23-01-31, Alexander Stein wrote:
> > > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > > this ADC has two internal reference voltages, which the driver currently
> > > doesn't make use of.
> > > 
> > > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for
> > > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > > <alexander.stein@ew.tq-group.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml          | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml index
> > > 63369ba388e4..879768af0303 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > 
> > > @@ -39,6 +39,9 @@ properties:
> > >    power-domains:
> > >      maxItems: 1
> > > 
> > > +  vref-supply:
> > > +    description: External ADC reference voltage supply on VREFH pad.
> > 
> > Please add it to the list of required properties, we can remove it as
> > soon as the driver has support for the internal reference voltages.
> 
> I was thinking in doing so before as well. But DT describes the hardware, and 
> this ADC apparently would be functioning without a reference voltage on that 
> pad, using a different one. What the driver actual does is a different matter.

I have also thought about it first but than I checked the RM which says
that "multi-reference selection" is chip dependent.

Regards,
  Marco


> 
> Best regards,
> Alexander
> 
> > Regards,
> >   Marco
> > 
> > > +
> > > 
> > >    "#io-channel-cells":
> > >      const: 1
> > > 
> > > @@ -72,6 +75,7 @@ examples:
> > >              assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> > >              assigned-clock-rates = <24000000>;
> > >              power-domains = <&pd IMX_SC_R_ADC_0>;
> > > 
> > > +            vref-supply = <&reg_1v8>;
> > > 
> > >              #io-channel-cells = <1>;
> > >          
> > >          };
> > >      
> > >      };
> 
> 
> 
> 
> 
