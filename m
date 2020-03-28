Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24FB1967C2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1QyW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgC1QyW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 12:54:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15056206DB;
        Sat, 28 Mar 2020 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585414461;
        bh=40r1l9mcdBUk5jg2yFANBM1CqwC81fi6zrWp9U/3P58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wD9SGskxMvyCE/JITbcLRzKht8D7FRqqeHrJAvklxfjYuqrHcgOtyOs77YmRBPC3B
         y50Yf4L6ZzQnG7krEiWs1EriFb8k0WkzALQDEnLpsfMV2W2K+SHnMz+n+MAj3OvHL9
         /lfn52yA+rxbSdwz8UUrk/oeYERNeyAg0Zgy5i+o=
Date:   Sat, 28 Mar 2020 16:54:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
Message-ID: <20200328165410.7db48818@archlinux>
In-Reply-To: <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
        <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 21:14:09 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
> communication to ADC goes through PMK8350, which communicates with
> other PMICs through PBS.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 72db14c..20f010c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>    voltage. The VADC is a 16-bit sigma-delta ADC.
>  
>  properties:
> @@ -23,6 +23,7 @@ properties:
>        - qcom,spmi-adc5
>        - qcom,spmi-adc-rev2
>        - qcom,pms405-adc
> +      - qcom,spmi-adc7
>  
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> @@ -65,6 +66,8 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/qcom,spmi-vadc.h
> +          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> +          in the PMIC-specific files in include/dt-bindings/iio/.

That makes me thing we really should have separate compatibles.  The
parts clearly have differences, even if we haven't needed to use them
explicitly as yet.

>  
>        label:
>          description: |
> @@ -72,7 +75,7 @@ patternProperties:
>              For thermistor inputs connected to generic AMUX or GPIO inputs
>              these can vary across platform for the same pins. Hence select
>              the platform schematics name for this channel. It is required
> -            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
> +            for "qcom,spmi-adc5", "qcom,spmi-adc7" and "qcom,spmi-adc-rev2".
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/string
>  
> @@ -85,6 +88,8 @@ patternProperties:
>                of 512 will be used.
>              - For compatible property "qcom,spmi-adc5", valid values are 250, 420
>                and 840. If property is not found, default value of 840 is used.
> +            - For compatible property "qcom,spmi-adc7", valid values are 85, 340
> +              and 1360. If property is not found, default value of 1360 is used.
>              - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
>                512 and 1024. If property is not present, default value is 1024.
>          allOf:
> @@ -109,11 +114,11 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> -              if this property is specified VADC will use the VDD reference (1.875V)
> -              and GND for channel calibration. If property is not found, channel
> -              will be calibrated with 0V and 1.25V reference channels, also known
> -              as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
> +              "qcom,spmi-adc-rev2", if this property is specified VADC will use
> +              the VDD reference (1.875V) and GND for channel calibration. If
> +              property is not found, channel will be calibrated with 0V and 1.25V
> +              reference channels, also known as absolute calibration.
>          type: boolean
>  
>        qcom,hw-settle-time:
> @@ -135,6 +140,12 @@ patternProperties:
>                Certain controller digital versions have valid values of
>                15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
>                If property is not found, channel will use 15us.
> +            - For compatible property "qcom,spmi-adc7", delay = 15us for
> +              value 0, 100us * (value) for values < 8, 1ms for value 8
> +              and 2ms * (value - 8) otherwise.
> +              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000,
> +              4000, 8000, 16000, 32000, 64000, 128000 us.
> +              If property is not found, channel will use 15us.
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
>  
> @@ -147,6 +158,9 @@ patternProperties:
>              - For compatible property "qcom,spmi-vadc", valid values
>                are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
>                If property is not found, 1 sample will be used.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7"
> +              and "qcom,spmi-adc-rev2", valid values are: 1, 2, 4, 8, 16.
> +              If property is not found, 1 sample will be used.
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
>  

