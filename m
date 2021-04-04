Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8643539C1
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhDDUdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhDDUdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Apr 2021 16:33:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD2C061793
        for <linux-iio@vger.kernel.org>; Sun,  4 Apr 2021 13:33:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i18so5810355wrm.5
        for <linux-iio@vger.kernel.org>; Sun, 04 Apr 2021 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLAy95bvS1zAnYuhC/w4xxxlm+O0tzNR1N2BJpqbw5w=;
        b=Uj0Y5h5dAclSEpTTchKZoN6d6/X2/jxuIIdiY2TiTyk3Va6KgXWEIR7nXrbx2G6DmG
         DEj8NTV0WHUfrymtdaelg8IdCSbFubY9BkAoUgH6qQf8EqAg7oNdPZikt1hBXz6v20zs
         A8AaPWXWp0Z2jemWr2KvX3VEPPGU3IlyIZPwCyiC+SenicBH6/PCmHtanTK6GQ1U+Ifg
         VY2SBWvWpq0G2yymbRGsBY5fsQ3VQ4aGS/FzsLk9krR6A4W7hb8uudpCoMiP1AUhW51x
         KAc2oi6Fi2BSvj3YthT1WKevVUyAKnRg3u5L4ySofPzK4gqEB2ss/pH/Whz46Pfeo62Z
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLAy95bvS1zAnYuhC/w4xxxlm+O0tzNR1N2BJpqbw5w=;
        b=UXRCmBg0RVtj46YCnKHCqevCLJcFSTdl0KbtZW5gMReaBvM/hp9KxTpLYA/j1RDmD7
         N1n7RE5RhjprRmJbj64t2EPwyw8aafseIlCbsdBygJ522qwNzOJYGkFoQBUrOa4hpT8g
         o4dSq5kJmMr4SNIDj3Oh2RHXgGe7c6XV2ur0e+ib4cVuHli4PzBz5LqJWWiMSVaZ6yUe
         oBhn1d4RIlyKP6cNyfwGqFZSMl/agAtoY7memoTwvSMMeOH+KCelNnFSqd3V+N9Vo3CH
         MY7C/7DWvcKoE2skVNyyjbjVjdiFlgYZARRmsXP8XxxsM7CNYSpBMV1mXiwQMre1IWqA
         EBnA==
X-Gm-Message-State: AOAM530NwsjuIZgUEZNzQP4O+Q0BW4s01O4xyYAjnLduR3t6nt/LJx1q
        pkGrHS2mgJ6c0DUuWD3yp3XLkmT7lzJhdQ==
X-Google-Smtp-Source: ABdhPJyhT6Ya2IgUD2RMKPgOE6BwHgGaUQpbUoSsELec3O9UxvF/KjbQKc6zYs03mvxBXK/bekFFsg==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr8456271wrx.386.1617568410016;
        Sun, 04 Apr 2021 13:33:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id u19sm8383785wml.28.2021.04.04.13.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:33:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] dt-bindings: timer: Add compatible for Mediatek
 MT8195
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org, srv_heupstream@mediatek.com
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-3-seiya.wang@mediatek.com>
 <bf7ad31e-974a-3e0a-12bd-32973c7c3cbd@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11bf6761-8902-bfa5-8577-d397846e7638@linaro.org>
Date:   Sun, 4 Apr 2021 22:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf7ad31e-974a-3e0a-12bd-32973c7c3cbd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 29/03/2021 13:52, Matthias Brugger wrote:
> 
> 
> On 19/03/2021 03:34, Seiya Wang wrote:
>> This commit adds dt-binding documentation of timer for Mediatek MT8195 SoC
>> Platform.
>>
>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> 
> Applied to v5.12-next/dts64

Usually bindings go through the subsystem maintainer.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
