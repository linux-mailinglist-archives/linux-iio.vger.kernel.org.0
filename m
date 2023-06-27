Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2090773EF93
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jun 2023 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjF0AI0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jun 2023 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF0AIZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jun 2023 20:08:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB82E3
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2023 17:08:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5401556e87.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2023 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687824502; x=1690416502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUDk6lpQO4D+lgSHC77eFwv9Vy/Pegzp1sgSsnp9oK0=;
        b=f+Su9d7Hpedc2UzK0RZkyNTQBgyXbMbi8fisIqreldLGMax5DzH/S/iepoXQQJuGBY
         Dj8rVoZ339Dce3SnqeY8MpcBU2wlaRXQc7N1rEjtjME3ruaQ/GbjpI+wFe36ap7eKi0A
         l1niWEgBAt+n6vCEVeOcz5AH/b26VkWfp52VKIIc6FikhpQbn5FKMl7wsHYM03JzUFkj
         zkC0S2NbsEe/fWo8kjVn0bH8TBbt6LVG5Ao9woHlVXF0+hgC0rbqLAIj9Nn5Jn+9pNnB
         GQsghVxmsCT/ldzXdEgEfc4XQB1bYliScPfYvnd/thjEzyy6xC8ehXikHYeVsSpfdfXZ
         1R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687824502; x=1690416502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUDk6lpQO4D+lgSHC77eFwv9Vy/Pegzp1sgSsnp9oK0=;
        b=V3DOFYA2hhpC7oyYm8DSYDjerVRZJ/JNGkhAJz6r5w3PJgf8x8P11GtTZKE46rchi1
         eagAQaXxl1MaXSKA5/2wE+2JiRRP3kkcS4Fum4msx5PZeForSgEvlVGYoPEirTl4v2dH
         TlLflVao0P6aMxaYlvYO1aEu1HEpkspz20F+d+G5w9I/sQIpR4W1VB+/TbPGY1ijt/M2
         EYn+FO49Hk6JkthtMTNQtRSE1ZCBkdHZGNh1Ytc/VhPGAAAo/r6TUkzyaqaDoGe/r3Qo
         +yuHbrRGtO6elwRG+7LKJ7MgbiDpbrPBodznwwCSH3BIuRT1bZjbkZH9w7M5kxaqRWaf
         XjEQ==
X-Gm-Message-State: AC+VfDwLRjk7+OpIitet4elHIzX/VfbxYF4y2QEPfDrc9mEdNP3ugZkT
        5xNS7acKx0UAqnT+yh0hv3a3qw==
X-Google-Smtp-Source: ACHHUZ7z4NEHlcGmXI64eNVgNgFtpHutyjAz+SSbRa1145TwcmQyjPbWDbgt3pH7sTGeBG+HFKH6uA==
X-Received: by 2002:a19:9151:0:b0:4f8:6b82:56c4 with SMTP id y17-20020a199151000000b004f86b8256c4mr14064306lfj.33.1687824502205;
        Mon, 26 Jun 2023 17:08:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m3-20020ac24ac3000000b004fb737737f9sm846593lfp.106.2023.06.26.17.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 17:08:21 -0700 (PDT)
Message-ID: <e7c577c8-f42a-cdfa-3369-5a377f3914f1@linaro.org>
Date:   Tue, 27 Jun 2023 03:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627-topic-adc-v1-1-c61581abffa3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230627-topic-adc-v1-1-c61581abffa3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27/06/2023 02:21, Konrad Dybcio wrote:
> Even though it existed in bindings for the longest time,
> ADC5_GPIO2_100K_PU was never assigned in the driver. Do so.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

