Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A756685F03
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 06:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBAFgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 00:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAFgX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 00:36:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B853B21
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 21:36:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so32166380ejc.2
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 21:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5WiMWuLjyJ5cBkDt4MevPkS97IYqAPPrd7ehKirxaE=;
        b=KIFFXRu0h6/dRlXDJLJ0Ai+K+WidvteFQhK/SqR+hemfnGnJwbRS29kz+RUzkh3Sn4
         M28VIP/t23L6EEm/ercKHAEy4nA/JbNHdfffh5pQtXb7GLBs1GPLa7oqalAMpf+bKxGm
         f95jnMbttGg8uvffuyNNaGlHd4mnIffgZoKYgAO37jbH55kherrlVuzPUE8BvxrzLCed
         PdykZuTvOxCMEXKTti8TmyAe4SU5sjVnH6XljuTG6BeTqa5wlXWbj5TxB8L64LsxPAyj
         eT1DGC8da9ko8CMlLJuhlTjP5UIN4IvqStb5e9tmbOOJ+e5DbWSxskWe7aooAPFTi14b
         a7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5WiMWuLjyJ5cBkDt4MevPkS97IYqAPPrd7ehKirxaE=;
        b=TJDmpQTfLdpUkN1eSCv9KaON7C7uF5d3uuHMaNHYYNJcaH0VE9kLAEC1ml05L1EN6k
         gZIWz9Y0anPZZ0neKaJsMcgzz6B80wLbDY5oMdCj5iFAIdRlb5vmw/E1E8TEWH9WhM2U
         Qt7evcDfs51v6ZR0jJ4Pd2NsP4Ch44nPuNLdIHKCWsADndtswRmPdgNd4r/J8gmL/bhR
         1/shRquCtj51pyxiPDbMv6HJdpi1y6fRsRZL8SCPwrDE8y/d1IKAjjmfb81bsh/cD2rX
         c67J3qU+4dLrHwjV6Q1F/T27rp6BivUAdQASTOOcankZ9nC9VGi/h09xI0tldDwUqsFm
         Yq7A==
X-Gm-Message-State: AO0yUKWbUKt+oZ4b8HPQXXF2Nz7tlUPN7e1ptXzg8ezuAq9PFnZ6ymBD
        XQOeMerVb1mEADIozKDvZD3NDe8ZHqA=
X-Google-Smtp-Source: AK7set8FbVpatkxpY7UsHIRW1Wc8HPBZltn3c5aKZSPB1CTVgPUg2CFBk/n2tayR6rO+DCRfA8LM7A==
X-Received: by 2002:a17:907:6d89:b0:878:52cd:9006 with SMTP id sb9-20020a1709076d8900b0087852cd9006mr407413ejc.69.1675229780772;
        Tue, 31 Jan 2023 21:36:20 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id lb23-20020a170907785700b008778f177fbesm9666794ejc.11.2023.01.31.21.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 21:36:20 -0800 (PST)
Message-ID: <0f6fe3bc-6626-9ad4-3eb6-9a603a360329@gmail.com>
Date:   Wed, 1 Feb 2023 07:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
 <d6e797c3-ef06-c89f-e181-45535d23f614@gmail.com> <Y9lwoMIPD134k0dy@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/2] iio: accel: kionix-kx022a: Minor fixes
In-Reply-To: <Y9lwoMIPD134k0dy@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/31/23 21:48, Mehdi Djait wrote:
> Hi Matti,
> 
> On Mon, Jan 30, 2023 at 10:15:51AM +0200, Matti Vaittinen wrote:
>> On 1/29/23 15:37, Mehdi Djait wrote:

> 
>          /*
>          * The only difference would be to store the g_range value in the
>          * driver private struct when the user changes it from sysfs
>          * (in this case I defined an array called kx022a_g_range_table)
>          */
> 
>          data->g_range = kx022a_g_range_table[n];
> 

Ok. Thanks for the clarification. In that case, as I mentioned below:

 >> Do you mean caching the g_range instead of retrieving it from the 
hardware?
 >> I don't know an use-case where reading the range would be 
time-critical -
 >> and even if it was, the regmap should cache the value anyways. (unless
 >> KX022A_REG_CNTL is in volatile range). So no, I don't think caching the
 >> g_range is worth it.

I don't think it makes much difference. The regmap should cache the 
value anyways. So, to be honest, I don't think it's worth the space and 
code - unless the GSEL reg was in volatile range for some reason - and 
even in that case the benefit might not be so big because AFAIR, the 
g-range is not read for every sample.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

