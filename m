Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E783C355153
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbhDFK4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDFK4b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 06:56:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5674C06174A;
        Tue,  6 Apr 2021 03:56:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t140so10047804pgb.13;
        Tue, 06 Apr 2021 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HQT74NVA73GGCdAvd6/1h7+SlTTe9RmIrgBWclsq6k8=;
        b=oQu/WXmQyuX44ohLqifUNcGDI81yV2/0YSelnio0a819gMpS/5aJVrckQkKHXWooFX
         ZgvnEp9I6qG9kvZ8AWTfgiPFA6PPdFkEaUkKrLHYuivbQs5w8k1O0Jqgyys+Hxtc4RKK
         tcJE+Y2QH3n3dDZdlMH0LlxaWeE18lg8pLAOiKlVGvb8WGzx8UdWASp4T2dnVS9bgufv
         xI14ejB0mrfBwySjM97Zvb6BOewCCRKA320H4oeIaUGCsklWbIOH9yYvCTedcRq0jw2i
         Pkb6vbQ4ttfKk/Vm676oWazkf1KRR50sGV8vr201pn5wNLeoC9tX4NfcAswhAEVJLVdj
         nUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQT74NVA73GGCdAvd6/1h7+SlTTe9RmIrgBWclsq6k8=;
        b=F8HOxCqjmsDN4XZmr1/goPATwh/nTuY6XptPQ8yTBtf79+QI7KHsYCXy6wAbdya700
         Omh+OXBp5ZNV0zX9jMebeBeQB+64Zl172HqY43wGsk8ox7uogZjuOKtWRDvy2D6oPKsM
         zKqbfkL/OfK2GcadqIa9AMw+RRlru5tmM1z4gAyr096Ah+218NfLHQLeqXxF84UBHdvd
         JNHHEJsGHO4/12sGM14yKHCvxUH7rjUlZ9oDwZ9rP0vycO9gLR7ftSOobpweanZ/KS4f
         juxGi33AQjBGJozpJK+Mxg2gBwb4wGtLQpxvR98JVwEWFHxf5Wy9A+LvsCpdcpYyOsmo
         7mLQ==
X-Gm-Message-State: AOAM533lhdXs8v/hs94SMl4Dw5h4nodrJMhfaZUbDsHPylhCa4+/03hx
        CxCjZHT6h9q7YMDq7S/6+L9tKz9NTcx1tA==
X-Google-Smtp-Source: ABdhPJysFojs7JX3hmvyUz5j1+7J5Z7YRyi0ZSnMOYLcJ2bsm0VfP6FBMz+dTpF3ob+Xk1uWQIx/pA==
X-Received: by 2002:a62:ce4e:0:b029:225:bcc4:4ee with SMTP id y75-20020a62ce4e0000b0290225bcc404eemr26569506pfg.13.1617706582373;
        Tue, 06 Apr 2021 03:56:22 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id r1sm20326351pfh.153.2021.04.06.03.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:56:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] dt-bindings: watchdog: Add compatible for Mediatek
 MT8195
To:     Rob Herring <robh@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-watchdog@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-serial@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-5-seiya.wang@mediatek.com>
 <20210326014037.GA2144901@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <32dd4d40-2dd3-fc58-ae2b-642b877085b4@gmail.com>
Date:   Tue, 6 Apr 2021 12:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326014037.GA2144901@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wim,

On 26/03/2021 02:40, Rob Herring wrote:
> On Fri, 19 Mar 2021 10:34:22 +0800, Seiya Wang wrote:
>> This commit adds dt-binding documentation of watchdog for Mediatek MT8195 SoC
>> Platform.
>>
>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

I suppose you will take this patch through your tree. If you want me to take it
through the MediaTek SoC tree, please let me know.

Regards,
Matthias
