Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF84D474C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiCJMwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 07:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiCJMwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 07:52:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3A148920
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 04:51:43 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C6DB13F4BC
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646916700;
        bh=TQz+s86WSRF8JD18DoYGMl9h0Gp5VNc55zA58BrovNE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=G4ucPY7QpAuGwqq+gML/vjnxTR7TcEGAMuQ4qNS+ikutduRIR072eZPgGNsyC0yXA
         vcyPkDoeop1eWlFvcPXmcJ1mxTN374fbJPmr4DOxutPFJYzLLB6D8xnSfqQcXD/L5P
         sOOIyv/WogTrmFRLcgBdYNajADatSaej/OVCdg9IThIiBOkCO9q95D+Xge0cBXuP+f
         l4p9ATbHbwsEVM+j2X72iOkzE5sj98Fw5WB7B6i1gMF9yB1h3DFdJgF7q5uQcFSi2D
         T3bVp4OMlH6aW2AxU2w5D+sUn9f6jCE+Tb8tutCEvSWj4IVdZvny+XTkWNs94EYHsy
         Xy8nILi3yYrkQ==
Received: by mail-ed1-f70.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so3028925edq.21
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 04:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TQz+s86WSRF8JD18DoYGMl9h0Gp5VNc55zA58BrovNE=;
        b=eS7W8Gg43emXGJIfAo2JjEAD26JAQLwvK5vfhiK6VsPMiyePtFa3KVS64rS+iI/Obz
         n90eU2leFGqzhzbYRHmblottkbvbUgLAmhwE0Z+os9LtRASTngiOY3p4Wc40aHJPIZoj
         O7T6AhTtbcyxwJa24hGTRlVqmYc8yYQ+/o06fdAxNYsOPdk3Rp2q8kNK/j9tUtGO5EYf
         NPoIQc2QHcvYR7oX+8pREyDS0nQTlY1SV6/a34OgdrLxKbbl9Y2CblNgJTJ4TV555401
         jp5JdTo4YmruhEVXD/p4CyNE/8LD7jiJ/CEU0th0ZNIRfl1/HARaa1fWFWWrhORKSmUH
         leMA==
X-Gm-Message-State: AOAM533yshffj7VKjmjpC6XBBpkqXIc9NyGEDw0ug6bnc6d/APJFjDU/
        KropAAuUiCOr9KhpnBAia3Cn5v/YJckCtakp0Ifb+7Q5Zi5ghkHeTZggbJmAs+ofWVb5CjiWbrS
        pv68+hUpPSQe/a/8s64fPtvoooemxWQcNw2Z7ig==
X-Received: by 2002:a05:6402:cb:b0:410:8094:872b with SMTP id i11-20020a05640200cb00b004108094872bmr4293524edu.378.1646916700509;
        Thu, 10 Mar 2022 04:51:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGbKpPr7brplhUtze/R2VoXUIp2jvGlg5y1FoUnr4MNZLvDWAUUfEoDuoqQwNR5nCBqQnqgg==
X-Received: by 2002:a05:6402:cb:b0:410:8094:872b with SMTP id i11-20020a05640200cb00b004108094872bmr4293511edu.378.1646916700360;
        Thu, 10 Mar 2022 04:51:40 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id zb5-20020a17090687c500b006ce2a98f715sm1718595ejb.117.2022.03.10.04.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:51:39 -0800 (PST)
Message-ID: <d683043f-dfcf-8254-4457-c56359e4c0de@canonical.com>
Date:   Thu, 10 Mar 2022 13:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: ti,ads1015: Add missing
 ADS1115 compatible string
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220310003402.490478-1-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310003402.490478-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/03/2022 01:33, Marek Vasut wrote:
> Add missing ti,ads1115 compatible string. This compatible string is
> supported by the Linux kernel driver and the ads1015 is a 12bit ADC
> while ads1115 is 16bit ADC. Add the missing compatible string.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
