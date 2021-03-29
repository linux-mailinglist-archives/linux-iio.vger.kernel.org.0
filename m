Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99334CF74
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhC2LxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhC2LxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:53:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878EAC061574;
        Mon, 29 Mar 2021 04:53:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 12so6453364wmf.5;
        Mon, 29 Mar 2021 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wQLkbOswuI+BpoLUVhG6EjT/ZfQAs/+vgKlOUr1dkh8=;
        b=kB8a7321/zav80c5lhd8wZGVmThE+nFkEER4zryYbkFuKOXBXQMvHs4iLXBJ6VXzXT
         ij3ks0AmPIQGyWUzO91Xlq2I5ber8JoTGXEapHt3DqUNEaAZT/w9E9SKUT4sVuoP+Gif
         nXhD51DjjmeMBwVPWmSStADEi596U66Xlu1FDbr9vY/PVowc53F/TkWM6r1/WQcDLDq6
         uExvPnbjC/m+TXuBx47elnEOfTA8R8tMjnI2llRyO6GK+/M/ibpechVcd+EcQVXmQD6H
         3O1L6YweNFGsRn1VUTMi/hfEwDYMaBDFFJ+iMFOPU4693G2c7YplKtHyMk2ddfG8akaq
         BeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQLkbOswuI+BpoLUVhG6EjT/ZfQAs/+vgKlOUr1dkh8=;
        b=cqerFq0uUW/iJ/JzRzxBvVmlkR7pGfZXVZ3hOEPvopNUmR5xFsP5Wd9JE3wYJm2J3y
         jiX7Xd3w7F+N+bmbLul/wmWzDRrMBsuPrYUd6lnf1q2PFixQ9dv3odg7dGfB5wWifzZQ
         dOQDNeuJ6SUFoJIXXDWVpE8an4nJNFbUPgGs3th6YCoyCrLF3Gjb8+etgDoLC647B9mX
         ficYb1AYZLFpa0wAoC+rl1M2OP3Q3ByuX6fsDS52Owf3k+4pClytDJhUjSuHp3QyA7kj
         kj7ijqYBBbAXhKpU/t8yDLbI4Jd/5osfIYZuu1x16UzAojM+WeBEZIxMbLySIjFRwr2p
         9/Zg==
X-Gm-Message-State: AOAM5320TQcckd+40cybFJ8RgWvNxZ8+OUXbpBhwMMNUp5vE5qCkl9Sj
        UmPUDjmNk3JyZjjEPU7qf9o=
X-Google-Smtp-Source: ABdhPJw0EXyW8g/N+HbtdIOdlmlhALM9J0chb1Wv/F56E/RlCvHktkk4fZbvbFKh72p7d6sbBzHefA==
X-Received: by 2002:a1c:e383:: with SMTP id a125mr24553877wmh.125.1617018790275;
        Mon, 29 Mar 2021 04:53:10 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id g15sm22721058wmq.31.2021.03.29.04.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:53:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] dt-bindings: serial: Add compatible for Mediatek
 MT8195
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <20210319023427.16711-4-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <96b1e804-fc1c-d343-2308-f96c95d82e81@gmail.com>
Date:   Mon, 29 Mar 2021 13:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319023427.16711-4-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 19/03/2021 03:34, Seiya Wang wrote:
> This commit adds dt-binding documentation of uart for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied to v5.12-next/dts64

Thanks!


> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 647b5aee86f3..64c4fb59acd1 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -20,6 +20,7 @@ Required properties:
>    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
>    * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
>    * "mediatek,mt8192-uart", "mediatek,mt6577-uart" for MT8192 compatible UARTS
> +  * "mediatek,mt8195-uart", "mediatek,mt6577-uart" for MT8195 compatible UARTS
>    * "mediatek,mt8516-uart" for MT8516 compatible UARTS
>    * "mediatek,mt6577-uart" for MT6577 and all of the above
>  
> 
