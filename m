Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2846F29AD
	for <lists+linux-iio@lfdr.de>; Sun, 30 Apr 2023 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjD3RAl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Apr 2023 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjD3RAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2023 13:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653F3AA0;
        Sun, 30 Apr 2023 10:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6D360DF5;
        Sun, 30 Apr 2023 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4940C433EF;
        Sun, 30 Apr 2023 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682874014;
        bh=vMagLB0T24aEnGIYaVLE/dTFO6A15JIDpqUIewEjwd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXbo5RN40/Wzdi59ooW090ZAmDKYM1vN4r0hPV4FpE4Bs/eOT+VJPa63xtHZQm2PF
         LT5ItpNJV/9kRyyWFHPq39Xr3Ss0H85s/twuPjRb2yf28jTtnif0C5VN0Wik2uGXp7
         nJa/dNsDsz0PXm0aHv4lN4+eIXyKWWpvvuWlBy3Wiq3OaGderss5xj3kv5/8WTAqcJ
         tOK6jUl4LHJFHnnZ/t6G5L4jOz4VbRvdpndwnCKXzZfJ4RiHCs94krXVDgU5tFcwvY
         wf9Ob628bSd4dnrYVD7naMKMK+CSzz4uQWHawJQPJQCoYRgwN3/07kG9qDi1PjbnT8
         sVNcaqtw8H+Ww==
Date:   Sun, 30 Apr 2023 18:15:58 +0100
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
Message-ID: <20230430181558.7614cbfc@jic23-huawei>
In-Reply-To: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
References: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Apr 2023 11:23:12 +0200
Alexander Stein <alexander.stein@ew.tq-group.com> wrote:

> Although this property is used right now for IIO_CHAN_INFO_SCALE,
> this ADC has two internal reference voltages, which the driver currently
> doesn't make use of.
> 
> Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Interesting that we are talking her only about vrefh, what about vrefp?
I guess the assumption is that will be wired to 0V?

The first reference I found didn't seem to imply that was necessarily the
case. https://www.mouser.com/pdfDocs/IMX8QXPAEC.pdf


Jonathan

> ---
> Thanks for your inputs. This improved descritpion should make it clear
> that this property is only about the external reference voltage, not
> about the optional, internal voltages.
> 
> Changes in v2:
> * Improved commit message subject as suggested
> * Add hint about feature flag regarding multiple, internal, reference
>   voltages
> 
>  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> index 63369ba388e4..878e67054d7c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -39,6 +39,12 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  vref-supply:
> +    description: |
> +      External ADC reference voltage supply on VREFH pad. If VERID[MVI] is
> +      set, there are additional, internal reference voltages selectable.
> +      VREFH1 is always from VREFH pad.
> +
>    "#io-channel-cells":
>      const: 1
>  
> @@ -72,6 +78,7 @@ examples:
>              assigned-clocks = <&clk IMX_SC_R_ADC_0>;
>              assigned-clock-rates = <24000000>;
>              power-domains = <&pd IMX_SC_R_ADC_0>;
> +            vref-supply = <&reg_1v8>;
>              #io-channel-cells = <1>;
>          };
>      };

