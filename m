Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1755123D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiFTIMx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 04:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTIMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 04:12:52 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC71B1;
        Mon, 20 Jun 2022 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655712770; x=1687248770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9X+hssY9dN8kHsTO+3H05T9LNHIP8OupMLoBCdeI0Y=;
  b=nx12Z8IPKIvjomZt5FqLqZJ5rhtJKDIbZ5Jl1Mi106nz2cgwCeIhHKGP
   tQsXy3GKio7+ZREVE4fB7NlmR7cu5Q5O1KWlc0Eo6/y2fzsn9/YjPg4Si
   ee/5dIOpEnIQXzpLslu2OLSQVJ8JbQavT/H8MdctUqWlGROVI6ddRVwxk
   1mzSS3pqoKi/I/3bhJRdcMmeLCDmCHEP427NfVGqv4flAAH3w5Wy72ra0
   6UDgMJx1uLXdJdpZjuWBgJGL9qtzBVirnycLXBIXnVTzYXvxnNern22Tm
   VTYRhjHq4GAcLSx9No/rwWMGLd7qkBAbzvxWSXzSz5DDyZ96jcE1RpHum
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="24538778"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Jun 2022 10:12:47 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 20 Jun 2022 10:12:47 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 20 Jun 2022 10:12:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655712767; x=1687248767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9X+hssY9dN8kHsTO+3H05T9LNHIP8OupMLoBCdeI0Y=;
  b=boAAbYkKZ4ORgftneITgbtTpX5s95tUXbyFf/ndRWDtBdfa36VBxXdDM
   3Tgid5KUcFs7MC4qFbSJXjQJcj6RsO/IUO5PfXE14EXAkPIs38RH9cXWo
   ty9MTrqbbI+uuysJD3w73zZ+PuvSPbdavm7MIi3GdNaO6d6NuY7fMcMnC
   BkjFiDFXqV5i3X99UMdBjyFdzJ6ILI8btekol26dbMRZ1K1Prd4SzqKm2
   yBPyehcCtxpHdAfrLnR94cZqycuF2eYOkoTM4sRpECV6fLPD3l4krLd5A
   9Gnyp52Jpt8/hoHs9kzDFWkkOy+zeoHO6dv0Gqhk8g9vYSVXFVgX5ZWdP
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="24538777"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Jun 2022 10:12:47 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E5C5D280056;
        Mon, 20 Jun 2022 10:12:46 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Date:   Mon, 20 Jun 2022 10:12:44 +0200
Message-ID: <12003373.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220618180129.699b8601@jic23-huawei>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com> <20220617224448.GA2574775-robh@kernel.org> <20220618180129.699b8601@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Am Samstag, 18. Juni 2022, 19:01:29 CEST schrieb Jonathan Cameron:
> On Fri, 17 Jun 2022 16:44:48 -0600
> 
> Rob Herring <robh@kernel.org> wrote:
> > On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:
> > > On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:
> > > > Both are already using the vf610 compatible.
> > > > 
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9
> > > >  ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > > 
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > > This will change in the future.
> > > 
> > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > 
> > > 
> > > adc@2198000: 'num-channels' does not match any of the regexes:
> > > 'pinctrl-[0-9]+'> 
> > Looks like you need to add 'num-channels'?
> 
> or a lot of wrong dtbs :)
> 
> By which I mean ones providing a property that may or may not be actually
> used by any drivers...

This got already fixed by Baruch's patch which is currently in Shawn's imx-
fixes-5.19 branch at [1]

Best reagrds,
Alexander

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/
commit/?h=imx/dt&id=71b81f1cac29297769ec81fe29a3fcc40bc2c31c

> > > 	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
> > > 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
> > > 	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
> > > 	arch/arm/boot/dts/imx6ul-geam.dtb
> > > 	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
> > > 	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
> > > 	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
> > > 	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
> > > 	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
> > > 	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
> > > 	arch/arm/boot/dts/imx6ul-liteboard.dtb
> > > 	arch/arm/boot/dts/imx6ull-jozacp.dtb
> > > 	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
> > > 	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
> > > 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
> > > 	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
> > > 	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
> > > 	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
> > > 	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
> > > 	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
> > > 	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
> > > 	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
> > > 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
> > > 	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
> > > 	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
> > > 	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
> > > 	arch/arm/boot/dts/imx6ul-pico-pi.dtb
> > > 	arch/arm/boot/dts/imx6ul-prti6g.dtb
> > > 	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
> > > 	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
> > > 	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
> > > 	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
> > > 	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
> > > 	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb




