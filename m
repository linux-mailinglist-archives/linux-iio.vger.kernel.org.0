Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481C721E75
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFEGoo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjFEGon (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 02:44:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DF1A5
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 23:44:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-97000a039b2so712266466b.2
        for <linux-iio@vger.kernel.org>; Sun, 04 Jun 2023 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685947458; x=1688539458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUGCYeOScHhssGielwBu6OShRHtxTVGNeYBVmelokvM=;
        b=Y3hi0KNyXSzEYKMvg+MDTVHjRG6F+Kktuiaj4Da85HCaJjgiUomvJmHGQvQME2xvIf
         RGSWI57KJ99Ori4rrlFP+8DBBQzFLU6rBY2g/0ZJo1hiWWrXAEzTFL7vCFAreC5iP/AG
         +6tul+68Tllyue+r4cmcuHQXJatb2LakNUYVB3NyHE07AuySQBravQOnvFjpl15kK1MW
         VoCs08vRcpJViLY0VuiOo3vdxHoIwxJl6CAhRJvsh+RvLozfGhYZNxTars9/QGWBz15B
         Q9b3QBfjegFYvJC4SnI7FXGp/hSUb5oDiURzpF6s/d7ugNqWiol5BbCGTwFWvo51eCz1
         HLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685947458; x=1688539458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUGCYeOScHhssGielwBu6OShRHtxTVGNeYBVmelokvM=;
        b=IEvoWJ9yjj5LcmGfEjOktB0hEZ8SqLAoBsb81ZXf06iSA2N4SCD9+oxLiDfsozIylP
         1+2Oge9LMV0yLXCaWbqXrY5o71ONj/3YsMgOHP8fHoOqHzf8+C3ZYK13HNiwYhkdKSmj
         qNuMEnHiJ+vLB0Om4QDFscM4c+6/NtCFRuV2G3XD3QIjyabkdO96QTxndlTZp1rv7Dcd
         sXHw8JVWP8fmu0+eQYsxTu8s0kQIKZocWEVqR+CuGHDE1NyVJKc81iPypiZlHHkDyh2L
         EFl1szM9hPAgMM6xY7j3JximM3Ab8ntXKIejk6HIPEUtR0V7Qw8D8JFXX8wTT8KcZj4F
         Z8sA==
X-Gm-Message-State: AC+VfDzGUem8KUU5ll58kd3x8bg73f92aBlybXC7YNWxNc36axcOf9X3
        d+aiJ0VCyU3Is7YEiCcyQaRRuA==
X-Google-Smtp-Source: ACHHUZ5+qQg5JWv/PBzryjhJ2KpeTQWGfg3wSLbmTG3o/Dcw24uO+D5wNXzGHUhrb/s3P273RT1zBw==
X-Received: by 2002:a17:907:728f:b0:966:4bb3:df63 with SMTP id dt15-20020a170907728f00b009664bb3df63mr5464988ejc.63.1685947457973;
        Sun, 04 Jun 2023 23:44:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906594600b009745e1b6226sm3859246ejr.125.2023.06.04.23.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:44:17 -0700 (PDT)
Message-ID: <d26d0a24-eaa5-9b32-4888-61217a24925e@linaro.org>
Date:   Mon, 5 Jun 2023 08:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Content-Language: en-US
To:     Maksim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230604185336.1943889-1-bigunclemax@gmail.com>
 <20230604185336.1943889-3-bigunclemax@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230604185336.1943889-3-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/06/2023 20:53, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 

Patch is still broken. Don't send code which does not work - does not
compile, does not pass basic usage tests.

Best regards,
Krzysztof

