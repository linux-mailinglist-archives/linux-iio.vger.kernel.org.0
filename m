Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAD6E69A3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Apr 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjDRQfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Apr 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjDRQfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 12:35:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9EB75F
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 09:35:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fw30so21991197ejc.5
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681835717; x=1684427717;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqklLL1/d8Vp5tYKo0ZG5zd2TLFgTYIUWIOvR0v621A=;
        b=zMCO8QAb00BwxuqKZOdexZbO4o2VgDdaMdmcYIy7S3IZi6XQpoBMuZ/5mthOoy5vwx
         C+JpSANMQLNtC2xNNHljZVxPEj9NVxwWXBP40CLzlUUtcB6LKpm/66nTfzTKGTIgxkwH
         CcJYnJ35TVLf8SWGYaM0cbY8ZgI7bbi1HAAnPRqMsFy6hAbLDVSNjhOHsGCy9is4ISlb
         HfsJEx/wHH6g5O/jv30gWWsZJyf+r0sC1Rutsdc6Yv1hSylUekMGP8ZEoOXZ4ebbo4aW
         BSNk9S6LKM8RrfbpoGI0jRb09LELrJzi4eORtsOGNfDsNRHe59e36ujnQo6gLh4wZuQf
         R3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835717; x=1684427717;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqklLL1/d8Vp5tYKo0ZG5zd2TLFgTYIUWIOvR0v621A=;
        b=hV5oSh2dNUKzmzjwuQcEqJk/UrBlP+QIMt5XT2NwHh2DyNAgkarQFbKe3y2YjMKO24
         zBhkZtTKwNl4ibXxJ+wicPQ8bHQkkP5ezL/pjptu4+sNe7KwK7C0khJMKrLFhcdPqYwK
         JEccTTOVF5uLHSt0IJos2WAI0jo5USjx4Jc5COqkTbId0tM5M/s3cV4OriH07Gwkm8WQ
         zPv70CmAlpH4W2XzGqIL9MiQ9dhUPg87CPa2Z3exNnGbhdTVuWjbhhf1yLqc5GDM9icy
         aeDCp0GuZNMMMQ0+kpgBXeaZNVKq8QcD+yaLcWCye2HjWiOaFek6hRG/ldXtYBPxOBZE
         JQ8A==
X-Gm-Message-State: AAQBX9fTYPZMtrvFwnEayogTYK6otrnvfsmEuyjz0bmzPFTlAn6XkEDG
        KKOKwNYNnI+sRl8aW/5bV9RKvg==
X-Google-Smtp-Source: AKy350aZ4vDf25kOEHBmpxkhlb1Dx2g1MoTdgqLpnICCmomELF1kDA0FHFFTa7oKFkPIiYVUTo+DpQ==
X-Received: by 2002:a17:907:3f08:b0:94f:9f76:c74f with SMTP id hq8-20020a1709073f0800b0094f9f76c74fmr5561973ejc.52.1681835716901;
        Tue, 18 Apr 2023 09:35:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id fy1-20020a170906b7c100b0094e4b8816e0sm8175969ejb.217.2023.04.18.09.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:35:16 -0700 (PDT)
Message-ID: <83ac1bd0-13c4-1c4b-9d1b-7205c34122ad@linaro.org>
Date:   Tue, 18 Apr 2023 18:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] iio: light: Add support for TI OPT4001 light sensor
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
 <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
 <72d5b078-da9e-ccbb-1557-9cacaea68e8d@linaro.org>
In-Reply-To: <72d5b078-da9e-ccbb-1557-9cacaea68e8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/04/2023 18:34, Krzysztof Kozlowski wrote:
> On 04/04/2023 11:07, Stefan Windfeldt-Prytz wrote:
>> This driver uses the continuous mode of the chip and integration
>> time can be configured through sysfs.
>> The constants for calculating lux value differs between packaging
>> so it uses different compatible string for the two versions
>> "ti,opt4001-picostar" and "ti,opt4001-sot-5x3" since the device id
>> is the same.
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +	indio_dev->channels = opt4001_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->name = chip->client->name;
>> +
>> +	of_id = of_match_device(of_match_ptr(opt4001_of_match), &client->dev);
> 
> ? Drop of_match_ptr

Ah, this is old patch... so maybe you already did this.

Best regards,
Krzysztof

