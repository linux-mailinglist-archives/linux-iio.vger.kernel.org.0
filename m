Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF036D3781
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDBLMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDBLMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 07:12:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700E6E97
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 04:12:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ew6so106601627edb.7
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680433930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEXwvHZJtZivK6tjI6uLPToL68HidfH6ai6G82DJFfA=;
        b=Td7Ztr1vB7iQAAY93j+UvqLOXDZwXY3TbF0SLTZPHJ5z9der2X1ugh38B5YCrz2xh6
         Vn0Hx2+AsUkTrt0Y8+f5aB4Dfvzo4zkHiIg6ldtnxYVptnWWlCqrWTyWvFooNF4SGaH0
         aMbH+dbKVsVZt8sSGXThYqkjD0VtvHyzLnxMov9MAQt3yuri5J9MD/WAqKuAJrRYm0vF
         hnKkHfHXub5ZHZ6YUQfT2Zwl2/nHHBC2RO+d9ycre6cFKpzvnOm4hiEoIUlALwc0crvH
         nMk58JyhpozIfBp9yfiA5UYaaGQcVLoS8JQj9lZm9Hnu25pnVYTHYDWkefj2wCXWckN8
         u7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680433930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEXwvHZJtZivK6tjI6uLPToL68HidfH6ai6G82DJFfA=;
        b=Kw+hgGedxJujUZPI8ITnh89lSUw+N9zkvfvihoAQiQVNXMiHcsuhK3d6D1497tCXJ8
         +jIc5FWVFgcI+c9mJ8J9WlQkBM6dSfCGCtiIvcOHcmNNiAXAWK/tJmJ1oMBEUqiR3Pmk
         IkwW3HfbNpH4MswcgPoLsvb+GALQPbv/nROjjSag9aFnWra+dxdxxkkvEfzIhfmryXtr
         QnL2XheImyGo/ZCRH0oBJMa46+1wQ8IZNhTO927UBfB5TPYqomxxJXQPveVyqYlrw7fT
         Z3lUbEL4Fue/GWjO3jFY57/76RCE2wtGmepP8idGtiHm8Rs50GTOXDfE21Thp8YIcBz3
         oQAQ==
X-Gm-Message-State: AAQBX9eZGHmytQW7IlJ6Eh8aTzzK5MDl/nIP4n0w5NDEii2+SD4U4FRF
        4LZqcCbZ64ut6L29QM9hIXMasA==
X-Google-Smtp-Source: AKy350YRqiH1zuh/+qfKwZj3K/cyif/y9bYtVUwvwNBu8hx86JIDxKyT3o8n92AtS/KK7L3zUE0riA==
X-Received: by 2002:a17:906:395:b0:93b:6da8:539a with SMTP id b21-20020a170906039500b0093b6da8539amr31550466eja.18.1680433930136;
        Sun, 02 Apr 2023 04:12:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id 29-20020a170906009d00b008ca52f7fbcbsm3111862ejc.1.2023.04.02.04.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 04:12:09 -0700 (PDT)
Message-ID: <34bacd09-829b-9a29-d3a7-bea107072ebb@linaro.org>
Date:   Sun, 2 Apr 2023 13:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 03/22] arm64: dts: qcom: sc8280xp-pmics: use pmk8350
 specifics for pon device
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-4-dmitry.baryshkov@linaro.org>
 <0d7d1fcb-e914-907b-0ed5-44e104929766@linaro.org>
 <CAA8EJpqqnRvJJUJn3VoFaBncMz1mgn6_q4vHp6Pv2L9V4QOdKQ@mail.gmail.com>
 <f25647d0-2526-da0d-42fb-abbe5284d22c@linaro.org>
 <07b87a68-14ee-41d8-27dd-7067fc7c8fd6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <07b87a68-14ee-41d8-27dd-7067fc7c8fd6@linaro.org>
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

On 02/04/2023 13:03, Dmitry Baryshkov wrote:
> 
>>
>>> region. I did not intend to have this patch backported (no Cc stable).
>>> If I were, I could have also added a Cc stable # 5.19.x 03fccdc76dce.
>>
>> AUTOSEL will backport it anyway, if you do not mention otherwise.
> 
> Is there a way to influence AUTOSEL to make it also pick up another commit?

Only via usual stable kernel patch rules/syntax.

Best regards,
Krzysztof

