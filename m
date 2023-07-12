Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA12751003
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jul 2023 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjGLRwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jul 2023 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGLRwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jul 2023 13:52:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC61FEB
        for <linux-iio@vger.kernel.org>; Wed, 12 Jul 2023 10:52:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso882992966b.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Jul 2023 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689184360; x=1691776360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THpXRSD84BFEVMh1tTi6CFXtfk/3GttF/ObmaoMABLI=;
        b=IpzE5GIVwvuhpr+Tz7D6OHQYx3hut1aaGtL8IiHboZVbn9LvPPJD0Ui/IwnGZCYyd5
         R3XRag9x1JuwxaSj9U3rQ1C5ghQ2CsQnwn0uxLsGeuPDT4tbYk6NSCK4WyJhB9uyGjB7
         166SpJyWXk03BFtQp76kiiiCIyHUAz3D3zhuF6CUhvBydDInIiHR4PcGMM6lZzDvLypM
         Ob0s1m1792Pg7kMnxEyQFJfLDpbXoY6Oom3X3yoj7j61XTB2AOW/m5wbsNXA9ZWUoDza
         mxxdwLXxyWi8o4HfbY7nnDuEjtm1lB6HcpMFdf0ovLyi/xphiCrG9XPq2U8JE32CeoSm
         /fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184360; x=1691776360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THpXRSD84BFEVMh1tTi6CFXtfk/3GttF/ObmaoMABLI=;
        b=TLGJjOHATwHvsFjPns4qOmr1YdRxfENp/JdJp728qGO4CRUmE7r036VYiArODVm8xq
         pt6ITH4ZvqKlTfxgeNlIXzAR5/h72Vuu9J3CbPKyU9FubkhDbj0GqrMDDkNxy/U5rwwL
         mfwH8fdzKuSmqfkkMcxlI8w/A0PmIPrv/TyiT2P1qVXi66g5eq1tK+UsUrTcYvULS1Yf
         t2ZH1XcRuzn6KNyYem9s72Qe+1m+luUe4GjMGH8JpYXQqlyMGZrGTZSsx6MeoSPpiLYs
         /ZHneYkLP7KTxJURHYZkXxKGuAlIQqplpB8kWlQhjCzx+hWXKtmsNH/ZhCR+HjChoJaS
         EWIQ==
X-Gm-Message-State: ABy/qLbQFKgjW9+0Itp2/Y7SywRkcbRqNtd4O/2TpL+w3b8dY64Kus0b
        vvhK81mnlDTABGqJmEdKVU2rXA==
X-Google-Smtp-Source: APBJJlHoK39LUke3/rD5zGAO5qmIiTsuplS6lqV24JZHne610LDYaifMCMtJiJ1PE4NRGnQ0F4gXcw==
X-Received: by 2002:a17:906:3956:b0:988:6e75:6b3d with SMTP id g22-20020a170906395600b009886e756b3dmr16439999eje.33.1689184360343;
        Wed, 12 Jul 2023 10:52:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ov4-20020a170906fc0400b00992b50fbbe9sm2877626ejb.90.2023.07.12.10.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:52:39 -0700 (PDT)
Message-ID: <66ca5498-04be-cfb3-c6fb-92481e505bc2@linaro.org>
Date:   Wed, 12 Jul 2023 19:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: proximity: Add Murata IRS-D200
Content-Language: en-US
To:     Waqar Hameed <waqar.hameed@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1689174736.git.waqar.hameed@axis.com>
 <3b9b284effa7d63c5c3c022f0d51312052bbe62c.1689174736.git.waqar.hameed@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3b9b284effa7d63c5c3c022f0d51312052bbe62c.1689174736.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/07/2023 17:12, Waqar Hameed wrote:
> Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
> for communication with interrupt support. Add devicetree bindings
> requiring the compatible string, I2C slave address (reg), power supply
> and interrupts.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

