Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B134E8844
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiC0O4Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiC0O4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 10:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155855A8;
        Sun, 27 Mar 2022 07:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7FD61028;
        Sun, 27 Mar 2022 14:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74DDC340EC;
        Sun, 27 Mar 2022 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648392875;
        bh=bRXhuKrJ6pznB4+tu0/oJB6VVtpKMq6WO6RpNjLduIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gH4YpmPiIGVPp7HGcinCOjxpo/+eVFtsiib44X5NFaUojH9gINQd7BgNsPxkotSPc
         B8qS5IDgHqZyfIFarKwZf0lEyJVsWcrqeFgg2Gf6PM9dx/WZK7dU7CjKhOwd1eJfUI
         gkm+EtlB5vADr/uuQjDaQVRQjCOw0q6mg8iIUjFl7vyNnFz02u9lay62GLn0IVz05/
         V2j9gPivYxQfDGjA78zxDtL3DcyJM6xyUGflz95wj8dTd9Eblwf+5spRtEH3Xagvuf
         9Y8f66zZWjOhsVFJGhmIWZpqWCvW/edDhYIjEY6wlQICDsYIgjFQiZ0S09I06nmOiJ
         rWO3bbJn6LKFg==
Date:   Sun, 27 Mar 2022 16:02:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v13 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Message-ID: <20220327160206.41c9b86d@jic23-huawei>
In-Reply-To: <20220323162820.110806-5-caleb@connolly.tech>
References: <20220323162820.110806-1-caleb@connolly.tech>
        <20220323162820.110806-5-caleb@connolly.tech>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Mar 2022 16:28:15 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
> PMI8998 and PMI8994
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
On basis I don't mind if Lee want's to pick this up and send me an
immutable branch. If not, once Lee has taken a look I can create
an immutable branch for this.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> new file mode 100644
> index 000000000000..c8cbfd3444be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-rradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC Round Robin ADC
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>
> +
> +description: |
> +  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to
> +  read the voltage, current and temperature for supported peripherals such as
> +  the battery thermistor die temperature, charger temperature, USB and DC input
> +  voltage / current and battery ID resistor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8998-rradc
> +      - qcom,pm660-rradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,batt-id-delay-ms:
> +    description: Sets the hardware settling time for the battery ID resistor.
> +    enum: [0, 1, 4, 12, 20, 40, 60, 80]
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic_rradc: adc@4500 {
> +          compatible = "qcom,pmi8998-rradc";
> +          reg = <0x4500>;
> +          #io-channel-cells  = <1>;
> +      };
> +    };

