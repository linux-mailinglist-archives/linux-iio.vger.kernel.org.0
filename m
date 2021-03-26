Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42623349EDD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 02:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCZBlU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 21:41:20 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36724 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZBlD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 21:41:03 -0400
Received: by mail-io1-f49.google.com with SMTP id f19so3889219ion.3;
        Thu, 25 Mar 2021 18:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMo2wYI5WIZFOKgvRIYEXEE0SHkOrndB8fO1GfnbYPs=;
        b=jhN8QIao4BSBY+fnCebwy8l4crwHUkxTBw5PIm/uBIzFU4vDe0g/98suK9vVjSyELl
         /+taf5+wTqbEMJxXHZr7VO6paElbqMxEoevDm5FBCCOjQRg0i2qPfP88Hf9/Ppg0h/mN
         EW0cVfg5DtV0Xv1iUH6+ZI2gMrxgxEP014N817e0NZiWDF4w49oozBsxaY/rlVwnyMzj
         f6uJBhvPT8YY/KIKL50sC63lcl5MVDOCE2+WHVCZBsM7H7zfKsHzjRgE2YslJcRyaFa5
         5KufXKZIwuZ6/R7yMfNXX/4yOoNMr6V3utKIqG3tLIJnunO6sRfn9gcbFZYCmyQOzAQg
         gSPw==
X-Gm-Message-State: AOAM531oqxDjZwBXDSTKdfSFCxKhki29aNjnA8gslAu7UL7Pk2AOk1N2
        Rak1dD55uduIsycYc2r80Q==
X-Google-Smtp-Source: ABdhPJz5FVZ++NTUJD7Wn6RDi6sP7fKXypp+u+gjUuZiO53JxQ/M0L3EFD4Zq355yqI1vZBjS3n/+Q==
X-Received: by 2002:a6b:4109:: with SMTP id n9mr8231738ioa.43.1616722861120;
        Thu, 25 Mar 2021 18:41:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y15sm3359412ilv.70.2021.03.25.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:41:00 -0700 (PDT)
Received: (nullmailer pid 2145304 invoked by uid 1000);
        Fri, 26 Mar 2021 01:40:45 -0000
Date:   Thu, 25 Mar 2021 19:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-watchdog@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vinod Koul <vkoul@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: timer: Add compatible for Mediatek
 MT8195
Message-ID: <20210326014045.GB2144901@robh.at.kernel.org>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-3-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-3-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 10:34:20 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of timer for Mediatek MT8195 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
