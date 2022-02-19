Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07324BC953
	for <lists+linux-iio@lfdr.de>; Sat, 19 Feb 2022 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiBSQkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Feb 2022 11:40:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Feb 2022 11:40:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B591BAC48
        for <linux-iio@vger.kernel.org>; Sat, 19 Feb 2022 08:39:40 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD3B13F1A1
        for <linux-iio@vger.kernel.org>; Sat, 19 Feb 2022 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645288778;
        bh=fv6Vlts8WZIOYFM6nhe/RZHWwtYVs4haR4eZslzQ91M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Gw+t81ySigxZI9PojtI690BRL/zTq0Z5pzqtZtzuD7XZn+3s3Ji4CyRqMlR4no2wy
         PD8PCTE8KQWsHZlrtecwo45ase9w0yk9OLqWvpRISJnreDnkrnnEpm+GRnKMB1uLNf
         baAMLa8LbcwTL8LvvepGNBVe2kovHW/aL87jL18zGK3HpwGB0C4qLokpzdRTqFPVUI
         OWuunoPsoOgowSNGhZf3HO/oYBt9aGLESuPJaGfYFTbG+3X0XoSb72zZqxcOoC6QLX
         brOVKeQg1zUOL4r3vxU55APcr7wp8MLyP7WDF8n04gbrZSXFtXYpzvKU3n2rcu3TMA
         y36CFD+ZkvC+Q==
Received: by mail-wr1-f69.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so4825247wra.16
        for <linux-iio@vger.kernel.org>; Sat, 19 Feb 2022 08:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fv6Vlts8WZIOYFM6nhe/RZHWwtYVs4haR4eZslzQ91M=;
        b=YRkOdXxA30+ew35s8aqdPKumbV2oSdMnHcx13axHYOHHq4bNH3xdC7ifw5NjYTkrZ+
         WRhhCo1cTQ3YmWOVelXvbbQeK1s42ZURWhVYMsohdz04PD12pe6NL+Sx4u99UJrCn/rn
         Fqfezweao40/l+7WeWKUhd0fjxOMG274dg0aOvzB/t7znxdWN0/k01+XcyNcwvgMzRaW
         GdtdnCyHahWiSQCnFa9p5kB9y6Xo/mzzA2GQ6VBsp0vm1JFZA12gB1olYvqd14VT1BM5
         RaL9YOSu86F0yOtWToCC5xC6EAnVFQ3VteFBZJLxYnApA6xHfW7O/O2BjizrLLvLN3BH
         qwwg==
X-Gm-Message-State: AOAM530XXJz24G17ZR6i+BgwUx+MQ2aTqva7JHrbGQjuzEP+yW6h9Spq
        BIaZoZgNSVjsyPm6ATrWqBjGHgCPl7XV3K1GfcMmwLYB41iVNtprHTRWASheMVouP1YWkHYZXZK
        XSCoEOOxlHolgXYvk+Dn5BVXL+fekY1jR1ppv8Q==
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id h24-20020a7bc938000000b0037bfdaa2749mr15160141wml.88.1645288778271;
        Sat, 19 Feb 2022 08:39:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTjIE8tRPmBD+PlkUTZBca9lbgzOitR83nDpYhWogpejZ8yTpnvZi5vWazVdvUaNy10Rl8sw==
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id h24-20020a7bc938000000b0037bfdaa2749mr15160128wml.88.1645288778087;
        Sat, 19 Feb 2022 08:39:38 -0800 (PST)
Received: from [192.168.0.116] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p7sm20505311wrr.95.2022.02.19.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 08:39:37 -0800 (PST)
Message-ID: <6188a47f-ed12-7d0a-bc28-5efa4092b59f@canonical.com>
Date:   Sat, 19 Feb 2022 17:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Content-Language: en-US
To:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220218150738.94735-1-cristian.pop@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220218150738.94735-1-cristian.pop@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/02/2022 16:07, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> changes in v5:
>  - Add spaces and fix prefix in commit subject
>  - Rename node name: admv4420 -> mixer
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
