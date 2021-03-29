Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7B34CF6B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhC2LxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhC2Lw6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:52:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D0C061574;
        Mon, 29 Mar 2021 04:52:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so12564515wrc.3;
        Mon, 29 Mar 2021 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rLsjhcNIwCmODv/MBaqanwexjHXK2SK1mKLiMmip+x4=;
        b=obVQCkr8uCkYLUv2yZfq8PuHxS3ElI8SIHyQRK2mmjbLl/TugiURrhBXWJw+5UFo4X
         qI0nOMkSDuhXVZ7doMZd5LSiKTnqoA5gIcywuw9Ke6UjEuevL2XtT5DhpiGaMfO+9OxZ
         HZSJXLF7qf2iv72kc0kxMyTMfam4e6n7dxSqNbzVJwaF4WzVuFHUFKz1k7uSQ9TuIdj7
         dl63qYplwjTtkATlI4Nu0LquEeOrQALCMslTOalYH2hwG0yJyblAk27PDzr3R9m48px8
         pQCfhmN3IJ56MM4ffdEfudrTzuZgmv7+jM9Vd1eJOxvnRk/asB1vc/w5IZunkmcftpRw
         4yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rLsjhcNIwCmODv/MBaqanwexjHXK2SK1mKLiMmip+x4=;
        b=pymkqgen/5WcqfuTMG0UJu06GAkn9CaGkstP5WgkG1CjO1AADENEynBPwy6qYifSbN
         IS3+5yY9B092zIf+QQrBrrqnPuFKpydtYtBum6Q+W2YhlzR79RlBMH9Nt17bnwz3UKPY
         oc/XIRgIp+VWrPPQGzJ6xb4qsqksp9703VXeHsIfFy+aEgzRzSj8T6NrvWdOERZU5lx1
         SfAi2YBv/N5iLFJKUIX1i/HnYFnFXU9ICbZxGEQnAxlrdNRFrzwhQZgNVnWXPlw1KKrD
         KiX+CMdCc4OwaPwOsdM7uTbtTlLkqCertD/GiTdg/iQ2yGn06d2Ldsaqq61GUc4jbDgE
         rtiw==
X-Gm-Message-State: AOAM532EtkxnNMoN1Q2cm9sYAbxNd+NcSn/CPIpUG+VVgtExbATTKH5J
        SzujGsebXIUXNwybM3eEoNw=
X-Google-Smtp-Source: ABdhPJzbEfFbXJ9fbqn8X3nAKteEObCciLIv/SGMQ5u1ubGJRiRxl62orHY58t646W11wQ7rTr7+rw==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr27974972wrd.47.1617018777293;
        Mon, 29 Mar 2021 04:52:57 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id u17sm29691663wrw.51.2021.03.29.04.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:52:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] dt-bindings: timer: Add compatible for Mediatek
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
 <20210319023427.16711-3-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <bf7ad31e-974a-3e0a-12bd-32973c7c3cbd@gmail.com>
Date:   Mon, 29 Mar 2021 13:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319023427.16711-3-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 19/03/2021 03:34, Seiya Wang wrote:
> This commit adds dt-binding documentation of timer for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied to v5.12-next/dts64

Thanks!

> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index 690a9c0966ac..e5c57d6e0186 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -23,6 +23,7 @@ Required properties:
>  	For those SoCs that use SYST
>  	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
>  	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
> +	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
>  	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
>  	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
>  
> 
