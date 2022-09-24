Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6732C5E8D37
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIXOBm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIXOBl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 10:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B17E9CC5
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 07:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04341B80FF1
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 14:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DB9C433D6;
        Sat, 24 Sep 2022 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664028095;
        bh=AcP93rnfPboIo60bw8RgpP20TC58WqQNuPbvNDgD69Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cU86U7kzpSzhgdqPFNxL/a65IjGOpJh+9qwRidyyawjxHgiDXGcbHBTGKHdQUrr4R
         YIWTmOn5mRyN5dtBrfS2WcxlY7LgtGCBgF8H5/zl2H4mlhw+/r1ajQT98CxGl1vajy
         8hLBBerAsY7LeMOLD4r3TW3usTGHXQDHmCDKuX36I41qPg1PZbEO9B0e6u9bl2PFzJ
         YTJRE4apLeYcHdR18x5UseX+kISdPTVm4+S1a9TMeta/l0Oc8oYKfjZLxDgkM74gFK
         auYy+KarsKIElg3/e0MCc/l6TUF6+waBbRWyywDqOuLHUKBEig65JwHuMjTu/ae33i
         gON6fijzoF0LQ==
Date:   Sat, 24 Sep 2022 15:01:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220924150143.3ac19da3@jic23-huawei>
In-Reply-To: <20220920152628.285-3-Ibrahim.Tilki@analog.com>
References: <20220920152628.285-1-Ibrahim.Tilki@analog.com>
        <20220920152628.285-3-Ibrahim.Tilki@analog.com>
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

On Tue, 20 Sep 2022 18:26:27 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Hi Ibrahim,

I didn't notice before (just saw it whilst following up on a question you had
on v4), but this doesn't have the dt-binding maintainers and list in
the CC list.  As such it's not going to get the required review + tag
from them as they won't see it!

Follow up below on discussion on v4.

> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 177 ++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 0000000000..52a4f6027c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---

> +
> +patternProperties:
> +  "^channel(@[0-9])?$":

You correctly identified the issue with what values reg takes for differential
channels in v4.  Please raise that open question clearly in v6 when CC'ing the
dt experts!  Having written and review DT bindings for years, I still regularly
find out I've done things wrong :)

> +    $ref: "adc.yaml"
> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 9

> +
> +      diff-channels: true
> +

> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            reg = <0>;
> +            compatible = "adi,max11410";
> +            spi-max-frequency = <8000000>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 2>;
> +            interrupt-names = "gpio1";
> +
> +            avdd-supply = <&adc_avdd>;
> +
> +            vref1p-supply = <&adc_vref1p>;
> +            vref1n-supply = <&adc_vref1n>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channels = <2 3>;
> +                adi,reference = <1>;
> +                bipolar;
> +                settling-time-us = <100000>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                diff-channels = <7 9>;
> +                adi,reference = <5>;
> +                adi,input-mode = <2>;
> +                settling-time-us = <50000>;
> +            };
> +        };
> +    };

