Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD446EC9D4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDXKJv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDXKJu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 06:09:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68C130
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 03:09:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50847469a7fso6100745a12.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682330988; x=1684922988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S/Hx6Ffd/VFvH6pc+we5sGq0vQaDXwwsPvUCfwhSCQ=;
        b=GdGFE8gVPT4oXvzahI4YwqqGYeQaNEbiG6tFUt3BRy1jOvOMF3iqekpouyZgvWGs96
         mfoFOvW1gwZ45lApixo94NSJhSV0iyQeMgh6WKISjjSPesjno5lMZZMVyeTZK7YgnEMU
         77U6Z41ITgQ6foVgK6yBtu2PVw4gaBGdgp3s3xOcFcdNwvgntLFJo5x8xjRcl73MWEOR
         /JluAsneoNZLQjP0OT8PWS0OpOWff/0WVXE9ztVBllKlMoBSkDdabNxvcluSkL9Gh51U
         rhM95K+0kz50og8lwebIMclY7nCSAxcsxJU+P5VhCHkM4pGM9EfsxgS4ltWI7IVrUBPm
         nXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330988; x=1684922988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S/Hx6Ffd/VFvH6pc+we5sGq0vQaDXwwsPvUCfwhSCQ=;
        b=ZxNpdnDZg4gkKkXXan51d4BYeBvHs824CLN/UBD6jt3mTJl7PTejbb6LVX40pTnTI7
         ShffpOjCh2kwaHgkbRCZ6ENqnKXX6ysu7p/U2ZbPgOhOz9ru2K7cRe9c/mjhBu6VVxjl
         7qj+Oltbo/ZJyhPKVY90vQdeie0ZfpPk7R03DPJ1UfzB2evmwG0/WnfnCuZng+F3qygb
         I+oeH4ynGPHGN+idjn2hWk/T99fAB3axNU/yRjhoOBCRU9r6K/yqXFcQdJVRDSiSWOBA
         +Pxau0smn/qt9PeUlr5WbOpopL1cZQg2H6c03uuXlR+57e7XYpy1jUViCnLMp0NTEyCc
         jWMQ==
X-Gm-Message-State: AAQBX9e2TzRHThgf3aZgVG0bj4IVes6NTL9H/RzOf59iJgz5L1xP3yxI
        EJBw1nuB5rm5tVaj6NjYys3org==
X-Google-Smtp-Source: AKy350aR3XIjk0mtl5UXazT2xWmKc4YwBFWDvUHW6fqRcnedbwf3qktmQWeRAgmi2oxuiuh2cS51Zw==
X-Received: by 2002:a05:6402:31f3:b0:4fb:aa0a:5b72 with SMTP id dy19-20020a05640231f300b004fbaa0a5b72mr10873955edb.5.1682330988026;
        Mon, 24 Apr 2023 03:09:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:fcdb:bf53:d053:3a52? ([2a02:810d:15c0:828:fcdb:bf53:d053:3a52])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm4478934edv.86.2023.04.24.03.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 03:09:47 -0700 (PDT)
Message-ID: <08635f5f-5ff6-f416-ba31-215307804332@linaro.org>
Date:   Mon, 24 Apr 2023 12:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing
 vref-supply
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
References: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/04/2023 11:23, Alexander Stein wrote:
> Although this property is used right now for IIO_CHAN_INFO_SCALE,
> this ADC has two internal reference voltages, which the driver currently
> doesn't make use of.
> 
> Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

