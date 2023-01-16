Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E571266B8EB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjAPIRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 03:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjAPIRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 03:17:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA6B75C
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 00:17:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ss4so58922318ejb.11
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 00:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rvy1b9vZOFy0r6tUkARlg6oXfN9pLw8MDEUtxOSpVyE=;
        b=qskBwSLuWaqAaxIuzTNCYR9htwKOjbJSDYqxzD2kiK28aLacqvlaaqf+4IwAlft+Ni
         6QtXN8KrvyP85c7vy+1/J2FrPp/ZPLd8TuATkMfcmLObDlWTaNBhVvgotf8qVha+H2uC
         AmD5LUcWXio6v3GI401xQ/kE4ti9u+s6uIS+pRWCBNYMZvHtdAvgIuN3LwqvlKUDHxbz
         ABousjtulrErR8loLDTS9hkww8c534Fv6W4ObRDFzIBW9GojiqpP48kJhius8yeG2A5P
         3aAPTYl37PczED7PF9/iN2uCWzv1ZPkMnRm+H1SYgWtRgiMwNlwKEx1qWNrUWKwa+5Cl
         Aebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvy1b9vZOFy0r6tUkARlg6oXfN9pLw8MDEUtxOSpVyE=;
        b=6z++BtmPYmWiRzUx4sD8PfusZiDwCQWZDw8ecbQbQnuARs8vVAXXCbXVrfjd6SPPGR
         7bhRL+lhtJrk75tIk9fR+VmshtGO4Top+TdFiMZ/WyeK61OiElibsY59tIiZveIdycJ4
         pC6hCJ6reS+64sZss3MhO9cU8WAqXhyvWBCFqBQjxCbInon0TB6ZNFVI31qB5H6ygBxD
         TkArW1H9V8q2DukyAabhI2UPMwucqs2eXjN4QI3n0KUFDL0AZzY+l3d+vnP4D8ZH18/3
         2ObZFeZ9rWYVksOmleSYd5QJpqQ3x7mQO71Wer1pRBlBiqAUsV82v2zRTFY50fgSjf5I
         AQzA==
X-Gm-Message-State: AFqh2kpNj2dR5b0kuE6A7yBCe+macnGgrbpzAGOP1wnX8ThOIgdgcz8f
        ITigy2/6JRuQPqe/R9HoXiymJA==
X-Google-Smtp-Source: AMrXdXvb3vp5afmT5t9Tifmzch+2zItr67oHjMDh96EJZXvzmlYuZPnIqXI2el1Ff42yQ55uGkIsIQ==
X-Received: by 2002:a17:907:a411:b0:871:89d:75e with SMTP id sg17-20020a170907a41100b00871089d075emr2105110ejc.16.1673857032214;
        Mon, 16 Jan 2023 00:17:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b007c0e6d6bd10sm11567984ejc.132.2023.01.16.00.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:17:11 -0800 (PST)
Message-ID: <49f22127-a0ad-ca1e-9923-fe91da4cdf87@linaro.org>
Date:   Mon, 16 Jan 2023 09:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230115170623.3680647-1-hugo@hugovil.com>
 <20230115170623.3680647-3-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230115170623.3680647-3-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/01/2023 18:06, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

