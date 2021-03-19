Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5D341F1F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCSONb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhCSONO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 10:13:14 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381E4C061760
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 07:13:14 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id o85so2130021vko.8
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kT7+B2/flieu5ujbkJnPLuQBBNLwKu9lAXheORirHr4=;
        b=U1yMXLigO4H7ah1+jp3sxNQNipWk46ztH98A3rCkQbklXq8Bq3Vs49yDHfqi9yrx5T
         03+sjIWHWjiKuEjfuGvYnjmw1ZBoAjXhzB688boq5L93ygDzDJkDh/TsjT4vo9ZUEGQT
         ZOACxRfEVcNH+O1z+OSCIQJ3waQbv0/wcsvv9Xq3IiHyMB5JW00ni0CL+W5tS05HYnxd
         DMcQeAaCArs5mqu1sgmxhE76BN6zq6aDUR9O2jPGwLgFFfWtuS4bO5eXWKH5/tYjPC3F
         198SNZ6lXRMWfqlp6lKO35cN/CZqkOYit5Rc3naNI3qdCJQjsk82bJcFgX76nHR/yzCI
         pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kT7+B2/flieu5ujbkJnPLuQBBNLwKu9lAXheORirHr4=;
        b=IDKYexvIY+f6lLdINtWkss0KhEXtydzjC8niSqmqtWCOubCAtJQCdJkoLiHwQ62sR6
         35Q2+g1VFzOhScTGJlVO45wZlDIA6P4DRSivpaLZhMu/4b8F8yk62x+882wrZIxgX0cp
         pZZsTqTcCCaSJ8Sx0+lBH7TCTGKAKIc7s/GLcEx+Zpqa5ZUvlVtiDQ5VreQGhd1LFuSe
         dQXC7WrFkFX44+IJK7unht/Virc21o2W4oOnEQ88otuOdfHFn/G3AoRIu341EoDNQMKJ
         aJqeHFkKqodHpjC7jPWrwcOY9N0nsYAC0yUhqbD0WBTgr+rp1Wd5hF+j0KgWQ60PBLVa
         Q9Jw==
X-Gm-Message-State: AOAM532/wM4rdlzCpXMtHG/Vpef8qrvrx2AAf4WtMw3ZRzvSJe/ifa0n
        0FjrKaVMFwoIT5PtAZqjte8WagANVypEGlp0jh3DCQ==
X-Google-Smtp-Source: ABdhPJyrCbfKFwzf3QvB/HbP0vNpYxFsspYHELQ6mbVNuzXPsE5ygCViGVapYNlX1ysNdx57pfIQk/9Uhjv0wFXLckU=
X-Received: by 2002:a1f:b408:: with SMTP id d8mr2905520vkf.8.1616163193433;
 Fri, 19 Mar 2021 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319023427.16711-1-seiya.wang@mediatek.com> <20210319023427.16711-6-seiya.wang@mediatek.com>
In-Reply-To: <20210319023427.16711-6-seiya.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:36 +0100
Message-ID: <CAPDyKFqWdJdF__c_=aqV_bjBNwh+-YY5xMy0_SWK9WJaOafawQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: Add compatible for Mediatek MT8195
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 at 03:36, Seiya Wang <seiya.wang@mediatek.com> wrote:
>
> This commit adds dt-binding documentation of mmc for Mediatek MT8195 SoC
> Platform.
>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 01630b0ecea7..8648d48dbbfd 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -31,6 +31,7 @@ properties:
>            - const: mediatek,mt2701-mmc
>        - items:
>            - const: mediatek,mt8192-mmc
> +          - const: mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
>    clocks:
> --
> 2.14.1
>
