Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F662FF58
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 22:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKRV0k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Nov 2022 16:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKRV0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 16:26:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63699A2885
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 13:26:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e13so8878976edj.7
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn19h91kD2DXtHLVTlmvX/z0+yNPKmW/7RO5Bbqf1MM=;
        b=FuGELQ46WHyMDr8mQpKAZjqb0l82MxhqlvgSAv6Po5f7yjBMJaIL42l7phMLc8R6Na
         SXmeZ6W6eSL7rQWunnHHmsZc/f9i/K0L5D28oi4xLPvx52ehylKA2MKq167XiG43QjjT
         k398LCs8w+zDm6A2gm+6GsyZoOnbm80rRM7MQxjN2tdNNYLLd/eQhXQTJXT8mInHxDdo
         zx4oPW+Ifl/+gVJD0MgQZ4YuiT3Lwzq/2z95lhiTVCHFivhzbYTn6kMen8x6aAqJu10a
         zeGnF4dOe2IfU3F0lRQONNWBK4Vxpf1eKGBUUQJdXVJBNiQtLW6v+GNYYePo5N9FToS0
         UtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gn19h91kD2DXtHLVTlmvX/z0+yNPKmW/7RO5Bbqf1MM=;
        b=QCOdYo17p8RgZUfhBV/T/IP4aAIzBhcdQVw/0XxdzBn9bRLzfjmohiKoW6FEsRHsu4
         tymleHQEzbSPZx7twS2W6Hzux1titImw0LCz/XbW1jzngT3PInmu6GOVYrTNDkLWKKiv
         2M9Oniezaeuq6dLdpOqEhLH/FiF41vv0pa7hgsakS5AN58RnMM7iZ6AGqOWV51r3h3+q
         077skkeKVwxgoNF31LwfgA2HlRMmCp2j5Ar5xeMwu3joEexBqglsoOjd06wIWE/wfDzr
         f0GGdQrX4ddJuVNAUvl4H+XzjrcRFKG3nExP/WCGvC3M8w1BNW5IosHAbpt1ue7mJfXV
         r5Yw==
X-Gm-Message-State: ANoB5pnnViTDwl/icyZTJYCEBov20hq2TQSEKiky+ms1NYEzVAmFPS+A
        B3C44Kc45A7qa/c8r4BKzsybU+V5tLRerBjufsyGPw==
X-Google-Smtp-Source: AA0mqf7/jfSfmCMp1R3z90KPsI7aEquK2Hg1zTkkjjR73PB27eXwJMYj8xkB+a9dyVksrMBxxq9IE8bZY63uCH8TSOA=
X-Received: by 2002:a05:6402:c0b:b0:463:a83c:e0af with SMTP id
 co11-20020a0564020c0b00b00463a83ce0afmr7463177edb.158.1668806793738; Fri, 18
 Nov 2022 13:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20221117080916.411766-1-cosmin.tanislav@analog.com> <20221117080916.411766-3-cosmin.tanislav@analog.com>
In-Reply-To: <20221117080916.411766-3-cosmin.tanislav@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Nov 2022 22:26:21 +0100
Message-ID: <CACRpkdbRPugRA+zbad8=v0jaUDCOYA4KWdsRxyFn_iWmiyJQFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: addac: add AD74115 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 17, 2022 at 9:09 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
>
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
>
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
>
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
>
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

(...)
> +config AD74115
> +       tristate "Analog Devices AD74115H driver"
> +       depends on GPIOLIB && SPI

I think you can technically just select GPIOLIB making it easier
for users, but that's up to you and definitely fine like this too.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
