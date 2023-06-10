Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC66672AD4C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jun 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFJQbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jun 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFJQbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jun 2023 12:31:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74883595
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 09:31:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so5013490a12.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686414660; x=1689006660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uk7ZRHzY6ZnIa35oiewUZ6JqsNNCpQsJIRIF2DGyVuo=;
        b=uzTJnk3hMjLXnmgHH535kCPcL222DsQlFUOg03NCBayB4Er0ztzmLa44+UUTpuDEgh
         4ognjT4NCy477Lpo0y0CVKrBIOf7j7MPpec6oJsDCSuPIbjxKhhrxWrqaRhHj2fAT6sy
         UA8JXM4RS/pFNU/ROOGugSfIkvQhHUAkQLMSGbNNZ+9vPA/re3BtBWquJ5EsrrDh0rZe
         kMDulhkr4TsqQTh7GG94zE7a/DmOn8KZwQ6Gy3xXrGbmMefdIT47FRXE7z9z+pmUUzoz
         VEIJg+bBrSl0ztpfvNtVXXDIqIeTLUvIBbmzlw24MK1gJe6ZI3pvu7iP7lxHE4EjDwwP
         cCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686414660; x=1689006660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk7ZRHzY6ZnIa35oiewUZ6JqsNNCpQsJIRIF2DGyVuo=;
        b=YnVvtyz02jup5k87iaDb9T5D7DbE5vtjbV7Q5+38fifFaoOXWLMCn1I6zzNCu1x77d
         5ApGvThqL9l5WLCmyxIZ7WLE9RKg4Ks0MJJ2wkXdFWNywxLDvRKwwKyF0sOVQLmPZPZK
         /+VGBwNxa8ec9Xamdqe8nU11DmzJdzwCdunSw3OIWFHn1Q3TCL5ywAIIpY1WpMjtnnIe
         Aw8U5QwdnoOAzZc5lSw2eX51ro8A7qWEn42TIHn4hryIryLCyQuuAN1vfwH5dgv2RnUQ
         is6Y3uhk3XgDQF97z0DkJv2wE4ohkFVg8Cwrrt8/duvoLqd8+YHQmarz9nORKHDAyEtL
         6stg==
X-Gm-Message-State: AC+VfDzpH6jZsJXTHtQN+rRvUHgYP5jmuV5Ojgk664xDaVzLq7Yvyimy
        GOoMB6uo+R9hUh4kRaBisuJB5Q==
X-Google-Smtp-Source: ACHHUZ7vxhVCpy6NFkysiYwdjutN6KRNJcaFd3rV7LzVNTq5r9IFA4bPPfG281Asltu8fcnoNTkcMA==
X-Received: by 2002:aa7:cd95:0:b0:514:a0a7:7e7f with SMTP id x21-20020aa7cd95000000b00514a0a77e7fmr1618079edv.2.1686414660144;
        Sat, 10 Jun 2023 09:31:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7d494000000b00514a3c04646sm3017914edr.73.2023.06.10.09.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:30:59 -0700 (PDT)
Message-ID: <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
Date:   Sat, 10 Jun 2023 18:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610143601.173307-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/06/2023 16:36, Shreeya Patel wrote:
> rk3588-saradc isn't compatible with the rk3399-saradc variant,
> hence, fix the following dtbs_check warning for 'oneOf' condition
> failure.
> 

Are you sure it isn't compatible? According to your driver it is and
this change is not enough.

Best regards,
Krzysztof

