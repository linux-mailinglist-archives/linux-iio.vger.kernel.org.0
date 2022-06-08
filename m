Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB42542E55
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jun 2022 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiFHKuZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiFHKuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 06:50:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4111E6FBF
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 03:50:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so40660537eja.8
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2022 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vm9XhdeYU7rRvslTwvUkHce0nhE9IQ9ok1tIOOnzVp0=;
        b=tjftErh4YNKJPcP5BEyJk296R2TSigz64ffMTdehQ+794p/qVh3rgyGMgXrt8fhe0x
         b1PUPN96Cxn5PbRvvtDMM5JG0rd5uI27wGcl1Fh2b0nYm+POWF/rCDnFarA1GWIg2y6v
         WstIjAqZ6MeUik55bC4h15atWIM3AE7tmBpeQ9gUyVj/eBMePcOWoOSSnjW0lHE1o8/w
         qBwQ221x8rox/TsMWLM0UbJVMavcfk2KBadVelqvdRxYsFhlZ3E9lXM8iyCn6g4xkrZi
         27OCwci1yUXHziOwIo6LEhy0YlX5ubQAfn/e+W0x1Tzo23jplro7Xgp4okYdRT5r3OJ8
         H50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vm9XhdeYU7rRvslTwvUkHce0nhE9IQ9ok1tIOOnzVp0=;
        b=lUyQVuAA/sdkBkw/+UAKfRwjKj+Z1j36cS/q/ird4m1KEoXnZ3eYWjfISldBL+X6+8
         5TQZEl7iHSUhFTCkWAQXIKLtREsA9KDi1GSLcAVI1OSIRBYVZjIV00FnFIZSB3Ox2n0b
         ufGJNWlo17jVkiglU6are1Y8qap1DHu/Jigt2CONTdk+qwMscuRUho46E2LFHK/6nwJf
         coeMfLGPVrw6BhzraEi4wam03f71pJM/5vJy4eAA+H3I3Zya3gtK1H/oM9rIgd4SQr+P
         xAwpMbmK1PkCr3GW0NkW//ddNvC0lIxd9TWVTUPPuqQW+OfMRjMWYEOcbklHpD0TIB+5
         v7ug==
X-Gm-Message-State: AOAM532TffPB33U2JIv0scfMbqcns8buH8iC5uWjfIEWJ6A5wCC1pf6E
        iOXMwsPByGqFjAIBDWdOLJW1Jg==
X-Google-Smtp-Source: ABdhPJzWUzL4o7NZrlrAIH2mz7oyYOOIbQLDjxuZ30g5twmrX8aF6udUHt0tBSrqq1P80KtyUooUaQ==
X-Received: by 2002:a17:906:7954:b0:6fe:d9af:feb0 with SMTP id l20-20020a170906795400b006fed9affeb0mr30037683ejo.361.1654685416246;
        Wed, 08 Jun 2022 03:50:16 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a9-20020a50ff09000000b0042fb3badd48sm7944900edu.9.2022.06.08.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:50:15 -0700 (PDT)
Message-ID: <505d2462-c448-ecd1-c27a-27b263e354e8@linaro.org>
Date:   Wed, 8 Jun 2022 12:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 05/17] dt-bindings: power: supply: axp20x: Add AXP192
 compatible
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-6-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607155324.118102-6-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/06/2022 17:53, Aidan MacDonald wrote:
> The AXP192's USB power supply is similar to the AXP202 but it has
> different USB current limits.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Please send a v3 with tags properly accumulated.


Best regards,
Krzysztof
