Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5094C349EE7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 02:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCZBpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 21:45:40 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:42593 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCZBpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 21:45:06 -0400
Received: by mail-il1-f177.google.com with SMTP id l5so3781550ilv.9;
        Thu, 25 Mar 2021 18:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZsXaMzEzAOeuTtz20TFhfalE//5yBaTZxTM2icf+t8=;
        b=pZNhvGRY8GQ46wD56YRWcEPkPBV0aoNGdNeeeVvD59vNnvGamo7J4duoTZ4cgMmfD0
         KmOZtxMNsd5FokLRhRP/rJAMPYjwAx+zto5I6BDw8aW8iV59SQrMTbKklsZdPieq5G9d
         zrn1DqT/zR7JtrNFuO5R4LATu3XETKBg6v5XbHqYtSr9XQvQHZlRetZuaV3j0N8aFqs/
         uxxLfl0l3vfeW2oi2E5GOgmtaCBM8XtiJCM6hYUvr8EN2iIyKPbWUdOF7LEJcD+AtkD1
         HfI12p2afrioOdtNFpr457lWqYD6DHBJkjjHPa6nTj/ZyOfpX+5Px70aiPNmiwdODFyI
         eZOg==
X-Gm-Message-State: AOAM532y+lf991Q8UghhoohURxd4k5RVok/7261ACSZWcMag+DtQoDDt
        UB1eH9VSx+QBr/mzr1XA4g==
X-Google-Smtp-Source: ABdhPJw2gR2TyVZd11y9iO8iab1634RMShjveSM1GjxFM4JuqXPhKrf2/Z0VPxLDBB7qy4BaghmQ0A==
X-Received: by 2002:a92:ca4b:: with SMTP id q11mr8989243ilo.272.1616723104674;
        Thu, 25 Mar 2021 18:45:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q8sm3443978ilv.55.2021.03.25.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:45:03 -0700 (PDT)
Received: (nullmailer pid 2151969 invoked by uid 1000);
        Fri, 26 Mar 2021 01:44:59 -0000
Date:   Thu, 25 Mar 2021 19:44:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: Add compatible for
 Mediatek MT8195
Message-ID: <20210326014459.GA2146095@robh.at.kernel.org>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-7-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-7-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 10:34:24 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of auxadc for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
