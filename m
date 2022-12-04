Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66549641D77
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLDO1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 09:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLDO1y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 09:27:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089D7643;
        Sun,  4 Dec 2022 06:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC3B60D2F;
        Sun,  4 Dec 2022 14:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F6C433C1;
        Sun,  4 Dec 2022 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670164071;
        bh=XSvIDwN3cWxgy86D24e4+Qi0IcagP/e6rbFBtLjZs4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grS+Bad4FUKjFI0t2w/D+Rsgr66JLR6vlXdvUDvKT0A+H5hqnZ53coFGu9+kAWqVN
         yIDbtf6XUrDOLyb5YK6gQbyLm8vhe6BZv+F9YQXgC6k+HuJ10Ac9bL41bMh25LAPc1
         8TxcoRXp4VWJlD5N7VKeHiE5hvDcV9DZlZE3Ig4mlPju2ifK9GEh/xXPcUjy43XIBM
         9/HCbsSlIFvrzQ1KNrRZJ5rj1ABmwIfM5P7rayvqMaHFy249OubTjpOoHjlA0PhTQH
         Y/d/kcnepV+fbYIIPtkRyThsv78hVL8C/CPoInFBkuxYwilsSgDGVZzZaJaISx1yCD
         0ciNd21PRjNxw==
Date:   Sun, 4 Dec 2022 14:40:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: qcom-pm8xxx: add missing child
 nodes
Message-ID: <20221204144036.25da4490@jic23-huawei>
In-Reply-To: <20221204061555.1355453-3-dmitry.baryshkov@linaro.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
        <20221204061555.1355453-3-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  4 Dec 2022 08:15:53 +0200
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Add gpio, keypad, led, mpps, pwrkey, vibrator and xoadc as possible
> child nodes of qcom,pm8xxx, referencing existint schema files.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> index 9acad9d326eb..7fe3875a5996 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> @@ -43,13 +43,37 @@ properties:
>    interrupt-controller: true
>  
>  patternProperties:
> +  "gpio@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
> +
> +  "keypad@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/input/qcom,pm8921-keypad.yaml#
> +
>    "led@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/leds/qcom,pm8058-led.yaml#
>  
> +  "mpps@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/pinctrl/qcom,pmic-mpp.yaml#
> +
> +  "pwrkey@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/input/qcom,pm8921-pwrkey.yaml#
> +
>    "rtc@[0-9a-f]+$":
>      type: object
> -    $ref: "../rtc/qcom-pm8xxx-rtc.yaml"
> +    $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#
> +
> +  "vibrator@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/input/qcom,pm8xxx-vib.yaml#
> +
> +  "xoadc@[0-9a-f]+$":

Should probably have a generic node name of
adc@...


> +    type: object
> +    $ref: /schemas/iio/adc/qcom,pm8018-adc.yaml#
>  
>  required:
>    - compatible

