Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CB374D0F3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jul 2023 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGJJEE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jul 2023 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGJJDs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2023 05:03:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CC213B
        for <linux-iio@vger.kernel.org>; Mon, 10 Jul 2023 02:03:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso65943271fa.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Jul 2023 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688979789; x=1691571789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RuekSu7wC/jPu8JGjcF1Z9EmasDz7G1x3xuJrWyM4A=;
        b=KNF9Lg4QB/M9+So7U0sfmfSUOZM90nZ3q0+KH6XRzwf0b4EqiIRTMuulPeNMvuxMMU
         lcTMwpzM5jL7T49KeZZuSDA+GipXKsaFJT9Futb9OGUIkFj3wHfMEYIxUGyx/er49eBN
         N0Ypn+9G6fBYv7GZTxJV3+cY+KTd4dejNxuARJJZktg8GIpBau+/s+MIVpZc7M3YpjhI
         UKVrnNxAQ1DcrxxCf6A4tOxxTxLPqVMNdMd4ADn1EX26BXJj+f+fjg1Jq7b6yI6pTA3w
         D3WJP0bjw5oTuvUUHKl+KTYLsDXBHw/rk62t9PUybGA+2e55TePwMTAp1tf59O6lzX2O
         IwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979789; x=1691571789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RuekSu7wC/jPu8JGjcF1Z9EmasDz7G1x3xuJrWyM4A=;
        b=RZ0NxklD06Wz1V+75AsYPsP+kXzDKdv8l4HMBT8k/rDfvg5TR7GxQ3lwbEjffF0px6
         9Ql784ndHLqJ10ALQ+i12GMp7Yf+n3EJvtrc7XRW1wGSvSTsNdd8LuW1gVGJujT746xe
         aGgKffZBsw9nU5COgRRQu4wvUPjWePOCP6IuZ42jf8HowV6gj2VnTF59ABshWaLeTRd2
         7wHUKql3W9QmnNnQmdNCc2JqFYBtUWoQDu+hdtCH8kx6z1RIWvFfG/8N4SZWki1SUHCp
         0EwsbZSBfJi+p5WZv7uJSozRCXcsYgo5dMSCO+954duFsMcSAb+TeDfece1Pp7BXOcun
         dsiQ==
X-Gm-Message-State: ABy/qLZFBKJ/fkZH/Fl1f3YYe19l5vF/taX4Up1CZjV0q3W0FiSICnC7
        fOxjZth+1KFdxyS1s/RiguVBcw==
X-Google-Smtp-Source: APBJJlHPVtn5DsMgtevykyum989mjTFv/fGGZk1ijUiB8lhyL75IbLB/3ZO7nmvb221Rx+Gm708gMA==
X-Received: by 2002:a2e:3109:0:b0:2b6:de52:357 with SMTP id x9-20020a2e3109000000b002b6de520357mr8634071ljx.40.1688979788987;
        Mon, 10 Jul 2023 02:03:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709065f9700b00992d70cc8acsm5805487eju.112.2023.07.10.02.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:03:05 -0700 (PDT)
Message-ID: <e8700bea-73d5-8ca2-9517-737c13ad3679@linaro.org>
Date:   Mon, 10 Jul 2023 11:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: adc: qcom,spmi-adc7: use
 predefined channel ids
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
 <20230707123027.1510723-2-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230707123027.1510723-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/07/2023 14:30, Dmitry Baryshkov wrote:
> Each of qcom,spmi-adc7-pm*.h headers define a set of ADC channels that
> can be used for monitoring on thie particular chip. Switch them to use
> channel IDs defined in the dt-bindings/iio/qcom,spmi-vadc.h header
> instead of specifying the numeric IDs.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

