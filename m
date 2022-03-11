Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19C4D6757
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 18:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiCKRQZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 12:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbiCKRQY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 12:16:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D01198EE7
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 09:15:19 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9435140160
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647018917;
        bh=Gc6o0dauMHLl2STaeWokUxRcXEEeDCCMBhTEPo6BQBk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nLoSZhMTClwjYAvHHm8lNAG61KmYWDLgXEdkqQ7wYwekvgvOsXeZqpYEEFrJdJp8N
         wvHKg55bgZjhX9K7dqNgejDJ2ChZMRsiuVDFDqP6jMDEkEOelG42QBqVQC+0n+Xpel
         8LUg4YH6MxmrpiHScKCQBqO7EhbgnXaF0Wf1Ca8vnT8CBE8DBOaskuYPLBu7oXqdCd
         nH03aB8I/Gr4+41U2D8AgFYktfoSBq0p1QqnZv5oWnHJlxUJIzyvdRuKVGMzEFNVbJ
         R+vxXXwYfMri5ecB1uPfbQcRh+jq30WNgfyD6Wc3CqP3aWeHUOkuCccpOCOb1AwAf8
         B4pS5ZpKm0eLQ==
Received: by mail-ed1-f69.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so5183710edd.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 09:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gc6o0dauMHLl2STaeWokUxRcXEEeDCCMBhTEPo6BQBk=;
        b=5p2a6GbUC2AOtcTNaUrskS9Rz5Cx6RyivWF9//KcC2vU/BTmcNG0N7u6vSMPDcPwLh
         XGShI4nWD9TdQ5D0qh6FQcBcX6g+3RKGDYLjl5P1EoB0J25L7pepNOhJHddEomzNyhQI
         NEmjYjWPUe5oKRdF/ezNgwSOcAdGhYa9vsw0zpNFzFfvTTivsRxZeL1Jpu5fT/q4/wr5
         vipWMF4uZlSOtIensEflDocV5wVYQLnE3VCns4i+mRPTSL/CRjYydj+sCQBFZ2lYTN64
         gwqF1HX3dUKA47kTQRyWniMf9enm1REAHiW88WHGAoLQXfWXs0hg5z7pYsM6N2qVGfWi
         Iu5Q==
X-Gm-Message-State: AOAM530lx3deiJ4RbsdQRTMfMyabhgY6QPkaw7jZgx4hjN/uH7/JTJfw
        qn/hRt6qANArW82Y8xFHV+HTnNuU4QdOZZlfRDvUGcX/rsS4GLphzX/GFIAOlliJ5JzCmf2lvni
        ZUa6neLPoOz7Drs9mzzjtW1nUnnqNwMsq5YFs9g==
X-Received: by 2002:a17:907:72ce:b0:6db:aed5:833e with SMTP id du14-20020a17090772ce00b006dbaed5833emr2360559ejc.420.1647018917074;
        Fri, 11 Mar 2022 09:15:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWC3BNaoCDDBdVXvwFBdb9cwHbA2vuKv+B1Eq7wiK2TARd6INYgWvkDRlyfEkVilx8u7a0rQ==
X-Received: by 2002:a17:907:72ce:b0:6db:aed5:833e with SMTP id du14-20020a17090772ce00b006dbaed5833emr2360548ejc.420.1647018916905;
        Fri, 11 Mar 2022 09:15:16 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm3126784ejc.99.2022.03.11.09.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 09:15:16 -0800 (PST)
Message-ID: <e9f0024a-461f-9f64-aa19-94b5ccf35be3@canonical.com>
Date:   Fri, 11 Mar 2022 18:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     michael.srba@seznam.cz, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220311161600.1469-1-michael.srba@seznam.cz>
 <20220311161600.1469-2-michael.srba@seznam.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311161600.1469-2-michael.srba@seznam.cz>
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

On 11/03/2022 17:15, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> ICM-20608-D differs from the other ICM-20608 variants by having
> a DMP (Digital Motion Processor) core tacked on.
> Despite having a different WHOAMI register, this variant is
> completely interchangeable with the other ICM-20608 variants
> by simply pretending the DMP core doesn't exist.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
> changelog:
>  - v2: require specifying "invensense,icm20608" as a fallback compatible
> ---
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
