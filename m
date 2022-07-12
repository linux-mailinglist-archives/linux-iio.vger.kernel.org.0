Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BC572880
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jul 2022 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiGLVXS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jul 2022 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiGLVXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 17:23:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71AD0E16
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 14:23:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u13so16050707lfn.5
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KhYX7FuYQUxi67GuZ2ixbS/AMyDFa/KK/jRr3sISomk=;
        b=PNYcPmnzi0W8n5Qtze2ZGtkUJF6xrJGoMW1UtKbz/qf4aFBw0uwxVsdjsE1FYnr+TT
         Q6zQ9r3NE0BBSn4wxEAmrmlBZXa0SgM8P2O03nMK+Ky6vybEH3e8KIWSAVmHzzM8XMhp
         jmWGiYZBMNJTb0zFfevEw8EBjvSCqH65bPomEEPe/t0BHdUSxSL2ogvtEYbIx49l9XX6
         L2AY5zchLiQBOS4t/SijMsdbd9kDZPK5lvN6g4Mc5080gAbg1Y6+rdG5m8jhXwA5M39T
         K2yus7s4Ud0SUOlKgo+QBoaAmFCgwSgRrntdIx+qzyn/4z0qo6WIN5GCC9Cee4T/ontm
         RgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhYX7FuYQUxi67GuZ2ixbS/AMyDFa/KK/jRr3sISomk=;
        b=nmCWSovFSkGe22W+jqgNrzzax4Tty/i3GZHLeo7cFHywJgQ3E4fT0gAHrB04w/d/JZ
         EC5pfv7hyKP3GfJIer0y73HWIlaWNrIlUsvv1WOsT+r4QpIEGynXv9mVH2mM9wN4Dw6d
         Q5a7+hmQLQo0WdWxv7/L8kJJ6JmdQ66Rk0wDs8gYnzT4rDQQVI/45WMUCE1wske0xAKi
         rEXwXCxA/D8cyvcxBkACSzSfdk6hWGZ9IOrehj2U8CDbF4rGmKlCeNlItzjxk2clftlX
         Q8skufUaSE3FNhqFaVUCETjVWVFpdaD1IiSG/Fq0yJg89EDqM0V4AOzhBzSGSxNWmEOE
         wg9A==
X-Gm-Message-State: AJIora8Z7gjkYiK7OFfpw546++R0GSlSJWn2hkX1q9kbQ+8AxYA59JRh
        Bm/11R5Q7u4FY7Y9uBUHOlPELg==
X-Google-Smtp-Source: AGRyM1s66esIFctUVClm4vc8Pa35fg55yA4QdNJhc8vEMh41lEP2nWRKR8ihjRFw3wJ2U/EW5Q3z0w==
X-Received: by 2002:a05:6512:1683:b0:47f:78ca:8ac5 with SMTP id bu3-20020a056512168300b0047f78ca8ac5mr16213908lfb.663.1657660991981;
        Tue, 12 Jul 2022 14:23:11 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b23-20020a056512061700b0047fac1feb6fsm2392578lfe.210.2022.07.12.14.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:23:11 -0700 (PDT)
Message-ID: <01e7b72f-a044-676c-16b0-d8ce556a1100@linaro.org>
Date:   Tue, 12 Jul 2022 23:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: stmpe: Remove node name
 requirement
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-5-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712163345.445811-5-francesco.dolcini@toradex.com>
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

On 12/07/2022 18:33, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml | 3 +--


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
