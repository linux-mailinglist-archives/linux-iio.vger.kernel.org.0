Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76655001F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiFQWow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiFQWov (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 18:44:51 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E43B3C6;
        Fri, 17 Jun 2022 15:44:50 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id i16so5900754ioa.6;
        Fri, 17 Jun 2022 15:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkyBoQrK77DJf9OidPmzQRZw3BY2GrOu7sXDzTqHibQ=;
        b=tYpwtZCLTGnIpucqGTZ4Sh5Gv3o/QIz2U9ojPllJXkoOlegH2CZeYIWsRBNqYkfnVg
         heR/1MYbiyheLkvPW4BHptoN4qQ/HXhobbUm2SDcgM0AbBnt6rlXl4zPFcEj2NYc5NDv
         jzz2shVTT5czGd0PjN/SD9Dw+5OdH4jL+aBCsG3ecQG5SteCz/PltEKPVnh/Jsetb/ZN
         nwsvC+yc97Qq3pfbeGIPWhqsYIPwEdCuDprzsYegXgTNKG5uHoIj7jmlylZHJcJRTLjb
         9wi9zrrVoz+elGoWJ/lntry/yGUCsI4lLCkV7mlA+3Ovl1uLN45Rb/IV/TGaozdy0KO4
         q4EA==
X-Gm-Message-State: AJIora8KeqXUDApQv7LyRzWUyzHY6Vy5UGpuantVPPQx81c5N4rTL7cz
        oxXB4sbe8qhHlgJcts7zlQ==
X-Google-Smtp-Source: AGRyM1tDPeUx3oHDWGBfNfy3Bwife7YxjkilpSCRIPUY+TToJAdSs36ofKaHo7asCA3YZKFWMOKAcg==
X-Received: by 2002:a02:6a1e:0:b0:331:f9b9:a920 with SMTP id l30-20020a026a1e000000b00331f9b9a920mr6617996jac.44.1655505889508;
        Fri, 17 Jun 2022 15:44:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c31-20020a023b1f000000b0032e271a558csm2722382jaa.168.2022.06.17.15.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:44:49 -0700 (PDT)
Received: (nullmailer pid 2576416 invoked by uid 1000);
        Fri, 17 Jun 2022 22:44:48 -0000
Date:   Fri, 17 Jun 2022 16:44:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Message-ID: <20220617224448.GA2574775-robh@kernel.org>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
 <1655141687.002668.3951189.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655141687.002668.3951189.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:
> On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:
> > Both are already using the vf610 compatible.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> adc@2198000: 'num-channels' does not match any of the regexes: 'pinctrl-[0-9]+'

Looks like you need to add 'num-channels'?

> 	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
> 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
> 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
> 	arch/arm/boot/dts/imx6ul-geam.dtb
> 	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
> 	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
> 	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
> 	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
> 	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
> 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
> 	arch/arm/boot/dts/imx6ul-liteboard.dtb
> 	arch/arm/boot/dts/imx6ull-jozacp.dtb
> 	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
> 	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
> 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
> 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
> 	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
> 	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
> 	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
> 	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
> 	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
> 	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
> 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
> 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
> 	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
> 	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
> 	arch/arm/boot/dts/imx6ul-pico-pi.dtb
> 	arch/arm/boot/dts/imx6ul-prti6g.dtb
> 	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
> 	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
> 	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
> 	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
> 	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
> 	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
> 
> 
