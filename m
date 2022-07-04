Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9341D565061
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiGDJHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiGDJHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 05:07:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03782BE09
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 02:07:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j21so14720389lfe.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BtyIymdH2qSSNBvNEoKc/50n+YaYkErYRhVN3d4+GHk=;
        b=XiM+E5UdwfyHsyHbIllCDzfZVdzGil+LXmUM3o6WF4PkRJ4XqFmVWojD1MoYEM77UY
         8+GhsWQjoigl4ndUWRWWskLeKNbMy9E0wfbPwsNxu0WoSBISOu84MorLmmWNIKgTWfWC
         Qj12RXtMOdfS1+T4b+EPVwW0F4GFOMBWYctm4pNB8bg1eHfe2AaGwUodg+mu7efIXksV
         TNtl7aJRF9CsWzUdAnNF1x2c3v41JPbqU1Ies4ozEErlMu42mw5lQIEqwp2GwAssuDYK
         Cw3KRx93bb5JTFartqor8wS0/vf3qj4RGn/Vtt/gfoVCkPpTOdjeZN4O1NmlZR66TIIo
         LfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BtyIymdH2qSSNBvNEoKc/50n+YaYkErYRhVN3d4+GHk=;
        b=iAIK3KuUTCBpjPh3eOAHdT3b/gIST7Vn5kaKuX/gs/KQ9fJigh/wyGzEfRf/oIvF9F
         xE09vB0EexwkbB+IZsOCE5QyxUsMeOPDa2krTA0wnPqmhsaJMeCYMEf0o0M2DhCLrdz3
         7/ZhLQXwQ254a+pn5Pmao+gWtNlAaD7rVDkqEsNoiw71aGIpyW2GHDiOsY6KZcvI1iVg
         hV/2PE4vbUmoXQ+UlRggAqr7HE2Fhh9eEgY4zw3/4dzBvVDGAHiJl0418U/NK5fkI1L3
         3sbt1UQIvzARXrIR2ANQnhOL2fIfXQ6hgGp9Mi2Ua75owHsIuNlOgefMOCZk8U/dF1TI
         xSpg==
X-Gm-Message-State: AJIora+AuAS4QsJhXp1BS5APXk08Jh8PSR6CBj8Cmcd/HWFu5sDsCM3A
        Rt6EOaVOMKGs3BzQ9+x0WlCc6w==
X-Google-Smtp-Source: AGRyM1tI9Ub9KvPHASQI5b2883dspTVBOFIXRiN1cbb02P3TVGpg8m7UwRb/aJtvqXiUk+O/khToVA==
X-Received: by 2002:a05:6512:2810:b0:47f:a76c:8770 with SMTP id cf16-20020a056512281000b0047fa76c8770mr19891464lfb.116.1656925635286;
        Mon, 04 Jul 2022 02:07:15 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b0047f77cc3287sm5036384lfn.274.2022.07.04.02.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:07:14 -0700 (PDT)
Message-ID: <247e5688-8aff-1c7c-80e4-b39c5f2fae9b@linaro.org>
Date:   Mon, 4 Jul 2022 11:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 06/13] dt-bindings: mfd: Add Mediatek MT6370
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-7-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704053901.728-7-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/07/2022 07:38, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 
> v4
> - Roll back all "$ref: " to v2 patch style (using
>   "/schemas/...")
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
>  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
>  2 files changed, 298 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> 

Looks ok. This depends on previous DT bindings patches, so all of them
should go through one tree or with some pull requests (but that would be
a lot). You should mention it in cover letter to get the acks from
subsystem maintainers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
