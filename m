Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D095A632043
	for <lists+linux-iio@lfdr.de>; Mon, 21 Nov 2022 12:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKULUE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Nov 2022 06:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKULTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2022 06:19:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C782BF583
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 03:15:05 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h12so14090280ljg.9
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 03:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGZVXroNko2LYkXX2d1H5176dslCLRw4/wVpm6c8VeI=;
        b=qEhchM3MgppYSIBV1XnWkiC7NbnASNfljGkSnGQOviQ+f0Wj968PjRIOGWuwMkqy2H
         jnb/GrzRQEIWgQs4+DiD1ktBBoqtC3N9eHWLjhajHw6PC+nEbPkKeDKrB/aVeNbVUXpG
         cGw2bRIILy4ngROjKJ1kSJotNrl5rHhOba9aahn42csyn8ZgjDOnLO8vshyGtu1cGOIE
         IRy3cIs6G25oghlRT8mBK5NRTj6L3AdJ8fElCY8s2cuDPPI7RQZkdccjmxLt7/tgKl1r
         TMdnYki1lDOnEA/JcDFNRHWGED7LjPoFRhViaUizrraKvPOmNe9CPGs8NZozapePeAvV
         5TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGZVXroNko2LYkXX2d1H5176dslCLRw4/wVpm6c8VeI=;
        b=fTScfFhD3e6FDgtuBgRfwbNTh8NleRjsasnVnpRdlmJDPUF0rT5JLQbB4f+HlURjdT
         3/Shk16Ro3Zb7H1wD6kYj3BMSq4AtGm87BOHtN3tT9TT8lELy5AWbaenoxeO2yMUarlz
         +2Zs8SweQf/gAdy7gXCqqY5+3Rt0Bp1g5T9kePvBvDOc4m5GKPjxk6l+db/kX2u92wo+
         UWkIIA9ah/PCl8dMcGrbvixl5uIiYVHNUcn42ipu219Sr3B5KD/u+z+DPpnpauYgUkh7
         J47K2fx+3hiU0cKNbg9SqQGAfo+7nqMhtwDhuJDdMgX5iyEcEYgOanIKlXpX4ifHescv
         VEbg==
X-Gm-Message-State: ANoB5pkHwN0v5qMtsL/BQb38ECnO1s9CRIkeoJWj4f08pIF1EU4/5yHJ
        UyB0bkAcNBakIkJjD5Mxj/+j0g==
X-Google-Smtp-Source: AA0mqf6ix/+IvbUURLngZVLZxzFONWcQeQ1FwEpxAM4PSx9ITjsMwk+U4Vc3uWLeua7FmQaNss7j9w==
X-Received: by 2002:a2e:a265:0:b0:26d:ee99:93b4 with SMTP id k5-20020a2ea265000000b0026dee9993b4mr540887ljm.329.1669029303825;
        Mon, 21 Nov 2022 03:15:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b0049e9122bd0esm1178039lfr.114.2022.11.21.03.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:15:03 -0800 (PST)
Message-ID: <3847c997-6f66-4595-6352-7ed3f4dd3f6d@linaro.org>
Date:   Mon, 21 Nov 2022 12:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Content-Language: en-US
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221120153419.GA3094349-robh@kernel.org>
 <20221120170630.29354-1-edmund.berenson@emlix.com>
 <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
 <20221121102600.uwmgivssgy7oakxf@emlix.com>
 <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
 <20221121104532.dibxead6kiv3xqzw@emlix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121104532.dibxead6kiv3xqzw@emlix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/11/2022 11:45, Edmund Berenson wrote:

>>>> I would expect lower number as fallback.
>>> If I remove alone compatibility of 7924 and 7927 in the documentation,
>>
>> I don't understand. 7924 and 7927 are not compatible with each other -
>> neither in old code nor in new - so what do you want to remove?
>>
>>> I will have to remove explicit compatibility match on the driver side,
>>> correct?
>>> Just want to make sure I don't misunderstand you.
>>
>> My comment to which you responded was about order of items. Usually
>> lower number means older device and usually older device is the fallback.
> My response was meant to respond to both your comment to "deprecate
> alone compatibility" and "lower number should be fallback"
> Which I understood in the following way: because 7923, 7924 for one and
> 7927, 7928 are compatible with each other I will remove
> 7924 compatible string from driver and not add 7927 to the driver and
> only add it to the documentation.

That's not what I suggested. I said nothing about driver, I did not even
look there. I *only* asked to mark old variants as "deprecated: true".
Not remove anything from drivers as this would be obvious ABI break.


Best regards,
Krzysztof

