Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425C6F98BC
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEGNo6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEGNoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 09:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580615684;
        Sun,  7 May 2023 06:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6ED611D6;
        Sun,  7 May 2023 13:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07259C433EF;
        Sun,  7 May 2023 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683467091;
        bh=/omlLysihdl8+PiJHmfwCUqmEW4kfNh2cWe39Dzmne8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bRR+8dwRT+xUojVrlhoa9X4C3WhIJ3NRsTHd7D4RTL/qD8QpAG/F0OpkCctrlIQNH
         htw0XLu5bHK7+75tIJOiuxGb7Yl34N+lxs57z8jTIf5dyyZBHMOusvJeS11Y+m/j2s
         FUMio8Rf+ogOYfeTvnOUzagMXKKbWDWGMUUAEzaGiWxugXqj4B7eal6dtRJXl8Vqns
         pI7COvi86i+snDuirvxuJouvkvM3hFTL3biWoeC1WqkS276QhA8PldplvZT/MQXDSN
         4PSsa38Tm6G0plZY7fGFIETN8uw04tNJMG3cJ+9UCUcs6awbqYV28KQLz2/tVrCkWx
         lZ+P2zZZ2OAgA==
Date:   Sun, 7 May 2023 15:00:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing
 vref-supply
Message-ID: <20230507150043.4b4adfac@jic23-huawei>
In-Reply-To: <5671528.DvuYhMxLoT@steina-w>
References: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
        <20230430181558.7614cbfc@jic23-huawei>
        <5671528.DvuYhMxLoT@steina-w>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 02 May 2023 08:34:12 +0200
Alexander Stein <alexander.stein@ew.tq-group.com> wrote:

> Am Sonntag, 30. April 2023, 19:15:58 CEST schrieb Jonathan Cameron:
> > On Mon, 24 Apr 2023 11:23:12 +0200
> > 
> > Alexander Stein <alexander.stein@ew.tq-group.com> wrote:  
> > > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > > this ADC has two internal reference voltages, which the driver currently
> > > doesn't make use of.
> > > 
> > > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for
> > > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > > <alexander.stein@ew.tq-group.com>  
> > 
> > Interesting that we are talking her only about vrefh, what about vrefp?
> > I guess the assumption is that will be wired to 0V?  
> 
> What's vrefp? The only other signal related to ADC is vrefl.

oops. Indeed vrefl.

> 
> > The first reference I found didn't seem to imply that was necessarily the
> > case. https://www.mouser.com/pdfDocs/IMX8QXPAEC.pdf  
> 
> Assuming you are talking about vrefh and vrefl, how is this a problem? Even if 
> vrefl is not 0V, the voltage difference is what the ADC uses as reference 
> voltage, so this should be supplied in the DT then.

Those two voltages can be supplied by entirely unrelated regulators (well
probably high precision references, but represented as regulators).  Those
may well need turning on.

I don't think there is any way to define that in DT without the consumer (here
the ADC) taking two different supplies.

Maybe that's a usecase no one cares about though and they will either supply
this with fixed regulators, or with a single precision reference supplying
both voltages.

Also, assuming these are used in a moderately normal reference way, if
vrefl is not 0V the driver should be supplying offset information to
consumers of this channel (userspace etc) to account for that.

meh. I don't care that much if this isn't a case we actually need to care about.
I just found it interesting the datasheet didn't talk about these as either
a differential pair (so balanced) or a reference 0V and vref.

I'll apply this as it stands.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan


> 
> Best regards
> Alexander
> 
> > Jonathan
> >   
> > > ---
> > > Thanks for your inputs. This improved descritpion should make it clear
> > > that this property is only about the external reference voltage, not
> > > about the optional, internal voltages.
> > > 
> > > Changes in v2:
> > > * Improved commit message subject as suggested
> > > * Add hint about feature flag regarding multiple, internal, reference
> > > 
> > >   voltages
> > >  
> > >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml       | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml index
> > > 63369ba388e4..878e67054d7c 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > 
> > > @@ -39,6 +39,12 @@ properties:
> > >    power-domains:
> > >      maxItems: 1
> > > 
> > > +  vref-supply:
> > > +    description: |
> > > +      External ADC reference voltage supply on VREFH pad. If VERID[MVI]
> > > is
> > > +      set, there are additional, internal reference voltages selectable.
> > > +      VREFH1 is always from VREFH pad.
> > > +
> > > 
> > >    "#io-channel-cells":
> > >      const: 1
> > > 
> > > @@ -72,6 +78,7 @@ examples:
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

