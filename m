Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C395A6651
	for <lists+linux-iio@lfdr.de>; Tue, 30 Aug 2022 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH3Obh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Aug 2022 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiH3Obg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2022 10:31:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF594A8331
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 07:31:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b26so4655304ljk.12
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pX0OlpLEvb4RPyJl58cTxMGgmyUm6YDNZgU2qeJsFjQ=;
        b=Q/3wwt+uZ9O53+zsHKzMYwQbmb2b6eJDG99iQjMan6Uw0hMFUZBcJZOlCSNG1k9aPP
         31YCofyBkD+mmM5+XWrHkFb+4bWyyQ+yMFvxQnA9qCVqwXJgrkARuYOdu33TghB1Mr4S
         GJ95bzHGLC3pWrnAQYiQ4bWUm6aqF50YYW8VpvMBZYfNYnbEN1r11LKJ0l5+KKNl+F4Y
         8Z2ET1TwKS34xlHPTUWeuR6itx3OZYW3p3YnYizNtCVF+wLZKlxOsqSsH5cpmvXrGYnG
         KEfyF94oLXSAwVd6TQ8oQrc3tZvKoenbqI/eveOy4k0lpgIHyzDkL1vEopnLhapwTZ4g
         re4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pX0OlpLEvb4RPyJl58cTxMGgmyUm6YDNZgU2qeJsFjQ=;
        b=KeSd4X/ZsTI5L2jB9wHZ0KMI4x/AqwWGj+kzXTA/R++PDe9exEIRbd+zy6ODJABhDD
         ebYDAZ9BfLPK3G9qNOxKqdRwZdsDQ9fygarkj7es5MXzSrmCD7qX+G/A60FPU/UVF5YY
         tvRfqCDOr2taxq/fpbQAY97Jgs9+kHG8pZ1MXy6ZfaELmW6qHY0RP91GwhSwr651DvZi
         v6vXwX4lE6oM+cxOr/J/hM7Tii7ZuhB/2IkMu6MbDX6i3nk8Dktg8ED58cvxeeCWLzPF
         frCpLA3Kd3qf4xqtVJmigrHrSqQXtGc8eGG6nX+f92pNY8EgeQAxk0Lg8HoYl8Bllddf
         jPbA==
X-Gm-Message-State: ACgBeo2YvEIXpK/qBityVZ1ho8HjlIw4TJObW6mJw7fLqexzh0ITtdPv
        2IiIOrAK9qanNmXyiwHk/K585g==
X-Google-Smtp-Source: AA6agR68vvQXFwNOUtVNjkp7Rvx2IDU0peYkOCAud31GCK6ryCiWT//uRQ7w48iVZUvB4ganFgT7xA==
X-Received: by 2002:a2e:a5c2:0:b0:261:d23a:2009 with SMTP id n2-20020a2ea5c2000000b00261d23a2009mr6726085ljp.303.1661869893181;
        Tue, 30 Aug 2022 07:31:33 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e5356000000b00261eb44bd16sm1814155ljd.5.2022.08.30.07.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 07:31:32 -0700 (PDT)
Message-ID: <2e55c955-1a16-307d-34de-6b598f6e31a2@linaro.org>
Date:   Tue, 30 Aug 2022 17:31:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: ti,tsc2046: add vref-supply
 property
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220830110709.2037302-1-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830110709.2037302-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/08/2022 14:07, Oleksij Rempel wrote:
> Add property for the voltage reference supply.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
