Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FE74C6B4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jul 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGIR0o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jul 2023 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGIR0n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2023 13:26:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA2E58
        for <linux-iio@vger.kernel.org>; Sun,  9 Jul 2023 10:26:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso463186a12.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Jul 2023 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923587; x=1691515587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N13e8qHoPdUNItDm39HEWkePArYa3KUVlo9kWPFhjdI=;
        b=ksEz3NhhIOXsjzRNA8hzCKSBYkchsF5hx0eS8CUctujx7WgiowTHsUCRGfgRGDAhlH
         AjFrN8APA4vbXnKN9ib/Vf84OpBfKemrOFb/04ns2iBO5hURwUE/cM6TDAPIn5eOPby0
         JpubXN3x5+9pkV9RMFZmjnLcOhLqPGUg5DaqgyrTBUexZ1+8TKDcSKfLtV8I5USOYyw6
         l5JWhP5TTBhh4Byh30UVQWS8AIdn3B390RIrnmzsvHGJXnX6O02Ovk+/Jr7InBGGGkLL
         eI3b29rMNNzl312xOPCBOWlfMwByVYnWyPBTzOynb0NBzvR5sPbR9UP1hS488RPNlTl7
         76Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923587; x=1691515587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N13e8qHoPdUNItDm39HEWkePArYa3KUVlo9kWPFhjdI=;
        b=WyAsr8VFJsCj3CdvX6KqDeQdwGfeOO03aD2HkJ/hElvP384tcg91OWBzUIyQ+g7yYq
         bQBV84XtNzA4bzBTk37g6bI9lfdsfVLOv6njdwK4xgcLz8PZoFEqEvwmqa1oPbXkocZe
         yCPeit7/BwBn8yj704VphnfjOozppHlc9hK0mzOEJS/csDYJoTJtbTfDHFKbdnuvxmdF
         ieSxR1F5pAM0YFc5ihiDTlkq6gm6wTCu8ZkBWuVYmECrJ0tfxQ5FMEOSukfZERJT1bf3
         OZjB62pUC9pDK3qCVoWEHIP8CPuOZ6oF1m8X9mVm1WWIOPHiTLR5p9TKGKm4+BICk3kP
         UKbA==
X-Gm-Message-State: ABy/qLaafvXqzGPMsPtt1+UD+fBA2DnGdGxuFikuWKG6a0b4APfIQTNS
        Mjao800qeHu38dqoTIuECcv47A==
X-Google-Smtp-Source: APBJJlEEjNntLhWspHz5vAUrXDvzwdtVSmuZ9eGCEUn0U8UWLFf6pBnyXESFk9mZcOYOlnnxlLuUWw==
X-Received: by 2002:a05:6402:150b:b0:51e:4e77:3347 with SMTP id f11-20020a056402150b00b0051e4e773347mr3965222edw.41.1688923587050;
        Sun, 09 Jul 2023 10:26:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7c90e000000b0051e1a4454b2sm4680110edt.67.2023.07.09.10.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:26:26 -0700 (PDT)
Message-ID: <39775b1d-5967-7401-6415-da6244546a6a@linaro.org>
Date:   Sun, 9 Jul 2023 19:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/11] ARM: dts: qcom: Update devicetree for QCOM ADC
 bindings path change
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-11-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-11-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> Update ADC dt-bindings file paths in QCOM devicetree files to
> match the dt-bindings change moving the files from 'iio' to
> 'iio/adc' folder.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pm6125.dtsi                       | 2 +-

Also (I am repeating myself):

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

