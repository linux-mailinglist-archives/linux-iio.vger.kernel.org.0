Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8864BC60
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 19:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiLMSvj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 13:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiLMSvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 13:51:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C025282
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 10:51:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so6414952lfu.11
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4caiTUPwb5yRD+BikSwZkcJjgHseuGfEKaaNJStw97Q=;
        b=XLQoG/VIsczeHkAcemrUqyZ5KHS+OICYwdB81xqVKZ7g6TLTVA93aLg1O3oZYS9HaV
         jFJmPqyriz9pTo80a6U6d38WPKaq6Id03Z8kl7eA3Uev7QAxe0sGCJ5cOEGPSzOqBbcZ
         onIVqKSRivPaUMZRa6DtcNjzIdjAudhbtEXgBFNmEZGYGKMPG0weDXZZcPJP77dnIre3
         iHFromBBXkEzLBP+ld+3388d9tKiMHfPsWVSayXgGeLoOucKRdL7gill9MyE19edOrS4
         Fm4o8Lqu0mQk30qYKiDKrRtSNFWcPKaEYvAxPmcAqdy2nXGA+jq3UFHuFvH7YnUtUI7g
         Usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4caiTUPwb5yRD+BikSwZkcJjgHseuGfEKaaNJStw97Q=;
        b=33s+rysKB3KSsxlwnHbrYBCjxsidTm+onOZmfp3+xLcJKXltinCdMURl4np8PEOaN/
         xqO/3LUpZk8HbwJ4XskKJ4ijsbyOFUkEE+OXGhQC3MnW5DerAS/XiaSx0VgX3BHXEbvY
         R6LHhNA84T7dSelzNqUA3SsNODrn12VEYJE1LW6wdmOh07ZyUck1GCl18OvpiMNNbsi9
         fI01ueLkLAIceD5pGwZJI/AXhfy4q8omv+l85QMDQ5s5uMTQEkAk+hV8lDiNMshx6lJt
         nZtbmrQZbtxiL37x1xgYSkLMMKCa1Id4PatsESYDAGRdZtQveOCnB1owBJ/7bXuad4Vb
         vRFQ==
X-Gm-Message-State: ANoB5pnMt6qNOYhgXYia14YAFQ9OTMSgS71suULvjIIF2YpJ5d5GyDNI
        gJxzqFiBj5sdSaencAhjpxSHAw==
X-Google-Smtp-Source: AA0mqf6E4/sjsn22TId8xaneNkrZpb3Jps/q1fT2KrOG3UfeG50TKQCREt68tsCkvMaIyJX4z583NA==
X-Received: by 2002:a05:6512:b9d:b0:4b5:8237:5c12 with SMTP id b29-20020a0565120b9d00b004b582375c12mr10602415lfv.15.1670957494496;
        Tue, 13 Dec 2022 10:51:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j25-20020ac25519000000b004a6f66eed7fsm473142lfk.165.2022.12.13.10.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 10:51:34 -0800 (PST)
Message-ID: <acbdf493-eeef-4eb1-508e-c3cc1a31c886@linaro.org>
Date:   Tue, 13 Dec 2022 19:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] iio: accel: add the new entry in driver for
 FXLS8967AF
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
References: <20221213171536.1880089-1-han.xu@nxp.com>
 <20221213171536.1880089-4-han.xu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213171536.1880089-4-han.xu@nxp.com>
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

On 13/12/2022 18:15, Han Xu wrote:
> Add this new device entry in the driver id table.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> 
> ---
> changes in v2
> - change chip info orders

?? This is v1 attached here. There is also "iio: accel: add the new
entry in driver for fxls8967af"? This patchset cannot be applied, when
sent like this.

Best regards,
Krzysztof

