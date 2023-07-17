Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB60756719
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGQPDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGQPDx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 11:03:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744110D8
        for <linux-iio@vger.kernel.org>; Mon, 17 Jul 2023 08:03:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e39784a85so1225333266b.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jul 2023 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689606230; x=1692198230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNlo5/33/tpWc1nTgCDW2ls2atNjwv805YtlYaQFXjo=;
        b=VXezRXvSnKUxNRQ0ERFIRqEgpDl+EHXDVjexM2a0pco4kXf8YfBxV/tk5Fo17SEtDf
         301Ogg2vNw6VplnRW129zAOItXLVU9lEvj7TnLhcSTbrVBK0qLnM6XqvwCDR+WTLwXy0
         iyvb3UKKqJ72/aTPV88mCb/bmchgVv0bKxyxadhJnaLQDWP4pi6esvgQx2MISHTD5h8L
         OHt6XuD2qBFpHrBeat+Az6NEy6LsVDvFZN/ImyAO4e46wrJHhDMsNoK24j/kedc74BWa
         Nw7XlySGuRVecm3cQ5AGx4m3R/FmrdqLZ274WxPtVJLWj/cA5Y99kqbrOA+VLLo0bE0s
         TQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606230; x=1692198230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNlo5/33/tpWc1nTgCDW2ls2atNjwv805YtlYaQFXjo=;
        b=V3Ky+KiTedMXapahBvTfQISrI4FifNbDxdYsrOQKiL5MFUsmYrBm/vXYGhy6Av7si2
         RxH+dq3PLGC/e/CDuURwx959DBzL4xD21RWM8PcEB2NtGGdLyVckx1UguiViaI78bXSp
         nx7p5kl9s4+DP+YSXtSpscpyT0olqC+mwz26RCTHtgLmZjD02A0xEMgQXcIge6IVlstg
         HRFm+PT9IT1j5XQDOOzte+xOwr1C79maj3FLIlJTzLR4qwLC7ZtNpzVoQIrT6jemuzen
         TWXNn93/U0qJmow12vgzUfMnAJuZatbuEskeLyH3W26dY973yV6XO0J4OqdcS7pR5Ow9
         1UuQ==
X-Gm-Message-State: ABy/qLY/NBF4vEYNfaUF6UqrjIMrs6+tptseShLu9zP3C8VY4r5bM2tm
        qdV6twTm6V6C7AIDz1hu3V4O0g==
X-Google-Smtp-Source: APBJJlF2LFfqZfynhkiDANmAZnKCzb44yFLtS+pg/hhhaIWi9RhWHrHNOlRXCOSkx9WloG5ntVSX2w==
X-Received: by 2002:a17:906:7a5b:b0:98e:370c:be69 with SMTP id i27-20020a1709067a5b00b0098e370cbe69mr11384967ejo.6.1689606230575;
        Mon, 17 Jul 2023 08:03:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b00987e2f84768sm9273168ejp.0.2023.07.17.08.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:03:49 -0700 (PDT)
Message-ID: <55177316-c3f9-5566-e2d2-202913fca8f2@linaro.org>
Date:   Mon, 17 Jul 2023 17:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_0/2=5d_add_mcp4728_I2C_DAC_driver?=
 =?UTF-8?B?4oCL?=
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0414e2e4-a17d-3435-e9e7-35b110233a6d@gmail.com>
 <46bccbca-1343-aed4-4dfe-eb5182b8f6a1@linaro.org>
 <72df284b-66dd-2deb-13c2-cc0c9f4105cb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <72df284b-66dd-2deb-13c2-cc0c9f4105cb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/07/2023 14:23, Andrea Collamati wrote:
> On 7/17/23 09:17, Krzysztof Kozlowski wrote:
>>>> Shouldn't this binding be just merged with existing mcp4725? Are you
>>>> sure it's not similar device, IOW, are you sure you do not have vref supply?
>>>>
>>> Unfortunately they are not that similar. MCP4728 has two vref choices:
>>>
>>> - Use Vdd (power supply) as Vref
>>>
>>> - User Internal 2.048 V Vref source.
>> Exactly the same as existing mcp4726, so what is the problem?
> 
> MCP4726 has 2 separate pins, VDD and VREF that can be both used as external Vref depending on configuration.
> 
> MCP4728 has only one external vref pin, VDD pin. The other vref source is internal and fixed to 2.048V.
> 
> Furthermore MCP4728  has four independent channels. For each channels it's possible to choose whether
> 
> using VDD (External VRef) or 2.048V (Internal Vref).

Indeed, so new binding makes sense.

Best regards,
Krzysztof

