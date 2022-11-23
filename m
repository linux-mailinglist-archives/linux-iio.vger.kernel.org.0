Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99612635F45
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiKWNWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 08:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiKWNWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 08:22:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A93FB8B
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 05:01:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l8so21259806ljh.13
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp9LQRHK4UZG+xUfLLMwYJtuh3wPrpxN6Fnd2UjWdQg=;
        b=YqKW4WZ12w3737HpIKaIbSfRqSmPKWir3XDrW/zdqOV9JGrfgldRSUQjiOR4mpwLZL
         CO+CHVIHt2qkz75r4PuT1YifKI/ufwNk5CLMVXDEnjYh7zYOibvXOFRLqK+eOY4JqvRa
         eylk3gfX+g7syMCZg6KdhAncldUPL6p8UKHWvE8a+SpBROLKURnbhyQ76keSjsPLxvFr
         euPLS7vpgu8v9MlgyjPLinBvTgoSYUbjCGPFxWH5zBqhxO9NI3+MV1+oW06cV5+DmYTU
         2Wxron4/P1HDYbINnL2S67EKIlSDaeuH8ldHoqSH2es4ghAFTlCTrCpmNhgR2wRM3yw0
         WEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp9LQRHK4UZG+xUfLLMwYJtuh3wPrpxN6Fnd2UjWdQg=;
        b=YRCwlraTDQQorgqohY4U7sAVmC+IJmIP5j22P8u78H4Po4tCBiYU6rVRQtthLRaTbw
         HD+LQWcZxGtxjt67OYfT1J1J7o6VR6u+/Oel/NLFSoBcYopo54d96GGyhKsg8Pl+hKll
         I2p9o40/kZ3OuP5nMf/hEEJR93KXhJz7W2ff4/YaZ8bKPbc48Hm+kbbuVJ6YY6vYFLmk
         XIBHFWBPHaMcmbnWR1RgD7+BhsMUAmGo1ci6Devkz9BQTGPUwfmcuo89XoYfo2/foaEO
         PzazTxvIr2ZmwC1W1t0tsBAwaPrUXo3RpjSRWOrfrskqaxUusCobPAKpiHnpXX/y2KyZ
         jIyg==
X-Gm-Message-State: ANoB5pnL/0idFMoM/uzECp7eIJoR1dy5q9gfn1vgiTh5GLhNtpLRBSwY
        wG8xwLS1FBtQ/tzYM2lSS9qK2g==
X-Google-Smtp-Source: AA0mqf5DGm4ZvktT4NR9WyAWpPuHSnlNUVoErSOEdsb9pP81a5SYi+qylXXNjUQBbNtecR/QIXyT/g==
X-Received: by 2002:a2e:a90b:0:b0:277:794:ae09 with SMTP id j11-20020a2ea90b000000b002770794ae09mr8806647ljq.286.1669208492340;
        Wed, 23 Nov 2022 05:01:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p7-20020a2eb987000000b002796fb63dbdsm534480ljp.13.2022.11.23.05.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:01:31 -0800 (PST)
Message-ID: <4d62d7e9-5454-4d1c-b3bb-4ba1fd7a31d6@linaro.org>
Date:   Wed, 23 Nov 2022 14:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5] dt-bindings: iio: adc: ad7923: adjust documentation
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
References: <20221122161437.18937-1-edmund.berenson@emlix.com>
 <c96d84e9-44d0-a389-429d-91d8a7d747b5@linaro.org>
 <20221123113224.5vxs2zmxf7z2bmvm@emlix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123113224.5vxs2zmxf7z2bmvm@emlix.com>
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

On 23/11/2022 12:32, Edmund Berenson wrote:
> On Wed, Nov 23, 2022 at 11:42:40AM +0100, Krzysztof Kozlowski wrote:
>> On 22/11/2022 17:14, Edmund Berenson wrote:
>>> - The ad7927 is fully compatible with ad7928 driver, add
>>> documentation for device.
>>> - ad7923 and ad7924 are treated the same in the driver, show
>>> the relationship in the documentation.
>>>
>>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
>>> ---
>>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
>>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>>
>>
>> 1. This is a v5, what are the changes?
>>
> The original idea was adding the compatible string into driver itself,
> then it was suggested that I have a fallback compatible to 7928 as the
> hardware versions are treated the same in the driver. After that it was
> suggested to add deprecated flag to standalone compatibility, but doing
> so I didn't want to add compatibility on driver side just to mark it
> deprecated in the documentation, so I dropped driver side changes.
> Finally I had some issues getting the documentation syntax into an
> acceptable form, mainly const vs enum listing of compatibility stings.

That's a bit too long for a changelog. Keep it short but still
descriptive. Anyway - this must be in the changelog place, so after ---


Best regards,
Krzysztof

