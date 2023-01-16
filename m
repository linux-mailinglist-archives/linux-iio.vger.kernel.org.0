Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A966D1E3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjAPWrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 17:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjAPWrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 17:47:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB726581
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 14:47:09 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id cc13-20020a05683061cd00b00684b8cf2f4dso8682611otb.12
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 14:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FATXkotf+e5k0DIoWNX+6ny/uIc+V0aVbGsArp9hV0I=;
        b=3L/benYB/C4EXdHLfe+PKFTrvvM/yhylwfw0Kc+LfF8D9ui/Y5kc+cb8F+kvTcscGU
         B3aUM3vq9vJrJrOkZDUAFwRrYa41v8xnmxqM3Y+HrN+2+QjW848xj5f7hH1m168VJUQY
         WL4FTC8bucDOhSfTATY479+kkhYuHRrkSmnicn4iVAW7hR+QizcIzYJSqT38RQGKlEdQ
         4nOAaf4GhagEcBUDC6Gli3z53BHEQKaZFEcuYeqB1lXlZ5pEFwdXQZLxr5D9v1JVFE25
         0wDPezcrOm9HrUuvhXrnxzbjLDRz9JNb34HxV1uWVnaIdat59ZXqATdZP+SSTIww2MWd
         24bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FATXkotf+e5k0DIoWNX+6ny/uIc+V0aVbGsArp9hV0I=;
        b=0Qwqr48WBj6VMBbJCSTdq8XenklawUt07mof0cIm/DxbBCUlHG42PmJVax8nsZocs9
         Eyd+sro6uSFKDf9nRmgdHSutaxwsp6/4Dx6LJAdha13PDb7aWt8owdfkj+0kWaBip4y/
         GUoUUdrMNkQDEKJfoaHBM9Yhqh5vPjcYxBOgxFYD8kfFRvYaHdEi3ClvRZEndLN9T1fe
         KRzpULcyzp0Pywunvh89RAxuLi7rbsbp4G5ndxZsYlxH9htPy6yxpV2FfY2B0tYQyG7n
         3g6dcNztatgot4c8+TJ/wwfQSMhwdDSB7gx+uecTzpAEBF2Y3IDgIMuAcZ+IpCkrRKQC
         KLNg==
X-Gm-Message-State: AFqh2krOq7cBGIqScUVa/EqvKmH8kaH1ZgwnNKIJmq8ft1KBZoky5OGY
        aCPb7w/evWJPLGHdVe1lohOBSrzTrzjhuvr6FaI8/A==
X-Google-Smtp-Source: AMrXdXvcqiFGfpxCItwXfRO6b4PgKNre3Hjwmtb7rRGPpUb3+voahU92utHTE/WAt4HqriA0LVFKeLCJ7xOn6XIGVd0=
X-Received: by 2002:a05:6830:6607:b0:686:3bf5:6644 with SMTP id
 cp7-20020a056830660700b006863bf56644mr42675otb.239.1673909228683; Mon, 16 Jan
 2023 14:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20230115173958.134201-1-jic23@kernel.org>
In-Reply-To: <20230115173958.134201-1-jic23@kernel.org>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Mon, 16 Jan 2023 23:46:35 +0100
Message-ID: <CALJHbkDKTFN6BT=MCA5Obg6K6jY+yhwCd5Dsa5Ayrj=Z1mLwEA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: Maxim max5522 DAC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

thanks a lot, and sorry, looks like i forgot this out.

Reviewed-by: Angelo Dureghello <angelo.dureghello@timesys.com>


On Sun, Jan 15, 2023 at 6:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Add binding Doc for this SPI DAC.
>
> The driver was perviously posted but was missing the DT binding document.
> https://lore.kernel.org/all/20221106165928.223318-1-angelo.dureghello@timesys.com/
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Dureghello <angelo.dureghello@timesys.com>
>
> ---
>
> As it has been a few months and I don't want to end up not taking the driver
> simply because it lacked this simple binding doc, I've written one.
>
>  .../bindings/iio/dac/maxim,max5522.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
> new file mode 100644
> index 000000000000..24830f56c501
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/maxim,max5522.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX5522 Dual 10-bit Voltage-Output SPI DACs
> +
> +maintainers:
> +  - Angelo Dureghello <angelo.dureghello@timesys.com>
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Datasheet available at:
> +  https://www.analog.com/en/products/max5522.html
> +
> +properties:
> +  compatible:
> +    const: maxim,max5522
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vrefin-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vrefin-supply
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
> +        dac@0 {
> +            compatible = "maxim,max5522";
> +            reg = <0>;
> +            vrefin-supply = <&vref>;
> +        };
> +    };
> +...
> --
> 2.39.0
>


--
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
