Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E474C6BB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jul 2023 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGIR25 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jul 2023 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGIR25 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2023 13:28:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB93FC
        for <linux-iio@vger.kernel.org>; Sun,  9 Jul 2023 10:28:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so5429854e87.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Jul 2023 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923734; x=1691515734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dKYNbBXcnp2npYERmD6OwPGyF18Ls7/g1iPD2dIqkc=;
        b=dfvQYsS7R+9f1XZdiGS878gaVCwz8HtDNvKnKs0ASwuLeupgac1jJp7J9xH4GzjbAY
         NQh0ZJIJbNgu9ulCqAlxsRu5ytNxmmDT+J2ghMVKnTLbPvRujFaZbfUFFvuJh5UdRlLj
         1d5kXM3W/Jmyj6N0q3TJhydMquk1WYpfx7L4R5goXwCW24P4fAZ9fXPwATcnY7OQe5gE
         D28Sy29i3ySLj8RGkJNV+aSpm9IszgF4mLHoHl0IJ6zCdgdUNPA0MIIr87CSquaofV69
         OSFE6YPYLYDiBkzahm+h0QNSD1s9gKwzLgN0IH2urcw0C+zvQu46Qb/9aSwBEOqKRJ1r
         oUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923734; x=1691515734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dKYNbBXcnp2npYERmD6OwPGyF18Ls7/g1iPD2dIqkc=;
        b=GgchuG54qZHzfvJ2qvh8UqXQPRdoLEU3ouipVo6yhhXW3l3ED02K9Upt6bd6y+P1KF
         WHgKJXHTGNEnKBEQ7ve6Sh8mToaHzi2Fy7bWZbSf836wece9M5lVU+gi/dnvbc7Sai1T
         W3XU262Sl53AUL1TQDqo96O27uTDfeJldoTVU+RtWD2UofiOsAu4Q6kv/JHxMrdpAuIq
         OJqj6eG5PDt3h0MGksQdOemFsvgEn5/0jHo2/4Pm5oL9xeSGUUrtXvW/VEnooqEPwY08
         aS/goX4Zcd2PoqoN9ysgftACFUEEmBaUT5u1DcZvcofVMKhZyD009hCEh7Fw2IoVKoNo
         IBnw==
X-Gm-Message-State: ABy/qLbb3ozimBaz4jOCiZtjb6HcA5JAvFp9rQrKVGK2YNbVNk+1kAyV
        zhW5gPBADgEEqWdf1M2JYFZoKg==
X-Google-Smtp-Source: APBJJlHpqhfp6mspgLh/7s1bioqqe7qjN0nmeg08p4aZ9KLzrTcfmxw29nR5V2f5KNKf7t9FIuexLQ==
X-Received: by 2002:a05:6512:3d14:b0:4fb:8afa:4dc9 with SMTP id d20-20020a0565123d1400b004fb8afa4dc9mr9176209lfv.49.1688923733365;
        Sun, 09 Jul 2023 10:28:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n2-20020aa7c782000000b0051de3e1323dsm4641086eds.95.2023.07.09.10.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:28:52 -0700 (PDT)
Message-ID: <8b2dd686-382a-f490-7b6e-9603d939bad7@linaro.org>
Date:   Sun, 9 Jul 2023 19:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/11] dt-bindings: iio: remove QCOM ADC files from iio
 folder
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
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-12-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-12-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> Now that the ADC dt-binding paths have been updated everywhere
> to use the files copied to the 'iio/adc' folder, remove them
> from the 'iio' folder.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---

Nothing this was explained in previous patches... We should not have to
read patchset from the end to understand what is happening here. Anyway,
your commits lack rationale why this is done. Without it, this is pure
churn which breaks users. ABI breaks need to be explained in the commit
msg and come with some reason.

...

> -/* 400k pull-up3 */
> -#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
> -#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
> -#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
> -#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
> -#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
> -#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
> -#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
> -#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
> -#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
> -#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
> -
> -/* 1/3 Divider */
> -#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
> -#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
> -#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c

You just added these defines in previous patches. Don't add them to
incorrect places just to fix it second later.

Best regards,
Krzysztof

