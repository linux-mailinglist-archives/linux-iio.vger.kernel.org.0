Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B960AEFD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiJXPZw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiJXPZ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:25:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945AC588B;
        Mon, 24 Oct 2022 07:10:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i21so10643884edj.10;
        Mon, 24 Oct 2022 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvDfUqBBoJwjlhc3LTQhEDbv7nOdzHTpwwahn4z7YPM=;
        b=qQNIQkeNybSbEFdYwv9QInKQ2tjDNh1z0OZIeJ8AKEtvpZ60hrNqraDdvdFb96Epi0
         IhmbqP/ZNYq6HjuAGOFMiGad4Q8G05/wKeKfEkHkj9e+MigJt8IwZiDA4z0vexIjZXzx
         VqFGhfSjHx4Gb2Ul3yf7gHlbgO9JBxw86LMLyQICPtgRGqaiUZz7pwUEFNx+3nz3Jo5g
         oRJp5Pjq48vq0BKrggtATqQvl39brNIgBLQ6LaV26fH2WqtScvLPBnPtTsIphpdpGaIr
         O+Fgq0bJf/2lB8KojD8puEaIARcgtZQre2/QCm/kEY0AMo6ZKnYtLaycy7ApmCwVLP+A
         uoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvDfUqBBoJwjlhc3LTQhEDbv7nOdzHTpwwahn4z7YPM=;
        b=v6YCje9EtcigFbG6SLj7HS4E7KcOEzIt9aSdNuTHwBxc5MGyuRdi/OSvlNjwfnkFvh
         ZmNguU3ADxTzL0xC/louNhg/JPft7AMoeLUcdRBuqY3WhoClANez9FUdpzmz4oTqziiA
         t/9hRmfYCST7RrIgGRu45fP6odweXzeILmOEavlZo3OplYTczpqUHFtCC8h7Edy4wVTe
         piUdPycVPMXo/9mvtIS58+3lYYWaGuQfqRfYEEryMteIsLYELNCk7OOYCnWhOj8nn5WE
         J69zAS1FXHlfZOdC4uGiTwb7/eJrbMx4K1tGmSzVkNNRbrm06gS6J9vHzhAIsUVSkIrd
         clMg==
X-Gm-Message-State: ACrzQf3b4Z/43kNf8rp+fF+LjNqNg3CkYyANARtJu7mZ/4JKqKqtiqKG
        nh8GgJiU9GjJSqb3RwjpdYE=
X-Google-Smtp-Source: AMsMyM6+RgBK/xW8+LjlIXzdLBr6rM/1hS60OWG3DGZkGpn5iEkMfQzzBfp68dcoorpPtZ+tWloEJA==
X-Received: by 2002:a17:907:96a0:b0:78d:dd45:a6d4 with SMTP id hd32-20020a17090796a000b0078ddd45a6d4mr28063728ejc.643.1666620451719;
        Mon, 24 Oct 2022 07:07:31 -0700 (PDT)
Received: from [192.168.0.104] (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id ky8-20020a170907778800b007a4e02e32ffsm2438993ejc.60.2022.10.24.07.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:07:31 -0700 (PDT)
Message-ID: <40711ccb-ef96-4905-40ed-525c0a490fba@gmail.com>
Date:   Mon, 24 Oct 2022 16:07:30 +0200
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
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <CAHp75Vd8L3vnfqahSP77b8bA-Z70w7rHOSNVgXPUXmOjBonLPg@mail.gmail.com>
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

On 24/10/22 15:50, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 4:50 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>>
>>> fix wrong interpretation of bitwise as hex
> 
> Maybe you can replace 0x with 0b instead?
> 

Ok, I consider to changes as "fix the register value interpretation as 
0x instead of 0b" does it fits !!

Thanks,
Saravanan
