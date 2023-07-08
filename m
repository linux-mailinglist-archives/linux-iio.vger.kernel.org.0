Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F474BDE9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jul 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGHOpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jul 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjGHOpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jul 2023 10:45:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC861723
        for <linux-iio@vger.kernel.org>; Sat,  8 Jul 2023 07:45:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so4698966e87.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Jul 2023 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688827530; x=1691419530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCWNwoC2vevqpteh32b8WOBme258WwCa2vLzAXyfb24=;
        b=qPVyTW8LTPpMHYGn1WZY105+FBHqpbVs2HWQnONMcbmI/9eXTYb5f9FK9l81kaP8KF
         1VTVaKs5IcKlOmVHovzoMQ/B0E/eY9pl16p6vkVyypCpWhxpi2MioVjQJyiwmGJ9RgFO
         ESo/ipRqQgyA8e9KBf46yFfBiFAytbtY0mQweSe4k9SOW3SI/1skjX6oOsUbAEDxOE1T
         yMll/jh4cst3r7lCz3eErSN2QBIa8tcG/40y7HZyGwpnJFhjsGYKH0Tr9TxMFKOPX/jA
         ssjaTbv5zpyOuXJB4vq7uEyDKWBPELUmff7egMwy6KCjg4IIEPN9b92MqZUxXSligVwK
         VOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688827530; x=1691419530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCWNwoC2vevqpteh32b8WOBme258WwCa2vLzAXyfb24=;
        b=eAOs3K7riNrw7mqr5waMinQUzTDzRgK7MF2N2Se3PxeMlWMgAMW3AJ9aTJheg3FglJ
         iOYn1LxNyIFK0fmtQT50EUGMLarHIvWv2tJP4jJ+r9xa5O6tglOuhG5OAo8O/1Sl8ElU
         Qs+rxjksKo4g3Wg3LbISVFHNAfRG9sdO9xJdvVJMz8XqhpC2i+QJjczVGi79KiFkObcF
         iJyQzOQ5rhKXYXd29ZtIdVxsaXk9K1C6i4Hcrt4KffRppMdEX98z/ne5Ym1u2vdLM2X/
         iH5v+gIu2CJI2vL9ln1Si6RtlI2m7o2Bjy/90GGMY96uSxq+HlU8VEjgOZHsneujpcWf
         8qtw==
X-Gm-Message-State: ABy/qLZ9r841pEqhvwV+W0UsYBNSehzbSef+ve1diRvInTDb7cYZtED0
        hoTLY2asKVB8hzGleTJKg4p0OA==
X-Google-Smtp-Source: APBJJlHni0GxQlaTk5KXSBdPCs8J6B3hVlzahsgMn05+Zf518fqtVQ0deGO6RytJtJobYW8S7ku2zw==
X-Received: by 2002:a19:911a:0:b0:4fb:89e3:5ac6 with SMTP id t26-20020a19911a000000b004fb89e35ac6mr5174424lfd.62.1688827530203;
        Sat, 08 Jul 2023 07:45:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id q7-20020a19a407000000b004fb9d32719fsm1045317lfc.36.2023.07.08.07.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 07:45:29 -0700 (PDT)
Message-ID: <560ddda0-338c-533b-35c5-58483ae0cea0@linaro.org>
Date:   Sat, 8 Jul 2023 16:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627-topic-adc-v1-1-c61581abffa3@linaro.org>
 <e7c577c8-f42a-cdfa-3369-5a377f3914f1@linaro.org>
 <20230708152931.146c6944@jic23-huawei>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230708152931.146c6944@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
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

On 8.07.2023 16:29, Jonathan Cameron wrote:
> On Tue, 27 Jun 2023 03:08:20 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> On 27/06/2023 02:21, Konrad Dybcio wrote:
>>> Even though it existed in bindings for the longest time,
>>> ADC5_GPIO2_100K_PU was never assigned in the driver. Do so.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>   
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
> I was a little unsure on this one. So far I've applied it as a 'feature'
> so it's in the normal iio togreg branch, but perhaps it should be a fix?
I suppose it's a feature as it's never been used before

Konrad
> 
> For now applied to the togreg branch of iio.git but given I'll be rebasing
> that on rc1, for now it's only visible as testing.  0-day can play with that
> in the meantime and see if it can find any issues
> 
> Jonathan
> 
> 
