Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A760F6D3699
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDBJnT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDBJnS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 05:43:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F901881A
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 02:42:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er13so65256804edb.9
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680428564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmOyDxhsRopi36Lx/Ljk8A9Cwl6udet2Bmq7NGembFQ=;
        b=qUzamM9T87te8vAKpDkdQw0fAY8Zp3lmvmi48v248rZSyldgZgnenDPmkS1Djsjp+P
         YzkCqJYDYNOD/zSMyX2bQ5zXz01d4GMbAhpvQonjGMwg7ExDyFedy7WjJQNmvEzVRlBe
         Nn2rA8RvzLSYEl+nyZ2rjaeenRcqylKxU5PZkMXOtzksjj3kZW7ffs2yQ9Ii7IsiVkJG
         JK3RICetHe8Z06C7/JaC6RKRN5vnb98/eIdrWlwhVbjb56DHGjoWYTol+NwB8/TXhn+8
         ThIBmfhZy1rdBCwON/eSWN8I3pRD2uH1eR2ydNKFpBOXxGB7r/FWTWpumRqpOXDM+1pE
         1ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680428564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmOyDxhsRopi36Lx/Ljk8A9Cwl6udet2Bmq7NGembFQ=;
        b=OGs6SQmwHWFtJPQ7/oPNBU4quPemu218g4GoaG1a95DMENVQUbq+DZ3hgaM6OvVcTx
         8BkdGyUjTR9eXvvIUX7C8aZuuGsSczagjOwC2wg56tzSC8x7Q1Dln+Jt28NzTW5f9Edo
         cOC/Jnt5qyIH/sSJvBFmHgoZDceQj7Gcd7WbgJKOPm5wWNesvP9WE9gFWhLOPmkEIjh7
         hdIlwfC9FBZn0rP0SpnwcPDbPRAu4so4NQHK47I39Wj38DIoMs1ASyIHQG+B58rS7Fot
         RYxBXhqpQP49LDa03fv3GeHqXsr5chTAsbGFT+tduzJwsbtOqjqnbj0udXvqvL4SEQqD
         jrag==
X-Gm-Message-State: AAQBX9cbrSkG9ba5xkouw32l6Xry6TIRRZ5P3URsTuSyomQMFPIfnVJF
        2ND78ex7QD3GVpuzJm4qTEPWPw==
X-Google-Smtp-Source: AKy350ZUv7YTFaz4s0N/EXlxxMCy7BUAOM64h64AGRtC4n4HDyX5TtFkLWwJ/h/7j3Z5CGBCofyVkQ==
X-Received: by 2002:a05:6402:445:b0:502:3ff1:2fcc with SMTP id p5-20020a056402044500b005023ff12fccmr21340037edw.35.1680428564225;
        Sun, 02 Apr 2023 02:42:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id v14-20020a50a44e000000b004bc15a440f1sm3076440edb.78.2023.04.02.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 02:42:43 -0700 (PDT)
Message-ID: <0d7d1fcb-e914-907b-0ed5-44e104929766@linaro.org>
Date:   Sun, 2 Apr 2023 11:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 03/22] arm64: dts: qcom: sc8280xp-pmics: use pmk8350
 specifics for pon device
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-4-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401220810.3563708-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> Following the commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the
> correct PON compatible") and commit f46ef374e0dc ("arm64: dts: qcom:
> pmk8350: Specify PBS register for PON") use "qcom,pmk8350-pon" compat
> string and add RBS region to the PON device.
> 
> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")

There is no compatible qcom,pmk8350-pon documented at ccd3517faf18, so
backporting it there is incorrect. qcom,pmk8350-pon is neither in v5.19
nor in v6.0.


Best regards,
Krzysztof

