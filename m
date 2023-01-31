Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EE682C55
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAaMOI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaMOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:14:07 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43053F29D;
        Tue, 31 Jan 2023 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675167246; x=1706703246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SrQW494zQd/xOVGrIEuwYC9iCR7cZ/BHB1SKMWvGKo4=;
  b=Q7JXtyd8XKbLBegUeOBwNyY+lt74PoVMVfwMV8/eNLBo3Ah5Jo3Vz3ma
   gt5GsV0jNeVFOdHddJA2eCFPd2SniY5k9eLYpittLXB7v626l/TJEmnNO
   ijX5w4C4vbuD5QDcmxajp214rZBxKa5AXGKZxF2hgU4xm1tQM84b8WTyD
   fEErgzR+UyASwZ5eNlAf+ZqdK5AdcS9W+XAqRCncWKKzSTpAko1eUb3Tk
   g21FfUswQEXwMZSxJQ78jbGECIy1e8bidTPUWGOSMUU+rySm2oEdHeKs2
   X+DP92IW5GjJ6maMvI3RCsnxjLDEhnRaOnS4RW6nXGgw4VFyJeMGR6KQy
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28770401"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 13:14:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 13:14:04 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 13:14:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675167244; x=1706703244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SrQW494zQd/xOVGrIEuwYC9iCR7cZ/BHB1SKMWvGKo4=;
  b=nDIFRpmEPdBbZxpUq0OHFzfX3uz16A0pnHMyI+/4h/melqT6Q+abOF3v
   laxhRb0HDDQnBReqhfVKgTfGSEcVXdnHbaEAyDxqN16yewHRp+h2/plCd
   Cr2vHTGlgT5yIL+/EhxEuxOuOHXEXtCIJ3WwL5rcPcKcr6putdWokZYOG
   STvN6zyteEkaGCGRAFk5SdhlU1Y1cS01vFMl805DiFJY9vuRG2l3l1Oya
   Pd6V3mPTO+CO0+WdrwvL6s8fz9EFf32Y02uSfvIRTAL0CWkeeFh6wKqdu
   CzVNTMG2SgzK2KMeZ8zJnaog5XRoPy+1dPOSAheBTbnnzaEy49VL39MEN
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28770400"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 13:14:03 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9AEFD280056;
        Tue, 31 Jan 2023 13:14:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
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
Date:   Tue, 31 Jan 2023 13:14:00 +0100
Message-ID: <1850476.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230131104816.w5sfpcdjulr2ogze@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com> <20230131104816.w5sfpcdjulr2ogze@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Marco,

thanks for the feedback.

Am Dienstag, 31. Januar 2023, 11:48:16 CET schrieb Marco Felsch:
> Hi Alexander,
> 
> On 23-01-31, Alexander Stein wrote:
> > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > this ADC has two internal reference voltages, which the driver currently
> > doesn't make use of.
> > 
> > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for
> > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml          | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml index
> > 63369ba388e4..879768af0303 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > 
> > @@ -39,6 +39,9 @@ properties:
> >    power-domains:
> >      maxItems: 1
> > 
> > +  vref-supply:
> > +    description: External ADC reference voltage supply on VREFH pad.
> 
> Please add it to the list of required properties, we can remove it as
> soon as the driver has support for the internal reference voltages.

I was thinking in doing so before as well. But DT describes the hardware, and 
this ADC apparently would be functioning without a reference voltage on that 
pad, using a different one. What the driver actual does is a different matter.

Best regards,
Alexander

> Regards,
>   Marco
> 
> > +
> > 
> >    "#io-channel-cells":
> >      const: 1
> > 
> > @@ -72,6 +75,7 @@ examples:
> >              assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> >              assigned-clock-rates = <24000000>;
> >              power-domains = <&pd IMX_SC_R_ADC_0>;
> > 
> > +            vref-supply = <&reg_1v8>;
> > 
> >              #io-channel-cells = <1>;
> >          
> >          };
> >      
> >      };




