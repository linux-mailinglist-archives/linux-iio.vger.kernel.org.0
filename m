Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C35F2F57
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJCLL2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJCLL1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 07:11:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045993ECF8
        for <linux-iio@vger.kernel.org>; Mon,  3 Oct 2022 04:11:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c4so864853ljj.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Oct 2022 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3xG7Sx36uXV+Y7O3JP3f1ZhHsXXXqdBNI1ovCRM0zfk=;
        b=uc+N57yoLdKAirCZp+ceADu7xZOvpXfBZR94l3MC8z1//WP9eHd/Yz4LdJ7ttpEvcC
         AQm+jq8VFfl7CDj1jAi3ss19OHsX9Jca/KgvhaDWirSRfaaYuuQByHkXWND7Wgz8J/3Z
         Ptm4aqO9PaWNbRNXR9vCWBEVigolAhHzCCugS/FJ7KDfOIcetxUnuxtrnx9mL7ezsuS+
         LtdauiFndPeGSb8ycG1pLE9tvM/OmhkA0TLlS34rLh6zszWhVposINXQeIdTaD612UmP
         3HHfxDQYKzFzCtviJIJ+OLHjUk0lcJWesUIommH8/gboc1llKe+NOi7AZKgFvSy5fNTW
         Cy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3xG7Sx36uXV+Y7O3JP3f1ZhHsXXXqdBNI1ovCRM0zfk=;
        b=tCvtZsVXsRR2URl4AKSCYALI0mJduCoKIt0d7KU2SDReO5XLn6OIMEC7dlIN3nePix
         oUzzTWuhoCKZk2UDQGrVVsx0RAwFpn1XTcE3khjfhLkT5EX0CeoT+i0bzV2Q4W54gutZ
         2hb3JV6hMsHJEWftjOA8Pk6P7kyDgEKi7IjiFfhG1cEXcutTsPYgw2XekhsQHGBND8Gc
         ffU6wg1NM1nHc7KchPe6MtYzb3V1KcwE8KuJIBB3ht5qRZyUqLI1bKfMVWPYsP9IRB6c
         nbZr+oZG5t8BNZ7539zzrd/8vGxoKuJ4IJniGIoPVhJRys7m98LZylbCzUVD0T0TyAHc
         8hxQ==
X-Gm-Message-State: ACrzQf05rQnpiNTB4FLKJmg4X6syrS4x3rK6VkKWqR0DRYuNUGDx0BXb
        EeOkUJvPvCyCxWAW7Vj2NtOr3Q==
X-Google-Smtp-Source: AMsMyM77y2jdFDY0J3lgTPFJ9CWeZaxwLfIHsDNfDBNt5i6Npdv9dMYYfkNRQPIE+2VkJ7zqbHG//g==
X-Received: by 2002:a2e:b88f:0:b0:26c:4697:6914 with SMTP id r15-20020a2eb88f000000b0026c46976914mr6286749ljp.50.1664795483276;
        Mon, 03 Oct 2022 04:11:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512305200b0049aa20af00fsm1417760lfb.21.2022.10.03.04.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 04:11:22 -0700 (PDT)
Message-ID: <c9791863-8ee0-739a-e7aa-da33af1ebbe8@linaro.org>
Date:   Mon, 3 Oct 2022 13:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v8 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221003105903.229-1-Ibrahim.Tilki@analog.com>
 <20221003105903.229-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003105903.229-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03/10/2022 12:59, Ibrahim Tilki wrote:
> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 177 ++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Jonathan,
With merging please wait till Rob's bot tests the patch. The status can
be checked:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221003105903.229-3-Ibrahim.Tilki@analog.com/

Best regards,
Krzysztof

