Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1567369DEA5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Feb 2023 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjBULVq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Feb 2023 06:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjBULVp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2023 06:21:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72725B93
        for <linux-iio@vger.kernel.org>; Tue, 21 Feb 2023 03:21:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy6so10243307edb.5
        for <linux-iio@vger.kernel.org>; Tue, 21 Feb 2023 03:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noPfk2rwggu5huHwxUZGbX0TMsiwuKiTUBy+RT3Rz6A=;
        b=VjwbRKomHCvZ+MGkMFoewEedUzOPYXvN33MUH6rIekqig3OIk5pldz7zYkvM3WAJ/P
         YiboPDeHhZAB8qHxSbRTBTTYKnQ1uN93W9irCZd8kqz6U0/lRj9nv3gUCDBtrJu2TK9e
         ibwGkMgLncMHLSECuhb3pphBpOLh0SQpVOhVOq/N26mlCRE9cPjTTpeUeTN70r5NPse9
         zrHTjuERSsvAO3EkDJ+uv19wHIbOHkzI1gyg2MmJTVoEvyQbYbwNkfD81ntHsurvm8D+
         zjg6vlKc1jt2Yf0zuALyNeAIAOGrcNJyvg/+vvqkYzyLS1RtgEHcIUuLyvclY8E9g5D7
         JzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noPfk2rwggu5huHwxUZGbX0TMsiwuKiTUBy+RT3Rz6A=;
        b=sWNl1mwRDEhqUpbpW0X+umszhk3f2IgyNvppCWK8VXSgWUYBa0GhypJpKAKiCBhlZJ
         1TOet87KojnmMOV3LDS6QykyuDepAviUEAbrL08J8La4AQ9a69JTCSvFbJ2Vfrr+eaF3
         cYQHQHsSDpVxf0jdlkpqpSQSEkRDX/zljV382EhQF2tWo8CYIl9HOrLv0BDi7hmxTS5+
         EYnfbukxAIdFlZyz3lkXushd2yKDGpJZf0vYU/OjiaPxjnK4WsbfZCjDb1YDzVvHdiY2
         nbpRYnhT7YWbJvZRxLxiO0rvWhxvryAQSP38JbHEKXYO9i6NRyOKn3H7vEhk5QcU29QA
         9kyw==
X-Gm-Message-State: AO0yUKVrlKJUhvkct19Z6gBfRMUK1fTYi1dbwwO5VPhjpQ1w/JY4YMgf
        Oqd5eGhtG1Le93pNlgImDVAfJw==
X-Google-Smtp-Source: AK7set8oGKpHrhMVaiMqtVr6pgui92clofdHwPEnsWLKK2LoqZzlKa3a/asNJAkYU4RPkazVhdmRZw==
X-Received: by 2002:a17:906:40d4:b0:8b1:781d:f9a8 with SMTP id a20-20020a17090640d400b008b1781df9a8mr14558837ejk.72.1676978502265;
        Tue, 21 Feb 2023 03:21:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l27-20020a50d6db000000b004aab36ad060sm2230688edj.92.2023.02.21.03.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:21:41 -0800 (PST)
Message-ID: <cc9f67c2-1728-4299-4d59-d662c9abe8cc@linaro.org>
Date:   Tue, 21 Feb 2023 12:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 4/5] dt-bindings: mfd: max77541: Add ADI
 MAX77541/MAX77540
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-5-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221103926.49597-5-okan.sahin@analog.com>
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

On 21/02/2023 11:39, Okan Sahin wrote:
> Add ADI MAX77541/MAX77540 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

