Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F662787FA9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 08:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbjHYGQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 02:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbjHYGQD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 02:16:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE019A0
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 23:16:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50079d148aeso806295e87.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692944159; x=1693548959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iM8El1KJDRMivN5v0+AcTBC/Luw+Aw9QD61213DG9Tw=;
        b=HKIWiSgCf7clZB0dX0JAxEOoikVQyJ6WmsGXPGfiBYeMpdBxWTX+FwO3L3asRkWkrX
         1qErpVNAHb+oAqYsWQ1zF1kiJ2dVfOraIpQqEkJVFJ3aHM8Qap37rLVfUf3Y/vOBKb6q
         b00IT5dkHrmi1j5p+YS8BKcax4ZdYO9CEMrob3D3AaLHc0NomBef7FWZx9czrdt/ADyi
         tHm8i2RvvQmLNpbRVENojA3/307Z5OqKBdmWovTfnzxjgiVhyo7KKKqcPglQbn9STgye
         JiMfFRn0eGN4fmznF91bDApthclKVYJurfE5mA4ZR/qnp5ePDXVx132ZmqCPtYRrVAkx
         v1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944159; x=1693548959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM8El1KJDRMivN5v0+AcTBC/Luw+Aw9QD61213DG9Tw=;
        b=C1+0W7pjj8Ex4MQjW24cMuqmjhDZD7EkSTFVsSN5Ac9bjgUk08FzBfoT27GJ0Y+GPe
         pf6j0O0JxpdEQvfbKUPzEORRTbb9wWh0nC2GI7XZO7kcbbllQfGCimlaAKtCpkN16fAy
         u5mYJ8x1jXGCdPrsdheqnPPBhBwpuSUgM4MXjfNmtu4vqAnJ8N+kDZxd8lOCUBHCMy4o
         iKVBPfmwg0sDIVeXg46r0qsxqxQZZTmnJqCLwambEWHjchh9j5mAS7Sf9o+T5NizJnEv
         CCpF0Thb1rgNKTtaor5f6jr8DMzfall4oN0yW5D/OcuCa8xAV5xQv8lIHPXjAPjxZkfu
         2DOQ==
X-Gm-Message-State: AOJu0YxqESh18+G4CQeGYJRmOlPYGg6Mk/JAkR5ApKKEOs04NGPNu36M
        zu04D49P8Jb1zFKH23q83NjZtQ==
X-Google-Smtp-Source: AGHT+IEG9YFvwBfJPh6Y4mk9Ujr63j9OKLTrCL6u4jSYhGphoBNbE1PIDQSsGBZ4FSaaNzcJUBKaJw==
X-Received: by 2002:a05:6512:1590:b0:4ff:ae42:19e2 with SMTP id bp16-20020a056512159000b004ffae4219e2mr1092193lfb.58.1692944158849;
        Thu, 24 Aug 2023 23:15:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709064a5400b00992b50fbbe9sm577072ejv.90.2023.08.24.23.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:15:58 -0700 (PDT)
Message-ID: <fecb8658-ed3a-1c5c-70bb-5238b09d4e76@linaro.org>
Date:   Fri, 25 Aug 2023 08:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: add lltc,ltc2309 bindings
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
 <e54273c7-4728-7577-f053-b15307d3a083@linaro.org>
 <20230824185054.GA3659959@shaak>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824185054.GA3659959@shaak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/08/2023 20:50, Liam Beguin wrote:
> On Thu, Aug 24, 2023 at 07:56:29PM +0200, Krzysztof Kozlowski wrote:
>> On 24/08/2023 18:55, Liam Beguin wrote:
>>> Add devicetree bindings for the Linear Technology LTC2309 ADC driver.
>>>
>>> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>
>> Wrong license. Run checkpatch before sending patches.
>>
> 
> Sorry about that, I ran it through checkpatch but it didn't flag
> anything.

No, you didn't, because checkpatch flags it easily:

WARNING: DT binding documents should be licensed (GPL-2.0-only OR
BSD-2-Clause)
#21: FILE: Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml:1:
+# SPDX-License-Identifier: GPL-2.0

total: 0 errors, 2 warnings, 52 lines checked


Best regards,
Krzysztof

