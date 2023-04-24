Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860546ECFD9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDXOAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjDXOAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 10:00:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594071FD7
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 07:00:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso648441766b.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682344834; x=1684936834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIElVtGN3c/ynVHzdh1I2clFX36ynQbh6Tll5aYPkeE=;
        b=zJ1U/MVRctyOwOwMy9OqqW2zMUczaKrVKe9utnbWR7QJjZtH3u+/gvVuRUolehnjLF
         gBMd5Jdt3+ongI7lRIhCUgseuZqvbxyeBDPbaY3Zo8ggs4VsUE4ey2QLlPuupg163/c9
         FnOffUAetL4TyEOY5Ru1zlZEAB1nE6Fbe+NKebsoxxsmo1Sd/1DeZMvjRsprbG2T7tfZ
         l3OMgomDHYogoDW9kC4EpQcxhuSA5b7QMcxfNlkfXEqlPowF4/TYuZffqGH9yZuxv2d4
         m8JhsHwqlxMj3ib05QnBpme43EMaNCQ1G5+llUDWOOOBFXf71nWmhlDkBcubmrWM8F0x
         u0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344834; x=1684936834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIElVtGN3c/ynVHzdh1I2clFX36ynQbh6Tll5aYPkeE=;
        b=VCpe8UUpX0AFAI1CBbyxoYPneHpno2RGxhfADY0/TYUzLTlxuHd4fdLZmLJy+Jpr9/
         HPZUq76yremaFN19BN8fRfeYkTI33lw86NF1iLA63pilSAr+LvFHPAUk0eYlHY9h+8v2
         l5BBRDTfYw1wh76BPBxf4DzAjupWceBv+KVz2POkWkDuIJR/LBeKzuZUk8cNqBPpo1tO
         iwT6LDWQDe1P6oMFJXY2o0w6R9/H0pnLJveB48Y04RunKmCDoYkQeqKWSNC46YMeLvea
         AW9Pz3mj/arELU+2AxZ+xWpfJdUT9MDn5fXlM5tFayVgQJVBCqdLi6Qu1LCJrxC6eKuC
         mKPQ==
X-Gm-Message-State: AAQBX9dwKY2naivV16DfXYmaCQzkkffmADlnij4xIgytIv+rMZ2KwbEI
        Ka5P3yAOLBJp/MAx9mFe6vDfag==
X-Google-Smtp-Source: AKy350asdmE57IyyTMft3iHfA4i4ZGlT9Z5daHkGYFIDzkG9zm1gN1PTz2ChZ86nx5XZBZfs3CM8gQ==
X-Received: by 2002:a17:907:c002:b0:932:ac6c:7ef9 with SMTP id ss2-20020a170907c00200b00932ac6c7ef9mr9800374ejc.22.1682344833882;
        Mon, 24 Apr 2023 07:00:33 -0700 (PDT)
Received: from [10.105.146.163] ([88.128.92.195])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090694d500b0094efe88a037sm5536838ejy.9.2023.04.24.07.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:00:33 -0700 (PDT)
Message-ID: <7f5eb9e5-6d27-a0e9-cfa3-8c07e9b519ea@linaro.org>
Date:   Mon, 24 Apr 2023 16:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: light: ROHM BU27008
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <c05272fdd607c45d352008f9d01fc44b9b8f50cc.1682340947.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c05272fdd607c45d352008f9d01fc44b9b8f50cc.1682340947.git.mazziesaccount@gmail.com>
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

On 24/04/2023 15:07, Matti Vaittinen wrote:
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add BU27008 dt-bindings.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

