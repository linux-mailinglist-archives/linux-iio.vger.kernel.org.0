Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38A7BFBB0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Oct 2023 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJJMpD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Oct 2023 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjJJMo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 08:44:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EBB4
        for <linux-iio@vger.kernel.org>; Tue, 10 Oct 2023 05:44:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a645e54806so944425266b.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Oct 2023 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696941893; x=1697546693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=199RxfkmlH6n0PnGVzkV097mb/3xpEnD5+hjR+TaTtE=;
        b=JmH7D69WsnkCkebbS1hjyIq1DuX2G87kMsDENdIn42KMUVTSXMvJgUyNvmnQfFfAnm
         sAKNeFr2KbGhzZAUM3d2FUiGhmGzIi4g10huT6y77SiM7YeAC3dRh/gWHegXxVzDspHN
         pKg6bzLEJdhKasD1fiFht1TAtuU1kDNtjeIOqN6K9LpICrjKH/O18IVJm0IKsCbiCqwZ
         /r8jwbfB5ky21HoGdBvMIl0HvKZ3H8X6k9MzMiaJhNOcYiQObCU9qsa6vM5XI6ByFQZ8
         B/e+VufkCyU3uhjfAxez62kDh32czXg17bDFFoik6Gge8EREhmxGwXpXmcFySg86QTUW
         Ah7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941893; x=1697546693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=199RxfkmlH6n0PnGVzkV097mb/3xpEnD5+hjR+TaTtE=;
        b=guiuYi2Ttk17bAI04jJeQuzv79VWuPy5zXTycZx4WsHJgXrnRrr76EBkcOwwR6D8PW
         vkfVC+aUoJTlyMD7mP8kL7RH4ATKJfNDWAgeIu4pOfqMzLrXaMJryFnRAkSvQg1odafC
         K2MXS21t2dEZ0dQTIoFlXw6O7BrTmliFOJ5e9Gzuh5yCCSnEa6VQXiiIQbJiJkkGeGwn
         RK1Nu003gjxrbhDasoSt5Fi1ZFVPinsHpwy9FU6p5pHwByD3xrgpDIc8N5gHjfsiLoTB
         fxsaiPh0J46sGcFxc+xYr6PPrfambcBoM9bG4RttN2R/jIsYc5rjER1XIy4MKPL1Jj/h
         aVQg==
X-Gm-Message-State: AOJu0YzsmJ8p0eNS6Vo5rIKz0CdiCuOI9Iq1JUfI+FBAWzGydWxm3jBp
        LM8/r+mI+BSY/SD/x771w/keNQ==
X-Google-Smtp-Source: AGHT+IEsJzobcPu8rJ40cb7SMlsIt72AvoIPVaKzAJWjiofu8QAGko17hHTmiHgPwC4WWEHIk++zTA==
X-Received: by 2002:a17:906:530b:b0:9b2:b975:8327 with SMTP id h11-20020a170906530b00b009b2b9758327mr17819526ejo.65.1696941892862;
        Tue, 10 Oct 2023 05:44:52 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id qq25-20020a17090720d900b00977cad140a8sm8410416ejb.218.2023.10.10.05.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:44:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:44:51 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        ruanjinjie@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH] iio: adc: mt6577_auxadc: Fix kernel panic on suspend
Message-ID: <20231010124451.iopfw2gnc54dap6f@blmsp>
References: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 10, 2023 at 02:19:40PM +0200, AngeloGioacchino Del Regno wrote:
> Commit a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
> simplified the driver with devm hooks, but wrongly states that the
> platform_set_drvdata(), platform_get_drvdata() are unused after the
> simplification: the driver data is infact used in .suspend() and
> .resume() PM callbacks, currently producing a kernel panic.
> 
> Reintroduce the call to platform_set_drvdata() in the probe function
> 
> Fixes: a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

> ---
>  drivers/iio/adc/mt6577_auxadc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 370b84c2d0ba..3343b54e8e44 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -293,6 +293,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>  			      MT6577_AUXADC_PDN_EN, 0);
>  	mdelay(MT6577_AUXADC_POWER_READY_MS);
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
>  	if (ret)
> -- 
> 2.42.0
> 
