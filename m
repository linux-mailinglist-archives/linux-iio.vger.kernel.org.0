Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26260AFDD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiJXP6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiJXP55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:57:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD489B849;
        Mon, 24 Oct 2022 07:53:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so5612385ejn.3;
        Mon, 24 Oct 2022 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSEvLyyLe+hBvaBKkfXBf/cGAr4HLvs3mPr8nOmc2qE=;
        b=Kkg+G8Qbwj17U2HvC+RSqFFPA3a2929kmtNddLJ3HNLq8j/m/OhhjVPOQBhZWtdsfa
         hJAEEHGbQrideQAYs3/YCODUgx5Cn3caRbkZSyG0S+M9nVsUXrF5mncrnE/3+/DTUkKN
         JnVUGjrfCvSzIVVM6TJf+nPoZDYwmcc//ydid47sMPC2KsomKZhmrcZCcDx12r1kU0yI
         55quplmP/5V7XKWK9bqMZoGCdd7oU96ztHJJMfRPP6Su6msnsH3HJUmvSQ54wzsOHZw4
         UguYX3lwjTCA/QWWRBtCdpen5xjG88G0zCwqbT/84/mvF6s0nPNWytywvgzJqOGLEY/E
         7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSEvLyyLe+hBvaBKkfXBf/cGAr4HLvs3mPr8nOmc2qE=;
        b=AuWbM5fyQiKJXOtRTPMxE7dkIgpd68Y6G0AiYVegGWujx9H+l9wwgSc8TjFxyVUGwP
         Pypia5O2/SC/NJGRAjkgjrqAL+jYh2QyNo2fuh2bRF7fF/u0JeD83je7H8y0Khsnnz4f
         opeCbRUZnd7mo759TlQZu61fKqOMOAC2vjqWUm2zove7m6p+Rrsm4o/LL7zFbFYgub03
         HH47tNCHRngjpTLBomdQzTAlu5ws363PPeqkj1x65zpwogOo6MRNeP4jMO2FL048Me1Z
         R8/o/OaE6FyXiz9UPl+AH8FwyxoOXIq3z+rvOmvmrjjSYgi0zv0us9lCcE0iJOZNU1lo
         dY/A==
X-Gm-Message-State: ACrzQf2yMgEQukdmhgk/j64GGtPz4vQVkYpv2OXDmNR24WHx6ACG19U1
        /7ftjIhBDfcwy0G8rfrdDdNEwqRofjI=
X-Google-Smtp-Source: AMsMyM7aHQCrNOjzSvvalhXn8dVkWbBY/o7LhXkPTgz61yoIiflR+1/F4+FrD4YMbhh8gIyz0A0FBA==
X-Received: by 2002:a05:6402:f1e:b0:461:cfd3:48c2 with SMTP id i30-20020a0564020f1e00b00461cfd348c2mr4103316eda.294.1666622240275;
        Mon, 24 Oct 2022 07:37:20 -0700 (PDT)
Received: from [192.168.0.104] (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id sd42-20020a1709076e2a00b0076ff600bf2csm15614764ejc.63.2022.10.24.07.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:37:19 -0700 (PDT)
Message-ID: <3769d202-334b-28f7-df96-a032301e1b96@gmail.com>
Date:   Mon, 24 Oct 2022 16:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 8/8] power: supply: fix wrong interpretation of
 register value
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-9-sravanhome@gmail.com>
 <CAHp75VeCGNvLhpsRvfzf8oedAhZVGuaiDQYJyahpPkvz1qQd7g@mail.gmail.com>
 <CAHp75Vd8L3vnfqahSP77b8bA-Z70w7rHOSNVgXPUXmOjBonLPg@mail.gmail.com>
 <40711ccb-ef96-4905-40ed-525c0a490fba@gmail.com>
 <CAHp75Veht22nPGyZGp4G0yGvYm4hyjZGvX4fdz4qCz7VUJcEdg@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <CAHp75Veht22nPGyZGp4G0yGvYm4hyjZGvX4fdz4qCz7VUJcEdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/10/22 16:18, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 5:07 PM saravanan sekar <sravanhome@gmail.com> wrote:
>>
>> On 24/10/22 15:50, Andy Shevchenko wrote:
>>> On Mon, Oct 24, 2022 at 4:50 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>>>>
>>>>> fix wrong interpretation of bitwise as hex
>>>
>>> Maybe you can replace 0x with 0b instead?
>>>
>>
>> Ok, I consider to changes as "fix the register value interpretation as
>> 0x instead of 0b" does it fits !!
> 
> No, it doesn't because there is no evidence of 0b in use. I suggested
> to use 0b in the code (as the part of your change) instead of
> switching to hex.
> 

Ok, I guess re-phrase of commit message shall solve the conflict. I feel 
use of 0x in code is fine.

I will edit the commit message as "fix the switch case to match the 
register values"


Thanks,
Saravanan
