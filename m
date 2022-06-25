Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195355AC44
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiFYUCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiFYUCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 16:02:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27514095
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 13:02:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cf14so7812228edb.8
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1bmdRkXG+0/AIBMbyim+OI6ERPwZh/R6bN2wBhDiCzs=;
        b=MdzmWirl9RPLK6JbbFIvcXwtfJYvNpIxa2PhADzzCqayJohcez0VKgNKY2NFCpiK9t
         0dn3owMLneYrqlP8r/h+rQ0iW8fVcI4vpiu+1DIgyrIRC/YlCCCRtTmjlk+HWftMnr7/
         Pkui+RdRmfR6bPoJAxrdyK0+SOfwawJ8UUL677ndk+D5uguf6esNaJbF5vKpO2VBGi9l
         e6lSqtgy2+OW1dwvkk0AG5QsvxXAKbCqIoBiQ0liZEnX9yxb9S0FcqJqJOu6B4ZN/PIY
         N+nlBpFONm02H1PHkx7w43WYgm7gTlhHd/x7+HDXvKF2aIzg0hBTXdRz6uWGpxVqp/Gp
         lObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1bmdRkXG+0/AIBMbyim+OI6ERPwZh/R6bN2wBhDiCzs=;
        b=ZSHty7/wyEL9M6tytprC5jJYPec2DjODrwBS1m8JisJgpc6CG6cNs7Lz2LwPpUrtuA
         U0jXfrhprql4Q5BgiAFJkKp4b/uB3l1MDhY7dT4gptdYnZi8dorMAWAW1+LI6dxjFBhs
         0bQw67KfRg6nkPuGWq2k+ZjeK1UCAI+uaSNnPkGfSWSRrDOng/pNzKDjLlcjkCyUNE13
         tMhhZgjhT8E3bImzVaYX/n7UkApxkCqnoerUeP7nOgkwgWuQXySYvuzTfEfglhI5i48h
         o2d/Bj83WYB/DmL3Ac0CwfiVXWPet21YlLlq7Hk3uwZ4HgXsuRV0dcR2f5tn8blC2n6A
         gRHg==
X-Gm-Message-State: AJIora/Zt5MAwUasI8IzoPv8w8rbB4rFrM0pLmxw6L7aWt7sl0C8Bbk1
        Uc8/VN1mMkjYNgSqbQyTLstF0w==
X-Google-Smtp-Source: AGRyM1u5yMoMZjVAqKv8jMqvQrKeHcZlmX5jqYX6/XCwbR1gbABZgWSOxeFos0qTuvbHbYOzaq+Uug==
X-Received: by 2002:a05:6402:2047:b0:435:67e0:44fe with SMTP id bc7-20020a056402204700b0043567e044femr6825367edb.360.1656187336156;
        Sat, 25 Jun 2022 13:02:16 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906174600b00715705dd23asm2966416eje.89.2022.06.25.13.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:02:15 -0700 (PDT)
Message-ID: <d6e313ef-511b-1cfa-037c-5e6cd28d754e@linaro.org>
Date:   Sat, 25 Jun 2022 22:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: bmp085: Add BMP380
 compatible string
Content-Language: en-US
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220625150811.47292-1-ang.iglesiasg@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220625150811.47292-1-ang.iglesiasg@gmail.com>
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

On 25/06/2022 17:08, Angel Iglesias wrote:
> Add bosch,bmp380 compatible string for the new family of sensors.
> This family includes the BMP380, BMP384 and BMP388. The register map
> in this family changes substantially and introduces new features
> but core concepts and operations carryover from the previous iterations
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
