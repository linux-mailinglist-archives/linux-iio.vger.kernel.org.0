Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB136549D1F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiFMTOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348582AbiFMTNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 15:13:34 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D79DF88;
        Mon, 13 Jun 2022 10:34:53 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id a10so6826400ioe.9;
        Mon, 13 Jun 2022 10:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sYLzOTBENP3NfN1PCCoAo3sOc2XW2MIX+0Xhlkpx5s8=;
        b=lRp7aQ7H0ItVphscOBet8N8Tk/NMXdcjN5E9FT9djLcV1MjKhKtaxZIh3H+dcGDX4V
         xDvzxUxHOByM0bgAiNSM53HOIrDi6Q0zjgJB1Sq9Fx51B4jX/CY+HK0Xeqn2foVIhpM5
         eRYEyv60D2P0qKiNyWYiB+Qx8nWJctlzFpEbPUbmZGX4n/iBVPXFChEAzAMJg/dYAfLx
         ec+C3sFR0GUGcfs9wJBj6X2582k/7tdAD6y0chvTH3T6wmyEDPB6qpUSDl1gvv6yBRoH
         uGCQuK/fCsTjcgoqtdga5GBni9k+FrAPwJz/ECltls74uB04INtTdZvWeGLmURcp9rcV
         /XKw==
X-Gm-Message-State: AOAM533oO92+JtYD9SFoASoqWY6u5GbE1Y7lW6483bPehVqRJAXfYomE
        m+2LfXf7A4wSDJenN1Dn1g==
X-Google-Smtp-Source: ABdhPJw+2TkWjSK8sDwc2Kg3/RBjre9zcT932WJZUctc/jDVSiLlJKiYajmI+w514opwwg9K3pIp3w==
X-Received: by 2002:a05:6638:250b:b0:331:b103:8b2b with SMTP id v11-20020a056638250b00b00331b1038b2bmr552127jat.246.1655141693138;
        Mon, 13 Jun 2022 10:34:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s5-20020a5e9805000000b006695b8bb8d3sm4129857ioj.12.2022.06.13.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:34:52 -0700 (PDT)
Received: (nullmailer pid 3951190 invoked by uid 1000);
        Mon, 13 Jun 2022 17:34:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
In-Reply-To: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Date:   Mon, 13 Jun 2022 11:34:46 -0600
Message-Id: <1655141687.002668.3951189.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:
> Both are already using the vf610 compatible.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


adc@2198000: 'num-channels' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb

