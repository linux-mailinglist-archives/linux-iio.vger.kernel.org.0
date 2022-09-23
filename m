Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6475E76D4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiIWJYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiIWJYQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 05:24:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98730E10BD
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 02:24:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x29so13983011ljq.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8sl1ujRTUl11fto0Ranm/tI+97TTYIAhGCwPSMFjBPA=;
        b=ZmEoXITQANAMGtqR91k1N7e/qM09bOZ9VUmbOJlmxoe+wA90YrN7DHPuk9pKGvpSLz
         xVyVY8rDgCNF4lOF70B+xypS4s7g5dhX+x54O5gy4n+rSN/V2QhRsGhHl/g/VNcnYRY6
         hqfp/v0KjYxaRphFyh8LBs0DbdbMzF982rBw1L5Yd6AWdwn12ub7APMiLwna9FPPqT5T
         F58b/se2mImF2x5vYBQSz5BrkaaFXH20uMIge/H5VwKCMwuGvcvz9Uz9ZzFxBYK8v5aZ
         UO4tOOdqKsIX9MEkra1vW9KosdEXSgKIbulthiqEK1fP3CuvU/jsvhwgOwvgHhhQUZ1N
         TznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8sl1ujRTUl11fto0Ranm/tI+97TTYIAhGCwPSMFjBPA=;
        b=mRnZFS+/LwENF4EMWyGxrqaIX9VGwwsMY+4sENZ4O35sPUU8jarE8836JZTcJjikPS
         BZp0JMm7cn48bi41vRWLcJBLJb17gzBcydfAQfXPsVUuMraIkKFYcmXgnDM4Se378vnH
         Kv0pXs8ph3FRIHeUOowSeaJMPMxOWme1FOAaxR8XfWPzIHnC26RaaVym97pwMYqgNz+W
         pS/6RfJ0vz5zzU8y5qYtB2gLTPfZV1IMynkGF2ICz+hRmFhHDhHUTgL56yxddhyyjkem
         C9vocdBVo6Z3V/4bd6VtOs3NfRaxVTJMWgPu4OepjRm1f/IXkm6ZQXjHEk3mVV59tNQA
         sn0w==
X-Gm-Message-State: ACrzQf2q6Fw2+bTbl9ON5Iz5HX1cVw3HGNHUgn1xWhytdqxqiM6hEBeC
        Msoeu4u9AxNoEoO7muAYdVTamw==
X-Google-Smtp-Source: AMsMyM65tpnYo0kY2Z5LJkbV/ckJdFgr1A0vjEOnLqPHceegmPhm+LwV4t9iV3qr8H8ZzzsIrZDrFQ==
X-Received: by 2002:a05:651c:1789:b0:26c:7480:f6f8 with SMTP id bn9-20020a05651c178900b0026c7480f6f8mr1866963ljb.374.1663925052895;
        Fri, 23 Sep 2022 02:24:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512368200b00494a603953dsm1362860lfs.89.2022.09.23.02.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:24:12 -0700 (PDT)
Message-ID: <2de38167-976b-6996-7929-a41a842991a2@linaro.org>
Date:   Fri, 23 Sep 2022 11:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
 <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org>
 <CAHp75VcEGb3kS03QG0ebOJYH1X_D5EbBjL6iNWUxQ5j=aCu29A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHp75VcEGb3kS03QG0ebOJYH1X_D5EbBjL6iNWUxQ5j=aCu29A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/09/2022 23:07, Andy Shevchenko wrote:
> On Thu, Sep 22, 2022 at 11:00 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 22/09/2022 21:46, Marcus Folkesson wrote:
> 
> ...
> 
>> No need to cc-us. Use scripts/get_maintainers.pl.
> 
> While I understand your point it's much easier to Cc all related
> people for all patches in the series, given the fact that many (code)
> maintainers ask for that (Cc'ing them all patches). So I prefer to be
> on the contributor side for the sake of ease of contribution.

Then please explain me how I am related to this patchset (it's one
patch, BTW, not a patchset)...

Best regards,
Krzysztof

