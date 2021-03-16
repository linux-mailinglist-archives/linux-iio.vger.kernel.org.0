Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341F33E02A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 22:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCPVQS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 17:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhCPVPr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 17:15:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBCC06174A;
        Tue, 16 Mar 2021 14:15:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p24so9284248ota.11;
        Tue, 16 Mar 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yor1EiHWBTylh9kpWP/wCw+xZkPtpXh/+Ths3TbYe0w=;
        b=FHM728QhNdZyvNZnbLRwhMr7POs7HeQb93i3aK0NTjbEX0TCRXWXK+IqWNF5miwyj1
         bcjH00mGyQ+dmGW7HrZOByZv0XDKLsK9gF2fV+6Ds2ef1uQ015/RVugX8UyqARMpNkuT
         481x4m8K8+wGUjDl/aZcOU67x2qh3biB4O3MwxvxySiQrTYE0Cjvnb9arnosXi1rWfvl
         HJZritG/sbhEsBCdbFb2lSWOljRPCkLq1tXYwzfgRO3rPglkBjwfSMDmLAtXxIXrrOuD
         HZ8kBN2rJr/i2EMRZ5WU/TSik1ttHnZF4Cvzl6qLtq1pqY2GHNLGiZHtt9IrL8U9s6Cy
         hXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yor1EiHWBTylh9kpWP/wCw+xZkPtpXh/+Ths3TbYe0w=;
        b=n03d5JERUBS/EreMYoDb8OdjvIGsnFMgA6VbemTyFHWfgQt8AQhcTt9WsOyS6jVDn8
         pp0tlPg5bf45UKDGUzxgcXvLp/3ykQ1+/rOuDwTTZXV+LhnqyWvI4gCvRrjTrY2fGy8j
         jF/ecDCY9V0SkTgZdHPA9Q0CMxiMdpuxNYc0BZ08ATvffX6TyGM/eerNeO+uw4R0BpSQ
         fJQDb20QTLUFdQ8FHW+4nB4G1YOJlfrDxTdgK/h0ASkno/0VYdCedbBxJ/zbPxCVifpl
         YM40sqiZxnMg0GG3+k370G9Hk0tYHBmgztKptheEoCG+MtgqsoBlP5vd5y58LPCSB2m7
         zU7Q==
X-Gm-Message-State: AOAM530pjYy+fk3M3KIpWFEaoGrSslF7090vTrX7pq3O1xkbdjKvaw7k
        iFpvtVd82RRIapBh2gOu9jc=
X-Google-Smtp-Source: ABdhPJz+tI/5qUoyqoIXj+lrmspTrR6p+9F7dSCgDDDieF1KKvij53ZFQt/vbOIgPzPDzCZKyrjFFg==
X-Received: by 2002:a9d:7545:: with SMTP id b5mr579421otl.223.1615929345829;
        Tue, 16 Mar 2021 14:15:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o197sm8075424ooo.44.2021.03.16.14.15.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Mar 2021 14:15:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Mar 2021 14:15:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 03/10] dt-bindings: watchdog: Add compatible for Mediatek
 MT8195
Message-ID: <20210316211544.GE60156@roeck-us.net>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
 <20210316111443.3332-4-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316111443.3332-4-seiya.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 16, 2021 at 07:14:36PM +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of watchdog for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index e36ba60de829..a658a0b92b9a 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -13,6 +13,7 @@ Required properties:
>  	"mediatek,mt8183-wdt": for MT8183
>  	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>  	"mediatek,mt8192-wdt": for MT8192
> +	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
>  
>  - reg : Specifies base physical address and size of the registers.
>  
> -- 
> 2.14.1
> 
