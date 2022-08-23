Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9813659E5FE
	for <lists+linux-iio@lfdr.de>; Tue, 23 Aug 2022 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiHWP3D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Aug 2022 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbiHWP2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2022 11:28:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977B883FF
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2022 04:10:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z20so13180151ljq.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2022 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MrLxb4E2DjxfMfHqX0aKpuYkCzfN45dEHvfq2u/Glfc=;
        b=oMu9LroE0RFKYUnrnUWRhbLqwE9SXGBkir2MBGkEE7vrSFbD1xoFjCFMdpG2eTJQq8
         GpWfKMT1LLuh0BLCNuyWdS35eZ+BbWTHta3HmqkrPOXvdth/lE7EhwIL7TL1dieNQI5u
         OhlZY3yoAKcJCmjiRKB7vWei+EB5dlzhS6au8bsxgqgLHKO2XnM1/ioP15HhbEQJlz93
         M5ZW7Fmu47MTlftRuoeWk2DqzbXvaatLwOl/NyauE9Gcv5TbFw0SBa7vOcLs3sS2rVEn
         Uuo0Zuy8gQUg7RiiWjfryxeinpc5E+uyw4sOGHaZgKTHRyCpEzE6jT5ep29j867EkRVJ
         bCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MrLxb4E2DjxfMfHqX0aKpuYkCzfN45dEHvfq2u/Glfc=;
        b=m3KY/hu8dUruIUsqMzWQDhIIXR595/bPYvIKEm5o2xB6VgCksY+vqjut+2tLTYus/l
         rYgmQUoiYls+88LUP29erbPcdA/ZyXl+w2jw21djh1ms9XH7Ar150y7Tc1qMw3decK2h
         t+T6A0DmLESYXrz2BfRAHVizgKVJgguE65oKw4xb7VOP6o4TTrZUkTzL0t0LyCYbGFJy
         7SUwD3UTvZ2wEXA4RGqD1zPkdYWBnnvjMVMveaH4WgGSaGtwsDfe0hR273eCLmOMFI/3
         9T+vu4EIkmraUuAOflNJmXnhQhVbzHZSwhHUMcDsLsjAZk0pmBgY54tl0hmJu5IBAz43
         JERA==
X-Gm-Message-State: ACgBeo1qlDmqH9a1PvJTylu29a3CSiq8fDF6mO+4JTiEzQqq/sFyact0
        4pJErg5q9fUB2WOaAkM8e7kTnDsfgyob0kLn
X-Google-Smtp-Source: AA6agR5tvu9knEhQdwzyYF2Q1oGh+SSN0iH2VVVvmeqNz9MLv8SEOAHKU+FHbuM9D26qpMR1MObYRw==
X-Received: by 2002:a2e:505d:0:b0:261:ce76:52b7 with SMTP id v29-20020a2e505d000000b00261ce7652b7mr2327656ljd.286.1661252943789;
        Tue, 23 Aug 2022 04:09:03 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a056512210900b0048b1d92991asm2375015lfr.303.2022.08.23.04.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:09:03 -0700 (PDT)
Message-ID: <2c14cc93-ae8d-365d-ac58-2e615d359fd7@linaro.org>
Date:   Tue, 23 Aug 2022 14:09:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-4-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822125106.1106798-4-ciprian.regus@analog.com>
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

On 22/08/2022 15:51, Ciprian Regus wrote:

(...)

>  
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index f4d939cfd48b..0e86e38248ee 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -12,6 +12,7 @@ enum chip_type {
>  
>  struct chip_info {
>  	u32 resolution;
> +	char *name;

const char *


Best regards,
Krzysztof
