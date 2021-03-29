Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB42D34CF7A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhC2LzZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhC2LzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:55:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DAC061574;
        Mon, 29 Mar 2021 04:55:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so8370780wmy.5;
        Mon, 29 Mar 2021 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTGUJTFeIuqkHE7OgJ63VK0q/EGuYFQeHNPktt9KFqo=;
        b=QN35vK/ypSg7ojWLSyNITTgbIp7lU5hj9ii1qUFNLXtobdt6MopjIdyHP28M9+Rffc
         0QyV1rs6l7CwMir6EKdxwwiegfEr5OyxXCaBZjYkx5GuJjZliKYxynDp13LHfw6DDagS
         UVD21vEON7j88LiUfCj8od7SxA+QySey74c9RbkXt7E8GTsIrOKSLgI/zZ1dO85Gz7Wq
         LJtj9zPXDtBbnEGjHUJYXws5JFL5lrmn8Gk8DParf4M5AQKjTOQ5fGxDfoPv0LraDup6
         gLklABKV5Y3HL0FsuHujXQv0D5BhUQyhP+ZaAwBeT++RpwmgiCJ0IeQSXp8ZGUkmyegF
         RNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTGUJTFeIuqkHE7OgJ63VK0q/EGuYFQeHNPktt9KFqo=;
        b=otePqtb4+Tw1ac1D6L3QWMRWhV9VvSHp1s2PuHsbP802eP7RCKZFWLnzfLlHvKoWSN
         kk0L7x9FO80n+MoUlvGS1FbKo8+rib5JehHQiNhn9S5ulsIozrDpXSfw3EA7cYAZsiPB
         ZShf6yCAhAUwd8IaTUa9qpWVz3ThC9jOVoKoSZ4jo8Q/sS7BCd5NlYa+MRr/pNTLYE5i
         e7yix01vXAHqp7V9pAVOY9pc8nwYSDxRsSuuafDFhmL6RzrLzIyjmOhNIvUlhtUuUX0Z
         M92HrVf6dnWxrKKk9C/OxXTyGsEdt1xMfhr3NSiQUo8YIT8kGmFAFsPbxM207mKfR97B
         AtHA==
X-Gm-Message-State: AOAM533uPhH0bRLPZYoafK1vVEiFTvPXaBJqVSniTSDIOoMO361A2KJF
        XQy8HiqdItdPHeT8ITd/VlI=
X-Google-Smtp-Source: ABdhPJwwik1eV8I3tyUxdsEEtBJZ250VJWBh3/7XjHJgtNWDne3LT3xC5YApnDCKW8FGW59G3wBZqg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr24516003wmc.59.1617018903448;
        Mon, 29 Mar 2021 04:55:03 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id f2sm30409723wrq.34.2021.03.29.04.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:55:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] dt-bindings: arm: Add compatible for Mediatek
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
 <20210319023427.16711-8-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <dd425954-cfeb-01d1-0027-17dedfd29dbc@gmail.com>
Date:   Mon, 29 Mar 2021 13:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319023427.16711-8-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 19/03/2021 03:34, Seiya Wang wrote:
> This commit adds dt-binding documentation for the Mediatek MT8195
> reference board.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied to v5.12-next/dts64

Thanks!



> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 93b3bdf6eaeb..a95224fcff9f 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -118,6 +118,10 @@ properties:
>            - enum:
>                - mediatek,mt8183-evb
>            - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-evb
> +          - const: mediatek,mt8195
>        - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
>          items:
>            - enum:
> 
