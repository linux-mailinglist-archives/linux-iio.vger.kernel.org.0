Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEC6B5BAD
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCKMaP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 07:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCKMaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 07:30:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB66512DC2E
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 04:30:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id da10so31228973edb.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678537802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjUhnHyDUJ5wg8HgLp7R2j6/UQh7qFkqjXC6cud7wFA=;
        b=NaF5Ipx6n2Sl2HxZZipEbRVnt/v/6N6IYCoCCu4OCVg0HDbVKNyh59h6wCsPqL84/Z
         lN1aKk4uVw2tADThdJierZuVSbNSkZmwQ4Fc8CcGB+xPoJACaROQCXFFAWlVa9Q88zfQ
         lv82QDWfIUpvDa+GftxlBRqJ93GQeO+RQUsMSc5i7hBHnTgcCJ3EzrvCKRHHTc4IceXP
         ViCn1Jldd51NbX2laUXcbEkeuQZHP9G1oo0KmKAFObwmozQG219jMaP0S3bBj6oJ3lHo
         wD9Bnp29yZJAj1HcDhDDtNI0VWtMxsgLPzNXS0xjHWsn3PTOnV/e72eCa3tB3qmuodMz
         HqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjUhnHyDUJ5wg8HgLp7R2j6/UQh7qFkqjXC6cud7wFA=;
        b=RR63giKTdQUWvr7x5K2rJG091SQ50zMSyMivdlFw0IeotIN1AN7vHbGUt8Mo2LYGBE
         P6ycnOturXYPnG2a6PeizAPNpBTAH0TDA1Ht9nGU38XL99PqFZG97BIQ0JArlWVGw0zu
         iMCuSPKIEZRd5ECEovVE/6vW+3GBsJKnnCaQAHUkr8cBdh07cF2qqw4uOhRU1fBo9B40
         dXgUP5FkiZg1JZiIgmOfwQXxgWZGDlwxljw+jrOu6b07s1vwj2zrSVvU19XFnDjSqwYX
         fHCJm52GXl1cJkQhTlN48++QvFURQP7oYVaSsosxcZFr4hDtyCVEqtS45pzQwoehkoXV
         DnPg==
X-Gm-Message-State: AO0yUKU5sf3XdH/yNLn0/RkdMTAkWWydIz6PR5nQmQNX5cDlw4FVcvEn
        eHW8LR5N//bcqbfa6U3Zt9rO+Q==
X-Google-Smtp-Source: AK7set/2o8ivcKMwc0mQHra9eJumNEYv6mhH+0exAy0texGLIvUhlh2ftWQaJ8F01uSG1mo/Mr5EtA==
X-Received: by 2002:a17:907:ca85:b0:922:3a53:46f8 with SMTP id ul5-20020a170907ca8500b009223a5346f8mr882715ejc.64.1678537802201;
        Sat, 11 Mar 2023 04:30:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id jg30-20020a170907971e00b0091ec885e016sm1030730ejc.54.2023.03.11.04.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:30:01 -0800 (PST)
Message-ID: <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
Date:   Sat, 11 Mar 2023 13:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related data
 as maybe unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
 <20230311122833.03b5a3d7@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311122833.03b5a3d7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/03/2023 13:28, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 12:14:57 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
>> certain data unused:
>>
>>   drivers/iio/proximity/sx9500.c:1039:34: error: ‘sx9500_of_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Krysztof
> 
> Thanks for looking at these warnings. 
> 
> Drop the protection macros instead.  The tables are trivial in size and
> the of_match_ptr() breaks some ways this driver can be used.
> ACPI_PTR() isn't as bad, but is pretty much pointless given this size of
> the array. 
> 

For ACPI platform, ACPI table is used, so nothing for PRP0001. For OF
platform, OF table is used.

What usage exactly is broken here? What ways?

Best regards,
Krzysztof

