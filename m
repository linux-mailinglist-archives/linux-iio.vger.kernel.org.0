Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FB557C7CF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiGUJi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiGUJi0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 05:38:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2628148E
        for <linux-iio@vger.kernel.org>; Thu, 21 Jul 2022 02:38:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp17so1888788lfb.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Jul 2022 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YmYiOt6Nv5ZShrwpGsxlicdF6A0q2fMH3BROdAu98XU=;
        b=ITBAh6AAPNMMGQ2ian/1MtBVlvRt23lvzrW7QWZr7g4p31vS2aU0XjiWx8tXFyb/lq
         20Sn7hiadI8+pKppU1wPuOkKyjC5uiezq7ML2t/9voHEgggwE9j2U60dM+jhXvapZwme
         EJf0oEfVQv3o7BR3Y9luzW/q5hhwu7fQOtfaZx3m6kgSGI17/hMUyvZc6vMAC6Up0z5Y
         JFiVxhl7OkbLvhSgak4kbQio2SUdKF0EHOJUIHKC7A0vh/dB1wkrF3fVj8mKVgTdv4sA
         Y0gfXWpkTCpWWwHbJLZciIIp2EECi5QqasLQ1R7QQLua546qCinvEyp0JXZk/ObqFCA/
         cOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YmYiOt6Nv5ZShrwpGsxlicdF6A0q2fMH3BROdAu98XU=;
        b=qf9/1dQJpZ57avNajnUPhJqexU8Xujsh41Z03TBbFJ4lIgBBC6Oz897t5WSecxLpiI
         DfPxzi1WTaJVUEFkYkM1u5BqzGfJasNxvW2ZvQoIRxUiWDMPhDCn0i+tVbpTw8tShfos
         ilCQRVSEqbM/q+VXF6lnQvFahhVFbNLfngaAVVhA/BxjXLgX+3n09qBdJq+KGzMsPkwG
         Yy3A6/lLbMmZZNGaOaWS+vr/OmnCiNGu/HWOOP0cRfGG5wlecjVsYvko5lIlKGNKlhcF
         1V5aw5GwlmzKK8MyCL9zwRZWO96Mv5a2agV+N+d7ROjxrJZFJ+TdOD2KmGO0URjoTonu
         6Pzg==
X-Gm-Message-State: AJIora8laQpAXvtqQrGQThnLNu2oLYtYUgIcjIeINQiOqMgJUJX6pNm/
        vOG2CAeZeb+QKbg1diFgBckSgQ==
X-Google-Smtp-Source: AGRyM1sKmuNhBDSkQFMFKQ09TrJStP/MVw/Gdz3jMAC+u4WLwYlwbOIU/r1tPttQhJc1W7PkDdRblQ==
X-Received: by 2002:a05:6512:3ba1:b0:48a:231a:205b with SMTP id g33-20020a0565123ba100b0048a231a205bmr16522721lfv.74.1658396302850;
        Thu, 21 Jul 2022 02:38:22 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id bf39-20020a2eaa27000000b0025d75b27fb7sm381737ljb.27.2022.07.21.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:38:21 -0700 (PDT)
Message-ID: <72e30e5f-bc65-5176-2e60-f94f71a710d3@linaro.org>
Date:   Thu, 21 Jul 2022 11:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] dt-bindings: iio: adc: use spi-peripheral-props.yaml
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <20220715095302.214276-1-krzysztof.kozlowski@linaro.org>
 <20220716192604.21a1d835@jic23-huawei>
 <20220718220012.GA3625497-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718220012.GA3625497-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/07/2022 00:00, Rob Herring wrote:
> On Sat, Jul 16, 2022 at 07:26:04PM +0100, Jonathan Cameron wrote:
>> On Fri, 15 Jul 2022 11:53:02 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> Instead of listing directly properties typical for SPI peripherals,
>>> reference the spi-peripheral-props.yaml schema.  This allows using all
>>> properties typical for SPI-connected devices, even these which device
>>> bindings author did not tried yet.
>>>
>>> Remove the spi-* properties which now come via spi-peripheral-props.yaml
>>> schema, except for the cases when device schema adds some constraints
>>> like maximum frequency.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> This is an RFC with only some files changed, as I am still not sure of
>>> benefits for typical case - device node has just spi-max-frequency and
>>> nothing more.  I still find useful to reference the schema, but maybe I
>>> am missing something?
>>>
>>> Before doing wide-tree cleanup like this, I would be happy to receive
>>> some feedback whether this makes sense.
>>
>> Hi Krzysztof,
>>
>> This has the side effect of allowing spi-cpol / spi-cpha for devices
>> where they weren't previously allowed by the binding.  A typical device
>> only supports a subset of combinations of those.
>>
>> I'm not clear whether these should always be allowed (e.g. allow for inverters
>> etc in the path) or whether we should be enforcing the "correct"
>> settings for devices assuming they are directly connected.
>>
>> Currently we have a bunch of bindings that are documenting the allowed
>> flexibility - including cases where only particular combinations of these
>> settings are allowed.
>>
>> So we could either:
>> 1) Note that we've been doing it wrong and the binding should not enforce
>>    these constraints so remove them.
> 
> I'd lean towards this.
> 
>> 2) Add explicit spi-cpol: false statements etc the drivers where they
>>    are not allowed.
> 
> 3) Drop spi-cpol / spi-cpha from spi-peripheral-props.yaml. It's purpose 
> is to collect all possible SPI controller properties that are per child 
> node. Whereas we've said spi-cpol / spi-cpha are device specific 
> properties.

Thanks Rob and Jonathan. I can go with (3).

Best regards,
Krzysztof
