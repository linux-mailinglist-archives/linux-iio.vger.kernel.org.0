Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19B76A56D6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjB1KfB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Feb 2023 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjB1Kew (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2023 05:34:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D111BDDA
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 02:34:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j2so9165379wrh.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 02:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677580490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcIFZ75GszROWVHc6fhuQ2yZDaxcPc/igDnt5Snznss=;
        b=hHB4WHESAJnekEReyf6uGCnczOr42Hhw7lkNkUk4gIPwcgTtyCSljxpqnXB2bTA7IG
         evNkmGEUZ90F7zckzsR2WzojUDk1xfUZrofd693USp+QNttzIv+uLSs9HhYywKNuWYpl
         hwJ3NuIlexGe3Ob6VZRCZeMbwSqeWb1O3uINVwcs21OkxOzaSK1vVYHiRixf3GRJ/Grb
         2dl7cgSyLIM2QJf/FUKm6pQvhwL1iVVsSBJzceJkGHgBpNWiN4CX3vcK3kRW8/dtc+ID
         GOIEROTN3LAiSg1CQzS3u9lHSe4u414Ku7earTvryzXUheZJggMurcPuCRLM/T+qXaMb
         /Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677580490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcIFZ75GszROWVHc6fhuQ2yZDaxcPc/igDnt5Snznss=;
        b=lL6q8LShdDXu1NE/ceYFMwWjQnK+nxSrxlBsyImZN3XBG6sflDV9vu2UPq/nBTOVvD
         +8khMSLaxQ1U0pY6PRlzK9L+ze9ZffMfqAlmz5lDthhtpUdKtLgRqLLgBuxV5CXXCTBo
         HQxhyS3x8A4j+m0uPaniFQeaT6YwfUbJTLcWJPpt2LSWWEvfuyggnyIMCD/5lAjazlw6
         mTMH16QCWi9bHzBNyEjX1T/k7tFdtC6a+mG6A+l8K3D6t+9W3sX2G9GbSjEUtzP3tHP0
         LN2wH1LPOjrNUt68Ex6j8tUphNLbpcXnIz3jO5hfeVA5BipZ0LN/esd+1tPLv5Bxs1JW
         4mQw==
X-Gm-Message-State: AO0yUKXxtUzcxiXGzs/004aqGRbbT/3BNkMi1LXSB/AFoV30h42LjVWJ
        1HHswI6onVt/ysbDgBOC3+qDpg==
X-Google-Smtp-Source: AK7set8XI9Z0kByAgnUP5JY/bKFJVG2SMphbFAIpM6vToy46scsdRHYBTPE65nIL2wDnEMD/x8iLBA==
X-Received: by 2002:a05:6000:190:b0:2c6:e744:cf71 with SMTP id p16-20020a056000019000b002c6e744cf71mr1551763wrx.52.1677580489791;
        Tue, 28 Feb 2023 02:34:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p8-20020adfcc88000000b002c55b0e6ef1sm9772120wrj.4.2023.02.28.02.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:34:49 -0800 (PST)
Message-ID: <2e3e0f4d-f7ee-4ce5-272e-c3be13da8c8c@linaro.org>
Date:   Tue, 28 Feb 2023 11:34:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228063151.17598-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 28/02/2023 07:31, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> "reg" property is mandatory.
> Add vdd-supply and #io-channel-cells


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

