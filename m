Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AE5A986D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Sep 2022 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiIANXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Sep 2022 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiIANXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2022 09:23:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5BDF43
        for <linux-iio@vger.kernel.org>; Thu,  1 Sep 2022 06:23:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s15so12733777ljp.5
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2022 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=e3HK9US0WO1UkRfGxEbaELQy+bTEUcDkkmiL6uVF2yg=;
        b=apABlBOmkqX/8VxFa8RkHKfD/jGKjSInOUQVO3GA0XBauhwsYuN4Bjqpuec1v6lpRb
         tmnSA/mqI8roMEX7RNg61TfDRIOQf+VZAu6fENRP956E0uEngle5V9ERnLhP9JrKdcFk
         MlaJy5hLI0ypXk+/Ylq9OWaoJq6tyMmBg+lKBTJ+cC4Uzc0QYi50pZGHWsa/J7SPoZBg
         UADNq4Fud3V+i0ww/Fablu1SjqrOKLVk0T9pW8E/yWLUckWI8lwgn3WggDQClYcFFK3s
         qr6b0J53BAtT1V1kxttnBFBt/rQTFUDMw3CedEdHju1hPiHvhSNmRbZWR/dhOjKuLX7B
         ClfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e3HK9US0WO1UkRfGxEbaELQy+bTEUcDkkmiL6uVF2yg=;
        b=0BkFPe05m3Vhs90e0lMNvC3jUheliNVZpea5p3iXvTYIIaMOWlRM0IcRfaeuR87Zvv
         ND3ADnCszyd8E1npPaZRaI5CcuJFGcZjaVLV0zsZFOaGJLGmTnrPijGRsg243S5FtVSu
         2JWbLshxppMWKHoj+RK4iugFQ99vJFxIdr1BId0I5Vppg8dIDy76PVcqu00CaFU5/HaH
         yf8MG2KPRMyM40t9zOcz2giAT6JcO55VLnPIoG4OI8Kl6TYo/cgVRC0TKJm9D34inIYZ
         Fq5eXTGjwKdUI06HEB42Vur0pqDV5CqGwfIggIQ71DDAUsdjOTTB4ONYJMWjWQJ0fe+b
         ttpw==
X-Gm-Message-State: ACgBeo0ph1TSWJNXCQMrD+VLx98zibn3UFi673LqzWu6jz8JZJ7emlcw
        B0Vf9hknrigjxXJZiWyxnZrl+A==
X-Google-Smtp-Source: AA6agR7RakjpXXLRts3xpbaQ0B20blEAd9rZH7OjtbuH7lX4ugJbC/fqnSFfEH8mhHN7r/QF7MNJZg==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr9742725ljp.442.1662038591495;
        Thu, 01 Sep 2022 06:23:11 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e8445000000b0025e4dcc48b1sm2499804ljh.19.2022.09.01.06.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:23:10 -0700 (PDT)
Message-ID: <4067432b-b5a6-f3eb-a707-5fa298ba846b@linaro.org>
Date:   Thu, 1 Sep 2022 16:23:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
 <20220901121700.1325733-4-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901121700.1325733-4-ciprian.regus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01/09/2022 15:16, Ciprian Regus wrote:
> The LTC2499 is a 16-channel (eight differential), 24-bit,
> ADC with Easy Drive technology and a 2-wire, I2C interface.
> 
> Implement support for the LTC2499 ADC by extending the LTC2497
> driver. A new chip_info struct is added to differentiate between
> chip types and resolutions when reading data from the device.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf

Missing blank line. Use standard Git tools for handling your patches or
be sure you produce the same result when using some custom process.

> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

(...)

> +};
> +
>  static const struct i2c_device_id ltc2497_id[] = {
> -	{ "ltc2497", 0 },
> +	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
> +	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },

So they are the same, aren't they?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
>  
>  static const struct of_device_id ltc2497_of_match[] = {
> -	{ .compatible = "lltc,ltc2497", },
> +	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
> +	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },

I think this should be split into two patches for easier review - one
working on driver data for existing variant and second for adding new
variant 2499.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltc2497_of_match);
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index d0b42dd6b8ad..95f6a5f4d4a6 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -4,9 +4,20 @@
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
>  
> +enum ltc2497_chip_type {
> +	TYPE_LTC2496,

Why having here 2496 and not using it?

> +	TYPE_LTC2497,
> +	TYPE_LTC2499,
> +};
> +
Krzysztof
