Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37158D930
	for <lists+linux-iio@lfdr.de>; Tue,  9 Aug 2022 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiHINOX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbiHINOW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 09:14:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A019C39
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 06:14:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1665025wmb.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Aug 2022 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YbYq10AH7DFyPthSKrztZodwwushB5t/2Y6IpnigFO4=;
        b=Z7YPedDXnLSgBPd9OMsLK57MpNaQ+Vcno0m+BuDTk72qpO7Aul44JeaGBXTzylLRf6
         nLlLx0AAopKc9yoMFkj+Q54hadriFobDH/c4+X0sfC9AHuazANM0RuLRgl7aIbp7cuqZ
         GuqgXlEc4WGquTmSK1cBzJuaCX2BX2TNLtrn0hY9FZo6tj0eSfsrMRlv0hloKxBdqAxe
         HzL7oWPVQvc9jYePBqrd3jAmn1hhsql6nZA98xDcQZHIrlEoh2Q1hNjtZQezpUCmpo7M
         blu04r+nOiSHk4MsGO4DyfiRnWD0AV/92wFDYDkXqtnn2T/ooJhtO/5AZzhil2k4tdEF
         DqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YbYq10AH7DFyPthSKrztZodwwushB5t/2Y6IpnigFO4=;
        b=5tIH2xrwSg6J+wwTQgiciarSrRcnNObrh9MjSoNfxg+iyHyajXE8s3YaQRfbB8emok
         SIUMuhIX4Bemw6jO2Xdq+wGurrwj7Uj3/7UkEF4GflVWb+MhkmXLJ6lGCug15VwMqYse
         bDFQd+nDPbW1jqE3EZfsX3D7deqs1WBVYzZLWNTW/fHi7efbbu/1T9hXoVHXgUzotIyS
         62FckmuygHZNx2WUzVVrSsZkn/T8PPef7QqoGDUn0EILltB7ab6dzLa2IBhR2QYfq6MK
         IxFwKPcyFM9LXTkqdnA1BfwEhC/lUBvD3o1NHoSKn3snHUS4oZwIJRMZraUCgIEAZjij
         +/QA==
X-Gm-Message-State: ACgBeo3fg816ekcflhZImNhptQcrRQ6zW1CZTpgr8AMtHGKs0/fXLsPW
        YD/UO0xhd2jBtAB/kttwtlt2nA==
X-Google-Smtp-Source: AA6agR4/lo60i+WLJVLsgEtDWzhjrmVdxnP64JGuV05zhH+S6LHtffAoI85nP9uDE8F/o6OlDzl8sg==
X-Received: by 2002:a7b:c848:0:b0:3a5:41f6:4d37 with SMTP id c8-20020a7bc848000000b003a541f64d37mr5721352wml.23.1660050857317;
        Tue, 09 Aug 2022 06:14:17 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003a1980d55c4sm22561795wmq.47.2022.08.09.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:14:16 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:14:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v7 06/13] dt-bindings: mfd: Add MediaTek MT6370
Message-ID: <YvJdpq0MWNPQZw5c@google.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
 <20220805070610.3516-7-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805070610.3516-7-peterwu.pub@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 05 Aug 2022, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add MediaTek MT6370 binding documentation.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
>  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
>  2 files changed, 298 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
