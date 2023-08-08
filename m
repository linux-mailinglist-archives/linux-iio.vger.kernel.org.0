Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3826773FB1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjHHQvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHHQuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:50:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC605B86
        for <linux-iio@vger.kernel.org>; Tue,  8 Aug 2023 08:57:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so9654092e87.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Aug 2023 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510228; x=1692115028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL57MaBdPM6++P437QDJfGupULs2TDGGdbQMca9U3hM=;
        b=HKWdi8rZHU1c0mtkvBhkFjoY9ntJeC8p/iTzmD2glmSkZoR4WM+0xHVpo9kVw80rrA
         xvUyLH3fJ8uA1F4S25xNxMw0GRAFzLWzjjwi6CldcqVo3sf0VguAqmNeCR6WsJGMw1UN
         /m/bSh313j7qo2TXyn2OIsslAHZTJFYwPYVRKjunpvldpZ1mhaskb5kYFWnabWr6Vu55
         hBXIFdlw/VUb90c93jwjg5njGhATDmPKXiWKiplxT1t78WqH2SGg/rsEfLzM0O6XzFfs
         AAMcg0ZefS8w7y9Ct8YfbQv5x0IhPZiOXJxg1COFu9cWm4i01ZN+guhVmVWvHCiQxlBs
         yLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510228; x=1692115028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL57MaBdPM6++P437QDJfGupULs2TDGGdbQMca9U3hM=;
        b=Dc6jjZfqgaYB4ov7YIafcdqBocVkK8v+QetOIbhM8NEsg9Nzcyt3NYUKliQhAeqXgT
         gVon0SsFsn9stncFnvTMTsEAI7ZpVlZBNhgGY7QDnrn/cvJVsdtLUkHTPg0XalFkO1Gp
         lBdiGkI2HefGK9XUP/k42ahKlFfxPBxz7Cza2oqQgdtGie9lOjJAAMFQ4tM5HCYZhCkd
         AmtLObbuuh9jfmx5wFRNVthTJUtPSzL3tAv7YAsmgphBCyIRBXiASpN9nUKDCT/+q68T
         u85l97wjx+0TjcoT2TCNWHAhYQqmKrvJBMrFosvQ4CLMBCTebjaP14KNWgmKQ8EnXOKN
         oiGA==
X-Gm-Message-State: AOJu0YwP4t5LVHGmySYNAZCgzBfx286OGJ/Dflnixu/jJlNYlANATJzW
        Xnc3TZzyC4qu9aLYSKKGZGKeo4VZ/tvwzSugOF0=
X-Google-Smtp-Source: AGHT+IFluzaGKTZK8dhiGf/jIxAe/vY+rM3Cg47RyOvynYVtONEW1n8zg4Kg7M1SwOUHcoCqsotjVw==
X-Received: by 2002:a17:906:10cc:b0:99c:c50f:7fb4 with SMTP id v12-20020a17090610cc00b0099cc50f7fb4mr5853025ejv.1.1691480985744;
        Tue, 08 Aug 2023 00:49:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id os14-20020a170906af6e00b0098963eb0c3dsm6235990ejb.26.2023.08.08.00.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:49:45 -0700 (PDT)
Message-ID: <74abc9e0-ba9a-d7ec-4f1c-815f8e351701@linaro.org>
Date:   Tue, 8 Aug 2023 09:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
 <ZNETcVNsEmvK0KKH@smile.fi.intel.com> <ZNHtMBG4yHpgL1kj@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZNHtMBG4yHpgL1kj@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/08/2023 09:22, Marcus Folkesson wrote:

>>
>> ...
>>
>>> -	ret = mcp3911_config(adc);
>>> +	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);
>>
>> Why not spi->dev? Ditto for other uses like this.
> 
> After all, I think it is better to stick sith adc->spi-dev to be
> consistent with the rest of the probe function. Change to spi->dev
> should probably be a seperate patch.
> Do you agree?
> 

You can first simplify the usages and then add new family support
already using spi->dev.

Best regards,
Krzysztof

