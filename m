Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58187355144
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 12:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhDFKxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDFKxV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 06:53:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB65C06174A;
        Tue,  6 Apr 2021 03:53:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i18so10254048wrm.5;
        Tue, 06 Apr 2021 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UW4SBvk4siFv9zFuBrGL9HNGyyN/dS4WBxMX1QWTZM8=;
        b=RqwwVIngnJInbW616xuEiRHUTETVRR42D4lHIX03HdrtnCcD1V8G5J302yq0IzkTAQ
         aAsAeCOQ1XZNfbbtNsxHvfJ0QH1Lla/valtxl62ZjozBrnHRzC5NOyItOuyB4djHff4u
         mfBcnWNpe97n1JBA5p1W0pSY+0To407VG5rUC5MPA3ZmLtzQ8T4+uGJWGD3nRsvxW9R2
         vaj71h2BZZuAid7IhY00fiNk0xPhaGgC0lBHjQRFq9hG8eNU4+cPWRcQ0ThDzGIxaoeX
         X7d1uJRz+t7Rl+L/pSamR4V7udhSn0Mgo1ZIuB/EFIvh/0qw39NRO8Qk0YujTCTvByrB
         PMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UW4SBvk4siFv9zFuBrGL9HNGyyN/dS4WBxMX1QWTZM8=;
        b=JKmKpRFboQwCCtJ31o0ff3YyZ0pLrHOnVihc912w+2XkWkMHGuNnNx7oA9t2zPLaDk
         SGZeXXw21JSglijiIBOG27+eD/nqZpwM+lvFUD44iyEEIsFE8+FpTk2mrCQiAp/urrNw
         5ZXhJZ5SyMwh/cdPut/x2oVJtRnfRuZ8ZFh6xMzyQKgAAoFgAkKPC7XqtggoHHtYj89B
         cQHkyLqY1bi25Ovlqsi746h4tFTEb8ktARcy3XqAIXRDqo0ceMlrwKhKCT2T9pkZ254W
         siFDpNBLjW4zw7EbHEexJ4qDUCKPgWKnJS4BCH1xcn2zHELarQRBXa9ofD7YPY4O/lqD
         R7Ig==
X-Gm-Message-State: AOAM532P4QIugzTAAQ6TL/BBCLyvMaO/7AcL9bXkRByGknURi+OOS3fy
        adCqhxUJeAhoqycbcISiSsk=
X-Google-Smtp-Source: ABdhPJyEcWxQjakzL4UBY/hSPfKVA9z+I4/Fts1uNiYoCieQ/sPpv7fJrL0XRGTcNHoTn2bhWLT6MA==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr33792030wrc.138.1617706392307;
        Tue, 06 Apr 2021 03:53:12 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c131sm2416442wma.37.2021.04.06.03.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:53:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] dt-bindings: timer: Add compatible for Mediatek
 MT8195
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <11bf6761-8902-bfa5-8577-d397846e7638@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <251f6d99-a7f6-ddbe-096a-95998b86dbed@gmail.com>
Date:   Tue, 6 Apr 2021 12:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <11bf6761-8902-bfa5-8577-d397846e7638@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Daniel,

On 04/04/2021 22:33, Daniel Lezcano wrote:
> On 29/03/2021 13:52, Matthias Brugger wrote:
>>
>>
>> On 19/03/2021 03:34, Seiya Wang wrote:
>>> This commit adds dt-binding documentation of timer for Mediatek MT8195 SoC
>>> Platform.
>>>
>>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
>>
>> Applied to v5.12-next/dts64
> 
> Usually bindings go through the subsystem maintainer.
> 

Yes I know, although not all maintainers are taking them. I'll coordinate with
you the next time, sorry for any inconvenience caused by this.

Regards,
Matthias
