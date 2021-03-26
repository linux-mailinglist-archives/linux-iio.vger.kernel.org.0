Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24531349EF5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 02:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCZBqn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 21:46:43 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:43931 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhCZBqT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 21:46:19 -0400
Received: by mail-il1-f173.google.com with SMTP id d2so3780209ilm.10;
        Thu, 25 Mar 2021 18:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r8oIhicR0M0rWsVThiNvSmTLmYajZwzOVB1v/JAmNUo=;
        b=GY9jqOj5MErUBryAp2O4rMi2sXihkFhRV5lbRhaYhVsef9jQ+VLa5yJjPpOBWywwq3
         Xt8faZ5WwPpPxYugVV2fPY5QNW6ASO0CKtxohpZ3ZdtSFsKoBn6VCQHRgC9NEQB5DA13
         DwQf3xXIYcVR8olqQIebe3HVBmaqPsqB2akzDZenxnjdMOeFIFtI1YMU/gZ4ZPNJUEI3
         vJn8rSw+/jo7EQ6i+IMdddH5JvUimnwYXl0GR0BTh69kygwEsVcJXT+ohwXRf3N68mXG
         mKfVgYNz34SAqsY76bvAl+kRyhAchKZHxnUDptTwHvHCO360Hsttdl6O8GXhojOfbdZ2
         XY3g==
X-Gm-Message-State: AOAM530qn+yn8bqLwSfwFZD5Yp81OwZj2uS/JzeXPws8QqMgZ3wr6z0c
        JAIsB4StK3Jayc9IDWRyTQ==
X-Google-Smtp-Source: ABdhPJwPChqbBJ77wIDn5W+k0ERwri8ICIG3Ysr443SmIFXqsQ/x1s7q28o5ZtNwCs7WuCdCIH0oGw==
X-Received: by 2002:a05:6e02:1143:: with SMTP id o3mr8643517ill.104.1616723178197;
        Thu, 25 Mar 2021 18:46:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f15sm3616031ilj.24.2021.03.25.18.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:46:17 -0700 (PDT)
Received: (nullmailer pid 2154103 invoked by uid 1000);
        Fri, 26 Mar 2021 01:46:13 -0000
Date:   Thu, 25 Mar 2021 19:46:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        srv_heupstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-iio@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mmc@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-serial@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: phy: fix dt_binding_check warning in
 mediatek, ufs-phy.yaml
Message-ID: <20210326014613.GA2153687@robh.at.kernel.org>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-9-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-9-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 10:34:26 +0800, Seiya Wang wrote:
> This commit fixes the warning messages of make dt_binding_check from
> newly added mediatek,mt8195-ufsphy in mediatek,ufs-phy.yaml
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
