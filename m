Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7555062B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiFRQwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiFRQwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 12:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142EDE94;
        Sat, 18 Jun 2022 09:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A84C60F42;
        Sat, 18 Jun 2022 16:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50619C3411A;
        Sat, 18 Jun 2022 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655571132;
        bh=hO3gP+ei2JRu9oPGWa5DA4GlwowtTxu8lIIs+XqI6uM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U25fZxOh4+QM/eudqid+jHEK0ZlV/X7ItQPSWFn/kJc+l0E0fyNfQVLI/4ELmwCh0
         d/azHCPodB+/vgjAr4pjzd4kfk5vh7dCLQKFlCXTC9Cibgjd2TloAI8iVdZS/HorAE
         0pgE+8VxTOaXwUdmFwmlVN/DxWQ5axRuA30AJefNXg/GgSpJN2+OvrefJrvb6Bi5A6
         RtSVyHlkB4wxpaj401eyEwNINvGEOp45fghW1t4parMMDbCWcoj5qBoD5oSsT8IS2y
         RKB1A2OjrFzZtigbE0+d5vbvFel3wC5sGX+8mIEZyNPztkvI6ZxkPeNnbtrhXTE22q
         rHS3M2LQE7cJA==
Date:   Sat, 18 Jun 2022 18:01:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Message-ID: <20220618180129.699b8601@jic23-huawei>
In-Reply-To: <20220617224448.GA2574775-robh@kernel.org>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
        <1655141687.002668.3951189.nullmailer@robh.at.kernel.org>
        <20220617224448.GA2574775-robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jun 2022 16:44:48 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:
> > On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:  
> > > Both are already using the vf610 compatible.
> > > 
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >   
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> > 
> > 
> > adc@2198000: 'num-channels' does not match any of the regexes: 'pinctrl-[0-9]+'  
> 
> Looks like you need to add 'num-channels'?

or a lot of wrong dtbs :)

By which I mean ones providing a property that may or may not be actually
used by any drivers...

Jonathan


> 
> > 	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
> > 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
> > 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
> > 	arch/arm/boot/dts/imx6ul-geam.dtb
> > 	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
> > 	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
> > 	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
> > 	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
> > 	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
> > 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
> > 	arch/arm/boot/dts/imx6ul-liteboard.dtb
> > 	arch/arm/boot/dts/imx6ull-jozacp.dtb
> > 	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
> > 	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
> > 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
> > 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
> > 	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
> > 	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
> > 	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
> > 	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
> > 	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
> > 	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
> > 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
> > 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
> > 	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
> > 	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
> > 	arch/arm/boot/dts/imx6ul-pico-pi.dtb
> > 	arch/arm/boot/dts/imx6ul-prti6g.dtb
> > 	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
> > 	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
> > 	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
> > 	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
> > 	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
> > 	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
> > 
> >   

