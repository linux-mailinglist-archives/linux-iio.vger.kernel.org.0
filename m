Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6FD632533
	for <lists+linux-iio@lfdr.de>; Mon, 21 Nov 2022 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKUOMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Nov 2022 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiKUOL0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2022 09:11:26 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E951C90A
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 06:08:40 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t10so14683824ljj.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1q/66qpieV42ROuLl508/NOCtso5oX8ztxq7+MJZS74=;
        b=aBTqybRW16+csQw2izdh0Z/Tj0Lsk9e5tDNHDVkqXxGVpi8ZGGdBefFmuZckcYvSNv
         ccO8+0/zdZjQhZ8MdHSNKbiiuuTJjFTjrGFukfLj0UifJluWc05jb16j9SNKexFvRQE/
         b35O3BsbViQVnWJJLT5DHrjfXxqe29OclCZHGU4/omQY8k9hXm6sJTeq7agyGviYdxK7
         qEZnarT2xh3OChfxr2V3l6KbiAYMBdgAeNyb21DDtx1zbd0+eTf2BTey7Lz2QfOfUlcA
         QwJ97wth0fIQCcSMT9Zi2WIyxqvK7fzJocKuMisbR1O0pX4kEYQWLu5iCl6hcNIlFrNg
         YXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1q/66qpieV42ROuLl508/NOCtso5oX8ztxq7+MJZS74=;
        b=twf/pKhUMvYBSyNt2ASaysS/1OG2ACB2ws7iN4e8cXSznxXtkvXAK+4O8Hf+LgXwBe
         c/NtSO/WaSvR5L4Ea7g5QuqYMvRhsByc6HHsPsSNXnGGwiK89NfEieYnMHriT8+Nn9XD
         1JTVA7837YWwGm0D0mTEooZflkhq01pZMowbvYNklYmCbEf6LXgd+A/Dh1E667T3oFQx
         gvsMR1g2WbYN72LovOImxKAPF17bsbHs6RVSXuAueL1wr+G+FipSlnv/HLUSQ8uTng+E
         OT+jtEEA74sds7WqwmBDN4FMO01H4y6qu3VE2aSwrWhicyVHqeeypgI8vpnp9njaZb6I
         rbrQ==
X-Gm-Message-State: ANoB5pkoE5XM9lTFQ3vbkCVZ5D/nk4cdBgOZOxhWm4wRENPnEzukjqag
        xm/PL5JmOPD3nSUp3c3URS2y5Q==
X-Google-Smtp-Source: AA0mqf6VveqNQ+m62AwB2rm6lHLBMfChSDcetgHGdiA1oaAB9sTaZG6t8MzhfxeZbmzwa2IBQ42MSw==
X-Received: by 2002:a2e:aa25:0:b0:277:4a17:be66 with SMTP id bf37-20020a2eaa25000000b002774a17be66mr6572661ljb.232.1669039718755;
        Mon, 21 Nov 2022 06:08:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f24-20020a193818000000b00492ceda336fsm2022674lfa.278.2022.11.21.06.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:08:38 -0800 (PST)
Message-ID: <c397969d-0f6c-42c2-cf08-3be81257cc22@linaro.org>
Date:   Mon, 21 Nov 2022 15:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Content-Language: en-US
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-2-gerald.loacker@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121123542.1322367-2-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/11/2022 13:35, Gerald Loacker wrote:
> Add bindings for TI TMAG5273.
> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
> Changes in v2:
>  - Removed nodename
>  - Changed angle-enable to angle-measurement and used strings
>  - Added interrupts
>  - Removed vcc-supply from required properties
>  - Changed i2c-0 to i2c in examples
>  .../iio/magnetometer/ti,tmag5273.yaml         | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> new file mode 100644
> index 000000000000..b2ecd7054a34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/ti,tmag5273.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
> +
> +maintainers:
> +  - Gerald Loacker <gerald.loacker@wolfvision.net>
> +
> +description:
> +  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
> +  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
> +  The device has an integrated temperature sensor available. The TMAG5273
> +  can be configured through the I2C interface to enable any combination of
> +  magnetic axes and temperature measurements. An integrated angle calculation
> +  engine (CORDIC) provides full 360° angular position information for both
> +  on-axis and off-axis angle measurement topologies. The angle calculation is
> +  performed using two user-selected magnetic axes.
> +
> +properties:
> +  compatible:
> +    const: ti,tmag5273
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  ti,angle-measurement:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Enables angle measurement in the selected plane.
> +      If not specified, "x-y" will be anables as default.
> +    enum:
> +      - "off"
> +      - "x-y"
> +      - "y-z"
> +      - "x-z"

Drop quotes from all these.

With this:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

