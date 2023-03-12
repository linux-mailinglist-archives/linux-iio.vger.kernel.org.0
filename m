Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423C6B6506
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCLKrZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCLKrY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 06:47:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ACA32E6F
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 03:47:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k10so37672529edk.13
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678618041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPQcTJnprKjz4aN56Vwu2Jyc5fmKQwcMip7oXq93ogM=;
        b=V9awQykFCrRudwnKavAUomavbs7FoSr6YaOYTV1kTGEnLquKR5VvHtCjX40HHo7tR3
         k9dZShcaclXMsPqiD5pjIUndbNACc/r1ESovXDjzG6TLeKS2YjrxJXdidZ6etnw75ySM
         sLGgIg8zjx8K+5/lrPuJQsGxHRqeMRCcD2aX4CygrWVc+zpMlxQ4jA1/C/8uRBqosGEp
         nNIs8UDYZOn9avnEWdsPl5+eczUyb56OYNygvus/tKd3f9OFhkKt4uNWFpUza5gmCv3d
         hnFZIBnI/W3enma8bMcJnXpP1J/eK35C7jlxUPvWmbpOv4LdlRQMlYd3Nzbz/tb/iopT
         XR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPQcTJnprKjz4aN56Vwu2Jyc5fmKQwcMip7oXq93ogM=;
        b=PHJmorwSSOHL9FFb7vLBK34tCM7YpTWdlOYP9PT2MaDBZN3sH8Q8tBjLMte5bf2VYQ
         awMVo4T142yJcn7J0TM4Q44vW9wksr1vHJmdmWQrQyeldLiDaHQkxmVuEXkPWYjDMpBh
         guYD2kOLcpg7/zQ1q6zMskUty4T5eO6ID7/2CwgeDCVMTSBea4dihgII73nxJJOlJkDe
         y+1MJc0Ncr8EXcG0CPRHXt/nIaSy3kvp8hJhyQj4ufKrWEOS2IGHqpxxpEJIPNtq5JE3
         fjkrjR7Hw2MTy5ZvSO+7OqBDiDokJSukpkHAUFbKcVUr/p61QF5dviwdoyESKY4B7SRS
         AVOQ==
X-Gm-Message-State: AO0yUKUtkTn87rBQvIB1Xr1EIM2PbAZvOCB+KP5mi4BUP7JLaBwiypZa
        V/8POqjQI1MxUp9OPP7ajh60yg==
X-Google-Smtp-Source: AK7set+/J79zPmxd3O0JYCN+liNr+yOK/4yhVF90oDHsTGp1WEL++XmHcJ6J16GeOPB5ds3PdgFn7A==
X-Received: by 2002:a17:906:9c8b:b0:8b1:76dd:f5ef with SMTP id fj11-20020a1709069c8b00b008b176ddf5efmr32559988ejc.5.1678618040757;
        Sun, 12 Mar 2023 03:47:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id b4-20020a50ccc4000000b004c09527d62dsm2084456edj.30.2023.03.12.03.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:47:20 -0700 (PDT)
Message-ID: <e6cb5a4f-30ac-3918-c188-cd14ef31f780@linaro.org>
Date:   Sun, 12 Mar 2023 11:47:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: light: add apds990x binding
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308090219.12710-1-clamor95@gmail.com>
 <20230308090219.12710-2-clamor95@gmail.com>
 <20230311193426.5b1b7e53@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311193426.5b1b7e53@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/03/2023 20:34, Jonathan Cameron wrote:

>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt
> It would nice to relax the need for an interrupt if the device is still useable
> with timeouts etc.  Board folk have a habit of deciding they don't need to wire
> up interrupts.  We can relax that a later date though if you prefer not to do
> it now.
>> +  - vdd-supply
>> +  - vled-supply
> 
> Whilst true that the supplies need to be connected, that doesn't
> mean they need to provided in the device tree binding.  If they are
> always powered up I think we can fallback to stub regulators.

We can, but others might not. The binding should still require them if
they are required for device to work. Mark also made it clear recently:

https://lore.kernel.org/all/31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk/
https://lore.kernel.org/all/5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk/
https://lore.kernel.org/all/f6f02138-8ef9-4a33-9b51-0b7cd371230f@sirena.org.uk/

Best regards,
Krzysztof

