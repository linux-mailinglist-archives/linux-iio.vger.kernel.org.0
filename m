Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD3349ED4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 02:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZBks (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 21:40:48 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:38750 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCZBkn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 21:40:43 -0400
Received: by mail-io1-f44.google.com with SMTP id e8so3873110iok.5;
        Thu, 25 Mar 2021 18:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/nZtzn3g/vwJOpDb+ADfWdP64r2tBwJPkLaskVNDJhA=;
        b=LA3SyioJcM1HOiZXSUBMiQmXZwUvWTzEyvqVg7tR0oFEwrV+cogewvPn8nxjslYrLD
         YR5550GCKCDEO/7b3+kFSuSxIF1L4nToxl5R3L9ZZvBIIc+Uc91O8IrR+ove+3JNjzB0
         604E5lG730MoQP/veTRPFZYYuhLtsn/ruYo9AAhX26gv7ZNS7A9x+qZhAA0nEIrUJ7Z9
         cru+6NmLeueCy4Rw+O60+3qPX/iUJDa32sooiV3R7RacPwOnrvhfrPuz8c8xcSFffMgk
         J5fw9EBstm2dguskTJNH/Y0yVZuxOgAFB555xfdCe5eMpasLiBA/QmwA6jEHuxVOUHPb
         3b1g==
X-Gm-Message-State: AOAM533L/IK+3xQQ8VxGE31HtvoPfyBi7nSCzmGlZDm8MtWNHdjReCp6
        roP4uKa7rlTZj/F+5i0bxQ==
X-Google-Smtp-Source: ABdhPJxT6+UsV+NLqh2ul/vKOfBtJQth8BzvthJhxtpfpmhgBPfXNzJsAHGTteI+WblAGq7BNiJNcQ==
X-Received: by 2002:a5d:818c:: with SMTP id u12mr8546949ion.81.1616722841515;
        Thu, 25 Mar 2021 18:40:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h2sm3394649ioj.30.2021.03.25.18.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:40:40 -0700 (PDT)
Received: (nullmailer pid 2145084 invoked by uid 1000);
        Fri, 26 Mar 2021 01:40:37 -0000
Date:   Thu, 25 Mar 2021 19:40:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-watchdog@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-serial@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: watchdog: Add compatible for
 Mediatek MT8195
Message-ID: <20210326014037.GA2144901@robh.at.kernel.org>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-5-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-5-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 10:34:22 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of watchdog for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
