Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5C349EE8
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 02:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCZBpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 21:45:40 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45918 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZBpe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 21:45:34 -0400
Received: by mail-io1-f45.google.com with SMTP id k8so3849182iop.12;
        Thu, 25 Mar 2021 18:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27tbT4MS/CX8M2DbKhKUDnhJBUGOSfTJ+GBZzWZj5P4=;
        b=tFjTtGi2fy74hO6bn+LjAH2lhdz/JZYCdA2LR4u0JZtWPd4pgAylvoINvhkYYBUytV
         fl9iauG5qnJtiDTN7WHTNS0jTMHjmcuWdiazuyuIPyBf8pR0KQf88WLef2UECyj/+01h
         pXE/4mcERs+WAFLbOMcShSBYUYX0pfGXI23X1skJ6KOWPTnghNC5n0PIqfXKs7dOyY5y
         eeG3PmXpn17LFZe/T2fvjHk4Td/gOyc+pPEuEh7WbIEeckLxSoXpZNjcU7bLfV+jPA1i
         /xrf5o8H7+iyTKoidvlXEa0VLLlPE94XT8yCCpEW2QO2OCftKeeg2C/5DJieSU+WU8uJ
         daSw==
X-Gm-Message-State: AOAM533cekIbYJXBbvezS4RkLJmeDFr8LVu2W9fbRxnF8WRjfD32LSFE
        PY0uSvQUuReLVdz7q5bjFQ==
X-Google-Smtp-Source: ABdhPJy63j3fTYtBj6uDNf6/KdcuR4UeZ7pXuEFPEoBMCmHpBcCcxvdbbnYD9tK7aXReVE3phLEG5Q==
X-Received: by 2002:a02:9042:: with SMTP id y2mr10027352jaf.94.1616723133720;
        Thu, 25 Mar 2021 18:45:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h6sm3433426ild.79.2021.03.25.18.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:45:33 -0700 (PDT)
Received: (nullmailer pid 2152868 invoked by uid 1000);
        Fri, 26 Mar 2021 01:45:29 -0000
Date:   Thu, 25 Mar 2021 19:45:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-watchdog@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: arm: Add compatible for Mediatek
 MT8195
Message-ID: <20210326014529.GA2152657@robh.at.kernel.org>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-8-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-8-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 10:34:25 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation for the Mediatek MT8195
> reference board.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
