Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B434D4F64
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiCJQfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 11:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241780AbiCJQfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 11:35:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD3192E19
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 08:34:29 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 29DA83F1A8
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646930068;
        bh=1IwQ3+lE7F8QVvZKi9jUnPx1UJCjiECTmDvjI4+NsWA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EoDlnHlMeJPBxhARpqd3glfMj1E+Ll5Ymf4BfD+dUm02LghdFtWpPDFpuVCPk33wW
         PtGGEcf4kdrilpgnDH2UvsXRPzJzSQ0Gyii+HoYtI5FKpVX+gLu6CdYi5VkpGYF5Fq
         gdt+vCTg5BFakMf4NZoKF/0BXAqb5+86J+aTONAbbD2yGU6XAcLyT2FXSIpsi99k+8
         f2VEiQdr0TuwCf0LyTcTl/83NWBbk7zZKfcjy9B7b7mXiXYmYVptCtxW3w4sKmh4z3
         ooJI856hjHy9WA1Vj7YSSG71X8XzBArUwCVJVpoU932l2PPYyXFe9X8tCWjbIIukgk
         M0TbiAa8toLJw==
Received: by mail-ej1-f70.google.com with SMTP id hx13-20020a170906846d00b006db02e1a307so3419681ejc.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 08:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1IwQ3+lE7F8QVvZKi9jUnPx1UJCjiECTmDvjI4+NsWA=;
        b=SXH48YNY5Qj27mmFlnXZWl96X/HNbvrU8Iej2Fr1Ly11ecWCzdASPebzTZp8K1OhOb
         NOW/c8ItI1pKTYNl/FOrj0A7aODeD8N7NrEa9Jia7nl2QhEllAbe2iexoo5y6UMkNrN1
         x1lXBnDoDAlaN4mg7+jJOmqPnp7UuBtm0O/f3/rltYLYDncZhj8yrTmyM4WltTFslb9V
         YXZnXPh70ZRcasi7vamo8MMxi83zC3jpgWz3QfWLCiw0iP9LDIn7tGZoWx+MbaR1xI1B
         PQZPBZgmKZVcjyawn2YFozubm5P981zMgkux7rHODXg9olFzr/Wlvf/jJYYGlEqXo2i1
         prWA==
X-Gm-Message-State: AOAM532P27omXnMTpeN9TpkUhRpVaainZrsMaBaWGnqJ3Og8oaZmJFg3
        le4fPsuFwPPsvuY6mhFwfVN10XmZngA0T2BNdB/uWxqt/SWssiJBBewulqrtBqoW22AGBHh0R2r
        2J3kCL3zdEosMsgePxDHDAZp/Ss/fvnSCdaXceA==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr5217113ejc.395.1646930066498;
        Thu, 10 Mar 2022 08:34:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxFwgzpVc4iC6I9K9t8C4ipBY8edEC5UW6dfXT0OzGHM6OusG2akfMPUQfFEnuCmR2cgXM8w==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr5217086ejc.395.1646930066244;
        Thu, 10 Mar 2022 08:34:26 -0800 (PST)
Received: from [192.168.0.147] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm1938981ejd.152.2022.03.10.08.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:34:25 -0800 (PST)
Message-ID: <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
Date:   Thu, 10 Mar 2022 17:34:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     michael.srba@seznam.cz, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-2-michael.srba@seznam.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310133938.2495-2-michael.srba@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/03/2022 14:39, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> ICM-20608-D differs from the other ICM-20608 variants by having
> a DMP (Digital Motion Processor) core tacked on.
> Despite having a different WHOAMI register, this variant is
> completely interchangeable with the other ICM-20608 variants
> by simply pretending the DMP core doesn't exist.

I wonder now why not using generic invensense,icm20608 compatible as
fallback? Why only having one specific compatible?

> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> index d69595a524c1..6784cc140323 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - invensense,iam20680
>        - invensense,icm20608
> +      - invensense,icm20608d
>        - invensense,icm20609
>        - invensense,icm20689
>        - invensense,icm20602


Best regards,
Krzysztof
