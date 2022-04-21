Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0E509924
	for <lists+linux-iio@lfdr.de>; Thu, 21 Apr 2022 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiDUHdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Apr 2022 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385884AbiDUHdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2022 03:33:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659DDF27
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 00:30:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id el3so535066edb.11
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4pF0A6y3g7eEZylxHcXLzbj4wMSYQN60017Fp6N/wJ4=;
        b=JMAhNmOQHYzYX/QwJWpkQgFLSiq56nOVh4a29aq+NoYQUsXwQ3DexliqbOrO7nA4sQ
         mGTGnCZmhJpnjYjgcwL1BCi41ZME5KcMRgi+RSbp4YzZ+KyvW90S4/jeyJKsCr3bP3sW
         zz62u+g+rZu/wFvl6ewBK/pP2w1q4vJL62p/XBHYYMPzE5J+xyZI6dx6DQQwGavXuu6j
         Hb6TyIZs3jRYQ+5m8p8z1Q6T8NGCIJX5J56j45rSxawFtSdgk/KsLnl71RNQcDnXO1fh
         cODaJrSRCQhA1CB6c0tP9FX2VqhGlXkBLpS3VVtNjY5C6MPtp9zZEjp+T6P5VPrtCNGE
         4NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4pF0A6y3g7eEZylxHcXLzbj4wMSYQN60017Fp6N/wJ4=;
        b=IANu7YgSZ6y1g6nyzyvSylx1VLd75t9u/pqudDWRBYAhyI3Xliy2NMzz9eXpwzfL41
         Hu4q0Bss0F64vADmPt99iNJEc5999v3UFWrhtXKdCC4z7afxQ2J/smqJo/6wjXoY1Pkh
         78RUOBxETlZepXoR+C66xoF9R+znKGFbXDogoKzZoRf9etJ+WpmtvpIxjzzN7IGwWmL7
         nFgeWAvcXqPiiGZSnuHjTuzqjQ2DmKRIQnErHQELynTCH4Xf3SLIQhkeEmx2rz0W20sw
         fZ8+vxQqg+/ruRi81qTCZqsB7SjwlYuJFai/fx0UsKLfrfTitH47uYihKdRq8fB6K/KF
         /JrQ==
X-Gm-Message-State: AOAM531J2iI4x9TBubs+9uFSWyECZ98+irjqMSg6Gkl38xy2XxHgMPRP
        KXrfY9OjovTiA9w5LhKrlWSQmA==
X-Google-Smtp-Source: ABdhPJzcusGsrke4I/0OilddfYcjJsZZwM7P12uAbiAifLK+xIPkbC5vrVaQG9+4ewHYqjlGicfE4w==
X-Received: by 2002:a05:6402:3584:b0:423:e4d0:34f with SMTP id y4-20020a056402358400b00423e4d0034fmr21174160edc.72.1650526211288;
        Thu, 21 Apr 2022 00:30:11 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b006f01492689bsm611017ejb.143.2022.04.21.00.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:30:10 -0700 (PDT)
Message-ID: <d91651a1-6ca6-1412-cc22-fab39e98f4f8@linaro.org>
Date:   Thu, 21 Apr 2022 09:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: stk33xx: Add
 proximity-near-level
Content-Language: en-US
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
 <20220420112540.91907-2-arnaud.ferraris@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420112540.91907-2-arnaud.ferraris@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/04/2022 13:25, Arnaud Ferraris wrote:
> This allows exporting the value from which userspace should assert an
> object is "near".
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
