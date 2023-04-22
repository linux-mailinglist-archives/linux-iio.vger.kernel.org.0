Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629A6EBA20
	for <lists+linux-iio@lfdr.de>; Sat, 22 Apr 2023 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDVQCe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Apr 2023 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVQCd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Apr 2023 12:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3151736;
        Sat, 22 Apr 2023 09:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFD1611C1;
        Sat, 22 Apr 2023 16:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C543FC433EF;
        Sat, 22 Apr 2023 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682179351;
        bh=PoumuO8WQwaap5HmG8pUFcuCsPm1QbWRabiXoQhhiFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfcXZ350PyHfmCKruGAr1cbbVQm6ouJBElpPWHRMs/48iKCGdS/SsXAErj6MZnwuZ
         aUG1WKCnkkqlbKOTikhQhwOjaQtN+OP/fn8Cz4YJapnZZnIU7EelWLfpPCuAHUP3su
         uyky8tEmMK5k3uZuwb6Zt/motVVHEE7QQ8xLERT4BLZAU7Wn7VBZcViJCcD02OayvM
         NNw7vIhy/eWJ78QL9TZ/F8RlQnMp5EqkofRMR1pHSKvKM/TkpFqkbSWI1N57glnnCX
         iHH1pKjYX3fNm6YJYkphKYg7IRRN5gRRbKABK9ck+TKGJDkAV9PQZuP036T4OUSLdl
         3U75eCPr7Riwg==
Date:   Sat, 22 Apr 2023 17:18:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Message-ID: <20230422171807.510d7fa3@jic23-huawei>
In-Reply-To: <20230421085245.302169-2-herve.codina@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
        <20230421085245.302169-2-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Apr 2023 10:52:43 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The Renesas X9250 is a quad digitally controlled potentiometers.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Hi Herve,

Historically we've been a bit lax in IIO bindings in always making
sure the per supplies are included.  As a result we frequently get
them added later and it just makes things messier than they should
be.

So please add vcc-supply from the start.  V+ and V- are a little trickier.
I was expecting datasheet to say they should be symmetric about 0 but it
doesn't. So they could be two independent supplies.

Also make it required as my current understanding is that we should
do that for supplies that are definitely present even if we could
rely on the fallback to regulator stubs if they aren't supplied.
So add the 3 supplies to required as well.

Less of a requirement, but you might want to also provide an optional 
gpio for the not WP pin on basis someone might wire it up to the host processor.

Beyond the comment Krzystof made on iio.yaml this otherwise looks good to me.

Thanks,

Jonathan



> ---
>  .../iio/potentiometer/renesas,x9250.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> new file mode 100644
> index 000000000000..dfa36b23eb0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/renesas,x9250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas X9250 quad potentiometers
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Renesas X9250 integrates four digitally controlled potentiometers.
> +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> +  X9250U has a 50 kOhms total resistance.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +  - $ref: /schemas/iio/iio.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,x9250t
> +      - renesas,x9250u
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#io-channel-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        potentiometer@0 {
> +            compatible = "renesas,x9250t";
> +            reg = <0>;
> +            spi-max-frequency = <2000000>;
> +            #io-channel-cells = <1>;
> +        };
> +    };

